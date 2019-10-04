Class {
	#name : #DiModelToJavascriptExporter,
	#superclass : #Object,
	#instVars : [
		'jsStream'
	],
	#category : #'GToolkit4DirectusRing2-Exporters'
}

{ #category : #writing }
DiModelToJavascriptExporter >> convertClass: aClass [  
	self halt.
	self writeClassDefinitionOf: aClass.
	self writeClassInheritanceOf: aClass.
	self writeClassVariablesDeclarationOf: aClass.
	self writeMethodsOf: aClass.
]

{ #category : #'as yet unclassified' }
DiModelToJavascriptExporter >> export: aModel [
	aModel ringEnvironment ask behaviors do: [ :aBehavior | self convertClass: aBehavior].
]

{ #category : #writing }
DiModelToJavascriptExporter >> onTempStreamDo: aBlock [
	| saveStream |
	saveStream := jsStream.
	jsStream := '' writeStream.
	[
		aBlock value.
		^ jsStream contents
	] ensure: [ jsStream := saveStream ]
]

{ #category : #writing }
DiModelToJavascriptExporter >> writeClassDefinitionOf: aClass [
	jsStream
		nextPutAll: 'class ';
		nextPutAll: aClass name;
		nextPutAll: '{';
		cr
]

{ #category : #writing }
DiModelToJavascriptExporter >> writeClassInheritanceOf: aClass [
]

{ #category : #writing }
DiModelToJavascriptExporter >> writeClassVariablesDeclarationOf: aClass [
]

{ #category : #writing }
DiModelToJavascriptExporter >> writeMethodsOf: aClass [
]
