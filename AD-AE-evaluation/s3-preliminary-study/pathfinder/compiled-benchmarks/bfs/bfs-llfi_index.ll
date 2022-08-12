; ModuleID = '/home/yafan/gitlab/optimizing-selective-protection-yafan/yafan-benchmarks/bfs.ll'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }
%struct.Node = type { i32, i32 }

@fp = global %struct._IO_FILE* null, align 8
@stderr = external global %struct._IO_FILE*
@.str = private unnamed_addr constant [24 x i8] c"Usage: %s <input_file>\0A\00", align 1
@.str1 = private unnamed_addr constant [14 x i8] c"Reading File\0A\00", align 1
@.str2 = private unnamed_addr constant [2 x i8] c"r\00", align 1
@.str3 = private unnamed_addr constant [26 x i8] c"Error Reading graph file\0A\00", align 1
@.str4 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str5 = private unnamed_addr constant [6 x i8] c"%d %d\00", align 1
@.str6 = private unnamed_addr constant [27 x i8] c"Start traversing the tree\0A\00", align 1
@.str7 = private unnamed_addr constant [11 x i8] c"output.txt\00", align 1
@.str8 = private unnamed_addr constant [2 x i8] c"w\00", align 1
@.str9 = private unnamed_addr constant [13 x i8] c"%d) cost:%d\0A\00", align 1

; Function Attrs: uwtable
define void @_Z5UsageiPPc(i32 %argc, i8** %argv) #0 {
  %1 = alloca i32, align 4, !llfi_index !1
  %2 = alloca i8**, align 8, !llfi_index !2
  store i32 %argc, i32* %1, align 4, !llfi_index !3
  store i8** %argv, i8*** %2, align 8, !llfi_index !4
  %3 = load %struct._IO_FILE** @stderr, align 8, !llfi_index !5
  %4 = load i8*** %2, align 8, !llfi_index !6
  %5 = getelementptr inbounds i8** %4, i64 0, !llfi_index !7
  %6 = load i8** %5, align 8, !llfi_index !8
  %7 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %3, i8* getelementptr inbounds ([24 x i8]* @.str, i32 0, i32 0), i8* %6), !llfi_index !9
  ret void, !llfi_index !10
}

declare i32 @fprintf(%struct._IO_FILE*, i8*, ...) #1

; Function Attrs: uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  %1 = alloca i32, align 4, !llfi_index !11
  %2 = alloca i8**, align 8, !llfi_index !12
  store i32 %argc, i32* %1, align 4, !llfi_index !13
  store i8** %argv, i8*** %2, align 8, !llfi_index !14
  %3 = load i32* %1, align 4, !llfi_index !15
  %4 = load i8*** %2, align 8, !llfi_index !16
  call void @_Z8BFSGraphiPPc(i32 %3, i8** %4), !llfi_index !17
  ret i32 0, !llfi_index !18
}

; Function Attrs: uwtable
define void @_Z8BFSGraphiPPc(i32 %argc, i8** %argv) #0 {
  %1 = alloca i32, align 4, !llfi_index !19
  %2 = alloca i8**, align 8, !llfi_index !20
  %no_of_nodes = alloca i32, align 4, !llfi_index !21
  %edge_list_size = alloca i32, align 4, !llfi_index !22
  %input_f = alloca i8*, align 8, !llfi_index !23
  %source = alloca i32, align 4, !llfi_index !24
  %h_graph_nodes = alloca %struct.Node*, align 8, !llfi_index !25
  %h_graph_mask = alloca i8*, align 8, !llfi_index !26
  %h_updating_graph_mask = alloca i8*, align 8, !llfi_index !27
  %h_graph_visited = alloca i8*, align 8, !llfi_index !28
  %start = alloca i32, align 4, !llfi_index !29
  %edgeno = alloca i32, align 4, !llfi_index !30
  %i = alloca i32, align 4, !llfi_index !31
  %id = alloca i32, align 4, !llfi_index !32
  %cost = alloca i32, align 4, !llfi_index !33
  %h_graph_edges = alloca i32*, align 8, !llfi_index !34
  %i1 = alloca i32, align 4, !llfi_index !35
  %h_cost = alloca i32*, align 8, !llfi_index !36
  %i2 = alloca i32, align 4, !llfi_index !37
  %k = alloca i32, align 4, !llfi_index !38
  %stop = alloca i8, align 1, !llfi_index !39
  %tid = alloca i32, align 4, !llfi_index !40
  %i3 = alloca i32, align 4, !llfi_index !41
  %id4 = alloca i32, align 4, !llfi_index !42
  %tid5 = alloca i32, align 4, !llfi_index !43
  %fpo = alloca %struct._IO_FILE*, align 8, !llfi_index !44
  %i6 = alloca i32, align 4, !llfi_index !45
  store i32 %argc, i32* %1, align 4, !llfi_index !46
  store i8** %argv, i8*** %2, align 8, !llfi_index !47
  store i32 0, i32* %no_of_nodes, align 4, !llfi_index !48
  store i32 0, i32* %edge_list_size, align 4, !llfi_index !49
  %3 = load i32* %1, align 4, !llfi_index !50
  %4 = icmp ne i32 %3, 2, !llfi_index !51
  br i1 %4, label %5, label %8, !llfi_index !52

; <label>:5                                       ; preds = %0
  %6 = load i32* %1, align 4, !llfi_index !53
  %7 = load i8*** %2, align 8, !llfi_index !54
  call void @_Z5UsageiPPc(i32 %6, i8** %7), !llfi_index !55
  call void @exit(i32 0) #4, !llfi_index !56
  unreachable, !llfi_index !57

