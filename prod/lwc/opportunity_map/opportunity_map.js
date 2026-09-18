import { LightningElement, api, track } from 'lwc';
import leaflets from '@salesforce/resourceUrl/ubd_leaflets_zip';
import { loadStyle, loadScript } from 'lightning/platformResourceLoader';
import switzerlandBorders from '@salesforce/resourceUrl/switzerlandGeoJson';
import opportunitiesMapCss from '@salesforce/resourceUrl/opportunities_map';
import red from '@salesforce/resourceUrl/red';
import orange from '@salesforce/resourceUrl/orange';
import green from '@salesforce/resourceUrl/green';
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class UbdMap extends LightningElement {
    @api recordId
    @api opportunities
    _selectedAccount
    _selectedStage
    _selectedDate
    _selectedTerritory
    @track markerGroup
    opportunitiesMap

    @api
    get selectedAccount() {
        return this._selectedAccount
    }

    set selectedAccount(accountId) {
        this._selectedAccount = accountId
        if (this.opportunitiesMap) {
            this.clearMarkers()
            this.addMarkers()
        }
    }

    @api
    get selectedStage() {
        return this._selectedStage
    }

    set selectedStage(stageName) {
        this._selectedStage = stageName
        if (this.opportunitiesMap) {
            this.clearMarkers()
            this.addMarkers()
        }
    }
    
    @api
    get selectedDate() {
        return this._selectedDate
    }

    set selectedDate(date) {
        this._selectedDate = date
        if (this.opportunitiesMap) {
            this.clearMarkers()
            this.addMarkers()
        }
    }

    @api
    get selectedTerritory() {
        return this._selectedTerritory
    }

    set selectedTerritory(territory) {
        this._selectedTerritory = territory
        if (this.opportunitiesMap) {
            this.clearMarkers()
            this.addMarkers()
        }
    }

    stageNameIcons = {
        'identification': orange,
        'à statuer': orange,
        'en négociation': orange,
        'repondue': orange,
        'Annonce préalable': orange,
        'candidature retenue': orange,
        'en cours': orange,
        'répondue': orange,

        'non répondue': red,
        'abandonnée': red,
        'perdue.': red,
        'infructueuses': red,
        'Sans suite': red,
        'candidature non retenue': red,

        'gagnée': green,
        'Travaux': green,

        'default': red
    }

    async connectedCallback() {
        try {
            await Promise.all([
                loadStyle(this, leaflets + '/leaflet.css'),
                loadScript(this, leaflets + '/leaflet.js'),
                fetch(switzerlandBorders),
                loadStyle(this, opportunitiesMapCss)
            ])
            .then(([,,geoJsonResponse]) => {
                return geoJsonResponse.json()
            })
            .then((data) => {
                this.switzerlandBordersData = data;
                this.initializeMap(data);
            })
        } catch {
            const evt = new ShowToastEvent({
                title: 'Error',
                message: 'Erreur lors du chargement des données',
                variant: 'error',
              });
            this.dispatchEvent(evt);
        }
    }

    async initializeMap(data)  {
        const anchor = this.template.querySelector('div')
        try {
            if (this.recordId) {
                const { latitude__c, longitude__c } = this.opportunities[0]
                this.opportunitiesMap = L.map(anchor).setView([parseFloat(latitude__c), parseFloat(longitude__c)], 16);
            } else {
                this.opportunitiesMap = L.map(anchor).setView([46.8, 8.2], 8);
            }

            L.tileLayer(
                'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                {
                    accessToken: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
                }
            ).addTo(this.opportunitiesMap);
            L.geoJSON(data, {
                style: () => ({
                    color: 'firebrick',
                    weight: 2,
                    fillColor: 'transparent',
                    fillOpacity: 0,
                })
            }).addTo(this.opportunitiesMap);
            this.addMarkers()
        } catch {
            const evt = new ShowToastEvent({
                title: 'Error',
                message: 'Erreur lors du chargement de la carte',
                variant: 'error',
              });
            this.dispatchEvent(evt);
        }            
    }

    filterOpportunities() {
        if (!this.selectedAccount && !this.selectedStage && !this.selectedDate && !this.selectedTerritory) {
            return this.opportunities
        }

        return this.opportunities.filter((opportunity) => {
            const matchesAccount = !this.selectedAccount || opportunity.Account.Id === this._selectedAccount
            const matchesStage = !this.selectedStage || opportunity.StageName === this._selectedStage
            const matchesDate = !this.selectedDate || new Date(opportunity.CreatedDate).getUTCFullYear().toString() === this.selectedDate
            const matchesTerritory = !this.selectedTerritory || opportunity.Territory2?.Name === this.selectedTerritory

            return matchesAccount && matchesStage && matchesDate && matchesTerritory
        })
    }

    clearMarkers() {
        this.markerGroup.clearLayers();
    }

    addMarkers() {
        const OpportunityIcon = L.Icon.extend({
            options: {
                iconSize: [38, 45],
                shadowSize: [50, 64],
                iconAnchor: [19, 49],
                shadowAnchor: [4, 62],
                popupAnchor: [0, -45] 
            }
        })

        this.markerGroup = L.layerGroup().addTo(this.opportunitiesMap);

        this.filterOpportunities()
            .forEach((opportunity) => {
                const { StageName, latitude__c, longitude__c } = opportunity;
                const customPopup = this.buildPopUp(opportunity);

                const customOptions = {
                    className: 'custom-popup',
                };

                const icon = new OpportunityIcon({
                    iconUrl: this.stageNameIcons[StageName] || this.stageNameIcons['default']
                });

                const marker = L.marker([
                    parseFloat(latitude__c),
                    parseFloat(longitude__c)
                ], { icon });

                marker.on('click', (e) => this.handlePopupDisplay(e, marker, customPopup, customOptions));
                marker.on('mousedown', (e) => {
                    if (navigator.userAgent.toLowerCase().includes('firefox')) {
                        this.handlePopupDisplay(e, marker, customPopup, customOptions)
                    }
                });

                marker.addTo(this.markerGroup);
            });
    }

    handlePopupDisplay(e, marker, customPopup, customOptions) {
        const isOpened = e.target.isPopupOpen();
        if (!isOpened) {
            marker.bindPopup(customPopup, customOptions).openPopup();
        } else {
            marker.closePopup();
            marker.unbindPopup();
        }
    };

    buildPopUp ({ Name, Account, StageName, Adresse__c, Id}) {
        return `
            <div>
                <h2>${Name.charAt(0).toUpperCase() + Name.slice(1)}</h2>
                ${this.buildAccountBlock(Account)}
                <h2>Stage</h2>
                <span>${StageName}</span>
                ${this.buildAddressBlock(Adresse__c)}
                <a href='/lightning/r/Opportunity/${Id}/view'>See opportunity</a>
            </div>
        `;
    }

    buildAccountBlock(Account) {
        return Account ?
            `<a href='/lightning/r/Account/${Account.Id}/view'>${Account.Name}</a>`
            : ''
    }

    buildAddressBlock(Adresse__c) {
        return Adresse__c ? 
                `<div class='address-container' data-city=${Adresse__c.city}>
                    <h2>Address</h2>
                    <span>${Adresse__c.street || ''}</span>
                    <span>${Adresse__c.city || ''}${Adresse__c.postalCode ? ' - ' + Adresse__c.postalCode : ''}</span>
                    <span>${Adresse__c.country || ''}</span>
                </div>`
            : ''
    }

}