//  MyDownloader.swift  IpaDownCreated by ice on 16/10/6.
//  Copyright © 2016年 k. All rights reserved.

import UIKit
import Alamofire
//import SwiftyJSON


//区分同一页面的下载类型
public enum DownloadType: Int{
    
    case  AppTable
    case  Advertisement   //下载广告
}


//区分 网络请求的方式
public enum MyRequestMethod: String{
    
    case MyGet
    case MyPost
}


//下载完成后 执行的方法,具体实现在 代理页面
protocol MyDownloaderDelegate: NSObjectProtocol {
    
    //下载成功  //返回的数据是 AnyObject 类型
    func downloader(downloader: MyDownloader, didFinishWithData data: AnyObject)
    
    //下载失败
    func downloader(downloader: MyDownloader, didFailWithError error: NSError)
    
}


class MyDownloader: NSObject {
    
    weak var delegate: MyDownloaderDelegate?
    
    var type: DownloadType?
    
    func downloadWithUrlString(urlString: String, methodOfRequest method: MyRequestMethod, parameterDict dict: [String: AnyObject]?){  //参数二区分请求方式,,,参数三传入POST请求的请求体
        
        //区别两种请求方式
        if method == .MyGet{
            
            //get请求
            Alamofire.request(.GET, urlString).responseJSON(completionHandler: { (response) -> Void in
                
                switch response.result{
                    
                    //失败
                    case .Failure(let error):
                    
                        self.delegate?.downloader(self, didFailWithError: error)
                    
                    //成功
                    case .Success(let jsonDate):  //jsonData 为AnyObject类型
                        
                        self.delegate?.downloader(self, didFinishWithData: jsonDate)
                
                }

            })
            
            
        }else{ //POST请求
            
            if dict != nil{  // 请求参数不为空
            
               Alamofire.request(.POST, urlString, parameters: dict!, encoding: ParameterEncoding.URL, headers: nil).responseJSON(completionHandler: { (response) -> Void in
                
                    switch response.result{
                        
                        case .Failure(let error):
                        
                            self.delegate?.downloader(self, didFailWithError: error)
                        
                        case .Success(let jsonDate):
                            
                            self.delegate?.downloader(self, didFinishWithData: jsonDate as! NSData)
                        
                    }
               })
            }
        }
    }

    
    
}
