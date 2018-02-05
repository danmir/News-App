//
//  BaseFlowProtocol.swift
//  News
//
//  Created by Danil Mironov on 04.02.18.
//  Copyright © 2018 Danil Mironov. All rights reserved.
//

import Foundation
import UIKit

protocol BaseFlowProtocol {
    
    func launchViewController() -> UIViewController?
    
    func makeRoot(viewController: UIViewController?, animated: Bool)
}

extension BaseFlowProtocol {
    
    func makeRoot(viewController: UIViewController?, animated: Bool = true) {
        (UIApplication.shared.delegate as? AppDelegate)?.makeRoot(viewController: viewController, animated: animated)
    }
}

