//
//  PopupViewController.swift
//  ToDo
//
//  Created by a.gretsov on 03.04.2020.
//  Copyright © 2020 a.gretsov. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {
    
    private let popupView: UIView = {
        let popup = UIView()
        popup.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        popup.layer.cornerRadius = 12
        return popup
    }()
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "New task"
        title.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        title.font = UIFont(name: "Artbrush", size: 24)
        title.textAlignment = .center
        return title
    }()
    
    private let closeButton: UIButton = {
        let close = UIButton()
        close.layer.cornerRadius = 12
        close.setImage(#imageLiteral(resourceName: "closeButton"), for: .normal)
        close.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return close
    }()
    
    private let doneButton: UIButton = {
        let done = UIButton()
        done.setTitle("Done", for: .normal)
        done.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        done.layer.cornerRadius = 12
        done.backgroundColor = UIColor(named: "additionColor")
        done.addTarget(self, action: #selector(taskSaver), for: .touchUpInside)
        return done
    }()
    
    private let taskTextField: UITextField = {
        let task = UITextField()
        task.backgroundColor = .white
        task.layer.borderWidth = 1
        task.layer.borderColor = UIColor(named: "additionColor")?.cgColor
        task.layer.cornerRadius = 5
        task.attributedPlaceholder = NSAttributedString(string: "I want to...", attributes:[NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)])
        task.textAlignment = .center
        task.becomeFirstResponder()
        task.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return task
    }()
    
    private let pencilImage: UIImageView = {
        let pencil = UIImageView()
        pencil.image = #imageLiteral(resourceName: "pencil")
        pencil.backgroundColor = UIColor(named: "additionColor")
        pencil.layer.cornerRadius = 55
        pencil.layer.borderWidth = 3
        pencil.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        return pencil
    }()
    
    private let toolbar: UIToolbar = {
        let tool = UIToolbar()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(endEditing))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        tool.sizeToFit()
        tool.setItems([flexSpace, doneButton], animated: true)
        return tool
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.locale = Locale(identifier: Locale.preferredLanguages.first!)
        picker.addTarget(self, action: #selector(datePickerChanged(sender:)), for:  .valueChanged)
        return picker
    }()
    
    private let taskDateTextField: UITextField = {
        let date = UITextField()
        date.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        date.layer.cornerRadius = 5
        date.layer.borderWidth = 1
        date.layer.borderColor = UIColor(named: "additionColor")?.cgColor
        date.textAlignment = .center
        date.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        date.attributedPlaceholder = NSAttributedString(string: "Date and time", attributes:[NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)])
        return date
    }()
    
    private let blurredBackground: UIVisualEffectView = {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        return blur
    }()
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskDateTextField.inputView = datePicker
        taskDateTextField.inputAccessoryView = toolbar
        addSubviews()
        addLayouts()
    }
    
    // MARK: - Layout methods
        
    private func addSubviews() {
        view.addSubview(blurredBackground)
        view.addSubview(popupView)
        view.addSubview(taskDateTextField)
        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.addSubview(taskTextField)
        view.addSubview(doneButton)
        view.addSubview(pencilImage)
    }
    
    private func addLayouts() {
        blurLayout()
        popupViewLayout()
        titleLabelLayout()
        doneButtonLayout()
        closeButtonLayout()
        taskTextFieldLayout()
        taskDateTextFieldLayout()
        pencilImageLayout()
    }
    
    private func blurLayout() {
        blurredBackground.frame = view.bounds
        blurredBackground.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func taskDateTextFieldLayout() {
        taskDateTextField.translatesAutoresizingMaskIntoConstraints = false
        taskDateTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        taskDateTextField.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 20).isActive = true
        taskDateTextField.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -20).isActive = true
        taskDateTextField.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 15).isActive = true
    }
    
    private func popupViewLayout() {
        popupView.translatesAutoresizingMaskIntoConstraints = false
        popupView.widthAnchor.constraint(equalToConstant: 360).isActive = true
        popupView.topAnchor.constraint(equalTo: view.topAnchor, constant: 190).isActive = true
        popupView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popupView.bottomAnchor.constraint(equalTo: doneButton.bottomAnchor, constant: 20).isActive = true
    }
    
    private func titleLabelLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: popupView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: pencilImage.bottomAnchor, constant: 35).isActive = true
    }
    
    private func closeButtonLayout() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.centerYAnchor.constraint(equalTo: popupView.topAnchor, constant: 30).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -15).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
    }
    
    private func taskTextFieldLayout() {
        taskTextField.translatesAutoresizingMaskIntoConstraints = false
        taskTextField.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 20).isActive = true
        taskTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        taskTextField.centerXAnchor.constraint(equalTo: popupView.centerXAnchor).isActive = true
        taskTextField.centerYAnchor.constraint(equalTo: popupView.centerYAnchor).isActive = true
    }
    
    private func doneButtonLayout() {
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        doneButton.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 20).isActive = true
        doneButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -20).isActive = true
        doneButton.topAnchor.constraint(equalTo: taskDateTextField.bottomAnchor, constant: 20).isActive = true
    }
    
    private func pencilImageLayout() {
        pencilImage.translatesAutoresizingMaskIntoConstraints = false
        pencilImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pencilImage.centerYAnchor.constraint(equalTo: popupView.topAnchor).isActive = true
        pencilImage.widthAnchor.constraint(equalToConstant: 110).isActive = true
        pencilImage.heightAnchor.constraint(equalToConstant: 110).isActive = true
    }
    
    // MARK: - Selector methods
    
    @objc private func datePickerChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd.yyyy HH:mm"
        taskDateTextField.text = formatter.string(from: datePicker.date)
        
    }
    
    @objc private func taskSaver() {
        guard taskTextField.text?.isEmpty == false else {
            taskTextField.attributedPlaceholder = NSAttributedString(string: "I want to...", attributes:[NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)])
            return
        }
        
        guard taskDateTextField.text?.count != 0 else {
            taskDateTextField.attributedPlaceholder = NSAttributedString(string: "Date and time", attributes:[NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)])
            return
        }
        
        DispatchQueue.global(qos: .default).sync {
            saveTask(title: "\(self.taskTextField.text!)", date: "\(self.taskDateTextField.text!)")
        }
        
        cancelButtonPressed(self)
    }
    
    @objc private func endEditing() {
        view.endEditing(true)
    }
    
    @objc private func cancelButtonPressed(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        dismiss(animated: true, completion: nil)
    }
}
