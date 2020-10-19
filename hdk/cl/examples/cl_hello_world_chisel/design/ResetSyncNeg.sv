module ResetSyncNeg(
    input logic clock,
    inout logic reset_n,
    output logic reset_sync_n
);
    logic pre_reset_sync_n;

    always_ff @(negedge reset_n or posedge clock)
        if (!reset_n)
            begin
                pre_reset_sync_n  <= 0;
                reset_sync_n <= 0;
            end
        else
            begin
                pre_reset_sync_n  <= 1;
                reset_sync_n <= pre_reset_sync_n;
            end
endmodule