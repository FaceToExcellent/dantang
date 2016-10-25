//
//  YZMeViewController.swift
//  dantang
//
//  Created by HYZ on 16/9/12.
//  Copyright © 2016年 HYZ. All rights reserved.
//

import UIKit

class YZMeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,myheadViewDelegate {
    let tableView=UITableView()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = UIColor.white
        //不写这句会自动下移20
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
        
        makeUI()
    }
      func makeUI(){
        //不这么写不显示
        let headview  = myheadView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 440*wb))
        
        tableView.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-24)
        //tableView.backgroundColor = UIColor.red
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.view.addSubview(tableView)
        tableView.register(UITableViewCell().classForCoder, forCellReuseIdentifier: "me")
        
       
        headview.delegate = self
        self.view .addSubview(headview)
        tableView.tableHeaderView = headview
        
       // tableView .reloadData()
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell  = UITableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "me", for: indexPath)
    return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func myheadViewheadbuttonCLick() {
        print("头像被点击");
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
