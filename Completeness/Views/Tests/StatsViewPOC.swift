import SwiftUI
import SwiftData

struct StatsViewPOC: View {
    @Bindable var viewModel: ChartsViewModel

    var body: some View {
        NavigationStack {
            // A View reage à propriedade 'isLoading' da ViewModel.
            // Se estiver carregando, mostra uma animação.
            if viewModel.isLoading {
                ProgressView("Buscando dados...")
                    .navigationTitle("Painel de Teste")
            } else {
                // Se não estiver carregando, mostra a lista com os dados.
                List {
                    // Seção para a taxa de conclusão geral.
                    Section("Visão Geral (Últimos 7 dias)") {
                        HStack {
                            Text("Taxa de conclusão")
                            Spacer()
                            // Formata o Double como uma porcentagem de forma limpa.
                            Text(viewModel.overallCompletionRate, format: .percent.precision(.fractionLength(1)))
                                .fontWeight(.semibold)
                                .foregroundStyle(.indigo)
                        }
                    }

                    // Seção para os hábitos mais completados.
                    Section("🏆 Hábitos Mais Concluídos") {
                        // Verifica se a lista está vazia para mostrar uma mensagem amigável.
                        if viewModel.mostCompletedHabits.isEmpty {
                            Text("Nenhum hábito para exibir.")
                        } else {
                            ForEach(viewModel.mostCompletedHabits) { habit in
                                Text(habit.habitName)
                            }
                        }
                    }

                    // Seção para os hábitos menos completados.
                    Section("📉 Hábitos Menos Concluídos") {
                        if viewModel.leastCompletedHabits.isEmpty {
                            Text("Nenhum hábito para exibir.")
                        } else {
                            ForEach(viewModel.leastCompletedHabits) { habit in
                                Text(habit.habitName)
                            }
                        }
                    }
                }
                .navigationTitle("Painel de Teste")
            }
        }
        // O modificador '.task' é a forma moderna de chamar uma função 'async'
        // de forma segura assim que a View aparece na tela.
        .task {
            await viewModel.fetchChartBy7Days()
        }
    }
}

// --- PREVIEW ---
// Para o preview funcionar, precisamos de um ambiente de dados de mentira (em memória).
#Preview {
}
