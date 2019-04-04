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
        contentTableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")
    }
    
    
    //MARK - Methods
    
    func loadData() {
        let post = Post()
        post.title = "I just dug this up metal detecting in the middle of nowhere"
        post.author = "MrDurka"
        post.date = 1554389834
        post.thumbnail = "https://b.thumbs.redditmedia.com/85zO359J7oya4Aasuhpkc4-IPEUQT0IbBiMs7S_Q-TQ.jpg"
        post.fullsizedImage = "https://i.redd.it/7texkfyya3q21.jpg"
        post.commentsCount = 3965
        
        posts.append(post)
        posts.append(post)
        posts.append(post)
        posts.append(post)
        posts.append(post)
        
        contentTableView.reloadData()
    }
    
    func showSelectorAlert(_ imageUrl: String) {
        let alert = UIAlertController(title: "Choose action", message: "You can open or save full-sized image", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Open", style: .default, handler: { _ in
            self.open(imageUrl)
        }))
        
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
            self.save(imageUrl)
        }))
        
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
        let url = URL(string: imageUrl)
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let _data = data, error == nil else { return }
            DispatchQueue.main.async() {
                guard let newImage = UIImage(data: _data) else { return }
                UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let _fullsizedImage = posts[indexPath.row].fullsizedImage else { return }
        showSelectorAlert(_fullsizedImage)
    }
    
}
