//
//  YZCategoryViewController.swift
//  dantang
//
//  Created by HYZ on 16/9/12.
//  Copyright © 2016年 HYZ. All rights reserved.
//

import UIKit

class YZCategoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    let tableView = UITableView()
    var DataArray : ([String])?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.barTintColor =
            UIColor(red: 240/255, green: 105/255, blue: 105/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white]
        
        
        self.view.backgroundColor = UIColor.white
         self.DataArray = ["FSCalendar（oc）","chineseCalendar（oc）","DZNEmptyDataSet","alertView","CoreText"]
        self.makeUI()
        
    }
    func makeUI(){
        
        tableView.frame = CGRect(x: 0, y: 64, width: self.view.frame.size.width, height: self.view.frame.size.height)
        tableView.delegate=self
        tableView.dataSource=self;
        self.view.addSubview(tableView)
        tableView.register(UITableViewCell().classForCoder, forCellReuseIdentifier: "id")
        
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  (self.DataArray?.count)!;
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath)
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        
        cell.textLabel?.text = self.DataArray![indexPath.row];
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row==0  {
            
//            let vc  = myCollectionViewController()
//            self.navigationController!.pushViewController(vc, animated: true)
            //桥接文件中需要导入 #import "FSCalendarViewController.h"
            let vc = FSCalendarViewController()
            self.navigationController!.pushViewController(vc, animated: true)
            
        }
        
        if indexPath.row==1  {
            
    
            let vc = chineseCalendarViewController()
            self.navigationController!.pushViewController(vc, animated: true)
            
        }
        if indexPath.row==2  {
            
            
            let vc = DZNEmptyDataSetViewController()
            self.navigationController!.pushViewController(vc, animated: true)
            
        }
        if indexPath.row==3  {
            
            
            let vc = alertViewController()
            self.navigationController!.pushViewController(vc, animated: true)
            
        }
        
        if indexPath.row==4  {
            
            
            let vc = CoreText2ViewController()
            self.navigationController!.pushViewController(vc, animated: true)
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
