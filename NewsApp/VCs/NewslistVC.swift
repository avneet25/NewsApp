//
//  NewslistVC.swift
//  NewsApp
//
//  Created by Avneet Kaur on 2022-01-01.
//

import UIKit
import Alamofire
import SDWebImage

class NewslistVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    
    @IBOutlet weak var newslistCV: UICollectionView!
    var data = [[String:Any]]() //stores data from api call
    var Categ = [String]() //stores category info from previous screen
    var ACCESS_KEY = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }

    func getData()
    {
        var codeStr = ""
        var categStr = ""
        
        for str in CCODE {
            codeStr.append(str)
            if str != CCODE[CCODE.count - 1] {
                codeStr.append(", ")
            }
        }
        
        for str in Categ {
            categStr.append(str)
            if str != Categ[Categ.count - 1] {
                categStr.append(",")
            }
        }

        
        let apiUrl = "https://api.mediastack.com/v1/news ? access_key = \(ACCESS_KEY) & languages = \(LANG) & countries = \(codeStr) & categories = \(categStr)"
        
        AF.request(apiUrl).responseJSON { [self] result in
            if let value = result.value as? [String:Any] {
                print(value)
                data = value["data"] as! [[String:Any]]
               // cv.reloadData()
        }
            else {
                print("error")
            }
        
        
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //cotrolling number of articles per page (=10)
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newslistCV.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as! CollectionViewCell
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: ((self.view.frame.width)-20), height: ((self.view.frame.width)-20)*0.3)
    }
    
    @IBAction func dropDownAction(_ sender: Any) {
        
    }
    
    /*
     
     AF.request(apiUrl).responseJSON { [self] result in
         if let value = result.value as? [String:Any] {
             print(value)
             data = value["data"] as! [[String:Any]]
             cv.reloadData()
     }
     
     
     
     let cell = languageCV.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as! CollectionViewCell
     
     cell.layer.borderWidth = 0.5
     cell.layer.borderColor = UIColor.darkGray.cgColor
     cell.layer.cornerRadius = 10
//        cell.contentView.layer.masksToBounds = true
//        cell.contentView.layer.cornerRadius = 10
//
//        cell.layer.shadowOffset = .zero
//        cell.layer.shadowColor = UIColor.black.cgColor
//        cell.layer.shadowOpacity = 0.5
//        cell.layer.cornerRadius = 10
//        cell.layer.masksToBounds = false
     
   
     let parti = data[indexPath.row]
    // print(parti)
     cell.titleLbl.text = parti["title"] as! String
     cell.authorLbl.text = parti["source"] as! String
 
     if let imgurl = parti["image"] as? String {
         cell.img.sd_setImage(with: URL.init(string: imgurl)) { img, Err, cache, url in
         
         }
     }
     
     
     return cell
     
     
     return CGSize.init(width: self.view.frame.width - 30 , height: (self.view.frame.width * 0.4))
     */
    
}


