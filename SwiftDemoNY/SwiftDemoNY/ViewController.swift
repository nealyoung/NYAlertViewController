//
//  ViewController.swift
//  SwiftDemoNY
//
//  Created by Bianca Tamayo on 10/30/17.
//  Copyright © 2017 Bianca Tamayo. All rights reserved.
//

import UIKit
import NYAlertViewController

class ViewController: UIViewController {
  @IBOutlet weak var ShowBtn: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func onShowButtonPress(_ sender: Any) {
    
    let nya = NYAlertViewController()
    self.present(nya, animated:true)
  }
}

