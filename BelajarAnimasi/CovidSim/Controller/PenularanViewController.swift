//
//  PenularanViewController.swift
//  BelajarAnimasi
//
//  Created by Haryanto Salim on 08/06/20.
//  Copyright © 2020 Haryanto Salim. All rights reserved.
//

import UIKit

class PenularanViewController: UIViewController {

    var dynamicAnimator   : UIDynamicAnimator!
    var dynamicItemBehavior: UIDynamicItemBehavior!
    var dynamicBehavior : UIDynamicBehavior!
    var gravityBehavior   : UIGravityBehavior!
    var collisionBehavior : UICollisionBehavior!
    var pushBehavior: UIPushBehavior!
    
    var bolaArray: [MyImageView] = []
    
    var simTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupButton()
        
        simTimer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(runnedByTimer), userInfo: nil, repeats: true)

        simTimer?.fire()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        view.addGestureRecognizer(tap)
        
        dynamicAnimator = UIDynamicAnimator(referenceView: view) //1
        dynamicBehavior = UIDynamicBehavior()
        
//        gravityBehavior = UIGravityBehavior()
        collisionBehavior = UICollisionBehavior()
        
        //gravityBehavior = UIGravityBehavior(items: bolaArray) //2
        //        dynamicAnimator!.addBehavior(gravityBehavior!) //3
//        dynamicBehavior!.addChildBehavior(gravityBehavior!)
        
        //collisionBehavior = UICollisionBehavior(items: bolaArray) //4
        collisionBehavior!.collisionDelegate = self
        collisionBehavior!.translatesReferenceBoundsIntoBoundary = true //5
        collisionBehavior!.collisionMode = .items
        
        //dynamicAnimator!.addBehavior(collisionBehavior!)
        dynamicBehavior!.addChildBehavior(collisionBehavior!)
        
//        pushBehavior = UIPushBehavior(items: bolaArray, mode: .continuous)
//        pushBehavior = UIPushBehavior()
//        pushBehavior.setAngle(0, magnitude: 1)
//        dynamicBehavior!.addChildBehavior(pushBehavior!)
//
        
        dynamicAnimator!.delegate = self
