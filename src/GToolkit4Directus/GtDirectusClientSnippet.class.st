Class {
	#name : #GtDirectusClientSnippet,
	#superclass : #GtSnippet,
	#instVars : [
		'url',
		'user',
		'token'
	],
	#category : #GToolkit4Directus
}

{ #category : #accessing }
GtDirectusClientSnippet class >> typeName [
	<return: #String>

	^ 'directus'
]

{ #category : #converting }
GtDirectusClientSnippet >> asElement [
	| snippetContainer formElement urlInputElement tokenInputElement toolbar playInspectButton userInputElement |
	formElement := BlElement new.
	formElement constraintsDo: [ :c |  
		c vertical fitContent.
		c horizontal matchParent ].
	formElement layout: (BlGridLayout horizontal columnCount: 2; cellSpacing: 10).

	urlInputElement := self inputElementNamed: 'Url' in: formElement.
	userInputElement := self inputElementNamed: 'User' in: formElement.
	tokenInputElement := self inputElementNamed: 'Token' in: formElement.
	
	toolbar := BrToolbar new
		look: BrToolbarLook new;
		layout: (BlGridLayout horizontal rowCount: 1; cellSpacing: 10);
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ].
	playInspectButton := BrButton new.
	playInspectButton 
		beSmall;
		look: BrGlamorousButtonWithIconLook;
		label: 'Inspect connection';
		icon: BrGlamorousIcons playinspect asElement;
		action: [ 
			| client  |
			"client := JenkinsClient new
				username: userInputElement editor text asString
				token: tokenInputElement editor text asString
				url: urlInputElement editor text asString.
			playInspectButton phlow spawnObject: client blueOcean" ].
	toolbar addItem: playInspectButton.
	
	snippetContainer := BrVerticalPane new
		vFitContent;
		hMatchParent;
		clipChildren: false;
		look: (GtSnippetContainerLook new snippet: self) + BrShadowLook new;
		border: BlBorder empty;
		padding: BlInsets empty;
		background: (BlBackground paint: Color white).
	snippetContainer addChild: formElement.
	snippetContainer addChild: toolbar.
	^ snippetContainer
]

{ #category : #converting }
GtDirectusClientSnippet >> asStencilBuilder [
	^ self
]

{ #category : #'api - instantiation' }
GtDirectusClientSnippet >> bind: aSnippet to: aSnippetElement [
]

{ #category : #converting }
GtDirectusClientSnippet >> inputElementNamed: aString in: formElement [
	| labelElement inputElement text |
	labelElement := BrLabel new text: aString, ':'; look: BrGlamorousLabelLook.
	labelElement constraintsDo: [ :c | 
		c vertical fitContent.
		c horizontal fitContent.
		c grid vertical alignCenter ].
	inputElement := BrEditorElement new.
	inputElement look: BrGlamorousInputFieldSpacingLook.
	inputElement constraintsDo: [ :c | 
		c vertical fitContent.
		c horizontal matchParent.
		c grid vertical alignCenter ].
	text := '' asRopedText 
		weight: 400;
		fontName: 'Source Sans Pro';
		fontSize: 14.
	inputElement editor: (BrTextEditor new text: text).
	formElement addChild: labelElement.
	formElement addChild: inputElement.
	^ inputElement
]

{ #category : #accessing }
GtDirectusClientSnippet >> string [
	<return: #String>
	^ String streamContents: [ :aStream | 
		aStream nextPutAll: 'Directus:'.
		self url ifNotNil: [ aStream space; print: self url ].
		self user ifNotNil: [ aStream space; print: self user ]. ]
]

{ #category : #accessing }
GtDirectusClientSnippet >> text [
	<return: #BlRope>
	^ self string asRopedText
]

{ #category : #accessing }
GtDirectusClientSnippet >> token [
	^ token
]

{ #category : #accessing }
GtDirectusClientSnippet >> token: anObject [
	token := anObject
]

{ #category : #accessing }
GtDirectusClientSnippet >> url [
	^ url
]

{ #category : #accessing }
GtDirectusClientSnippet >> url: anObject [
	url := anObject
]

{ #category : #accessing }
GtDirectusClientSnippet >> user [
	^ user
]

{ #category : #accessing }
GtDirectusClientSnippet >> user: anObject [
	user := anObject
]
