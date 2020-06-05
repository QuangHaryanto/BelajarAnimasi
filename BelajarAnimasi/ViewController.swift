//
//  ViewController.swift
//  BelajarAnimasi
//
//  Created by Haryanto Salim on 04/06/20.
//  Copyright © 2020 Haryanto Salim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var myView: UIView!
    var kotakAwal = UIView()
    let ukuranAwal: CGFloat = 100.0
    var ukuranAkhir: CGFloat = 150.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setup()
        animateBox3()
    }
    
    func setup(){
//        let posisiKotakAwal = CGRect(x: 0, y: 0, width: ukuranAwal, height: ukuranAwal)
//        kotakAwal = UIView(frame: posisiKotakAwal)
        self.kotakAwal.center = self.view.center
        kotakAwal.backgroundColor = .blue
        view.addSubview(kotakAwal)
        print(kotakAwal.center)
    }

    func animateBox(){
        UIView.animate(withDuration: 2.0) {
            let posisiKotakAkhir = CGRect(x: 0, y: 0, width: self.ukuranAkhir, height: self.ukuranAkhir)
            self.kotakAwal.frame = posisiKotakAkhir
            
            self.kotakAwal.center = self.view.center
            print(self.kotakAwal.center)
            
            self.myView.center = self.kotakAwal.center
        }
    }
    
    func animateBox1(){
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            let posisiKotakAkhir = CGRect(x: 0, y: 0, width: self.ukuranAkhir, height: self.ukuranAkhir)
            self.kotakAwal.frame = posisiKotakAkhir
            
            self.kotakAwal.center = self.view.center
            print(self.kotakAwal.center)
            
            self.myView.center = self.kotakAwal.center
        }, completion: nil)
    }
    
    func animateBox2(){
        let animator = UIViewPropertyAnimator(duration: 2.0, curve: .easeInOut) {
            let posisiKotakAkhir = CGRect(x: 0, y: 0, width: self.ukuranAkhir, height: self.ukuranAkhir)
            self.kotakAwal.frame = posisiKotakAkhir
            
            self.kotakAwal.center = self.view.center
            print(self.kotakAwal.center)
            
            self.myView.center = self.kotakAwal.center
        }
        animator.startAnimation()
    }
    
    func animateBox3(){
        let posisiCenterAwal = CGPoint(x: 50.0, y: 50.0)
        myView.center = posisiCenterAwal
        let geserPosisi: CGFloat = 150.0
        
        UIView.animateKeyframes(withDuration: 3.0, delay: 0.0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
                //let posisiKotakAkhir = CGRect(x: 0, y: 0, width: self.ukuranAkhir-100, height: self.ukuranAkhir-100)
                self.myView.center = CGPoint(x: self.myView.center.x + geserPosisi, y: self.myView.center.y + geserPosisi)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
//                let posisiKotakAkhir = CGRect(x: 0, y: 0, width: self.ukuranAkhir-75, height: self.ukuranAkhir-75)
                self.myView.center = CGPoint(x: self.myView.center.x, y: self.myView.center.y + geserPosisi)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
                //let posisiKotakAkhir = CGRect(x: 0, y: 0, width: self.ukuranAkhir-50, height: self.ukuranAkhir-50)
                self.myView.center = CGPoint(x: self.myView.center.x + geserPosisi, y: self.myView.center.y)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                //let posisiKotakAkhir = CGRect(x: 0, y: 0, width: self.ukuranAkhir, height: self.ukuranAkhir)
                self.myView.center = CGPoint(x: self.myView.center.x, y: self.myView.center.y + geserPosisi)
            }
        }, completion: nil)
    }

}

