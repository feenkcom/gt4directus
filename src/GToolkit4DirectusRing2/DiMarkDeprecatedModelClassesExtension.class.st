Class {
	#name : #DiMarkDeprecatedModelClassesExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #building }
DiMarkDeprecatedModelClassesExtension >> build [
	"do nothing"
	| aRootModel aRealClass allModelNames |
	aRootModel := self modelRootClass.
	aRealClass := self class environment at: aRootModel name asSymbol ifAbsent: [ ^ self ].
	allModelNames := self builder allModelNames.
	aRealClass allSubclassesDo: [ :eachClass | 
		(allModelNames includes: eachClass name) ifFalse: [ 
			self markDeprecatedModel: eachClass ] ]
]

{ #category : #building }
DiMarkDeprecatedModelClassesExtension >> markDeprecatedModel: aRealClass [ 
	| aClass aSourceCode aMethod aPackage |
	aClass := self builder ensureClassAndMetaClassNamed: aRealClass name.
	aSourceCode := 'isDeprecated', String cr, String tab, '^ true'. 
	aMethod := self modelBuilder 
		ensureLocalMethodNamed: 'isDeprecated'
		withSourceCode: aSourceCode 
		andProtocol: self naming accessorProtocolName
		inBehavior: aClass classSide.
	aPackage := self builder modelPackage.
	aMethod package: aPackage.
]
