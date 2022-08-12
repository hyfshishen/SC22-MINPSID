; ModuleID = 'bfs.cpp'
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
  %1 = alloca i32, align 4
  %2 = alloca i8**, align 8
  store i32 %argc, i32* %1, align 4
  store i8** %argv, i8*** %2, align 8
  %3 = load %struct._IO_FILE** @stderr, align 8
  %4 = load i8*** %2, align 8
  %5 = getelementptr inbounds i8** %4, i64 0
  %6 = load i8** %5, align 8
  %7 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %3, i8* getelementptr inbounds ([24 x i8]* @.str, i32 0, i32 0), i8* %6)
  ret void
}

declare i32 @fprintf(%struct._IO_FILE*, i8*, ...) #1

; Function Attrs: uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i8**, align 8
  store i32 %argc, i32* %1, align 4
  store i8** %argv, i8*** %2, align 8
  %3 = load i32* %1, align 4
  %4 = load i8*** %2, align 8
  call void @_Z8BFSGraphiPPc(i32 %3, i8** %4)
  ret i32 0
}

; Function Attrs: uwtable
define void @_Z8BFSGraphiPPc(i32 %argc, i8** %argv) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i8**, align 8
  %no_of_nodes = alloca i32, align 4
  %edge_list_size = alloca i32, align 4
  %input_f = alloca i8*, align 8
  %source = alloca i32, align 4
  %h_graph_nodes = alloca %struct.Node*, align 8
  %h_graph_mask = alloca i8*, align 8
  %h_updating_graph_mask = alloca i8*, align 8
  %h_graph_visited = alloca i8*, align 8
  %start = alloca i32, align 4
  %edgeno = alloca i32, align 4
  %i = alloca i32, align 4
  %id = alloca i32, align 4
  %cost = alloca i32, align 4
  %h_graph_edges = alloca i32*, align 8
  %i1 = alloca i32, align 4
  %h_cost = alloca i32*, align 8
  %i2 = alloca i32, align 4
  %k = alloca i32, align 4
  %stop = alloca i8, align 1
  %tid = alloca i32, align 4
  %i3 = alloca i32, align 4
  %id4 = alloca i32, align 4
  %tid5 = alloca i32, align 4
  %fpo = alloca %struct._IO_FILE*, align 8
  %i6 = alloca i32, align 4
  store i32 %argc, i32* %1, align 4
  store i8** %argv, i8*** %2, align 8
  store i32 0, i32* %no_of_nodes, align 4
  store i32 0, i32* %edge_list_size, align 4
  %3 = load i32* %1, align 4
  %4 = icmp ne i32 %3, 2
  br i1 %4, label %5, label %8

; <label>:5                                       ; preds = %0
  %6 = load i32* %1, align 4
  %7 = load i8*** %2, align 8
  call void @_Z5UsageiPPc(i32 %6, i8** %7)
  call void @exit(i32 0) #4
  unreachable

; <label>:8                                       ; preds = %0
  %9 = load i8*** %2, align 8
  %10 = getelementptr inbounds i8** %9, i64 1
  %11 = load i8** %10, align 8
  store i8* %11, i8** %input_f, align 8
  %12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str1, i32 0, i32 0))
  %13 = load i8** %input_f, align 8
  %14 = call %struct._IO_FILE* @fopen(i8* %13, i8* getelementptr inbounds ([2 x i8]* @.str2, i32 0, i32 0))
  store %struct._IO_FILE* %14, %struct._IO_FILE** @fp, align 8
  %15 = load %struct._IO_FILE** @fp, align 8
  %16 = icmp ne %struct._IO_FILE* %15, null
  br i1 %16, label %19, label %17

; <label>:17                                      ; preds = %8
  %18 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([26 x i8]* @.str3, i32 0, i32 0))
  br label %282

