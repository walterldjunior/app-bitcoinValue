//
//  ViewController.swift
//  BitcoinValue
//
//  Created by Walter Junior on 28/12/2017.
//  Copyright © 2017 Walter Junior. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "https://blockchain.info/pt/ticker") {
            
            // dataTask é uma tarefa que fica executando até conseguir um retorno, sucesso ou erro.
            let tarefa = URLSession.shared.dataTask(with: url, completionHandler: { (dados, requisicao, erro) in
                if erro == nil {
                    print("SUCESS")
                    
                    if let dadosRetorno = dados {
                        
                        do {
                            //options: [] -> significa que no JSON não será aplicado sem nenhum formato
                            if let objetoJson = try JSONSerialization.jsonObject(with: dadosRetorno, options: []) as? [String: Any] {
                                if let brl = objetoJson["BRL"] as? [String: Any] {
                                    if let precoBRL = brl["buy"] as? Float {
                                        print(precoBRL)
                                    }
                                }
                            }
                        } catch {
                            print("ERROR")
                        }
                    }
                } else {
                    print("ERRO ao fazer a consulta")
                }
            })
            // metodo resume é quem inicia a tarefa.
            tarefa.resume()
        }
    }
}

