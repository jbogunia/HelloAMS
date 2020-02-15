//
//  ViewController.swift
//  HelloAMS
//
//  Created by Jakub Bogunia on 16/12/2019.
//  Copyright © 2019 Jakub Bogunia. All rights reserved.
//

import UIKit
import Alamofire
import BRYXBanner
import LoadingShimmer

class ViewController: UIViewController {
    
    

    @IBOutlet weak var activityView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    

    @IBAction func buttonClick(_ sender: Any) {
        
        LoadingShimmer.startCovering(activityView, with: ["Loading..."])
        AF.request("https://www.boredapi.com/api/activity/").responseJSON { (response) -> Void in
            switch response.result {
            case .success(let value):
                LoadingShimmer.stopCovering(self.activityView)
                if let JSON = value as? [String: Any] {
                    let activity = JSON["activity"] as! String;
                    self.activityView.text = activity;
                }
            case .failure(let error):
                LoadingShimmer.stopCovering(self.activityView)
                let banner = Banner(title: "Error!", subtitle: "Something went wrong :(", image: UIImage(named: "Icon"), backgroundColor: UIColor(red:198.0/255.0, green:26.00/255.0, blue:27.0/255.0, alpha:1.000))
                banner.dismissesOnTap = true
                banner.show(duration: 3.0)
                break
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2 , execute:  {
                
                let banner = Banner(title: "Success!", subtitle: "Activity downloaded", image: UIImage(named: "Icon"), backgroundColor: UIColor(red:48.00/255.0, green:174.0/255.0, blue:51.5/255.0, alpha:1.000))
                banner.dismissesOnTap = true
                banner.show(duration: 3.0)
            })
            
        }
    }
    


}

