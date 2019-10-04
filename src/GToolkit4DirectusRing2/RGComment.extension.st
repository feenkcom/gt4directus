Extension { #name : #RGComment }

{ #category : #'*GToolkit4DirectusRing2' }
RGComment >> gtContentFor: aView [
	<gtView>
	self content isRingResolved ifFalse: [ ^ aView empty ].
	self isEmptyOrNil ifTrue: [ ^ aView empty ].
	^ aView textEditor
		title: 'Content';
		priority: 1;
		glamorousCodeFont;
		text: [ self content ]
]
