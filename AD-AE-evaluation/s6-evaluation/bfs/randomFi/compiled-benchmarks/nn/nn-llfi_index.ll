; ModuleID = '/home/yafan/gitlab/optimizing-selective-protection-yafan/yafan-benchmarks/nn.ll'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }
%struct.neighbor = type { [49 x i8], double }

@stderr = external global %struct._IO_FILE*
@.str = private unnamed_addr constant [26 x i8] c"Invalid set of arguments\0A\00", align 1
@.str1 = private unnamed_addr constant [2 x i8] c"r\00", align 1
@.str2 = private unnamed_addr constant [21 x i8] c"error opening flist\0A\00", align 1
@.str3 = private unnamed_addr constant [23 x i8] c"no room for neighbors\0A\00", align 1
@.str4 = private unnamed_addr constant [4 x i8] c"%s\0A\00", align 1
@.str5 = private unnamed_addr constant [24 x i8] c"error reading filelist\0A\00", align 1
@.str6 = private unnamed_addr constant [20 x i8] c"error opening a db\0A\00", align 1
@.str7 = private unnamed_addr constant [6 x i8] c"Error\00", align 1
@.str8 = private unnamed_addr constant [6 x i8] c"%f %f\00", align 1
@.str9 = private unnamed_addr constant [11 x i8] c"output.txt\00", align 1
@.str10 = private unnamed_addr constant [2 x i8] c"w\00", align 1
@.str11 = private unnamed_addr constant [31 x i8] c"The %d nearest neighbors are:\0A\00", align 1
@.str12 = private unnamed_addr constant [11 x i8] c"%s --> %f\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  %1 = alloca i32, align 4, !llfi_index !1
  %2 = alloca i32, align 4, !llfi_index !2
  %3 = alloca i8**, align 8, !llfi_index !3
  %flist = alloca %struct._IO_FILE*, align 8, !llfi_index !4
  %fp = alloca %struct._IO_FILE*, align 8, !llfi_index !5
  %i = alloca i32, align 4, !llfi_index !6
  %j = alloca i32, align 4, !llfi_index !7
  %k = alloca i32, align 4, !llfi_index !8
  %rec_count = alloca i32, align 4, !llfi_index !9
  %done = alloca i32, align 4, !llfi_index !10
  %sandbox = alloca [490 x i8], align 16, !llfi_index !11
  %rec_iter = alloca i8*, align 8, !llfi_index !12
  %dbname = alloca [64 x i8], align 16, !llfi_index !13
  %neighbors = alloca %struct.neighbor*, align 8, !llfi_index !14
  %target_lat = alloca float, align 4, !llfi_index !15
  %target_long = alloca float, align 4, !llfi_index !16
  %tmp_lat = alloca float, align 4, !llfi_index !17
  %tmp_long = alloca float, align 4, !llfi_index !18
  %z = alloca float*, align 8, !llfi_index !19
  %max_dist = alloca float, align 4, !llfi_index !20
  %max_idx = alloca i32, align 4, !llfi_index !21
  %out = alloca %struct._IO_FILE*, align 8, !llfi_index !22
  store i32 0, i32* %1, !llfi_index !23
  store i32 %argc, i32* %2, align 4, !llfi_index !24
  store i8** %argv, i8*** %3, align 8, !llfi_index !25
  store i32 0, i32* %i, align 4, !llfi_index !26
  store i32 0, i32* %j, align 4, !llfi_index !27
  store i32 0, i32* %k, align 4, !llfi_index !28
  store i32 0, i32* %rec_count, align 4, !llfi_index !29
  store i32 0, i32* %done, align 4, !llfi_index !30
  store %struct.neighbor* null, %struct.neighbor** %neighbors, align 8, !llfi_index !31
  store float 0.000000e+00, float* %tmp_lat, align 4, !llfi_index !32
  store float 0.000000e+00, float* %tmp_long, align 4, !llfi_index !33
  %4 = load i32* %2, align 4, !llfi_index !34
  %5 = icmp slt i32 %4, 5, !llfi_index !35
  br i1 %5, label %6, label %9, !llfi_index !36

