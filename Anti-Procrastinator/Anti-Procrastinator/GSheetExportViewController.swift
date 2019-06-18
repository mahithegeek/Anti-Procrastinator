//
//  GSheetExportViewController.swift
//  Anti-Procrastinator
//
//  Created by nimma01 on 30/04/19.
//  Copyright © 2019 nimma01. All rights reserved.
//

import UIKit
import GoogleAPIClientForREST
import GoogleSignIn

class GSheetExportViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {

    private let scopes = [kGTLRAuthScopeSheetsSpreadsheets]
    
    private let service = GTLRSheetsService()
    let signInButton = GIDSignInButton()
    let output = UITextView()
    var spreadSheetID : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().scopes = scopes
        GIDSignIn.sharedInstance().signIn()
        
        // Add the sign-in button.
        view.addSubview(signInButton)
        
        // Add a UITextView to display output.
        output.frame = view.bounds
        output.isEditable = false
        output.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        output.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        output.isHidden = true
        view.addSubview(output);
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            showAlert(title: "Authentication Error", message: error.localizedDescription)
            self.service.authorizer = nil
        } else {
            self.signInButton.isHidden = true
            //self.output.isHidden = false
            self.service.authorizer = user.authentication.fetcherAuthorizer()
            //listMajors()
            startExportingData()
        }
    }
    
//    func listMajors() {
//        output.text = "Getting sheet data..."
//        let spreadsheetId = "1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms"
//        let range = "Class Data!A2:E"
//        let query = GTLRSheetsQuery_SpreadsheetsValuesGet
//            .query(withSpreadsheetId: spreadsheetId, range:range)
//        service.executeQuery(query,
//                             delegate: self,
//                             didFinish:#selector(displayResultWithTicket(ticket:finishedWithObject: error:))
//        )
//    }
    
    
    func startExportingData() {
        
        guard let spreadSheetId = self.getSpreadSheetID()
            else{
                createSheet();
                return;
        }
        addDataToSheet(spreadSheetId: spreadSheetId);
        
    }
    
    func createSheet() {
        let spreadSheet = GTLRSheets_Spreadsheet()
        let spreadSheetProps = GTLRSheets_SpreadsheetProperties()
        spreadSheetProps.title = "Pomodoro Hours"
        spreadSheet.properties = spreadSheetProps
        let query = GTLRSheetsQuery_SpreadsheetsCreate.query(withObject: spreadSheet)
        service.executeQuery(query, delegate: self, didFinish: #selector(SpreadSheetCreatedCallback))
    }
    
    func handleCompletion(ticket : GTLRServiceTicket, object : Any,error:NSError){
        print("test")
    }
    
    @objc func SpreadSheetCreatedCallback(ticket:GTLRServiceTicket,object: Any,error:NSError?)->Void {
        guard let spreadSheetID = (object as AnyObject).spreadsheetId
            else{
                return
        }
        self.saveSpreadSheetID(spreadSheetID:spreadSheetID!)
        //showAlert(title: "Successfully created Spread Sheet", message: "")
        addDataToSheet(spreadSheetId:spreadSheetID!);
    }
    
    private func addDataToSheet(spreadSheetId:String) {
        
        let values = GTLRSheets_ValueRange()
        values.majorDimension = "ROWS";
        values.values = [["Mahendra","test"], ["test","Mike testing"]]
        
        let query = GTLRSheetsQuery_SpreadsheetsValuesAppend.query(withObject: values, spreadsheetId: spreadSheetId, range: "Sheet1")
        query.valueInputOption = "USER_ENTERED"
        service.executeQuery(query, delegate: self, didFinish: #selector(SpreadSheetAppendedCallback))
    }
    
    @objc func SpreadSheetAppendedCallback(ticket:GTLRServiceTicket,object: Any,error:NSError?)->Void {
        //self.spreadSheetID = (object as AnyObject).spreadsheetId
        if (error != nil){
            showAlert(title: "Error", message: error?.localizedDescription ?? "unknown error")
            
        }
        else{
            showAlert(title: "Successfully Added to Spread Sheet", message: "")
        }
        
        //addDataToSheet();
    }
    
    // Process the response and display output
    @objc func displayResultWithTicket(ticket: GTLRServiceTicket,
                                       finishedWithObject result : GTLRSheets_ValueRange,
                                       error : NSError?) {
        
        if let error = error {
            showAlert(title: "Error", message: error.localizedDescription)
            return
        }
        
        var majorsString = ""
        let rows = result.values!
        
        if rows.isEmpty {
            output.text = "No data found."
            return
        }
        
        majorsString += "Name, Major:\n"
        for row in rows {
            let name = row[0]
            let major = row[4]
            
            majorsString += "\(name), \(major)\n"
        }
        
        output.text = majorsString
    }
    
    
    
    // Helper for showing an alert
    func showAlert(title : String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertAction.Style.default,
            handler: nil
        )
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    
    func saveSpreadSheetID(spreadSheetID:String){
        UserDefaults.standard.set(spreadSheetID,forKey: "spreadSheetID")
    }
    
    func getSpreadSheetID()->String?{
        return UserDefaults.standard.string(forKey: "spreadSheetID")
    }

}
