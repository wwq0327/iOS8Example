//
//  DiaryAnimator.swift
//  Diary
//
//  Created by wyatt on 15/6/14.
//  Copyright (c) 2015年 Wanqing Wang. All rights reserved.
//

import UIKit

class DiaryAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var operation: UINavigationControllerOperation!
    
    //转场时长
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // 获取转场舞台
        let containerView = transitionContext.containerView()
        
        // 从哪个场景开始转
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let fromView = fromVC!.view
        
        // 要转到哪个场景去
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let toView = toVC!.view
        
        toView?.alpha = 0.0
        
        if operation == UINavigationControllerOperation.Pop {
            toView?.transform = CGAffineTransformMakeScale(1.0, 1.0)
        } else {
            toView?.transform = CGAffineTransformMakeScale(0.3, 0.3)
        }
        
        containerView.insertSubview(toView, aboveSubview: fromView)
        
        // 开始进行动画
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            if self.operation == UINavigationControllerOperation.Pop {
                fromView.transform = CGAffineTransformMakeScale(3.3, 3.3)
            } else {
                toView.transform = CGAffineTransformMakeScale(1.0, 1.0)
            }
            toView.alpha = 1.0
        }) { finished in
            transitionContext.completeTransition(true)
        }
    }
}
