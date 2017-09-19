//
//  HGTransparentNaviBarVC.swift
//  ScaleNavBarSwiftDemo
//
//  Created by Harvey Zhang on 16/4/27.
//

import UIKit

typealias AlphaClosure = (String) -> Void

class HGTransparentNaviBarVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var myAlphaClosure: AlphaClosure?
    
    var tableView:UITableView?
    fileprivate let TVtopContentInset:CGFloat = 100
	var topImageView:UIImageView?
    var statusBarStyleControl:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
        setupNaviBar()
        
        statusBarStyleControl = false
        
        createTableView()

        createScaleImageView()
        
        createHeaderView()
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (myAlphaClosure != nil) {
            myAlphaClosure!("hhahha")
        }
    }
	
    // MARK: - Private helpers
	
    fileprivate func createTableView() -> Void
	{
        if (tableView == nil) {
            tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
            tableView?.contentInset = UIEdgeInsetsMake(TVtopContentInset, 0, 0, 0)
            tableView?.delegate = self
            tableView?.dataSource = self
            tableView?.backgroundColor = UIColor.clear
            tableView?.separatorStyle = .singleLine
            self.view.addSubview(tableView!)
        }
    }
	
    fileprivate func createScaleImageView() -> Void
	{
        topImageView = UIImageView(frame: CGRect(x: 0, y: 0, width:
												 UIScreen.main.bounds.width, height: UIScreen.main.bounds.width*435.5/313.0))
        topImageView?.backgroundColor = UIColor.white
        topImageView?.image = UIImage(named: "backImage")
        self.view.insertSubview(topImageView!, belowSubview: tableView!)
    }
	
    fileprivate func createHeaderView() -> Void
	{
        //topContentInset = 136;//136+64 = 200
        let headBkView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: TVtopContentInset))
        headBkView.backgroundColor = UIColor.clear
        tableView?.tableHeaderView = headBkView
        
        let headImageView = UIImageView()
        headImageView.bounds = CGRect(x: 0, y: 0, width: 64, height: 64)
        headImageView.center = CGPoint(x: UIScreen.main.bounds.width/2.0, y: (TVtopContentInset - 64)/2.0)
        headImageView.backgroundColor = UIColor.white
        headImageView.layer.cornerRadius = headImageView.bounds.size.width / 2.0
        headImageView.layer.masksToBounds = true
        headImageView.image = UIImage(named: "head")
        headBkView.addSubview(headImageView)
    }
	
	// setup a transparent navigation bar
	fileprivate func setupNaviBar() {
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.isTranslucent = true
	}
	
    // MARK: - tableView DataSource and Delegate
	
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

    func scrollViewDidScroll(_ scrollView: UIScrollView)
	{
        let offsetY = scrollView.contentOffset.y + (tableView?.contentInset.top)!
        
        print("offsetY: \(offsetY.string2)")
        
        if offsetY > TVtopContentInset && offsetY <= TVtopContentInset*2
		{
            statusBarStyleControl = true
            setupNaviBar()
        }
        else if (offsetY <= TVtopContentInset && offsetY >= 0) {
            statusBarStyleControl = false
            if (self.responds(to: #selector(UIViewController.setNeedsStatusBarAppearanceUpdate))) {
                self.setNeedsStatusBarAppearanceUpdate()
            }
            setupNaviBar()
        }
        else if offsetY > TVtopContentInset * 2 {
            setupNaviBar()
        }
        else if offsetY < 0 {
            topImageView?.transform = CGAffineTransform(scaleX: 1 + offsetY/(-500), y: 1 + offsetY/(-500))
        }
		
        var frame:CGRect = (topImageView?.frame)!
        frame.origin.y = 0
        topImageView?.frame = frame
    }
	
}
