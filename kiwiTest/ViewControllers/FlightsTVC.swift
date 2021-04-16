//
//  FlightListTVC.swift
//  kiwiTest
//
//  Created by Pavle Mijatovic on 15.4.21..
//

import UIKit

class FlightsTVC: UITableViewController, Storyboarded {
    
    // MARK: - API
    weak var mainCoordinator: MainCoordinator?
    
    // MARK: - Properties
    @IBOutlet weak var cityImageView: FlightsImageView!
    private var flights: [FlightVM]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private let flightInfoService = FlightInfoService()
    private var urlSessionDataTask: URLSessionDataTask?
    private var vm = FlightsVM() {
        didSet {
            DispatchQueue.main.async {
                self.setUI()
            }
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        setUI()
        fetchFlights(first: vm.numberOfFlightsOfInterest)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        urlSessionDataTask?.cancel()
    }
    
    // MARK: - Helper
    private func setUI() {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        title = vm.title
        vm.isFetchingInProgress ? BlockingScreen.start(vc: self) : BlockingScreen.stop()
    }
    
    private func fetchFlights(first numberOfFirstFlights: Int) {
        urlSessionDataTask = flightInfoService.fetchFlights(flightRequest: FlightRequest()) { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            
            case .failure(let err):
                
                AlertHelper.simpleAlert(message: err.errorDescription, vc: self) {
                    self.vm = FlightsVM(isFetchingInProgress: false)
                }
                
            case .success(let flights):
                self.vm = FlightsVM(isFetchingInProgress: false)
                
                guard flights.count > 0 else {
                    AlertHelper.simpleAlert(message: self.vm.errMsg, vc: self) {}
                    
                    return
                }
                
                let firstNFlights = FlightVM.getFirst(n: numberOfFirstFlights, from: flights.map { FlightVM(flight: $0) })
                self.flights = firstNFlights
                
                guard let destinationImgName = firstNFlights?.first?.destinationToImageName else { return }
                
                self.cityImageView.setImage(withName: destinationImgName) { (err) in
                    AlertHelper.simpleAlert(message: err.errorDescription, vc: self) { }
                }
            }
        }
    }
}

//MARK: - UITableViewDataSource
extension FlightsTVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.flights?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FlightListCell.id, for: indexPath) as? FlightListCell else { return UITableViewCell() }
        
        cell.vm = self.flights?[indexPath.row]
        
        cell.buyFlight = { destionationUrlString in
            self.mainCoordinator?.buy(flight: destionationUrlString)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            tableView.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
        }
    }
}

//MARK: - UITableViewDelegate
extension FlightsTVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        guard let imgName = flights?[indexPath.row].destinationToImageName else { return }
        self.cityImageView.setImage(withName: imgName) { (err) in
            AlertHelper.simpleAlert(message: err.errorDescription, vc: self) {
                self.vm = FlightsVM(isFetchingInProgress: false)
            }
        }
    }
}
