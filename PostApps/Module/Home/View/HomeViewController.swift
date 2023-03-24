//
//  HomeViewController.swift
//  PostApps
//
//  Created by tamu on 24/03/23.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var allPostLineView: UIView!
    @IBOutlet weak var myPostLineView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var btnLeft = UIButton(type: .custom)
    private var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel.users.count == 0 {
            viewModel.createUser()
            viewModel.createPost()
        }
        viewModel.selectedUser = viewModel.users.first
        setupNavigation()
        configureLineButtomTitle()
        configureTableView()
    }
    
    @IBAction func allPostBtn(_ sender: Any) {
        configureLineButtomTitle()
        setPostData()
    }
    
    @IBAction func myPostBtn(_ sender: Any) {
        configureLineButtomTitle(false)
        setPostData(false)
    }
    
    @objc func addPost() {
        let addPostVC = AddPostViewController(user: viewModel.selectedUser)
        addPostVC.delegate = self
        self.navigationController?.pushViewController(addPostVC, animated: true)
    }
    
    @objc func changeUser() {
        let userVC = UserViewController(users: viewModel.users)
        userVC.delegate = self
        userVC.modalPresentationStyle = .overFullScreen
        userVC.modalTransitionStyle = .crossDissolve
        self.present(userVC, animated: true, completion: nil)
    }
    
    private func setupNavigation() {
        self.navigationItem.title = "Posts Apps"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.init(red: 21/255, green: 34/255, blue: 56/255, alpha: 1.0)
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        btnLeft.isEnabled = false
        btnLeft.setTitle(viewModel.selectedUser?.name, for: .normal)
        btnLeft.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnLeft.addTarget(self, action: #selector(self.changeUser), for: .touchUpInside)
        let itemLeft = UIBarButtonItem(customView: btnLeft)
        
        self.navigationItem.leftBarButtonItem = itemLeft
        
        let btnRight = UIButton(type: .custom)
        btnRight.isEnabled = false
        btnRight.setTitle("Add Post", for: .normal)
        btnRight.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnRight.addTarget(self, action: #selector(self.addPost), for: .touchUpInside)
        let itemRight = UIBarButtonItem(customView: btnRight)
        
        self.navigationItem.rightBarButtonItem = itemRight
    }
    
    private func configureLineButtomTitle(_ isAllPost: Bool = true) {
        if isAllPost {
            allPostLineView.backgroundColor = UIColor.white
            myPostLineView.backgroundColor = UIColor.clear
        } else {
            allPostLineView.backgroundColor = UIColor.clear
            myPostLineView.backgroundColor = UIColor.white
        }
    }
    
    private func setPostData(_ isAll: Bool = true) {
        if isAll {
            viewModel.getAllPost()
        } else {
            viewModel.getUserPost()
        }
        tableView.reloadData()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let nibName = UINib(nibName: String(describing: HomeTableViewCell.self), bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: String(describing: HomeTableViewCell.self))
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getPostCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeTableViewCell.self)) as? HomeTableViewCell {
            if let validPost = viewModel.tempPost {
                cell.configureCell(data: validPost[indexPath.row])
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension HomeViewController: UserViewControllerDelegate {
    func setSelectedUser(user: User?) {
        self.dismiss(animated: true, completion: {
            self.viewModel.selectedUser = user
            self.configureLineButtomTitle()
            self.setPostData()
            self.btnLeft.setTitle(self.viewModel.selectedUser?.name, for: .normal)
        })
    }
}

extension HomeViewController: AddPostViewControllerDelegate {
    func successAddPost() {
        self.navigationController?.popViewController(animated: true)
        configureLineButtomTitle()
        setPostData()
    }
}
