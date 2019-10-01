Class {
	#name : #DiAddClassCommentExtension,
	#superclass : #DiCollectionToModelBuilderExtension,
	#category : #'GToolkit4DirectusRing2-Model Builders'
}

{ #category : #building }
DiAddClassCommentExtension >> build [
	self includedCollectionsAndModelsDo: [ :eachCollection :eachClass | 
		eachCollection note isEmptyOrNil ifFalse: [ 
			self ensureClassComment: eachCollection note forBehavior: eachClass ] ]
]
