import SwiftUI

struct EditShiftView: View {
    @Environment(\.dismiss) var dismiss
    @State var shift: Shift
    var onSave: (Shift) -> Void

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.indigo.opacity(0.7), Color.blue.opacity(0.4)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 20) {
                    Spacer().frame(height: 10) // adds some breathing room below nav bar

                    GroupBox(label: Label("Client Name", systemImage: "person")) {
                        TextField("Client Name", text: $shift.clientName)
                            .textFieldStyle(.roundedBorder)
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                    GroupBox(label: Label("Support Worker", systemImage: "person.2")) {
                        TextField("Support Worker Name", text: $shift.supportWorkerName)
                            .textFieldStyle(.roundedBorder)
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                    GroupBox(label: Label("Date", systemImage: "calendar")) {
                        DatePicker("", selection: $shift.date, displayedComponents: .date)
                            .labelsHidden()
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                    HStack(spacing: 12) {
                        GroupBox(label: Text("Start Time")) {
                            DatePicker("", selection: $shift.startTime, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                        }
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)

                        GroupBox(label: Text("End Time")) {
                            DatePicker("", selection: $shift.endTime, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                        }
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)
                    }

                    GroupBox(label: Label("Notes", systemImage: "note.text")) {
                        TextField("Notes", text: $shift.notes)
                            .textFieldStyle(.roundedBorder)
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                    Toggle("Attended", isOn: $shift.isAttended)
                        .padding(.horizontal)
                        .foregroundColor(.white)

                    Spacer()

                    HStack(spacing: 20) {
                        Button("Cancel") {
                            dismiss()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.opacity(0.15))
                        .foregroundColor(.white)
                        .cornerRadius(10)

                        Button("Save") {
                            onSave(shift)
                            dismiss()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.opacity(0.15))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                .padding()
            }
            .navigationTitle("Edit Shift") // moves title to nav bar
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
