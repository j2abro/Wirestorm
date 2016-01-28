//
//  SecondVC.swift
//  Wirestorm
//
//  Created by j2 on 1/28/16.
//  Copyright © 2016 Blue Motion Labs. All rights reserved.
//

import UIKit

class SecondVC: UIViewController {

    @IBOutlet var mainImageView: UIImageView!
    
    var imageUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let defaultImage = UIImage(named: "default")
        
        if let imageUrl = NSURL(string: imageUrl) {
            mainImageView.af_setImageWithURL(imageUrl, placeholderImage: defaultImage)
        } else {
            mainImageView.image = defaultImage
        }
    }

    

}
