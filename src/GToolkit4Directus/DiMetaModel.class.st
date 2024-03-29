"
I am an abstract and root class for all Editorial Services model objects. 
The root meta model class is {{gtClass:DiMetaCollections}}.

See my subclasses for more detials: {{gtClass:DiMetaModel|expanded=true|show=gtSubclassesFor:|height=200}}


"
Class {
	#name : #DiMetaModel,
	#superclass : #Object,
	#instVars : [
		'modelBuilder'
	],
	#category : 'GToolkit4Directus-Meta Model'
}

{ #category : #testing }
DiMetaModel >> isSuccess [
	"Polymorphic to ${method:ZnResponse>>#isSuccess}$.
	This is likely not an optimal solution."
	^ true
]

{ #category : #accessing }
DiMetaModel >> modelBuilder [
	^ modelBuilder
]

{ #category : #accessing }
DiMetaModel >> modelBuilder: anObject [
	modelBuilder := anObject
]
