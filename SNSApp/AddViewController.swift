import UIKit
import Firebase

class AddViewController: UIViewController {
    
    @IBOutlet var contentTextView: UITextView!
    
    var me: AppUser!
    var database: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
        database = Firestore.firestore()
    }
    
    func setupTextView() {
        let toolBar = UIToolbar()
        let flexibleSpaceBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        toolBar.items = [flexibleSpaceBarButton, doneButton]
        toolBar.sizeToFit()
        contentTextView.inputAccessoryView = toolBar
    }

    @objc func dismissKeyboard() {
        contentTextView.resignFirstResponder()
    }
    
    @IBAction func postContent() {
        let content = contentTextView.text!
        let saveDocument = database.collection("posts").document()
        saveDocument.setData([
            "content": content,
            "postID": saveDocument.documentID,
            "senderID": me.userID,
            "createdAt": FieldValue.serverTimestamp(),
            "updatedAt": FieldValue.serverTimestamp()
        ]) { error in
            if error == nil {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    // 前の画面に戻るボタン
    @IBAction func back() {
        dismiss(animated: true, completion: nil)
    }
}
