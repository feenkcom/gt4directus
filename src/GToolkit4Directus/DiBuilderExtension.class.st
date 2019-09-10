Class {
	#name : #DiBuilderExtension,
	#superclass : #Object,
	#instVars : [
		'builder'
	],
	#category : #'GToolkit4Directus-Builder'
}

{ #category : #building }
DiBuilderExtension >> build [
	self subclassResponsibility
]

{ #category : #accessing }
DiBuilderExtension >> builder [
	^ builder
]

{ #category : #accessing }
DiBuilderExtension >> builder: anObject [
	builder := anObject
]
