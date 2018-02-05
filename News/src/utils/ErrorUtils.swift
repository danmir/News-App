//
//  ErrorUtils.swift
//  News
//
//  Created by Danil Mironov on 04.02.18.
//  Copyright © 2018 Danil Mironov. All rights reserved.
//

import Foundation
import UIKit

enum ErrorCode: Int {
    case unknownError = -999
}

func makeError(with message: String) -> Error {
    return NSError(domain: "", code: ErrorCode.unknownError.rawValue, userInfo: [
        NSLocalizedDescriptionKey: message
        ])
}

func showError(message: String, viewController: UIViewController?) {
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default))
    if let viewController = viewController {
        viewController.present(alert, animated: true)
    } else {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController!.present(alert, animated: true)
    }
}

