//
//  storeCookie.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/2/22.
//

import Foundation

func createFile(token: String) -> Bool{
    let fileManager = FileManager.default
    let documentPath: URL = fileManager.urls(for:.documentDirectory, in: .userDomainMask)[0]
    let directoryPath: URL = documentPath.appendingPathComponent("UserToken")
    let textPath: URL = directoryPath.appendingPathComponent("UserToken.txt")
    
    do {
        let dataFromPath: Data = try Data(contentsOf: textPath)
        let text: String = String(data: dataFromPath, encoding: .utf8) ?? "File not Exist"
        print(text)
    } catch let error {
        print(error.localizedDescription)
        return false
    }
    return true
}

func getFileURL () -> URL {
    let documentsURL = try! FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let tokenURL = documentsURL.appendingPathComponent("UserToken.txt")
    let fileExists = FileManager().fileExists(atPath: tokenURL.path)
    if fileExists {
        return tokenURL
    }
    return URL(string: "error")!
}

func saveToken(token: String) -> Bool {
    let filePath = getFileURL()
    if filePath == URL(string: "error") {
        print("token: \(token)")
        let documentsURL = try! FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let textPath = documentsURL.appendingPathComponent("UserToken.txt")
        if let data: Data = token.data(using: String.Encoding.utf8){
            do{
                try data.write(to: textPath)
            } catch let error {
                print(error.localizedDescription)
                return false
            }
        }
    } else {
        print("heyheyney")
        if let data: Data = token.data(using: String.Encoding.utf8){
            do{
                print("papapapap")
                try data.write(to: filePath)
                return true
            } catch let error {
                print(error.localizedDescription)
                return false
            }
        }
    }
    return true
}

func getTokenfromFile() -> String{
    let filePath = getFileURL()
    do{
        let dataFromPath: Data = try Data(contentsOf: filePath)
        let Token: String = String(data: dataFromPath, encoding: .utf8) ?? "File Not Exist"
        return Token
    } catch let error {
        print(error.localizedDescription)
        return error.localizedDescription
    }
}
