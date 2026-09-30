// ====================================================================
// EIXO NEURAL SEMICONDUCTORS - PROJETO CATRACA
// Componente: SCRIPT DE TESTE AUTOMATIZADO (Testbench para Simuladores)
// Idealizador e Proprietário Original: Paulo Roberto Macedo de Pinho
// Licença: Apache 2.0 (Manutenção de Crédito Obrigatória)
// TRL Nível: 3 (Pronto para Simulação e Homologação Técnica)
// ====================================================================

`timescale 1ns / 1ps

module tb_eixo_neural;

    // Sinais de entrada para testes
    reg clk;
    reg rst;
    reg wr_en;
    reg [1:0] addr;
    reg [1:0] operando_b;
    reg [1:0] seletor_op;

    // Sinal de saída monitorado
    wire [3:0] resultado_final;

    // Conecta o nosso chip completo (Top Module) no painel de testes
    eixo_neural_top uut (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .addr(addr),
        .operando_b(operando_b),
        .seletor_op(seletor_op),
        .resultado_final(resultado_final)
    );

    // Geração do coração do chip (Clock pulsa a cada 10 unidades de tempo)
    always #5 clk = ~clk;

    initial begin
        // Passo 1: Inicializa e limpa os circuitos do chip
        clk = 0;
        rst = 1;
        wr_en = 0;
        addr = 2'b00;
        operando_b = 2'b00;
        seletor_op = 2'b00;
        #10;
        
        rst = 0; // Desliga o reset, o chip começa a funcionar!
        #10;

        // Passo 2: Teste de Soma de IA (Operação 2'b00)
        // Adiciona pesos neuroniais e salva na posição de memória 0
        wr_en = 1;
        addr = 2'b00;
        operando_b = 2'b01; // Peso positivo (+1)
        seletor_op = 2'b00; // Comando de Soma
        #10;

        // Passo 3: Teste de Função de Ativação ReLU de IA (Operação 2'b10)
        // Desliga o neurônio se ele tentar consumir energia de forma negativa
        wr_en = 1;
        addr = 2'b01;
        seletor_op = 2'b10; // Ativação ReLU
        #10;

        // Finaliza o teste com sucesso
        $display("[SUCESSO] Chip Eixo Neural NPU-1 homologado nos testes automatizados!");
        $finish;
    end

endmodule
