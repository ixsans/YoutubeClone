//
//  ViewController.swift
//  YoutubeApp
//
//  Created by Ikhsan on 24/7/18.
//  Copyright © 2018 Yanmii. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var videos: [Video] = {
        let zakirVideo = Video()
        zakirVideo.thumbnailImageName = "zakir_video"
        zakirVideo.title = "American Girl VS Dr Zakir Naik 2018"
        zakirVideo.numOfView = 249320332092302
        let zakirChannel = Channel()
        zakirChannel.name = "Zakir Naik Official"
        zakirChannel.profileImageName = "zakir_profile"
        zakirVideo.channel = zakirChannel
        
        let slidenerdVideo = Video()
        slidenerdVideo.thumbnailImageName = "slidenerd_video"
        slidenerdVideo.title = "[Android] Complete Slidenerd Android Tutorials"
        slidenerdVideo.numOfView = 249320332092302
        let slidenerdChannel = Channel()
        slidenerdChannel.name = "Slidenerd"
        slidenerdChannel.profileImageName = "slidenerd_profile"
        slidenerdVideo.channel = slidenerdChannel
        
       return [zakirVideo, slidenerdVideo]
    }()
    
    
    let menuBar: MenuBar = {
        let bar = MenuBar()
        return bar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.backgroundColor = UIColor.red
        navigationItem.title = "Home"
        
        navigationController?.navigationBar.isTranslucent = false
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        setupMenuBar()
        
        setupNavBarButtons()
        
        fetchVideos()
    }
    
    private func fetchVideos() {
        let url = URL(string: "http://www.mocky.io/v2/5b5eb3c72e0000020a6945d3")
        URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            if error != nil {
                print(error ?? "-")
                return
            }
            
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                self.videos.removeAll()
                for dictionary in json as! [[String : AnyObject]]{
                    //print(dictionary["title"])
                    let video = Video()
                    video.title = dictionary["title"] as! String
                    video.numOfView = dictionary["number_of_views"] as? NSNumber ?? 0
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as! String
                    
                    let dictChannel = dictionary["channel"]
                    let channel = Channel()
                    channel.name = dictChannel!["name"] as! String ?? "-"
                    channel.profileImageName = dictChannel!["profile_image_name"] as! String
                    video.channel = channel
                    
                    self.videos.append(video)
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                }
                
            }catch let jsonException {
                print(jsonException)
            }
        }.resume()
    }
    
    

    private func setupMenuBar(){
        view.addSubview(menuBar)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
    private func setupNavBarButtons() {
        let searchBtnImage = UIImage(named: "ic_search")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        let searchBarBtnItem = UIBarButtonItem(image: searchBtnImage, style: .plain, target: self, action:#selector(handleSearch))
        
        let moreBtnImage = UIImage(named: "ic_more")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        let moreBarBtnItem = UIBarButtonItem(image: moreBtnImage, style: .plain, target: self, action:#selector(handleSearch))
        
        
        navigationItem.rightBarButtonItems = [moreBarBtnItem, searchBarBtnItem]
    }
    
    @objc private func handleSearch() {
        print("search")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 68)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}




