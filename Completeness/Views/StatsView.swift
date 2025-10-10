import SwiftUI
import SwiftData

struct StatsView: View {
    @State var viewModel: ChartsViewModelProtocol
    
    var body: some View {
        VStack(spacing: 16) {
            if viewModel.mostCompletedHabits.isEmpty {
                StatsEmptyView()
                    .containerRelativeFrame(.vertical)
            } else {
                OverallChart(viewModel: $viewModel)
                
                if let mostCompleted = viewModel.mostCompletedHabits.first,
                   let leastCompleted = viewModel.leastCompletedHabits.first {
                    HabitStatCard(
                        viewModel: $viewModel,
                        habitCartType: .mostDone
                    )
                    
                    if mostCompleted.id != leastCompleted.id {
                        HabitStatCard(
                            viewModel: $viewModel,
                            habitCartType: .leastDone
                        )
                    }
                }
                
                Spacer()
            }
        }
        .navigationTitle("Resumo")
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .task {
            await viewModel.fetchChartBy7Days()
        }
    }
}

#Preview {
}