; <label>:8                                       ; preds = %0
  %9 = load i8*** %2, align 8, !llfi_index !58
  %10 = getelementptr inbounds i8** %9, i64 1, !llfi_index !59
  %11 = load i8** %10, align 8, !llfi_index !60
  store i8* %11, i8** %input_f, align 8, !llfi_index !61
  %12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str1, i32 0, i32 0)), !llfi_index !62
  %13 = load i8** %input_f, align 8, !llfi_index !63
  %14 = call %struct._IO_FILE* @fopen(i8* %13, i8* getelementptr inbounds ([2 x i8]* @.str2, i32 0, i32 0)), !llfi_index !64
  store %struct._IO_FILE* %14, %struct._IO_FILE** @fp, align 8, !llfi_index !65
  %15 = load %struct._IO_FILE** @fp, align 8, !llfi_index !66
  %16 = icmp ne %struct._IO_FILE* %15, null, !llfi_index !67
  br i1 %16, label %19, label %17, !llfi_index !68

; <label>:17                                      ; preds = %8
  %18 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([26 x i8]* @.str3, i32 0, i32 0)), !llfi_index !69
  br label %282, !llfi_index !70

; <label>:19                                      ; preds = %8
  store i32 0, i32* %source, align 4, !llfi_index !71
  %20 = load %struct._IO_FILE** @fp, align 8, !llfi_index !72
  %21 = call i32 (%struct._IO_FILE*, i8*, ...)* @fscanf(%struct._IO_FILE* %20, i8* getelementptr inbounds ([3 x i8]* @.str4, i32 0, i32 0), i32* %no_of_nodes), !llfi_index !73
  %22 = load i32* %no_of_nodes, align 4, !llfi_index !74
  %23 = sext i32 %22 to i64, !llfi_index !75
  %24 = mul i64 8, %23, !llfi_index !76
  %25 = call noalias i8* @malloc(i64 %24) #5, !llfi_index !77
  %26 = bitcast i8* %25 to %struct.Node*, !llfi_index !78
  store %struct.Node* %26, %struct.Node** %h_graph_nodes, align 8, !llfi_index !79
  %27 = load i32* %no_of_nodes, align 4, !llfi_index !80
  %28 = sext i32 %27 to i64, !llfi_index !81
  %29 = mul i64 1, %28, !llfi_index !82
  %30 = call noalias i8* @malloc(i64 %29) #5, !llfi_index !83
  store i8* %30, i8** %h_graph_mask, align 8, !llfi_index !84
  %31 = load i32* %no_of_nodes, align 4, !llfi_index !85
  %32 = sext i32 %31 to i64, !llfi_index !86
  %33 = mul i64 1, %32, !llfi_index !87
  %34 = call noalias i8* @malloc(i64 %33) #5, !llfi_index !88
  store i8* %34, i8** %h_updating_graph_mask, align 8, !llfi_index !89
  %35 = load i32* %no_of_nodes, align 4, !llfi_index !90
  %36 = sext i32 %35 to i64, !llfi_index !91
  %37 = mul i64 1, %36, !llfi_index !92
  %38 = call noalias i8* @malloc(i64 %37) #5, !llfi_index !93
  store i8* %38, i8** %h_graph_visited, align 8, !llfi_index !94
  store i32 0, i32* %i, align 4, !llfi_index !95
  br label %39, !llfi_index !96

; <label>:39                                      ; preds = %70, %19
  %40 = load i32* %i, align 4, !llfi_index !97
  %41 = load i32* %no_of_nodes, align 4, !llfi_index !98
  %42 = icmp ult i32 %40, %41, !llfi_index !99
  br i1 %42, label %43, label %73, !llfi_index !100

; <label>:43                                      ; preds = %39
  %44 = load %struct._IO_FILE** @fp, align 8, !llfi_index !101
  %45 = call i32 (%struct._IO_FILE*, i8*, ...)* @fscanf(%struct._IO_FILE* %44, i8* getelementptr inbounds ([6 x i8]* @.str5, i32 0, i32 0), i32* %start, i32* %edgeno), !llfi_index !102
  %46 = load i32* %start, align 4, !llfi_index !103
  %47 = load i32* %i, align 4, !llfi_index !104
  %48 = zext i32 %47 to i64, !llfi_index !105
  %49 = load %struct.Node** %h_graph_nodes, align 8, !llfi_index !106
  %50 = getelementptr inbounds %struct.Node* %49, i64 %48, !llfi_index !107
  %51 = getelementptr inbounds %struct.Node* %50, i32 0, i32 0, !llfi_index !108
  store i32 %46, i32* %51, align 4, !llfi_index !109
  %52 = load i32* %edgeno, align 4, !llfi_index !110
  %53 = load i32* %i, align 4, !llfi_index !111
  %54 = zext i32 %53 to i64, !llfi_index !112
  %55 = load %struct.Node** %h_graph_nodes, align 8, !llfi_index !113
  %56 = getelementptr inbounds %struct.Node* %55, i64 %54, !llfi_index !114
  %57 = getelementptr inbounds %struct.Node* %56, i32 0, i32 1, !llfi_index !115
  store i32 %52, i32* %57, align 4, !llfi_index !116
  %58 = load i32* %i, align 4, !llfi_index !117
  %59 = zext i32 %58 to i64, !llfi_index !118
  %60 = load i8** %h_graph_mask, align 8, !llfi_index !119
  %61 = getelementptr inbounds i8* %60, i64 %59, !llfi_index !120
  store i8 0, i8* %61, align 1, !llfi_index !121
  %62 = load i32* %i, align 4, !llfi_index !122
  %63 = zext i32 %62 to i64, !llfi_index !123
  %64 = load i8** %h_updating_graph_mask, align 8, !llfi_index !124
  %65 = getelementptr inbounds i8* %64, i64 %63, !llfi_index !125
  store i8 0, i8* %65, align 1, !llfi_index !126
  %66 = load i32* %i, align 4, !llfi_index !127
  %67 = zext i32 %66 to i64, !llfi_index !128
  %68 = load i8** %h_graph_visited, align 8, !llfi_index !129
  %69 = getelementptr inbounds i8* %68, i64 %67, !llfi_index !130
  store i8 0, i8* %69, align 1, !llfi_index !131
  br label %70, !llfi_index !132

