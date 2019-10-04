"
I add a ==userData== method to a root model class. The method returns a ${class:Dictionary}$ and can be used to store any user data.

!! Example with One Trait

Using the following company meta-model: ${example:DiCollectionToModelBuilderExamples>>#collectionsAndRelationsWithCompany|codeExpanded=false|previewExpanded=true}$

I build the following root model:
${example:DiCollectionToModelBuilderExamples>>#buildFullModelWithUserDataMethod_Behavior|codeExpanded=false|previewExpanded=true}$

Here you can browse the full model:
${example:DiCollectionToModelBuilderExamples>>#buildFullModelWithUserDataMethod|codeExpanded=false|previewExpanded=true}$

You can compare the model above with the standard build without my extension: 
${example:DiCollectionToModelBuilderExamples>>#buildFullModelClassesOnly|codeExpanded=false|previewExpanded=true}$




"
Class {
	#name : #DiUserDataExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builder Extensions'
}

{ #category : #building }
DiUserDataExtension >> build [
	| aClass aMethodBody |
	aClass := self modelRootClass.
	self ensureInstanceVariable: 'userData' inBehavior: aClass.
	aMethodBody := 'userData', String cr, String tab, '^ userData ifNil: [ userData := Dictionary new ]'.
	self 
		ensureLocalMethodNamed: 'userData' 
		withSourceCode: aMethodBody 
		andProtocol: self naming accessorProtocolName 
		inBehavior: aClass
]
