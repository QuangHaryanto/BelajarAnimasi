//
//  ViewController.swift
//  BelajarAnimasi
//
//  Created by Haryanto Salim on 04/06/20.
//  Copyright © 2020 Haryanto Salim. All rights reserved.
//

import UIKit

private let defaultProgressTrackColor = UIColor.blue

class ViewController: UIViewController {
    @IBOutlet var myManuallyMadeView: UIView!
    
    var myProgrammaticallyMadeView = UIView()
    
    let ukuranAwal: CGFloat = 100.0
    var ukuranAkhir: CGFloat = 150.0
    
    private var progressView = ProgressView()
    private let animatePropertyButton = FancyButton(title: "Animate ✨")
    private let setPropertyButton = FancyButton(title: "Set")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //setupProgressView()
        //setupButtonsForProgressView()
        
        setupProgrammaticallyMadeView()
        animateBox()
    }
    
    private func setupProgressView() {
        let height: CGFloat = 32.0
        let saveArea = view.safeAreaLayoutGuide
        
        progressView.backgroundColor = .lightGray
        progressView.layer.cornerRadius = height / 2.0
        progressView.layer.masksToBounds = true
        
        progressView.color = defaultProgressTrackColor
        progressView.progress = 0.0
        
        progressView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressView)
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: saveArea.leadingAnchor, constant: 16),
            progressView.trailingAnchor.constraint(equalTo: saveArea.trailingAnchor, constant: -16),
            progressView.heightAnchor.constraint(equalToConstant: height),
            progressView.bottomAnchor.constraint(equalTo: saveArea.bottomAnchor, constant: -64)
        ])
    }
    
    private func setupButtonsForProgressView() {
        let buttonSize = CGSize(width: 120, height: 40)
        let edgePadding: CGFloat = 50.0
        let bottomPadding: CGFloat = 100.0
        
        let saveArea = view.safeAreaLayoutGuide
        
        animatePropertyButton.addTarget(self, action: #selector(progressViewAnimateButtonPressed), for: .touchUpInside)
        setPropertyButton.addTarget(self, action: #selector(progressViewSetButtonPressed), for: .touchUpInside)
        
        animatePropertyButton.translatesAutoresizingMaskIntoConstraints = false
        setPropertyButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animatePropertyButton)
        view.addSubview(setPropertyButton)
        
        NSLayoutConstraint.activate([
            animatePropertyButton.widthAnchor.constraint(equalToConstant: buttonSize.width),
            animatePropertyButton.heightAnchor.constraint(equalToConstant: buttonSize.height),
            animatePropertyButton.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: -bottomPadding),
            animatePropertyButton.leadingAnchor.constraint(equalTo: saveArea.leadingAnchor, constant: edgePadding),
            
            setPropertyButton.widthAnchor.constraint(equalToConstant: buttonSize.width),
            setPropertyButton.heightAnchor.constraint(equalToConstant: buttonSize.height),
            setPropertyButton.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: -bottomPadding),
            setPropertyButton.trailingAnchor.constraint(equalTo: saveArea.trailingAnchor, constant: -edgePadding)
        ])
    }
    
    @objc private func progressViewAnimateButtonPressed() {
        // Reset
        progressView.progress = 0.0
        progressView.color = defaultProgressTrackColor
        
        // Animate the property inside an animation context
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.progressView.progress = 0.8
            self.progressView.color = .red
        }, completion: nil) 
    }
    
    @objc private func progressViewSetButtonPressed(sender: FancyButton) {
        let newProgress: CGFloat = progressView.progress > 0 ? 0.0 : 1.0
        
        // Set the value, reflecting immediately
        progressView.progress = newProgress
    }
    
        func setupProgrammaticallyMadeView(){
            //        let posisiKotakAwal = CGRect(x: 0, y: 0, width: ukuranAwal, height: ukuranAwal)
            //        kotakAwal = UIView(frame: posisiKotakAwal)
            
            self.myProgrammaticallyMadeView.center = self.view.center
            myProgrammaticallyMadeView.backgroundColor = .blue
            
            view.addSubview(myProgrammaticallyMadeView)
            print(myProgrammaticallyMadeView.center)
        }
        
        func animateBox(){
            UIView.animate(withDuration: 2.0) {
                let posisiKotakAkhir = CGRect(x: 0, y: 0, width: self.ukuranAkhir, height: self.ukuranAkhir)
                self.myProgrammaticallyMadeView.frame = posisiKotakAkhir
                
                self.myProgrammaticallyMadeView.center = self.view.center
                print(self.myProgrammaticallyMadeView.center)
                
                self.myManuallyMadeView.center = self.myProgrammaticallyMadeView.center
            }
        }
    
    func animateBox1(){
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            let posisiKotakAkhir = CGRect(x: 0, y: 0, width: self.ukuranAkhir, height: self.ukuranAkhir)
            self.myProgrammaticallyMadeView.frame = posisiKotakAkhir
            
            self.myProgrammaticallyMadeView.center = self.view.center
            print(self.myProgrammaticallyMadeView.center)
            
            self.myManuallyMadeView.transform = CGAffineTransform(rotationAngle: .pi)
            self.myManuallyMadeView.layer.cornerRadius = 10.0
            
            self.myManuallyMadeView.center = self.myProgrammaticallyMadeView.center
        }, completion: nil)
    }
    
    func animateBox2(){
        let animator = UIViewPropertyAnimator(duration: 2.0, curve: .easeInOut) {
            let posisiKotakAkhir = CGRect(x: 0, y: 0, width: self.ukuranAkhir, height: self.ukuranAkhir)
            self.myProgrammaticallyMadeView.frame = posisiKotakAkhir
            
            self.myProgrammaticallyMadeView.center = self.view.center
            print(self.myProgrammaticallyMadeView.center)
            
            self.myManuallyMadeView.center = self.myProgrammaticallyMadeView.center
        }
        animator.startAnimation()
    }
    
    func animateBox3(){
        let posisiKotakAwal = CGRect(x: 0, y: 0, width: ukuranAwal, height: ukuranAwal)
        myProgrammaticallyMadeView.frame = posisiKotakAwal
        myProgrammaticallyMadeView.backgroundColor = .blue
        
        let posisiCenterAwal = CGPoint(x: 50.0, y: 50.0)
        myProgrammaticallyMadeView.center = posisiCenterAwal
        let geserPosisi: CGFloat = 150.0
        
        UIView.animateKeyframes(withDuration: 3.0, delay: 0.0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
                //let posisiKotakAkhir = CGRect(x: 0, y: 0, width: self.ukuranAkhir-100, height: self.ukuranAkhir-100)
                self.myProgrammaticallyMadeView.center = CGPoint(x: self.myProgrammaticallyMadeView.center.x + geserPosisi, y: self.myProgrammaticallyMadeView.center.y + geserPosisi)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                //                let posisiKotakAkhir = CGRect(x: 0, y: 0, width: self.ukuranAkhir-75, height: self.ukuranAkhir-75)
                self.myProgrammaticallyMadeView.center = CGPoint(x: self.myProgrammaticallyMadeView.center.x, y: self.myProgrammaticallyMadeView.center.y + geserPosisi)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
                //let posisiKotakAkhir = CGRect(x: 0, y: 0, width: self.ukuranAkhir-50, height: self.ukuranAkhir-50)
                self.myProgrammaticallyMadeView.center = CGPoint(x: self.myProgrammaticallyMadeView.center.x + geserPosisi, y: self.myProgrammaticallyMadeView.center.y)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                //let posisiKotakAkhir = CGRect(x: 0, y: 0, width: self.ukuranAkhir, height: self.ukuranAkhir)
                self.myProgrammaticallyMadeView.center = CGPoint(x: self.myProgrammaticallyMadeView.center.x, y: self.myProgrammaticallyMadeView.center.y + geserPosisi)
            }
        }, completion: nil)
    }
    
    
    
    func animateBox4(){
        
        let posisiButton = CGRect(x: 100.0, y: 500.0, width: ukuranAwal, height: 30.0)
        let myButton = UIButton(frame: posisiButton)
        myButton.setTitle("Reveal", for: .normal)
        myButton.backgroundColor = .cyan
        view.addSubview(myButton)
        
        myButton.addTarget(self, action: #selector(tapButton(sender:)), for: .touchUpInside)
        
        let posisiKotakAwal = CGRect(x: 0, y: 0, width: ukuranAwal, height: ukuranAwal)
        myProgrammaticallyMadeView.frame = posisiKotakAwal
        myProgrammaticallyMadeView.backgroundColor = .blue
        
        let posisiCenterAwal = CGPoint(x: 300.0, y: 500.0)
        myProgrammaticallyMadeView.center = posisiCenterAwal
    }
    
    @objc func tapButton(sender: UIButton){
        if myProgrammaticallyMadeView.alpha == 1.0{
            myProgrammaticallyMadeView.animHide()
        }else if myProgrammaticallyMadeView.alpha == 0.0{
            myProgrammaticallyMadeView.animShow()
        }
    }
}

extension UIView{
    func animShow(){
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseInOut],
                       animations: {
                        self.center.y -= self.bounds.height
                        //self.layoutIfNeeded()
                        self.alpha = 1.0
        }, completion: {(_ completed: Bool) -> Void in
            //            self.isHidden = false
        })
        self.isHidden = false
    }
    func animHide(){
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseInOut],
                       animations: {
                        self.center.y += self.bounds.height
                        //self.layoutIfNeeded()
                        self.alpha = 0.0
        },  completion: {(_ completed: Bool) -> Void in
            self.isHidden = true
        })
    }
}
