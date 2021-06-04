"
I remove all existing methods with undeclared variables after a model installation.
In other words, I will clean the newly installed model by removing accessor methods that are no more valid.
See {{gtMethod:DiRemoveMethodsWithUndeclaredVariablesExtension>>#postInstall}}.

## Example

You can try me by installing the following model (click on the `Full Install`): 
{{gtExample:DiCollectionToModelBuilderExamples>>#buildFilteredModelWithoutCountry_Unfiltered|codeExpanded=false|previewExpanded=true}}

You can browse the installed {{gtClass:DiDummyCompany}} class. For example it includes the {{gtMethod:DiDummyCompany>>#country}} method.

Then you can install another model with less {{gtClass:DiDummyCompany}} instance variables (click on the `Full Install`):
{{gtExample:DiCollectionToModelBuilderExamples>>#buildFilteredModelWithoutCountry|codeExpanded=false|previewExpanded=true}}

If you browse the installed {{gtClass:DiDummyCompany}} class, you will find methods with undeclared variables, e.g., {{gtMethod:DiDummyCompany>>#country}}.

Then you can install the same model using me (click on the `Full Install`):
{{gtExample:DiCollectionToModelBuilderExamples>>#buildFilteredModelWithoutCountry_WithRemoveUndeclaredVariables|codeExpanded=false|previewExpanded=true}}

And if you browse the installed {{gtClass:DiDummyCompany}} class, you will find out that the methods with undeclared variables disappeared, e.g., {{gtMethod:DiDummyCompany>>#country}} does not exist anymore.


"
Class {
	#name : #DiRemoveMethodsWithUndeclaredVariablesExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builder Extensions'
}

{ #category : #building }
DiRemoveMethodsWithUndeclaredVariablesExtension >> build [
	"do nothing"
]

{ #category : #building }
DiRemoveMethodsWithUndeclaredVariablesExtension >> postInstall [
	| aRootModel aRealClass |
	aRootModel := self builder modelRootClass.
	aRealClass := self class environment at: aRootModel name asSymbol ifAbsent: [ ^ self ].
	aRealClass withAllSubclassesDo: [ :eachClass | 
		eachClass methodDict copy do: [ :eachCompiledMethod | 
			eachCompiledMethod usesUndeclares ifTrue: [ 
				eachCompiledMethod removeFromSystem ] ] ]
]