; <label>:6                                       ; preds = %0
  %7 = load %struct._IO_FILE** @stderr, align 8, !llfi_index !37
  %8 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %7, i8* getelementptr inbounds ([26 x i8]* @.str, i32 0, i32 0)), !llfi_index !38
  call void @exit(i32 -1) #5, !llfi_index !39
  unreachable, !llfi_index !40

; <label>:9                                       ; preds = %0
  %10 = load i8*** %3, align 8, !llfi_index !41
  %11 = getelementptr inbounds i8** %10, i64 1, !llfi_index !42
  %12 = load i8** %11, align 8, !llfi_index !43
  %13 = call %struct._IO_FILE* @fopen(i8* %12, i8* getelementptr inbounds ([2 x i8]* @.str1, i32 0, i32 0)), !llfi_index !44
  store %struct._IO_FILE* %13, %struct._IO_FILE** %flist, align 8, !llfi_index !45
  %14 = load %struct._IO_FILE** %flist, align 8, !llfi_index !46
  %15 = icmp ne %struct._IO_FILE* %14, null, !llfi_index !47
  br i1 %15, label %18, label %16, !llfi_index !48

; <label>:16                                      ; preds = %9
  %17 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str2, i32 0, i32 0)), !llfi_index !49
  call void @exit(i32 1) #5, !llfi_index !50
  unreachable, !llfi_index !51

; <label>:18                                      ; preds = %9
  %19 = load i8*** %3, align 8, !llfi_index !52
  %20 = getelementptr inbounds i8** %19, i64 2, !llfi_index !53
  %21 = load i8** %20, align 8, !llfi_index !54
  %22 = call i32 @atoi(i8* %21) #6, !llfi_index !55
  store i32 %22, i32* %k, align 4, !llfi_index !56
  %23 = load i8*** %3, align 8, !llfi_index !57
  %24 = getelementptr inbounds i8** %23, i64 3, !llfi_index !58
  %25 = load i8** %24, align 8, !llfi_index !59
  %26 = call double @atof(i8* %25) #6, !llfi_index !60
  %27 = fptrunc double %26 to float, !llfi_index !61
  store float %27, float* %target_lat, align 4, !llfi_index !62
  %28 = load i8*** %3, align 8, !llfi_index !63
  %29 = getelementptr inbounds i8** %28, i64 4, !llfi_index !64
  %30 = load i8** %29, align 8, !llfi_index !65
  %31 = call double @atof(i8* %30) #6, !llfi_index !66
  %32 = fptrunc double %31 to float, !llfi_index !67
  store float %32, float* %target_long, align 4, !llfi_index !68
  %33 = load i32* %k, align 4, !llfi_index !69
  %34 = sext i32 %33 to i64, !llfi_index !70
  %35 = mul i64 %34, 64, !llfi_index !71
  %36 = call noalias i8* @malloc(i64 %35) #7, !llfi_index !72
  %37 = bitcast i8* %36 to %struct.neighbor*, !llfi_index !73
  store %struct.neighbor* %37, %struct.neighbor** %neighbors, align 8, !llfi_index !74
  %38 = load %struct.neighbor** %neighbors, align 8, !llfi_index !75
  %39 = icmp eq %struct.neighbor* %38, null, !llfi_index !76
  br i1 %39, label %40, label %43, !llfi_index !77

; <label>:40                                      ; preds = %18
  %41 = load %struct._IO_FILE** @stderr, align 8, !llfi_index !78
  %42 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %41, i8* getelementptr inbounds ([23 x i8]* @.str3, i32 0, i32 0)), !llfi_index !79
  call void @exit(i32 0) #5, !llfi_index !80
  unreachable, !llfi_index !81

; <label>:43                                      ; preds = %18
  store i32 0, i32* %j, align 4, !llfi_index !82
  br label %44, !llfi_index !83

