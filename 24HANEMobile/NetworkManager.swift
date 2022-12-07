//
//  NetworkManager.swift
//  24HANEMobile
//
//  Created by Katherine JANG on 12/7/22.
//

import Foundation
import Network

class NetworkManager: ObservableObject{
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkMonitor")
    
    @Published var isConnected = true
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected =  path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
    
}
