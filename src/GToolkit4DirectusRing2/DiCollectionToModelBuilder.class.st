Class {
	#name : #DiCollectionToModelBuilder,
	#superclass : #Object,
	#instVars : [
		'namingStrategy',
		'extensions',
		'metaModel',
		'modelBuilder',
		'packageName',
		'modelClassPrefix'
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
	| aClassName aClass aPackage |
	aClassName := self naming collectionModelName: aDiMetaCollection.
	aClass := self modelBuilder ensureClassNamed: aClassName.
	aPackage := self modelBuilder ensurePackageNamed: self packageName.
	aClass package: aPackage.
	
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

{ #category : #accessing }
DiCollectionToModelBuilder >> extensions [
	^ extensions
]

{ #category : #accessing }
DiCollectionToModelBuilder >> gtBehaviorsFor: aView [
	<gtView>
	self modelBuilder ifNil: [ ^ aView empty ].
	^ (self modelBuilder gtBehaviorsFor: aView)
]

{ #category : #accessing }
DiCollectionToModelBuilder >> gtPackagesFor: aView [
	<gtView>
	self modelBuilder ifNil: [ ^ aView empty ].
	^ (self modelBuilder gtPackagesFor: aView)
]

{ #category : #initialization }
DiCollectionToModelBuilder >> initialize [
	super initialize.
	self initializeModelBuilder.
	self initializeNamingStrategy.
	packageName := 'UninitializedDummyPackage'.
	modelClassPrefix := ''.
	extensions := OrderedCollection new.

]

{ #category : #initialization }
DiCollectionToModelBuilder >> initializeModelBuilder [
	modelBuilder := DiModelBuilder ring2.
]

{ #category : #initialization }
DiCollectionToModelBuilder >> initializeNamingStrategy [
	self naming: DiCamelNamingStrategy new.
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

{ #category : #initialization }
DiCollectionToModelBuilder >> useInstanceVariableAccessorsBuilder [
	self addExtension: DiInstanceVariablesAccessorsBuilderExtension new.
]

{ #category : #initialization }
DiCollectionToModelBuilder >> useInstanceVariableBuilder [
	self addExtension: DiInstanceVariablesBuilderExtension new.
]
