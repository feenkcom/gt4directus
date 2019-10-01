Class {
	#name : #DiCollectionToModelBuilder,
	#superclass : #Object,
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

{ #category : #initialization }
DiCollectionToModelBuilder >> addExtension: anExtension [
	self 
		assert: [ anExtension isNotNil ] 
		description: [ 'The builder extension must be non-nil' ].
	anExtension builder: self.
	self extensions add: anExtension
]

{ #category : #initialization }
DiCollectionToModelBuilder >> addFilter: aFilter [
	self 
		assert: [ aFilter isNotNil ] 
		description: [ 'The builder filter must be non-nil' ].
	aFilter builder: self.
	self filters add: aFilter
]

{ #category : #enumerating }
DiCollectionToModelBuilder >> allModelNames [
	| aSet |
	aSet := Set new.
	self collectionsAndModelsDo: [ :eachCollection :eachClass |
		aSet add: eachClass name ].
	^ aSet
]

{ #category : #enumerating }
DiCollectionToModelBuilder >> behaviorNamed: aString [ 
	^ self modelBuilder behaviorNamed: aString
]

{ #category : #building }
DiCollectionToModelBuilder >> build [
	self buildBehaviors.
	self buildUsingExtensions.
	self modelBuilder clean.
]

{ #category : #building }
DiCollectionToModelBuilder >> buildBehavior: aDiMetaCollection [
	| aClassName aClass aSuperClass |
	(self canIncludeCollection: aDiMetaCollection)
		ifFalse: [ ^ self ].
	aClassName := self naming collectionModelName: aDiMetaCollection.
	aClass := self modelBuilder ensureClassAndMetaClassNamed: aClassName.
	aClass package: self modelPackage.
	aClass tagWith: self packageTagName.
	aSuperClass := self modelRootClass.
	aClass superclass: aSuperClass
]

{ #category : #building }
DiCollectionToModelBuilder >> buildBehaviors [
	self collections do: [ :eachCollection | self buildBehavior: eachCollection ]
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

{ #category : #enumerating }
DiCollectionToModelBuilder >> collectionsAndModelsDo: aBlockClosure [ 
	self collections do: [ :eachCollection | 
		| aClassName eachClass |
		aClassName := self naming collectionModelName: eachCollection.
		eachClass := self modelBuilder behaviorNamed: aClassName.
		eachClass ifNotNil: [ aBlockClosure cull: eachCollection cull: eachClass ]
	]
]

{ #category : #initialization }
DiCollectionToModelBuilder >> discoverCollectionSystemTraits [
	self addExtension: Di2TraitDiscoveryExtension new.
]

{ #category : #model }
DiCollectionToModelBuilder >> ensureClassAndMetaClassNamed: aString [ 
	<return: #RGClass>
	^ self modelBuilder ensureClassAndMetaClassNamed: aString 
]

{ #category : #initialization }
DiCollectionToModelBuilder >> excludeCollectionNamed: aCollectionName fieldNamed: aFieldName [
	self addFilter: (DiExcludeCollectionFieldFilter new collectionName: aCollectionName; fieldName: aFieldName)
]

{ #category : #initialization }
DiCollectionToModelBuilder >> excludeCollections: collectionNames [
	self addFilter: (DiExcludeCollections new collectionNames: collectionNames)
]

{ #category : #initialization }
DiCollectionToModelBuilder >> excludeSystemCollections [
	self addFilter: (DiExcludeSystemCollections new)
]

{ #category : #initialization }
DiCollectionToModelBuilder >> excludeSystemFields [
	self addFilter: (DiExcludeDirectusSystemFieldsFilter new)
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

{ #category : #initialization }
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
		assert: [ aString isNotNil and: [ aString isString and: [ aString isNotEmpty ] ] ] 
		description: [ 'Model class prefix must be a non-empty string' ].
	modelClassPrefix := aString
]

{ #category : #environment }
DiCollectionToModelBuilder >> modelEnvironment [
	<return: #RGEnvironment>
	^ self modelBuilder modelEnvironment 
]

{ #category : #model }
DiCollectionToModelBuilder >> modelPackage [
	^ self modelBuilder ensurePackageNamed: self packageName
]

{ #category : #model }
DiCollectionToModelBuilder >> modelRootClass [
	<return: #RGClass>
	| aClass aSuperClass |
	aClass := self modelBuilder
		ensureClassAndMetaClassNamed: self modelRootClassName.
	aClass package: self modelPackage.
	aClass tagWith: self packageTagName.
	aSuperClass := self modelBuilder ensureObject.
	aClass superclass: aSuperClass.
	aClass metaclass superclass: aSuperClass metaclass.
	
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

{ #category : #initialization }
DiCollectionToModelBuilder >> removeMethodsWithUndeclaredVariables [
	self addExtension: DiRemoveMethodsWithUndeclaredVariablesExtension new.
]

{ #category : #initialization }
DiCollectionToModelBuilder >> useCollectionNameBuilder [
	self addExtension: DiCollectionNameBuilderExtension new.
]

{ #category : #initialization }
DiCollectionToModelBuilder >> useInstanceVariableAccessorsBuilder [
	self addExtension: DiInstanceVariablesAccessorsBuilderExtension new.
]

{ #category : #initialization }
DiCollectionToModelBuilder >> useInstanceVariableBuilder [
	self addExtension: DiInstanceVariablesBuilderExtension new.
]

{ #category : #initialization }
DiCollectionToModelBuilder >> useTrait: aTraitClass inCollectionNamed: aCollectionName [
	self useTraitNamed: aTraitClass name inCollectionNamed: aCollectionName
]

{ #category : #initialization }
DiCollectionToModelBuilder >> useTraitNamed: aTraitName inCollectionNamed: aCollectionName [
	self addExtension: (DiAddTraitExtension new 
		traitClassName: aTraitName; 
		collectionName: aCollectionName)
]
