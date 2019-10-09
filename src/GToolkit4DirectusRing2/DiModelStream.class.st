Class {
	#name : #DiModelStream,
	#superclass : #Object,
	#instVars : [
		'modelStream',
		'level'
	],
	#category : #'GToolkit4DirectusRing2-Exporters'
}

{ #category : #writing }
DiModelStream >> contents [
	^ modelStream contents.	
]

{ #category : #writing }
DiModelStream >> decreaseTabLevel [
	level := level - 1.
]

{ #category : #writing }
DiModelStream >> increaseTabLevel [
	level := level + 1.
]

{ #category : #writing }
DiModelStream >> indent [
	self subclassResponsibility.
]

{ #category : #initialization }
DiModelStream >> initialize [
	modelStream := '' writeStream.
	level := 0.
]

{ #category : #writing }
DiModelStream >> newline [
	^ self nextPutAll: String crlf.
]

{ #category : #writing }
DiModelStream >> newlineIndent [
	level timesRepeat: [ self indent ].
]

{ #category : #writing }
DiModelStream >> newlines: count [
	^ count timesRepeat: [ self newline ].
]

{ #category : #writing }
DiModelStream >> nextPut: character [
	^ modelStream nextPut: character
]

{ #category : #writing }
DiModelStream >> nextPutAll: string [
	^ modelStream nextPutAll: string
]

{ #category : #writing }
DiModelStream >> parantheses: aBlock [
	self nextPut: $(.
	aBlock cull: self.
	self nextPut: $).	
]