; <label>:19                                      ; preds = %8
  store i32 0, i32* %source, align 4
  %20 = load %struct._IO_FILE** @fp, align 8
  %21 = call i32 (%struct._IO_FILE*, i8*, ...)* @fscanf(%struct._IO_FILE* %20, i8* getelementptr inbounds ([3 x i8]* @.str4, i32 0, i32 0), i32* %no_of_nodes)
  %22 = load i32* %no_of_nodes, align 4
  %23 = sext i32 %22 to i64
  %24 = mul i64 8, %23
  %25 = call noalias i8* @malloc(i64 %24) #5
  %26 = bitcast i8* %25 to %struct.Node*
  store %struct.Node* %26, %struct.Node** %h_graph_nodes, align 8
  %27 = load i32* %no_of_nodes, align 4
  %28 = sext i32 %27 to i64
  %29 = mul i64 1, %28
  %30 = call noalias i8* @malloc(i64 %29) #5
  store i8* %30, i8** %h_graph_mask, align 8
  %31 = load i32* %no_of_nodes, align 4
  %32 = sext i32 %31 to i64
  %33 = mul i64 1, %32
  %34 = call noalias i8* @malloc(i64 %33) #5
  store i8* %34, i8** %h_updating_graph_mask, align 8
  %35 = load i32* %no_of_nodes, align 4
  %36 = sext i32 %35 to i64
  %37 = mul i64 1, %36
  %38 = call noalias i8* @malloc(i64 %37) #5
  store i8* %38, i8** %h_graph_visited, align 8
  store i32 0, i32* %i, align 4
  br label %39

; <label>:39                                      ; preds = %70, %19
  %40 = load i32* %i, align 4
  %41 = load i32* %no_of_nodes, align 4
  %42 = icmp ult i32 %40, %41
  br i1 %42, label %43, label %73

; <label>:43                                      ; preds = %39
  %44 = load %struct._IO_FILE** @fp, align 8
  %45 = call i32 (%struct._IO_FILE*, i8*, ...)* @fscanf(%struct._IO_FILE* %44, i8* getelementptr inbounds ([6 x i8]* @.str5, i32 0, i32 0), i32* %start, i32* %edgeno)
  %46 = load i32* %start, align 4
  %47 = load i32* %i, align 4
  %48 = zext i32 %47 to i64
  %49 = load %struct.Node** %h_graph_nodes, align 8
  %50 = getelementptr inbounds %struct.Node* %49, i64 %48
  %51 = getelementptr inbounds %struct.Node* %50, i32 0, i32 0
  store i32 %46, i32* %51, align 4
  %52 = load i32* %edgeno, align 4
  %53 = load i32* %i, align 4
  %54 = zext i32 %53 to i64
  %55 = load %struct.Node** %h_graph_nodes, align 8
  %56 = getelementptr inbounds %struct.Node* %55, i64 %54
  %57 = getelementptr inbounds %struct.Node* %56, i32 0, i32 1
  store i32 %52, i32* %57, align 4
  %58 = load i32* %i, align 4
  %59 = zext i32 %58 to i64
  %60 = load i8** %h_graph_mask, align 8
  %61 = getelementptr inbounds i8* %60, i64 %59
  store i8 0, i8* %61, align 1
  %62 = load i32* %i, align 4
  %63 = zext i32 %62 to i64
  %64 = load i8** %h_updating_graph_mask, align 8
  %65 = getelementptr inbounds i8* %64, i64 %63
  store i8 0, i8* %65, align 1
  %66 = load i32* %i, align 4
  %67 = zext i32 %66 to i64
  %68 = load i8** %h_graph_visited, align 8
  %69 = getelementptr inbounds i8* %68, i64 %67
  store i8 0, i8* %69, align 1
  br label %70

; <label>:70                                      ; preds = %43
  %71 = load i32* %i, align 4
  %72 = add i32 %71, 1
  store i32 %72, i32* %i, align 4
  br label %39

; <label>:73                                      ; preds = %39
  %74 = load %struct._IO_FILE** @fp, align 8
  %75 = call i32 (%struct._IO_FILE*, i8*, ...)* @fscanf(%struct._IO_FILE* %74, i8* getelementptr inbounds ([3 x i8]* @.str4, i32 0, i32 0), i32* %source)
  %76 = load i32* %source, align 4
  %77 = sext i32 %76 to i64
  %78 = load i8** %h_graph_mask, align 8
  %79 = getelementptr inbounds i8* %78, i64 %77
  store i8 1, i8* %79, align 1
  %80 = load i32* %source, align 4
  %81 = sext i32 %80 to i64
  %82 = load i8** %h_graph_visited, align 8
  %83 = getelementptr inbounds i8* %82, i64 %81
  store i8 1, i8* %83, align 1
  %84 = load %struct._IO_FILE** @fp, align 8
  %85 = call i32 (%struct._IO_FILE*, i8*, ...)* @fscanf(%struct._IO_FILE* %84, i8* getelementptr inbounds ([3 x i8]* @.str4, i32 0, i32 0), i32* %edge_list_size)
  %86 = load i32* %edge_list_size, align 4
  %87 = sext i32 %86 to i64
  %88 = mul i64 4, %87
  %89 = call noalias i8* @malloc(i64 %88) #5
  %90 = bitcast i8* %89 to i32*
  store i32* %90, i32** %h_graph_edges, align 8
  store i32 0, i32* %i1, align 4
  br label %91

