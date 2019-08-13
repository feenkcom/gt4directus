"
I exemplify Editorial Services.
See ${class:EsMetaCollections}$ for more details about the model.
"
Class {
	#name : #DiExamples,
	#superclass : #Object,
	#category : #'Directus-Examples'
}

{ #category : #'json data' }
DiExamples >> collectionsJsonString [
	^ '{"data":[', self metaCollectionJsonString, ',', self metaCollectionTwoJsonString, ']}'
]

{ #category : #'json data' }
DiExamples >> collectionsJsonStringStonJson [
	<gtExample>
	| aString anObject |
	aString := self collectionsJsonString.
	anObject := STONJSON fromString: aString.
	self assert: anObject isDictionary.
	self assert: anObject keys size equals: 1.
	^ anObject
]

{ #category : #'meta model' }
DiExamples >> mapping [
	<gtExample>
	| aMapping |
	aMapping := DiMetaModelMapping uniqueInstance.
	self assert: aMapping isNotNil.
	^ aMapping
]

{ #category : #'meta model' }
DiExamples >> metaCollection [
	<gtExample>
	| aJson anObject |
	aJson := self metaCollectionJsonString.
	anObject := self mapping read: DiMetaCollection withMapping: #metaCollectionMappingFor: on: aJson readStream. 
	self assert: anObject class equals: DiMetaCollection.
	self assert: anObject fields numberOfFields equals: 11.
	^ anObject
]

{ #category : #'json data' }
DiExamples >> metaCollectionJsonString [
	^ '{"single":false,"collection":"app","icon":null,"fields":{"description":{"note":"Describes, what the app does","auto_increment":false,"group":null,"type":"string","sort":11,"hidden_detail":false,"hidden_browse":false,"validation":null,"default_value":null,"readonly":false,"options":{"rows":8},"width":"full","length":"65535","primary_key":false,"interface":"textarea","unique":false,"required":false,"translation":null,"datatype":"TEXT","locked":0,"signed":true,"collection":"app","id":262,"field":"description"},"name":{"note":"The name of an app","auto_increment":false,"group":null,"type":"string","sort":8,"hidden_detail":false,"hidden_browse":false,"validation":null,"default_value":null,"readonly":false,"options":{"width":"auto","trim":true,"showCharacterCount":true,"formatValue":false},"width":"full","length":"200","primary_key":false,"interface":"text-input","unique":false,"required":true,"translation":null,"datatype":"VARCHAR","locked":0,"signed":true,"collection":"app","id":261,"field":"name"},"modified_on":{"note":"","auto_increment":false,"group":null,"type":"datetime_updated","sort":6,"hidden_detail":true,"hidden_browse":true,"validation":null,"default_value":null,"readonly":true,"options":null,"width":"full","length":null,"primary_key":false,"interface":"datetime-updated","unique":false,"required":false,"translation":null,"datatype":"DATETIME","locked":0,"signed":true,"collection":"app","id":220,"field":"modified_on"},"created_by":{"note":"","auto_increment":false,"group":null,"type":"user_created","sort":3,"hidden_detail":true,"hidden_browse":true,"validation":null,"default_value":null,"readonly":true,"options":{"display":"both","template":"{{first_name}} {{last_name}}"},"width":"full","length":"10","primary_key":false,"interface":"user-created","unique":false,"required":false,"translation":null,"datatype":"INT","locked":0,"signed":false,"collection":"app","id":217,"field":"created_by"},"id":{"note":"","auto_increment":true,"group":null,"type":"integer","sort":1,"hidden_detail":true,"hidden_browse":true,"validation":null,"default_value":null,"readonly":false,"options":null,"width":"full","length":"10","primary_key":true,"interface":"primary-key","unique":false,"required":true,"translation":null,"datatype":"INT","locked":0,"signed":false,"collection":"app","id":215,"field":"id"},"company":{"note":"The company that provides this app","auto_increment":false,"group":null,"type":"m2o","sort":7,"hidden_detail":false,"hidden_browse":false,"validation":null,"default_value":null,"readonly":false,"options":{"visible_fields":"name","placeholder":"Select one","template":"{{name}}","threshold":20},"width":"full","length":"10","primary_key":false,"interface":"many-to-one","unique":false,"required":true,"translation":null,"datatype":"INT","locked":0,"signed":false,"collection":"app","id":260,"field":"company"},"apple_store_rating":{"note":"The rating of an app from 0 to 5 in the Apple App Store","auto_increment":false,"group":null,"type":"decimal","sort":9,"hidden_detail":false,"hidden_browse":false,"validation":"/^5$|^[0-4](\\.\\d\\d?)?$/","default_value":null,"readonly":false,"options":{"display":"number","localized":true,"iconLeft":"star","active_color":"blue-500","max_stars":5},"width":"half-left","length":"3,2","primary_key":false,"interface":"numeric","unique":false,"required":false,"translation":null,"datatype":"DECIMAL","locked":0,"signed":true,"collection":"app","id":263,"field":"apple_store_rating"},"created_on":{"note":"","auto_increment":false,"group":null,"type":"datetime_created","sort":4,"hidden_detail":true,"hidden_browse":true,"validation":null,"default_value":null,"readonly":true,"options":null,"width":"full","length":null,"primary_key":false,"interface":"datetime-created","unique":false,"required":false,"translation":null,"datatype":"DATETIME","locked":0,"signed":true,"collection":"app","id":218,"field":"created_on"},"status":{"note":"","auto_increment":false,"group":null,"type":"status","sort":2,"hidden_detail":false,"hidden_browse":false,"validation":null,"default_value":"draft","readonly":false,"options":{"status_mapping":{"deleted":{"value":"deleted","browse_subdued":true,"text_color":"white","background_color":"red","browse_badge":true,"soft_delete":true,"name":"Deleted","published":false},"published":{"value":"published","browse_subdued":false,"text_color":"white","background_color":"accent","browse_badge":true,"soft_delete":false,"name":"Published","published":true},"draft":{"value":"draft","browse_subdued":true,"text_color":"white","background_color":"blue-grey-100","browse_badge":true,"soft_delete":false,"name":"Draft","published":false}}},"width":"full","length":"20","primary_key":false,"interface":"status","unique":false,"required":false,"translation":null,"datatype":"VARCHAR","locked":0,"signed":true,"collection":"app","id":216,"field":"status"},"play_store_rating":{"note":"The rating of an app from 0 to 5 in the Google Play Store","auto_increment":false,"group":null,"type":"decimal","sort":10,"hidden_detail":false,"hidden_browse":false,"validation":"/^5$|^[0-4](\\.\\d\\d?)?$/","default_value":null,"readonly":false,"options":{"display":"number","localized":true,"iconLeft":"star","active_color":"green","max_stars":5},"width":"half-right","length":"3,2","primary_key":false,"interface":"numeric","unique":false,"required":false,"translation":null,"datatype":"DECIMAL","locked":0,"signed":true,"collection":"app","id":264,"field":"play_store_rating"},"modified_by":{"note":"","auto_increment":false,"group":null,"type":"user_updated","sort":5,"hidden_detail":true,"hidden_browse":true,"validation":null,"default_value":null,"readonly":true,"options":{"display":"both","template":"{{first_name}} {{last_name}}"},"width":"full","length":"10","primary_key":false,"interface":"user-updated","unique":false,"required":false,"translation":null,"datatype":"INT","locked":0,"signed":false,"collection":"app","id":219,"field":"modified_by"}},"translation":null,"note":null,"hidden":false,"managed":true}'
			
]

{ #category : #'json data' }
DiExamples >> metaCollectionStonJson [
	<gtExample>
	| aString anObject |
	aString := self metaCollectionJsonString.
	anObject := STONJSON fromString: aString.
	self assert: anObject isDictionary.
	self assert: anObject keys size equals: 8.
	^ anObject
]

{ #category : #'json data' }
DiExamples >> metaCollectionTwoJsonString [
	^ '{"single":false,"collection":"app_traffic_country","icon":null,"fields":{"modified_on":{"note":"","auto_increment":false,"group":null,"type":"datetime_updated","sort":6,"hidden_detail":true,"hidden_browse":true,"validation":null,"default_value":null,"readonly":true,"options":null,"width":"full","length":null,"primary_key":false,"interface":"datetime-updated","unique":false,"required":false,"translation":null,"datatype":"DATETIME","locked":0,"signed":true,"collection":"app_traffic_country","id":232,"field":"modified_on"},"created_by":{"note":"","auto_increment":false,"group":null,"type":"user_created","sort":3,"hidden_detail":true,"hidden_browse":true,"validation":null,"default_value":null,"readonly":true,"options":{"display":"both","template":"{{first_name}} {{last_name}}"},"width":"full","length":"10","primary_key":false,"interface":"user-created","unique":false,"required":false,"translation":null,"datatype":"INT","locked":0,"signed":false,"collection":"app_traffic_country","id":229,"field":"created_by"},"id":{"note":"","auto_increment":true,"group":null,"type":"integer","sort":1,"hidden_detail":true,"hidden_browse":true,"validation":null,"default_value":null,"readonly":false,"options":null,"width":"full","length":"10","primary_key":true,"interface":"primary-key","unique":false,"required":true,"translation":null,"datatype":"INT","locked":0,"signed":false,"collection":"app_traffic_country","id":227,"field":"id"},"play_store_downloads":{"note":"Count of app downloads from Play Store (country specific)","auto_increment":false,"group":null,"type":"integer","sort":12,"hidden_detail":false,"hidden_browse":false,"validation":null,"default_value":null,"readonly":false,"options":{"localized":true,"iconRight":"get_app","iconLeft":"android"},"width":"half-right","length":"20","primary_key":false,"interface":"numeric","unique":false,"required":false,"translation":null,"datatype":"BIGINT","locked":0,"signed":false,"collection":"app_traffic_country","id":239,"field":"play_store_downloads"},"created_on":{"note":"","auto_increment":false,"group":null,"type":"datetime_created","sort":4,"hidden_detail":true,"hidden_browse":true,"validation":null,"default_value":null,"readonly":true,"options":null,"width":"full","length":null,"primary_key":false,"interface":"datetime-created","unique":false,"required":false,"translation":null,"datatype":"DATETIME","locked":0,"signed":true,"collection":"app_traffic_country","id":230,"field":"created_on"},"apple_store_downloads":{"note":"Count of app downloads from Apple Store (country specific)","auto_increment":false,"group":null,"type":"integer","sort":11,"hidden_detail":false,"hidden_browse":false,"validation":null,"default_value":null,"readonly":false,"options":{"localized":true,"iconRight":"get_app","iconLeft":"phone_iphone"},"width":"half-left","length":"20","primary_key":false,"interface":"numeric","unique":false,"required":false,"translation":null,"datatype":"BIGINT","locked":0,"signed":false,"collection":"app_traffic_country","id":238,"field":"apple_store_downloads"},"status":{"note":"","auto_increment":false,"group":null,"type":"status","sort":2,"hidden_detail":false,"hidden_browse":false,"validation":null,"default_value":"draft","readonly":false,"options":{"status_mapping":{"deleted":{"value":"deleted","browse_subdued":true,"text_color":"white","background_color":"red","browse_badge":true,"soft_delete":true,"name":"Deleted","published":false},"published":{"value":"published","browse_subdued":false,"text_color":"white","background_color":"accent","browse_badge":true,"soft_delete":false,"name":"Published","published":true},"draft":{"value":"draft","browse_subdued":true,"text_color":"white","background_color":"blue-grey-100","browse_badge":true,"soft_delete":false,"name":"Draft","published":false}}},"width":"full","length":"20","primary_key":false,"interface":"status","unique":false,"required":false,"translation":null,"datatype":"VARCHAR","locked":0,"signed":true,"collection":"app_traffic_country","id":228,"field":"status"},"country":{"note":"Represented country","auto_increment":false,"group":null,"type":"m2o","sort":8,"hidden_detail":false,"hidden_browse":false,"validation":null,"default_value":null,"readonly":false,"options":{"showCharacterCount":true,"visible_fields":"iso_code, name","formatting":true,"limit":false,"width":"auto","threshold":20,"choices":[],"trim":true,"formatValue":false,"template":"{{iso_code}} {{name}}","placeholder":"Select one"},"width":"full","length":"10","primary_key":false,"interface":"many-to-one","unique":false,"required":true,"translation":null,"datatype":"INT","locked":0,"signed":true,"collection":"app_traffic_country","id":234,"field":"country"},"play_store_rank":{"note":"Rank of an app traffic in a country generated by Play Store","auto_increment":false,"group":null,"type":"integer","sort":10,"hidden_detail":false,"hidden_browse":false,"validation":null,"default_value":null,"readonly":false,"options":{"localized":true,"iconRight":"trending_up","iconLeft":"android"},"width":"half-right","length":"10","primary_key":false,"interface":"numeric","unique":false,"required":false,"translation":null,"datatype":"INT","locked":0,"signed":false,"collection":"app_traffic_country","id":258,"field":"play_store_rank"},"app_traffic_data":{"note":"","auto_increment":false,"group":null,"type":"m2o","sort":7,"hidden_detail":false,"hidden_browse":false,"validation":null,"default_value":null,"readonly":false,"options":{"visible_fields":"created_on, app","placeholder":"Select one","template":"{{app.name}} ({{created_on}})","threshold":20},"width":"full","length":"10","primary_key":false,"interface":"many-to-one","unique":false,"required":true,"translation":null,"datatype":"INT","locked":0,"signed":false,"collection":"app_traffic_country","id":259,"field":"app_traffic_data"},"apple_store_rank":{"note":"Rank of an app traffic in a country generated by Apple Store","auto_increment":false,"group":null,"type":"integer","sort":9,"hidden_detail":false,"hidden_browse":false,"validation":null,"default_value":null,"readonly":false,"options":{"localized":true,"iconRight":"trending_up","iconLeft":"phone_iphone"},"width":"half-left","length":"10","primary_key":false,"interface":"numeric","unique":false,"required":false,"translation":null,"datatype":"INT","locked":0,"signed":false,"collection":"app_traffic_country","id":257,"field":"apple_store_rank"},"modified_by":{"note":"","auto_increment":false,"group":null,"type":"user_updated","sort":5,"hidden_detail":true,"hidden_browse":true,"validation":null,"default_value":null,"readonly":true,"options":{"display":"both","template":"{{first_name}} {{last_name}}"},"width":"full","length":"10","primary_key":false,"interface":"user-updated","unique":false,"required":false,"translation":null,"datatype":"INT","locked":0,"signed":false,"collection":"app_traffic_country","id":231,"field":"modified_by"}},"translation":null,"note":null,"hidden":false,"managed":true}'
			
]

{ #category : #'json data' }
DiExamples >> metaCollectionTwoStonJson [
	<gtExample>
	| aString anObject |
	aString := self metaCollectionTwoJsonString.
	anObject := STONJSON fromString: aString.
	self assert: anObject isDictionary.
	self assert: anObject keys size equals: 8.
	^ anObject
]

{ #category : #'meta model' }
DiExamples >> metaCollections [
	<gtExample>
	| aJson anObject |
	aJson := self collectionsJsonString.
	anObject := self mapping readMetaDescriptions: aJson. 
	self assert: anObject class equals: DiMetaCollections.
	self assert: anObject numberOfData equals: 2.
	^ anObject
]

{ #category : #'meta model' }
DiExamples >> metaFieldOfDescription [
	<gtExample>
	| aJson anObject |
	aJson := self metaFieldOfDescriptionJsonString.
	anObject := self mapping read: DiMetaField withMapping: #metaFieldMappingFor: on: aJson readStream. 
	self assert: anObject class equals: DiMetaField.
	self assert: anObject name equals: 'description'.
	self assert: anObject note equals: 'Describes, what the app does'.
	self assert: anObject type equals: 'string'.
	^ anObject
]

{ #category : #'json data' }
DiExamples >> metaFieldOfDescriptionJsonString [
	^ '{
					"note" : "Describes, what the app does",
					"auto_increment" : false,
					"group" : null,
					"type" : "string",
					"sort" : 11,
					"hidden_detail" : false,
					"hidden_browse" : false,
					"validation" : null,
					"default_value" : null,
					"readonly" : false,
					"options" : {
						"rows" : 8
					},
					"width" : "full",
					"length" : "65535",
					"primary_key" : false,
					"interface" : "textarea",
					"unique" : false,
					"required" : false,
					"translation" : null,
					"datatype" : "TEXT",
					"locked" : 0,
					"signed" : true,
					"collection" : "app",
					"id" : 262,
					"field" : "description"
		}'
]

{ #category : #'json data' }
DiExamples >> metaFieldOfDescriptionStonJson [
	<gtExample>
	| aString anObject |
	aString := self metaFieldOfDescriptionJsonString.
	anObject := STONJSON fromString: aString.
	self assert: anObject isDictionary.
	self assert: anObject keys size equals: 24.
	^ anObject
]

{ #category : #'meta model' }
DiExamples >> metaFieldOfName [
	<gtExample>
	| aJson anObject |
	aJson := self metaFieldOfNameJsonString.
	anObject := self mapping read: DiMetaField withMapping: #metaFieldMappingFor: on: aJson readStream. 
	self assert: anObject class equals: DiMetaField.
	self assert: anObject name equals: 'name'.
	self assert: anObject note equals: 'The name of an app'.
	self assert: anObject type equals: 'string'.
	^ anObject
]

{ #category : #'json data' }
DiExamples >> metaFieldOfNameJsonString [
	^ '{
					"note" : "The name of an app",
					"auto_increment" : false,
					"group" : null,
					"type" : "string",
					"sort" : 8,
					"hidden_detail" : false,
					"hidden_browse" : false,
					"validation" : null,
					"default_value" : null,
					"readonly" : false,
					"options" : {
						"width" : "auto",
						"trim" : true,
						"showCharacterCount" : true,
						"formatValue" : false
					},
					"width" : "full",
					"length" : "200",
					"primary_key" : false,
					"interface" : "text-input",
					"unique" : false,
					"required" : true,
					"translation" : null,
					"datatype" : "VARCHAR",
					"locked" : 0,
					"signed" : true,
					"collection" : "app",
					"id" : 261,
					"field" : "name"
				}'
]

{ #category : #'json data' }
DiExamples >> metaFieldOfNameStonJson [
	<gtExample>
	| aString anObject |
	aString := self metaFieldOfNameJsonString.
	anObject := STONJSON fromString: aString.
	self assert: anObject isDictionary.
	self assert: anObject keys size equals: 24.
	^ anObject
]

{ #category : #'meta model' }
DiExamples >> metaFieldsOfNameAndDescription [
	<gtExample>
	| aJson anObject |
	aJson := self metaFieldsOfNameAndDescriptionJsonString.
	anObject := self mapping read: DiMetaFields withMapping: #metaFieldsMappingFor: on: aJson readStream. 
	self assert: anObject class equals: DiMetaFields.
	self assert: anObject numberOfFields equals: 2.
	^ anObject
]

{ #category : #'json data' }
DiExamples >> metaFieldsOfNameAndDescriptionJsonString [
	^ '{"description" : ', self metaFieldOfDescriptionJsonString, ', "name" : ', self metaFieldOfNameJsonString, '}'
]

{ #category : #'json data' }
DiExamples >> metaFieldsOfNameAndDescriptionStonJson [
	<gtExample>
	| aString anObject |
	aString := self metaFieldsOfNameAndDescriptionJsonString.
	anObject := STONJSON fromString: aString.
	self assert: anObject isDictionary.
	self assert: anObject keys size equals: 2.
	^ anObject
]
