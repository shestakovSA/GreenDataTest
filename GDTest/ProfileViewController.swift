//
//  ProfileViewController.swift
//  GDTest
//
//  Created by Сергей Шестаков on 15.08.2020.
//  Copyright © 2020 Сергей Шестаков. All rights reserved.
//

import Foundation
import UIKit


class ProfileViewController: UIViewController {
    //MARK: - Subview
    @IBOutlet weak var dataBornLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var genderImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK: - Properties
    let times = Time()
    var fullName = ""
    var image = UIImage()
    var email = ""
    var dataBorn = ""
    var age = ""
    var time = ""
    var gender = ""
    var imageGender = UIImage()
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = fullName
        imageView.image = image
        emailLabel.text = "EMAIL:" + " " + email
        dataBornLabel.text = "DATE OF BIRTH:" + " " + times.dateFormater(dataOne: dataBorn) + " " + "(" + age + ")"
        timeLabel.text = "LOCAL TIME:" + " " + times.timeDecoder(gmt: time)
        genderSwitch()
    }
    // MARK: - Action
    @IBAction private func imageTapped(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }

    @objc private func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    // MARK: - Methods
    func genderSwitch() {
        if self.gender == "male" {
            self.genderImageView.image = UIImage(named: "male")
        }
        else {
            self.genderImageView.image = UIImage(named: "female")
        }
    }
}