; <label>:44                                      ; preds = %54, %43
  %45 = load i32* %j, align 4, !llfi_index !84
  %46 = load i32* %k, align 4, !llfi_index !85
  %47 = icmp slt i32 %45, %46, !llfi_index !86
  br i1 %47, label %48, label %57, !llfi_index !87

; <label>:48                                      ; preds = %44
  %49 = load i32* %j, align 4, !llfi_index !88
  %50 = sext i32 %49 to i64, !llfi_index !89
  %51 = load %struct.neighbor** %neighbors, align 8, !llfi_index !90
  %52 = getelementptr inbounds %struct.neighbor* %51, i64 %50, !llfi_index !91
  %53 = getelementptr inbounds %struct.neighbor* %52, i32 0, i32 1, !llfi_index !92
  store double 1.000000e+04, double* %53, align 8, !llfi_index !93
  br label %54, !llfi_index !94

; <label>:54                                      ; preds = %48
  %55 = load i32* %j, align 4, !llfi_index !95
  %56 = add nsw i32 %55, 1, !llfi_index !96
  store i32 %56, i32* %j, align 4, !llfi_index !97
  br label %44, !llfi_index !98

; <label>:57                                      ; preds = %44
  %58 = load %struct._IO_FILE** %flist, align 8, !llfi_index !99
  %59 = getelementptr inbounds [64 x i8]* %dbname, i32 0, i32 0, !llfi_index !100
  %60 = call i32 (%struct._IO_FILE*, i8*, ...)* @__isoc99_fscanf(%struct._IO_FILE* %58, i8* getelementptr inbounds ([4 x i8]* @.str4, i32 0, i32 0), i8* %59), !llfi_index !101
  %61 = icmp ne i32 %60, 1, !llfi_index !102
  br i1 %61, label %62, label %65, !llfi_index !103

; <label>:62                                      ; preds = %57
  %63 = load %struct._IO_FILE** @stderr, align 8, !llfi_index !104
  %64 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %63, i8* getelementptr inbounds ([24 x i8]* @.str5, i32 0, i32 0)), !llfi_index !105
  call void @exit(i32 0) #5, !llfi_index !106
  unreachable, !llfi_index !107

; <label>:65                                      ; preds = %57
  %66 = getelementptr inbounds [64 x i8]* %dbname, i32 0, i32 0, !llfi_index !108
  %67 = call %struct._IO_FILE* @fopen(i8* %66, i8* getelementptr inbounds ([2 x i8]* @.str1, i32 0, i32 0)), !llfi_index !109
  store %struct._IO_FILE* %67, %struct._IO_FILE** %fp, align 8, !llfi_index !110
  %68 = load %struct._IO_FILE** %fp, align 8, !llfi_index !111
  %69 = icmp ne %struct._IO_FILE* %68, null, !llfi_index !112
  br i1 %69, label %72, label %70, !llfi_index !113

; <label>:70                                      ; preds = %65
  %71 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str2, i32 0, i32 0)), !llfi_index !114
  call void @exit(i32 1) #5, !llfi_index !115
  unreachable, !llfi_index !116

; <label>:72                                      ; preds = %65
  %73 = call noalias i8* @malloc(i64 40) #7, !llfi_index !117
  %74 = bitcast i8* %73 to float*, !llfi_index !118
  store float* %74, float** %z, align 8, !llfi_index !119
  br label %75, !llfi_index !120

; <label>:75                                      ; preds = %237, %72
  %76 = load i32* %done, align 4, !llfi_index !121
  %77 = icmp ne i32 %76, 0, !llfi_index !122
  %78 = xor i1 %77, true, !llfi_index !123
  br i1 %78, label %79, label %238, !llfi_index !124

