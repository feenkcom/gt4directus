Class {
	#name : #BaselineOfGToolkit4Directus,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkit4Directus
}

{ #category : #baseline }
BaselineOfGToolkit4Directus >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'NeoJSON' with: [
				spec repository: 'github://svenvc/NeoJSON:v17/repository' ].

		spec package: 'GToolkit4Directus' with: [
			spec requires: #('NeoJSON') ].
		spec package: 'GToolkit4DirectusRing2' with: [
			spec requires: #('GToolkit4Directus') ].
	]
]
