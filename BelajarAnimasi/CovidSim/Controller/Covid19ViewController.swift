//
//  Covid19ViewController.swift
//  BelajarAnimasi
//
//  Created by Haryanto Salim on 08/06/20.
//  Copyright © 2020 Haryanto Salim. All rights reserved.
//

import UIKit

class Covid19ViewController: UIViewController {
    
    var dynamicAnimator   : UIDynamicAnimator!
    var gravityBehavior   : UIGravityBehavior!
    var collisionBehavior : UICollisionBehavior!
    
    var bolaArray: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupButton()
    }
    
    func setupButton(){
        let myButton = UIButton(frame: CGRect(x: 100.0, y: 100.0, width: 150.0, height: 30.0))
        myButton.setTitle("Create A ball", for: .normal)
        myButton.setTitleColor(.blue, for: .normal)
        myButton.backgroundColor = .yellow
        myButton.addTarget(self, action: #selector(membuatSebuahBola(sender:)), for: .touchUpInside)
        view.addSubview(myButton)
    }
    
    @objc func membuatSebuahBola(sender: UIButton){
        
        let saveArea = view.safeAreaLayoutGuide
        let maxY = saveArea.layoutFrame.size.height
        let maxX = saveArea.layoutFrame.size.width
        
        //membuat uiview
        let randomX = randomizer(min: 0, max: UInt32(maxX))
        let randomY = randomizer(min: 0, max: UInt32(maxY))
        
        let diameter: CGFloat = randomizer(min: UInt32(10.0), max: UInt32(80.0))
        let posisiUkuran = CGRect(x: randomX, y: randomY, width: diameter, height: diameter)
        let bolaView = UIView(frame: posisiUkuran)
        bolaView.backgroundColor = UIColor.random()
        bolaView.layer.cornerRadius = diameter / 2
        
        bolaArray.append(bolaView)
        view.addSubview(bolaView)
        
        dynamicAnimator = UIDynamicAnimator(referenceView: view) //1
        
        gravityBehavior = UIGravityBehavior(items: bolaArray) //2
        dynamicAnimator.addBehavior(gravityBehavior) //3
        
        collisionBehavior = UICollisionBehavior(items: bolaArray) //4
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true //5
        collisionBehavior.collisionMode = .everything
        
        dynamicAnimator.addBehavior(collisionBehavior) //6
    }
    
    func randomizer(min: UInt32, max: UInt32) -> CGFloat {
        
        assert(min < max)
        return CGFloat(arc4random_uniform(max - min)  + min)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red:   .random(),
            green: .random(),
            blue:  .random(),
            alpha: 1.0
        )
    }
    static func CGColorRandom() -> CGColor {
        return CGColor(srgbRed: .random(), green: .random(), blue: .random(), alpha: 1.0)
    }
}

class CircleView: UIView {
    var lineWidth: CGFloat = 3

    var shapeLayer: CAShapeLayer = {
        let _shapeLayer = CAShapeLayer()
        _shapeLayer.strokeColor = UIColor.blue.cgColor
        _shapeLayer.fillColor = UIColor.blue.withAlphaComponent(0.5).cgColor
        return _shapeLayer
    }()

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.addSublayer(shapeLayer)
        shapeLayer.lineWidth = lineWidth
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        shapeLayer.path = circularPath(lineWidth: lineWidth, center: center).cgPath
    }

    private func circularPath(lineWidth: CGFloat = 0, center: CGPoint = .zero) -> UIBezierPath {
        let radius = (min(bounds.width, bounds.height) - lineWidth) / 2
        return UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
    }

    override var collisionBoundsType: UIDynamicItemCollisionBoundsType { return .path }

    override var collisionBoundingPath: UIBezierPath { return circularPath() }
}
