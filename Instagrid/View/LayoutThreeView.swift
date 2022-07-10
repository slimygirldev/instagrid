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
    
    func setImage(tag: Int, image: UIImage) {
        if tag == 0 {
            imageTopLeft.image = image
            imageTopLeft.contentMode = .scaleAspectFill
        } else if tag == 1 {
            imageTopRight.image = image
            imageTopRight.contentMode = .scaleAspectFill
        } else if tag == 2{
            imageBotLeft.image = image
            imageBotLeft.contentMode = .scaleAspectFill
        } else {
            imageBotRight.image = image
            imageBotRight.contentMode = .scaleAspectFill
        }
    }
}
