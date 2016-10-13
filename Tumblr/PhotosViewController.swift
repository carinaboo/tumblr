//
//  ViewController.swift
//  Tumblr
//
//  Created by Carina Boo on 10/12/16.
//  Copyright © 2016 Carina Boo. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  var posts: [NSDictionary]?
  var refreshControl: UIRefreshControl!

  @IBOutlet weak var postTableView: UITableView!
  @IBOutlet weak var postTableViewCell: PostTableViewCell!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    postTableView.dataSource = self
    postTableView.delegate = self
    
    self.postTableView.rowHeight = 320
    
    self.refreshControl = UIRefreshControl()
    self.refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
    
    getPosts()
    
    postTableView.insertSubview(refreshControl, at: 0)
  }
  
  func refreshControlAction(_:Any?) {
    getPosts()
  }
  
  func getPosts() {
    let apiKey = "Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"
    let url = URL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=\(apiKey)")
    let request = URLRequest(url: url!)
    let session = URLSession(
      configuration: URLSessionConfiguration.default,
      delegate:nil,
      delegateQueue:OperationQueue.main
    )
    
    let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (dataOrNil, response, error) in
      if let data = dataOrNil {
        if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
          
          let response = responseDictionary["response"] as! NSDictionary
          self.posts = response["posts"] as? [NSDictionary]
          
          self.postTableView.reloadData()
          self.refreshControl.endRefreshing()
        }
      }
    });
    task.resume()
  }
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let posts = self.posts {
      return posts.count
    } else {
      return 0
    }
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = postTableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
    
    let photoURL = getPhotoURLFromPosts(indexPath: indexPath)
    cell.postImageView.setImageWith(photoURL)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let vc = segue.destination as! PhotosDetailsViewController
    let indexPath = self.postTableView.indexPath(for: sender as! UITableViewCell)
    let photoURL = getPhotoURLFromPosts(indexPath: indexPath!)
    vc.photoURL = photoURL
  }
  
  func getPhotoURLFromPosts(indexPath: IndexPath) -> URL {
    let post = self.posts![indexPath.row]
    
    let photos = post["photos"] as! [NSDictionary]
    let photo = photos[0]
    let photoOriginal = photo["original_size"] as! NSDictionary
    let photoURLString = photoOriginal["url"] as! String
    let photoURL = URL(string: photoURLString)
    return photoURL!
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

