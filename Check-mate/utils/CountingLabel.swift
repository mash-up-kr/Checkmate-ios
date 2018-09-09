//
//  CountingLabel.swift
//  Ani1
//
//  Created by Changmin Kim on 2018. 8. 25..
//  Copyright © 2018년 twibeat. All rights reserved.
//
/*
 Usage
 
 countingLabel.count(fromValue: 99999, to: 0, withDuration: 5, andAnimationType: .EaseOut, andCouterType: .Int)
 */
import UIKit

class CountingLabel: UILabel {
    
    let CounterVelocity: Float = 3.0
    
    //최종 값은 같지만, 증가하는 모습이 다르게 됨
    enum CounterAnimationType{
        case Linear // f(x) = x
        case EaseIn // f(x) = x ^ 3
        case EaseOut // f(x) = (1-x) ^ 3
    }
    
    enum CounterType{
        case Int
        case Float
    }
    
    var counterType: CounterType!
    var counterAnimationType: CounterAnimationType!
    
    var startNumber: Float = 0.0
    var endNumber: Float = 0.0
    
    //현재 값
    var progress: TimeInterval!
    //지정한 값
    var duration: TimeInterval!
    var lastUpdate: TimeInterval!

    var timer: Timer?
    
    var currentCounterValue:Float {
        if progress >= duration {
            return endNumber
        }
        
        let percentage = Float(progress / duration)
        let update = updateCounter(counterValue: percentage)
        
        return startNumber + (update * (endNumber - startNumber))
    }
    
    
    func count(fromValue: Float, to toValue:Float, withDuration duration: TimeInterval, andAnimationType animationType: CounterAnimationType, andCouterType counterType: CounterType ) {
        self.startNumber = fromValue
        self.endNumber = toValue
        self.duration = duration
        self.counterType = counterType
        self.counterAnimationType = animationType
        self.progress = 0
        self.lastUpdate = Date.timeIntervalSinceReferenceDate
        
        invalidateTimer()
        
        if duration == 0 {
            updateText(value: toValue)
            return
        }
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(CountingLabel.updateValue), userInfo: nil, repeats: true)
    }
    
    @objc func updateValue (){
        let now = Date.timeIntervalSinceReferenceDate
        progress = progress + (now - lastUpdate)
        lastUpdate = now
        
        if progress >= duration{
            invalidateTimer()
            progress = duration
        }
        
        updateText(value: currentCounterValue)
    }

    func invalidateTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    func updateText(value: Float){
        switch counterType! {
        case .Int:
            self.text = Int(value).formattedWithSeparator
        case .Float:
            self.text = String(format: "%.2f", value)
        }
    }
    
    func updateCounter(counterValue: Float) -> Float {
        switch counterAnimationType! {
        case .Linear:
            return counterValue
        case .EaseIn:
            return powf(counterValue, CounterVelocity)
        case .EaseOut:
            return 1.0 - powf(1.0 - counterValue, CounterVelocity)
        }
    }
}
