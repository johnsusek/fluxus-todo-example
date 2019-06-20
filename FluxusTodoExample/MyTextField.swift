import SwiftUI
import UIKit
import Foundation

class MyTableViewController<Data, Content>: UITableViewController where Data: RandomAccessCollection, Content: View, Data.Element: Identifiable {
  let renderFunc: ForEach<Data, Content>

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
    let data = renderFunc.data
    let todo1 = data.first as! Data.Element.IdentifiedValue
    let result = renderFunc.content(todo1)

    let hc = UIHostingController(rootView: result)
    hc.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6000000238)
    hc.view.frame = CGRect(x: 0, y: 0, width: 380, height: 43)

    for subview in cell.contentView.subviews {
      subview.removeFromSuperview()
    }

    cell.contentView.addSubview(hc.view)
    return cell
  }

  init(renderFunc: ForEach<Data, Content>) {
    self.renderFunc = renderFunc
    super.init(style: UITableView.Style.plain)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
  }
}

struct BridgedUITableView<Data, Content>: UIViewControllerRepresentable where Data: RandomAccessCollection, Content: View, Data.Element: Identifiable {
  let renderFunc: ForEach<Data, Content>

  func makeUIViewController(context: UIViewControllerRepresentableContext<BridgedUITableView>) -> UITableViewController {
    let tvc = MyTableViewController<Data, Content>(renderFunc: renderFunc)
    return tvc
  }

  func updateUIViewController(_ uiViewController: UITableViewController, context: UIViewControllerRepresentableContext<BridgedUITableView>) {}

  init(_ forEach: () -> ForEach<Data, Content>) {
    renderFunc = forEach()
  }

  func makeCoordinator() -> Coordinator {
    return Coordinator(self)
  }

  class Coordinator {
    var parent: BridgedUITableView

    init(_ view: BridgedUITableView) {
      self.parent = view
    }
  }
}


//struct ProTextField: UIViewRepresentable {
//  var text: Binding<String>
//  var placeholder: String?
//  var onEditingChanged: (UITextField, Bool) -> Void
//
//  public init(_ text: Binding<String>, placeholder: String? = nil, onEditingChanged: @escaping (UITextField, Bool) -> Void = { _, _ in }) {
//    self.text = text
//    self.placeholder = placeholder
//    self.onEditingChanged = onEditingChanged
//  }
//
//  func makeUIView(context: Context) -> UITextField {
//    let ourTextField = UITextField()
//    ourTextField.placeholder = self.placeholder
//    ourTextField.delegate = context.coordinator
//
//    ourTextField.addTarget(self, action: #selector(context.coordinator.textFieldDidChange(_:)),
//                           for: UIControl.Event.editingChanged)
//
//    return ourTextField
//  }
//
//  func updateUIView(_ view: UITextField, context: Context) {
//    print("Updating the view's text from the binding passed in...!")
//    view.text = self.text.value
//  }
//
//  func makeCoordinator() -> Coordinator {
//    return Coordinator(self)
//  }
//
//  class Coordinator : NSObject, UITextFieldDelegate, UITextInputDelegate {
//    var parent: ProTextField
//
//    init(_ view: ProTextField) {
//      self.parent = view
//    }
//
////    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
////      return true
////    }
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//      self.parent.onEditingChanged(textField, true)
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//      self.parent.onEditingChanged(textField, false)
//    }
//
//    func selectionWillChange(_ textInput: UITextInput?) {
//    }
//
//    func selectionDidChange(_ textInput: UITextInput?) {
//    }
//
//    func textWillChange(_ textInput: UITextInput?) {
//    }
//
//    func textDidChange(_ textInput: UITextInput?) {
//      print("Text changed!")
//    }
//
//    @objc func textFieldDidChange(_ textField: UITextField) {
//      print("Text changed!")
//    }
//  }
//}
