"
Test Pharo meta-model to Javascript generation.
I exemplify ${class:DiModelToJavascriptExporter}$.

"
Class {
	#name : #DiModelExporterExamples,
	#superclass : #Object,
	#instVars : [
		'builderExamples'
	],
	#category : #'GToolkit4DirectusRing2-Examples'
}

{ #category : #examples }
DiModelExporterExamples >> companyAndCountryBuilder [
	<gtExample>
	^ builderExamples buildFilteredModelWithoutCountry_Unfiltered.
]

{ #category : #examples }
DiModelExporterExamples >> companyAndCountryExporter [
	<gtExample>
	| exporter |
	exporter := self companyAndCountryBuilder exportToJavascript.
	self assert: exporter contents isNotEmpty.
	^ exporter. 
]

{ #category : #initialization }
DiModelExporterExamples >> initialize [
	super initialize.
	builderExamples := DiCollectionToModelBuilderExamples new.
]
