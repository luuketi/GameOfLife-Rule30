Class {
	#name : #BlinkerPattern,
	#superclass : #Pattern,
	#instVars : [
		'initialPosition'
	],
	#category : #'Conways-Game-Of-Life'
}

{ #category : #creation }
BlinkerPattern class >> at: aPoint [

	| pattern |
	pattern := self new.
	pattern setInitialPoint: aPoint.
	^ pattern.
]

{ #category : #accessing }
BlinkerPattern >> positions [
			
	| x y |
	x := initialPosition x.
	y := initialPosition y.
	^ {  (Point x: x y: y    ).
		  (Point x: x y: (y+1)).     
		  (Point x: x y: (y+2)).
	  }
]

{ #category : #private }
BlinkerPattern >> setInitialPoint: aPoint [
	
	initialPosition := aPoint 
]
