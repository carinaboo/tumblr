//
//  PhotosDetailsViewController.swift
//  Tumblr
//
//  Created by Carina Boo on 10/12/16.
//  Copyright © 2016 Carina Boo. All rights reserved.
//

import UIKit

class PhotosDetailsViewController: UIViewController {
  
  @IBOutlet weak var detailPhotoView: UIImageView!
  
  var photoURL: URL!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      self.detailPhotoView.setImageWith(self.photoURL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