//        dynamicItemBehavior = UIDynamicItemBehavior()
//        dynamicItemBehavior!.elasticity = 1
//        dynamicBehavior!.addChildBehavior(dynamicItemBehavior!)
        
        dynamicAnimator.addBehavior(dynamicBehavior)
    }
    
    @objc func didTap(_ sender: UITapGestureRecognizer){
        let point = sender.location(in: self.view)
        let x = point.x
        let y = point.y
        
        membuatBola(posisi: CGPoint(x: x, y: y))
        
        membuatAnimasiGerakanKurva(sky: view)
    }
    
    @objc func runnedByTimer(){
        let saveArea = view.safeAreaLayoutGuide
        let maxY = saveArea.layoutFrame.size.height
        let maxX = saveArea.layoutFrame.size.width

        let maxMovement: CGFloat = 30

        var randomX = 0
        var randomY = 0
        if bolaArray.count > 0 {
            for item in bolaArray{
                //randomX calculation
                if (item.center.x - maxMovement) < 0  {
                    randomX = Int(randomizer(min: UInt32(item.center.x), max: UInt32(item.center.x + maxMovement)))
                } else if (item.center.x + maxMovement) > maxX {
                    randomX = Int(randomizer(min: UInt32(item.center.x - maxMovement), max: UInt32(maxX)))
                }else{
                    randomX = Int(randomizer(min: UInt32(item.center.x - maxMovement), max: UInt32(item.center.x + maxMovement)))
                }
                //randomY calculation
                if (item.center.y - maxMovement) < 0  {
                    randomY = Int(randomizer(min: UInt32(item.center.y), max: UInt32(item.center.y + maxMovement)))
                } else if (item.center.y + maxMovement) > maxY {
                    randomY = Int(randomizer(min: UInt32(item.center.y - maxMovement), max: UInt32(maxY)))
                }else{
                    randomY = Int(randomizer(min: UInt32(item.center.y - maxMovement), max: UInt32(item.center.y + maxMovement)))
                }
                
                //item.center = CGPoint(x: randomX, y: randomY)
                
                item.move(newPosition: CGPoint(x: randomX, y: randomY))
            }
        }
    }
    
    
    func setupButton(){
        let myButton = UIButton(frame: CGRect(x: 100.0, y: 100.0, width: 150.0, height: 30.0))
        myButton.setTitle("Create Sample", for: .normal)
        myButton.setTitleColor(.blue, for: .normal)
        myButton.backgroundColor = .yellow
        myButton.addTarget(self, action: #selector(didTapButton(sender:)), for: .touchUpInside)
        view.addSubview(myButton)
    }
    
    func membuatAnimasiGerakanKurva(sky: UIView){
        let path = UIBezierPath()
        path.move(to: CGPoint(x: sky.frame.maxX, y: sky.frame.maxY))

        path.addQuadCurve(to: CGPoint(x: 0, y: sky.frame.maxY), controlPoint: CGPoint(x:sky.frame.maxX/2, y: 0))
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path.cgPath
        animation.repeatCount = 0
        animation.duration = 2.0
        
        let imageSunName = "jempol-emoji"
        let imageSun = UIImage(named: imageSunName)
        let imageView = UIImageView(image: imageSun)
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.view.addSubview(imageView)
        
        imageView.layer.add(animation, forKey: "animate along path")
        imageView.center = CGPoint(x: 0, y: sky.frame.maxY)
    }
    
    
    func membuatBola(posisi: CGPoint){
        let diameter: CGFloat = 20.0//randomizer(min: UInt32(10.0), max: UInt32(80.0))
        let posisiUkuran = CGRect(x: posisi.x, y: posisi.y, width: diameter, height: diameter)
        let bolaView = MyImageView(frame: posisiUkuran)
        bolaView.bounds = posisiUkuran
        bolaView.layer.bounds = posisiUkuran
        bolaView.layer.backgroundColor = UIColor.CGColorRandom()
        bolaView.layer.cornerRadius = diameter / 2
        bolaView.layer.borderWidth = 0.5
        bolaView.layer.borderColor = UIColor.CGColorRandom()
        bolaView.layer.masksToBounds = true
        bolaView.image = StarPolygonRenderer.image(withSize: CGSize(width: diameter, height: diameter))
        
        bolaArray.append(bolaView)
        view.addSubview(bolaView)
        
        //collisionBehavior.addItem(bolaView)
//        pushBehavior.addItem(bolaView)
//        dynamicItemBehavior.addItem(bolaView)
        //gravityBehavior.addItem(bolaView)
        
//        bolaView.animator.startAnimation()
        
    }
    
    @objc func didTapButton(sender: UIButton){
        
        let saveArea = view.safeAreaLayoutGuide
        let maxY = saveArea.layoutFrame.size.height
        let maxX = saveArea.layoutFrame.size.width
        
        //membuat uiview
        let randomX = randomizer(min: 0, max: UInt32(maxX))
        let randomY = randomizer(min: 0, max: UInt32(maxY))
        
        membuatBola(posisi: CGPoint(x: randomX, y: randomY))
        
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
    
    override func viewWillDisappear(_ animated: Bool) {
        simTimer?.invalidate()
    }
}

class MyImageView: UIImageView {
//extension UIView {
    //let animator = UIViewPropertyAnimator(duration: 2.0, curve: .linear)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.needsDisplayOnBoundsChange = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
//
    
    func move(newPosition: CGPoint){
//        UIView.animate(withDuration: 3.0) {
//            self.center = newPosition
//        }
        let animator = UIViewPropertyAnimator(duration:3.0, curve: .linear) { //1
            self.center = newPosition
        }
        animator.startAnimation()
//        animator.continueAnimation(withTimingParameters: animator.timingParameters, durationFactor: 2.0)
        
//        switch animator.state {
//        case .active:
//            //animator.stopAnimation(true)
//            print("active state")
//        case .inactive:
//
//            animator.addAnimations {
//                self.center = newPosition
//            }
//            animator.startAnimation()
//            print("inactive state")
//        case .stopped:
//            animator.finishAnimation(at: .current)
//            print("stopped")
//        @unknown default:
//             print("unknown state")
//        }
        
    }
}

extension PenularanViewController:  UICollisionBehaviorDelegate{
    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?) {
        print(item.center)
    }
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        print(item.center)
    }
}

extension PenularanViewController: UIDynamicAnimatorDelegate{

}


class StarPolygonRenderer {
    class func image(withSize size: CGSize, fillColor: UIColor = UIColor.yellow, pointCount: Int = 5, radiusRatio: CGFloat = 0.382) -> UIImage {
        let outerRadius = min(size.width, size.height) / 2
        let innerRadius = outerRadius * radiusRatio
        
        let centerX = size.width / 2
        let centerY = size.height / 2
        
        let renderer = UIGraphicsImageRenderer(size: size)
        
