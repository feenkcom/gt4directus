Class {
	#name : #DiModelExporter,
	#superclass : #DiCollectionToModelBuilderExtension,
	#instVars : [
		'stream',
		'modelClassPrefix'
	],
	#category : #'GToolkit4DirectusRing2-Exporters'
}

{ #category : #exporting }
DiModelExporter >> build [
	self onTempStreamDo: [ 
		self convertRootClass: (DiMetaCollection new name: self modelRootClassName).
		self includedCollectionsDo: [ :aMetaCollection | 
			self convertClass: aMetaCollection.
		]
	].
]

{ #category : #accessing }
DiModelExporter >> contents [
	^ stream contents.
]

{ #category : #writing }
DiModelExporter >> convertClass: aClass [
	self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
DiModelExporter >> convertRootClass: aRootClass [
	self subclassResponsibility.
]

{ #category : #exporting }
DiModelExporter >> export: builder [
	^ self onTempStreamDo: [ 
		self convertRootClass: builder modelRootClass.
		stream newlines: 2.
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

{ #category : #testing }
DiModelExporter >> isSourceCodeGenerator [
	"This is kind of hack as we do not have a ${class:DiModelBuilder}$ for other languages at this moment."
	<return: #Boolean>
	^ true
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
	self subclassResponsibility.
]