; <label>:70                                      ; preds = %43
  %71 = load i32* %i, align 4, !llfi_index !133
  %72 = add i32 %71, 1, !llfi_index !134
  store i32 %72, i32* %i, align 4, !llfi_index !135
  br label %39, !llfi_index !136

; <label>:73                                      ; preds = %39
  %74 = load %struct._IO_FILE** @fp, align 8, !llfi_index !137
  %75 = call i32 (%struct._IO_FILE*, i8*, ...)* @fscanf(%struct._IO_FILE* %74, i8* getelementptr inbounds ([3 x i8]* @.str4, i32 0, i32 0), i32* %source), !llfi_index !138
  %76 = load i32* %source, align 4, !llfi_index !139
  %77 = sext i32 %76 to i64, !llfi_index !140
  %78 = load i8** %h_graph_mask, align 8, !llfi_index !141
  %79 = getelementptr inbounds i8* %78, i64 %77, !llfi_index !142
  store i8 1, i8* %79, align 1, !llfi_index !143
  %80 = load i32* %source, align 4, !llfi_index !144
  %81 = sext i32 %80 to i64, !llfi_index !145
  %82 = load i8** %h_graph_visited, align 8, !llfi_index !146
  %83 = getelementptr inbounds i8* %82, i64 %81, !llfi_index !147
  store i8 1, i8* %83, align 1, !llfi_index !148
  %84 = load %struct._IO_FILE** @fp, align 8, !llfi_index !149
  %85 = call i32 (%struct._IO_FILE*, i8*, ...)* @fscanf(%struct._IO_FILE* %84, i8* getelementptr inbounds ([3 x i8]* @.str4, i32 0, i32 0), i32* %edge_list_size), !llfi_index !150
  %86 = load i32* %edge_list_size, align 4, !llfi_index !151
  %87 = sext i32 %86 to i64, !llfi_index !152
  %88 = mul i64 4, %87, !llfi_index !153
  %89 = call noalias i8* @malloc(i64 %88) #5, !llfi_index !154
  %90 = bitcast i8* %89 to i32*, !llfi_index !155
  store i32* %90, i32** %h_graph_edges, align 8, !llfi_index !156
  store i32 0, i32* %i1, align 4, !llfi_index !157
  br label %91, !llfi_index !158

; <label>:91                                      ; preds = %105, %73
  %92 = load i32* %i1, align 4, !llfi_index !159
  %93 = load i32* %edge_list_size, align 4, !llfi_index !160
  %94 = icmp slt i32 %92, %93, !llfi_index !161
  br i1 %94, label %95, label %108, !llfi_index !162

; <label>:95                                      ; preds = %91
  %96 = load %struct._IO_FILE** @fp, align 8, !llfi_index !163
  %97 = call i32 (%struct._IO_FILE*, i8*, ...)* @fscanf(%struct._IO_FILE* %96, i8* getelementptr inbounds ([3 x i8]* @.str4, i32 0, i32 0), i32* %id), !llfi_index !164
  %98 = load %struct._IO_FILE** @fp, align 8, !llfi_index !165
  %99 = call i32 (%struct._IO_FILE*, i8*, ...)* @fscanf(%struct._IO_FILE* %98, i8* getelementptr inbounds ([3 x i8]* @.str4, i32 0, i32 0), i32* %cost), !llfi_index !166
  %100 = load i32* %id, align 4, !llfi_index !167
  %101 = load i32* %i1, align 4, !llfi_index !168
  %102 = sext i32 %101 to i64, !llfi_index !169
  %103 = load i32** %h_graph_edges, align 8, !llfi_index !170
  %104 = getelementptr inbounds i32* %103, i64 %102, !llfi_index !171
  store i32 %100, i32* %104, align 4, !llfi_index !172
  br label %105, !llfi_index !173

; <label>:105                                     ; preds = %95
  %106 = load i32* %i1, align 4, !llfi_index !174
  %107 = add nsw i32 %106, 1, !llfi_index !175
  store i32 %107, i32* %i1, align 4, !llfi_index !176
  br label %91, !llfi_index !177

; <label>:108                                     ; preds = %91
  %109 = load %struct._IO_FILE** @fp, align 8, !llfi_index !178
  %110 = icmp ne %struct._IO_FILE* %109, null, !llfi_index !179
  br i1 %110, label %111, label %114, !llfi_index !180

; <label>:111                                     ; preds = %108
  %112 = load %struct._IO_FILE** @fp, align 8, !llfi_index !181
  %113 = call i32 @fclose(%struct._IO_FILE* %112), !llfi_index !182
  br label %114, !llfi_index !183

; <label>:114                                     ; preds = %111, %108
  %115 = load i32* %no_of_nodes, align 4, !llfi_index !184
  %116 = sext i32 %115 to i64, !llfi_index !185
  %117 = mul i64 4, %116, !llfi_index !186
  %118 = call noalias i8* @malloc(i64 %117) #5, !llfi_index !187
  %119 = bitcast i8* %118 to i32*, !llfi_index !188
  store i32* %119, i32** %h_cost, align 8, !llfi_index !189
  store i32 0, i32* %i2, align 4, !llfi_index !190
  br label %120, !llfi_index !191

; <label>:120                                     ; preds = %129, %114
  %121 = load i32* %i2, align 4, !llfi_index !192
  %122 = load i32* %no_of_nodes, align 4, !llfi_index !193
  %123 = icmp slt i32 %121, %122, !llfi_index !194
  br i1 %123, label %124, label %132, !llfi_index !195

