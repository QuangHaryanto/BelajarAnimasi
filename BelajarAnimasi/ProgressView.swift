//
//  ProgressView.swift
//  BelajarAnimasi
//
//  Created by Haryanto Salim on 06/06/20.
//  Copyright © 2020 Haryanto Salim. All rights reserved.
//

import Foundation
import UIKit

class ProgressView: UIView {
    
    /// The progress bar which adjusts width based on progress.
    private var progressBar: UIView!
    
    /// Progress on the track [0.0, 1.0]. Animatable.
    @objc dynamic var progress: CGFloat {
        set { progressLayer.progress = newValue }
        get { return progressLayer.progress }
    }
    
    /// Display color of the progress bar. Animatable.
    @objc dynamic var color: UIColor {
        set { progressLayer.color = newValue.cgColor }
        get { return UIColor(cgColor: progressLayer.color) }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.progress = 0.0
        self.color = .black
        
        progressBar = UIView(frame: .zero)
        progressBar.backgroundColor = color
        addSubview(progressBar)
    }
    
    override class var layerClass: AnyClass {
        return ProgressLayer.self
    }
    
    private var progressLayer: ProgressLayer {
        return layer as! ProgressLayer
    }
    
    override func display(_ layer: CALayer) {
        guard let presentationLayer = layer.presentation() as? ProgressLayer else {
            return
        }
        
        // Use presentationLayer's interpolated property value(s) to update UI components.
        let clampedProgress = max(0.0, min(1.0, presentationLayer.progress))
        let newWidth = layer.bounds.width * clampedProgress
        progressBar.frame = CGRect(x: 0, y: 0, width: newWidth, height: bounds.height)
        progressBar.backgroundColor = UIColor(cgColor: presentationLayer.color)
    }
}
