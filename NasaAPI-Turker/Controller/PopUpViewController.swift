//
//  PopUpViewController.swift
//  NasaAPI-Turker
//
//  Created by Gülşah Alan on 29.09.2021.
//

import UIKit
import Kingfisher

class PopUpViewController: UIViewController {
    
    @IBOutlet private weak var roverImage: UIImageView!
    @IBOutlet private weak var roverName: UILabel!
    @IBOutlet private weak var photoDate: UILabel!
    @IBOutlet private weak var cameraName: UILabel!
    @IBOutlet private weak var status: UILabel!
    @IBOutlet private weak var launchDate: UILabel!
    @IBOutlet private weak var landDate: UILabel!
    
    
    var selectedPhoto: Rover!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureOutlets()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.view.removeFromSuperview()
    }
    
}

//MARK: -  Configure Outlets
extension PopUpViewController {
    func configureOutlets() {
        roverImage.fetchImage(from: "\(selectedPhoto.img_src ?? "")")
        roverName.text = selectedPhoto.rover.name
        photoDate.text = selectedPhoto.earth_date
        cameraName.text = selectedPhoto.camera.name
        status.text = selectedPhoto.rover.status
        launchDate.text = selectedPhoto.rover.launch_date
        landDate.text = selectedPhoto.rover.landing_date
    }
}

