"
I am an abstract and root class for all Editorial Services model objects. 
The root meta model class is ${class:DiMetaCollections}$.

See my subclasses for more detials: ${class:DiMetaModel|expanded=true|show=gtSubclassesFor:|height=200}$


"
Class {
	#name : #DiMetaModel,
	#superclass : #Object,
	#category : #'GToolkit4Directus-Meta Model'
}

{ #category : #testing }
DiMetaModel >> isSuccess [
	"Polymorphic to ${method:ZnResponse>>#isSuccess}$.
	This is likely not an optimal solution."
	^ true
]
