//
//  PhotoTableViewController.swift
//  PhotoTableViewController
//
//  Created by อธิคม ปิยะบงการ on 3/3/2564 BE.
//  Copyright © 2564 BE อธิคม ปิยะบงการ. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PhotoTableViewController: UITableViewController {
    private var viewModel: PhotoTableViewModel!
    private var refreshControls = UIRefreshControl()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PhotoTableViewModel()
        bindObservable()
        viewModel.loadData()
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 100)])
    }
    
    private func bindObservable() {
        viewModel.shouldReload.subscribe(onNext: { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
    
    @objc func refresh(sender:AnyObject) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    private func expectRow(photoCount: Int) -> Int {
        return photoCount + photoCount/4
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let photoCount = viewModel.getPhotos().count
        return expectRow(photoCount: photoCount)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 5 == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageInsertionCell", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as! PhotoTableViewCell
            cell.photo = viewModel.getPhotos()[indexPath.row - indexPath.row/5]
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let almostLastElement = expectRow(photoCount: viewModel.getPhotos().count)  - 5
        if indexPath.row == almostLastElement {
            viewModel.loadData()
        }
    }
}