; <label>:79                                      ; preds = %75
  %80 = getelementptr inbounds [490 x i8]* %sandbox, i32 0, i32 0, !llfi_index !125
  %81 = load %struct._IO_FILE** %fp, align 8, !llfi_index !126
  %82 = call i64 @fread(i8* %80, i64 49, i64 10, %struct._IO_FILE* %81), !llfi_index !127
  %83 = trunc i64 %82 to i32, !llfi_index !128
  store i32 %83, i32* %rec_count, align 4, !llfi_index !129
  %84 = load i32* %rec_count, align 4, !llfi_index !130
  %85 = icmp ne i32 %84, 10, !llfi_index !131
  br i1 %85, label %86, label %116, !llfi_index !132

; <label>:86                                      ; preds = %79
  %87 = load %struct._IO_FILE** %flist, align 8, !llfi_index !133
  %88 = call i32 @ferror(%struct._IO_FILE* %87) #7, !llfi_index !134
  %89 = icmp ne i32 %88, 0, !llfi_index !135
  br i1 %89, label %114, label %90, !llfi_index !136

; <label>:90                                      ; preds = %86
  %91 = load %struct._IO_FILE** %fp, align 8, !llfi_index !137
  %92 = call i32 @fclose(%struct._IO_FILE* %91), !llfi_index !138
  %93 = load %struct._IO_FILE** %flist, align 8, !llfi_index !139
  %94 = call i32 @feof(%struct._IO_FILE* %93) #7, !llfi_index !140
  %95 = icmp ne i32 %94, 0, !llfi_index !141
  br i1 %95, label %96, label %97, !llfi_index !142

; <label>:96                                      ; preds = %90
  store i32 1, i32* %done, align 4, !llfi_index !143
  br label %113, !llfi_index !144

; <label>:97                                      ; preds = %90
  %98 = load %struct._IO_FILE** %flist, align 8, !llfi_index !145
  %99 = getelementptr inbounds [64 x i8]* %dbname, i32 0, i32 0, !llfi_index !146
  %100 = call i32 (%struct._IO_FILE*, i8*, ...)* @__isoc99_fscanf(%struct._IO_FILE* %98, i8* getelementptr inbounds ([4 x i8]* @.str4, i32 0, i32 0), i8* %99), !llfi_index !147
  %101 = icmp ne i32 %100, 1, !llfi_index !148
  br i1 %101, label %102, label %105, !llfi_index !149

; <label>:102                                     ; preds = %97
  %103 = load %struct._IO_FILE** @stderr, align 8, !llfi_index !150
  %104 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %103, i8* getelementptr inbounds ([24 x i8]* @.str5, i32 0, i32 0)), !llfi_index !151
  call void @exit(i32 0) #5, !llfi_index !152
  unreachable, !llfi_index !153

; <label>:105                                     ; preds = %97
  %106 = getelementptr inbounds [64 x i8]* %dbname, i32 0, i32 0, !llfi_index !154
  %107 = call %struct._IO_FILE* @fopen(i8* %106, i8* getelementptr inbounds ([2 x i8]* @.str1, i32 0, i32 0)), !llfi_index !155
  store %struct._IO_FILE* %107, %struct._IO_FILE** %fp, align 8, !llfi_index !156
  %108 = load %struct._IO_FILE** %fp, align 8, !llfi_index !157
  %109 = icmp ne %struct._IO_FILE* %108, null, !llfi_index !158
  br i1 %109, label %112, label %110, !llfi_index !159

; <label>:110                                     ; preds = %105
  %111 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([20 x i8]* @.str6, i32 0, i32 0)), !llfi_index !160
  call void @exit(i32 1) #5, !llfi_index !161
  unreachable, !llfi_index !162

; <label>:112                                     ; preds = %105
  br label %113, !llfi_index !163

; <label>:113                                     ; preds = %112, %96
  br label %115, !llfi_index !164

; <label>:114                                     ; preds = %86
  call void @perror(i8* getelementptr inbounds ([6 x i8]* @.str7, i32 0, i32 0)), !llfi_index !165
  call void @exit(i32 0) #5, !llfi_index !166
  unreachable, !llfi_index !167

