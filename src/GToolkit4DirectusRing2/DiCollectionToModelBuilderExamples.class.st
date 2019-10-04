Class {
	#name : #DiCollectionToModelBuilderExamples,
	#superclass : #Object,
	#instVars : [
		'metaModelExamples'
	],
	#category : #'GToolkit4DirectusRing2-Examples'
}

{ #category : #'examples - ring2 builder' }
DiCollectionToModelBuilderExamples >> basicCollectionToModelBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := DiCollectionToModelBuilder new.
	self assert: aBuilder modelBuilder isNotNil.
	self assert: aBuilder modelBuilder class equals: DiRing2ModelBuilder.
	self assert: aBuilder packageName isString.
	self assert: aBuilder modelClassPrefix isString.
	^ aBuilder
]

{ #category : #'examples - filtered model' }
DiCollectionToModelBuilderExamples >> buildFilteredModelWithInstanceAndAccessorsVariables [
	<gtExample>
	| aBuilder aModelClass |
	aBuilder := self collectionToModelBuilderWithSubsidiaryCompaniesFieldMetaModel.
	aBuilder useInstanceVariableBuilder.
	aBuilder useInstanceVariableAccessorsBuilder.
	aBuilder excludeCollectionNamed: 'company' fieldNamed: 'subsidiary_companies'.
	aBuilder build.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
	self assert: aModelClass instVarNames size equals: 3.
	self assert: aModelClass localMethods size equals: 6.
	^ aBuilder
]

{ #category : #'examples - filtered model' }
DiCollectionToModelBuilderExamples >> buildFilteredModelWithInstanceAndAccessorsVariables_Behavior [
	<gtExample>
	| aBuilder |
	aBuilder := self buildFilteredModelWithInstanceAndAccessorsVariables.
	^ aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
]

{ #category : #'examples - filtered model' }
DiCollectionToModelBuilderExamples >> buildFilteredModelWithoutCountry [
	<gtExample>
	| aBuilder aModelClass |
	aBuilder := self collectionToModelBuilderWithCountryAndCompany.
	aBuilder useInstanceVariableBuilder.
	aBuilder useInstanceVariableAccessorsBuilder.
	aBuilder excludeCollections: #( 'country' ).
	aBuilder build.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Country'.
	self assert: aModelClass isNil.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
	self assert: aModelClass instVarNames size equals: 4.
	self assert: aModelClass localMethods size equals: 8.
	^ aBuilder
]

{ #category : #'examples - filtered model' }
DiCollectionToModelBuilderExamples >> buildFilteredModelWithoutCountry_Behavior [
	<gtExample>
	| aBuilder |
	aBuilder := self buildFilteredModelWithoutCountry.
	^ aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
]

{ #category : #'examples - filtered model' }
DiCollectionToModelBuilderExamples >> buildFilteredModelWithoutCountry_Unfiltered [
	<gtExample>
	| aBuilder aModelClass |
	aBuilder := self collectionToModelBuilderWithCountryAndCompany.
	aBuilder useInstanceVariableBuilder.
	aBuilder useInstanceVariableAccessorsBuilder.
	aBuilder build.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Country'.
	self assert: aModelClass isNotNil.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
	self assert: aModelClass instVarNames size equals: 5.
	self assert: aModelClass localMethods size equals: 10.
	^ aBuilder
]

{ #category : #'examples - filtered model' }
DiCollectionToModelBuilderExamples >> buildFilteredModelWithoutSystemFields [
	<gtExample>
	| aBuilder aModelClass |
	aBuilder := self collectionToModelBuilderWithCountryAndCompanyAndSystemFields.
	aBuilder useInstanceVariableBuilder.
	aBuilder useInstanceVariableAccessorsBuilder.
	aBuilder excludeSystemFields.
	aBuilder build.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
	self assert: aModelClass instVarNames size equals: 5.
	self assert: aModelClass localMethods size equals: 10.
	^ aBuilder
]

{ #category : #'examples - filtered model' }
DiCollectionToModelBuilderExamples >> buildFilteredModelWithoutSystemFields_Behavior [
	<gtExample>
	| aBuilder |
	aBuilder := self buildFilteredModelWithoutSystemFields.
	aBuilder useInstanceVariableBuilder.
	aBuilder useInstanceVariableAccessorsBuilder.
	aBuilder excludeSystemFields.
	aBuilder build.
	^ aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
]

{ #category : #'examples - filtered model' }
DiCollectionToModelBuilderExamples >> buildFilteredModelWithoutSystemFields_Unfiltered [
	<gtExample>
	| aBuilder aModelClass |
	aBuilder := self collectionToModelBuilderWithCountryAndCompanyAndSystemFields.
	aBuilder useInstanceVariableBuilder.
	aBuilder useInstanceVariableAccessorsBuilder.
	aBuilder build.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
	self assert: aModelClass instVarNames size equals: 5 + DiMetaField systemFieldNames size.
	self assert: aModelClass localMethods size equals: 10 + (2 * DiMetaField systemFieldNames size).
	^ aBuilder
]

{ #category : #'examples - filtered model' }
DiCollectionToModelBuilderExamples >> buildFilteredModelWithoutSystemFields_Unfiltered_Behavior [
	<gtExample>
	| aBuilder |
	aBuilder := self buildFilteredModelWithoutSystemFields_Unfiltered.
	^ aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
]

{ #category : #'examples - full model' }
DiCollectionToModelBuilderExamples >> buildFullModelClassesOnly [
	<gtExample>
	| aBuilder aModelClass |
	aBuilder := self collectionToModelBuilderWithCompanyMetaModel.
	aBuilder build.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
	self assert: aModelClass isNotNil.
	self assert: aModelClass isClass.
	self assert: aModelClass package name equals: self dummyPackageName.
	^ aBuilder
]

{ #category : #'examples - full model' }
DiCollectionToModelBuilderExamples >> buildFullModelClassesOnly_Behavior [
	<gtExample>
	| aBuilder |
	aBuilder := self buildFullModelClassesOnly.
	aBuilder build.
	^ aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
]

{ #category : #'examples - full model' }
DiCollectionToModelBuilderExamples >> buildFullModelWithAllInstanceAndAccessorsVariables [
	<gtExample>
	| aBuilder aModelClass |
	aBuilder := self collectionToModelBuilderWithCompanyMetaModel.
	aBuilder useInstanceVariableBuilder.
	aBuilder useInstanceVariableAccessorsBuilder.
	aBuilder build.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
	self assert: aModelClass instVarNames size equals: 3.
	self assert: aModelClass localMethods size equals: 6.
	^ aBuilder
]

{ #category : #'examples - full model' }
DiCollectionToModelBuilderExamples >> buildFullModelWithAllInstanceAndAccessorsVariables_Behavior [
	<gtExample>
	| aBuilder |
	aBuilder := self buildFullModelWithAllInstanceAndAccessorsVariables.
	^ aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
]

{ #category : #'examples - full model' }
DiCollectionToModelBuilderExamples >> buildFullModelWithAllInstanceVariables [
	<gtExample>
	| aBuilder aModelClass |
	aBuilder := self collectionToModelBuilderWithCompanyMetaModel.
	aBuilder useInstanceVariableBuilder.
	aBuilder build.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
	self assert: aModelClass instVarNames size equals: 3.
	^ aBuilder
]

{ #category : #'examples - full model' }
DiCollectionToModelBuilderExamples >> buildFullModelWithAllInstanceVariables_Behavior [
	<gtExample>
	| aBuilder |
	aBuilder := self buildFullModelWithAllInstanceVariables.
	^ aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
]

{ #category : #'examples - full model' }
DiCollectionToModelBuilderExamples >> buildFullModelWithDiscoveredTraits [
	<gtExample>
	| aBuilder aModelClass aCollection |
	aBuilder := self collectionToModelBuilderWithCompanyMetaModel.
	aBuilder discoverCollectionSystemTraits.
	aBuilder build.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
	self assert: aModelClass isNotNil.
	self assert: aModelClass isClass.
	self assert: aModelClass package name equals: self dummyPackageName.
	self assert: aModelClass usedTraits size equals: 1.
	aCollection := aModelClass usedTraits asArray.
	self assert: aCollection first name equals: TDiDummyCompany name.
	^ aBuilder
]

{ #category : #'examples - full model' }
DiCollectionToModelBuilderExamples >> buildFullModelWithTrait [
	<gtExample>
	| aBuilder aModelClass |
	aBuilder := self collectionToModelBuilderWithCompanyMetaModel.
	aBuilder useTrait: TDummyTraitOneExample inCollectionNamed: 'company'.
	aBuilder build.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
	self assert: aModelClass isNotNil.
	self assert: aModelClass isClass.
	self assert: aModelClass package name equals: self dummyPackageName.
	self assert: aModelClass usedTraits size equals: 1.
	self assert: aModelClass usedTraits anyOne name equals: TDummyTraitOneExample name.
	^ aBuilder
]

{ #category : #'examples - full model' }
DiCollectionToModelBuilderExamples >> buildFullModelWithTrait_Behavior [
	<gtExample>
	| aBuilder |
	aBuilder := self buildFullModelWithTrait.
	^ aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
]

{ #category : #'examples - full model' }
DiCollectionToModelBuilderExamples >> buildFullModelWithTwoTraits [
	<gtExample>
	| aBuilder aModelClass aCollection |
	aBuilder := self collectionToModelBuilderWithCompanyMetaModel.
	aBuilder useTrait: TDummyTraitOneExample inCollectionNamed: 'company'.
	aBuilder useTrait: TDummyTraitTwoExample inCollectionNamed: 'company'.
	aBuilder build.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
	self assert: aModelClass isNotNil.
	self assert: aModelClass isClass.
	self assert: aModelClass package name equals: self dummyPackageName.
	self assert: aModelClass usedTraits size equals: 2.
	aCollection := aModelClass usedTraits asArray sort: [ :a :b | a name < b name ].
	self assert: aCollection first name equals: TDummyTraitOneExample name.
	self assert: aCollection second name equals: TDummyTraitTwoExample name.
	^ aBuilder
]

{ #category : #'examples - full model' }
DiCollectionToModelBuilderExamples >> buildFullModelWithTwoTraits_Behavior [
	<gtExample>
	| aBuilder |
	aBuilder := self buildFullModelWithTwoTraits.
	^ aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
]

{ #category : #'examples - ring2 builder' }
DiCollectionToModelBuilderExamples >> collectionToModelBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := self basicCollectionToModelBuilder.
	aBuilder packageName: self dummyPackageName.
	aBuilder modelClassPrefix: self dummyModelClassPrefix.
	aBuilder modelRootClassName: self dummyModelRootClassName.
	self assert: aBuilder packageName equals: self dummyPackageName.
	self assert: aBuilder modelClassPrefix equals: self dummyModelClassPrefix.
	self assert: aBuilder modelRootClassName equals: self dummyModelRootClassName.
	^ aBuilder
]

{ #category : #'examples - ring2 builder' }
DiCollectionToModelBuilderExamples >> collectionToModelBuilderWithCompanyMetaModel [
	<gtExample>
	| aBuilder |
	aBuilder := self collectionToModelBuilder.
	aBuilder metaModel: self collectionsAndRelationsWithCompany.
	self assert: aBuilder metaModel isNotNil.
	^ aBuilder
]

{ #category : #'examples - ring2 builder' }
DiCollectionToModelBuilderExamples >> collectionToModelBuilderWithCountryAndCompany [
	<gtExample>
	| aBuilder |
	aBuilder := self collectionToModelBuilder.
	aBuilder metaModel: self collectionsAndRelationsWithCountryAndCompany.
	self assert: aBuilder metaModel isNotNil.
	^ aBuilder
]

{ #category : #'examples - ring2 builder' }
DiCollectionToModelBuilderExamples >> collectionToModelBuilderWithCountryAndCompanyAndSystemFields [
	<gtExample>
	| aBuilder |
	aBuilder := self collectionToModelBuilder.
	aBuilder metaModel: self collectionsAndRelationsWithCountryAndCompanyAndSystemFields.
	self assert: aBuilder metaModel isNotNil.
	^ aBuilder
]

{ #category : #'examples - ring2 builder' }
DiCollectionToModelBuilderExamples >> collectionToModelBuilderWithSubsidiaryCompaniesFieldMetaModel [
	<gtExample>
	| aBuilder |
	aBuilder := self collectionToModelBuilder.
	aBuilder metaModel: self collectionsAndRelationsWithSubsidiaryCompaniesField.
	self assert: aBuilder metaModel isNotNil.
	^ aBuilder
]

{ #category : #'examples - meta model' }
DiCollectionToModelBuilderExamples >> collectionsAndRelationsWithCompany [
	<gtExample>
	| aModel |
	aModel := metaModelExamples collectionsAndRelationsWithCompany.
	self assert: aModel isNotNil.
	^ aModel
]

{ #category : #'examples - meta model' }
DiCollectionToModelBuilderExamples >> collectionsAndRelationsWithCountryAndCompany [
	<gtExample>
	| aModel |
	aModel := metaModelExamples collectionsAndRelationsWithCountryAndCompany.
	self assert: aModel isNotNil.
	^ aModel
]

{ #category : #'examples - meta model' }
DiCollectionToModelBuilderExamples >> collectionsAndRelationsWithCountryAndCompanyAndSystemFields [
	<gtExample>
	| aModel |
	aModel := self collectionsAndRelationsWithCountryAndCompany.
	aModel collectionsDo: [ :eachCollection | 
		| anOriginalFieldSize theSystemFields |
		anOriginalFieldSize := eachCollection numberOfFields.
		theSystemFields := DiMetaField systemFieldNames collect: [ :eachFieldName | 
			DiMetaField new
				name: eachFieldName;
				note: 'System field';
				type: (DiMetaFieldType typeNamed: eachFieldName) ].
		eachCollection fields: (eachCollection fields, theSystemFields).
		self assert: eachCollection numberOfFields equals: anOriginalFieldSize + theSystemFields size
	].
	^ aModel
]

{ #category : #'examples - meta model' }
DiCollectionToModelBuilderExamples >> collectionsAndRelationsWithSubsidiaryCompaniesField [
	<gtExample>
	| aModel |
	aModel := metaModelExamples collectionsAndRelationsWithSubsidiaryCompaniesField.
	self assert: aModel isNotNil.
	^ aModel
]

{ #category : #'examples - common names' }
DiCollectionToModelBuilderExamples >> dummyModelClassPrefix [
	^ 'DiDummy'
]

{ #category : #'examples - common names' }
DiCollectionToModelBuilderExamples >> dummyModelRootClassName [
	^ 'DiDummyModel'
]

{ #category : #'examples - common names' }
DiCollectionToModelBuilderExamples >> dummyPackageName [
	^ 'Dummy-Package-For' , self class package name
]

{ #category : #initialization }
DiCollectionToModelBuilderExamples >> initialize [
	super initialize.
	metaModelExamples := DiCompanyMetaModelExamples new.
]
