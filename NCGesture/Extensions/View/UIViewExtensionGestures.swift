//
//  UIViewExtensionGestures.swift
//  Sensitive
//
//  Created by NC on 10.11.15.
//  Copyright © 2015 NC. All rights reserved.
//

import Foundation
import UIKit

public typealias GestureRecognizerConfigurationBlock<UIKitGestureRecognizerType: UIGestureRecognizer> = (_ gestureRecognizer: UIKitGestureRecognizerType) -> Void

public typealias GestureRecognizerHandlerBlock<GestureRecognizerType: UIGestureRecognizer> = (_ gestureRecognizer: GestureRecognizerType) -> Void

public enum GestureHandlerReuseCount {
    case once
    case times(count: Int)
    case always
}



public extension UIView {
    
    // MARK: Public static methods
    
    // MARK: Private static methods
    
    // MARK: Public object methods
    
    /**
    Adds `UITapGestureRecognizer` instance to view.
    
    - parameters:
        - when: Represents how many times gesture should be handled.
        - handle: Called when `UITapGestureRecognizer` instance changes its state.
        - configure: Allows to configure `UITapGestureRecognizer` instance.
            It's recommended to change settings of gesture recognizer inside of this block.
    
    - returns:
        Reference to receiver for support of chain calls.
    */
    @discardableResult
    public func onTap(when handlerReuseCount: GestureHandlerReuseCount, handle: @escaping GestureRecognizerHandlerBlock<UITapGestureRecognizer>, configure: GestureRecognizerConfigurationBlock<UITapGestureRecognizer>?) -> Self {
        /*
         * Obtain handler block for gesture recognizer.
         */
        
        let handlerBlockForTapGestureRecognizer = stv_applyReuseCount(reuseCount: handlerReuseCount, toHandlerBlock: handle)
        
        /*
         * Create gesture recognizer instance.
         */
        
        let tapGestureRecognizer = TapGestureRecognizer(handlerBlock: handlerBlockForTapGestureRecognizer)
        
        /*
         * Add gesture recognizer to receiver.
         */
        self.isUserInteractionEnabled = true
        addGestureRecognizer(tapGestureRecognizer)
        
        /*
         * Call configuration block for gesture recognizer.
         */
        
        configure?(tapGestureRecognizer)
        
        /*
         * Return receiver's instance for support of chain calls.
         */
        
        return self
    }
    
    /**
    Adds `UITapGestureRecognizer` instance to view.
    
    - parameters:
        - handle: Called when `UITapGestureRecognizer` instance changes its state.
    
    - returns:
        Reference to receiver for support of chain calls.
    */
    @discardableResult
    public func onTap(handle: @escaping GestureRecognizerHandlerBlock<UITapGestureRecognizer>) -> Self {
        return onTap(when: .always, handle: handle, configure: nil)
    }
    

    
    // MARK: Private object methods
    
    fileprivate func stv_numberOfTimesGestureRecognizerIsHandled(gestureRecognizer: UIGestureRecognizer) -> Int? {
        switch gestureRecognizer {
        case is TapGestureRecognizer:
            return (gestureRecognizer as! TapGestureRecognizer).numberOfTimesHandled
        default:
            return nil
        }
    }
    
    fileprivate func stv_applyReuseCount<GestureRecognizerType: UIGestureRecognizer>(reuseCount: GestureHandlerReuseCount, toHandlerBlock handlerBlock: @escaping GestureRecognizerHandlerBlock<GestureRecognizerType>) -> GestureRecognizerHandlerBlock<GestureRecognizerType> {
        switch reuseCount {
        case .once:
            return { (gestureRecognizer) in
                handlerBlock(gestureRecognizer)
                gestureRecognizer.view?.removeGestureRecognizer(gestureRecognizer)
            }
        case let .times(count):
            return { (gestureRecognizer) in
                handlerBlock(gestureRecognizer)
                
                let numberOfTimesGestureRecognizersIsHandled = self.stv_numberOfTimesGestureRecognizerIsHandled(gestureRecognizer: gestureRecognizer) ?? 0
                
                if numberOfTimesGestureRecognizersIsHandled == count {
                    gestureRecognizer.view?.removeGestureRecognizer(gestureRecognizer)
                }
            }
        case .always:
            return { (gestureRecognizer) in
                handlerBlock(gestureRecognizer)
            }
        }
    }
    
 
    
}
