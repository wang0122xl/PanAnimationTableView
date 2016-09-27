//
//  ViewController.swift
//  PanAnimationTableView
//
//  Created by mac on 16/6/27.
//  Copyright © 2016年 jason.wang. All rights reserved.
//

import UIKit

var SCREEN_WIDTH:CGFloat = UIScreen.main.bounds.width
var SCREEN_HEIGHT:CGFloat = UIScreen.main.bounds.height


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false

        self.navigationController?.pushViewController(TestPanAnimationViewController(), animated: true)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

