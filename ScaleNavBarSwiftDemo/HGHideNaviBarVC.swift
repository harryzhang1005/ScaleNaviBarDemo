//
//  HGHideNaviBarVC.swift
//  ScaleNavBarSwiftDemo
//
//  Created by Harvey Zhang on 16/4/27.
//

import UIKit

class HGHideNaviBarVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView:UITableView?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		// Do any additional setup after loading the view.
		
        createTableView()
    }
	
    // MARK: - tableView
    func createTableView() -> Void
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
	
    func scrollViewDidScroll(_ scrollView: UIScrollView)
	{
        let offsetY: CGFloat = scrollView.contentOffset.y + (tableView?.contentInset.top)!
        let panTranslationY = scrollView.panGestureRecognizer.translation(in: tableView).y
        print("panTranslationY: \(panTranslationY.string2)");
        
        if offsetY > 0 {
            if panTranslationY > 0 { // down and show
				self.navigationController?.setNavigationBarHidden(false, animated: true)
            }
			else { // up and hide
                self.navigationController?.setNavigationBarHidden(true, animated: true)
            }
        }
		else {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }

}
