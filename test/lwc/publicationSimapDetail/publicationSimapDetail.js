import { LightningElement, api, wire } from 'lwc';

import savePublicationHeader from '@salesforce/apex/SimapPublicationDetailService.savePublicationHeader';
import getPublicationDetail from '@salesforce/apex/SimapPublicationDetailService.getPublicationDetail';

import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import PUBLICATION_SIMAP__C from '@salesforce/schema/Publication_Simap__c';

import { publish, MessageContext } from 'lightning/messageService';
import SIMAPMC from "@salesforce/messageChannel/SimapMessageChannel__c";

import { NavigationMixin } from 'lightning/navigation';

const MC_ORIGIN = 'publication_simap_detail'
const GRID_COLUMNS = [
    {
        type: 'text',
        fieldName: 'key',
        label: '',
        width: 300,
    },
    {
        type: 'text',
        fieldName: 'value',
        label: '',
        wrapText: true
    }
]

const STANDARD_PAGE = 'standard__webPage'
const BLANK = '_blank'

const FLOW_BASE_URL = '/lightning/action/quick/Publication_Simap__c.Convertir_Opportunit';
const FLOW_OBJ_API_NAME_PARAM = 'objectApiName';
const FLOW_CONTEXT = 'RECORD_DETAIL';
const FLOW_BACKGROUND_CONTEXT = '/lightning/r/Publication_Simap__c/'
const FLOW_ACTION = '/view'
const PUBLICATION_CONVERTED_STATUS = 'Converted'

const SIMAP_BASE_DETAIL_URL = 'https://www.simap.ch/en/project-detail/'

export default class PublicationSimapDetail extends NavigationMixin(LightningElement) {
    @api publication
    publicationDetails = {}
    publicationFields = {}
    insertedRecordId
    gridColumns = GRID_COLUMNS
    _isFetching = true

    @wire(MessageContext) messageContext;

    @wire(getObjectInfo, { objectApiName: PUBLICATION_SIMAP__C })
    publicationInfo({ data }) {
        if (data) {
            this.publicationFields = data.fields
        }
    }

    get layoutData() {
        return Object.entries(this.publicationFields).reduce((acc, [key, field]) => {
            return field.custom ? [ ...acc, {key: field.label, value: this.publicationDetails[key]} ] : acc
        }, [])
    }

    get title() {
        return this.publication.title.fr || this.publication.title.de || this.publication.title.it || this.publication.title.en
    }

    get displayOpportunityFlowButton() {
        return this.publication.actionStatus !== PUBLICATION_CONVERTED_STATUS
    }

    get externalSimapURL() {
        return `${SIMAP_BASE_DETAIL_URL}${this.publication.id}`
    }

    get externalSimapPDFURL() {
        return this.publicationDetails.Lien_PDF__c
    }

    get isFetching() {
        return this._isFetching
    }

    connectedCallback() {
        this.handleFetchDetails()
    }

    async handleFetchDetails() {
        try {
            const headerResponse = await savePublicationHeader({ jsonPub: JSON.stringify(this.publication) });
            const publication = JSON.parse(headerResponse);
            this.insertedRecordId = publication.Id;
            const detailResponse = await getPublicationDetail({ publicationSimapId: this.insertedRecordId });
            const detailedRecord = JSON.parse(detailResponse);
            this.publicationDetails = { ...publication, ...detailedRecord };
            this._isFetching = false
        } catch (error) {
            console.error('Error in handleFetchDetails:', error);
        }
    }

    handleShowOpportunityFlow() {
        this[NavigationMixin.GenerateUrl]({
            type: STANDARD_PAGE,
            attributes: {
                url: this.makeOpportunityFlowURL()
            }
        }).then(url => {
            window.open(url, BLANK)
        })
        // publish(this.messageContext, SIMAPMC, {
        //     origin: MC_ORIGIN,
        //     type: 'show-opportunity-flow',
        //     recordId: this.insertedRecordId
        // })
    }

    seeOnSimap() {
        window.open(this.externalSimapURL, BLANK);
    }

    async seePDFOnSimap() {
        window.open(this.externalSimapPDFURL, BLANK);
    }

    makeOpportunityFlowURL() {
        const recordId = this.publicationDetails.Id;
        const backgroundContext = `${FLOW_BACKGROUND_CONTEXT}${recordId}${FLOW_ACTION}`;

        const url = `${FLOW_BASE_URL}?${FLOW_OBJ_API_NAME_PARAM}&context=${FLOW_CONTEXT}&recordId=${recordId}&backgroundContext=${encodeURIComponent(backgroundContext)}`;
        
        return url;
    }

    handleCloseModal() {
        const payload = {
            origin: MC_ORIGIN,
            type: 'publication-detail',
            shouldDisplayModal: false,
        }
        console.log(MC_ORIGIN, ' sending event', payload)
        publish(this.messageContext, SIMAPMC, payload)
    }

}