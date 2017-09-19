//
//  ViewController.swift
//  ScaleNavBarSwiftDemo
//
//  Created by Harvey Zhang on 16/4/27.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView:UITableView?
    var topImageView:UIImageView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		
        createTableView()
        setupNavigationItems()
    }
    
    // MARK: - Private helpers
	
    fileprivate func createTableView() -> Void
	{
        if (tableView == nil) {
            tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
            tableView?.delegate = self
            tableView?.dataSource = self
            tableView?.backgroundColor = UIColor.white
            tableView?.separatorStyle = .singleLine
            self.view.addSubview(tableView!)
        }
    }
	
    fileprivate func setupNavigationItems() -> Void
	{
		/// setup a title view for the navigation bar
        let headBackView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        headBackView.backgroundColor = UIColor.clear
		
        topImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        topImageView?.backgroundColor = UIColor.white
        topImageView?.layer.cornerRadius = (topImageView?.bounds.size.width)! / 2
        topImageView?.layer.masksToBounds = true
        topImageView?.image = UIImage(named: "head")
		
		headBackView.addSubview(topImageView!)

        self.navigationItem.titleView = headBackView
		
		/// setup left and right bar button items
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "HideNaviBar", style: .done,
		                                                        target: self, action: #selector(ViewController.hideNaviBtnClick))
		
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "NextPage", style: .done,
		                                                         target: self, action: #selector(ViewController.nextBtnClick))
    }
	
	// MARK: - callbacks and helpers
	
	func hideNaviBtnClick() -> Void
	{
		let hideVC = HGHideNaviBarVC()
		self.navigationController?.pushViewController(hideVC, animated: true)
	}
	
	func nextBtnClick() -> Void
	{
		let transparentBarVC = HGTransparentNaviBarVC()
		
		transparentBarVC.myAlphaClosure = { (a: String) in
			// xxx
		}
		
		self.navigationController?.pushViewController(transparentBarVC, animated: true)
	}
	
    // MARK: - tableView DataSource and Delegate methods
	
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = "myCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
		
        cell?.backgroundColor = UIColor.aRandomColor()
        return cell!
    }
	
    // UIScrollViewDelegate method
    func scrollViewDidScroll(_ scrollView: UIScrollView)
	{
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
	
}
