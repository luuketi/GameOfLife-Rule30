Class {
	#name : #GameOfLifeDeadCell,
	#superclass : #GameOfLifeCell,
	#category : #'Conways-Game-Of-Life'
}

{ #category : #intialization }
GameOfLifeDeadCell class >> new [
	

	^ super new: Color black.
]