; <label>:115                                     ; preds = %113
  br label %116, !llfi_index !168

; <label>:116                                     ; preds = %115, %79
  store i32 0, i32* %i, align 4, !llfi_index !169
  br label %117, !llfi_index !170

; <label>:117                                     ; preds = %153, %116
  %118 = load i32* %i, align 4, !llfi_index !171
  %119 = load i32* %rec_count, align 4, !llfi_index !172
  %120 = icmp slt i32 %118, %119, !llfi_index !173
  br i1 %120, label %121, label %156, !llfi_index !174

; <label>:121                                     ; preds = %117
  %122 = getelementptr inbounds [490 x i8]* %sandbox, i32 0, i32 0, !llfi_index !175
  %123 = load i32* %i, align 4, !llfi_index !176
  %124 = mul nsw i32 %123, 49, !llfi_index !177
  %125 = add nsw i32 %124, 28, !llfi_index !178
  %126 = sub nsw i32 %125, 1, !llfi_index !179
  %127 = sext i32 %126 to i64, !llfi_index !180
  %128 = getelementptr inbounds i8* %122, i64 %127, !llfi_index !181
  store i8* %128, i8** %rec_iter, align 8, !llfi_index !182
  %129 = load i8** %rec_iter, align 8, !llfi_index !183
  %130 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* %129, i8* getelementptr inbounds ([6 x i8]* @.str8, i32 0, i32 0), float* %tmp_lat, float* %tmp_long) #7, !llfi_index !184
  %131 = load float* %tmp_lat, align 4, !llfi_index !185
  %132 = load float* %target_lat, align 4, !llfi_index !186
  %133 = fsub float %131, %132, !llfi_index !187
  %134 = load float* %tmp_lat, align 4, !llfi_index !188
  %135 = load float* %target_lat, align 4, !llfi_index !189
  %136 = fsub float %134, %135, !llfi_index !190
  %137 = fmul float %133, %136, !llfi_index !191
  %138 = load float* %tmp_long, align 4, !llfi_index !192
  %139 = load float* %target_long, align 4, !llfi_index !193
  %140 = fsub float %138, %139, !llfi_index !194
  %141 = load float* %tmp_long, align 4, !llfi_index !195
  %142 = load float* %target_long, align 4, !llfi_index !196
  %143 = fsub float %141, %142, !llfi_index !197
  %144 = fmul float %140, %143, !llfi_index !198
  %145 = fadd float %137, %144, !llfi_index !199
  %146 = fpext float %145 to double, !llfi_index !200
  %147 = call double @sqrt(double %146) #7, !llfi_index !201
  %148 = fptrunc double %147 to float, !llfi_index !202
  %149 = load i32* %i, align 4, !llfi_index !203
  %150 = sext i32 %149 to i64, !llfi_index !204
  %151 = load float** %z, align 8, !llfi_index !205
  %152 = getelementptr inbounds float* %151, i64 %150, !llfi_index !206
  store float %148, float* %152, align 4, !llfi_index !207
  br label %153, !llfi_index !208

; <label>:153                                     ; preds = %121
  %154 = load i32* %i, align 4, !llfi_index !209
  %155 = add nsw i32 %154, 1, !llfi_index !210
  store i32 %155, i32* %i, align 4, !llfi_index !211
  br label %117, !llfi_index !212

; <label>:156                                     ; preds = %117
  store i32 0, i32* %i, align 4, !llfi_index !213
  br label %157, !llfi_index !214

; <label>:157                                     ; preds = %234, %156
  %158 = load i32* %i, align 4, !llfi_index !215
  %159 = load i32* %rec_count, align 4, !llfi_index !216
  %160 = icmp slt i32 %158, %159, !llfi_index !217
  br i1 %160, label %161, label %237, !llfi_index !218

