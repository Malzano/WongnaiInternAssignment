//
//  PhotoTableViewModel.swift
//  PhotoTableViewModel
//
//  Created by อธิคม ปิยะบงการ on 3/3/2564 BE.
//  Copyright © 2564 BE อธิคม ปิยะบงการ. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa

final class PhotoTableViewModel {
    
    private let url = "https://api.500px.com/v1/photos?feature=popular&page="
    private var currentPage = 1
    private let photos = BehaviorRelay(value: [Photo]())
    
    var shouldReload: Observable<Bool> {
        return photos.asObservable().map { _ in return true }
    }
    
    func loadData() {
        guard let JSONURL = URL(string: url + String(currentPage)) else { return }
        URLSession.shared.dataTask(with: JSONURL) { (data, response , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let JsonData = try decoder.decode(Photos.self, from: data)
                print(self.currentPage)
                self.currentPage == 1 ? self.photos.accept(JsonData.photos) : self.photos.accept(self.photos.value + JsonData.photos)
                self.currentPage += 1
            } catch let err {
                print("Err", err)
            }
        }.resume()
    }
    
    func getPhotos() -> [Photo] {
        return photos.value
    }
    
}


struct Photos : Codable {
    let photos: [Photo]
}

struct Photo: Codable {
    let image_url: [String]
    let name : String
    let description : String
    let positive_votes_count : Int
}
