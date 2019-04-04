//
//  MainViewController.swift
//  topreddit
//
//  Created by Arthur Stepanov on 03.04.2019.
//  Copyright © 2019 Arthur. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    @IBOutlet weak var contentTableView: UITableView!
    
    var posts = [Post]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadData()
    }
    
    
    //MARK - Setups
    
    func setupView() {
        contentTableView.tableFooterView = UIView()
        contentTableView.remembersLastFocusedIndexPath = true
        contentTableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")
    }
    
    
    //MARK - Methods
    
    func loadData() {
        showWaiting()
        PostsManager.shared.loadTopPosts { isSuccess in
            self.hideWaiting()
            guard let _posts = PostsManager.shared.posts, isSuccess else {
                self.showOkayAlert(title: "Error", text: "Server internal error")
                return
            }
            
            self.posts = _posts
            DispatchQueue.main.async {
                self.contentTableView.reloadData()
            }
        }
    }
    
    func showSelectorAlert(_ imageUrl: String) {
        let alert = UIAlertController(title: "Choose action", message: "You can open or save full-sized image", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Open", style: .default, handler: { _ in
            self.open(imageUrl)
        }))
        
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
            self.save(imageUrl)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func open(_ imageUrl: String) {
        guard let url = URL(string: imageUrl) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    func save(_ imageUrl: String) {
        showWaiting()
        let url = URL(string: imageUrl)
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let _data = data, error == nil else { return }
            DispatchQueue.main.async() {
                guard let newImage = UIImage(data: _data) else { return }
                UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil)
                self.hideWaiting()
                self.showOkayAlert(text: "Image saved to your Camera Roll")
            }
        }
        
        task.resume()
    }
    
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as! PostTableViewCell
        let item = posts[indexPath.row]
        cell.setupCell(item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == posts.count - 1 {
            loadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let _fullsizedImage = posts[indexPath.row].fullsizedImage else { return }
        showSelectorAlert(_fullsizedImage)
    }
    
}
