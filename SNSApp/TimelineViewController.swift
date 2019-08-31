import UIKit
import Firebase

class TimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    var user: User!
    var database: Firestore!
    var postArray: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        database = Firestore.firestore()
        tableView.delegate = self
        tableView.dataSource = self
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
                self.tableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = postArray[indexPath.row].content
        return cell
    }
}
