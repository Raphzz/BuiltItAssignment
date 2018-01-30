//
//  Networking.swift
//  BuiltItAssignment
//
//  Created by Raphael on 30/01/18.
//  Copyright © 2018 Raphael. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import RxSwift

class Networking {
    func requestAPI() -> Observable<Result> {
        return Observable.create { observer in
            Alamofire.request("http://api.openweathermap.org/data/2.5/forecast?q=London,us&APPID=0167a92e0bd7514afa83dd9c4e7c095c&units=metric", method: .post).responseObject { (response: DataResponse<Result>) in
                    switch response.result{
                    case .success:
                        let result = response.result.value
                        observer.onNext(result!)
                        observer.onCompleted()
                    case .failure:
                        print(response.error!)
                    }
            }
            
            return Disposables.create()
        }
    }
}
