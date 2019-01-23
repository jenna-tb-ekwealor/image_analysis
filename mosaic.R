library("RsimMosaic")

# Set the folder where the original images are located
pathToOriginalImages <- system.file("bow_river/-UV/", package="RsimMosaic")

# Set the folder where the tiles will be stored. It will be created if it does not exists. 
pathToTileImages <- paste(tempdir(), "/myTiles/", sep="")

# Create the tiles (10 pix are used just to make this example run fast)
createTiles(pathToOriginalImages, pathToTileImages, tileHeight=10)

# Create the tiles (10 pix are used just to make this example run fast)
createTiles("bow_river/-UV/", "/myTiles/", tileHeight=1)


library("imager")