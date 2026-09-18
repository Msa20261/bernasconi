import { LightningElement, api, track, wire } from 'lwc';

import getPublication from '@salesforce/apex/PublicationSimap.getPublication';
import fetchPublicationDetail from '@salesforce/apex/SimapPublicationDetailService.fetchPublicationDetail';

import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import PublicationSimapDetail from '@salesforce/schema/Publication_Simap_Detail__c';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { notifyRecordUpdateAvailable } from 'lightning/uiRecordApi';

export default class Simap_publication_page_detail extends LightningElement {
    @api recordId
    @track publication
    @track publicationDetail
    @track _publicationDetailData = {}
    @track PublicationSimapDetail_API

    @wire(getObjectInfo, { objectApiName: PublicationSimapDetail })
    objectHandler({ data, error }) {
        if (data) {
            this.PublicationSimapDetail_API = data
        } else if (error) {
            console.error('Error retrieving object info: ', error);
        }
    }

    get publicationDetailData() {
        return Object.entries(this._publicationDetailData).map(([key, value]) => ({ key, value }))
    }

    async connectedCallback() {
        const publication = await getPublication({recordId : this.recordId})
        this.publication = JSON.parse(publication)
        this.fetchPublicationDetail()
    }

    async fetchPublicationDetail() {
        try {
            const response = await fetchPublicationDetail({
                pageId : this.publication.Id_publication_page__c,
                detailId : this.publication.Id_publication_detail__c,
                recordId: this.recordId
            })
            const {publicationSimapDetail, isNew} = JSON.parse(response)
            this.publicationDetail = publicationSimapDetail
            this._publicationDetailData = this.parseData()
            this.showToastmessage(isNew)
            notifyRecordUpdateAvailable([{ recordId: this.recordId }])
        } catch (error) {
            console.error('Error fetching publication detail:', error)
        }
    }

    parseData() {
        return Object.entries(this.PublicationSimapDetail_API.fields).reduce((acc, [key, value]) => 
            value.custom ? {...acc, [value.label] : this.publicationDetail[key]} : acc
        , {})
    }

    showToastmessage(isNew) {
        if (!isNew) return
        const evt = new ShowToastEvent({
            title: 'Success',
            message: 'Details récupérés sur SIMAP',
            variant: 'success',
          });
        this.dispatchEvent(evt);
    }

}