; <label>:124                                     ; preds = %120
  %125 = load i32* %i2, align 4, !llfi_index !196
  %126 = sext i32 %125 to i64, !llfi_index !197
  %127 = load i32** %h_cost, align 8, !llfi_index !198
  %128 = getelementptr inbounds i32* %127, i64 %126, !llfi_index !199
  store i32 -1, i32* %128, align 4, !llfi_index !200
  br label %129, !llfi_index !201

; <label>:129                                     ; preds = %124
  %130 = load i32* %i2, align 4, !llfi_index !202
  %131 = add nsw i32 %130, 1, !llfi_index !203
  store i32 %131, i32* %i2, align 4, !llfi_index !204
  br label %120, !llfi_index !205

; <label>:132                                     ; preds = %120
  %133 = load i32* %source, align 4, !llfi_index !206
  %134 = sext i32 %133 to i64, !llfi_index !207
  %135 = load i32** %h_cost, align 8, !llfi_index !208
  %136 = getelementptr inbounds i32* %135, i64 %134, !llfi_index !209
  store i32 0, i32* %136, align 4, !llfi_index !210
  %137 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([27 x i8]* @.str6, i32 0, i32 0)), !llfi_index !211
  store i32 0, i32* %k, align 4, !llfi_index !212
  br label %138, !llfi_index !213

; <label>:138                                     ; preds = %249, %132
  store i8 0, i8* %stop, align 1, !llfi_index !214
  store i32 0, i32* %tid, align 4, !llfi_index !215
  br label %139, !llfi_index !216

; <label>:139                                     ; preds = %212, %138
  %140 = load i32* %tid, align 4, !llfi_index !217
  %141 = load i32* %no_of_nodes, align 4, !llfi_index !218
  %142 = icmp slt i32 %140, %141, !llfi_index !219
  br i1 %142, label %143, label %215, !llfi_index !220

; <label>:143                                     ; preds = %139
  %144 = load i32* %tid, align 4, !llfi_index !221
  %145 = sext i32 %144 to i64, !llfi_index !222
  %146 = load i8** %h_graph_mask, align 8, !llfi_index !223
  %147 = getelementptr inbounds i8* %146, i64 %145, !llfi_index !224
  %148 = load i8* %147, align 1, !llfi_index !225
  %149 = trunc i8 %148 to i1, !llfi_index !226
  %150 = zext i1 %149 to i32, !llfi_index !227
  %151 = icmp eq i32 %150, 1, !llfi_index !228
  br i1 %151, label %152, label %211, !llfi_index !229

; <label>:152                                     ; preds = %143
  %153 = load i32* %tid, align 4, !llfi_index !230
  %154 = sext i32 %153 to i64, !llfi_index !231
  %155 = load i8** %h_graph_mask, align 8, !llfi_index !232
  %156 = getelementptr inbounds i8* %155, i64 %154, !llfi_index !233
  store i8 0, i8* %156, align 1, !llfi_index !234
  %157 = load i32* %tid, align 4, !llfi_index !235
  %158 = sext i32 %157 to i64, !llfi_index !236
  %159 = load %struct.Node** %h_graph_nodes, align 8, !llfi_index !237
  %160 = getelementptr inbounds %struct.Node* %159, i64 %158, !llfi_index !238
  %161 = getelementptr inbounds %struct.Node* %160, i32 0, i32 0, !llfi_index !239
  %162 = load i32* %161, align 4, !llfi_index !240
  store i32 %162, i32* %i3, align 4, !llfi_index !241
  br label %163, !llfi_index !242

; <label>:163                                     ; preds = %207, %152
  %164 = load i32* %i3, align 4, !llfi_index !243
  %165 = load i32* %tid, align 4, !llfi_index !244
  %166 = sext i32 %165 to i64, !llfi_index !245
  %167 = load %struct.Node** %h_graph_nodes, align 8, !llfi_index !246
  %168 = getelementptr inbounds %struct.Node* %167, i64 %166, !llfi_index !247
  %169 = getelementptr inbounds %struct.Node* %168, i32 0, i32 1, !llfi_index !248
  %170 = load i32* %169, align 4, !llfi_index !249
  %171 = load i32* %tid, align 4, !llfi_index !250
  %172 = sext i32 %171 to i64, !llfi_index !251
  %173 = load %struct.Node** %h_graph_nodes, align 8, !llfi_index !252
  %174 = getelementptr inbounds %struct.Node* %173, i64 %172, !llfi_index !253
  %175 = getelementptr inbounds %struct.Node* %174, i32 0, i32 0, !llfi_index !254
  %176 = load i32* %175, align 4, !llfi_index !255
  %177 = add nsw i32 %170, %176, !llfi_index !256
  %178 = icmp slt i32 %164, %177, !llfi_index !257
  br i1 %178, label %179, label %210, !llfi_index !258

; <label>:179                                     ; preds = %163
  %180 = load i32* %i3, align 4, !llfi_index !259
  %181 = sext i32 %180 to i64, !llfi_index !260
  %182 = load i32** %h_graph_edges, align 8, !llfi_index !261
  %183 = getelementptr inbounds i32* %182, i64 %181, !llfi_index !262
  %184 = load i32* %183, align 4, !llfi_index !263
  store i32 %184, i32* %id4, align 4, !llfi_index !264
  %185 = load i32* %id4, align 4, !llfi_index !265
  %186 = sext i32 %185 to i64, !llfi_index !266
  %187 = load i8** %h_graph_visited, align 8, !llfi_index !267
  %188 = getelementptr inbounds i8* %187, i64 %186, !llfi_index !268
  %189 = load i8* %188, align 1, !llfi_index !269
  %190 = trunc i8 %189 to i1, !llfi_index !270
  br i1 %190, label %206, label %191, !llfi_index !271

