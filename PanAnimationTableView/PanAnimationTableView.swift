//
//  SwipAnimationScrollView.swift
//  WeddingMemory
//
//  Created by mac on 16/6/17.
//  Copyright © 2016年 jason.wang. All rights reserved.
//

import UIKit

typealias PanTableViewReachTopViewBottomClosure = (isTopDirection:Bool) -> Void

class PanAnimationTableView: UITableView , UITableViewDelegate {
    /// 保存上次的contentOffSetY值 , 用于判断滚动方向
    private var previousContentOffSetY:CGFloat!
    private var topViewHeight:CGFloat!
    private var originWidth:CGFloat! = 0
    private var originHeight:CGFloat! = 0
        
    /// 滚动到topView的最下部分时调用
    var reachbottomClosure:PanTableViewReachTopViewBottomClosure!
    
    /// 先设置settingInfo后再设置topView
    var settingInfo:SwipAnimationViewInfo = SwipAnimationViewInfo()
    
    var topView:UIView? {
        didSet {
            
            let view = UIView.init(frame: CGRectMake(0, 0, self.frame.width, settingInfo.headerViewActualHeight))
            view.alpha = 0
            self.tableHeaderView = view
            
            originWidth = topView?.frame.width
            topView?.frame = CGRectMake(0, -settingInfo.headerViewHiddenHeight, originWidth, settingInfo.headerViewHiddenHeight * 2 + settingInfo.headerViewActualHeight)
            originHeight = topView?.frame.height
            
            self.insertSubview(topView!, atIndex: 0)
        }
    }
    
    /**
     *  页面设置信息
     */
     struct SwipAnimationViewInfo { //通过设置settingInfo的隐藏高度和显示高度来最终确定topView的height , 直接设置topView的frame , frame的y和height无效
        /// 上方headerView上下隐藏部分高度
        var headerViewHiddenHeight:CGFloat = 40
        
        /// 上方headerView的露出的实际显示高度
        var headerViewActualHeight:CGFloat = 150
        
        /// 上部页面跟随下部页面的动画方式
        var followAnimationType:TopViewAnimationType = .HoldAndStretch
        
        var stretchType:StretchType = .SameRate
    }
    
    /**
    *  页面滑动时 , 上部画面的动画
    */
    enum TopViewAnimationType {
        /**
         *  页面滑动时 , 上部画面保持原位
         */
        case Hold
        /**
         *  页面滑动时 , 上部画面保持原位 , 并且到最顶部时有拉伸动画
         */
         case HoldAndStretch
        /**
         *  页面滑动时 , 上部画面的位移与下部页面一致 , 即页面同步
         */
        case Follow
        /**
         页面滑动时 , 上部画面的位移与下部页面一致 , 即页面同步 , 并到底后有拉伸
         */
        case FollowAndStretch
    }
    
    enum StretchType {
        /// 同比例缩放
        case SameRate
        /// 宽度方向不缩放
        case Equal
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError()
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: .Plain)
        self.delegate = self
        self.clipsToBounds = false
    }
    
    func addContentView(view:UIView) {
        view.frame = CGRectMake(view.frame.origin.x, settingInfo.headerViewActualHeight - view.frame.height, view.frame.width, view.frame.height)
        self.addSubview(view)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        switch settingInfo.followAnimationType {
        case .Follow : self.headerAnimationFollow(scrollView.contentOffset.y)
        case .Hold : self.headerAnimationHold(scrollView.contentOffset.y)
        case .HoldAndStretch : self.headerAnimationHoldAndStretch(scrollView.contentOffset.y)
        case .FollowAndStretch : self.headerAnimationFollowAndStretch(scrollView.contentOffset.y)
        }
        // 判断是否滚动到上方view的最下部
        if abs(scrollView.contentOffset.y - settingInfo.headerViewActualHeight) < 20 {
            if reachbottomClosure != nil {
                reachbottomClosure!(isTopDirection: scrollView.contentOffset.y > previousContentOffSetY)
            }
        }
        previousContentOffSetY = scrollView.contentOffset.y
    }
    
    // 不同的animationType作不同的动画处理
    func headerAnimationFollow(contentOffSetY:CGFloat) {
        if contentOffSetY <= 0 && contentOffSetY >= -settingInfo.headerViewHiddenHeight * 2.0 {
            topView?.frame = CGRectMake(0, -settingInfo.headerViewHiddenHeight + contentOffSetY / 2.0, self.originWidth, self.originHeight)
        }
    }
    
    func headerAnimationFollowAndStretch(contentOffSetY:CGFloat) {
        self.headerAnimationFollow(contentOffSetY)
        if contentOffSetY <= -settingInfo.headerViewHiddenHeight * 2.0  {
            let actualOffSetY = -contentOffSetY - settingInfo.headerViewHiddenHeight * 2
            var actualOffSetX:CGFloat = 0
            if settingInfo.stretchType == .Equal {
                actualOffSetX = 0
            } else {
                actualOffSetX = actualOffSetY * originWidth / originHeight
            }
            self.topView?.frame = CGRectMake(-actualOffSetX / 2.0, contentOffSetY, self.originWidth + actualOffSetX, self.originHeight + actualOffSetY)
        }
    }
    
    func headerAnimationHold(contentOffSetY:CGFloat) {
        if contentOffSetY < settingInfo.headerViewActualHeight && contentOffSetY > 0 {
            //保持不动
            topView?.frame = CGRectMake(0, -settingInfo.headerViewHiddenHeight + contentOffSetY, topView!.frame.width, (topView?.frame.height)!)
        } else if contentOffSetY <= 0 && contentOffSetY >= -settingInfo.headerViewHiddenHeight * 2.0 {
            topView?.frame = CGRectMake(0, -settingInfo.headerViewHiddenHeight + contentOffSetY / 2.0, self.originWidth, self.originHeight)
        }
    }
    
    func headerAnimationHoldAndStretch(contentOffSetY:CGFloat) {
        self.headerAnimationHold(contentOffSetY)
        if contentOffSetY <= -settingInfo.headerViewHiddenHeight * 2.0 {
            //减去隐藏高度算出实际y轴偏移量
            let actualOffSetY = -contentOffSetY - settingInfo.headerViewHiddenHeight * 2
            var actualOffSetX:CGFloat = 0
            if settingInfo.stretchType == .Equal {
                actualOffSetX = 0
            } else {
                actualOffSetX = actualOffSetY * originWidth / originHeight
            }
            //根据偏移量计算新的frame
            self.topView?.frame = CGRectMake(-actualOffSetX / 2.0, contentOffSetY, self.originWidth + actualOffSetX, self.originHeight + actualOffSetY)
        }
    }
}
