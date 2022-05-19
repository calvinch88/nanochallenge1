//
//  ViewController.swift
//  NanoChallenge1
//
//  Created by Calvin Chandra on 28/04/22.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var wrNow: UITextField!
    @IBOutlet weak var matchTotal: UITextField!
    @IBOutlet weak var wrWant: UITextField!
    @IBOutlet weak var outputText: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    struct gambar {
        var title: String?
        var imageName: String?
    }
    
    var images = [gambar]()
    
    func initData() {
        let before = gambar(title: "WinRate & jumlah pertandingan saat ini", imageName: "before")
        let simulasi = gambar(title: "Dari WinRate 75% ingin menjadi 80%", imageName: "simulasi")
        let proses = gambar(title: "Proses 2 win tanpa kalah (rank / clasic)", imageName: "proses")
        let after = gambar(title: "WinRate 80% berhasil tercapai", imageName: "after")
        images.append(before)
        images.append(simulasi)
        images.append(proses)
        images.append(after)
        // trigger refresh collection view
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GambarView
        let asset = images[indexPath.row]
        cell.tulisan.text = asset.title!
        cell.gambar.image = UIImage(named: asset.imageName!)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        initData()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func buttonHitung(_ sender: Any) {
        var strNow:NSString = wrNow.text as! NSString
        let now = strNow.floatValue
        var strTotal:NSString = matchTotal.text as! NSString
        let total = strTotal.floatValue
        var strWant:NSString = wrWant.text as! NSString
        let want = strWant.floatValue
        var hasilWin:Float = 0
        var hasilLose:Float = 0
        var match:Float = 0.0
        var win:Float = 0.0
        var noLose:Float = 0.0
        switch (now, total, want) {
        case (0, 0, 100):
            outputText.text = "Kalau belum pernah main dan ingin mendapatkan WinRate 100% cukup main sekali aja"
        case (...100 ,0... ,100):
            outputText.text = "WinRate yang dinginkan tidak bisa mencapai 100% jika sudah pernah kalah sekali"
        default:
            hasilWin = total * now / 100
            hasilLose = total - hasilWin
            match = hasilLose / (100 - want)
            win = match * want
            noLose = win - hasilWin
            var str = ""
            let withOutLose = Int(round(noLose))
            switch withOutLose {
            case (1...):
                str = NSString(format: "Kamu harus memainkan kurang lebih %d pertandingan tanpa kalah, Semoga beruntung!", withOutLose) as String
                outputText.text = str
                wrNow.text = ""
                matchTotal.text = ""
                wrWant.text = ""
                break
            default:
                outputText.text = "WinRate yang diinginkan tidak bisa lebih kecil dari WinRate saat ini!"
            }
        }
        
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 400)
    }
}
