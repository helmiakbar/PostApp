//
//  UserViewController.swift
//  PostApps
//
//  Created by tamu on 24/03/23.
//

import UIKit

protocol UserViewControllerDelegate {
    func setSelectedUser(user: User?)
}

class UserViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    var users: [User]?
    var delegate: UserViewControllerDelegate? = nil
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self.view {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    init(users: [User]) {
        super.init(nibName: String(describing: UserViewController.self), bundle: nil)
        self.users = users
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let nibName = UINib(nibName: String(describing: UserTableViewCell.self), bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: String(describing: UserTableViewCell.self))
        tableView.layoutIfNeeded()
        tableView.reloadData()
        tableViewHeight.constant = tableView.contentSize.height + 20
    }
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let validUsers = users {
            return validUsers.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserTableViewCell.self)) as? UserTableViewCell {
            if let validUsers = users {
                cell.configureCellData(data: validUsers[indexPath.row])
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let validUsers = users {
            delegate?.setSelectedUser(user: validUsers[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
