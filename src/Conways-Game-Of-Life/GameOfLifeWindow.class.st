Class {
	#name : #GameOfLifeWindow,
	#superclass : #Object,
	#instVars : [
		'container',
		'height',
		'width',
		'form',
		'scale'
	],
	#classInstVars : [
		'container'
	],
	#category : #'Conways-Game-Of-Life'
}

{ #category : #'instance creation' }
GameOfLifeWindow class >> withHeight: aHeight withWidth: aWidth [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
	| world |
	world := 	self new.	
	world setHeight: aHeight. 
	world setWidth: aWidth.
	world initializes.
	^world
]

{ #category : #public }
GameOfLifeWindow >> draw [

	container changed
]

{ #category : #private }
GameOfLifeWindow >> initializes [

	scale := 3.
	container := ((Form extent: width@height depth: 32) magnifyBy: scale) asMorph.
	form := container form.
]

{ #category : #private }
GameOfLifeWindow >> setHeight: aHeight [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	height := aHeight 
]

{ #category : #private }
GameOfLifeWindow >> setWidth: aWidth [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"	
			
	width := aWidth 
]

{ #category : #public }
GameOfLifeWindow >> show [

	container openInWorld
	
]

{ #category : #public }
GameOfLifeWindow >> updateCell: aPoint color: aColor [

	| ix iy |
	ix := aPoint x -1.
	iy := aPoint y -1.
	ix*scale to: ix*scale+(scale-1) do: [ :x |
		iy*scale to: iy*scale+(scale-1) do: [ :y | 
			form colorAt: x@y put: aColor.
			]]
]
