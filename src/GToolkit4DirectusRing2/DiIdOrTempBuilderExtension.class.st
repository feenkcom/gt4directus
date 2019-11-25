"
I am a copy of class DiCollectionNameBuilderExtension. This comment is copied from there, and might not be entirely accurate

I add a ==collectionName== method to models in order to easily associate to which ${class:DiMetaCollection}$ belongs.
Someone can then call ==modelNamed:== with ${class:DiMetaCollection}$'s name on the model root class in order to identify the correct model class.

!! Example

Using the following company meta-model: ${example:DiCollectionToModelBuilderExamples>>#collectionsAndRelationsWithCompany|codeExpanded=false|previewExpanded=true}$

I build the following root model:
${example:DiCollectionToModelBuilderExamples>>#buildFullModelWithPrintOnMethod_Behavior|codeExpanded=false|previewExpanded=true}$

Here you can browse the full model:
${example:DiCollectionToModelBuilderExamples>>#buildFullModelWithPrintOnMethod|codeExpanded=false|previewExpanded=true}$

You can compare the model above with the standard build without my extension: 
${example:DiCollectionToModelBuilderExamples>>#buildFullModelClassesOnly|codeExpanded=false|previewExpanded=true}$

!! Related

Similarly, ${class:DiIncludedFieldsBuilderExtension}$ add a method that returns ${class:DiMetaField}$ objects considered (included) during the model (class) build.

"
Class {
	#name : #DiIdOrTempBuilderExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builder Extensions'
}

{ #category : #building }
DiIdOrTempBuilderExtension >> build [
	self buildInRootModelClass.
]

{ #category : #building }
DiIdOrTempBuilderExtension >> buildInRootModelClass [
	| aClass idSourceCode idOrTempSourceCode |
	aClass := self builder modelRootClass.
	idSourceCode := 'id', String cr, String tab, '^ self subclassResponsibility'. 
	self 
		ensureLocalMethodNamed: 'id'
		withSourceCode: idSourceCode 
		andProtocol: self naming accessorProtocolName
		inBehavior: aClass.
		
	self ensureInstanceVariable: 'tempId' inBehavior: aClass.
	idOrTempSourceCode := 'idOrTemp', String cr, 
		String tab, 'self id', String cr, 
		String tab, String tab, 'ifNil: [ tempId ifNil: [ tempId := UUIDGenerator next asString ]. ^ tempId.]', String cr, 
		String tab, String tab, 'ifNotNil: [ ^ self id ].'.
	self 
		ensureLocalMethodNamed: 'idOrTemp' 
		withSourceCode: idOrTempSourceCode 
		andProtocol: self naming accessorProtocolName 
		inBehavior: aClass.
]
