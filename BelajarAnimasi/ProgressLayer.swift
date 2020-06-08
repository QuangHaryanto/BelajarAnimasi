//
//  ProgressLayer.swift
//  BelajarAnimasi
//
//  Created by Haryanto Salim on 06/06/20.
//  Copyright © 2020 Haryanto Salim. All rights reserved.
//

import Foundation
import UIKit

class ProgressLayer: CALayer {
    @NSManaged var progress: CGFloat
    @NSManaged var color: CGColor
    
    // Whenever a new presentation layer is created, this function is called and makes a COPY of the object.
    override init(layer: Any) {
        super.init(layer: layer)
        if let layer = layer as? ProgressLayer {
            progress = layer.progress
            color = layer.color
        }
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override class func needsDisplay(forKey key: String) -> Bool {
        if isAnimationKeySupported(key) {
            return true
        }
        return super.needsDisplay(forKey: key)
    }
    
    override func action(forKey event: String) -> CAAction? {
        if ProgressLayer.isAnimationKeySupported(event) {
            // Copy animation context and mutate as needed
            guard let animation = currentAnimationContext(in: self)?.copy() as? CABasicAnimation else {
                setNeedsDisplay()
                return nil
            }
            
            animation.keyPath = event
            if let presentation = presentation() {
                animation.fromValue = presentation.value(forKeyPath: event)
            }
            animation.toValue = nil
            return animation
        }
        
        return super.action(forKey: event)
    }
    
    private class func isAnimationKeySupported(_ key: String) -> Bool {
        return key == #keyPath(progress) || key == #keyPath(color)
    }
    
    private func currentAnimationContext(in layer: CALayer) -> CABasicAnimation? {
        /// The UIView animation implementation is private, so to check if the view is animating and
        /// get its property keys we can use the key "backgroundColor" since its been a property of
        /// UIView which has been forever and returns a CABasicAnimation.
        return action(forKey: #keyPath(backgroundColor)) as? CABasicAnimation
    }
}
