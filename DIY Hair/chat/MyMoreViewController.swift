//
//  MoreViewController.swift
//  myfistlib
//
//  Created by student on 2018/12/23.
//  Copyright © 2018年 蒋宇童. All rights reserved.
//

import UIKit
import Alamofire
import LeanCloud
class MyMoreViewController: UIViewController, UITableViewDataSource, UIScrollViewDelegate ,UITableViewDelegate{
  var token=""
    var dataArray = NSMutableArray()
     var dataArray2 = NSMutableArray()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var navBarTitle: UILabel!
   
  
    //@IBOutlet weak var navBarRightBtn: UIButton!
    var navigationView:UIView!
    var bgImg: UIImageView!
    var bgImgHeight: CGFloat = 0
    var headerHeight: CGFloat = 0
    var originalFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
 
    let ratio: CGFloat = 880/1279// 图片宽高比例
    
    let cellId = "UITableViewCell"
    let myimge=UIImage(named: "22")
    let images:[UIImage] = [UIImage(named: "badoo")!,UIImage(named: "behance")!,UIImage(named: "deviantart")!]
    let images2:[UIImage] = [UIImage(named: "dribbble")!,UIImage(named: "facebook")!,UIImage(named: "flickr")!]
    let images3:[UIImage] = [UIImage(named: "22")!,UIImage(named: "23")!,UIImage(named: "24")!,UIImage(named: "25")!]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        tableView.rowHeight = 45
        bgImgHeight = view.frame.width*ratio// 根据图片比例计算headerView高度
        headerHeight = bgImgHeight - 64
        
        bgImg = UIImageView.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: bgImgHeight))
        bgImg.image = UIImage.init(named: "photo.jpeg")
        //    tableView.insertSubview(img, at: 0)
        
        view.insertSubview(bgImg, at: 0)
        
        originalFrame = bgImg.frame
        
        // contentInset的实质就是修改bounds
        // scrollView滑动的本质，是修改bounds
        //    tableView.contentInset = UIEdgeInsets(top: view.frame.width*880/1279, left: 0, bottom: 0, right: 0)
        
        let headerView = UIView(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: headerHeight))
        headerView.backgroundColor = .clear
        tableView.tableHeaderView = headerView
       
 
       headerRefresh()
        //footerRefresh()
        
//        let obj2=dataArray2[0] as! AVObject
//        let myname=obj2["username"] as! String
//        for i in 0..<dataArray.count
//        {
//            let obj=dataArray[i] as! AVObject
//
//            let idString=obj["username"] as! String
//            print("username\(myname),idString\(idString)")
//            if idString==myname
//            {
//                dataArray.removeObject(at: i)
//            }
//
//
//
//        }
        
       self.tableView?.reloadData()

//        let tagRecognizer=UITapGestureRecognizer(target: self, action: #selector(tag(recognizer:)))
//       images3[0].addGestureRecognizer(tagRecognizer)
//        tagRecognizer.numberOfTapsRequired=1
//        tagRecognizer.numberOfTouchesRequired=2
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden=false
    }
    
    
   
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dataArray.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj=dataArray[indexPath.row] as! AVObject
         let idString=obj["username"] as! String
        
        let chat = RCConversationViewController(conversationType: RCConversationType.ConversationType_PRIVATE, targetId:  (idString))
        
        chat?.title =  idString
     
        
        
<<<<<<< HEAD
       self.tabBarController?.tabBar.isHidden=true
        self.navigationController?.show(chat!, sender: nil)
=======
      
        //self.navigationController?.show(chat!, sender: nil)
>>>>>>> e0ba979ea39fc66b5746dd074bfa840678dfe688
       // self.navigationController.
       // self.navigationController?.popToViewController(chat!, animated: true)
        self.navigationController?.pushViewController(chat!, animated: true)
        self.tabBarController?.tabBar.isHidden=true
       //self.present(chat!, animated: true, completion: nil)
    }
<<<<<<< HEAD
  
=======
   
