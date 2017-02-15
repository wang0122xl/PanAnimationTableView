//
//  TestPanAnimationViewController.swift
//  WeddingMemory
//
//  Created by mac on 16/6/22.
//  Copyright © 2016年 jason.wang. All rights reserved.
//

import UIKit

let cellIdentify:String = "cellIdentify"

let SCREEN_WIDTH:CGFloat = UIScreen.main.bounds.width
let SCREEN_HEIGHT:CGFloat = UIScreen.main.bounds.height

class TestPanAnimationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {



    private var mainTableView:PanAnimationTableView!
    
    private var selectBtn:UIButton!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.gray
        self.title = "PanAnimationTableView"

        mainTableView = PanAnimationTableView.init(frame: CGRect.init(x:0, y:0, width:SCREEN_WIDTH, height:self.view.frame.height), style: UITableViewStyle.plain)
        mainTableView.reachbottomClosure = reachBottom
        
        mainTableView.settingInfo.followAnimationType = .HoldAndStretch
        mainTableView.settingInfo.headerViewActualHeight = 230
        mainTableView.settingInfo.headerViewHiddenHeight = 25
        mainTableView.tableFooterView = UIView.init()
        
        let imageView = UIImageView.init(image: UIImage.init(named: "ComicPicture3"))
        imageView.frame = CGRect.init(x:0, y:0, width:SCREEN_WIDTH, height:0)
        mainTableView.topView = imageView
        
        self.setContentView()
        
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        self.view.addSubview(mainTableView)
    }
    
    func setContentView() {
        let height:CGFloat = 44
        let eachWidth:CGFloat = SCREEN_WIDTH / 4.0
        let bgView = UIView.init(frame: CGRect.init(x:0, y:0, width:SCREEN_WIDTH, height:height))
        bgView.backgroundColor = UIColor.darkGray
        bgView.alpha = 0.7
        
        mainTableView.addContentView(view: bgView)
        
        let follow = UIButton.init(frame: CGRect.init(x:0, y:0, width:eachWidth, height:height))
        follow.setTitle("Follow", for: .normal)
        follow.setTitleColor(UIColor.white, for: .normal)
        follow.setTitleColor(UIColor.orange, for: .selected)
        follow.addTarget(self, action: #selector(followAction), for: .touchUpInside)
        bgView.addSubview(follow)
        
        let followAndStretch = UIButton.init(frame: CGRect.init(x:eachWidth, y:0, width:eachWidth, height:height))
        followAndStretch.setTitle("FollowAndStretch", for: .normal)
        followAndStretch.setTitleColor(UIColor.white, for: .normal)
        followAndStretch.setTitleColor(UIColor.orange, for: .selected)
        followAndStretch.addTarget(self, action: #selector(followAndStretchAction), for: .touchUpInside)
        bgView.addSubview(followAndStretch)
        
        let hold = UIButton.init(frame: CGRect.init(x:eachWidth * 2, y:0, width:eachWidth, height:height))
        hold.setTitle("Hold", for: .normal)
        hold.setTitleColor(UIColor.white, for: .normal)
        hold.setTitleColor(UIColor.orange, for: .selected)
        hold.addTarget(self, action: #selector(holdAction), for: .touchUpInside)
        bgView.addSubview(hold)
        
        let holdAndStretch = UIButton.init(frame: CGRect.init(x:eachWidth * 3, y:0, width:eachWidth, height:height))
        holdAndStretch.setTitle("HoldAndStretch", for: .normal)
        holdAndStretch.setTitleColor(UIColor.white, for: .normal)
        holdAndStretch.setTitleColor(UIColor.orange, for: .selected)
        holdAndStretch.addTarget(self, action: #selector(holdAndStretchAction), for: .touchUpInside)
        selectBtn = holdAndStretch
        selectBtn.isSelected = true
        bgView.addSubview(holdAndStretch)
    }
    
    func followAction(btn:UIButton) {
        selectBtn.isSelected = false
        btn.isSelected = !btn.isSelected
        selectBtn = btn
        mainTableView.settingInfo.followAnimationType = .Follow
    }
    
    func followAndStretchAction(btn:UIButton) {
        selectBtn.isSelected = false
        btn.isSelected = !btn.isSelected
        selectBtn = btn
        mainTableView.settingInfo.stretchType = .StretchEqual
        mainTableView.settingInfo.followAnimationType = .FollowAndStretch
    }
    
    func holdAction(btn:UIButton) {
        selectBtn.isSelected = false
        btn.isSelected = !btn.isSelected
        selectBtn = btn
        mainTableView.settingInfo.followAnimationType = .Hold
    }
    
    func holdAndStretchAction(btn:UIButton) {
        selectBtn.isSelected = false
        btn.isSelected = !btn.isSelected
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let imageView = UIImageView.init(image: UIImage.init(named: "ComicPicture2"))
        
        
        return imageView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentify)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentify)
            
            switch indexPath.row % 7 {
            case 0 : cell!.backgroundColor = UIColor.blue
            case 1 : cell!.backgroundColor = UIColor.green
            case 2 : cell!.backgroundColor = UIColor.red
            case 3 : cell!.backgroundColor = UIColor.yellow
            case 5 : cell!.backgroundColor = UIColor.purple
            case 6 : cell!.backgroundColor = UIColor.orange
            default : cell!.backgroundColor = UIColor.lightGray
            }
        }
        return cell!
    }
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        mainTableView.scrollViewDidScroll(mainTableView)
    }
}
