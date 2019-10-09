Class {
	#name : #DiSwiftModelStream,
	#superclass : #DiModelStream,
	#instVars : [
		'stream'
	],
	#category : #'GToolkit4DirectusRing2-Exporters'
}

{ #category : #writing }
DiSwiftModelStream >> code: snippet [
	self newlineIndent.
	^ self nextPutAll: snippet.
]

{ #category : #writing }
DiSwiftModelStream >> curlies: aBlock [
	self nextPut: ${; increaseTabLevel; newline.
	aBlock cull: self.
	self decreaseTabLevel; code: '}'.
]

{ #category : #writing }
DiSwiftModelStream >> indent [
	self nextPut: Character tab.
]

{ #category : #writing }
DiSwiftModelStream >> line: aLine [
	self newlineIndent.
	^ self nextPutAll: aLine; newline.
]
