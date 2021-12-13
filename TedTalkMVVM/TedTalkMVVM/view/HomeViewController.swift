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
    
    var viewModel: ViewModelTedTalkProtocol!
    var tedTalksDisplay: [TedTalkDisplay] = []
    private var pickerSelectedRow = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModelTedTalk(displayManager: DisplayManagerTedTalk.shareTedTalkManager ,observerData: { [unowned self] viewModel in
            self.tedTalksDisplay = viewModel
            self.reloadData()
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
        viewModel.getPickerRowsCount()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        viewModel.getPickerRow(index: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerSelectedRow = viewModel.getPickerRow(index: row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tedTalksDisplay.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let talk = viewModel.getFilteredTalk(for: indexPath.row)
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
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showDetail", sender: viewModel.getFilteredTalk(for: indexPath.row))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail",
           let destinationViewController = segue.destination as? DetailTedTalkViewController,
           let selectedTedTalk = sender as? TedTalkDisplay {
            destinationViewController.setTedTalk(talk: selectedTedTalk)
        }
    }
}

