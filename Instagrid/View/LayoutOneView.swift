//
//  LayoutOneView.swift
//  Instagrid
//
//  Created by Lorene Brocourt on 02/07/2022.
//

import Foundation
import UIKit

class LayoutOneView: UIView {

    @IBOutlet weak var imageTop: UIImageView!
    @IBOutlet weak var imageRight: UIImageView!
    @IBOutlet weak var imageLeft: UIImageView!
    
    func setImage(tag: Int, image: UIImage) {
        if tag == 0 {
            imageTop.image = image
            imageTop.contentMode = .scaleAspectFill
        } else if tag == 1 {
            imageLeft.image = image
            imageLeft.contentMode = .scaleAspectFill
        } else {
            imageRight.image = image
            imageRight.contentMode = .scaleAspectFill
        }
    }
}
