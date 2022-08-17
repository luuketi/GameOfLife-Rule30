Class {
	#name : #GameOfLifeCell,
	#superclass : #BorderedMorph,
	#instVars : [
		'isAlive'
	],
	#category : #'Conways-Game-Of-Life'
}

{ #category : #initialization }
GameOfLifeCell class >> new [
	
	|cell|
	
	cell := super new.
	cell borderStyle: (SimpleBorder width: 0 color: Color transparent). 
	cell bounds: (Rectangle point: 0@0 point: 10@10).
	cell isAlive: false.
	^cell.
]

{ #category : #initialization }
GameOfLifeCell class >> new: aColor [
	
	|cell|
	
	cell := super new.
	cell borderStyle: (SimpleBorder width: 1 color: Color transparent). 
	cell bounds: (Rectangle point: 0@0 point: 10@10).
	cell isAlive: false.
	^cell.
]

{ #category : #public }
GameOfLifeCell >> awake [

	^ self isAlive: true.
]

{ #category : #public }
GameOfLifeCell >> isAlive [

	^ isAlive 
]

{ #category : #public }
GameOfLifeCell >> isAlive: isAliveBoolean [


	self color: 	(isAliveBoolean ifTrue: [Color white] ifFalse: [Color black]).
	isAlive := isAliveBoolean.
	^ self
]

{ #category : #public }
GameOfLifeCell >> kill [

	^ self isAlive: false.
]
