// ====================================================================
// EIXO NEURAL SEMICONDUCTORS - PROJETO CATRACA
// Componente: MÓDULO PRINCIPAL (Top Module - Integração do Chip NPU-1)
// Idealizador e Proprietário Original: Paulo Roberto Macedo de Pinho
// Licença: Apache 2.0 (Manutenção de Crédito Obrigatória)
// TRL Nível: 3 (Arquitetura de Processador Completa e Interconectada)
// ====================================================================

module eixo_neural_top (
    input clk,                    // Clock do sistema (Sincronismo global)
    input rst,                    // Reset global do hardware
    input wr_en,                  // Habilita gravação na memória interna
    input [1:0] addr,             // Endereço do neurônio selecionado
    input [1:0] operando_b,       // Peso do segundo operando para a ULA
    input [1:0] seletor_op,       // Seleção da operação de IA (Soma, Multiplica, ReLU)
    output [3:0] resultado_final  // Saída final processada pelo chip
);

    // Fios microscópicos internos para interconectar os blocos lógicos
    wire [3:0] w_dado_memoria_para_ula;
    wire [3:0] w_resultado_ula_para_memoria;

    // Instanciação do Banco de Registradores (Memória Local do Chip)
    banco_registradores memoria_interna (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .addr(addr),
        .dado_entrada(w_resultado_ula_para_memoria),
        .dado_saida(w_dado_memoria_para_ula)
    );

    // Instanciação da ULA (O Cérebro Computacional de Inteligência Artificial)
    ula_eixo_neural processador_ula (
        .clk(clk),
        .rst(rst),
        .operando_a(w_dado_memoria_para_ula[1:0]), // Pega o dado da memória
        .operando_b(operando_b),
        .seletor_op(seletor_op),
        .resultado(w_resultado_ula_para_memoria)   // Devolve o cálculo para a memória
    );

    // A saída do chip exibe o resultado da última operação processada
    assign resultado_final = w_resultado_ula_para_memoria;

endmodule
