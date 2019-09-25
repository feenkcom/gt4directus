Class {
	#name : #DiRing2ModelBuilder,
	#superclass : #DiModelBuilder,
	#instVars : [
		'ringEnvironment'
	],
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #cleaning }
DiRing2ModelBuilder >> clean [
	self ensureObjectAsSuperclass.
	self ringEnvironment clean.
]

{ #category : #model }
DiRing2ModelBuilder >> ensureAllBehaviorsWithPackageNamed: aString [
	<return: #RGPackageDefinition>
	| aPackage |
	aPackage := self ensurePackageNamed: aString.
	self ringEnvironment behaviorsDo: [ :eachBehavior | 
		self ensurePackage: aPackage forBehavior: eachBehavior ].
	^ aPackage
]

{ #category : #model }
DiRing2ModelBuilder >> ensureClassAndMetaClassNamed: aString [
	<return: #RGClass>
	| aClass |
	self 
		assert: [ aString isNotNil and: [ aString isNotEmpty and: [ aString isString ] ] ] 
		description: [ 'Class names must be non-nil and non-empty string' ].
	self 
		assert: [ (aString endsWith: ' class') not ] 
		description: [ 'Only class name is permitted (without ''class'' part)' ].
	aClass := self ensureClassNamed: aString.
	self ensureClassNamed: aString, ' class'.
	^ aClass
]

{ #category : #model }
DiRing2ModelBuilder >> ensureClassNamed: aString [
	<return: #RGClass or: #RGMetaClass>
	self 
		assert: [ aString isNotNil and: [ aString isNotEmpty ] ] 
		description: [ 'Class names must be non-nil and non-empty string' ].
	^ self ringEnvironment ensureClassNamed: aString
]

{ #category : #model }
DiRing2ModelBuilder >> ensureObject [
	<return: #RGClass>
	| aClass |
	aClass := self ensureClassNamed: 'Object'.
	^ aClass
]

{ #category : #model }
DiRing2ModelBuilder >> ensureObject: anObjectRGBehavior asSuperClassFor: aRGBehavior [
	anObjectRGBehavior == aRGBehavior ifTrue: [ ^ self ].
	aRGBehavior hasResolvedSuperclass ifTrue: [ ^ self ].
	aRGBehavior behaviorStrategy isClass ifFalse: [ ^ self ].
	aRGBehavior isRingResolved ifFalse: [ ^ self ].
	
	aRGBehavior superclass: anObjectRGBehavior
]

{ #category : #model }
DiRing2ModelBuilder >> ensureObjectAsSuperclass [
	| anObject |
	anObject := self ensureObject.
	self ringEnvironment behaviorsDo: [ :eachBehavior | 
		self ensureObject: anObject asSuperClassFor: eachBehavior ]
]

{ #category : #model }
DiRing2ModelBuilder >> ensurePackage: aPackage forBehavior: aRGBehavior [
	aRGBehavior isRingResolved ifFalse: [ ^ self ].
	aRGBehavior package isRingResolved ifTrue: [ ^ self ].
	aRGBehavior superclass isRingResolved ifFalse: [ ^ self ].
	aRGBehavior package: aPackage
]

{ #category : #model }
DiRing2ModelBuilder >> ensurePackageNamed: aString [
	<return: #RGPackageDefinition>
	self 
		assert: [ aString isNotNil and: [ aString isNotEmpty ] ] 
		description: [ 'Package name must be non-nil and non-empty string' ].
	^ self ringEnvironment ensurePackageNamed: aString
]

{ #category : #'gt-extension' }
DiRing2ModelBuilder >> gtBehaviorsFor: aView [
	<gtView>
	self ringEnvironment ifNil: [ ^ aView empty ].
	^ (self ringEnvironment gtBehaviorsFor: aView)
		actionButtonLabel: 'Install' action: [ :aBrTab | self installPackages ]
]

{ #category : #'gt-extension' }
DiRing2ModelBuilder >> gtPackagesFor: aView [
	<gtView>
	self ringEnvironment ifNil: [ ^ aView empty ].
	^ (self ringEnvironment gtPackagesFor: aView)
		actionButtonLabel: 'Install' action: [ :aBrTab | self installPackages ]
]

{ #category : #initialization }
DiRing2ModelBuilder >> initialize [
	super initialize.
	self initializeRingEnvironment
]

{ #category : #initialization }
DiRing2ModelBuilder >> initializeRingEnvironment [
	ringEnvironment := RGEnvironment named: 'Directus Model Environment'.
]

{ #category : #installing }
DiRing2ModelBuilder >> installPackage: aPackage [
	aPackage isRingResolved ifFalse: [ ^ self ].
	aPackage asMCSnapshot install 
]

{ #category : #installing }
DiRing2ModelBuilder >> installPackages [
	self ringEnvironment packagesDo: [ :eachPackage | 
		self installPackage: eachPackage ] 
]

{ #category : #accessing }
DiRing2ModelBuilder >> ringEnvironment [
	<return: #RGEnvironment>
	^ ringEnvironment
]

{ #category : #accessing }
DiRing2ModelBuilder >> ringEnvironment: aRGEnvironment [
	self 
		assert: [ aRGEnvironment isNotNil ] 
		description: [ 'Ring Environment must be non-nil' ].
	^ ringEnvironment := RGEnvironment new.
]
