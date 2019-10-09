Class {
	#name : #DiModelExporter,
	#superclass : #Object,
	#instVars : [
		'stream',
		'modelClassPrefix'
	],
	#category : #'GToolkit4DirectusRing2-Exporters'
}

{ #category : #accessing }
DiModelExporter >> contents [
	^ stream contents.
]

{ #category : #writing }
DiModelExporter >> convertClass: aClass [
	self subclassResponsibility.
]

{ #category : #exporting }
DiModelExporter >> export: builder [
	^ self onTempStreamDo: [ 
		self convertClass: builder modelRootClass.
		builder includedCollectionsAndModelsDo: [ :aMetaCollection :aBehavior | 
			self convertClass: aBehavior.
		]
	].
]

{ #category : #formatting }
DiModelExporter >> for: elements do: aDoBlock separatedBy: aSeparatorBlock [
	| aBeforeFirst | 
	aBeforeFirst := true.
	elements do: [ :anElement | 
		aBeforeFirst
			ifTrue: [ aBeforeFirst := false ]
			ifFalse: [ aSeparatorBlock value ].
		aDoBlock cull: anElement ]
]

{ #category : #accessing }
DiModelExporter >> modelClassPrefix [
	^ modelClassPrefix
]

{ #category : #accessing }
DiModelExporter >> modelClassPrefix: anObject [
	modelClassPrefix := anObject
]

{ #category : #writing }
DiModelExporter >> onTempStreamDo: aBlock [
	stream := DiJavascriptModelStream new.
	aBlock value.
]
