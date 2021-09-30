//
//  OpportunityViewController.swift
//  NasaAPI-Turker
//
//  Created by Gülşah Alan on 28.09.2021.
//

import UIKit

class OpportunityViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var loadingScreen: UIView!
    @IBOutlet private weak var filterButton: UIBarButtonItem!
    @IBOutlet private weak var cameraScreen: UIView!
    
    private var photoArray: [Rover]?
    private var changePhotoArray: [Rover]?
    private var filteredPhotoArray: [Rover]? = []
    
    private var filterRemove: Bool = true
    
    private var pageCounter = 0
    private var cameraName = ""
    
    private func isLoadingMorePhotos (_ loadingStatus: Bool) {
        if loadingStatus {
            loadingIndicator.startAnimating()
            loadingScreen.isHidden = false
            if let changePhotoArray = changePhotoArray {
                self.photoArray?.append(contentsOf: changePhotoArray)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.collectionView.reloadData()
            }
        } else {
            loadingIndicator.stopAnimating()
            loadingScreen.isHidden = true
            loadingIndicator.hidesWhenStopped = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollecitonView()
        getOpportunityPhotos()
        loadingScreen.isHidden = true
        cameraScreen.isHidden = true
    }
    
    func configureCollecitonView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
}

//MARK: - Get Opportunity Photos
extension OpportunityViewController {
    
    func getOpportunityPhotos() {
        NetworkManager().fetchOpportunityPhotos(page: pageCounter) { [weak self] photoResponse in
            guard let self = self else { return }
            self.photoArray = photoResponse
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func getNewOpportunityPhotos() {
        NetworkManager().fetchOpportunityPhotos(page: pageCounter) { [weak self] photoResponse in
            guard let self = self else { return }
            self.changePhotoArray = photoResponse
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

//MARK: - CollectionView Delegate&DataSource Methods
extension OpportunityViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.opportunityCell.rawValue, for: indexPath) as? OpportunityCollectionViewCell else { return UICollectionViewCell() }
        
        if let photoArray = photoArray {
            cell.configureRoverOutlets(on: photoArray[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let photoArray = photoArray {
            if indexPath.row == photoArray.count - 1 {
                // there are only 2 pages (page= 0 , page=1), therefore i coded this way
                if pageCounter < 2 {
                    pageCounter += 1
                    getNewOpportunityPhotos()
                    isLoadingMorePhotos(true)
                    
                    if filterRemove == false {
                        filterPhoto()
                    } else {
                        return
                    }
                }
            } else {
                isLoadingMorePhotos(false)
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let selectedPhotos = photoArray?[indexPath.row] else { return }
        
        guard let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: K.popUpID.rawValue) as? PopUpViewController else { return }
        
        popUpVC.selectedPhoto = selectedPhotos
        
        self.addChild(popUpVC)
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParent: self)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

//MARK: - Filter Methods
extension OpportunityViewController {
    
    func filterPhoto() {
        if let photoArray = photoArray {
            for rover in photoArray {
                if rover.camera.name == cameraName {
                    filteredPhotoArray?.append(rover)
                }
            }
        }
        
        DispatchQueue.main.async {
            self.photoArray = self.filteredPhotoArray
            self.collectionView.reloadData()
        }
    }
    
    @IBAction func removeFilterButton(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.pageCounter = 0
            self.filteredPhotoArray = []
            self.getOpportunityPhotos()
            self.cameraName = ""
            self.collectionView.reloadData()
        }
        filterRemove = true
        cameraScreen.isHidden = true
    }
    
    @IBAction func filterButtonPressed(_ sender: UIBarButtonItem) {
        cameraScreen.isHidden = false
        DispatchQueue.main.async {
            self.pageCounter = 0
            self.filteredPhotoArray = []
            self.getOpportunityPhotos()
            self.cameraName = ""
            self.collectionView.reloadData()
            self.filterRemove = false
        }
    }
    
    @IBAction func navcamButton(_ sender: UIButton) {
        cameraName = sender.titleLabel?.text ?? ""
        
        if filterRemove == false {
            filterPhoto()
        } else {
            return
        }
        
        cameraScreen.isHidden = true
    }
    
    @IBAction func pancamButton(_ sender: UIButton) {
        cameraName = sender.titleLabel?.text ?? ""
        
        if filterRemove == false {
            filterPhoto()
        } else {
            return
        }
        
        cameraScreen.isHidden = true
    }
    
}
