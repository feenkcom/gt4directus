Extension { #name : #RGBehavior }

{ #category : #'*GToolkit4DirectusRing2' }
RGBehavior >> gtDefinitionFor: aView [
	<gtView>
	^ aView textEditor
			title: 'Definition';
			priority: 1;
			look: BrGlamorousCodeEditorLook new;
			styler: BrRBTextStyler new;
			text: [ self definition asRopedText  ]
]
