//
//  SharingService.swift
//  Instagrid
//
//  Created by Lorene Brocourt on 10/07/2022.
//

import Foundation
import UIKit

class SharingService {


    func transformViewToImage(view: UIView) {
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { ctx in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
    }

//    func shareOnlyImage(_ sender: UIButton) {
//        let image = UIImage(named: "Product")
//        let imageShare = [ image! ]
//        let activityViewController = UIActivityViewController(activityItems: imageShare , applicationActivities: nil)
//        activityViewController.popoverPresentationController?.sourceView = self.view
//        self.present(activityViewController, animated: true, completion: nil)
//    }
}
