//
//  Label.swift
//  Desafio Mobile
//
//  Created by Mariana Meireles on 29/10/17.
//  Copyright © 2017 Mariana Meireles. All rights reserved.
//

import Foundation
import UIKit

func labelDidChange(label: UILabel, sum: Int) {
    var total = String(sum)
    if sum != 0{
        total.insert(",", at: total.index(total.endIndex, offsetBy: -2))
        if total.characters.count >= 7{
            total.insert(".", at: total.index(total.endIndex, offsetBy: -6))
        }
    }
    label.text = "Total: R$ " + total
}
