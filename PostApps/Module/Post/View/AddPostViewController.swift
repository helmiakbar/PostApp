//
//  AddPostViewController.swift
//  PostApps
//
//  Created by tamu on 24/03/23.
//

import UIKit

protocol AddPostViewControllerDelegate {
    func successAddPost()
}

class AddPostViewController: UIViewController {
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.delegate = self
        }
    }
    @IBOutlet weak var imageView: UIImageView!
    
    var user: User?
    let viewModel = AddPostViewModel()
    var delegate: AddPostViewControllerDelegate? = nil
    
    init(user: User?) {
        super.init(nibName: String(describing: AddPostViewController.self), bundle: nil)
        self.user = user
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = "What's happening?"
        textView.textColor = .lightGray
        textView.addDoneButtonOnKeyboard()

    }
    
    @IBAction func postBtn(_ sender: Any) {
        if textView.textColor == UIColor.lightGray {
            showAlert()
        } else {
            viewModel.publishPost(post: textView.text ?? "", image: imageView.image, user: user, onCompletion: {
                self.delegate?.successAddPost()
            })
        }
    }
    
    @IBAction func addImageBtn(_ sender: Any) {
        showActionSheetForSelectedImage()
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "", message: "Sorry please type what's happening", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {
            (alert: UIAlertAction!) in
            self.dismiss(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showActionSheetForSelectedImage() {
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let firstAction: UIAlertAction =  UIAlertAction(title: "Camera", style: .default) { action -> Void in
            self.openCamera()
        }
        
        let secondAction: UIAlertAction =  UIAlertAction(title: "Photos", style: .default) { action -> Void in
            self.openGallary()
        }
                
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
                
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(secondAction)
        actionSheetController.addAction(cancelAction)
                
        if let popoverController = actionSheetController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
                
        present(actionSheetController, animated: true, completion: nil)
    }
    
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
            
    private func openGallary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension AddPostViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        self.dismiss(animated:true, completion: {
            self.imageView.image = image
//            self.viewModel.readImage(image: image, onCompletion: self.onHandleTextRecognition())
        })
    }
}

extension AddPostViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "What's happening?"
            textView.textColor = UIColor.lightGray
        }
    }
}
