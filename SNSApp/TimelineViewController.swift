import UIKit
import Firebase

class TimelineViewController: UIViewController {

    var user: User!
    var database: Firestore!
    var postArray: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        database = Firestore.firestore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        database.collection("posts").getDocuments { (snapshot, error) in
            if error == nil, let snapshot = snapshot {
                self.postArray = []
                for document in snapshot.documents {
                    let data = document.data()
                    let post = Post(data: data)
                    self.postArray.append(post)
                }
                print(self.postArray)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! AddViewController
        destination.user = user
    }
    
    @IBAction func toAddViewController() {
        performSegue(withIdentifier: "Add", sender: user)
    }
}
