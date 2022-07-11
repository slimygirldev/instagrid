//
//  SharingService.swift
//  Instagrid
//
//  Created by Lorene Brocourt on 10/07/2022.
//

import Foundation
import UIKit

class SharingService {


    func transformViewToImage(view: UIView) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { ctx in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        return image
    }
}
