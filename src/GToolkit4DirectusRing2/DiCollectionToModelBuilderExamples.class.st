"
I exemplify {{gtClass:DiCollectionToModelBuilder}}.


"
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
DiCollectionToModelBuilderExamples >> buildFilteredModelWithIncludedCollectionFields [
	<gtExample>
	| aBuilder aModelClass |
	aBuilder := self collectionToModelBuilderWithCountryAndCompany.
	aBuilder useInstanceVariableBuilder.
	aBuilder useInstanceVariableAccessorsBuilder.
	aBuilder excludeCollections: #( 'country' ).
	aBuilder useIncludedFieldsBuilder.
	aBuilder build.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
	self assert: aModelClass instVarNames size equals: 4.
	self assert: aModelClass localMethods size equals: 8.
	self assert: aModelClass classSide instVarNames size equals: 0.
	self assert: aModelClass classSide localMethods size equals: 1.
	self assert: aModelClass classSide localMethods anyOne name equals: 'includedCollectionFields'.
	^ aBuilder
]

{ #category : #'examples - filtered model' }
DiCollectionToModelBuilderExamples >> buildFilteredModelWithIncludedCollectionFields_Behavior [
	<gtExample>
	| aBuilder |
	aBuilder := self buildFilteredModelWithIncludedCollectionFields.
	^ (aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company') classSide.
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
	self assert: aModelClass instVarNames size equals: 4.
	self assert: aModelClass localMethods size equals: 8.
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
DiCollectionToModelBuilderExamples >> buildFilteredModelWithoutCountry_WithRemoveUndeclaredVariables [
	<gtExample>
	| aBuilder aModelClass |
	aBuilder := self collectionToModelBuilderWithCountryAndCompany.
	aBuilder useInstanceVariableBuilder.
	aBuilder useInstanceVariableAccessorsBuilder.
	aBuilder excludeCollections: #( 'country' ).
	aBuilder removeMethodsWithUndeclaredVariables.
	aBuilder build.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Country'.
	self assert: aModelClass isNil.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
	self assert: aModelClass instVarNames size equals: 4.
	self assert: aModelClass localMethods size equals: 8.
	^ aBuilder
]

{ #category : #'examples - filtered model' }
DiCollectionToModelBuilderExamples >> buildFilteredModelWithoutSystemCollections [
	<gtExample>
	| aBuilder aModelClass |
	aBuilder := self collectionToModelBuilderWithCountryAndCompanyAndDirectusUser.
	aBuilder useInstanceVariableBuilder.
	aBuilder useInstanceVariableAccessorsBuilder.
	aBuilder excludeSystemCollections.
	aBuilder build.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
	self assert: aModelClass instVarNames size equals: 5.
	self assert: aModelClass localMethods size equals: 10.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Country'.
	self assert: aModelClass instVarNames size equals: 3.
	self assert: aModelClass localMethods size equals: 6.
	self assert: aBuilder allModelNames size equals: 2.
	^ aBuilder
]

{ #category : #'examples - filtered model' }
DiCollectionToModelBuilderExamples >> buildFilteredModelWithoutSystemCollections_Unfiltered [
	<gtExample>
	| aBuilder aModelClass |
	aBuilder := self collectionToModelBuilderWithCountryAndCompanyAndDirectusUser.
	aBuilder useInstanceVariableBuilder.
	aBuilder useInstanceVariableAccessorsBuilder.
	aBuilder build.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
	self assert: aModelClass instVarNames size equals: 5.
	self assert: aModelClass localMethods size equals: 10.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Country'.
	self assert: aModelClass instVarNames size equals: 3.
	self assert: aModelClass localMethods size equals: 6.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'DirectusUser'.
	self assert: aModelClass instVarNames size equals: 2.
	self assert: aModelClass localMethods size equals: 4.
	self assert: aBuilder allModelNames size equals: 3.
	^ aBuilder
]

{ #category : #'examples - filtered model' }
DiCollectionToModelBuilderExamples >> buildFilteredModelWithoutSystemCollections_Unfiltered_Behavior [
	<gtExample>
	| aBuilder |
	aBuilder := self buildFilteredModelWithoutSystemCollections_Unfiltered.
	aBuilder useInstanceVariableBuilder.
	aBuilder useInstanceVariableAccessorsBuilder.
	aBuilder build.
	^ aBuilder behaviorNamed: self dummyModelClassPrefix, 'DirectusUser'.
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
DiCollectionToModelBuilderExamples >> buildFullModelWithClassComment [
	<gtExample>
	| aBuilder aModelClass |
	aBuilder := self collectionToModelBuilderWithCompanyMetaModel.
	aBuilder addClassComments.
	aBuilder build.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
	self assert: aModelClass isNotNil.
	self assert: aModelClass comment content isNotNil.
	self assert: aModelClass comment content isNotEmpty.
	^ aBuilder
]

{ #category : #'examples - full model' }
DiCollectionToModelBuilderExamples >> buildFullModelWithClassComment_Behavior [
	<gtExample>
	| aBuilder |
	aBuilder := self buildFullModelWithClassComment.
	^ aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
]

{ #category : #'examples - full model' }
DiCollectionToModelBuilderExamples >> buildFullModelWithDeprecatedCountry [
	<gtExample>
	| aTargetEnvironmentBuilder aBuilder aModelClass aTargetEnvironment |
	aTargetEnvironmentBuilder := self collectionToModelBuilderWithCountryAndCompany.
	aTargetEnvironmentBuilder build.
	aTargetEnvironment := aTargetEnvironmentBuilder modelBuilder ringEnvironment.
	aBuilder := self collectionToModelBuilderWithCountryAndCompany.
	aBuilder excludeCollections: #( 'country' ).
	aBuilder addExtension: (DiMarkDeprecatedModelClassesExtension new targetEnvironment: aTargetEnvironment).
	aBuilder build.
	self assert: aBuilder allModelNames size equals: 1.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
	self assert: aModelClass classSide instVarNames size equals: 0.
	self assert: aModelClass classSide localMethods size equals: 1.
	self assert: aModelClass classSide localMethods anyOne name equals: 'isDeprecated'.
	self assert: aModelClass classSide localMethods anyOne sourceCode equals: 'isDeprecated', String cr, String tab, '^ false'.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Country'.
	self assert: aModelClass classSide instVarNames size equals: 0.
	self assert: aModelClass classSide localMethods size equals: 1.
	self assert: aModelClass classSide localMethods anyOne name equals: 'isDeprecated'.
	self assert: aModelClass classSide localMethods anyOne sourceCode equals: 'isDeprecated', String cr, String tab, '^ true'.
	^ aBuilder
]

{ #category : #'examples - full model' }
DiCollectionToModelBuilderExamples >> buildFullModelWithDeprecatedCountry_ClassSideCompanyBehavior [
	<gtExample>
	| aBuilder |
	aBuilder := self buildFullModelWithDeprecatedCountry.
	^ (aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company') classSide.
]

{ #category : #'examples - full model' }
DiCollectionToModelBuilderExamples >> buildFullModelWithDeprecatedCountry_ClassSideCountryBehavior [
	<gtExample>
	| aBuilder |
	aBuilder := self buildFullModelWithDeprecatedCountry.
	^ (aBuilder behaviorNamed: self dummyModelClassPrefix, 'Country') classSide.
]

{ #category : #'examples - full model' }
DiCollectionToModelBuilderExamples >> buildFullModelWithDiscoveredTraits [
	<gtExample>
	| aBuilder aModelClass |
	aBuilder := self collectionToModelBuilderWithCompanyMetaModel.
	aBuilder discoverCollectionSystemTraits.
	aBuilder build.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
	self assert: aModelClass isNotNil.
	self assert: aModelClass isClass.
	self assert: aModelClass package name equals: self dummyPackageName.
	self assert: aModelClass usedTraits size equals: 1.
	self assert: aModelClass usedTraits anyOne name equals: TDiDummyCompany name.
	^ aBuilder
]

{ #category : #'examples - full model' }
DiCollectionToModelBuilderExamples >> buildFullModelWithDiscoveredTraits_Behavior [
	<gtExample>
	| aBuilder |
	aBuilder := self buildFullModelWithDiscoveredTraits.
	^ aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
]

{ #category : #'examples - full model' }
DiCollectionToModelBuilderExamples >> buildFullModelWithJsonMapping [
	<gtExample>
	| aBuilder aModelClass |
	aBuilder := self collectionToModelBuilderWithCompanyMetaModel.
	aBuilder useInstanceVariableBuilder.
	aBuilder useInstanceVariableAccessorsBuilder.
	aBuilder useJsonMappingBuilder.
	aBuilder build.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'JsonMapping'.
	self assert: aModelClass instVarNames size equals: 0.
	self assert: aModelClass localMethods size equals: 9.
	^ aBuilder
]

{ #category : #'examples - full model' }
DiCollectionToModelBuilderExamples >> buildFullModelWithJsonMapping_Behavior [
	<gtExample>
	| aBuilder |
	aBuilder := self buildFullModelWithJsonMapping.
	^ aBuilder behaviorNamed: self dummyModelClassPrefix, 'JsonMapping'.
]

{ #category : #'examples - full model' }
DiCollectionToModelBuilderExamples >> buildFullModelWithPrintOnMethod [
	<gtExample>
	| aBuilder aModelClass |
	aBuilder := self collectionToModelBuilderWithCompanyMetaModel.
	aBuilder usePrintOnWithNameExtension.
	aBuilder build.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
	self assert: aModelClass isNotNil.
	self assert: (aModelClass localMethods anySatisfy: [ :eachMethod | eachMethod name = 'printOn:' ]).
	^ aBuilder
]

{ #category : #'examples - full model' }
DiCollectionToModelBuilderExamples >> buildFullModelWithPrintOnMethod_Behavior [
	<gtExample>
	| aBuilder |
	aBuilder := self buildFullModelWithPrintOnMethod.
	^ aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
]

{ #category : #'examples - full model' }
DiCollectionToModelBuilderExamples >> buildFullModelWithTrait [
	<gtExample>
	| aBuilder aModelClass |
	aBuilder := self collectionToModelBuilderWithCompanyMetaModel.
	aBuilder useTrait: TDiDummyTraitOneExample inCollectionNamed: 'company'.
	aBuilder build.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
	self assert: aModelClass isNotNil.
	self assert: aModelClass isClass.
	self assert: aModelClass package name equals: self dummyPackageName.
	self assert: aModelClass usedTraits size equals: 1.
	self assert: aModelClass usedTraits anyOne name equals: TDiDummyTraitOneExample name.
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
	aBuilder useTrait: TDiDummyTraitOneExample inCollectionNamed: 'company'.
	aBuilder useTrait: TDiDummyTraitTwoExample inCollectionNamed: 'company'.
	aBuilder build.
	aModelClass := aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
	self assert: aModelClass isNotNil.
	self assert: aModelClass isClass.
	self assert: aModelClass package name equals: self dummyPackageName.
	self assert: aModelClass usedTraits size equals: 2.
	aCollection := aModelClass usedTraits asArray sort: [ :a :b | a name < b name ].
	self assert: aCollection first name equals: TDiDummyTraitOneExample name.
	self assert: aCollection second name equals: TDiDummyTraitTwoExample name.
	^ aBuilder
]

{ #category : #'examples - full model' }
DiCollectionToModelBuilderExamples >> buildFullModelWithTwoTraits_Behavior [
	<gtExample>
	| aBuilder |
	aBuilder := self buildFullModelWithTwoTraits.
	^ aBuilder behaviorNamed: self dummyModelClassPrefix, 'Company'.
]

{ #category : #'examples - full model' }
DiCollectionToModelBuilderExamples >> buildFullModelWithUserDataMethod [
	<gtExample>
	| aBuilder aModelClass |
	aBuilder := self collectionToModelBuilderWithCompanyMetaModel.
	aBuilder useUserDataExtension.
	aBuilder build.
	aModelClass := aBuilder modelRootClass.
	self assert: aModelClass isNotNil.
	self assert: aModelClass isClass.
	self assert: aModelClass package name equals: self dummyPackageName.
	self assert: (aModelClass instVarNames includes: 'userData').
	self assert: (aModelClass localMethods anySatisfy: [ :eachMethod | eachMethod name = 'userData' ]).
	^ aBuilder
]

{ #category : #'examples - full model' }
DiCollectionToModelBuilderExamples >> buildFullModelWithUserDataMethod_Behavior [
	<gtExample>
	| aBuilder |
	aBuilder := self buildFullModelWithUserDataMethod.
	aBuilder useUserDataExtension.
	aBuilder build.
	^ aBuilder modelRootClass
]

{ #category : #'examples - ring2 builder' }
DiCollectionToModelBuilderExamples >> collectionToModelBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := self basicCollectionToModelBuilder.
	aBuilder packageName: self dummyPackageName.
	aBuilder modelClassPrefix: self dummyModelClassPrefix.
	aBuilder modelRootClassName: self dummyModelRootClassName.
	aBuilder usePharoModelBuilder.
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
DiCollectionToModelBuilderExamples >> collectionToModelBuilderWithCountryAndCompanyAndDirectusUser [
	<gtExample>
	| aBuilder |
	aBuilder := self collectionToModelBuilder.
	aBuilder metaModel: self collectionsAndRelationsWithCountryAndCompanyAndDirectusUser.
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
DiCollectionToModelBuilderExamples >> collectionsAndRelationsWithCountryAndCompanyAndDirectusUser [
	<gtExample>
	| aModel |
	aModel := metaModelExamples collectionsAndRelationsWithCountryAndCompanyAndDirectusUser.
	self assert: aModel isNotNil.
	^ aModel
]

{ #category : #'examples - meta model' }
DiCollectionToModelBuilderExamples >> collectionsAndRelationsWithCountryAndCompanyAndSystemFields [
	<gtExample>
	| aModel |
	aModel := metaModelExamples collectionsAndRelationsWithCountryAndCompanyAndSystemFields.
	self assert: aModel isNotNil.
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