        let image = renderer.image { rendererContext in
            let cgContext = rendererContext.cgContext
            cgContext.setFillColor(fillColor.cgColor)
            
            let angleStride = (2 * CGFloat.pi) / CGFloat(pointCount)
            
            var outerAngle = CGFloat.pi / 2
            var innerAngle = outerAngle - (angleStride / 2)
            
            let topPoint = CGPoint(x: centerX + outerRadius * cos(outerAngle),
                                   y: centerY - outerRadius * sin(outerAngle))
            cgContext.move(to: topPoint)
            
            for _ in 0..<pointCount {
                outerAngle += angleStride
                innerAngle += angleStride
                
                let innerPoint = CGPoint(x: centerX + innerRadius * cos(innerAngle),
                                         y: centerY - innerRadius * sin(innerAngle))
                cgContext.addLine(to: innerPoint)
                
                let outerPoint = CGPoint(x: centerX + outerRadius * cos(outerAngle),
                                         y: centerY - outerRadius * sin(outerAngle))
                cgContext.addLine(to: outerPoint)
            }
            
            cgContext.fillPath()
        }
        
        return image
    }
}


class CardView : UIView
{
  // init the view with a rectangular frame
  override init(frame: CGRect)
  {
    super.init(frame: frame)
    backgroundColor = UIColor.clear
  }
  // init the view by deserialisation
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    backgroundColor = UIColor.clear
  }
  /// override the draw(_:) to draw your own view
  ///
  /// Default implementation - `rectangular view`
  ///
  override func draw(_ rect: CGRect)
  {
    // Card view corner radius
    let cardRadius = CGFloat(30)
    // Button slot arc radius
    let buttonSlotRadius = CGFloat(30)
    
    // Card view frame dimensions
    let viewSize = self.bounds.size
    // Effective height of the view
    let effectiveViewHeight = viewSize.height - buttonSlotRadius
    // Get a path to define and traverse
    let path = UIBezierPath()
    // Shift origin to left corner of top straight line
    path.move(to: CGPoint(x: cardRadius, y: 0))
    
    // top line
    path.addLine(to: CGPoint(x: viewSize.width - cardRadius, y: 0))
    // top-right corner arc
    path.addArc(
      withCenter: CGPoint(
        x: viewSize.width - cardRadius,
        y: cardRadius
      ),
      radius: cardRadius,
      startAngle: CGFloat(Double.pi * 3 / 2),
      endAngle: CGFloat(0),
      clockwise: true
    )
    // right line
    path.addLine(
      to: CGPoint(x: viewSize.width, y: effectiveViewHeight)
    )
    
    // bottom-right corner arc
    path.addArc(
      withCenter: CGPoint(
        x: viewSize.width - cardRadius,
        y: effectiveViewHeight - cardRadius
      ),
      radius: cardRadius,
      startAngle: CGFloat(0),
      endAngle: CGFloat(Double.pi / 2),
      clockwise: true
    )
    // right half of bottom line
    path.addLine(
      to: CGPoint(x: viewSize.width / 4 * 3, y: effectiveViewHeight)
    )
    // button-slot right arc
    path.addArc(
      withCenter: CGPoint(
        x: viewSize.width / 4 * 3 - buttonSlotRadius,
        y: effectiveViewHeight
      ),
      radius: buttonSlotRadius,
      startAngle: CGFloat(0),
      endAngle: CGFloat(Double.pi / 2),
      clockwise: true
    )
    
    // button-slot line
    path.addLine(
      to: CGPoint(
        x: viewSize.width / 4 + buttonSlotRadius,
        y: effectiveViewHeight + buttonSlotRadius
      )
    )
    // button left arc
    path.addArc(
      withCenter: CGPoint(
        x: viewSize.width / 4 + buttonSlotRadius,
        y: effectiveViewHeight
      ),
      radius: buttonSlotRadius,
      startAngle: CGFloat(Double.pi / 2),
      endAngle: CGFloat(Double.pi),
      clockwise: true
    )
    // left half of bottom line
    path.addLine(
      to: CGPoint(x: cardRadius, y: effectiveViewHeight)
    )
    // bottom-left corner arc
    path.addArc(
      withCenter: CGPoint(
        x: cardRadius,
        y: effectiveViewHeight - cardRadius
      ),
      radius: cardRadius,
      startAngle: CGFloat(Double.pi / 2),
      endAngle: CGFloat(Double.pi),
      clockwise: true
    )
    // left line
    path.addLine(to: CGPoint(x: 0, y: cardRadius))
    // top-left corner arc
    path.addArc(
      withCenter: CGPoint(x: cardRadius, y: cardRadius),
      radius: cardRadius,
      startAngle: CGFloat(Double.pi),
      endAngle: CGFloat(Double.pi / 2 * 3),
      clockwise: true
    )
    
    // close path join to origin
    path.close()
    // Set the background color of the view
    UIColor.gray.set()
    path.fill()
  }
}
