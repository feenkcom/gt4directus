"
I exemplify Editorial Services.
See ${class:DiMetaCollections}$ for more details about the model.
"
Class {
	#name : #DiExamples,
	#superclass : #DiCommonExamples,
	#category : #'GToolkit4Directus-Examples'
}

{ #category : #'company - creating class model' }
DiExamples >> buildCompanyModel [
	<gtExample>
	| aBuilder aModelClass |
	aBuilder := self companyModelClassBuilder.
	aBuilder build.
	aModelClass := self class environment classNamed: 'DummyCompany'.
	self assert: aModelClass isNotNil.
	self assert: aModelClass isClass.
	self assert: aModelClass selectors size equals: 9.
	^ aModelClass
]

{ #category : #'company - creating class model' }
DiExamples >> companyModelClassBuilder [
	<gtExample>
	| aMetaCollections aBuilder |
	aMetaCollections := self metaCollectionsOfCompany.
	aBuilder := self modelBuilder.
	aBuilder collections: aMetaCollections.
	self assert: aBuilder collections equals: aMetaCollections.
	^ aBuilder
]

{ #category : #'model builder' }
DiExamples >> dummyPackage [
	<gtExample>
	"<after: #removeDummyPackage>"
	| aPackageName aPackage anOrganizer |
	aPackageName := self dummyPackageName.
	anOrganizer := RPackageOrganizer default.
	aPackage := anOrganizer registerPackageNamed: aPackageName asSymbol.
	self assert: (anOrganizer includesPackageNamed: aPackageName).
	^ aPackage
]

{ #category : #'model builder' }
DiExamples >> dummyPackageName [
	^ 'Dummy-Package-For' , self class package name
]

{ #category : #'company - importer' }
DiExamples >> importCompanyCollectionsWithRelations [
	<gtExample>
	| anImporter aMetaModel aCollection aRelation aField |
	anImporter := self importer.
	aMetaModel := anImporter getCollectionsWithRelations.
	self assert: aMetaModel isNotNil.
	aCollection := aMetaModel collections data first.
	aRelation := aMetaModel relations data first.
	aField := aCollection fieldNamed: 'parent_company'.
	self assert: aField type collection equals: aCollection.
	self assert: aField type relation equals: aRelation.
	aField :=  aCollection fieldNamed: 'subsidiary_companies'.
	self assert: aField type collection equals: aCollection.
	self assert: aField type relation equals: aRelation.
	^ aMetaModel
]

{ #category : #'company - importer' }
DiExamples >> importCompanyMetaModel [
	<gtExample>
	| anImporter aMetaModel aCollection aField |
	anImporter := self importer.
	aMetaModel := anImporter getCollections.
	self assert: aMetaModel isNotNil.
	aCollection := aMetaModel data first.
	aField := aCollection fieldNamed: 'parent_company'.
	self assert: aField type collection isNil.
	self assert: aField type relation isNil.
	aField :=  aCollection fieldNamed: 'subsidiary_companies'.
	self assert: aField type collection isNil.
	self assert: aField type relation isNil.
	^ aMetaModel
]

{ #category : #'company - importer' }
DiExamples >> importCompanyRelations [
	<gtExample>
	| anImporter theCollections |
	anImporter := self importer.
	theCollections := anImporter getRelations.
	self assert: theCollections isNotNil.
	self assert: theCollections class equals: DiMetaRelations.
	self assert: theCollections numberOfData equals: 1.
	^ theCollections
]

{ #category : #server }
DiExamples >> initializeDelegate [
	super initializeDelegate.
	delegate
		map: '/collections'
		to: [ :aRequest :aResponse | 
			aResponse entity: (ZnEntity json: self metaCollectionsOfCompanyJsonString) ];
		map: '/relations'
		to: [ :aRequest :aResponse | 
			aResponse entity: (ZnEntity json: self metaRelationsOfParentSubsidiaryCompaniesJsonString) ]
]

{ #category : #'reading - meta model' }
DiExamples >> metaCollection [
	<gtExample>
	| aJson anObject |
	aJson := self metaCollectionJsonString.
	anObject := self mapping read: DiMetaCollection withMapping: #metaCollectionMappingFor: on: aJson readStream. 
	self assert: anObject class equals: DiMetaCollection.
	self assert: anObject fields numberOfFields equals: 11.
	self assert: anObject modelClassName equals: 'App'.
	^ anObject
]

{ #category : #'json data' }
DiExamples >> metaCollectionCountryJsonString [
	^ '{"collection":"country","fields":[', 
			self metaFieldOfIdJsonString, ',',
			self metaFieldOfCapitalCityJsonString, ',',
			self metaFieldOfIsoCodeJsonString, 
		'],"hidden":false,"icon":"outlined_flag","managed":true,"single":false}'
			
]

{ #category : #'json data' }
DiExamples >> metaCollectionCountryStonJson [
	<gtExample>
	| aString anObject |
	aString := self metaCollectionCountryJsonString.
	anObject := STONJSON fromString: aString.
	self assert: anObject isDictionary.
	self assert: anObject keys size equals: 6.
	^ anObject
]

{ #category : #'json data' }
DiExamples >> metaCollectionJsonString [
	^ '{"single":false,"collection":"app","icon":null,"fields":{"description":{"note":"Describes, what the app does","auto_increment":false,"group":null,"type":"string","sort":11,"hidden_detail":false,"hidden_browse":false,"validation":null,"default_value":null,"readonly":false,"options":{"rows":8},"width":"full","length":"65535","primary_key":false,"interface":"textarea","unique":false,"required":false,"translation":null,"datatype":"TEXT","locked":0,"signed":true,"collection":"app","id":262,"field":"description"},"name":{"note":"The name of an app","auto_increment":false,"group":null,"type":"string","sort":8,"hidden_detail":false,"hidden_browse":false,"validation":null,"default_value":null,"readonly":false,"options":{"width":"auto","trim":true,"showCharacterCount":true,"formatValue":false},"width":"full","length":"200","primary_key":false,"interface":"text-input","unique":false,"required":true,"translation":null,"datatype":"VARCHAR","locked":0,"signed":true,"collection":"app","id":261,"field":"name"},"modified_on":{"note":"","auto_increment":false,"group":null,"type":"datetime_updated","sort":6,"hidden_detail":true,"hidden_browse":true,"validation":null,"default_value":null,"readonly":true,"options":null,"width":"full","length":null,"primary_key":false,"interface":"datetime-updated","unique":false,"required":false,"translation":null,"datatype":"DATETIME","locked":0,"signed":true,"collection":"app","id":220,"field":"modified_on"},"created_by":{"note":"","auto_increment":false,"group":null,"type":"user_created","sort":3,"hidden_detail":true,"hidden_browse":true,"validation":null,"default_value":null,"readonly":true,"options":{"display":"both","template":"{{first_name}} {{last_name}}"},"width":"full","length":"10","primary_key":false,"interface":"user-created","unique":false,"required":false,"translation":null,"datatype":"INT","locked":0,"signed":false,"collection":"app","id":217,"field":"created_by"},"id":{"note":"","auto_increment":true,"group":null,"type":"integer","sort":1,"hidden_detail":true,"hidden_browse":true,"validation":null,"default_value":null,"readonly":false,"options":null,"width":"full","length":"10","primary_key":true,"interface":"primary-key","unique":false,"required":true,"translation":null,"datatype":"INT","locked":0,"signed":false,"collection":"app","id":215,"field":"id"},"company":{"note":"The company that provides this app","auto_increment":false,"group":null,"type":"m2o","sort":7,"hidden_detail":false,"hidden_browse":false,"validation":null,"default_value":null,"readonly":false,"options":{"visible_fields":"name","placeholder":"Select one","template":"{{name}}","threshold":20},"width":"full","length":"10","primary_key":false,"interface":"many-to-one","unique":false,"required":true,"translation":null,"datatype":"INT","locked":0,"signed":false,"collection":"app","id":260,"field":"company"},"apple_store_rating":{"note":"The rating of an app from 0 to 5 in the Apple App Store","auto_increment":false,"group":null,"type":"decimal","sort":9,"hidden_detail":false,"hidden_browse":false,"validation":"/^5$|^[0-4](\\.\\d\\d?)?$/","default_value":null,"readonly":false,"options":{"display":"number","localized":true,"iconLeft":"star","active_color":"blue-500","max_stars":5},"width":"half-left","length":"3,2","primary_key":false,"interface":"numeric","unique":false,"required":false,"translation":null,"datatype":"DECIMAL","locked":0,"signed":true,"collection":"app","id":263,"field":"apple_store_rating"},"created_on":{"note":"","auto_increment":false,"group":null,"type":"datetime_created","sort":4,"hidden_detail":true,"hidden_browse":true,"validation":null,"default_value":null,"readonly":true,"options":null,"width":"full","length":null,"primary_key":false,"interface":"datetime-created","unique":false,"required":false,"translation":null,"datatype":"DATETIME","locked":0,"signed":true,"collection":"app","id":218,"field":"created_on"},"status":{"note":"","auto_increment":false,"group":null,"type":"status","sort":2,"hidden_detail":false,"hidden_browse":false,"validation":null,"default_value":"draft","readonly":false,"options":{"status_mapping":{"deleted":{"value":"deleted","browse_subdued":true,"text_color":"white","background_color":"red","browse_badge":true,"soft_delete":true,"name":"Deleted","published":false},"published":{"value":"published","browse_subdued":false,"text_color":"white","background_color":"accent","browse_badge":true,"soft_delete":false,"name":"Published","published":true},"draft":{"value":"draft","browse_subdued":true,"text_color":"white","background_color":"blue-grey-100","browse_badge":true,"soft_delete":false,"name":"Draft","published":false}}},"width":"full","length":"20","primary_key":false,"interface":"status","unique":false,"required":false,"translation":null,"datatype":"VARCHAR","locked":0,"signed":true,"collection":"app","id":216,"field":"status"},"play_store_rating":{"note":"The rating of an app from 0 to 5 in the Google Play Store","auto_increment":false,"group":null,"type":"decimal","sort":10,"hidden_detail":false,"hidden_browse":false,"validation":"/^5$|^[0-4](\\.\\d\\d?)?$/","default_value":null,"readonly":false,"options":{"display":"number","localized":true,"iconLeft":"star","active_color":"green","max_stars":5},"width":"half-right","length":"3,2","primary_key":false,"interface":"numeric","unique":false,"required":false,"translation":null,"datatype":"DECIMAL","locked":0,"signed":true,"collection":"app","id":264,"field":"play_store_rating"},"modified_by":{"note":"","auto_increment":false,"group":null,"type":"user_updated","sort":5,"hidden_detail":true,"hidden_browse":true,"validation":null,"default_value":null,"readonly":true,"options":{"display":"both","template":"{{first_name}} {{last_name}}"},"width":"full","length":"10","primary_key":false,"interface":"user-updated","unique":false,"required":false,"translation":null,"datatype":"INT","locked":0,"signed":false,"collection":"app","id":219,"field":"modified_by"}},"translation":null,"note":null,"hidden":false,"managed":true}'
			
]

{ #category : #'company - reading' }
DiExamples >> metaCollectionOfCompany [
	<gtExample>
	| aJson anObject |
	aJson := self metaCollectionOfCompanyJsonString.
	anObject := self mapping read: DiMetaCollection withMapping: #metaCollectionMappingFor: on: aJson readStream. 
	self assert: anObject class equals: DiMetaCollection.
	self assert: anObject numberOfFields equals: 4.
	self assert: anObject modelClassName equals: 'Company'.
	^ anObject
]

{ #category : #'company - json data' }
DiExamples >> metaCollectionOfCompanyJsonString [
	^ '{"collection":"company","fields":{',
			'"id":', self metaFieldOfIdJsonString, ',',
			'"name":', self metaFieldOfCompanyNameJsonString, ',',
			'"parent_company":', self metaFieldOfParentCompanyJsonString, ',',
			'"subsidiary_companies":', self metaFieldOfSubsidiaryCompaniesJsonString, 
		'},"hidden":false,"icon":"location_city","managed":true,"single":false}'			
]

{ #category : #'company - json data' }
DiExamples >> metaCollectionOfCompanyStonJson [
	<gtExample>
	| aString anObject |
	aString := self metaCollectionOfCompanyJsonString.
	anObject := STONJSON fromString: aString.
	self assert: anObject isDictionary.
	self assert: anObject keys size equals: 6.
	^ anObject
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

{ #category : #'reading - meta model' }
DiExamples >> metaCollections [
	<gtExample>
	| aJson anObject |
	aJson := self metaCollectionsJsonString.
	anObject := self mapping readCollections: aJson. 
	self assert: anObject class equals: DiMetaCollections.
	self assert: anObject numberOfData equals: 2.
	^ anObject
]

{ #category : #'json data' }
DiExamples >> metaCollectionsJsonString [
	^ '{"data":[', self metaCollectionJsonString, ',', self metaCollectionTwoJsonString, ']}'
]

{ #category : #'company - reading' }
DiExamples >> metaCollectionsOfCompany [
	<gtExample>
	| aJson anObject |
	aJson := self metaCollectionsOfCompanyJsonString.
	anObject := self mapping readCollections: aJson readStream. 
	self assert: anObject class equals: DiMetaCollections.
	self assert: anObject numberOfData equals: 1.
	^ anObject
]

{ #category : #'company - json data' }
DiExamples >> metaCollectionsOfCompanyJsonString [
	^ '{"data":[', self metaCollectionOfCompanyJsonString, ']}'			
]

{ #category : #'company - json data' }
DiExamples >> metaCollectionsOfCompanyStonJson [
	<gtExample>
	| aString anObject |
	aString := self metaCollectionsOfCompanyJsonString.
	anObject := STONJSON fromString: aString.
	self assert: anObject isDictionary.
	self assert: anObject keys size equals: 1.
	self assert: anObject keys first equals: 'data'.
	^ anObject
]

{ #category : #'json data' }
DiExamples >> metaCollectionsStonJson [
	<gtExample>
	| aString anObject |
	aString := self metaCollectionsJsonString.
	anObject := STONJSON fromString: aString.
	self assert: anObject isDictionary.
	self assert: anObject keys size equals: 1.
	^ anObject
]

{ #category : #'company - reading' }
DiExamples >> metaCollectionsWithRelationsOfCompany [
	<gtExample>
	| aMetaModel aField aCollection aRelation |
	aMetaModel := self metaCollectionsWithRelationsOfCompany_NotComputed.
	aMetaModel buildRelations.
	aCollection := aMetaModel collections data first.
	aRelation := aMetaModel relations data first.
	aField := aCollection fieldNamed: 'parent_company'.
	self assert: aField type collection equals: aCollection.
	self assert: aField type relation equals: aRelation.
	aField :=  aCollection fieldNamed: 'subsidiary_companies'.
	self assert: aField type collection equals: aCollection.
	self assert: aField type relation equals: aRelation.
	^ aMetaModel
]

{ #category : #'company - reading' }
DiExamples >> metaCollectionsWithRelationsOfCompany_NotComputed [
	<gtExample>
	| theCollections theRelations aMetaModel aField |
	theCollections := self metaCollectionsOfCompany.
	theRelations := self metaRelationsOfParentSubsidiaryCompanies.
	aMetaModel := DiMetaCollectionsWithRelations new
		collections: theCollections;
		relations: theRelations.
	self assert: aMetaModel collections equals: theCollections.
	self assert: aMetaModel relations equals: theRelations.
	aField := theCollections data first fieldNamed: 'parent_company'.
	self assert: aField type collection isNil.
	self assert: aField type relation isNil.
	aField := theCollections data first fieldNamed: 'subsidiary_companies'.
	self assert: aField type collection isNil.
	self assert: aField type relation isNil.
	^ aMetaModel
]

{ #category : #'json data' }
DiExamples >> metaFieldOfCapitalCityJsonString [
	^ '{"note":"The capital of a country","type":"string","field":"capital_city"}'
]

{ #category : #'reading - meta model' }
DiExamples >> metaFieldOfDescription [
	<gtExample>
	| aJson anObject |
	aJson := self metaFieldOfDescriptionJsonString.
	anObject := self mapping read: DiMetaField withMapping: #metaFieldMappingFor: on: aJson readStream. 
	self assert: anObject class equals: DiMetaField.
	self assert: anObject name equals: 'description'.
	self assert: anObject note equals: 'Describes, what the app does'.
	self assert: anObject type isUnrecognized not.
	self assert: anObject type name equals: 'String'.
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

{ #category : #'json data' }
DiExamples >> metaFieldOfIsoCodeJsonString [
	^ '{"note":"Alpha-2 Code (two letters) from ISO 3166","type":"string","field":"iso_code"}'
]

{ #category : #'reading - meta model' }
DiExamples >> metaFieldOfName [
	<gtExample>
	| aJson anObject |
	aJson := self metaFieldOfNameJsonString.
	anObject := self mapping read: DiMetaField withMapping: #metaFieldMappingFor: on: aJson readStream. 
	self assert: anObject class equals: DiMetaField.
	self assert: anObject name equals: 'name'.
	self assert: anObject note equals: 'The name of an app'.
	self assert: anObject type isUnrecognized not.
	self assert: anObject type name equals: 'String'.
	self assert: anObject getter equals: #name.
	self assert: anObject setter equals: #name:.
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

{ #category : #'company - json data' }
DiExamples >> metaFieldOfSubsidiaryCompaniesJsonString [
	^ '{"note":"Companies that are owned by this company. To change this, select this company as parent in the subsidiary companies.","type":"O2M","field":"subsidiary_companies"}'
]

{ #category : #'reading - meta model' }
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

{ #category : #'reading - meta model' }
DiExamples >> metaRelationOfFieldManyRole [
	<gtExample>
	| aJson anObject |
	aJson := self metaRelationOfFieldManyRoleJsonString.
	anObject := self mapping read: DiMetaRelation withMapping: #metaRelationMappingFor: on: aJson readStream. 
	self assert: anObject class equals: DiMetaRelation.
	self assert: anObject junctionField equals: 'user'.
	self assert: anObject collectionMany equals: 'directus_user_roles'.
	self assert: anObject collectionOne equals: 'directus_roles'.
	self assert: anObject fieldMany equals: 'role'.
	self assert: anObject fieldOne equals: 'users'.
	^ anObject
]

{ #category : #'json data' }
DiExamples >> metaRelationOfFieldManyRoleJsonString [
	^ '{"junction_field":"user","collection_many":"directus_user_roles","field_many":"role","id":12,"collection_one":"directus_roles","field_one":"users"}'
]

{ #category : #'json data' }
DiExamples >> metaRelationOfFieldManyRoleStonJson [
	<gtExample>
	| aString anObject |
	aString := self metaRelationOfFieldManyRoleJsonString.
	anObject := STONJSON fromString: aString.
	self assert: anObject isDictionary.
	self assert: anObject keys size equals: 6.
	^ anObject
]

{ #category : #'reading - meta model' }
DiExamples >> metaRelationOfFieldManyUser [
	<gtExample>
	| aJson anObject |
	aJson := self metaRelationOfFieldManyUserJsonString.
	anObject := self mapping read: DiMetaRelation withMapping: #metaRelationMappingFor: on: aJson readStream. 
	self assert: anObject class equals: DiMetaRelation.
	self assert: anObject collectionMany equals: 'directus_activity_seen'.
	self assert: anObject collectionOne equals: 'directus_users'.
	self assert: anObject fieldMany equals: 'user'.
	^ anObject
]

{ #category : #'json data' }
DiExamples >> metaRelationOfFieldManyUserJsonString [
	^ '{"junction_field":null,"collection_many":"directus_activity_seen","field_many":"user","id":2,"collection_one":"directus_users","field_one":null}'
]

{ #category : #'json data' }
DiExamples >> metaRelationOfFieldManyUserStonJson [
	<gtExample>
	| aString anObject |
	aString := self metaRelationOfFieldManyUserJsonString.
	anObject := STONJSON fromString: aString.
	self assert: anObject isDictionary.
	self assert: anObject keys size equals: 6.
	^ anObject
]

{ #category : #'company - reading' }
DiExamples >> metaRelationOfParentSubsidiaryCompanies [
	<gtExample>
	| aJson anObject |
	aJson := self metaRelationOfParentSubsidiaryCompaniesJsonString.
	anObject := self mapping read: DiMetaRelation withMapping: #metaRelationMappingFor: on: aJson readStream. 
	self assert: anObject class equals: DiMetaRelation.
	self assert: anObject collectionMany equals: 'company'.
	self assert: anObject collectionOne equals: 'company'.
	self assert: anObject fieldMany equals: 'parent_company'.
	self assert: anObject fieldOne equals: 'subsidiary_companies'.
	^ anObject
]

{ #category : #'company - json data' }
DiExamples >> metaRelationOfParentSubsidiaryCompaniesJsonString [
	^ '{"field_one":"subsidiary_companies","collection_many":"company","field_many":"parent_company","collection_one":"company"}'
]

{ #category : #'reading - meta model' }
DiExamples >> metaRelationsOfFieldManyUserAndRole [
	<gtExample>
	| aJson anObject |
	aJson := self metaRelationsOfFieldManyUserAndRoleJsonString.
	anObject := self mapping readRelations: aJson. 
	self assert: anObject class equals: DiMetaRelations.
	self assert: anObject numberOfData equals: 2.
	^ anObject
]

{ #category : #'json data' }
DiExamples >> metaRelationsOfFieldManyUserAndRoleJsonString [
	^ '{"data":[', self metaRelationOfFieldManyUserJsonString, ',', self metaRelationOfFieldManyRoleJsonString, ']}'
]

{ #category : #'json data' }
DiExamples >> metaRelationsOfFieldManyUserAndRoleStonJson [
	<gtExample>
	| aString anObject |
	aString := self metaRelationsOfFieldManyUserAndRoleJsonString.
	anObject := STONJSON fromString: aString.
	self assert: anObject isDictionary.
	self assert: anObject keys size equals: 1.
	^ anObject
]

{ #category : #'company - reading' }
DiExamples >> metaRelationsOfParentSubsidiaryCompanies [
	<gtExample>
	| aJson anObject |
	aJson := self metaRelationsOfParentSubsidiaryCompaniesJsonString.
	anObject := self mapping readRelations: aJson readStream. 
	self assert: anObject class equals: DiMetaRelations.
	self assert: anObject numberOfData equals: 1.
	^ anObject
]

{ #category : #'company - json data' }
DiExamples >> metaRelationsOfParentSubsidiaryCompaniesJsonString [
	^ '{"data":[', self metaRelationOfParentSubsidiaryCompaniesJsonString, ']}'			
]

{ #category : #'company - json data' }
DiExamples >> metaRelationsOfParentSubsidiaryCompaniesStonJson [
	<gtExample>
	| aString anObject |
	aString := self metaRelationsOfParentSubsidiaryCompaniesJsonString.
	anObject := STONJSON fromString: aString.
	self assert: anObject isDictionary.
	self assert: anObject keys size equals: 1.
	self assert: anObject keys first equals: 'data'.
	^ anObject
]

{ #category : #'model builder' }
DiExamples >> modelBuilder [
	<gtExample>
	| aBuilder aPackage |
	aBuilder := DiCollectionToClassBuilder new.
	aPackage := self dummyPackage.
	aBuilder package: aPackage.
	aBuilder modelClassPrefix: 'Dummy'.
	self assert: aBuilder package equals: aPackage.
	self assert: aBuilder modelClassPrefix equals: 'Dummy'.
	^ aBuilder
]

{ #category : #'model builder' }
DiExamples >> removeDummyPackage [
	| aPackageName aPackageOrNil anOrganizer |
	aPackageName := self dummyPackageName.
	anOrganizer := RPackageOrganizer default.
	aPackageOrNil := anOrganizer unregisterPackageNamed: aPackageName.
	^ aPackageOrNil
]

{ #category : #'writing - meta model' }
DiExamples >> writeMetaCollection [
	<gtExample>
	<noTest>
	| aJson anObject |
	anObject := self metaCollection.
	aJson := self mapping write: anObject mappedTo: #metaCollectionMappingFor:.
	self assert: aJson equals: self metaCollectionJsonString.
	^ anObject
]

{ #category : #'writing - meta model' }
DiExamples >> writeMetaFieldOfName [
	<gtExample>
	<noTest>
	| aJson anObject |
	anObject := self metaFieldOfName.
	aJson := self mapping write: anObject mappedTo: #metaFieldMappingFor:.
	self assert: aJson equals: self metaFieldOfNameJsonString.
	^ aJson
]
