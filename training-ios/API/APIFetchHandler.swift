//
//  APIFetchHandler.swift
//  training-ios
//
//  Created by Bui Trung Quan on 30/10/2023.
//

import Foundation
import Alamofire
import UIKit

class APIFetchHandler {
    static let shared = APIFetchHandler()
    
    var access_token = ""
    
    let headers: HTTPHeaders = [
        "app-id": "653f385075eab0704b56b05c"
    ]
    
    func getDataInstagram(completion: @escaping (_ name: String)->Void) {
        let url = "https://graph.instagram.com/me?fields=id,username&access_token=\(self.access_token)"
        AF.request(url, method: .get).response { response in
            switch response.result{
                case .success(let data):
                    do{
                        let jsonData = try JSONDecoder().decode(UserInstagram.self, from: data!)
                        completion(jsonData.username)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func getAccessTokenInstagram(code: String,completion: @escaping (_ name: String)->Void) {
        let url = "https://api.instagram.com/oauth/access_token?locale=en_US"
        let params: [String: Any] = [
            "client_id": Global.shared.clientId,
            "client_secret": Global.shared.clientSecret,
            "code": code,
            "grant_type": "authorization_code",
            "redirect_uri": Global.shared.redirectUri
        ]
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        AF.request(url, method: .post,parameters: params, headers: headers).response { response in
            switch response.result{
                case .success(let data):
                    do{
                        let jsonData = try JSONDecoder().decode(TokenInstagram.self, from: data!)
                        self.access_token = jsonData.access_token
                        APIFetchHandler.shared.getDataInstagram { name in
                            completion(name)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func getDataZalo(completion: @escaping (_ name: String,_ url: String)->Void) {
        let headersZalo: HTTPHeaders = [
            "access_token": access_token
        ]
        
        AF.request("https://graph.zalo.me/v2.0/me?fields=id,name,picture", method: .get, headers: headersZalo).response { response in
            switch response.result{
                case .success(let data):
                    do{
                        let jsonData = try JSONDecoder().decode(UserZalo.self, from: data!)
                        print(jsonData.picture.data.url)
                        completion(jsonData.name, jsonData.picture.data.url)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func fetchAPIData() {
        let url = "https://jsonplaceholder.typicode.com/posts";
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response{ resp in
                switch resp.result{
                    case .success(let data):
                        do{
                            let jsonData = try JSONDecoder().decode([Model].self, from: data!)
                            print(jsonData)
                        } catch {
                            print(error.localizedDescription)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
    }
    
    func fetchAPIDataMovie(completion: @escaping ([ModelMovie]) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/popular?api_key=dc9e9a73378330417bb4818abf1b60ed&language=en-US&page=1"
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response{ resp in
                switch resp.result{
                    case .success(let data):
                        do{
                            let jsonData = try JSONDecoder().decode(ResultMovie.self, from: data!)
                            completion(jsonData.results)
                        } catch {
                            print(error.localizedDescription)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
    }
    
    func fetchImage(path: String,completion: @escaping ((UIImage?, _ request: DataRequest?)->Void)) {
        var request: DataRequest? = nil
        request = AF.request( path,method: .get).response{ response in
            
            switch response.result {
                case .success(let responseData):
                    completion(UIImage(data: responseData!, scale:1), request)
                    
                case .failure(let error):
                    print("error--->",error)
            }
        }
    }
    
    func deleteUser(user: User,completion: @escaping (()->Void)) {
        AF.request("https://dummyapi.io/data/v1/user/\(user.id!)",method: .delete, headers: headers).response { response in
            switch response.result {
                case .success(let responseData):
                    do{
                        let jsonData = try JSONSerialization.jsonObject(with: responseData!)
                        print(jsonData)
                        completion()
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print("error--->",error)
            }
        }
    }
    
    func getListUser(page: Int = 0,completion: @escaping (([User])->Void)) {
        AF.request("https://dummyapi.io/data/v1/user?page=\(page)",method: .get, headers: headers).response { response in
            switch response.result {
                case .success(let responseData):
                    do{
                        let jsonData = try JSONDecoder().decode(ResultUser.self, from: responseData!)
                        completion(jsonData.data)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print("error--->",error)
            }
        }
    }
    
    func createUser(user: User, completion: @escaping ()->Void) {
        AF.request("https://dummyapi.io/data/v1/user/create",method: .post,parameters: user, headers: headers).response { response in
            switch response.result {
                case .success(let responseData):
                    print(responseData)
                    completion()
                case .failure(let error):
                    print("error--->",error)
            }
        }
    }
    
    func updateUser(user: User, completion: @escaping ()->Void) {
        AF.request("https://dummyapi.io/data/v1/user/\(user.id!)",method: .put,parameters: user, headers: headers).response { response in
            switch response.result {
                case .success(let responseData):
                    print(responseData)
                    completion()
                case .failure(let error):
                    print("error--->",error)
            }
        }
    }
}
