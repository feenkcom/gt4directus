Class {
	#name : #DiModularDirectus,
	#superclass : #DiProtoDirectus,
	#category : #'GToolkit4Directus-Importer'
}

{ #category : #printing }
DiModularDirectus >> printOn: aStream [
	self projectURL ifNil: [ ^ super printOn: aStream ].
	aStream 
		nextPutAll: 'Directus at: ';
		print: self projectURL.
	self isAuthenticated ifTrue: [ 
		aStream nextPutAll: ' (authenticated)' ].
]
