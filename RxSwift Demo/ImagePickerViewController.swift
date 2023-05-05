//
//  ImagePickerViewController.swift
//  RxSwift Demo
//
//  Created by 楊朝富 on 2023/5/4.
//

import UIKit
import RxSwift
import RxCocoa

class ImagePickerViewController: UIViewController {

    @IBOutlet weak var buttonCamera: UIButton!
    
    @IBOutlet weak var buttonGallery: UIButton!
    
    @IBOutlet weak var buttonCrop: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        buttonCamera.rx.tap
            .flatMapLatest { [weak self] _ in
                return UIImagePickerController.rx.createWithParent(self) { picker in
                    picker.sourceType = .camera
                    picker.allowsEditing = false
                }
                .flatMap { $0.rx.didFinishPickingMediaWithInfo }
                .take(1)
            }
            .map { info in
                return info[.originalImage] as? UIImage
            }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
        
        buttonGallery.rx.tap
            .flatMapLatest { [weak self] _ in
                return UIImagePickerController.rx.createWithParent(self) { picker in
                    picker.sourceType = .photoLibrary
                    picker.allowsEditing = false
                }
                .flatMap {
                    $0.rx.didFinishPickingMediaWithInfo
                }
                .take(1)
            }
            .map { info in
                return info[.originalImage] as? UIImage
            }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
        
        buttonCrop.rx.tap
            .flatMapLatest { [weak self] _ in
                return UIImagePickerController.rx.createWithParent(self) { picker in
                    picker.sourceType = .photoLibrary
                    picker.allowsEditing = true
                }
                .flatMap { $0.rx.didFinishPickingMediaWithInfo }
                .take(1)
            }
            .map { info in
                return info[.editedImage] as? UIImage
            }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
