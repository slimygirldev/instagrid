//
//  PictureProvider.swift
//  Instagrid
//
//  Created by Lorene Brocourt on 30/06/2022.
//

import Foundation
import UIKit
import Photos

class PictureProvider: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagePicked: Picture = Picture(picture: UIImage())

    func getPicture() -> Picture {
        return imagePicked
    }

    func libraryPicker() -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        return picker
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if picker.sourceType == .photoLibrary {
            if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                imagePicked = Picture(picture: image)
            }
        }
        picker.dismiss(animated: true, completion: { ()
            let name = Notification.Name(rawValue: "PictureNotification")
            let notification = Notification(name: name)
            NotificationCenter.default.post(notification)
        })
    }

    func requestAuthorizationHandler(status: PHAuthorizationStatus) {
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            print("Access granted to use Photo Library.")
        } else {
            print("Access to Photo Library was denied.")
        }
    }

    func checkPermission() {
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
            PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) -> Void in ()})
        }
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
        } else {
            PHPhotoLibrary
                .requestAuthorization(requestAuthorizationHandler)
        }
    }
}
