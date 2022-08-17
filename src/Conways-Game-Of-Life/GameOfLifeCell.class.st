Class {
	#name : #GameOfLifeCell,
	#superclass : #BorderedMorph,
	#instVars : [
		'isAlive'
	],
	#category : #'Conways-Game-Of-Life'
}

{ #category : #initialization }
GameOfLifeCell class >> new: aColor [
	
	|cell|
	
	cell := super new.
	cell borderStyle: (SimpleBorder width: 1 color: aColor). 
	cell bounds: (Rectangle point: 0@0 point: 10@10).
	cell color: aColor.
	^cell.
]
