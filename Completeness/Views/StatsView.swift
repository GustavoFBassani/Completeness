import SwiftUI
import SwiftData

struct StatsView: View {
    @State var viewModel: ChartsViewModelProtocol
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if viewModel.mostCompletedHabits.isEmpty {
                    StatsEmptyView()
                        .containerRelativeFrame(.vertical)
                } else {
                    HabitStatCard(
                        viewModel: $viewModel, habitCartType: .mostDone
                    )
                    HabitStatCard(
                        viewModel: $viewModel,
                        habitCartType: .leatDone
                    )
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.backgroundSecondary)
        .task {
            await viewModel.fetchChartBy7Days()
        }
        .navigationTitle("Resumo")
    }
}

#Preview {
    //StatsView()
}
