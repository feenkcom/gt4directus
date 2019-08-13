Class {
	#name : #BaselineOfGToolkit4Directus,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkit4Directus
}

{ #category : #baselines }
BaselineOfGToolkit4Directus >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec 
			baseline: 'NeoJSON' with: [
				spec repository: 'github://svenvc/NeoJSON:master/repository' ];
			package: 'GToolkit4Directus' with: [
				spec requires: #('NeoJSON' ) ]
	]

]
