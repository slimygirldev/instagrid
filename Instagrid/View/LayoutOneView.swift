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
    var isImageOneReady: Bool = false
    var isImageTwoReady: Bool = false
    var isImageThreeReady: Bool = false

    func isReady() -> Bool{
        if isImageOneReady && isImageTwoReady && isImageThreeReady == true {
            return true
        } else {
            return false
        }
    }

    func setImage(tag: Int, image: UIImage) {
        if tag == 0 {
            isImageOneReady = true
            imageTop.image = image
            imageTop.contentMode = .scaleAspectFill
        } else if tag == 1 {
            isImageTwoReady = true
            imageLeft.image = image
            imageLeft.contentMode = .scaleAspectFill
        } else {
            isImageThreeReady = true
            imageRight.image = image
            imageRight.contentMode = .scaleAspectFill
        }
    }
}
