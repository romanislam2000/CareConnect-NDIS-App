import SwiftUI

struct ShiftsView: View {
    @StateObject private var shiftViewModel = ShiftViewModel()
    @StateObject private var clientViewModel = ClientViewModel()

    @State private var showNewShiftForm = false
    @State private var showEditShiftForm = false
    @State private var selectedShift: Shift?
    @State private var searchText = ""

    var filteredShifts: [Shift] {
        if searchText.isEmpty {
            return shiftViewModel.shifts
        } else {
            return shiftViewModel.shifts.filter {
                $0.clientName.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.indigo.opacity(0.7), Color.blue.opacity(0.4)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                VStack {
                    if shiftViewModel.shifts.isEmpty {
                        Spacer()
                        ProgressView("Loading shifts...")
                            .foregroundColor(.white)
                        Spacer()
                    } else {
                        List {
                            ForEach(filteredShifts) { shift in
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(shift.clientName)
                                        .font(.headline)
                                        .foregroundColor(.primary)

                                    Text("🧑‍🤝‍🧑 \(shift.supportWorkerName)")
                                        .font(.subheadline)

                                    Text("📅 \(formattedDate(shift.date))")
                                        .font(.footnote)
                                        .foregroundColor(.gray)

                                    Text("🕒 \(shift.startTime) - \(shift.endTime)")
                                        .font(.footnote)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                                .onTapGesture {
                                    selectedShift = shift
                                    showEditShiftForm = true
                                }
                            }
                        }
                        .listStyle(InsetGroupedListStyle())
                        .searchable(text: $searchText)
                    }
                }
                .navigationTitle("📆 Shifts")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showNewShiftForm = true
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.white)
                        }
                    }
                }
                .sheet(isPresented: $showNewShiftForm) {
                    AddShiftView(
                        clientViewModel: clientViewModel,
                        onSave: { newShift in
                            shiftViewModel.addShift(newShift)
                            shiftViewModel.fetchShifts()
                        }
                    )
                }
                .sheet(isPresented: $showEditShiftForm) {
                    if let shift = selectedShift {
                        EditShiftView(shift: shift) { updated in
                            shiftViewModel.updateShift(updated)
                            shiftViewModel.fetchShifts()
                        }
                    }
                }
                .onAppear {
                    shiftViewModel.fetchShifts()
                }
                .padding()
            }
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
