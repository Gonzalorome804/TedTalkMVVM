//
//  ViewController.swift
//  TedTalkMVVM
//
//  Created by Gonzalo Romero on 09/12/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableTedTalk: UITableView!
    @IBOutlet weak var pickerTedTalk: UIPickerView!
    @IBOutlet weak var searchTedTalk: UISearchBar!
    
    
    private var viewModel: ViewModelTedTalkProtocol!
    private var tedTalksDisplay: [TedTalkDisplay] = []
    private var pickerSelectedRow = ""
    private var pickerDisplay: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModelTedTalk(displayManager: DisplayManagerTedTalk.sharedTedTalkManager ,observerData: { [unowned self] viewModel in
            self.tedTalksDisplay = viewModel
            self.reloadData()
        }, observerPicker: {[unowned self] viewModel in
            self.pickerDisplay = viewModel
        })
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableTedTalk.reloadData()    }
    }
}
    extension HomeViewController: UITableViewDataSource, UISearchBarDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerDisplay.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerDisplay[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerSelectedRow = pickerDisplay[row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tedTalksDisplay.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let talk = tedTalksDisplay[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "customCellTable", for: indexPath) as? TableCustomCellTedTalk
        if cell == nil {
            cell = TableCustomCellTedTalk()
        }
        cell?.configureCell(talk)
        return cell ?? UITableViewCell()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterTalk(filter: pickerSelectedRow, text: searchText)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationDetailView = segue.destination as? DetailTedTalkViewController, let tableTedTalkIndex = tableTedTalk.indexPathForSelectedRow?.row {
            destinationDetailView.index = tableTedTalkIndex
        }
    }
}

