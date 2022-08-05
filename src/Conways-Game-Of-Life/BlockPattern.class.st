Class {
	#name : #BlockPattern,
	#superclass : #Pattern,
	#instVars : [
		'initialPoint'
	],
	#category : #'Conways-Game-Of-Life'
}

{ #category : #creation }
BlockPattern class >> at: aPoint [
			
	| pattern |
	pattern := self new.
	pattern setInitialPoint: aPoint.
	^ pattern
]

{ #category : #accessing }
BlockPattern >> positions [
			
	| x y |
	x := initialPoint x.
	y := initialPoint y.
	^ {  (Point x: x     y: y    ).
		  (Point x: (x+1) y: y    ).     
		  (Point x: x     y: (y+1)).
		  (Point x: (x+1) y: (y+1)).
	  }
]

{ #category : #private }
BlockPattern >> setInitialPoint: aPoint [
	
	initialPoint  := aPoint 
]
