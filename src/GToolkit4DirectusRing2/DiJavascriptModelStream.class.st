Class {
	#name : #DiJavascriptModelStream,
	#superclass : #Object,
	#instVars : [
		'stream',
		'level'
	],
	#category : #'GToolkit4DirectusRing2-Exporters'
}

{ #category : #writing }
DiJavascriptModelStream >> code: snippet [
	self newlineIndent.
	^ self nextPutAll: snippet.
]

{ #category : #writing }
DiJavascriptModelStream >> contents [
	^ stream contents.	
]

{ #category : #writing }
DiJavascriptModelStream >> curlies: aBlock [
	self nextPut: ${.
	self increaseTabLevel.
	aBlock cull: self.
	self decreaseTabLevel.
	self newline.
	self nextPut: $}.	
]

{ #category : #'as yet unclassified' }
DiJavascriptModelStream >> decreaseTabLevel [
	level := level - 1.
]

{ #category : #'as yet unclassified' }
DiJavascriptModelStream >> increaseTabLevel [
	level := level + 1.
]

{ #category : #'as yet unclassified' }
DiJavascriptModelStream >> initialize [
	level := 0.
	stream := '' writeStream.
]

{ #category : #'as yet unclassified' }
DiJavascriptModelStream >> intialize [
	level := 0.
	stream := '' writeStream.
]

{ #category : #writing }
DiJavascriptModelStream >> newline [
	^ self nextPutAll: String crlf.
]

{ #category : #writing }
DiJavascriptModelStream >> newlineIndent [
	level timesRepeat: [ self nextPut: Character tab ].
]

{ #category : #writing }
DiJavascriptModelStream >> nextPut: character [
	^ stream nextPut: character
]

{ #category : #writing }
DiJavascriptModelStream >> nextPutAll: string [
	^ stream nextPutAll: string
]
