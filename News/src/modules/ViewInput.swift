//
//  ViewInput.swift
//  News
//
//  Created by Danil Mironov on 04.02.18.
//  Copyright © 2018 Danil Mironov. All rights reserved.
//

import Foundation
import UIKit

protocol BaseViewInput: class {
    associatedtype ViewType
    var rootView: ViewType { get }
    func show(error: Error)
}

extension BaseViewInput where Self: UIViewController {
    
    var rootView: ViewType {
        return view as! ViewType
    }
    
    func show(error: Error) {
        showError(message: error.localizedDescription, viewController: self)
    }
}

