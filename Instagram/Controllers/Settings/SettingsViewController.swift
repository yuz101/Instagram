//
//  SettingsViewController.swift
//  Instagram
//
//  Created by Yuru Zhou on 11/24/22.
//

import UIKit

struct SettingsItem {
    var title: String
    var handler: (() -> Void)
}

class SettingsViewController: UIViewController {
    private var tableView: UITableView!
    var settingsItems: [SettingsItem] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .white
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SettingsTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        configureSettings()
        setupConstraints()
    }
    
    func configureSettings() {
        let items = [
            SettingsItem(title: "Log Out") { [weak self] in
                self?.didTapLogOut()
            }
        ]
        settingsItems.append(contentsOf: items)
    }
    
    func didTapLogOut() {
        let actionSheet = UIAlertController()
        let logout = UIAlertAction(title: "Log Out", style: .default) {_ in
            AuthenticationManager.logOut { success in
                DispatchQueue.main.async {
                    if success {
                        let vc  = LoginViewController()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true){
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    } else {
                        fatalError("Unable to Log Out")
                    }
                }
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheet.addAction(logout)
        actionSheet.addAction(cancel)
        //iPad. Else it will crash for iPad
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        present(actionSheet, animated: true)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath)
        cell.textLabel?.text = settingsItems[indexPath.row].title
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(settingsItems)
        settingsItems[indexPath.row].handler()
    }
}
