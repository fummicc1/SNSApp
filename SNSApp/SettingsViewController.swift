//
//  SettingsViewController.swift
//  SNSApp
//
//  Created by Fumiya Tanaka on 2019/09/02.
//  Copyright © 2019 Fumiya Tanaka. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var userNameTextField: UITextField! // 変更するユーザー名を入力するところ
    var me: AppUser! // 追加
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.delegate = self // デリゲートを指定
        userNameTextField.text = me.userName // 現在のユーザー名をテキストに表示
    }
    
    // returnキーを押したときの処理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // キーボードを閉じる
        return true
    }
    
    //　前の画面に戻るボタン
    @IBAction func back() {
        dismiss(animated: true, completion: nil)
    }
    
    // 保存ボタンを押したときに呼ばれる。
    @IBAction func save() {
        let newUserName = userNameTextField.text!
        Firestore.firestore().collection("users").document(me.userID).setData([
            "userName": newUserName
        ], merge: true) { error in
            if error == nil {
                self.dismiss(animated: true, completion: nil) // errorがなく、正常に終了していたらタイムラインの画面に戻る
            }
        }
    }
    
    // ログアウトボタンを押したときに呼ばれる。
    @IBAction func logout() {
        try? Auth.auth().signOut()
        let accountViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! AccountViewController
        present(accountViewController, animated: true, completion: nil)
    }
}