; <label>:191                                     ; preds = %179
  %192 = load i32* %tid, align 4, !llfi_index !272
  %193 = sext i32 %192 to i64, !llfi_index !273
  %194 = load i32** %h_cost, align 8, !llfi_index !274
  %195 = getelementptr inbounds i32* %194, i64 %193, !llfi_index !275
  %196 = load i32* %195, align 4, !llfi_index !276
  %197 = add nsw i32 %196, 1, !llfi_index !277
  %198 = load i32* %id4, align 4, !llfi_index !278
  %199 = sext i32 %198 to i64, !llfi_index !279
  %200 = load i32** %h_cost, align 8, !llfi_index !280
  %201 = getelementptr inbounds i32* %200, i64 %199, !llfi_index !281
  store i32 %197, i32* %201, align 4, !llfi_index !282
  %202 = load i32* %id4, align 4, !llfi_index !283
  %203 = sext i32 %202 to i64, !llfi_index !284
  %204 = load i8** %h_updating_graph_mask, align 8, !llfi_index !285
  %205 = getelementptr inbounds i8* %204, i64 %203, !llfi_index !286
  store i8 1, i8* %205, align 1, !llfi_index !287
  br label %206, !llfi_index !288

; <label>:206                                     ; preds = %191, %179
  br label %207, !llfi_index !289

; <label>:207                                     ; preds = %206
  %208 = load i32* %i3, align 4, !llfi_index !290
  %209 = add nsw i32 %208, 1, !llfi_index !291
  store i32 %209, i32* %i3, align 4, !llfi_index !292
  br label %163, !llfi_index !293

; <label>:210                                     ; preds = %163
  br label %211, !llfi_index !294

; <label>:211                                     ; preds = %210, %143
  br label %212, !llfi_index !295

; <label>:212                                     ; preds = %211
  %213 = load i32* %tid, align 4, !llfi_index !296
  %214 = add nsw i32 %213, 1, !llfi_index !297
  store i32 %214, i32* %tid, align 4, !llfi_index !298
  br label %139, !llfi_index !299

; <label>:215                                     ; preds = %139
  store i32 0, i32* %tid5, align 4, !llfi_index !300
  br label %216, !llfi_index !301

; <label>:216                                     ; preds = %243, %215
  %217 = load i32* %tid5, align 4, !llfi_index !302
  %218 = load i32* %no_of_nodes, align 4, !llfi_index !303
  %219 = icmp slt i32 %217, %218, !llfi_index !304
  br i1 %219, label %220, label %246, !llfi_index !305

; <label>:220                                     ; preds = %216
  %221 = load i32* %tid5, align 4, !llfi_index !306
  %222 = sext i32 %221 to i64, !llfi_index !307
  %223 = load i8** %h_updating_graph_mask, align 8, !llfi_index !308
  %224 = getelementptr inbounds i8* %223, i64 %222, !llfi_index !309
  %225 = load i8* %224, align 1, !llfi_index !310
  %226 = trunc i8 %225 to i1, !llfi_index !311
  %227 = zext i1 %226 to i32, !llfi_index !312
  %228 = icmp eq i32 %227, 1, !llfi_index !313
  br i1 %228, label %229, label %242, !llfi_index !314

; <label>:229                                     ; preds = %220
  %230 = load i32* %tid5, align 4, !llfi_index !315
  %231 = sext i32 %230 to i64, !llfi_index !316
  %232 = load i8** %h_graph_mask, align 8, !llfi_index !317
  %233 = getelementptr inbounds i8* %232, i64 %231, !llfi_index !318
  store i8 1, i8* %233, align 1, !llfi_index !319
  %234 = load i32* %tid5, align 4, !llfi_index !320
  %235 = sext i32 %234 to i64, !llfi_index !321
  %236 = load i8** %h_graph_visited, align 8, !llfi_index !322
  %237 = getelementptr inbounds i8* %236, i64 %235, !llfi_index !323
  store i8 1, i8* %237, align 1, !llfi_index !324
  store i8 1, i8* %stop, align 1, !llfi_index !325
  %238 = load i32* %tid5, align 4, !llfi_index !326
  %239 = sext i32 %238 to i64, !llfi_index !327
  %240 = load i8** %h_updating_graph_mask, align 8, !llfi_index !328
  %241 = getelementptr inbounds i8* %240, i64 %239, !llfi_index !329
  store i8 0, i8* %241, align 1, !llfi_index !330
  br label %242, !llfi_index !331

; <label>:242                                     ; preds = %229, %220
  br label %243, !llfi_index !332

; <label>:243                                     ; preds = %242
  %244 = load i32* %tid5, align 4, !llfi_index !333
  %245 = add nsw i32 %244, 1, !llfi_index !334
  store i32 %245, i32* %tid5, align 4, !llfi_index !335
  br label %216, !llfi_index !336

; <label>:246                                     ; preds = %216
  %247 = load i32* %k, align 4, !llfi_index !337
  %248 = add nsw i32 %247, 1, !llfi_index !338
  store i32 %248, i32* %k, align 4, !llfi_index !339
  br label %249, !llfi_index !340

; <label>:249                                     ; preds = %246
  %250 = load i8* %stop, align 1, !llfi_index !341
  %251 = trunc i8 %250 to i1, !llfi_index !342
  br i1 %251, label %138, label %252, !llfi_index !343

; <label>:252                                     ; preds = %249
  %253 = call %struct._IO_FILE* @fopen(i8* getelementptr inbounds ([11 x i8]* @.str7, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8]* @.str8, i32 0, i32 0)), !llfi_index !344
  store %struct._IO_FILE* %253, %struct._IO_FILE** %fpo, align 8, !llfi_index !345
  store i32 0, i32* %i6, align 4, !llfi_index !346
  br label %254, !llfi_index !347

; <label>:254                                     ; preds = %267, %252
  %255 = load i32* %i6, align 4, !llfi_index !348
  %256 = load i32* %no_of_nodes, align 4, !llfi_index !349
  %257 = icmp slt i32 %255, %256, !llfi_index !350
  br i1 %257, label %258, label %270, !llfi_index !351

