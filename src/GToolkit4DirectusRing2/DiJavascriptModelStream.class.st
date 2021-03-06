Class {
	#name : #DiJavascriptModelStream,
	#superclass : #DiModelStream,
	#instVars : [
		'stream'
	],
	#category : #'GToolkit4DirectusRing2-Exporters'
}

{ #category : #writing }
DiJavascriptModelStream >> code: snippet [
	self newlineIndent.
	^ self nextPutAll: snippet.
]

{ #category : #writing }
DiJavascriptModelStream >> curlies: aBlock [
	self nextPut: ${; increaseTabLevel; newline.
	aBlock cull: self.
	self decreaseTabLevel; code: '}'.
]

{ #category : #writing }
DiJavascriptModelStream >> indent [
	self nextPut: Character tab.
]

{ #category : #writing }
DiJavascriptModelStream >> line: aLine [
	self newlineIndent.
	^ self nextPutAll: aLine; nextPut: $;; newline.
]
