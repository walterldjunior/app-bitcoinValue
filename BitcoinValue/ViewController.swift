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
                    print("SUCESSO ao fazer a consulta.")
                    
                    if let dadosRetorno = dados {
                        
                        do {
                            //options: [] -> significa que no JSON não será aplicado nenhum formato
                            let objetoJson = try JSONSerialization.jsonObject(with: dadosRetorno, options: [])
                            print(objetoJson)

                        } catch {
                            print("ERRO ao formatar o retorno de dados!")
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

