// SET TITLE AND ARTIST NAME
#let Title = "SONG_TITLE"
#let Artist = "ARTIST_NAME"

// PASTE SONG LYRICS HERE
#let Lyrics = `
LYRICS
LYRICS
LYRICS
LYRICS
`

// DO NOT TOUCH THE REST, UNLESS YOU KNOW WHAT YOU ARE DOING
#set text(font: "New Computer Modern", size: 12pt)

#align(center)[
  #block(text(size: 36pt, weight: "bold", Title))
  #block(text(size: 18pt, style: "italic", Artist))

  #text(size: 12pt)[
    #Lyrics.text
  ]
]
