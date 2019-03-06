//
//  BlockchainViewController.swift
//  ExampleDemo
//
//  Created by xiejiangbo on 2018/9/17.
//  Copyright © 2018年 yin chen. All rights reserved.
//

import UIKit
//import Cocoa

class BlockchainViewController: BaseViewController {

    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "BlockchainViewController", bundle: nil)
        let vc:BlockchainViewController=storyboard.instantiateViewController(withIdentifier: "BlockchainViewController") as! BlockchainViewController
        vc.createArgs=createArgs
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let genesisBlock = Block()
        
        var transaction = Transaction(from: "dx", to: "xzp", amount: 10)
        genesisBlock.addTransaction(transaction: transaction!)
        
        let blockChain = BlockChain.init(gensdisBlock: genesisBlock)
        
        
        
        print("--------------------------------")
        
        transaction = Transaction(from: "swift", to: "objc", amount: 20)
        
        let block = blockChain.getNextBlock(transaction: [transaction!])
        blockChain.addBlock(block)
        print(blockChain.blocks.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
/**
 index 在区块链中的第几账本
 previousHash 当前账本的上一个账本的哈希值
 hash 该账本的哈希值
 nonce 递增数字
 hash = SHA-256(最后一个区块的Hash + 新区块的基本信息 + 交易记录信息 + 随机数)
 */
class Block: Codable {
    var index: Int = 0
    var previousHash: String = ""
    var hash: String!
    var noice: Int
    
    private (set) var transaction:[Transaction]=[Transaction]()
    var key:String {
        get{
            let transactionData = try!JSONEncoder().encode(self.transaction)
            let transactionJSONString:String = String.init(data: transactionData, encoding: .utf8)!
            return (String(index)+String(previousHash)+String(self.noice))
        }
    }
    func addTransaction(transaction: Transaction) {
        self.transaction.append(transaction)
    }
    init() {
        self.noice = 0
    }
    
}
/**
 区块链中的交易内容
 Codable 数据属于json格式的，Codable表示可以解析
 from交易中的甲方
 to 交易中的乙方
 amount 交易的数值内容
 */
class Transaction: Codable {
    var from: String!
    var to: String!
    var amount : Double
    init?(from : String?, to : String?, amount : Double) {
        guard from != nil && to != nil else {
            return nil;
        }
        self.from = from
        self.to = to
        self.amount = amount
    }
}
class BlockChain: Codable {
    private (set) var blocks : [Block] = [Block]()
    init(gensdisBlock:Block) {
        
    }
    func addBlock(_ block : Block) -> Void {
        if self.blocks.isEmpty {
            block.previousHash = "0000000000" // 第一个账本的hash是0000000000
            block.hash = generateHash(for: block)
        }
        self.blocks.append(block)
    }
    func generateHash(for block: Block) -> String {
        var hasn = block.key.sha1()
        while !hasn.hasPrefix("00") {
            block.noice += 1
            hasn = block.key.sha1()
        }
        return hasn
    }
    
    func getNextBlock(transaction : [Transaction]) -> Block {
        let block = Block()
        transaction.forEach { (transaction) in
            block.addTransaction(transaction: transaction)
        }
        let previousBlock = getPreviousBlock()
        block.index = self.blocks.count
        block.previousHash = previousBlock.hash
        block.hash = generateHash(for: block)
        return block
    }
    
    private func getPreviousBlock() -> Block{
        return self.blocks[self.blocks.count - 1]
    }
    
}

// sha1 算法, 将 NSString 转换成 sha1
extension String {
    
    func sha1() -> String {
        
//        let task = Process()
//        task.launchPath = "/usr/bin/shasum"
//        task.arguments = []
//
//        let inputPipe = Pipe()
//
//        inputPipe.fileHandleForWriting.write(self.data(using: .utf8, allowLossyConversion: true)!)
//
//        inputPipe.fileHandleForWriting.closeFile()
//
//        let outputPipe = Pipe()
//
//        task.standardOutput = outputPipe
//        task.standardInput = inputPipe
//        task.launch()
//
//        let data = outputPipe.fileHandleForReading.readDataToEndOfFile()
//        let hash = String(data: data, encoding: .utf8)
//
//        return (hash?.replacingOccurrences(of: "  -\n", with: ""))!
        return ""
    }
}






