# ScaleNaviBarDemo

## Scale the titleView of Navigation Bar Demo

```swift
// UIScrollViewDelegate method
func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY: CGFloat = scrollView.contentOffset.y + (tableView?.contentInset.top)!
        print("offsetY = \(offsetY.string2) contentOffset.y = \(scrollView.contentOffset.y.string2) contentInset.top = \(tableView!.contentInset.top.string2)")
		
	/*
	An affine transformation matrix for use in drawing 2D graphics.
	An affine transformation matrix is used to rotate, scale, translate, or skew the objects you draw in a graphics context. The CGAffineTransform type provides functions for creating, concatenating, and applying affine transformations.
		
	Affine transforms are represented by a 3 by 3 matrix:
	Because the third column is always (0,0,1), the CGAffineTransform data structure contains values for only the first two columns.
	*/
	if offsetY < 0 && offsetY >= -150 {
        	topImageView?.transform = CGAffineTransform(scaleX: 1 - offsetY/300, y: 1 - offsetY/300)
        }
	else if (offsetY >= 0 && offsetY <= 150) {
            topImageView?.transform = CGAffineTransform(scaleX: 1 - offsetY/300, y: 1 - offsetY/300)
        }
	else if (offsetY > 150) {
            topImageView?.transform = CGAffineTransform(scaleX: 0.45, y: 0.45)
        }
	else if(offsetY < -150) {
            topImageView?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }
	
	var frame: CGRect = (topImageView?.frame)!
        frame.origin.y = 5;
        topImageView?.frame = frame
}
```

Happy coding! :+1:  :sparkles:
