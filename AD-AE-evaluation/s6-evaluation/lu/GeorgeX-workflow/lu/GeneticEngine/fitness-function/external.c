#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Total index of lu is 1161
#define TOTAL_INDEX 1161
// Dump results every 10000 dynamic cycle in lu
#define WRITE_CYCLE 10000

// Global variables.
int adj_matrix[TOTAL_INDEX][TOTAL_INDEX] = {};
long last_llfi_index = 0;
int cur_cycle = 0;

// Generate an adjacent matrix from the contro flow of a running program.
void writeLLFIIndex(long llfi_index){
    // Assign value to adj_matrix.
    if(last_llfi_index != 0){
        adj_matrix[last_llfi_index-1][llfi_index-1] += 1;
        cur_cycle += 1;
    }
    last_llfi_index = llfi_index;

    // Dump results only when cur_cycle >= WRITE_CYCLE
    if(cur_cycle >= WRITE_CYCLE){
        // Delete the last file.
        system("rm -rf ./controlFlow.txt");
        // Write new file.
        FILE *fp;
        char *filename = "./controlFlow.txt";
        fp = fopen(filename, "a");
        for(int i=0; i<TOTAL_INDEX; i++){
            for(int j=0; j<TOTAL_INDEX; j++){
                if(adj_matrix[i][j] > 0){
                    fprintf(fp, "%d %d %d\n", i+1, j+1, adj_matrix[i][j]);
                }        
            }
        }
        fclose(fp);
        // Reassign 0 to counter.
        cur_cycle = 0;
    }
}
