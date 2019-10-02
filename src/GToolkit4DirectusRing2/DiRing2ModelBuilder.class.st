Class {
	#name : #DiRing2ModelBuilder,
	#superclass : #DiModelBuilder,
	#instVars : [
		'ringEnvironment'
	],
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #enumerating }
DiRing2ModelBuilder >> behaviorNamed: aString [ 
	^ self ringEnvironment ask behaviorNamed: aString ifAbsent: nil
]

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
		eachBehavior superclass isRingResolved ifTrue: [ 
			self ensurePackage: aPackage forBehavior: eachBehavior ] ].
	^ aPackage
]

{ #category : #model }
DiRing2ModelBuilder >> ensureClassAndMetaClassNamed: aString [
	<return: #RGClass>
	| anInstaceSide aClassSide |
	self 
		assert: [ aString isNotNil and: [ aString isNotEmpty and: [ aString isString ] ] ] 
		description: [ 'Class names must be non-nil and non-empty string' ].
	self 
		assert: [ (aString endsWith: ' class') not ] 
		description: [ 'Only class name is permitted (without ''class'' part)' ].
	anInstaceSide := self ensureClassNamed: aString.
	aClassSide := self ensureClassNamed: aString, ' class'.

	self assert: [ anInstaceSide isRingResolved ] description: [ 'Instance side class must be resolved' ].
	self 
		assert: [ anInstaceSide name = aString ]
		description: [ 'Instance side class name must be ', aString asString ].

	self assert: [ aClassSide isRingResolved ] description: [ 'Class side must be resolved' ].
	self 
		assert: [ aClassSide name beginsWith: anInstaceSide name ] 
		description: [ 'Class side must start with same name as the instnace side' ].

	self 
		assert: [ anInstaceSide classSide == aClassSide and: [ aClassSide instanceSide == anInstaceSide ] ] 
		description: [ 'Instance side and class side must be consistent' ].
		
	^ anInstaceSide
]

{ #category : #model }
DiRing2ModelBuilder >> ensureClassComment: aString forBehavior: aBRBehavior [
	| aComment |
	aComment := aBRBehavior defaultCommentStubIn: aBRBehavior.
	aComment content: aString.
	aComment name: 'Comment of ', aBRBehavior name. 
	aBRBehavior comment: aComment 
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
DiRing2ModelBuilder >> ensureInstanceVariable: aString inBehavior: aRGBehavior [
	"Return collection of existing behavior instance variables"
	<return: #Array of: #String>
	^ self ensureInstanceVariables: { aString } inBehavior: aRGBehavior
]

{ #category : #model }
DiRing2ModelBuilder >> ensureInstanceVariables: aCollection inBehavior: aRGBehavior [
	"Return collection of existing behavior instance variables"
	<return: #Array of: #String>
	| aNewInstanceVariables aSortedVariables |
	self 
		assert: [ aCollection isCollection ] 
		description: [ 'Instance variables must be a collection' ].
	self 
		assert: [ aRGBehavior isNotNil ] 
		description: [ 'Behavior name must be non-nil' ].
	
	aNewInstanceVariables := aRGBehavior instVarNames union: aCollection.
	aSortedVariables := aNewInstanceVariables sort: [ :a :b | a < b ].
	aRGBehavior instanceVariables: aSortedVariables.
	^ aRGBehavior instVarNames
]

{ #category : #model }
DiRing2ModelBuilder >> ensureLocalMethodNamed: aMethodName withSourceCode: aSourceCode andProtocol: aProtocolName inBehavior: aRGBehavior [
	<return: #RGMethod>
	| aMethod |
	self 
		assert: [ aMethodName isNotNil and: [ aMethodName isString and: [ aMethodName isNotEmpty ] ] ] 
		description: [ 'Method name must be a non-empty string' ].
	self 
		assert: [ aSourceCode isNotNil and: [ aSourceCode isString and: [ aSourceCode isNotEmpty ] ] ] 
		description: [ 'Method source code must be a non-empty string' ].
	self 
		assert: [ aProtocolName isNotNil and: [ aProtocolName isString and: [ aProtocolName isNotEmpty ] ] ] 
		description: [ 'Method protocol name must be a non-empty string' ].
	self 
		assert: [ aRGBehavior isNotNil ] 
		description: [ 'Behavior name must be non-nil' ].
	
	aMethod := aRGBehavior ensureLocalMethodNamed: aMethodName.
	aMethod protocol: aProtocolName.
	aMethod sourceCode: aSourceCode.
	^ aMethod
]

{ #category : #model }
DiRing2ModelBuilder >> ensureObject [
	<return: #RGClass>
	| aClass |
	aClass := self ensureClassAndMetaClassNamed: 'Object'.
	^ aClass
]

{ #category : #model }
DiRing2ModelBuilder >> ensureObject: anObjectRGBehavior asSuperClassFor: aRGBehavior [
	anObjectRGBehavior == aRGBehavior ifTrue: [ ^ self ].
	aRGBehavior hasResolvedSuperclass ifTrue: [ ^ self ].
	aRGBehavior isClass ifFalse: [ ^ self ].
	aRGBehavior isRingResolved ifFalse: [ ^ self ].
	
	aRGBehavior superclass: anObjectRGBehavior.
	aRGBehavior metaclass superclass: anObjectRGBehavior metaclass.
]

{ #category : #model }
DiRing2ModelBuilder >> ensureObjectAsSuperclass [
	| anObject |
	anObject := self ensureObject.
	self ringEnvironment behaviorsDo: [ :eachBehavior | 
		eachBehavior package isRingResolved ifTrue: [
			self ensureObject: anObject asSuperClassFor: eachBehavior ] ]
]

{ #category : #model }
DiRing2ModelBuilder >> ensureObjectAsSuperclassForBehavior: aRGBehavior [
	self ensureObject: self ensureObject asSuperClassFor: aRGBehavior
]

{ #category : #model }
DiRing2ModelBuilder >> ensurePackage: aPackage forBehavior: aRGBehavior [
	aRGBehavior isRingResolved ifFalse: [ ^ self ].
	aRGBehavior package isRingResolved ifTrue: [ ^ self ].
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

{ #category : #model }
DiRing2ModelBuilder >> ensurePackageTagNamed: aPackageTagName forBehavior: aRGBehavior [
	aRGBehavior isRingResolved ifFalse: [ ^ self ].
	aRGBehavior package isRingResolved ifFalse: [ ^ self ].
	aRGBehavior tagWith: aPackageTagName.
]

{ #category : #model }
DiRing2ModelBuilder >> ensureTraitNamed: aString [
	<return: #RGTrait>
	self 
		assert: [ aString isNotNil and: [ aString isNotEmpty ] ] 
		description: [ 'Trait name must be non-nil and non-empty string' ].
	^ self ringEnvironment ensureTraitNamed: aString
]

{ #category : #model }
DiRing2ModelBuilder >> ensureTraitNamed: aTraitName inBehavior: aRGBehavior [
	| aTrait |
	self 
		assert: [ aTraitName isNotNil ] 
		description: [ 'Trait name must be non-nil' ].
	self 
		assert: [ aRGBehavior isNotNil ] 
		description: [ 'Behavior name must be non-nil' ].
		
	(aRGBehavior usedTraits anySatisfy: [ :eachTrait | 
		eachTrait name = aTraitName ]) ifTrue: [ ^ self ].
	aTrait := self ensureTraitNamed: aTraitName.
	aRGBehavior hasTraitComposition 
		ifFalse: [ 
			| aComposition |
			aComposition := aRGBehavior defaultTraitComposition.
			aComposition addTransformation: aTrait.
			aRGBehavior traitComposition: aComposition ]
		ifTrue: [ 
			aRGBehavior traitComposition addTransformation: aTrait ]
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
DiRing2ModelBuilder >> modelEnvironment [
	<return: #RGEnvironment>
	^ self ringEnvironment
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
