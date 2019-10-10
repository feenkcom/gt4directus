"
I build a model based on ${class:DiMetaCollectionsWithRelations}$.

By default, I build a Pharo model (classes, Traits, methods, etc.) using ${class:DiModelBuilder}$ subclasses. 
By default, I use ${class:DiRing2ModelBuilder}$, see ${method:DiCollectionToModelBuilder>>#initializeModelBuilder}$.

!! Example

Using the following company meta-model: ${example:DiCollectionToModelBuilderExamples>>#collectionsAndRelationsWithCompany|codeExpanded=false|previewExpanded=true}$

I generate the following Pharo model: 
${example:DiCollectionToModelBuilderExamples>>#buildFullModelClassesOnly_Behavior|codeExpanded=false|previewExpanded=true}$

Here you can browse the full model:
${example:DiCollectionToModelBuilderExamples>>#buildFullModelClassesOnly|codeExpanded=false|previewExpanded=true}$


By default, I generate only the plain Pharo model (classes only). I can be extended by many ${class:DiCollectionToModelBuilderExtension}$ extensions and ${class:DiCollectionToModelBuilderFilter}$ filters. I also use ${class:DiModelNamingStrategy}$ naming strategy (by default ${class:DiCamelNamingStrategy}$, see ${method:DiCollectionToModelBuilder>>#initializeNamingStrategy}$). 

As an example, the following example shows how to build a Pharo model with instance variables and accessors: 
${example:DiCollectionToModelBuilderExamples>>#buildFullModelWithAllInstanceAndAccessorsVariables|codeExpanded=false|previewExpanded=true}$

!! Extensions

For more extensions see ${class:DiCollectionToModelBuilderExtension|expanded=true|show=gtSubclassesFor:}$:

!! Filteres

For more filteres see ${class:DiCollectionToModelBuilderFilter|expanded=true|show=gtSubclassesFor:}$:


"
Class {
	#name : #DiCollectionToModelBuilder,
	#superclass : #Object,
	#traits : 'TCollectionIterator + TModelBuilder',
	#classTraits : 'TCollectionIterator classTrait + TModelBuilder classTrait',
	#instVars : [
		'namingStrategy',
		'extensions',
		'filters',
		'metaModel',
		'modelBuilder',
		'packageName',
		'packageTagName',
		'modelClassPrefix',
		'modelRootClassName'
	],
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #'initialization - extensions - pharo' }
DiCollectionToModelBuilder >> addClassComments [
	self addExtension: DiAddClassCommentExtension new.
]

{ #category : #'initialization - extensions' }
DiCollectionToModelBuilder >> addExtension: anExtension [
	self 
		assert: [ anExtension isNotNil ] 
		description: [ 'The builder extension must be non-nil' ].
	anExtension builder: self.
	self extensions add: anExtension
]

{ #category : #'initialization - filteres' }
DiCollectionToModelBuilder >> addFilter: aFilter [
	self 
		assert: [ aFilter isNotNil ] 
		description: [ 'The builder filter must be non-nil' ].
	aFilter builder: self.
	self filters add: aFilter
]

{ #category : #building }
DiCollectionToModelBuilder >> build [
	self buildUsingExtensions.
	self modelBuilder clean.
]

{ #category : #building }
DiCollectionToModelBuilder >> buildUsingExtensions [
	self extensions
		do: [ :eachBuilderExtension | eachBuilderExtension build ]
]

{ #category : #filtering }
DiCollectionToModelBuilder >> canIncludeCollection: aDiMetaCollection [
	<return: #Boolean>
	^ self filters allSatisfy: [ :eachFilter | 
		eachFilter canIncludeCollection: aDiMetaCollection ]
]

{ #category : #filtering }
DiCollectionToModelBuilder >> canIncludeCollection: aDiMetaCollection field: aDiMetaField [
	<return: #Boolean>
	^ self filters allSatisfy: [ :eachFilter | 
		eachFilter canIncludeCollection: aDiMetaCollection field: aDiMetaField ]
]

{ #category : #accessing }
DiCollectionToModelBuilder >> collections [
	^ self metaModel collections
]

{ #category : #'initialization - extensions - pharo' }
DiCollectionToModelBuilder >> discoverCollectionSystemTraits [
	self addExtension: DiTraitDiscoveryExtension new.
]

{ #category : #'building - model' }
DiCollectionToModelBuilder >> ensureModelPackageForBehavior: aRGBehavior [
	self modelBuilder ensurePackage: self modelPackage forBehavior: aRGBehavior
]

{ #category : #'building - model' }
DiCollectionToModelBuilder >> ensurePackageAndTagForBehavior: aRGBehavior [
	self modelBuilder ensurePackage: self modelPackage forBehavior: aRGBehavior. 
	self modelBuilder ensurePackageTagNamed: self packageTagName forBehavior: aRGBehavior
]

{ #category : #'initialization - filteres' }
DiCollectionToModelBuilder >> excludeCollectionNamed: aCollectionName fieldNamed: aFieldName [
	self addFilter: (DiExcludeCollectionFieldFilter new collectionName: aCollectionName; fieldName: aFieldName)
]

{ #category : #'initialization - filteres' }
DiCollectionToModelBuilder >> excludeCollections: collectionNames [
	self addFilter: (DiExcludeCollections new collectionNames: collectionNames)
]

{ #category : #'initialization - filteres' }
DiCollectionToModelBuilder >> excludeSystemCollections [
	self addFilter: (DiExcludeSystemCollections new)
]

{ #category : #'initialization - filteres' }
DiCollectionToModelBuilder >> excludeSystemFields [
	self addFilter: (DiExcludeDirectusSystemFieldsFilter new)
]

{ #category : #'accessing - model' }
DiCollectionToModelBuilder >> existingCollectionBehaviorOrNil: aDiMetaCollection [
	| aClassName |
	aClassName := self naming collectionModelName: aDiMetaCollection.
	^ self modelBuilder behaviorNamed: aClassName.
]

{ #category : #building }
DiCollectionToModelBuilder >> exportToJavascript [
	| jsExporter |
	jsExporter := DiModelToJavascriptExporter new
		modelClassPrefix: self modelClassPrefix.
	jsExporter export: self.
	^ jsExporter. 
]

{ #category : #building }
DiCollectionToModelBuilder >> exportToSwift [
	| swiftExporter |
	swiftExporter := DiModelToSwiftExporter new
		modelClassPrefix: self modelClassPrefix.
	swiftExporter export: self.
	^ swiftExporter. 
]

{ #category : #accessing }
DiCollectionToModelBuilder >> extensions [
	^ extensions
]

{ #category : #accessing }
DiCollectionToModelBuilder >> filters [
	^ filters
]

{ #category : #accessing }
DiCollectionToModelBuilder >> gtBehaviorsFor: aView [
	<gtView>
	self modelBuilder ifNil: [ ^ aView empty ].
	^ (self modelBuilder gtBehaviorsFor: aView)
		actionButtonLabel: 'Full Install' action: [ :aBrTab | self install ]
]

{ #category : #accessing }
DiCollectionToModelBuilder >> gtPackagesFor: aView [
	<gtView>
	self modelBuilder ifNil: [ ^ aView empty ].
	^ (self modelBuilder gtPackagesFor: aView)
		actionButtonLabel: 'Full Install' action: [ :aBrTab | self install ]
]

{ #category : #accessing }
DiCollectionToModelBuilder >> gtTreeBehaviorsFor: aView [
	<gtView>
	self modelBuilder ifNil: [ ^ aView empty ].
	^ (self modelBuilder gtTreeBehaviorsFor: aView)
		title: 'Model';
		priority: 0;
		items: [ self hasModels ifTrue: [ { self modelRootClass } ] ifFalse: [ #() ] ];
		actionButtonLabel: 'Full Install' action: [ :aBrTab | self install ]
]

{ #category : #accessing }
DiCollectionToModelBuilder >> gtUMLOfCollectionsFor: aView [
	<gtView>
	self metaModel ifNil: [ ^ aView empty ].
	^ (self metaModel gtUMLFor: aView)
		title: 'Collections';
		priority: 4;
		actionButtonLabel: 'Details' action: [ :aBrTab | 
			aBrTab phlow spawnObject: self metaModel ]
]

{ #category : #initialization }
DiCollectionToModelBuilder >> initialize [
	super initialize.
	self initializeModelBuilder.
	self initializeNamingStrategy.
	packageName := 'UninitializedDummyPackage'.
	packageTagName := 'Model'.
	modelClassPrefix := 'UnitializedPrefix'.
	modelRootClassName := modelClassPrefix, 'Model'.
	extensions := OrderedCollection new.
	filters := OrderedCollection new.

]

{ #category : #initialization }
DiCollectionToModelBuilder >> initializeModelBuilder [
	modelBuilder := DiModelBuilder ring2.
]

{ #category : #initialization }
DiCollectionToModelBuilder >> initializeNamingStrategy [
	self naming: DiCamelNamingStrategy new.
]

{ #category : #building }
DiCollectionToModelBuilder >> install [
	self modelBuilder installPackages.
	self extensions do: #postInstall.
]

{ #category : #'initialization - extensions - pharo' }
DiCollectionToModelBuilder >> markDeprecatedModels [
	self addExtension: DiMarkDeprecatedModelClassesExtension new.
]

{ #category : #accessing }
DiCollectionToModelBuilder >> metaModel [
	<return: #DiMetaCollections>
	^ metaModel
]

{ #category : #accessing }
DiCollectionToModelBuilder >> metaModel: aDiMetaCollections [
	self 
		assert: [ aDiMetaCollections isNotNil ] 
		description: [ 'Meta-model must be non-nil' ].
	metaModel := aDiMetaCollections
]

{ #category : #accessing }
DiCollectionToModelBuilder >> modelBuilder [
	<return: #DiModelBuilder>
	^ modelBuilder
]

{ #category : #accessing }
DiCollectionToModelBuilder >> modelBuilder: aDiModelBuilder [
	self 
		assert: [ aDiModelBuilder isNotNil ] 
		description: [ 'Model builder must be non-nil' ].
	modelBuilder := aDiModelBuilder
]

{ #category : #accessing }
DiCollectionToModelBuilder >> modelClassPrefix [
	<return: #String>
	^ modelClassPrefix
]

{ #category : #accessing }
DiCollectionToModelBuilder >> modelClassPrefix: aString [
	self 
		assert: [ aString isNotNil and: [ aString isString ] ] 
		description: [ 'Model class prefix must be a string' ].
	modelClassPrefix := aString
]

{ #category : #'building - model' }
DiCollectionToModelBuilder >> modelPackage [
	<return: #RGPackageDefinition>
	^ self modelBuilder ensurePackageNamed: self packageName
]

{ #category : #'building - model' }
DiCollectionToModelBuilder >> modelRootClass [
	<return: #RGClass>
	| aClass |
	aClass := self behaviorNamed: self modelRootClassName.
	aClass ifNotNil: [ ^ aClass ].
	aClass := self ensureClassAndMetaClassNamed: self modelRootClassName.
	self ensureObjectAsSuperclassForBehavior: aClass.
	self ensurePackageAndTagForBehavior: aClass.
	
	^ aClass
]

{ #category : #accessing }
DiCollectionToModelBuilder >> modelRootClassName [
	<return: #String>
	^ modelRootClassName
]

{ #category : #accessing }
DiCollectionToModelBuilder >> modelRootClassName: aString [
	self 
		assert: [ aString isNotNil and: [ aString isString and: [ aString isNotEmpty ] ] ] 
		description: [ 'Model root class name must be a non-empty string' ].
	modelRootClassName := aString
]

{ #category : #accessing }
DiCollectionToModelBuilder >> naming [
	<return: #DiModelNamingStrategy>
	^ namingStrategy
]

{ #category : #accessing }
DiCollectionToModelBuilder >> naming: aDiModelNamingStrategy [
	self 
		assert: [ aDiModelNamingStrategy isNotNil ] 
		description: [ 'Naming strategy must be non-nil' ].
	aDiModelNamingStrategy builder: self.
	namingStrategy := aDiModelNamingStrategy
]

{ #category : #accessing }
DiCollectionToModelBuilder >> packageName [
	<return: #String>
	^ packageName
]

{ #category : #accessing }
DiCollectionToModelBuilder >> packageName: aString [
	self 
		assert: [ aString isNotNil and: [ aString isString and: [ aString isNotEmpty ] ] ] 
		description: [ 'Package name must be a non-empty string' ].
	packageName := aString
]

{ #category : #accessing }
DiCollectionToModelBuilder >> packageTagName [
	<return: #String>
	^ packageTagName
]

{ #category : #accessing }
DiCollectionToModelBuilder >> packageTagName: aString [
	self 
		assert: [ aString isNotNil and: [ aString isString and: [ aString isNotEmpty ] ] ] 
		description: [ 'Package tag name must be a non-empty string' ].
	packageTagName := aString
]

{ #category : #'initialization - extensions - pharo' }
DiCollectionToModelBuilder >> removeMethodsWithUndeclaredVariables [
	self addExtension: DiRemoveMethodsWithUndeclaredVariablesExtension new.
]

{ #category : #'initialization - extensions - others' }
DiCollectionToModelBuilder >> sourceCodeGenerator [
	"This is kind of hack as we do not have a ${class:DiModelBuilder}$ for other languages at this moment."
	<return: #DiModelExporter>
	^ self extensions detect: #isSourceCodeGenerator
]

{ #category : #'initialization - extensions - pharo' }
DiCollectionToModelBuilder >> useCollectionNameBuilder [
	self addExtension: DiCollectionNameBuilderExtension new.
]

{ #category : #'initialization - extensions - pharo' }
DiCollectionToModelBuilder >> useIncludedFieldsBuilder [
	self addExtension: DiIncludedFieldsBuilderExtension new.
]

{ #category : #'initialization - extensions - pharo' }
DiCollectionToModelBuilder >> useInstanceVariableAccessorsBuilder [
	self addExtension: DiInstanceVariablesAccessorsBuilderExtension new.
]

{ #category : #'initialization - extensions - pharo' }
DiCollectionToModelBuilder >> useInstanceVariableBuilder [
	self addExtension: DiInstanceVariablesBuilderExtension new.
]

{ #category : #'initialization - extensions - others' }
DiCollectionToModelBuilder >> useJavaScriptGenerator [
	self addExtension: DiModelToJavascriptExporter new.
	self useNullModelBuilder.
]

{ #category : #'initialization - extensions - pharo' }
DiCollectionToModelBuilder >> useJsonMappingBuilder [
	self addExtension: DiJsonMappingModelBuilderExtension new.
]

{ #category : #'initialization - model builder' }
DiCollectionToModelBuilder >> useNullModelBuilder [
	self modelBuilder: DiModelBuilder null.
]

{ #category : #'initialization - extensions - pharo' }
DiCollectionToModelBuilder >> usePharoModelBuilder [
	self addExtension: DiPharoModelBuilderExtension new.
]

{ #category : #'initialization - extensions - pharo' }
DiCollectionToModelBuilder >> usePrintOnWithNameExtension [
	self addExtension: DiPrintOnWithNameExtension new.
]

{ #category : #'initialization - model builder' }
DiCollectionToModelBuilder >> useRing2ModelBuilder [
	self modelBuilder: DiModelBuilder ring2.
]

{ #category : #'initialization - extensions - others' }
DiCollectionToModelBuilder >> useSwiftGenerator [
	self addExtension: DiModelToSwiftExporter new.
	self useNullModelBuilder.
]

{ #category : #'initialization - extensions - pharo' }
DiCollectionToModelBuilder >> useTrait: aTraitClass inCollectionNamed: aCollectionName [
	self useTraitNamed: aTraitClass name inCollectionNamed: aCollectionName
]

{ #category : #'initialization - extensions - pharo' }
DiCollectionToModelBuilder >> useTraitNamed: aTraitName inCollectionNamed: aCollectionName [
	self addExtension: (DiAddTraitExtension new 
		traitClassName: aTraitName; 
		collectionName: aCollectionName)
]

{ #category : #'initialization - extensions - pharo' }
DiCollectionToModelBuilder >> useUserDataExtension [
	self addExtension: DiUserDataExtension new.
]
