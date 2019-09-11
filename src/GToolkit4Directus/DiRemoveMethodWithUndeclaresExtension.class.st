Class {
	#name : #DiRemoveMethodWithUndeclaresExtension,
	#superclass : #DiCollectionToClassBuilderExtension,
	#category : #'GToolkit4Directus-Builder'
}

{ #category : #building }
DiRemoveMethodWithUndeclaresExtension >> build [
	self builder modelRootClass withAllSubclassesDo: [ :eachClass | 
		eachClass methodDict do: [ :eachCompiledMethod | 
			eachCompiledMethod usesUndeclares ifTrue: [ 
				eachCompiledMethod removeFromSystem ] ] ]
]