; <label>:161                                     ; preds = %157
  store float -1.000000e+00, float* %max_dist, align 4, !llfi_index !219
  store i32 0, i32* %max_idx, align 4, !llfi_index !220
  store i32 0, i32* %j, align 4, !llfi_index !221
  br label %162, !llfi_index !222

; <label>:162                                     ; preds = %186, %161
  %163 = load i32* %j, align 4, !llfi_index !223
  %164 = load i32* %k, align 4, !llfi_index !224
  %165 = icmp slt i32 %163, %164, !llfi_index !225
  br i1 %165, label %166, label %189, !llfi_index !226

; <label>:166                                     ; preds = %162
  %167 = load i32* %j, align 4, !llfi_index !227
  %168 = sext i32 %167 to i64, !llfi_index !228
  %169 = load %struct.neighbor** %neighbors, align 8, !llfi_index !229
  %170 = getelementptr inbounds %struct.neighbor* %169, i64 %168, !llfi_index !230
  %171 = getelementptr inbounds %struct.neighbor* %170, i32 0, i32 1, !llfi_index !231
  %172 = load double* %171, align 8, !llfi_index !232
  %173 = load float* %max_dist, align 4, !llfi_index !233
  %174 = fpext float %173 to double, !llfi_index !234
  %175 = fcmp ogt double %172, %174, !llfi_index !235
  br i1 %175, label %176, label %185, !llfi_index !236

; <label>:176                                     ; preds = %166
  %177 = load i32* %j, align 4, !llfi_index !237
  %178 = sext i32 %177 to i64, !llfi_index !238
  %179 = load %struct.neighbor** %neighbors, align 8, !llfi_index !239
  %180 = getelementptr inbounds %struct.neighbor* %179, i64 %178, !llfi_index !240
  %181 = getelementptr inbounds %struct.neighbor* %180, i32 0, i32 1, !llfi_index !241
  %182 = load double* %181, align 8, !llfi_index !242
  %183 = fptrunc double %182 to float, !llfi_index !243
  store float %183, float* %max_dist, align 4, !llfi_index !244
  %184 = load i32* %j, align 4, !llfi_index !245
  store i32 %184, i32* %max_idx, align 4, !llfi_index !246
  br label %185, !llfi_index !247

; <label>:185                                     ; preds = %176, %166
  br label %186, !llfi_index !248

; <label>:186                                     ; preds = %185
  %187 = load i32* %j, align 4, !llfi_index !249
  %188 = add nsw i32 %187, 1, !llfi_index !250
  store i32 %188, i32* %j, align 4, !llfi_index !251
  br label %162, !llfi_index !252

; <label>:189                                     ; preds = %162
  %190 = load i32* %i, align 4, !llfi_index !253
  %191 = sext i32 %190 to i64, !llfi_index !254
  %192 = load float** %z, align 8, !llfi_index !255
  %193 = getelementptr inbounds float* %192, i64 %191, !llfi_index !256
  %194 = load float* %193, align 4, !llfi_index !257
  %195 = fpext float %194 to double, !llfi_index !258
  %196 = load i32* %max_idx, align 4, !llfi_index !259
  %197 = sext i32 %196 to i64, !llfi_index !260
  %198 = load %struct.neighbor** %neighbors, align 8, !llfi_index !261
  %199 = getelementptr inbounds %struct.neighbor* %198, i64 %197, !llfi_index !262
  %200 = getelementptr inbounds %struct.neighbor* %199, i32 0, i32 1, !llfi_index !263
  %201 = load double* %200, align 8, !llfi_index !264
  %202 = fcmp olt double %195, %201, !llfi_index !265
  br i1 %202, label %203, label %233, !llfi_index !266

