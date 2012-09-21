FlipGridView
============

a  display of six grids which can perform half-flip

<img src="https://github.com/aceisScope/FlipGridView/raw/master/screenshot.png"/> 

##Description
=============
This is a humble information board which resembles FlipBoard but far from what the brilliant app can reach. The half-folder flip effect is based on 
<a href="https://github.com/mtabini/AFKPageFlipper">mtabini / AFKPageFlipper</a>

##How to use
=================
Only three functions in FlipGridDisplayView.h:
	- (void)shuffelColors;
	- (void)setCurrentContentForGrids:(NSArray*)array;
	- (void)updateContentAtIndex:(NSInteger)index withContent:(NSDictionary*)content;

- shuffle random colours for each cell
- init the whole display, i.e., current view for each cell
- update any cell that needs to