Class {
	#name : #DiRemoveMethodsWithUndeclaredVariablesExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #building }
DiRemoveMethodsWithUndeclaredVariablesExtension >> build [
	"do nothing"
]

{ #category : #building }
DiRemoveMethodsWithUndeclaredVariablesExtension >> postInstall [
	| aRootModel aRealClass |
	aRootModel := self builder modelRootClass.
	aRealClass := self class environment at: aRootModel name asSymbol.
	aRealClass withAllSubclassesDo: [ :eachClass | 
		eachClass methodDict do: [ :eachCompiledMethod | 
			eachCompiledMethod usesUndeclares ifTrue: [ 
				eachCompiledMethod removeFromSystem ] ] ]
]
