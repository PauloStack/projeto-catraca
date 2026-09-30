// ====================================================================
// EIXO NEURAL SEMICONDUCTORS - PROJETO CATRACA
// Componente: Banco de Registradores de Baixíssimo Consumo (Memória Interna)
// Idealizador e Proprietário Original: Paulo Roberto Macedo de Pinho
// Licença: Apache 2.0 (Manutenção de Crédito Obrigatória)
// TRL Nível: 3 (Prova de Conceito de Hardware Simulável)
// ====================================================================

module banco_registradores (
    input clk,                  // Sinal de clock (sincronismo)
    input rst,                  // Reinício do sistema
    input wr_en,                // Sinal para permitir a gravação de dados
    input [1:0] addr,           // Endereço de qual neurônio acessar (0 a 3)
    input [3:0] dado_entrada,   // O peso do neurônio vindo da ULA
    output reg [3:0] dado_saida // O dado lido para enviar de volta à ULA
);

    // Criamos 4 posições de memória interna ultra-rápidas para a IA
    reg [3:0] memoria [0:3];

    // Operação de leitura e escrita síncrona
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            memoria[0] <= 4'b0000;
            memoria[1] <= 4'b0000;
            memoria[2] <= 4'b0000;
            memoria[3] <= 4'b0000;
            dado_saida <= 4'b0000;
        end else begin
            if (wr_en) begin
                memoria[addr] <= dado_entrada; // Grava o dado na posição escolhida
            end
            dado_saida <= memoria[addr]; // Lê o dado da posição escolhida
        end
    end

endmodule
