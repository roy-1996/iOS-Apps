//
//  MenuManager.swift
//  News App
//
//  Created by RONIT NATH on 16/08/19.
//  Copyright © 2019 RONIT NATH. All rights reserved.
//

import UIKit

class MenuManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    let blackView = UIView()
    let menuTableView = UITableView()
    let arrayOfSources = ["bbc-news"]
    var mainVC: ViewController?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as UITableViewCell
        cell.textLabel?.text = arrayOfSources[ indexPath.item ]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50       /* Height of each menu cell */
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = mainVC
        {
            vc.source = arrayOfSources[ indexPath.item ].lowercased()
            vc.fetchArticles(fromSource: arrayOfSources[ indexPath.item ].lowercased())
            dismissMenu()
        }
    }
    
    
    public func openMenu()
    {
        if let window = UIApplication.shared.keyWindow
        {
            blackView.frame = window.frame
            blackView.backgroundColor = UIColor( white : 0 , alpha : 0.5 )
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissMenu)))
            
            let height: CGFloat = CGFloat(50 * arrayOfSources.count)        /* Total height of the menu tableview is height of each menu row times number of rows */
            let y = window.frame.height - height                            /* The y-coordinate of the menu table view after sliding up */
            menuTableView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            window.addSubview(blackView)
            window.addSubview(menuTableView)
            
            UIView.animate(withDuration: 0.5, animations: {
                self.blackView.alpha = 1
                self.menuTableView.frame.origin.y = y
            })
        }
    }
    
    @objc public func dismissMenu()
    {
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow
            {
                self.menuTableView.frame.origin.y = window.frame.height     /* For hiding the menu after dismissal */
            }
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    

    override init()
    {
        super.init()
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        menuTableView.isScrollEnabled = false
        menuTableView.bounces = false
        
        menuTableView.register(BaseViewCell.classForCoder(), forCellReuseIdentifier: "cellid")
    }
    

 }
