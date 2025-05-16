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
                Color(red: 0/255, green: 50/255, blue: 98/255)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 12) {
                        Text("📆 Shifts")
                            .font(.largeTitle.bold())
                            .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.top, .horizontal])

                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                            TextField("Search", text: $searchText)
                                .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                                .placeholder(when: searchText.isEmpty) {
                                    Text("Search")
                                        .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255).opacity(0.6))
                                }
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(12)
                        .padding(.horizontal)

                        if shiftViewModel.shifts.isEmpty {
                            ProgressView("Loading shifts...")
                                .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                                .padding(.top, 50)
                        } else {
                            ForEach(filteredShifts) { shift in
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(shift.clientName)
                                        .font(.headline)
                                        .bold()
                                        .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))

                                    Text("🧑‍🤝‍🧑 \(shift.supportWorkerName)")
                                        .font(.subheadline)
                                        .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))

                                    Text("📅 \(formattedDate(shift.date))")
                                        .font(.footnote)
                                        .foregroundColor(.gray)

                                    Text("🕒 \(shift.startTime) - \(shift.endTime)")
                                        .font(.footnote)
                                        .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                }
                                .padding()
                                .background(Color(red: 0/255, green: 50/255, blue: 98/255))
                                .cornerRadius(14)
                                .shadow(color: Color.black.opacity(0.3), radius: 15, x: 10, y: 10)
                                .shadow(color: Color.white.opacity(0.4), radius: 8, x: -5, y: -5)
                                .padding(.horizontal)
                                .onTapGesture {
                                    selectedShift = shift
                                    showEditShiftForm = true
                                }
                            }
                        }
                    }
                    .padding(.bottom, 16)
                }

                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showNewShiftForm = true
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
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
            }
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
