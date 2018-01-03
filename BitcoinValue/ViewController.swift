//
//  ViewController.swift
//  BitcoinValue
//
//  Created by Walter Junior on 28/12/2017.
//  Copyright © 2017 Walter Junior. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var precoBitcoin: UILabel!
    @IBOutlet weak var botaoAtualizar: UIButton!
    @IBAction func atualizarPreco(_ sender: Any) {
        self.recuperarPrecoBitcoin()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recuperarPrecoBitcoin()
    }
    
    func formatarPreco(preco: NSNumber) -> String {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.locale = Locale(identifier: "pt_BR")
        
        if let precoFinal = nf.string(from: preco) {
            return precoFinal
        }
        
        return "0,00"
        
    }
    
    func recuperarPrecoBitcoin() {
        
        self.botaoAtualizar.setTitle("Atualizando...", for: .normal)
        
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
                                    if let precoBRL = brl["buy"] as? Double {
                                        let precoFormatado = self.formatarPreco(preco: NSNumber(value: precoBRL))
                                        
                                        // Para atualizar componentes de interface dentro da clouser usando um thread
                                        DispatchQueue.main.async(execute: {
                                            self.precoBitcoin.text = "R$ " + precoFormatado
                                            self.botaoAtualizar.setTitle("Atualizar", for: .normal)
                                        })
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

