//
//  ViewController.swift
//  Project 37 გიორგი მაჩაბლიშვილი
//
//  Created by Gio's Mac on 02.07.24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        return collectionView
    }()
    
    private var jobManager = JobsManager()
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraint()
        loadData()
        refreshNews()
    }
    
    func setup() {
        view.addSubview(collectionView)
    }
    
    func setupConstraint() {
        collectionView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func loadData() {
        let urlString = "https://jobicy.com/api/v2/remote-jobs"
        guard let url = URL(string: urlString) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            }
            
            guard let data else {
                return
            }
            
            do {
                let info = try JSONDecoder().decode(JobsResponse.self, from: data)
                DispatchQueue.main.async {
                    
                    self.jobManager.setJobInfo(info.jobs)
                    self.collectionView.reloadData()
                }
                
            } catch {
                dump(error)
            }
        }
        task.resume()
    }
    
    func refreshNews() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(newsInfoRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    @objc func newsInfoRefresh() {
        loadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//            let urlString = "https://jobicy.com/jobs-rss-feed?utm_source=apislist.com#section1"
//            guard let url = URL(string: urlString) else {
//                return
//            }
//            
//            var request = URLRequest(url: url)
//            request.httpMethod = "GET"
//            
//            let task = URLSession.shared.dataTask(with: request) { data, response, error in
//                if let error = error {
//                    print(error)
//                }
//                
//                guard let data else {
//                    return
//                }
//                
//                do {
//                    let info = try JSONDecoder().decode(JobsResponse.self, from: data)
//                    DispatchQueue.main.async {
//                        
//                        self.jobManager.setJobInfo(info.jobs)
//                        self.collectionView.reloadData()
//                    }
//                    
//                } catch {
//                    dump(error)
//                }
//            }
//            task.resume()
            self.refreshControl.endRefreshing()
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobManager.jobInfoCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        let info = jobManager.getJobInfo()
        let jobCell = info[indexPath.row]
        cell.configure(with: jobCell)
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: 150)
    }
}
