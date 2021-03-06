"
I build instance variable accessors for each {{gtClass:DiMetaCollection}} class based on {{gtMethod:DiMetaCollection>>#fields}} information, which is a collection of {{gtClass:DiMetaField}}.
The instance variables should be generated before my execution using {{gtClass:DiInstanceVariablesBuilderExtension}}.

## Example

Using the following company meta-model: {{gtExample:DiCollectionToModelBuilderExamples>>#collectionsAndRelationsWithCompany|codeExpanded=false|previewExpanded=true}}

I build the following model:
{{gtExample:DiCollectionToModelBuilderExamples>>#buildFullModelWithAllInstanceAndAccessorsVariables_Behavior|codeExpanded=false|previewExpanded=true}}

Here you can browse the full model:
{{gtExample:DiCollectionToModelBuilderExamples>>#buildFullModelWithAllInstanceAndAccessorsVariables|codeExpanded=false|previewExpanded=true}}


"
Class {
	#name : #DiInstanceVariablesAccessorsBuilderExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builder Extensions'
}

{ #category : #building }
DiInstanceVariablesAccessorsBuilderExtension >> build [
	self includedCollectionsAndFieldsAndModelsDo: [ :eachCollection :eachField :eachClass | 
		self buildInstanceVariableAccessor: eachField inClass: eachClass ofCollection: eachCollection ].
]

{ #category : #building }
DiInstanceVariablesAccessorsBuilderExtension >> buildInstanceVariableAccessor: aDiMetaField inClass: aRGBehavior ofCollection: aDiMetaCollection [ 
	| aName aType aVariableName aProtocolName aSourceCode aSetterName aMethodComment |
	
	aMethodComment := aDiMetaField note isEmptyOrNil
		ifTrue: [ '' ] 
		ifFalse: [ String cr, String tab, '"', ((aDiMetaField note) copyReplaceAll: '"' with: ''''), '"' ].
	aProtocolName := self naming accessorProtocolName.

	"Type"
	aType := aDiMetaField typeNameUsingNaming: self naming.
	
	"Getter"
	aName := self naming accessorName: aDiMetaField.
	aSourceCode := aName, aMethodComment, String cr, 
		String tab, '<return: ', aType printString, '>', String cr, 
		String tab, '<metaField: ', aDiMetaField name printString, '>', String cr, 
		String tab, '<required: ', aDiMetaField required asString, '>', String cr, 
		String tab, '<unique: ', aDiMetaField unique asString, '>', String cr, 
		String tab, '^ ', aName. 
	self modelBuilder 
		ensureLocalMethodNamed: aName 
		withSourceCode: aSourceCode 
		andProtocol: aProtocolName 
		inBehavior: aRGBehavior.

	"Setter"
	aVariableName := self naming modelInstanceName: aType.
	aSetterName := self naming setterName: aDiMetaField.
	aSourceCode := aSetterName, ' ', aVariableName, aMethodComment, String cr, 
		String tab, '<input: ', aType printString, '>', String cr, 
		String tab, '<metaField: ', aDiMetaField name printString, '>', String cr, 
		String tab, aName, ' := ', aVariableName. 
	self modelBuilder 
		ensureLocalMethodNamed: aSetterName 
		withSourceCode: aSourceCode 
		andProtocol: aProtocolName 
		inBehavior: aRGBehavior.
	
]
