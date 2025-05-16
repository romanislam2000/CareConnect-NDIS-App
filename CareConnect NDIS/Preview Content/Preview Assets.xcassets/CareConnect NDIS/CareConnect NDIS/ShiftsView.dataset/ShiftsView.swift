//
//  ShiftsView.swift
//  CareConnect NDIS
//
//  Created by Md Roman Islam on 14/5/2025.
//

import SwiftUI

struct ShiftsView: View {
    @StateObject private var viewModel = ShiftViewModel()
    @State private var showAddShift = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.shifts) { shift in
                    VStack(alignment: .leading, spacing: 4) {
                        Text("👤 \(shift.clientName) with \(shift.supportWorkerName)")
                            .font(.headline)
                        Text("🗓️ \(formattedDate(shift.date)) | \(shift.startTime) - \(shift.endTime)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        if shift.notes != "" {
                            Text("📝 \(shift.notes)")
                                .font(.footnote)
                        }
                        if shift.isAttended {
                            Text("✅ Attended")
                                .font(.caption)
                                .foregroundColor(.green)
                        } else {
                            Button("Mark as Attended") {
                                viewModel.markAttendance(for: shift)
                            }
                            .font(.caption)
                            .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .background(Color(.systemGroupedBackground))
                    .cornerRadius(10)
                    .shadow(radius: 1)
                }
            }
            .navigationTitle("Shifts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddShift = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.accentColor)
                    }
                }
            }
            .sheet(isPresented: $showAddShift) {
                AddShiftView(viewModel: viewModel)
            }
            .onAppear {
                viewModel.fetchShifts()
            }
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
