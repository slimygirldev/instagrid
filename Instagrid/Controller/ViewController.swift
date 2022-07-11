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

//    var currentPosition: CGRect = .zero

    override func viewDidLoad() {
        super.viewDidLoad()
        servicePicture.checkPermission()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            arrow.image = UIImage(named: "Arrow Left")
        } else {
            arrow.image = UIImage(named: "Arrow Up")
        }
    }



    @IBAction func didPanGesture(_ sender: UIPanGestureRecognizer) {

        if sender.state == .began {
 //      currentPosition = mainView.frame

        } else if sender.state == .changed {
            let translation = sender.translation(in: mainView)

            let translationTransform = CGAffineTransform(translationX: translation.x,
                                                         y: translation.y)
            mainView.transform = translationTransform

        } else if sender.state == .ended || sender.state == .cancelled {
//            share(startPose: currentPosition)
        }
    }

    func share() {
        //param for startPose = startPose: CGRect
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
        // self.mainView.frame = startPose
        })

    }

    @IBAction func didSwipeTheView(_ sender: UISwipeGestureRecognizer) {
        print("je suis swipé")
        //share()
    }
}

