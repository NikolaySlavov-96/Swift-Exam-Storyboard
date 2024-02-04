//
//  MotionManager.swift
//  MyNotes
//
//  Created by Nikolay Slavov on 4.02.24.
//

import Foundation
import CoreMotion

protocol MotionManagerDelegate: AnyObject {
    func didDetectMotion()
}

class MotionManager {
    
    private let motionManafer = CMMotionManager()
    weak var delegate: MotionManagerDelegate?
    
    func startAccelemeterUpdate () {
        if motionManafer.isAccelerometerAvailable {
            motionManafer.accelerometerUpdateInterval = 0.1
            motionManafer.startAccelerometerUpdates(to: OperationQueue.main) {
                data, error in
                if error != nil { return }
                
                if let acceleration = data?.acceleration {
                    let treshold = 0.3
                    
                    if acceleration.z > treshold {
                        self.delegate?.didDetectMotion()
                    }
                }
            }
        }
    }
    
    func stopAccelemeterUpdate() {
        if motionManafer.isAccelerometerActive {
            motionManafer.stopAccelerometerUpdates()
        }
    }
}
