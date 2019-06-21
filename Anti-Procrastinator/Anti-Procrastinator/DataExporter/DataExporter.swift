//
//  DataExporter.swift
//  Anti-Procrastinator
//
//  Created by nimma01 on 03/06/19.
//  Copyright © 2019 nimma01. All rights reserved.
//

import Foundation
import GoogleAPIClientForREST
import GoogleSignIn

class DataExporter : NSObject,DataExporterProtocol,GIDSignInDelegate {
    
    private let scopes = [kGTLRAuthScopeSheetsSpreadsheets]
    
    private let service = GTLRSheetsService()
    var spreadSheetID : String?
    
    
    func exportData(data: [Any], completion: (Bool, NSError?) -> Void) {
        self.setUpGoogleObject()
        self.startExportingData()
    }
    
    private func setUpGoogleObject(){
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().scopes = scopes
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            showAlert(title: "Authentication Error", message: error.localizedDescription)
            self.service.authorizer = nil
        } else {
            //self.output.isHidden = false
            self.service.authorizer = user.authentication.fetcherAuthorizer()
            //listMajors()
            startExportingData()
        }
    }
    
    
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
        //present(alert, animated: true, completion: nil)
    }
    
    
    func saveSpreadSheetID(spreadSheetID:String){
        UserDefaults.standard.set(spreadSheetID,forKey: "spreadSheetID")
    }
    
    func getSpreadSheetID()->String?{
        return UserDefaults.standard.string(forKey: "spreadSheetID")
    }
    
    
}
