Class {
	#name : #DiMarkDeprecatedModelClassesExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #building }
DiMarkDeprecatedModelClassesExtension >> build [
	"do nothing"
	| aRootModel aRealClass allModelNames |
	aRootModel := self builder modelRootClass.
	aRealClass := self class environment at: aRootModel name asSymbol ifAbsent: [ ^ self ].
	allModelNames := self builder allModelNames.
	aRealClass allSubclassesDo: [ :eachClass | 
		(allModelNames includes: eachClass name) ifFalse: [ 
			self markDeprecatedModelNamed: eachClass name ] ]
]

{ #category : #building }
DiMarkDeprecatedModelClassesExtension >> markDeprecatedModelNamed: aString [ 
	| aClass aSourceCode |
	aClass := self builder ensureClassAndMetaClassNamed: aString.
	aSourceCode := 'isDeprecated', String cr, String tab, '^ true'. 
	self modelBuilder 
		ensureLocalMethodNamed: 'isDeprecated'
		withSourceCode: aSourceCode 
		andProtocol: self naming testingProtocolName
		inBehavior: aClass classSide.
]
