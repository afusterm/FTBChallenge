//
//  PlayersViewController.swift
//  FTBChallenge
//
//  Created by Alejandro on 24/12/2017.
//  Copyright © 2017 Alejandro. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController {
    private let reuseIdentifier = "PlayerCell"
    
    var collectionView: UICollectionView!
    var players: Players!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadPlayers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func downloadPlayers() {
        let playersInteractor = PlayersInteractor()
        playersInteractor.download(closure: {(players: Players) -> Void in
            self.players = players
            setupCollectionView()
        })
    }
    
    func setupCollectionView() {
        let layout = createLayout()
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(PlayerCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let background = UIImage(named: "fondo_players.jpg")
        let backgroundView = UIImageView(image: background)
        collectionView.backgroundView = backgroundView
        
        view.addSubview(collectionView)
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .vertical
        let itemSide = view.frame.width / 2.3
        layout.itemSize = CGSize(width: itemSide, height: itemSide)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return layout
    }
}

extension PlayersViewController: UICollectionViewDelegate,
    UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PlayerCell
        let player = players.get(position: indexPath.row)
        cell.textLabel.text = player.name
        cell.imageView.image = player.image
        
        return cell
    }
}
