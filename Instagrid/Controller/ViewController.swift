//
//  ViewController.swift
//  Instagrid
//
//  Created by Lorene Brocourt on 29/06/2022.
//

import UIKit


class ViewController: UIViewController, UIGestureRecognizerDelegate {


    @IBOutlet weak var layoutThreeView: LayoutThreeView!
    @IBOutlet weak var layoutTwoView: LayoutTwoView!
    @IBOutlet weak var layoutOneView: LayoutOneView!

    @IBOutlet weak var layoutButtonThreeView: LayoutButtonView!
    @IBOutlet weak var layoutButtonTwoView: LayoutButtonView!
    @IBOutlet weak var layoutButtonOneView: LayoutButtonView!

    @IBOutlet weak var arrow: UIImageView!



    let servicePicture: PictureProvider = PictureProvider()
    var currentImageTag: Int = 0

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
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            arrow.image = UIImage(named: "Arrow Left")
        } else {
            arrow.image = UIImage(named: "Arrow Up")
        }
    }

}

