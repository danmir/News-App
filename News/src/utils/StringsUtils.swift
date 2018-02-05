//
//  StringsUtils.swift
//  News
//
//  Created by Danil Mironov on 05.02.18.
//  Copyright © 2018 Danil Mironov. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var html2AttributedString: NSAttributedString? {
        do {
            let modifiedFont = String(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(15)\">%@</span>", self)
            
            let attrStr = try NSAttributedString(
                data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
                options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil)
            return attrStr
        } catch {
            return nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
