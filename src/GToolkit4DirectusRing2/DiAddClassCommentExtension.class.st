"
I add a class comment if {{gtClass:DiMetaCollection}} has a defined note.

## Example

Using the following company meta-model: {{gtExample:DiCollectionToModelBuilderExamples>>#collectionsAndRelationsWithCompany|codeExpanded=false|previewExpanded=true}}

that have the following note:
{{gtExample:DiCompanyMetaModelExamples>>#companyCollection|previewShow=gtNoteFor:|previewHeight=50|noCode=true|codeExpanded=false|previewExpanded=true}}

I add the following class comment:
{{gtExample:DiCollectionToModelBuilderExamples>>#buildFullModelWithClassComment_Behavior|previewShow=gtClassCommentFor:|previewHeight=50|noCode=true|codeExpanded=false|previewExpanded=true}}

Into the following model:
{{gtExample:DiCollectionToModelBuilderExamples>>#buildFullModelWithClassComment_Behavior|codeExpanded=false|previewExpanded=true}}

Here you can browse the full model:
{{gtExample:DiCollectionToModelBuilderExamples>>#buildFullModelWithClassComment|codeExpanded=false|previewExpanded=true}}

You can compare the model above with the standard build without my extension: 
{{gtExample:DiCollectionToModelBuilderExamples>>#buildFullModelClassesOnly|codeExpanded=false|previewExpanded=true}}



"
Class {
	#name : #DiAddClassCommentExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builder Extensions'
}

{ #category : #building }
DiAddClassCommentExtension >> build [
	self includedCollectionsAndModelsDo: [ :eachCollection :eachClass | 
		eachCollection note isEmptyOrNil ifFalse: [ 
			self ensureClassComment: eachCollection note forBehavior: eachClass ] ]
]
