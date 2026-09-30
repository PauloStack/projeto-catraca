// ====================================================================
// EIXO NEURAL SEMICONDUCTORS - PROJETO CATRACA
// Componente: Unidade Lógica e Aritmética (ULA) Avançada de IA
// Idealizador e Proprietário Original: Paulo Roberto Macedo de Pinho
// Licença: Apache 2.0 (Manutenção de Crédito Obrigatória)
// TRL Nível: 3 (Prova de Conceito de Hardware Simulável)
// ====================================================================

module ula_eixo_neural (
    input clk,                 // Coração do chip (Sinal de clock)
    input rst,                 // Reinício do sistema
    input [1:0] operando_a,    // Dado de IA A (-1, 0 ou +1)
    input [1:0] operando_b,    // Dado de IA B (-1, 0 ou +1)
    input [1:0] seletor_op,    // Escolha da conta (00: Soma, 01: Multiplica, 10: Ativação)
    output reg [3:0] resultado // Resultado da operação lógica de IA
);

    // Executa a computação a cada pulso de clock
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            resultado <= 4'b0000;
        end else begin
            case(seletor_op)
                2'b00: begin // OPERAÇÃO SOMA: Junta os pesos dos neurônios
                    resultado <= operando_a + operando_b;
                end
                2'b01: begin // OPERAÇÃO MULTIPLICAÇÃO: Executa o produto de matrizes de IA
                    resultado <= operando_a * operando_b;
                end
                2'b10: begin // FUNÇÃO DE ATIVAÇÃO POPULAR (ReLU Simplificada)
                    if (operando_a[1] == 1'b1) // Se o número for negativo
                        resultado <= 4'b0000;  // Zera o neurônio (Gasta zero de energia)
                    else
                        resultado <= operando_a; // Mantém o peso positivo
                end
                default: resultado <= 4'b0000;
            endcase
        end
    end

endmodule
