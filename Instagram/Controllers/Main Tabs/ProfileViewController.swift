//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Yuru Zhou on 11/24/22.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
        // Do any additional setup after loading the view.
    }
    
    @objc func didTapSettings() {
        let vc  = SettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}
