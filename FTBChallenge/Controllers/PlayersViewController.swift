//
//  PlayersViewController.swift
//  FTBChallenge
//
//  Created by Alejandro on 01/01/2018.
//  Copyright © 2018 Alejandro. All rights reserved.
//

import UIKit

class PlayersViewController: UICollectionViewController {
    // MARK: Properties
    
    private let reuseIdentifier = "PlayerCell"
    private let headerReuseIdentifier = "HeaderCell"
    private let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    private let itemsPerRow: CGFloat = 2
    
    private var players: Players
    
    init(players: Players, layout: UICollectionViewLayout) {
        self.players = players
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCellClasses()
        
        navigationController?.isNavigationBarHidden = false
        collectionView?.backgroundColor = UIColor(red: 0.183, green: 0.702, blue: 0.634, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func registerCellClasses() {
        collectionView?.register(PlayerCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let nib = UINib(nibName: "PlayersHeaderView", bundle: nil)
        collectionView?.register(nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView,
         numberOfItemsInSection section: Int) -> Int {
        return players.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath) as! PlayersHeaderView
        return header
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PlayerCell
    
        let player = players.get(position: indexPath.row)
        let imageCache = ImageCache.shared
        cell.name = player.name
        imageCache.get(for: player.imageUrl) { (image) in
            cell.image = image
        }
    
        return cell
    }
}

extension PlayersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let aspectRatio: CGFloat = 1.78125
        
        return CGSize(width: widthPerItem, height: widthPerItem / aspectRatio)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: CGFloat(100))
    }
}