; <label>:91                                      ; preds = %105, %73
  %92 = load i32* %i1, align 4
  %93 = load i32* %edge_list_size, align 4
  %94 = icmp slt i32 %92, %93
  br i1 %94, label %95, label %108

; <label>:95                                      ; preds = %91
  %96 = load %struct._IO_FILE** @fp, align 8
  %97 = call i32 (%struct._IO_FILE*, i8*, ...)* @fscanf(%struct._IO_FILE* %96, i8* getelementptr inbounds ([3 x i8]* @.str4, i32 0, i32 0), i32* %id)
  %98 = load %struct._IO_FILE** @fp, align 8
  %99 = call i32 (%struct._IO_FILE*, i8*, ...)* @fscanf(%struct._IO_FILE* %98, i8* getelementptr inbounds ([3 x i8]* @.str4, i32 0, i32 0), i32* %cost)
  %100 = load i32* %id, align 4
  %101 = load i32* %i1, align 4
  %102 = sext i32 %101 to i64
  %103 = load i32** %h_graph_edges, align 8
  %104 = getelementptr inbounds i32* %103, i64 %102
  store i32 %100, i32* %104, align 4
  br label %105

; <label>:105                                     ; preds = %95
  %106 = load i32* %i1, align 4
  %107 = add nsw i32 %106, 1
  store i32 %107, i32* %i1, align 4
  br label %91

; <label>:108                                     ; preds = %91
  %109 = load %struct._IO_FILE** @fp, align 8
  %110 = icmp ne %struct._IO_FILE* %109, null
  br i1 %110, label %111, label %114

; <label>:111                                     ; preds = %108
  %112 = load %struct._IO_FILE** @fp, align 8
  %113 = call i32 @fclose(%struct._IO_FILE* %112)
  br label %114

; <label>:114                                     ; preds = %111, %108
  %115 = load i32* %no_of_nodes, align 4
  %116 = sext i32 %115 to i64
  %117 = mul i64 4, %116
  %118 = call noalias i8* @malloc(i64 %117) #5
  %119 = bitcast i8* %118 to i32*
  store i32* %119, i32** %h_cost, align 8
  store i32 0, i32* %i2, align 4
  br label %120

; <label>:120                                     ; preds = %129, %114
  %121 = load i32* %i2, align 4
  %122 = load i32* %no_of_nodes, align 4
  %123 = icmp slt i32 %121, %122
  br i1 %123, label %124, label %132

; <label>:124                                     ; preds = %120
  %125 = load i32* %i2, align 4
  %126 = sext i32 %125 to i64
  %127 = load i32** %h_cost, align 8
  %128 = getelementptr inbounds i32* %127, i64 %126
  store i32 -1, i32* %128, align 4
  br label %129

; <label>:129                                     ; preds = %124
  %130 = load i32* %i2, align 4
  %131 = add nsw i32 %130, 1
  store i32 %131, i32* %i2, align 4
  br label %120

; <label>:132                                     ; preds = %120
  %133 = load i32* %source, align 4
  %134 = sext i32 %133 to i64
  %135 = load i32** %h_cost, align 8
  %136 = getelementptr inbounds i32* %135, i64 %134
  store i32 0, i32* %136, align 4
  %137 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([27 x i8]* @.str6, i32 0, i32 0))
  store i32 0, i32* %k, align 4
  br label %138

; <label>:138                                     ; preds = %249, %132
  store i8 0, i8* %stop, align 1
  store i32 0, i32* %tid, align 4
  br label %139

; <label>:139                                     ; preds = %212, %138
  %140 = load i32* %tid, align 4
  %141 = load i32* %no_of_nodes, align 4
  %142 = icmp slt i32 %140, %141
  br i1 %142, label %143, label %215