; <label>:203                                     ; preds = %189
  %204 = load i32* %i, align 4, !llfi_index !267
  %205 = add nsw i32 %204, 1, !llfi_index !268
  %206 = mul nsw i32 %205, 49, !llfi_index !269
  %207 = sub nsw i32 %206, 1, !llfi_index !270
  %208 = sext i32 %207 to i64, !llfi_index !271
  %209 = getelementptr inbounds [490 x i8]* %sandbox, i32 0, i64 %208, !llfi_index !272
  store i8 0, i8* %209, align 1, !llfi_index !273
  %210 = load i32* %max_idx, align 4, !llfi_index !274
  %211 = sext i32 %210 to i64, !llfi_index !275
  %212 = load %struct.neighbor** %neighbors, align 8, !llfi_index !276
  %213 = getelementptr inbounds %struct.neighbor* %212, i64 %211, !llfi_index !277
  %214 = getelementptr inbounds %struct.neighbor* %213, i32 0, i32 0, !llfi_index !278
  %215 = getelementptr inbounds [49 x i8]* %214, i32 0, i32 0, !llfi_index !279
  %216 = getelementptr inbounds [490 x i8]* %sandbox, i32 0, i32 0, !llfi_index !280
  %217 = load i32* %i, align 4, !llfi_index !281
  %218 = mul nsw i32 %217, 49, !llfi_index !282
  %219 = sext i32 %218 to i64, !llfi_index !283
  %220 = getelementptr inbounds i8* %216, i64 %219, !llfi_index !284
  %221 = call i8* @strcpy(i8* %215, i8* %220) #7, !llfi_index !285
  %222 = load i32* %i, align 4, !llfi_index !286
  %223 = sext i32 %222 to i64, !llfi_index !287
  %224 = load float** %z, align 8, !llfi_index !288
  %225 = getelementptr inbounds float* %224, i64 %223, !llfi_index !289
  %226 = load float* %225, align 4, !llfi_index !290
  %227 = fpext float %226 to double, !llfi_index !291
  %228 = load i32* %max_idx, align 4, !llfi_index !292
  %229 = sext i32 %228 to i64, !llfi_index !293
  %230 = load %struct.neighbor** %neighbors, align 8, !llfi_index !294
  %231 = getelementptr inbounds %struct.neighbor* %230, i64 %229, !llfi_index !295
  %232 = getelementptr inbounds %struct.neighbor* %231, i32 0, i32 1, !llfi_index !296
  store double %227, double* %232, align 8, !llfi_index !297
  br label %233, !llfi_index !298

; <label>:233                                     ; preds = %203, %189
  br label %234, !llfi_index !299

; <label>:234                                     ; preds = %233
  %235 = load i32* %i, align 4, !llfi_index !300
  %236 = add nsw i32 %235, 1, !llfi_index !301
  store i32 %236, i32* %i, align 4, !llfi_index !302
  br label %157, !llfi_index !303

; <label>:237                                     ; preds = %157
  br label %75, !llfi_index !304

; <label>:238                                     ; preds = %75
  %239 = call %struct._IO_FILE* @fopen(i8* getelementptr inbounds ([11 x i8]* @.str9, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8]* @.str10, i32 0, i32 0)), !llfi_index !305
  store %struct._IO_FILE* %239, %struct._IO_FILE** %out, align 8, !llfi_index !306
  %240 = load %struct._IO_FILE** %out, align 8, !llfi_index !307
  %241 = load i32* %k, align 4, !llfi_index !308
  %242 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %240, i8* getelementptr inbounds ([31 x i8]* @.str11, i32 0, i32 0), i32 %241), !llfi_index !309
  %243 = load i32* %k, align 4, !llfi_index !310
  %244 = sub nsw i32 %243, 1, !llfi_index !311
  store i32 %244, i32* %j, align 4, !llfi_index !312
  br label %245, !llfi_index !313

; <label>:245                                     ; preds = %272, %238
  %246 = load i32* %j, align 4, !llfi_index !314
  %247 = icmp sge i32 %246, 0, !llfi_index !315
  br i1 %247, label %248, label %275, !llfi_index !316

