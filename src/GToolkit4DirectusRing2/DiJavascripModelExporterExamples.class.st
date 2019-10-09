"
Test Pharo meta-model to Javascript generation.
I exemplify ${class:DiModelToJavascriptExporter}$.

"
Class {
	#name : #DiJavascripModelExporterExamples,
	#superclass : #Object,
	#instVars : [
		'builderExamples'
	],
	#category : #'GToolkit4DirectusRing2-Examples'
}

{ #category : #examples }
DiJavascripModelExporterExamples >> companyAndCountryBuilder [
	<gtExample>
	^ builderExamples buildFilteredModelWithoutCountry_Unfiltered.
]

{ #category : #examples }
DiJavascripModelExporterExamples >> companyAndCountryExporter [
	<gtExample>
	| exporter |
	exporter := self companyAndCountryBuilder exportToJavascript.
	self assert: exporter contents isNotEmpty.
	^ exporter. 
]

{ #category : #initialization }
DiJavascripModelExporterExamples >> initialize [
	super initialize.
	builderExamples := DiCollectionToModelBuilderExamples new.
]
