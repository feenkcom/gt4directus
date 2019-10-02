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
		self markDeprecatedModel: eachClass as: ((allModelNames includes: eachClass name) not)].
]

{ #category : #building }
DiMarkDeprecatedModelClassesExtension >> markDeprecatedModel: aRealClass as: isDeprecated [
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
