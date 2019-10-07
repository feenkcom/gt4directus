"
I remove all existing methods with undeclared variables after a model installation.
In other words, I will clean the newly installed model by removing accessor methods that are no more valid.
See ${method:DiRemoveMethodsWithUndeclaredVariablesExtension>>#postInstall}$.

"
Class {
	#name : #DiRemoveMethodsWithUndeclaredVariablesExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builder Extensions'
}

{ #category : #building }
DiRemoveMethodsWithUndeclaredVariablesExtension >> build [
	"do nothing"
]

{ #category : #building }
DiRemoveMethodsWithUndeclaredVariablesExtension >> postInstall [
	| aRootModel aRealClass |
	aRootModel := self builder modelRootClass.
	aRealClass := self class environment at: aRootModel name asSymbol ifAbsent: [ ^ self ].
	aRealClass withAllSubclassesDo: [ :eachClass | 
		eachClass methodDict copy do: [ :eachCompiledMethod | 
			eachCompiledMethod usesUndeclares ifTrue: [ 
				eachCompiledMethod removeFromSystem ] ] ]
]
