//
//  LayoutTwoView.swift
//  Instagrid
//
//  Created by Lorene Brocourt on 06/07/2022.
//

import Foundation
import UIKit

class LayoutTwoView: UIView {

    @IBOutlet weak var imageBot: UIImageView!
    @IBOutlet weak var imageRight: UIImageView!
    @IBOutlet weak var imageLeft: UIImageView!

    func isReady() -> Bool{
        return imageBot.image != nil && imageLeft.image != nil && imageRight.image != nil
    }

    func setImage(tag: Int, image: UIImage) {
        if tag == 0 {
            imageLeft.image = image
            imageLeft.contentMode = .scaleAspectFill
        } else if tag == 1 {
            imageRight.image = image
            imageRight.contentMode = .scaleAspectFill
        } else {
            imageBot.image = image
            imageRight.contentMode = .scaleAspectFill
        }
    }
}
