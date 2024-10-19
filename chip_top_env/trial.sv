module trial;

int signed_value = 83;            // Signed 32-bit integer
logic [15:0] twos_complement;      // 32-bit unsigned logic to store the 2's complement

initial begin
    // Cast signed to unsigned to get the 2's complement automatically
    twos_complement = $unsigned(163-255);

    $display("Signed value: %0d", signed_value);
    $display("2's complement (unsigned): %d", twos_complement); // Binary representation
    $display("2's complement (unsigned decimal): %0d", twos_complement); // Decimal representation
    $finish();
end

endmodule
