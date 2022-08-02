//
//  ViewController.swift
//  AndelaJsonTests
//
//  Created by Chukwuebuka Nwudo on 28/07/2022.
//

import UIKit

class ViewController: UIViewController {
  
  @IBAction func filterButtonAction(_ sender: Any) {
    tableData = mainData
    guard let tabDataToBeFiltered = tableData else{
      return
    }
    if !priceFilterTextField.text!.isEmpty && !cityFilterTxtField.text!.isEmpty{
        // filter both
        tableData = tabDataToBeFiltered.filter {
          $0.city.contains(cityFilterTxtField.text!) && String($0.price).contains(priceFilterTextField.text!)
        }
      }else if !priceFilterTextField.text!.isEmpty{
        // filter only price
        tableData = tabDataToBeFiltered.filter {
          String($0.price).contains(priceFilterTextField.text!)
        }
      }else  if !cityFilterTxtField.text!.isEmpty{
        // filter only city
        tableData = tabDataToBeFiltered.filter {
           $0.city.contains(cityFilterTxtField.text!)
        }
      }
    tableV?.reloadData()
  }
  
  @IBOutlet weak var priceFilterTextField: UITextField!
  @IBOutlet weak var cityFilterTxtField: UITextField!
  @IBOutlet weak var tableV:UITableView?
  let viewModel = MainViewModel()
  var tableData:[Event]?
  var mainData:[Event]?
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.delegate = self
    priceFilterTextField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
    cityFilterTxtField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
    viewModel.getEvents()
  }

  @objc func textChanged(_ sender: UITextField) {
         print("Text changed - \(sender.text!)")
     }
}


extension ViewController: EventsViewModelDelegate{
  func EventsViewModelDidTransitionToState(model: MainViewModel, state: EventsViewModelState) {
    switch state {
    case .EventsViewModelDidStartRetrievingItems:
      //load
      break
    case .EventsViewModelDidEndRetrievingItems:
      // handle succes
      var children = viewModel.eventList?.map { $0.children }
      let childrenFlat = children?.flatMap { $0 }.compactMap{ $0 }
      let eventList = childrenFlat.map{$0.map{$0.events}.flatMap { $0 }.compactMap{ $0 }}
      tableData = eventList
      mainData = tableData
      tableV?.reloadData()
      break
    case .EventsViewModelDidFailToRetrieveItems:
      // handle failure
      break
    default:
      break
    }
  }
  
  
}


extension ViewController:UITableViewDelegate,UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return tableData?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier) as? MainTableViewCell
    if let data = tableData?[indexPath.row]{
      cell?.configure(event: data)
    }
    
    return cell ?? UITableViewCell()
  }
  
  
}
