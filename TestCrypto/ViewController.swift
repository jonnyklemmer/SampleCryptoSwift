//
//  ViewController.swift
//  TestCrypto
//
//  Created by Jonny Klemmer on 10/30/18.
//  Copyright © 2018 JonnyKlemmer. All rights reserved.
//

import UIKit
import CryptoSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        test()
    }

    private func test() {
        let key = Array("hashed".sha256().utf8)
        let iv = Array("drowssapdrowssap".utf8)
        print("Key count: \(key.count)")
        // - Key count: 64
        // (since its a SHA-256'd string this count appears correct, however would variant property to yield a preconditionFailure)

        do {
            // based on the variantNr / variantNk appears to default to AES-128
            // newer CryptoSwift versions properly throw the error
            let aes = try AES(key: key, blockMode: .CBC(iv: iv))

            let bytes =  Array("encrypt-me".utf8)
            let encryptedBytes = try aes.encrypt(bytes)
            let newBytes = try aes.decrypt(encryptedBytes)
            let output = String(bytes: newBytes, encoding: .utf8)
            print("output: \(String(describing: output))")
        } catch {
            print("error: \(error)")
        }
    }

}

