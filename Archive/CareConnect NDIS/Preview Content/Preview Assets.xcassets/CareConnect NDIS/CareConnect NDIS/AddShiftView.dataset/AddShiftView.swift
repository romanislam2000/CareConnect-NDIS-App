//
//  AddShiftView.swift
//  CareConnect NDIS
//
//  Created by Md Roman Islam on 14/5/2025.
//

import SwiftUI

struct AddShiftView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ShiftViewModel

    @State private var clientName = ""
    @State private var workerName = ""
    @State private var date = Date()
    @State private var startTime = ""
    @State private var endTime = ""
    @State private var notes = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Shift Assignment")) {
                    TextField("Client Name", text: $clientName)
                    TextField("Support Worker Name", text: $workerName)
                }

                Section(header: Text("Date & Time")) {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    TextField("Start Time (e.g. 10:00 AM)", text: $startTime)
                    TextField("End Time (e.g. 12:00 PM)", text: $endTime)
                }

                Section(header: Text("Notes")) {
                    TextField("Additional notes (optional)", text: $notes)
                }
            }
            .navigationTitle("New Shift")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let shift = Shift(
                            clientName: clientName,
                            supportWorkerName: workerName,
                            date: date,
                            startTime: startTime,
                            endTime: endTime,
                            notes: notes,
                            isAttended: false
                        )
                        viewModel.addShift(shift)
                        dismiss()
                    }
                    .disabled(clientName.isEmpty || workerName.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
    }
}
