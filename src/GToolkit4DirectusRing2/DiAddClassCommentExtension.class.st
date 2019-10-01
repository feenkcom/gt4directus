Class {
	#name : #DiAddClassCommentExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #building }
DiAddClassCommentExtension >> build [
	self collectionsAndModelsDo: [ :eachCollection :eachClass | 
		| aComment |
		eachCollection note isEmptyOrNil ifFalse: [ 
			aComment := eachClass defaultCommentStubIn: eachClass.
			aComment content: eachCollection note.
			aComment name: 'Comment of ', eachClass name. 
			eachClass comment: aComment ] ]
]
