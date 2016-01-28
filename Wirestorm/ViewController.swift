//
//  ViewController.swift
//  Wirestorm
//
//  Created by j2 on 1/28/16.
//  Copyright © 2016 Blue Motion Labs. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tblView: UITableView!
    
    var tableList: [(name: String, position: String, smallpic: String, lrgpic: String)] = []
    
    let cellIdentifier = "basicCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.delegate = self
        tblView.dataSource = self
        
        var detailName = ""
        var dtailImage = ""
        
        let url = "https://s3-us-west-2.amazonaws.com/wirestorm/assets/response.json"
        
        loadTable(url)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableList.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCellWithIdentifier(cellIdentifier)
        
        let defaultImage = UIImage(named: "default")
        
        if let imageUrl = NSURL(string: tableList[indexPath.row].smallpic) {
            cell?.imageView?.af_setImageWithURL(imageUrl, placeholderImage: defaultImage)
        } else {
            cell?.imageView?.image = defaultImage
        }
        
        cell?.textLabel?.text = tableList[indexPath.row].name
        cell?.detailTextLabel!.text = tableList[indexPath.row].position
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showSecond", sender: self)
    }
    
    func loadTable(url: String) {
        
        Alamofire.request(.GET, url)
            .responseJSON { response in
                
                switch response.result {
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    
                case .Success(let remoteJSON):
                    
                    let json = JSON(remoteJSON)
                    
                    print(json)
                    var name = ""
                    var position = ""
                    var smallpic = ""
                    var lrgpic = ""
                    
                    guard let items = json.array else {
                        print("JSON error")
                        return
                    }
                    
                    for item in items {
                        if let nameTmp = item["name"].string {
                            name = nameTmp
                        }
                        
                        if let positionTmp = item["position"].string {
                            position = positionTmp
                        }
                        
                        if let smallpicTmp = item["smallpic"].string {
                            smallpic = smallpicTmp
                        }
                        
                        if let lrgpicTmp = item["lrgpic"].string {
                            lrgpic = lrgpicTmp
                        }
                        
                        //position = item["position"].string
                        //smallPic = item["smallPic"].string
                        //lrgPic = item["lrgPic"].string
                        
                        print("--> \(name)")
                        print("--> \(position)")
                        print("--> \(smallpic)")
                        print("--> \(lrgpic)")
                        print("-------------")
                        
                        self.tableList.append((name: name, position: position, smallpic: smallpic, lrgpic: lrgpic))
                    }
                    
                    
                    //print(json)
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.tblView.reloadData()
                    }
                } //end Switch
        } //end Alamofire request block
    }



}