>>>>>>> e0ba979ea39fc66b5746dd074bfa840678dfe688
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let personCell=tableView.dequeueReusableCell(withIdentifier: "PersonTableView") as! PersonTableViewCell
       
       
        let obj=dataArray[indexPath.row] as! AVObject
         let idString=obj["username"] as! String
          let experience=obj["experience"] as! String
          let myimge=obj["image"] as! AVFile
        
            personCell.ss.text = experience
            personCell.img.image=UIImage(data: myimge.getData()!)
            personCell.textLb.text=idString
            personCell.img.contentMode = .scaleAspectFit
            personCell.img.layer.cornerRadius=personCell.img.frame.size.width/2
            personCell.img.clipsToBounds=true
            return personCell
       
    }
   
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        if yOffset < headerHeight {// 当滑动到导航栏底部之前
            let alpha = yOffset/headerHeight
            navBarView.backgroundColor = UIColor.white.withAlphaComponent(alpha)
            
            navBarTitle.textColor = .white
         
          
            //navBarRightBtn.setImage(UIImage.init(named: "add.png"), for: .normal)
        } else {// 超过导航栏底部
            navBarView.backgroundColor = .white
            
            navBarTitle.textColor = .black
          
          
           // navBarRightBtn.setImage(UIImage.init(named: "add_sel.png"), for: .normal)
        }
        
        // 处理图片放大效果，往上移动效果
        if yOffset > 0 {// 往上移动
            var frame = originalFrame
            frame.origin.y = originalFrame.origin.y - yOffset
            bgImg.frame = frame
        } else { // 往上移动
            var frame = originalFrame
            frame.size.height = originalFrame.size.height - yOffset
            frame.size.width = frame.size.height/ratio
            frame.origin.x = originalFrame.origin.x - (frame.size.width - originalFrame.size.width)/2
            bgImg.frame = frame
        }
        
    }

    /**
     *  上拉加载 、 下拉刷新
     */
 func headerRefresh(){
        
   
        print("headerRefresh\n\n\n\n\n\n\n\n\n\n\n")
        let query = AVQuery(className: "Sharingexperience")
        query.order(byDescending: "createdAt")
        query.limit = 20
        query.skip = 0
        //  query.whereKey("user", equalTo: AVUser.current()
        
        query.findObjectsInBackground { (results, error) -> Void in
            
            if let Result=results{
                
                self.dataArray.addObjects(from: (Result))
                
                print("*****************\(self.dataArray.count)")
            }
            
          //  self.tableView?.mj_header.beginRefreshing()
            self.tableView?.reloadData()
          
        }
   
        
    }
    
// func footerRefresh(){
//    let query2 = AVQuery(className: "want")
//    query2.whereKey("kind", equalTo: "1")
//
//
//    //  query.whereKey("user", equalTo: AVUser.current()
//
//    query2.findObjectsInBackground { (results, error) -> Void in
//
//        if let Result=results{
//
//            self.dataArray2.addObjects(from: (Result))
//            let obj2=self.dataArray2[0] as! AVObject
//            let myname=obj2["username"] as! String
//            for i in 0..<self.dataArray.count
//            {
//                let obj=self.dataArray[i] as! AVObject
//
//                let idString=obj["username"] as! String
//                print("username\(myname),idString\(idString)")
//                if idString==myname
//                {
//                    self.dataArray.removeObject(at: i)
//                }
//
//
//
//            }
//            print("*****************2\(self.dataArray2.count)")
//            print("*****************1\(self.dataArray.count)")
//        }
//
//        //  self.tableView?.mj_header.beginRefreshing()
//        self.tableView?.reloadData()
//
//    }
//
//    }
//    func requestToken1(userID:String) -> Void {
//        let dicUser = ["userId":userID,
//                       "name":userID,
//                       "portraitUrl":"http://img3.duitang.com/uploads/item/201508/30/20150830083023_N3rTL.png"
//        ] //请求token的用户信息
//        let urlStr = "https://api.cn.ronghub.com/user/getToken.json" //网址接口
//        let appKey = "kj7swf8ok3ht2"
//        let appSecret = "d90NwSZPS6YU"
//        let nonce = "\(arc4random())"   //生成随机数
//        let timestamp = "\(NSDate().timeIntervalSince1970)"//时间戳
//        var sha1Value = appSecret + nonce + timestamp
//        sha1Value = sha1Value.sha1()//数据签名,sha1是一个加密的方法
//        let headers = [ //照着文档要求写的Http 请求的 4个head
//            "App-key":appKey
//            ,"Nonce":nonce
//            ,"Timestamp":timestamp
//            ,"Signature":sha1Value
//        ]
//        Alamofire.request(urlStr, method: .post, parameters: dicUser , encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
//            print(response)
//            if let dic = response.result.value  as? NSDictionary{
//                let code = dic.value(forKey: "code") as! NSNumber
//                if code.stringValue == "200" {
//                    print(dic.value(forKey: "token"))
//                    self.token=dic.value(forKey: "token") as! String
//                    
//                    print("sadfasf  "+self.token)
//                    self.ConnectOne()
//                }
//            }
//        }
//    }
//    
//    func ConnectOne()->Void{
//        RCIM.shared().initWithAppKey("3argexb630cme")
//        
//        
//        RCIM.shared().connect(withToken: token,success: { (userId) -> Void in
//            print("登陆成功。当前登录的用户ID：\(userId)")
//        }, error: { (status) -> Void in
//            print("登陆的错误码为:\(status.rawValue)")
//        }, tokenIncorrect: {
//            //token过期或者不正确。
//            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
//            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
//            print("token错误")
//        })
//        
//    }
}

