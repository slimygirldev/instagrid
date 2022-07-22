//
//  ViewController.swift
//  Instagrid
//
//  Created by Lorene Brocourt on 29/06/2022.
//

import UIKit


class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var mainView: UIStackView!

    @IBOutlet weak var layoutThreeView: LayoutThreeView!
    @IBOutlet weak var layoutTwoView: LayoutTwoView!
    @IBOutlet weak var layoutOneView: LayoutOneView!

    @IBOutlet weak var layoutButtonThreeView: LayoutButtonView!
    @IBOutlet weak var layoutButtonTwoView: LayoutButtonView!
    @IBOutlet weak var layoutButtonOneView: LayoutButtonView!

    @IBOutlet weak var arrow: UIImageView!

    let serviceSharing: SharingService = SharingService()

    let servicePicture: PictureProvider = PictureProvider()

    var currentImageTag: Int = 0

    var currentLayout: Int = 0

    var currentPosition: CGRect = .zero

    override func viewDidLoad() {
        super.viewDidLoad()
        servicePicture.checkPermission()
        let swipeUp = UISwipeGestureRecognizer (target: self, action: #selector(didSwipeTheView(_:)))
        swipeUp.direction = .up
        let swipeLeft = UISwipeGestureRecognizer (target: self, action: #selector(didSwipeTheView(_:)))
        swipeLeft.direction = .left
        mainView.addGestureRecognizer(swipeLeft)
        mainView.addGestureRecognizer(swipeUp)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UIDevice.current.orientation.isLandscape {
            arrow.image = UIImage(named: "Arrow Left")
        } else {
            arrow.image = UIImage(named: "Arrow Up")
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            arrow.image = UIImage(named: "Arrow Left")
        } else {
            arrow.image = UIImage(named: "Arrow Up")
        }
    }

    @objc func handlePictureNotification() {
        let model: Picture  = servicePicture.getPicture()
        layoutOneView.setImage(tag: currentImageTag, image: model.picture)
        layoutTwoView.setImage(tag: currentImageTag, image: model.picture)
        layoutThreeView.setImage(tag: currentImageTag, image: model.picture)
    }

    @IBAction func didTapButton(_ sender: UITapGestureRecognizer) {
        let picker = servicePicture.libraryPicker()
        present(picker, animated: true)
        currentImageTag = sender.view?.tag ?? 0
        let name = Notification.Name(rawValue: "PictureNotification")
        NotificationCenter.default.addObserver(self, selector: #selector(handlePictureNotification), name: name, object: nil)
    }

    @IBAction func didTapModelButton(_ sender: UITapGestureRecognizer) {
        if sender.view?.tag == 0 {
            layoutOneView.isHidden = false
            layoutTwoView.isHidden = true
            layoutThreeView.isHidden = true
            layoutButtonOneView.selectedModelButtonImage.isHidden = false
            layoutButtonTwoView.selectedModelButtonImage.isHidden = true
            layoutButtonThreeView.selectedModelButtonImage.isHidden = true
        } else if sender.view?.tag == 1 {
            layoutOneView.isHidden = true
            layoutTwoView.isHidden = false
            layoutThreeView.isHidden = true
            layoutButtonOneView.selectedModelButtonImage.isHidden = true
            layoutButtonTwoView.selectedModelButtonImage.isHidden = false
            layoutButtonThreeView.selectedModelButtonImage.isHidden = true
        } else if sender.view?.tag == 2 {
            layoutOneView.isHidden = true
            layoutTwoView.isHidden = true
            layoutThreeView.isHidden = false
            layoutButtonOneView.selectedModelButtonImage.isHidden = true
            layoutButtonTwoView.selectedModelButtonImage.isHidden = true
            layoutButtonThreeView.selectedModelButtonImage.isHidden = false
        }
        currentLayout = sender.view?.tag ?? 0
    }

    func share(startPose position: CGRect) {
        var image: UIImage

        if currentLayout == 0 {
            image = serviceSharing.transformViewToImage(view: layoutOneView)
        } else if currentLayout == 1 {
            image = serviceSharing.transformViewToImage(view: layoutTwoView)
        } else  {
            image = serviceSharing.transformViewToImage(view: layoutThreeView)
        }

        let imageShare = [ image ]
        let activityViewController = UIActivityViewController(activityItems: imageShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: {
        })

        //On completion
        activityViewController.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed: Bool, arrayReturnedItems: [Any]?, error: Error?) in
            // Restore mainView position
            UIView.animate(withDuration: 0.3) {
                self.mainView.transform = .identity
            }
            //error handeling
            if completed {
                let alert = UIAlertController(title: "Succes", message: "🎉Image shared successfully🎉", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default))
                self.present(alert, animated: true, completion: nil)
                print("share success")
            } else {
                let alert = UIAlertController(title: "Cancel", message: "Image sharing cancelled.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default))
                self.present(alert, animated: true, completion: nil)
            }
            if let shareError = error {
                let alert = UIAlertController(title: "Error", message: "\(shareError.localizedDescription)", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default))
                self.present(alert, animated: true, completion: nil)
                print("error while sharing: \(shareError.localizedDescription)")
            }
        }
    }

    func errorImage() {
        let alert = UIAlertController(title: "Error", message: "Set all images before sharing.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default))
        self.present(alert, animated: true, completion: nil)
    }

    func swipeAnimation(_ sender: UISwipeGestureRecognizer) {
        let orientation = UIDevice.current.orientation
        if sender.direction == .up && orientation.isPortrait {
            let translationTransform = CGAffineTransform(translationX: 0, y: -(mainView.frame.origin.y + (mainView.superview?.frame.height ?? 0)))

            UIView.animate(withDuration: 0.3) {
                self.mainView.transform = translationTransform
            } completion: { finished in
                self.share(startPose: self.currentPosition)
            }
        } else if sender.direction == .left  && orientation.isLandscape {
            let translationTransform = CGAffineTransform(translationX: -(mainView.frame.origin.x + (mainView.superview?.frame.width ?? 0)), y: 0)

            UIView.animate(withDuration: 0.3) {
                self.mainView.transform = translationTransform
            } completion: { finished in
                self.share(startPose: self.currentPosition)
            }
        }
    }

    @objc func didSwipeTheView(_ sender: UISwipeGestureRecognizer) {
        //checking images in mainView / error
        if currentLayout == 0 {
            if layoutOneView.isReady() == false {
                errorImage()
            } else {
                swipeAnimation(sender)
            }
        }
        if currentLayout == 1 {
            if layoutTwoView.isReady() == false {
                errorImage()
            } else {
                swipeAnimation(sender)
            }
        }
        if currentLayout == 2 {
            if layoutThreeView.isReady() == false {
                errorImage()
            } else {
                swipeAnimation(sender)
            }
        }
    }
}

