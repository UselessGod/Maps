//
//  NetworkManager.swift
//  MyMaps
//
//  Created by Дмитрий Емельянов on 17.11.2021.
//

import Foundation
import Alamofire

final class NetworkFactory {

    init() {
        let cache = URLCache(
            memoryCapacity: 0,
            diskCapacity: 0,
            diskPath: nil)
        URLCache.shared = cache
    }
    
    var stack = [URL]()
    
    func makeRequest(_ url: URL) -> URLSessionDataTask? {
        stack.append(url)
        let task = URLSession.shared.dataTask(with: .init(url: url)) { [self] data, responce, error in
            if let error = error {
                auth {
                    stack.forEach { makeRequest($0) }
                }
            } else {
                if let index =  stack.firstIndex(of: url) {
                    stack.remove(at: index)
                }
            }
        }
        task.resume()
        return task
    }
    
    func auth(completion: @escaping () -> Void) {
        
    }
    
    let crtBase64 = "..."
    
    func pinSSL(){
        if let certificationData = Data(base64Encoded: crtBase64, options: []),
           let certificate = SecCertificateCreateWithData(nil, certificationData as CFData) {
            
            let pinned = PinnedCertificatesTrustEvaluator(certificates: [certificate],
                                                          acceptSelfSignedCertificates: true,
                                                          performDefaultValidation: true,
                                                          validateHost: true)
            
            // use cert
            
            var trust: SecTrust?
            let policy = SecPolicyCreateBasicX509()
            let status = SecTrustCreateWithCertificates(certificate, policy, &trust)
            
            if status == errSecSuccess, let trust = trust,
               let publicKey = SecTrustCopyPublicKey(trust) {
                let key = PublicKeysTrustEvaluator(keys: [publicKey],
                                                   performDefaultValidation: true,
                                                   validateHost: true)
                // use key
                
            }
        }
    }
}

