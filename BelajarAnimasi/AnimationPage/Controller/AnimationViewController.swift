//
//  AnimationViewController.swift
//  BelajarAnimasi
//
//  Created by Handy Handy on 08/06/20.
//  Copyright © 2020 Haryanto Salim. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {
    
    // MARK: - Step 1
    // Create the ball and size of the ball
    let ball = UIView()
    let size = CGSize(width: 100, height: 100)
    // ---- End of Step 1
    
    // MARK: - Step 5
    var isPulse = true
    var animationProperty = UIViewPropertyAnimator()
    // ---- End of Step 5
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBall()
    }

    // MARK: - Step 2
    // Create the ball programmaticaly
    private func setupBall() {
        ball.frame.size = size
        ball.center = self.view.center
        ball.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        ball.layer.cornerRadius = size.width / 2
        ball.layer.masksToBounds = true
        
        ball.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ball.layer.borderWidth = 2
        // ---- Cont of Step 2, dont forget to add the function in viewDidLoad and
        // the below of the function about addSubView
        
        // MARK: - Step 4
        // Create the tap gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(ballDidTap))
        ball.addGestureRecognizer(tap)
        // ---- End of Step 4
        
        // MARK: - Step 8
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ballDragged(_:)))
        ball.addGestureRecognizer(pan)
        // ---- End of Step 8
        
        // MARK: - Step 11
        let hold = UILongPressGestureRecognizer(target: self, action: #selector(ballHold))
        ball.addGestureRecognizer(hold)
        // ---- End of Step 11
        
        // MARK: - Cont Step 2
        view.addSubview(ball)
        pulseBall()
        // ---- End of Step 2
    }
    
    // MARK: - Step 6
    // Create the tap gesture
    @objc func ballDidTap () {
        animationProperty = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: {
            self.ball.alpha = 0
        })
        animationProperty.addCompletion { (position) in
            if position == .end {
                self.isPulse = false
                self.resetBall()
            }
        }
        animationProperty.startAnimation()
    }
    // ---- End of Step 6
    
    // MARK: - Step 9
    @objc func ballDragged(_ sender: UIPanGestureRecognizer) {
        if !isPulse {
            view.bringSubviewToFront(ball)
            let translation = sender.translation(in: view)
            ball.center = CGPoint(x: ball.center.x + translation.x, y: ball.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: view)
            if sender.state == .ended {
                animateBallToCenter()
            }
        }
    }
    // ---- End of Step 9
    
    // MARK: - Step 12
    @objc func ballHold(_ sender: UILongPressGestureRecognizer) {
        if !isPulse && sender.state == .began {
            ballZoomingOut()
        }
    }
    // ---- End of Step 12
    
    
    // MARK: - Step 3
    // Create the function to pulse the ball
    private func pulseBall() {
        // Step 1 with simplest animation
        /*
         UIView.animate(withDuration: 3) {
         self.ball.frame.size.width = self.size.width * 1.2
         self.ball.frame.size.height = self.size.height * 1.2
         self.ball.layer.cornerRadius = self.size.width * 0.6
         }
         */
        
        // Step 2 with auto reverse option
        UIView.animate(
            withDuration: 2,
            delay: 1,
            options: [.autoreverse, .repeat, .allowUserInteraction],
            animations: {
                // after using this function, introduce student with CGAffineTransform
                /*
                 self.ball.frame.size.width = self.size.width * 1.2
                 self.ball.frame.size.height = self.size.height * 1.2
                 self.ball.layer.cornerRadius = self.size.width * 0.6
                 */
                
                self.ball.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: nil)
        
    }
    // ---- End of Step 3
    
    // MARK: - Step 10
    private func animateBallToCenter() {
        let animator = UIViewPropertyAnimator(duration: 0.8, dampingRatio: 0.2, animations: {
            self.ball.center = self.view.center
        })
        animator.startAnimation()
    }
    // ---- End of Step 10
    
    // MARK: - Step 13
    private func ballZoomingOut() {
        UIView.animateKeyframes(withDuration: 1, delay: 0, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.ball.transform = CGAffineTransform(scaleX: 10, y: 10)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2) {
                self.ball.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2) {
                self.ball.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.2) {
                self.ball.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2) {
                self.ball.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) {
                self.ball.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
            }
        }) { (isAnimated) in
            self.ballDidTap()
        }
    }
    // ---- End of Step 13
    
    // MARK: - Step 7
    // Create reset ball function
    private func resetBall() {
        // this function used for remove all animation and reset it
        ball.layer.removeAllAnimations()
        ball.transform = .identity
        UIView.animate(withDuration: 1) {
            self.ball.alpha = 1
        }
    }
    // ---- End of Step 7
}
