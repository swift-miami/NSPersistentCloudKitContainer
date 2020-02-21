//  Created by Dylan  on 2/18/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.
//

import UIKit
import CoreData

class AlbumsViewController: UIViewController, CanReadFromDatabase {
    
    //MARK: Properties
    lazy private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.registerCell(cellClass: AlbumsCell.self)
        return tableView
    }()
    var band: Band?
    var albumsController: NSFetchedResultsController<NSFetchRequestResult>?
        
    
    
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        navigationItem.title = band?.name ?? ""
        configureController()
    }
    
    //MARK: - Helpers
    func setupView() {
        view.addSubview(tableView)
        tableView.setTableViewFullScreenConstraints(in: view)
    }
    
    func configureController() {
        let bandPredicate = NSPredicate(format: "band == %@", band!)
        albumsController = configureAlbumsController(with: bandPredicate)
        albumsController?.delegate = self
    }
    
    func fetchAllAlbums() -> Int {
        if let allAlbums = albumsController?.fetchedObjects as? [Albums] {
            return allAlbums.count
        }
        else { return 0 }
    }
}

//MARK: - UITableView Data Source Methods
extension AlbumsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return fetchAllAlbums()
        default: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let textFieldCell = TextFieldCell(style: .default, reuseIdentifier: "textCell")
        let albumsCell: AlbumsCell = tableView.dequeueReusableCell(for: indexPath)
        
        switch indexPath.section {
        case 0:
            textFieldCell.configureTextFieldCell(placeholder: .Album, textFieldDelegate: self)
            return textFieldCell
            
        case 1:
            let frcIndexPath = IndexPath(row: indexPath.row, section: 0)
            let album = albumsController?.object(at: frcIndexPath) as? Albums
            
            if let albumTitle = album?.title, let albumYear = album?.releaseYear {
                albumsCell.configureAlbumCell(albumName: albumTitle, albumYear: albumYear)
            }
            return albumsCell
            
        default: return UITableViewCell()
        }
    }
}

//MARK: UITableView Delegate Methods
extension AlbumsViewController: UITableViewDelegate {
    
}

//MARK: - UITextField Delegate Methods
extension AlbumsViewController: UITextFieldDelegate, CanWriteToDatabase {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let album = textField.text {
            let year = "2019"
            saveAlbumToCoreData(albumTitle: album, albumYear: year, band: band!)
        }
        
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
}


//MARK: Core Data NSFetchedResultsController Delegate Methods
extension AlbumsViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            print("Inserting Album: \(anObject as? Albums)")
            guard let newIndexPath = newIndexPath else {
                return
            }
            let frcIndexPath = IndexPath(row: newIndexPath.row, section: 1)
            tableView.insertRows(at: [frcIndexPath], with: .fade)
            
        case .update:
            guard let indexPath = indexPath, let managedObject = anObject as? Band else {
                return
            }
            print("Updating Album: \(managedObject.name ?? "") at IP: \(indexPath)")
            
        case .move:
            print("If your Moving ")
            
        case .delete:
            print("Delete")
            
        @unknown default: ()

        }
    }
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}