; <label>:143                                     ; preds = %139
  %144 = load i32* %tid, align 4
  %145 = sext i32 %144 to i64
  %146 = load i8** %h_graph_mask, align 8
  %147 = getelementptr inbounds i8* %146, i64 %145
  %148 = load i8* %147, align 1
  %149 = trunc i8 %148 to i1
  %150 = zext i1 %149 to i32
  %151 = icmp eq i32 %150, 1
  br i1 %151, label %152, label %211

; <label>:152                                     ; preds = %143
  %153 = load i32* %tid, align 4
  %154 = sext i32 %153 to i64
  %155 = load i8** %h_graph_mask, align 8
  %156 = getelementptr inbounds i8* %155, i64 %154
  store i8 0, i8* %156, align 1
  %157 = load i32* %tid, align 4
  %158 = sext i32 %157 to i64
  %159 = load %struct.Node** %h_graph_nodes, align 8
  %160 = getelementptr inbounds %struct.Node* %159, i64 %158
  %161 = getelementptr inbounds %struct.Node* %160, i32 0, i32 0
  %162 = load i32* %161, align 4
  store i32 %162, i32* %i3, align 4
  br label %163

; <label>:163                                     ; preds = %207, %152
  %164 = load i32* %i3, align 4
  %165 = load i32* %tid, align 4
  %166 = sext i32 %165 to i64
  %167 = load %struct.Node** %h_graph_nodes, align 8
  %168 = getelementptr inbounds %struct.Node* %167, i64 %166
  %169 = getelementptr inbounds %struct.Node* %168, i32 0, i32 1
  %170 = load i32* %169, align 4
  %171 = load i32* %tid, align 4
  %172 = sext i32 %171 to i64
  %173 = load %struct.Node** %h_graph_nodes, align 8
  %174 = getelementptr inbounds %struct.Node* %173, i64 %172
  %175 = getelementptr inbounds %struct.Node* %174, i32 0, i32 0
  %176 = load i32* %175, align 4
  %177 = add nsw i32 %170, %176
  %178 = icmp slt i32 %164, %177
  br i1 %178, label %179, label %210

; <label>:179                                     ; preds = %163
  %180 = load i32* %i3, align 4
  %181 = sext i32 %180 to i64
  %182 = load i32** %h_graph_edges, align 8
  %183 = getelementptr inbounds i32* %182, i64 %181
  %184 = load i32* %183, align 4
  store i32 %184, i32* %id4, align 4
  %185 = load i32* %id4, align 4
  %186 = sext i32 %185 to i64
  %187 = load i8** %h_graph_visited, align 8
  %188 = getelementptr inbounds i8* %187, i64 %186
  %189 = load i8* %188, align 1
  %190 = trunc i8 %189 to i1
  br i1 %190, label %206, label %191

; <label>:191                                     ; preds = %179
  %192 = load i32* %tid, align 4
  %193 = sext i32 %192 to i64
  %194 = load i32** %h_cost, align 8
  %195 = getelementptr inbounds i32* %194, i64 %193
  %196 = load i32* %195, align 4
  %197 = add nsw i32 %196, 1
  %198 = load i32* %id4, align 4
  %199 = sext i32 %198 to i64
  %200 = load i32** %h_cost, align 8
  %201 = getelementptr inbounds i32* %200, i64 %199
  store i32 %197, i32* %201, align 4
  %202 = load i32* %id4, align 4
  %203 = sext i32 %202 to i64
  %204 = load i8** %h_updating_graph_mask, align 8
  %205 = getelementptr inbounds i8* %204, i64 %203
  store i8 1, i8* %205, align 1
  br label %206

; <label>:206                                     ; preds = %191, %179
  br label %207

; <label>:207                                     ; preds = %206
  %208 = load i32* %i3, align 4
  %209 = add nsw i32 %208, 1
  store i32 %209, i32* %i3, align 4
  br label %163

; <label>:210                                     ; preds = %163
  br label %211

; <label>:211                                     ; preds = %210, %143
  br label %212

; <label>:212                                     ; preds = %211
  %213 = load i32* %tid, align 4
  %214 = add nsw i32 %213, 1
  store i32 %214, i32* %tid, align 4
  br label %139

; <label>:215                                     ; preds = %139
  store i32 0, i32* %tid5, align 4
  br label %216

; <label>:216                                     ; preds = %243, %215
  %217 = load i32* %tid5, align 4
  %218 = load i32* %no_of_nodes, align 4
  %219 = icmp slt i32 %217, %218
  br i1 %219, label %220, label %246

