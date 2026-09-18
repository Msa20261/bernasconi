import { LightningElement, track, api } from 'lwc';
import getOpportunitiesWithAccount from '@salesforce/apex/OpportunityService.getOpportunitiesWithAccount';
import getOpportunity from '@salesforce/apex/OpportunityService.getOpportunity';
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class Opportunity_map_filter extends LightningElement {

    allOptions = {
        label: 'See All',
        value: null
    }

    @api recordId
    @track opportunities = false
    @track accounts = [this.allOptions]
    @track stageNames = [this.allOptions]
    @track creationsDate =[this.allOptions]
    @track territories = [this.allOptions]
    @track selectedAccount = null
    @track selectedStage = null
    @track selectedDate = null
    @track selectedTerritory = null

    async connectedCallback() {
        try {
            const data = this.recordId
                ? await getOpportunity({ opportunityId: this.recordId })
                : await getOpportunitiesWithAccount()
            this.opportunities = JSON.parse(data)
            this.opportunities.forEach(opportunity => {
                if (opportunity.Account && !this.accounts.some(account => account.value === opportunity.Account.Id)) {
                    this.accounts.push({
                        label: opportunity.Account.Name,
                        value: opportunity.Account.Id
                    })
                }
                if (!this.stageNames.some(stage => stage.value === opportunity.StageName)) {
                    this.stageNames.push({
                        label: opportunity.StageName,
                        value: opportunity.StageName
                    })
                }
                let year = new Date(opportunity.CreatedDate).getUTCFullYear();
                year = year.toString()
                if (!this.creationsDate.some(date => date.value === year)) {
                    this.creationsDate.push({
                        label: year,
                        value: year
                    })
                }
                if (opportunity.Territory2 && !this.territories.some(territory => territory.value === opportunity.Territory2.Name)) {
                    this.territories.push({
                        label: opportunity.Territory2.Name,
                        value: opportunity.Territory2.Name
                    })
                }
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

    handleAccountSelection(e) {
        this.selectedAccount = e.detail.value
    }

    handleStageSelection(e) {
        this.selectedStage = e.detail.value
    }

    handleDateSelection(e) {
        this.selectedDate = e.detail.value
    }

    handleTerritorySelection(e) {
        this.selectedTerritory = e.detail.value
    }

}