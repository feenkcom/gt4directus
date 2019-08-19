"
I communicate with *Directus>https://directus.io* using RESTful API.
You can find the API documentation at *https://docs.directus.io*.

"
Class {
	#name : #DiDirectus,
	#superclass : #DiProtoDirectus,
	#instVars : [
		'email',
		'password'
	],
	#category : #'GToolkit4Directus-Importer'
}

{ #category : #accessing }
DiDirectus >> email [
	^ email
]

{ #category : #accessing }
DiDirectus >> email: anObject [
	email := anObject
]

{ #category : #accessing }
DiDirectus >> password [
	^ password
]

{ #category : #accessing }
DiDirectus >> password: anObject [
	password := anObject
]
