Class {
	#name : #Pattern,
	#superclass : #Object,
	#category : #'Conways-Game-Of-Life'
}

{ #category : #creation }
Pattern class >> at: aPoint [
	
  ^ SubclassResponsibility new signal.
]

{ #category : #accessing }
Pattern >> positions [

	  ^ SubclassResponsibility new signal.
]
