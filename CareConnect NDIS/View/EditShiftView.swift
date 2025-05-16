import SwiftUI

struct EditShiftView: View {
    @Environment(\.dismiss) var dismiss
    @State var shift: Shift
    var onSave: (Shift) -> Void

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 18/255, green: 10/255, blue: 143/255) // #120A8F
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("🕒 Edit Shift")
                        .font(.largeTitle.bold())
                        .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                        .padding(.horizontal)

                    GroupBox(label: Label("Client Name", systemImage: "person")) {
                        TextField("Client Name", text: $shift.clientName)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding()
                    .background(Color(red: 18/255, green: 10/255, blue: 143/255))
                    .cornerRadius(12)
                    .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                    .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                    .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)
                    .padding(.horizontal)

                    GroupBox(label: Label("Support Worker", systemImage: "person.2")) {
                        TextField("Support Worker Name", text: $shift.supportWorkerName)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding()
                    .background(Color(red: 18/255, green: 10/255, blue: 143/255))
                    .cornerRadius(12)
                    .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                    .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                    .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)
                    .padding(.horizontal)

                    GroupBox(label: Label("Date", systemImage: "calendar")) {
                        DatePicker("", selection: $shift.date, displayedComponents: .date)
                            .labelsHidden()
                    }
                    .padding()
                    .background(Color(red: 18/255, green: 10/255, blue: 143/255))
                    .cornerRadius(12)
                    .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                    .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                    .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)
                    .padding(.horizontal)

                    HStack(spacing: 12) {
                        GroupBox(label: Text("Start Time")) {
                            DatePicker("", selection: $shift.startTime, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                        }
                        .padding()
                        .background(Color(red: 18/255, green: 10/255, blue: 143/255))
                        .cornerRadius(12)
                        .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                        .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                        .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)

                        GroupBox(label: Text("End Time")) {
                            DatePicker("", selection: $shift.endTime, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                        }
                        .padding()
                        .background(Color(red: 18/255, green: 10/255, blue: 143/255))
                        .cornerRadius(12)
                        .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                        .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                        .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)
                    }
                    .padding(.horizontal)

                    GroupBox(label: Label("Notes", systemImage: "note.text")) {
                        TextField("Notes", text: $shift.notes)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding()
                    .background(Color(red: 18/255, green: 10/255, blue: 143/255))
                    .cornerRadius(12)
                    .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                    .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                    .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)
                    .padding(.horizontal)

                    Toggle("Attended", isOn: $shift.isAttended)
                        .padding(.horizontal)
                        .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))

                    Spacer()

                    HStack(spacing: 20) {
                        Button("Cancel") {
                            dismiss()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 18/255, green: 10/255, blue: 143/255))
                        .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                        .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)

                        Button("Save") {
                            onSave(shift)
                            dismiss()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 18/255, green: 10/255, blue: 143/255))
                        .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                        .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}
