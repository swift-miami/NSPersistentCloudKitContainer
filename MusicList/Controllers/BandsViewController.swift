
//  Created by Dylan  on 2/18/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.
//

import UIKit
import CoreData


class BandsViewController: UIViewController, CanReadFromDatabase {
    //MARK: - Properties
    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.registerCell(cellClass: BandCell.self)
        return tableView
    }()
    lazy var controller: NSFetchedResultsController<NSFetchRequestResult> = {
        let controller = self.bandsFetchedResultsController
        controller.delegate = self
        return controller
    }()
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        navigationItem.title = "Bands"
        
    }

    
    
    //MARK: - Helpers
    func setUpView() {
        view.addSubview(tableView)
        tableView.setTableViewFullScreenConstraints(in: view)
    }
    
    
   
}

//MARK: - UITableView Data Source Methods
extension BandsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return bandsCount()
        default: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TableView Cells
        let textFieldCell = TextFieldCell(style: .default, reuseIdentifier: "textFieldCell")
        let bandCell: BandCell = tableView.dequeueReusableCell(for: indexPath)
        
        switch indexPath.section {
        case 0:
            //Text Field
            textFieldCell.configureTextFieldCell(placeholder: .Band, textFieldDelegate: self)
            return textFieldCell
        case 1:
            let fetchedResultsIndex = IndexPath(row: indexPath.row, section: 0)
            let bandAtIndexPath = controller.object(at: fetchedResultsIndex) as? Band
            bandCell.configureBandCell(bandName: bandAtIndexPath?.name)
            return bandCell
            
        default: return UITableViewCell()
        }
    }
}

//MARK: UITableView Delegate Methods
extension BandsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0: return
        case 1:
            let albumsVC = AlbumsViewController()
            let band = controller.object(at: IndexPath(row: indexPath.row, section: 0)) as? Band
            albumsVC.band = band
            navigationController?.pushViewController(albumsVC, animated: true)
            
        default: return
        }
    }
}

//MARK: UITextField Delegate Methods
extension BandsViewController: UITextFieldDelegate, CanWriteToDatabase {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let bandName = textField.text {
            saveBandToCoreData(bandName: bandName)
        }
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
}

//MARK: NSFetchedResultsController Delegate Methods
extension BandsViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            
        case .insert:
            print("Inserting Band: \(anObject as? Band)")
            guard let newIndexPath = newIndexPath else {
                return
            }
            let frcIndexPath = IndexPath(row: newIndexPath.row, section: 1)
            tableView.insertRows(at: [frcIndexPath], with: .fade)
            
            
        case .update:
            print("Updating: \(anObject as? Band)")
            guard let indexPath = indexPath, let managedObject = anObject as? Band else {
                return
            }
            print("Updating \(managedObject) at Indexpath: \(indexPath)")
            
        case .move:
            print("Moving \(anObject as? Band)")
            
        case .delete:
            print("Deleting \(anObject as? Band)")
            
        @unknown default: ()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
