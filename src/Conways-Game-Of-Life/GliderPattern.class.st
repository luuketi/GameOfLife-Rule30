Class {
	#name : #GliderPattern,
	#superclass : #Pattern,
	#instVars : [
		'initialPosition'
	],
	#category : #'Conways-Game-Of-Life'
}

{ #category : #creation }
GliderPattern class >> at: aPoint [

	| pattern |
	pattern := self new.
	pattern setInitialPoint: aPoint.
	^ pattern.
]

{ #category : #accessing }
GliderPattern >> positions [
			
	| x y |
	x := initialPosition x.
	y := initialPosition y.
	^ {  (Point x: (x+1) y: y    ).
		  (Point x: (x+2) y: (y+1)).     
		  (Point x: (x) y: (y+2)).
		  (Point x: (x+1) y: (y+2)).
		  (Point x: (x+2) y: (y+2)).
	  }
]

{ #category : #private }
GliderPattern >> setInitialPoint: aPoint [
	
	initialPosition := aPoint 
]
