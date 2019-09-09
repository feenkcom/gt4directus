Class {
	#name : #DiManyToOneModelExamples,
	#superclass : #DiCommonExamples,
	#category : #'GToolkit4Directus-Examples'
}

{ #category : #'company - creating class model' }
DiManyToOneModelExamples >> buildCompanyModel [
	<gtExample>
	| aBuilder aModelClass |
	aBuilder := self companyModelClassBuilder.
	aBuilder build.
	aModelClass := self class environment classNamed: 'Dummy2Company'.
	self assert: aModelClass isNotNil.
	self assert: aModelClass isClass.
	self assert: aModelClass selectors size equals: 7.
	^ aModelClass
]

{ #category : #'company - creating class model' }
DiManyToOneModelExamples >> companyModelClassBuilder [
	<gtExample>
	| aMetaCollections aBuilder |
	aMetaCollections := self metaCollectionsOfCompany.
	aBuilder := self modelBuilder.
	aBuilder collections: aMetaCollections.
	self assert: aBuilder collections equals: aMetaCollections.
	^ aBuilder
]

{ #category : #'model builder' }
DiManyToOneModelExamples >> dummyPackage [
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
DiManyToOneModelExamples >> dummyPackageName [
	^ 'Dummy2-Package-For' , self class package name
]

{ #category : #'company - importer' }
DiManyToOneModelExamples >> importCompanyCollectionsWithRelations [
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
	^ aMetaModel
]

{ #category : #'company - importer' }
DiManyToOneModelExamples >> importCompanyMetaModel [
	<gtExample>
	| anImporter aMetaModel aCollection aField |
	anImporter := self importer.
	aMetaModel := anImporter getCollections.
	self assert: aMetaModel isNotNil.
	aCollection := aMetaModel data first.
	aField := aCollection fieldNamed: 'parent_company'.
	self assert: aField type collection isNil.
	self assert: aField type relation isNil.
	aField :=  aCollection fieldNamed: 'name'.
	self assert: aField type name equals: 'String'.
	aField :=  aCollection fieldNamed: 'id'.
	self assert: aField type name equals: 'Integer'.
	^ aMetaModel
]

{ #category : #'company - importer' }
DiManyToOneModelExamples >> importCompanyRelations [
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
DiManyToOneModelExamples >> initializeDelegate [
	super initializeDelegate.
	delegate
		map: '/collections'
		to: [ :aRequest :aResponse | 
			aResponse entity: (ZnEntity json: self metaCollectionsOfCompanyWithParentCompanyJsonString) ];
		map: '/relations'
		to: [ :aRequest :aResponse | 
			aResponse entity: (ZnEntity json: self metaRelationsOfParentCompanyJsonString) ]
]

{ #category : #'company - json data' }
DiManyToOneModelExamples >> metaCollectionOfCompanyWithParentCompanyJsonString [
	^ '{"collection":"company","fields":{',
			'"id":', self metaFieldOfIdJsonString, ',',
			'"name":', self metaFieldOfCompanyNameJsonString, ',',
			'"parent_company":', self metaFieldOfParentCompanyJsonString,
		'},"hidden":false,"icon":"location_city","managed":true,"single":false}'			
]

{ #category : #'company - reading' }
DiManyToOneModelExamples >> metaCollectionsOfCompany [
	<gtExample>
	| aJson anObject |
	aJson := self metaCollectionsOfCompanyWithParentCompanyJsonString.
	anObject := self mapping readCollections: aJson readStream. 
	self assert: anObject class equals: DiMetaCollections.
	self assert: anObject numberOfData equals: 1.
	^ anObject
]

{ #category : #'company - json data' }
DiManyToOneModelExamples >> metaCollectionsOfCompanyWithParentCompanyJsonString [
	^ '{"data":[', self metaCollectionOfCompanyWithParentCompanyJsonString, ']}'
]

{ #category : #'company - json data' }
DiManyToOneModelExamples >> metaCollectionsOfCompanyWithParentCompanyStonJson [
	<gtExample>
	| aString anObject |
	aString := self metaCollectionsOfCompanyWithParentCompanyJsonString.
	anObject := STONJSON fromString: aString.
	self assert: anObject isDictionary.
	self assert: anObject keys size equals: 1.
	self assert: anObject keys first equals: 'data'.
	^ anObject
]

{ #category : #'company - json data' }
DiManyToOneModelExamples >> metaRelationOfParentCompanyJsonString [
	^ '{"collection_many":"company","field_many":"parent_company","collection_one":"company"}'
]

{ #category : #'company - json data' }
DiManyToOneModelExamples >> metaRelationsOfParentCompanyJsonString [
	^ '{"data":[', self metaRelationOfParentCompanyJsonString, ']}'			
]

{ #category : #'company - json data' }
DiManyToOneModelExamples >> metaRelationsOfParentCompanyStonJson [
	<gtExample>
	| aString anObject |
	aString := self metaRelationsOfParentCompanyJsonString.
	anObject := STONJSON fromString: aString.
	self assert: anObject isDictionary.
	self assert: anObject keys size equals: 1.
	self assert: anObject keys first equals: 'data'.
	^ anObject
]

{ #category : #'model builder' }
DiManyToOneModelExamples >> modelBuilder [
	<gtExample>
	| aBuilder aPackage |
	aBuilder := DiCollectionToClassBuilder new.
	aPackage := self dummyPackage.
	aBuilder package: aPackage.
	aBuilder modelClassPrefix: 'Dummy2'.
	self assert: aBuilder package equals: aPackage.
	self assert: aBuilder modelClassPrefix equals: 'Dummy2'.
	^ aBuilder
]
