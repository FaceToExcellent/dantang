//
//  YZMeViewController.swift
//  dantang
//
//  Created by HYZ on 16/9/12.
//  Copyright © 2016年 HYZ. All rights reserved.
//

import UIKit

class YZMeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,myheadViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate{
    let tableView=UITableView()
     //不这么写不显示
   let headview  = myheadView.init(frame: CGRect.init(x: 0, y: 0, width: Screem_W, height: 440*wb))
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
       
        
        
        tableView.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-24)
        //tableView.backgroundColor = UIColor.red
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.view.addSubview(tableView)
        tableView.register(UITableViewCell().classForCoder, forCellReuseIdentifier: "me")
        
        headview.isUserInteractionEnabled = true
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
        let alertController = UIAlertController()
        //是否支持相机
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            //相册
            alertController.addAction(UIAlertAction.init(title: "从相册中选取", style: .default, handler: { (action1:UIAlertAction) in
                
                print("从相册选取")
                let imagePickerController1 = UIImagePickerController()
                imagePickerController1.delegate = self
                imagePickerController1.allowsEditing = true
                imagePickerController1.sourceType = .photoLibrary
                
                self.present(imagePickerController1, animated: true, completion: nil)
                
                
            }))
            
            //相机
            
            alertController.addAction(UIAlertAction.init(title: "拍照", style: .default, handler: { (action2:UIAlertAction ) in
                
                print("拍照")
                let imagePickerController2 = UIImagePickerController()
                imagePickerController2.delegate = self
                imagePickerController2.allowsEditing = true
                imagePickerController2.sourceType = .camera
                
                self.present(imagePickerController2, animated: true, completion: nil)
                
            }))
            
            
            //取消
            
            
            alertController.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (action3:UIAlertAction ) in
                
                return
                
            }))
            
            
            self.present(alertController, animated: true, completion: nil)
            
            
        }else
        {
            //只能相册
            //相册
            alertController.addAction(UIAlertAction.init(title: "从相册中选取", style: .default, handler: { (action1:UIAlertAction) in
                
                print("从相册选取")
                let imagePickerController = UIImagePickerController()
                imagePickerController.delegate = self
                imagePickerController.allowsEditing = true
                imagePickerController.sourceType = .photoLibrary
                
                self.present(imagePickerController, animated: true, completion: nil)
                
                
            }))
        
            
            //取消
            
            
            alertController.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (action2:UIAlertAction ) in
                
                return
                
            }))
            
            
            self.present(alertController, animated: true, completion: nil)
            

        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        let image:UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        
        headview.headimage.setImage(image, for: .normal)
        
        picker.dismiss(animated: true, completion: nil)
        
        self .saveImage(image: image, name: "headView.png")
        

    }
    
    func saveImage(image:UIImage, name:String){
        let ImageData:Data = UIImageJPEGRepresentation(image, 0.8)!
        let fullPath:String = NSHomeDirectory() + "/Documents/" + name
        
        let imageNSDate: NSData = NSData.init(data: ImageData)
        imageNSDate.write(toFile: fullPath, atomically: true)
        
        
        
        
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
