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
                    
                    OverallChart(viewModel: $viewModel)
                    
                    HabitStatCard(
                        viewModel: $viewModel,
                        habitCartType: .mostDone
                    )
                    
                    HabitStatCard(
                        viewModel: $viewModel,
                        habitCartType: .leastDone
                    )
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.backgroundPrimary)
        .task {
            await viewModel.fetchChartBy7Days()
            print(viewModel.overallCompletionRate)
        }
        .navigationTitle("Resumo")
    }
}

#Preview {
}
