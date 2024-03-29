//
//  CustomViewController.swift
//  CustomViewController
//
//  Created by apple on 2019/11/22.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var header : CustomHeaderView!
    var tableView : UITableView!
    var navigationView = UIView()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kCellID)
        setupHeaderView()
        
        // NavigationHeader
        let navibarHeight : CGFloat = navigationController!.navigationBar.bounds.height
        let statusbarHeight : CGFloat = UIApplication.shared.statusBarFrame.size.height
        navigationView = UIView()
        navigationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: navibarHeight + statusbarHeight)
        navigationView.backgroundColor = UIColor(red: 121/255.0, green: 193/255.0, blue: 203/255.0, alpha: 1.0)
        navigationView.alpha = 0.0
        view.addSubview(navigationView)
        
        // back button
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 15, y: kTopStatusBarHeight + 20, width: 44, height: 44)
        button.setImage(UIImage(named: "navi_back_btn")?.withRenderingMode(.alwaysTemplate), for: UIControl.State())
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(CustomViewController.leftButtonAction), for: .touchUpInside)
        view.addSubview(button)
    }

    func setupHeaderView() {
        
        header = CustomHeaderView()
        header.flexZoomHeaderSize(headerSize: CGSize(width: view.frame.size.width, height: 160),
            imageSize: CGSize(width: view.frame.size.width, height: 120),
            controller: self,
            position: .fullScreenTop)
        header.imageView.image = UIImage(named: "photo_sample_05")
        
        // custom
        let avatarImage = UIImageView()
        avatarImage.frame = CGRect(x: 10, y: header.imageView.frame.height - 20, width: 60, height: 60)
        avatarImage.image = UIImage(named: "photo_sample_03")
        avatarImage.layer.cornerRadius = 5.0
        avatarImage.layer.borderColor = UIColor.white.cgColor
        avatarImage.layer.borderWidth = 3.0
        avatarImage.clipsToBounds = true
        avatarImage.contentMode = .scaleAspectFill
        header.addSubview(avatarImage)
        
        let button = UIButton(type: .roundedRect)
        button.frame = CGRect(x: header.imageView.frame.width - 100 - 10, y: header.imageView.frame.height + 10, width: 100, height: 30)
        button.setTitle("Edit Profile", for: UIControl.State())
        button.setTitleColor(UIColor.lightGray, for: UIControl.State())
        button.layer.cornerRadius = 5.0
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1.0
        header.addSubview(button)
        
        tableView.tableHeaderView = header
    }
    
    // MARK: - Selector
    @objc func leftButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // #warning Incomplete implementation, return the number of rows
           return 20
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: kCellID, for: indexPath)
           cell.textLabel?.text = "index -- \((indexPath as NSIndexPath).row)"
           return cell
       }
    
    // MARK: - ScrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        header.updateScrollViewOffset(scrollView)
        
        // NavigationHeader alpha update
        let offset : CGFloat = scrollView.contentOffset.y
        if (offset > 50) {
            let alpha : CGFloat = min(CGFloat(1), CGFloat(1) - (CGFloat(50) + (navigationView.frame.height) - offset) / (navigationView.frame.height))
            navigationView.alpha = CGFloat(alpha)
            
        } else {
            navigationView.alpha = 0.0;
        }
    }
}

//extention CustomViewController: UITableViewDataSource {
//
//
//
//}
//
//extention CustomViewController: UITableViewDelegate {
//
//
//}


