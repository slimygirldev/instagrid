//
//  LayoutThreeView.swift
//  Instagrid
//
//  Created by Lorene Brocourt on 06/07/2022.
//

import Foundation
import UIKit

class LayoutThreeView: UIView {

    @IBOutlet weak var imageTopRight: UIImageView!
    @IBOutlet weak var imageBotRight: UIImageView!
    @IBOutlet weak var imageTopLeft: UIImageView!
    @IBOutlet weak var imageBotLeft: UIImageView!
    var isImageOneReady: Bool = false
    var isImageTwoReady: Bool = false
    var isImageThreeReady: Bool = false
    var isImageFourReady: Bool = false

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
            imageTopLeft.image = image
            imageTopLeft.contentMode = .scaleAspectFill
        } else if tag == 1 {
            isImageTwoReady = true
            imageTopRight.image = image
            imageTopRight.contentMode = .scaleAspectFill
        } else if tag == 2{
            isImageThreeReady = true
            imageBotLeft.image = image
            imageBotLeft.contentMode = .scaleAspectFill
        } else {
            isImageFourReady = true
            imageBotRight.image = image
            imageBotRight.contentMode = .scaleAspectFill
        }
    }
}
