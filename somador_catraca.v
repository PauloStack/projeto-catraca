// ====================================================================
// PROJETO CATRACA - HARDWARE LIVRE E POPULAR DE IA
// Componente: Unidade Somadora Ternária (Baixíssimo Custo para Edge AI)
// Idealizador e Proprietário Original: Paulo Roberto Macedo de Pinho
// Licença: Apache 2.0 (Manutenção de Crédito Obrigatória)
// ====================================================================

module somador_catraca (
    input clk,             // Sinal de clock (o coração do chip)
    input rst,             // Botão de reiniciar o circuito
    input [1:0] dado_ia,   // Entrada de dados da IA (-1, 0 ou +1)
    output reg [7:0] acumulador // Resultado guardado na memória
);

    // O chip decide o que fazer a cada batida do coração (clk)
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            acumulador <= 8'b00000000; // Zera a conta se reiniciar
        end else begin
            // O chip faz contas ultra-simples para economizar energia e silício
            if (dado_ia == 2'b01) 
                acumulador <= acumulador + 1; // Soma se o dado for positivo (+1)
            else if (dado_ia == 2'b10) 
                acumulador <= acumulador - 1; // Subtrai se o dado for negativo (-1)
            // Se o dado for 2'b00 (Zero), o circuito não gasta energia fazendo nada
        end
    end

endmodule
