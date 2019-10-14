Class {
	#name : #DiItemsCommand,
	#superclass : #DiResponseCommand,
	#category : #'GToolkit4Directus-Commands'
}

{ #category : #accessing }
DiItemsCommand class >> endPoint [
	^ #( 'items' )
]

{ #category : #testing }
DiItemsCommand class >> isAbstract [
	^ self name = #DiItemsCommand 
]