; <label>:220                                     ; preds = %216
  %221 = load i32* %tid5, align 4
  %222 = sext i32 %221 to i64
  %223 = load i8** %h_updating_graph_mask, align 8
  %224 = getelementptr inbounds i8* %223, i64 %222
  %225 = load i8* %224, align 1
  %226 = trunc i8 %225 to i1
  %227 = zext i1 %226 to i32
  %228 = icmp eq i32 %227, 1
  br i1 %228, label %229, label %242

; <label>:229                                     ; preds = %220
  %230 = load i32* %tid5, align 4
  %231 = sext i32 %230 to i64
  %232 = load i8** %h_graph_mask, align 8
  %233 = getelementptr inbounds i8* %232, i64 %231
  store i8 1, i8* %233, align 1
  %234 = load i32* %tid5, align 4
  %235 = sext i32 %234 to i64
  %236 = load i8** %h_graph_visited, align 8
  %237 = getelementptr inbounds i8* %236, i64 %235
  store i8 1, i8* %237, align 1
  store i8 1, i8* %stop, align 1
  %238 = load i32* %tid5, align 4
  %239 = sext i32 %238 to i64
  %240 = load i8** %h_updating_graph_mask, align 8
  %241 = getelementptr inbounds i8* %240, i64 %239
  store i8 0, i8* %241, align 1
  br label %242

; <label>:242                                     ; preds = %229, %220
  br label %243

; <label>:243                                     ; preds = %242
  %244 = load i32* %tid5, align 4
  %245 = add nsw i32 %244, 1
  store i32 %245, i32* %tid5, align 4
  br label %216

; <label>:246                                     ; preds = %216
  %247 = load i32* %k, align 4
  %248 = add nsw i32 %247, 1
  store i32 %248, i32* %k, align 4
  br label %249

; <label>:249                                     ; preds = %246
  %250 = load i8* %stop, align 1
  %251 = trunc i8 %250 to i1
  br i1 %251, label %138, label %252

; <label>:252                                     ; preds = %249
  %253 = call %struct._IO_FILE* @fopen(i8* getelementptr inbounds ([11 x i8]* @.str7, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8]* @.str8, i32 0, i32 0))
  store %struct._IO_FILE* %253, %struct._IO_FILE** %fpo, align 8
  store i32 0, i32* %i6, align 4
  br label %254

; <label>:254                                     ; preds = %267, %252
  %255 = load i32* %i6, align 4
  %256 = load i32* %no_of_nodes, align 4
  %257 = icmp slt i32 %255, %256
  br i1 %257, label %258, label %270

; <label>:258                                     ; preds = %254
  %259 = load %struct._IO_FILE** %fpo, align 8
  %260 = load i32* %i6, align 4
  %261 = load i32* %i6, align 4
  %262 = sext i32 %261 to i64
  %263 = load i32** %h_cost, align 8
  %264 = getelementptr inbounds i32* %263, i64 %262
  %265 = load i32* %264, align 4
  %266 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %259, i8* getelementptr inbounds ([13 x i8]* @.str9, i32 0, i32 0), i32 %260, i32 %265)
  br label %267

; <label>:267                                     ; preds = %258
  %268 = load i32* %i6, align 4
  %269 = add nsw i32 %268, 1
  store i32 %269, i32* %i6, align 4
  br label %254

; <label>:270                                     ; preds = %254
  %271 = load %struct._IO_FILE** %fpo, align 8
  %272 = call i32 @fclose(%struct._IO_FILE* %271)
  %273 = load %struct.Node** %h_graph_nodes, align 8
  %274 = bitcast %struct.Node* %273 to i8*
  call void @free(i8* %274) #5
  %275 = load i32** %h_graph_edges, align 8
  %276 = bitcast i32* %275 to i8*
  call void @free(i8* %276) #5
  %277 = load i8** %h_graph_mask, align 8
  call void @free(i8* %277) #5
  %278 = load i8** %h_updating_graph_mask, align 8
  call void @free(i8* %278) #5
  %279 = load i8** %h_graph_visited, align 8
  call void @free(i8* %279) #5
  %280 = load i32** %h_cost, align 8
  %281 = bitcast i32* %280 to i8*
  call void @free(i8* %281) #5
  br label %282

; <label>:282                                     ; preds = %270, %17
  ret void
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
