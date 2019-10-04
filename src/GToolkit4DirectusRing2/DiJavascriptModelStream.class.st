Class {
	#name : #DiJavascriptModelStream,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'GToolkit4DirectusRing2-Exporters'
}

{ #category : #writing }
DiJavascriptModelStream >> nextPut: character [
	^ stream nextPut: character
]

{ #category : #writing }
DiJavascriptModelStream >> nextPutAll: string [
	^ stream nextPutAll: string
]
