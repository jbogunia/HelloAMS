//
//  ViewController.swift
//  HelloAMS
//
//  Created by Jakub Bogunia on 16/12/2019.
//  Copyright © 2019 Jakub Bogunia. All rights reserved.
//

import UIKit
import SwiftSpinner
import Alamofire

class ViewController: UIViewController {
    
    
    @IBOutlet weak var factTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        factTextView.isEditable = false;
        
    }

    

    @IBAction func buttonClick(_ sender: Any) {
        SwiftSpinner.show("Connecting \nto satellite...").addTapHandler({
            SwiftSpinner.hide()
        })
        
        AF.request("https://cat-fact.herokuapp.com/facts/random").responseJSON { (response) -> Void in
            switch response.result {
            case .success(let value):
                if let JSON = value as? [String: Any] {
                    let text = JSON["text"] as! String;
                    self.factTextView.text = text;
                }
            case .failure(let error): break
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2 , execute:  {
                SwiftSpinner.hide()
            })
            
            
            
        }
    }
    


}