; <label>:248                                     ; preds = %245
  %249 = load i32* %j, align 4, !llfi_index !317
  %250 = sext i32 %249 to i64, !llfi_index !318
  %251 = load %struct.neighbor** %neighbors, align 8, !llfi_index !319
  %252 = getelementptr inbounds %struct.neighbor* %251, i64 %250, !llfi_index !320
  %253 = getelementptr inbounds %struct.neighbor* %252, i32 0, i32 1, !llfi_index !321
  %254 = load double* %253, align 8, !llfi_index !322
  %255 = fcmp oeq double %254, 1.000000e+04, !llfi_index !323
  br i1 %255, label %271, label %256, !llfi_index !324

; <label>:256                                     ; preds = %248
  %257 = load %struct._IO_FILE** %out, align 8, !llfi_index !325
  %258 = load i32* %j, align 4, !llfi_index !326
  %259 = sext i32 %258 to i64, !llfi_index !327
  %260 = load %struct.neighbor** %neighbors, align 8, !llfi_index !328
  %261 = getelementptr inbounds %struct.neighbor* %260, i64 %259, !llfi_index !329
  %262 = getelementptr inbounds %struct.neighbor* %261, i32 0, i32 0, !llfi_index !330
  %263 = getelementptr inbounds [49 x i8]* %262, i32 0, i32 0, !llfi_index !331
  %264 = load i32* %j, align 4, !llfi_index !332
  %265 = sext i32 %264 to i64, !llfi_index !333
  %266 = load %struct.neighbor** %neighbors, align 8, !llfi_index !334
  %267 = getelementptr inbounds %struct.neighbor* %266, i64 %265, !llfi_index !335
  %268 = getelementptr inbounds %struct.neighbor* %267, i32 0, i32 1, !llfi_index !336
  %269 = load double* %268, align 8, !llfi_index !337
  %270 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %257, i8* getelementptr inbounds ([11 x i8]* @.str12, i32 0, i32 0), i8* %263, double %269), !llfi_index !338
  br label %271, !llfi_index !339

; <label>:271                                     ; preds = %256, %248
  br label %272, !llfi_index !340

; <label>:272                                     ; preds = %271
  %273 = load i32* %j, align 4, !llfi_index !341
  %274 = add nsw i32 %273, -1, !llfi_index !342
  store i32 %274, i32* %j, align 4, !llfi_index !343
  br label %245, !llfi_index !344

; <label>:275                                     ; preds = %245
  %276 = load %struct._IO_FILE** %out, align 8, !llfi_index !345
  %277 = call i32 @fclose(%struct._IO_FILE* %276), !llfi_index !346
  %278 = load %struct._IO_FILE** %flist, align 8, !llfi_index !347
  %279 = call i32 @fclose(%struct._IO_FILE* %278), !llfi_index !348
  ret i32 0, !llfi_index !349
}

declare i32 @fprintf(%struct._IO_FILE*, i8*, ...) #1

; Function Attrs: noreturn nounwind
declare void @exit(i32) #2

declare %struct._IO_FILE* @fopen(i8*, i8*) #1

declare i32 @printf(i8*, ...) #1

; Function Attrs: nounwind readonly
declare i32 @atoi(i8*) #3

; Function Attrs: nounwind readonly
declare double @atof(i8*) #3

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #4

declare i32 @__isoc99_fscanf(%struct._IO_FILE*, i8*, ...) #1

declare i64 @fread(i8*, i64, i64, %struct._IO_FILE*) #1

; Function Attrs: nounwind
declare i32 @ferror(%struct._IO_FILE*) #4

declare i32 @fclose(%struct._IO_FILE*) #1

; Function Attrs: nounwind
declare i32 @feof(%struct._IO_FILE*) #4

declare void @perror(i8*) #1

; Function Attrs: nounwind
declare i32 @__isoc99_sscanf(i8*, i8*, ...) #4

; Function Attrs: nounwind
declare double @sqrt(double) #4

; Function Attrs: nounwind
declare i8* @strcpy(i8*, i8*) #4

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn nounwind }
attributes #6 = { nounwind readonly }
attributes #7 = { nounwind }

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
