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
			baseline: 'Ring2' with: [ 
				spec repository: 'github://pavel-krivanek/Ring2/src' ];
			package: 'GToolkit4Directus' with: [
				spec requires: #( 'NeoJSON' ) ];
			package: 'GToolkit4DirectusRing2' with: [
				spec requires: #( 'GToolkit4Directus' 'Ring2' ) ]
	]

]