; <label>:258                                     ; preds = %254
  %259 = load %struct._IO_FILE** %fpo, align 8, !llfi_index !352
  %260 = load i32* %i6, align 4, !llfi_index !353
  %261 = load i32* %i6, align 4, !llfi_index !354
  %262 = sext i32 %261 to i64, !llfi_index !355
  %263 = load i32** %h_cost, align 8, !llfi_index !356
  %264 = getelementptr inbounds i32* %263, i64 %262, !llfi_index !357
  %265 = load i32* %264, align 4, !llfi_index !358
  %266 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %259, i8* getelementptr inbounds ([13 x i8]* @.str9, i32 0, i32 0), i32 %260, i32 %265), !llfi_index !359
  br label %267, !llfi_index !360

; <label>:267                                     ; preds = %258
  %268 = load i32* %i6, align 4, !llfi_index !361
  %269 = add nsw i32 %268, 1, !llfi_index !362
  store i32 %269, i32* %i6, align 4, !llfi_index !363
  br label %254, !llfi_index !364

; <label>:270                                     ; preds = %254
  %271 = load %struct._IO_FILE** %fpo, align 8, !llfi_index !365
  %272 = call i32 @fclose(%struct._IO_FILE* %271), !llfi_index !366
  %273 = load %struct.Node** %h_graph_nodes, align 8, !llfi_index !367
  %274 = bitcast %struct.Node* %273 to i8*, !llfi_index !368
  call void @free(i8* %274) #5, !llfi_index !369
  %275 = load i32** %h_graph_edges, align 8, !llfi_index !370
  %276 = bitcast i32* %275 to i8*, !llfi_index !371
  call void @free(i8* %276) #5, !llfi_index !372
  %277 = load i8** %h_graph_mask, align 8, !llfi_index !373
  call void @free(i8* %277) #5, !llfi_index !374
  %278 = load i8** %h_updating_graph_mask, align 8, !llfi_index !375
  call void @free(i8* %278) #5, !llfi_index !376
  %279 = load i8** %h_graph_visited, align 8, !llfi_index !377
  call void @free(i8* %279) #5, !llfi_index !378
  %280 = load i32** %h_cost, align 8, !llfi_index !379
  %281 = bitcast i32* %280 to i8*, !llfi_index !380
  call void @free(i8* %281) #5, !llfi_index !381
  br label %282, !llfi_index !382

; <label>:282                                     ; preds = %270, %17
  ret void, !llfi_index !383
}

; Function Attrs: noreturn nounwind
declare void @exit(i32) #2

declare i32 @printf(i8*, ...) #1

declare %struct._IO_FILE* @fopen(i8*, i8*) #1

declare i32 @fscanf(%struct._IO_FILE*, i8*, ...) #1

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #3

declare i32 @fclose(%struct._IO_FILE*) #1

; Function Attrs: nounwind
declare void @free(i8*) #3

