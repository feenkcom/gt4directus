"
I interate over all models (classes) in a ${method:DiMarkDeprecatedModelClassesExtension>>#targetEnvironment}$ target environment and I mark any of the existing models as deprecated if they are not present in a new model build.

I override the ${method:Class>>#isDeprecated}$ method to do so. In other words, I add a ==isDeprecated== class-side method that returns ==true== or ==false==.

!! Example

Using the following company meta-model: ${example:DiCollectionToModelBuilderExamples>>#collectionsAndRelationsWithCountryAndCompany|codeExpanded=false|previewExpanded=true}$

I build the following country class-side model (see local methods):
${example:DiCollectionToModelBuilderExamples>>#buildFullModelWithDeprecatedCountry_ClassSideCountryBehavior|codeExpanded=false|previewExpanded=true}$

And I build the following company class-side model (see local methods):
${example:DiCollectionToModelBuilderExamples>>#buildFullModelWithDeprecatedCountry_ClassSideCompanyBehavior|codeExpanded=false|previewExpanded=true}$

Here you can browse the full model where you can find the country method as a package extension:
${example:DiCollectionToModelBuilderExamples>>#buildFullModelWithDeprecatedCountry|codeExpanded=false|previewExpanded=true}$


"
Class {
	#name : #DiMarkDeprecatedModelClassesExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#instVars : [
		'targetEnvironment'
	],
	#category : #'GToolkit4DirectusRing2-Model Builder Extensions'
}

{ #category : #building }
DiMarkDeprecatedModelClassesExtension >> build [
	"do nothing"
	| aRootModel aRealClass allModelNames |
	aRootModel := self modelRootClass.
	aRealClass := self targetEnvironment gtBehaviorNamed: aRootModel name asSymbol ifAbsent: [ ^ self ].
	allModelNames := self allModelNames.
	aRealClass allSubclassesDo: [ :eachClass | 
		self markModel: eachClass asDeprecated: ((allModelNames includes: eachClass name) not)].
]

{ #category : #defaults }
DiMarkDeprecatedModelClassesExtension >> defaultTargetEnvironment [
	^ self class environment
]

{ #category : #initialization }
DiMarkDeprecatedModelClassesExtension >> initialize [
	super initialize.
	targetEnvironment := self defaultTargetEnvironment.
]

{ #category : #building }
DiMarkDeprecatedModelClassesExtension >> markModel: aRealClass asDeprecated: isDeprecated [
	| aClass aSourceCode aMethod aPackage |
	aClass := self builder ensureClassAndMetaClassNamed: aRealClass name.
	aSourceCode := 'isDeprecated', String cr, String tab, '^ ', (isDeprecated asString). 
	aMethod := self modelBuilder 
		ensureLocalMethodNamed: 'isDeprecated'
		withSourceCode: aSourceCode 
		andProtocol: self naming accessorProtocolName
		inBehavior: aClass classSide.
	aPackage := self builder modelPackage.
	aMethod package: aPackage.
]

{ #category : #accessing }
DiMarkDeprecatedModelClassesExtension >> targetEnvironment [
	<return: 	#SystemDictionary>
	^ targetEnvironment
]

{ #category : #accessing }
DiMarkDeprecatedModelClassesExtension >> targetEnvironment: anEnvironment [
	self 
		assert: [ anEnvironment isNotNil ] 
		description: [ 'The target environment must be non-nil' ].
	targetEnvironment := anEnvironment
]
