//
//  TestPanAnimationViewController.swift
//  WeddingMemory
//
//  Created by mac on 16/6/22.
//  Copyright © 2016年 jason.wang. All rights reserved.
//

import UIKit

let cellIdentify:String = "cellIdentify"


class TestPanAnimationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


    private var mainTableView:PanAnimationTableView!
    
    private var selectBtn:UIButton!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.grayColor()
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        mainTableView = PanAnimationTableView.init(frame: CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.height), style: UITableViewStyle.Plain)
        mainTableView.reachbottomClosure = reachBottom
        
        mainTableView.settingInfo.followAnimationType = .HoldAndStretch
        mainTableView.settingInfo.headerViewActualHeight = 240
        mainTableView.settingInfo.headerViewHiddenHeight = 20
        
        let imageView = UIImageView.init(image: UIImage.init(named: "ComicPicture3"))
        imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0)
        mainTableView.topView = imageView
        
        self.setContentView()
        
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        self.view.addSubview(mainTableView)
    }
    
    func setContentView() {
        let height:CGFloat = 44
        let eachWidth:CGFloat = SCREEN_WIDTH / 4.0
        let bgView = UIView.init(frame: CGRectMake(0, 0, SCREEN_WIDTH, height))
        bgView.backgroundColor = UIColor.darkGrayColor()
        bgView.alpha = 0.7
        
        mainTableView.addContentView(bgView)
        
        let follow = UIButton.init(frame: CGRectMake(0, 0, eachWidth, height))
        follow.setTitle("Follow", forState: .Normal)
        follow.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        follow.setTitleColor(UIColor.orangeColor(), forState: .Selected)
        follow.addTarget(self, action: #selector(followAction), forControlEvents: .TouchUpInside)
        bgView.addSubview(follow)
        
        let followAndStretch = UIButton.init(frame: CGRectMake(eachWidth, 0, eachWidth, height))
        followAndStretch.setTitle("FollowAndStretch", forState: .Normal)
        followAndStretch.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        followAndStretch.setTitleColor(UIColor.orangeColor(), forState: .Selected)
        followAndStretch.addTarget(self, action: #selector(followAndStretchAction), forControlEvents: .TouchUpInside)
        bgView.addSubview(followAndStretch)
        
        let hold = UIButton.init(frame: CGRectMake(eachWidth * 2, 0, eachWidth, height))
        hold.setTitle("Hold", forState: .Normal)
        hold.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        hold.setTitleColor(UIColor.orangeColor(), forState: .Selected)
        hold.addTarget(self, action: #selector(holdAction), forControlEvents: .TouchUpInside)
        bgView.addSubview(hold)
        
        let holdAndStretch = UIButton.init(frame: CGRectMake(eachWidth * 3, 0, eachWidth, height))
        holdAndStretch.setTitle("HoldAndStretch", forState: .Normal)
        holdAndStretch.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        holdAndStretch.setTitleColor(UIColor.orangeColor(), forState: .Selected)
        holdAndStretch.addTarget(self, action: #selector(holdAndStretchAction), forControlEvents: .TouchUpInside)
        selectBtn = holdAndStretch
        selectBtn.selected = true
        bgView.addSubview(holdAndStretch)
    }
    
    func followAction(btn:UIButton) {
        selectBtn.selected = false
        btn.selected = !btn.selected
        selectBtn = btn
        mainTableView.settingInfo.followAnimationType = .Follow
    }
    
    func followAndStretchAction(btn:UIButton) {
        selectBtn.selected = false
        btn.selected = !btn.selected
        selectBtn = btn
        mainTableView.settingInfo.stretchType = .StretchEqual
        mainTableView.settingInfo.followAnimationType = .FollowAndStretch
    }
    
    func holdAction(btn:UIButton) {
        selectBtn.selected = false
        btn.selected = !btn.selected
        selectBtn = btn
        mainTableView.settingInfo.followAnimationType = .Hold
    }
    
    func holdAndStretchAction(btn:UIButton) {
        selectBtn.selected = false
        btn.selected = !btn.selected
        selectBtn = btn
        mainTableView.settingInfo.stretchType = .StretchSameRate
        mainTableView.settingInfo.followAnimationType = .HoldAndStretch
    }
    
    func reachBottom(isTop:Bool) {
        if isTop {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        } else {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let imageView = UIImageView.init(image: UIImage.init(named: "ComicPicture2"))
        
        
        return imageView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentify)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentify)
            
            switch indexPath.row % 7 {
            case 0 : cell!.backgroundColor = UIColor.blueColor()
            case 1 : cell!.backgroundColor = UIColor.greenColor()
            case 2 : cell!.backgroundColor = UIColor.redColor()
            case 3 : cell!.backgroundColor = UIColor.yellowColor()
            case 5 : cell!.backgroundColor = UIColor.purpleColor()
            case 6 : cell!.backgroundColor = UIColor.orangeColor()
            default : cell!.backgroundColor = UIColor.lightGrayColor()
            }
        }
        return cell!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        mainTableView.scrollViewDidScroll(mainTableView)
    }
}