attributes #0 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind }
attributes #5 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"clang version 3.4 (tags/RELEASE_34/final)"}
!1 = metadata !{i64 1}
!2 = metadata !{i64 2}
!3 = metadata !{i64 3}
!4 = metadata !{i64 4}
!5 = metadata !{i64 5}
!6 = metadata !{i64 6}
!7 = metadata !{i64 7}
!8 = metadata !{i64 8}
!9 = metadata !{i64 9}
!10 = metadata !{i64 10}
!11 = metadata !{i64 11}
!12 = metadata !{i64 12}
!13 = metadata !{i64 13}
!14 = metadata !{i64 14}
!15 = metadata !{i64 15}
!16 = metadata !{i64 16}
!17 = metadata !{i64 17}
!18 = metadata !{i64 18}
!19 = metadata !{i64 19}
!20 = metadata !{i64 20}
!21 = metadata !{i64 21}
!22 = metadata !{i64 22}
!23 = metadata !{i64 23}
!24 = metadata !{i64 24}
!25 = metadata !{i64 25}
!26 = metadata !{i64 26}
!27 = metadata !{i64 27}
!28 = metadata !{i64 28}
!29 = metadata !{i64 29}
!30 = metadata !{i64 30}
!31 = metadata !{i64 31}
!32 = metadata !{i64 32}
!33 = metadata !{i64 33}
!34 = metadata !{i64 34}
!35 = metadata !{i64 35}
!36 = metadata !{i64 36}
!37 = metadata !{i64 37}
!38 = metadata !{i64 38}
!39 = metadata !{i64 39}
!40 = metadata !{i64 40}
!41 = metadata !{i64 41}
!42 = metadata !{i64 42}
!43 = metadata !{i64 43}
!44 = metadata !{i64 44}
!45 = metadata !{i64 45}
!46 = metadata !{i64 46}
!47 = metadata !{i64 47}
!48 = metadata !{i64 48}
!49 = metadata !{i64 49}
!50 = metadata !{i64 50}
!51 = metadata !{i64 51}
!52 = metadata !{i64 52}
!53 = metadata !{i64 53}
!54 = metadata !{i64 54}
!55 = metadata !{i64 55}
!56 = metadata !{i64 56}
!57 = metadata !{i64 57}
!58 = metadata !{i64 58}
!59 = metadata !{i64 59}
!60 = metadata !{i64 60}
!61 = metadata !{i64 61}
!62 = metadata !{i64 62}
!63 = metadata !{i64 63}
!64 = metadata !{i64 64}
!65 = metadata !{i64 65}
!66 = metadata !{i64 66}
!67 = metadata !{i64 67}
!68 = metadata !{i64 68}
!69 = metadata !{i64 69}
!70 = metadata !{i64 70}
!71 = metadata !{i64 71}
!72 = metadata !{i64 72}
!73 = metadata !{i64 73}
!74 = metadata !{i64 74}
!75 = metadata !{i64 75}
!76 = metadata !{i64 76}
!77 = metadata !{i64 77}
!78 = metadata !{i64 78}
!79 = metadata !{i64 79}
!80 = metadata !{i64 80}
!81 = metadata !{i64 81}
!82 = metadata !{i64 82}
!83 = metadata !{i64 83}
!84 = metadata !{i64 84}
!85 = metadata !{i64 85}
!86 = metadata !{i64 86}
!87 = metadata !{i64 87}
!88 = metadata !{i64 88}
!89 = metadata !{i64 89}
!90 = metadata !{i64 90}
!91 = metadata !{i64 91}
!92 = metadata !{i64 92}
!93 = metadata !{i64 93}
!94 = metadata !{i64 94}
!95 = metadata !{i64 95}
!96 = metadata !{i64 96}
!97 = metadata !{i64 97}
!98 = metadata !{i64 98}
!99 = metadata !{i64 99}
!100 = metadata !{i64 100}
!101 = metadata !{i64 101}
!102 = metadata !{i64 102}
!103 = metadata !{i64 103}
!104 = metadata !{i64 104}
!105 = metadata !{i64 105}
!106 = metadata !{i64 106}
!107 = metadata !{i64 107}
!108 = metadata !{i64 108}
!109 = metadata !{i64 109}
!110 = metadata !{i64 110}
!111 = metadata !{i64 111}
!112 = metadata !{i64 112}
!113 = metadata !{i64 113}
!114 = metadata !{i64 114}
!115 = metadata !{i64 115}
!116 = metadata !{i64 116}
!117 = metadata !{i64 117}
!118 = metadata !{i64 118}
!119 = metadata !{i64 119}
!120 = metadata !{i64 120}
!121 = metadata !{i64 121}
!122 = metadata !{i64 122}
!123 = metadata !{i64 123}
!124 = metadata !{i64 124}
!125 = metadata !{i64 125}
!126 = metadata !{i64 126}
!127 = metadata !{i64 127}
!128 = metadata !{i64 128}
!129 = metadata !{i64 129}
!130 = metadata !{i64 130}
!131 = metadata !{i64 131}
!132 = metadata !{i64 132}
!133 = metadata !{i64 133}
!134 = metadata !{i64 134}
!135 = metadata !{i64 135}
!136 = metadata !{i64 136}
!137 = metadata !{i64 137}
!138 = metadata !{i64 138}
!139 = metadata !{i64 139}
!140 = metadata !{i64 140}
!141 = metadata !{i64 141}
!142 = metadata !{i64 142}
!143 = metadata !{i64 143}
!144 = metadata !{i64 144}
!145 = metadata !{i64 145}
!146 = metadata !{i64 146}
!147 = metadata !{i64 147}
!148 = metadata !{i64 148}
!149 = metadata !{i64 149}
!150 = metadata !{i64 150}
!151 = metadata !{i64 151}
!152 = metadata !{i64 152}
!153 = metadata !{i64 153}
!154 = metadata !{i64 154}
!155 = metadata !{i64 155}
!156 = metadata !{i64 156}
!157 = metadata !{i64 157}
!158 = metadata !{i64 158}
!159 = metadata !{i64 159}
!160 = metadata !{i64 160}
!161 = metadata !{i64 161}
!162 = metadata !{i64 162}
!163 = metadata !{i64 163}
!164 = metadata !{i64 164}
!165 = metadata !{i64 165}
!166 = metadata !{i64 166}
!167 = metadata !{i64 167}
!168 = metadata !{i64 168}
!169 = metadata !{i64 169}
!170 = metadata !{i64 170}
!171 = metadata !{i64 171}
!172 = metadata !{i64 172}
!173 = metadata !{i64 173}
!174 = metadata !{i64 174}
!175 = metadata !{i64 175}
!176 = metadata !{i64 176}
!177 = metadata !{i64 177}
!178 = metadata !{i64 178}
!179 = metadata !{i64 179}
!180 = metadata !{i64 180}
!181 = metadata !{i64 181}
!182 = metadata !{i64 182}
!183 = metadata !{i64 183}
!184 = metadata !{i64 184}
!185 = metadata !{i64 185}
!186 = metadata !{i64 186}
!187 = metadata !{i64 187}
!188 = metadata !{i64 188}
!189 = metadata !{i64 189}
!190 = metadata !{i64 190}
!191 = metadata !{i64 191}
!192 = metadata !{i64 192}
!193 = metadata !{i64 193}
!194 = metadata !{i64 194}
!195 = metadata !{i64 195}
!196 = metadata !{i64 196}
!197 = metadata !{i64 197}
!198 = metadata !{i64 198}
!199 = metadata !{i64 199}
!200 = metadata !{i64 200}
!201 = metadata !{i64 201}
!202 = metadata !{i64 202}
!203 = metadata !{i64 203}
!204 = metadata !{i64 204}
!205 = metadata !{i64 205}
!206 = metadata !{i64 206}
!207 = metadata !{i64 207}
!208 = metadata !{i64 208}
!209 = metadata !{i64 209}
!210 = metadata !{i64 210}
!211 = metadata !{i64 211}
!212 = metadata !{i64 212}
!213 = metadata !{i64 213}
!214 = metadata !{i64 214}
!215 = metadata !{i64 215}
!216 = metadata !{i64 216}
!217 = metadata !{i64 217}
!218 = metadata !{i64 218}
!219 = metadata !{i64 219}
!220 = metadata !{i64 220}
!221 = metadata !{i64 221}
!222 = metadata !{i64 222}
!223 = metadata !{i64 223}
!224 = metadata !{i64 224}
!225 = metadata !{i64 225}
!226 = metadata !{i64 226}
!227 = metadata !{i64 227}
!228 = metadata !{i64 228}
!229 = metadata !{i64 229}
!230 = metadata !{i64 230}
!231 = metadata !{i64 231}
!232 = metadata !{i64 232}
!233 = metadata !{i64 233}
!234 = metadata !{i64 234}
!235 = metadata !{i64 235}
!236 = metadata !{i64 236}
!237 = metadata !{i64 237}
!238 = metadata !{i64 238}
!239 = metadata !{i64 239}
!240 = metadata !{i64 240}
!241 = metadata !{i64 241}
!242 = metadata !{i64 242}
!243 = metadata !{i64 243}
!244 = metadata !{i64 244}
!245 = metadata !{i64 245}
!246 = metadata !{i64 246}
!247 = metadata !{i64 247}
!248 = metadata !{i64 248}
!249 = metadata !{i64 249}
!250 = metadata !{i64 250}
!251 = metadata !{i64 251}
!252 = metadata !{i64 252}
!253 = metadata !{i64 253}
!254 = metadata !{i64 254}
!255 = metadata !{i64 255}
!256 = metadata !{i64 256}
!257 = metadata !{i64 257}
!258 = metadata !{i64 258}
!259 = metadata !{i64 259}
!260 = metadata !{i64 260}
!261 = metadata !{i64 261}
!262 = metadata !{i64 262}
!263 = metadata !{i64 263}
!264 = metadata !{i64 264}
!265 = metadata !{i64 265}
!266 = metadata !{i64 266}
!267 = metadata !{i64 267}
!268 = metadata !{i64 268}
!269 = metadata !{i64 269}
!270 = metadata !{i64 270}
!271 = metadata !{i64 271}
!272 = metadata !{i64 272}
!273 = metadata !{i64 273}
!274 = metadata !{i64 274}
!275 = metadata !{i64 275}
!276 = metadata !{i64 276}
!277 = metadata !{i64 277}
!278 = metadata !{i64 278}
!279 = metadata !{i64 279}
!280 = metadata !{i64 280}
!281 = metadata !{i64 281}
!282 = metadata !{i64 282}
!283 = metadata !{i64 283}
!284 = metadata !{i64 284}
!285 = metadata !{i64 285}
!286 = metadata !{i64 286}
!287 = metadata !{i64 287}
!288 = metadata !{i64 288}
!289 = metadata !{i64 289}
!290 = metadata !{i64 290}
!291 = metadata !{i64 291}
!292 = metadata !{i64 292}
!293 = metadata !{i64 293}
!294 = metadata !{i64 294}
!295 = metadata !{i64 295}
!296 = metadata !{i64 296}
!297 = metadata !{i64 297}
!298 = metadata !{i64 298}
!299 = metadata !{i64 299}
!300 = metadata !{i64 300}
!301 = metadata !{i64 301}
!302 = metadata !{i64 302}
!303 = metadata !{i64 303}
!304 = metadata !{i64 304}
!305 = metadata !{i64 305}
!306 = metadata !{i64 306}
!307 = metadata !{i64 307}
!308 = metadata !{i64 308}
!309 = metadata !{i64 309}
!310 = metadata !{i64 310}
!311 = metadata !{i64 311}
!312 = metadata !{i64 312}
!313 = metadata !{i64 313}
!314 = metadata !{i64 314}
!315 = metadata !{i64 315}
!316 = metadata !{i64 316}
!317 = metadata !{i64 317}
!318 = metadata !{i64 318}
!319 = metadata !{i64 319}
!320 = metadata !{i64 320}
!321 = metadata !{i64 321}
!322 = metadata !{i64 322}
!323 = metadata !{i64 323}
!324 = metadata !{i64 324}
!325 = metadata !{i64 325}
!326 = metadata !{i64 326}
!327 = metadata !{i64 327}
!328 = metadata !{i64 328}
!329 = metadata !{i64 329}
!330 = metadata !{i64 330}
!331 = metadata !{i64 331}
!332 = metadata !{i64 332}
!333 = metadata !{i64 333}
!334 = metadata !{i64 334}
!335 = metadata !{i64 335}
!336 = metadata !{i64 336}
!337 = metadata !{i64 337}
!338 = metadata !{i64 338}
!339 = metadata !{i64 339}
!340 = metadata !{i64 340}
!341 = metadata !{i64 341}
!342 = metadata !{i64 342}
!343 = metadata !{i64 343}
!344 = metadata !{i64 344}
!345 = metadata !{i64 345}
!346 = metadata !{i64 346}
!347 = metadata !{i64 347}
!348 = metadata !{i64 348}
!349 = metadata !{i64 349}
!350 = metadata !{i64 350}
!351 = metadata !{i64 351}
!352 = metadata !{i64 352}
!353 = metadata !{i64 353}
!354 = metadata !{i64 354}
!355 = metadata !{i64 355}
!356 = metadata !{i64 356}
!357 = metadata !{i64 357}
!358 = metadata !{i64 358}
!359 = metadata !{i64 359}
!360 = metadata !{i64 360}
!361 = metadata !{i64 361}
!362 = metadata !{i64 362}
!363 = metadata !{i64 363}
!364 = metadata !{i64 364}
!365 = metadata !{i64 365}
!366 = metadata !{i64 366}
!367 = metadata !{i64 367}
!368 = metadata !{i64 368}
!369 = metadata !{i64 369}
!370 = metadata !{i64 370}
!371 = metadata !{i64 371}
!372 = metadata !{i64 372}
!373 = metadata !{i64 373}
!374 = metadata !{i64 374}
!375 = metadata !{i64 375}
!376 = metadata !{i64 376}
!377 = metadata !{i64 377}
!378 = metadata !{i64 378}
!379 = metadata !{i64 379}
!380 = metadata !{i64 380}
!381 = metadata !{i64 381}
!382 = metadata !{i64 382}
!383 = metadata !{i64 383}
