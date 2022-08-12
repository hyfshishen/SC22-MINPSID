; ModuleID = 'nn.c'
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
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %flist = alloca %struct._IO_FILE*, align 8
  %fp = alloca %struct._IO_FILE*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %rec_count = alloca i32, align 4
  %done = alloca i32, align 4
  %sandbox = alloca [490 x i8], align 16
  %rec_iter = alloca i8*, align 8
  %dbname = alloca [64 x i8], align 16
  %neighbors = alloca %struct.neighbor*, align 8
  %target_lat = alloca float, align 4
  %target_long = alloca float, align 4
  %tmp_lat = alloca float, align 4
  %tmp_long = alloca float, align 4
  %z = alloca float*, align 8
  %max_dist = alloca float, align 4
  %max_idx = alloca i32, align 4
  %out = alloca %struct._IO_FILE*, align 8
  store i32 0, i32* %1
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  store i32 0, i32* %i, align 4
  store i32 0, i32* %j, align 4
  store i32 0, i32* %k, align 4
  store i32 0, i32* %rec_count, align 4
  store i32 0, i32* %done, align 4
  store %struct.neighbor* null, %struct.neighbor** %neighbors, align 8
  store float 0.000000e+00, float* %tmp_lat, align 4
  store float 0.000000e+00, float* %tmp_long, align 4
  %4 = load i32* %2, align 4
  %5 = icmp slt i32 %4, 5
  br i1 %5, label %6, label %9

; <label>:6                                       ; preds = %0
  %7 = load %struct._IO_FILE** @stderr, align 8
  %8 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %7, i8* getelementptr inbounds ([26 x i8]* @.str, i32 0, i32 0))
  call void @exit(i32 -1) #5
  unreachable

; <label>:9                                       ; preds = %0
  %10 = load i8*** %3, align 8
  %11 = getelementptr inbounds i8** %10, i64 1
  %12 = load i8** %11, align 8
  %13 = call %struct._IO_FILE* @fopen(i8* %12, i8* getelementptr inbounds ([2 x i8]* @.str1, i32 0, i32 0))
  store %struct._IO_FILE* %13, %struct._IO_FILE** %flist, align 8
  %14 = load %struct._IO_FILE** %flist, align 8
  %15 = icmp ne %struct._IO_FILE* %14, null
  br i1 %15, label %18, label %16

; <label>:16                                      ; preds = %9
  %17 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str2, i32 0, i32 0))
  call void @exit(i32 1) #5
  unreachable

; <label>:18                                      ; preds = %9
  %19 = load i8*** %3, align 8
  %20 = getelementptr inbounds i8** %19, i64 2
  %21 = load i8** %20, align 8
  %22 = call i32 @atoi(i8* %21) #6
  store i32 %22, i32* %k, align 4
  %23 = load i8*** %3, align 8
  %24 = getelementptr inbounds i8** %23, i64 3
  %25 = load i8** %24, align 8
  %26 = call double @atof(i8* %25) #6
  %27 = fptrunc double %26 to float
  store float %27, float* %target_lat, align 4
  %28 = load i8*** %3, align 8
  %29 = getelementptr inbounds i8** %28, i64 4
  %30 = load i8** %29, align 8
  %31 = call double @atof(i8* %30) #6
  %32 = fptrunc double %31 to float
  store float %32, float* %target_long, align 4
  %33 = load i32* %k, align 4
  %34 = sext i32 %33 to i64
  %35 = mul i64 %34, 64
  %36 = call noalias i8* @malloc(i64 %35) #7
  %37 = bitcast i8* %36 to %struct.neighbor*
  store %struct.neighbor* %37, %struct.neighbor** %neighbors, align 8
  %38 = load %struct.neighbor** %neighbors, align 8
  %39 = icmp eq %struct.neighbor* %38, null
  br i1 %39, label %40, label %43

; <label>:40                                      ; preds = %18
  %41 = load %struct._IO_FILE** @stderr, align 8
  %42 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %41, i8* getelementptr inbounds ([23 x i8]* @.str3, i32 0, i32 0))
  call void @exit(i32 0) #5
  unreachable

; <label>:43                                      ; preds = %18
  store i32 0, i32* %j, align 4
  br label %44

; <label>:44                                      ; preds = %54, %43
  %45 = load i32* %j, align 4
  %46 = load i32* %k, align 4
  %47 = icmp slt i32 %45, %46
  br i1 %47, label %48, label %57

; <label>:48                                      ; preds = %44
  %49 = load i32* %j, align 4
  %50 = sext i32 %49 to i64
  %51 = load %struct.neighbor** %neighbors, align 8
  %52 = getelementptr inbounds %struct.neighbor* %51, i64 %50
  %53 = getelementptr inbounds %struct.neighbor* %52, i32 0, i32 1
  store double 1.000000e+04, double* %53, align 8
  br label %54

; <label>:54                                      ; preds = %48
  %55 = load i32* %j, align 4
  %56 = add nsw i32 %55, 1
  store i32 %56, i32* %j, align 4
  br label %44

; <label>:57                                      ; preds = %44
  %58 = load %struct._IO_FILE** %flist, align 8
  %59 = getelementptr inbounds [64 x i8]* %dbname, i32 0, i32 0
  %60 = call i32 (%struct._IO_FILE*, i8*, ...)* @__isoc99_fscanf(%struct._IO_FILE* %58, i8* getelementptr inbounds ([4 x i8]* @.str4, i32 0, i32 0), i8* %59)
  %61 = icmp ne i32 %60, 1
  br i1 %61, label %62, label %65

; <label>:62                                      ; preds = %57
  %63 = load %struct._IO_FILE** @stderr, align 8
  %64 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %63, i8* getelementptr inbounds ([24 x i8]* @.str5, i32 0, i32 0))
  call void @exit(i32 0) #5
  unreachable

; <label>:65                                      ; preds = %57
  %66 = getelementptr inbounds [64 x i8]* %dbname, i32 0, i32 0
  %67 = call %struct._IO_FILE* @fopen(i8* %66, i8* getelementptr inbounds ([2 x i8]* @.str1, i32 0, i32 0))
  store %struct._IO_FILE* %67, %struct._IO_FILE** %fp, align 8
  %68 = load %struct._IO_FILE** %fp, align 8
  %69 = icmp ne %struct._IO_FILE* %68, null
  br i1 %69, label %72, label %70

; <label>:70                                      ; preds = %65
  %71 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str2, i32 0, i32 0))
  call void @exit(i32 1) #5
  unreachable

; <label>:72                                      ; preds = %65
  %73 = call noalias i8* @malloc(i64 40) #7
  %74 = bitcast i8* %73 to float*
  store float* %74, float** %z, align 8
  br label %75

; <label>:75                                      ; preds = %237, %72
  %76 = load i32* %done, align 4
  %77 = icmp ne i32 %76, 0
  %78 = xor i1 %77, true
  br i1 %78, label %79, label %238

; <label>:79                                      ; preds = %75
  %80 = getelementptr inbounds [490 x i8]* %sandbox, i32 0, i32 0
  %81 = load %struct._IO_FILE** %fp, align 8
  %82 = call i64 @fread(i8* %80, i64 49, i64 10, %struct._IO_FILE* %81)
  %83 = trunc i64 %82 to i32
  store i32 %83, i32* %rec_count, align 4
  %84 = load i32* %rec_count, align 4
  %85 = icmp ne i32 %84, 10
  br i1 %85, label %86, label %116

; <label>:86                                      ; preds = %79
  %87 = load %struct._IO_FILE** %flist, align 8
  %88 = call i32 @ferror(%struct._IO_FILE* %87) #7
  %89 = icmp ne i32 %88, 0
  br i1 %89, label %114, label %90

; <label>:90                                      ; preds = %86
  %91 = load %struct._IO_FILE** %fp, align 8
  %92 = call i32 @fclose(%struct._IO_FILE* %91)
  %93 = load %struct._IO_FILE** %flist, align 8
  %94 = call i32 @feof(%struct._IO_FILE* %93) #7
  %95 = icmp ne i32 %94, 0
  br i1 %95, label %96, label %97

; <label>:96                                      ; preds = %90
  store i32 1, i32* %done, align 4
  br label %113

; <label>:97                                      ; preds = %90
  %98 = load %struct._IO_FILE** %flist, align 8
  %99 = getelementptr inbounds [64 x i8]* %dbname, i32 0, i32 0
  %100 = call i32 (%struct._IO_FILE*, i8*, ...)* @__isoc99_fscanf(%struct._IO_FILE* %98, i8* getelementptr inbounds ([4 x i8]* @.str4, i32 0, i32 0), i8* %99)
  %101 = icmp ne i32 %100, 1
  br i1 %101, label %102, label %105

; <label>:102                                     ; preds = %97
  %103 = load %struct._IO_FILE** @stderr, align 8
  %104 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %103, i8* getelementptr inbounds ([24 x i8]* @.str5, i32 0, i32 0))
  call void @exit(i32 0) #5
  unreachable

; <label>:105                                     ; preds = %97
  %106 = getelementptr inbounds [64 x i8]* %dbname, i32 0, i32 0
  %107 = call %struct._IO_FILE* @fopen(i8* %106, i8* getelementptr inbounds ([2 x i8]* @.str1, i32 0, i32 0))
  store %struct._IO_FILE* %107, %struct._IO_FILE** %fp, align 8
  %108 = load %struct._IO_FILE** %fp, align 8
  %109 = icmp ne %struct._IO_FILE* %108, null
  br i1 %109, label %112, label %110

; <label>:110                                     ; preds = %105
  %111 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([20 x i8]* @.str6, i32 0, i32 0))
  call void @exit(i32 1) #5
  unreachable

; <label>:112                                     ; preds = %105
  br label %113

; <label>:113                                     ; preds = %112, %96
  br label %115

; <label>:114                                     ; preds = %86
  call void @perror(i8* getelementptr inbounds ([6 x i8]* @.str7, i32 0, i32 0))
  call void @exit(i32 0) #5
  unreachable

; <label>:115                                     ; preds = %113
  br label %116

; <label>:116                                     ; preds = %115, %79
  store i32 0, i32* %i, align 4
  br label %117

; <label>:117                                     ; preds = %153, %116
  %118 = load i32* %i, align 4
  %119 = load i32* %rec_count, align 4
  %120 = icmp slt i32 %118, %119
  br i1 %120, label %121, label %156

; <label>:121                                     ; preds = %117
  %122 = getelementptr inbounds [490 x i8]* %sandbox, i32 0, i32 0
  %123 = load i32* %i, align 4
  %124 = mul nsw i32 %123, 49
  %125 = add nsw i32 %124, 28
  %126 = sub nsw i32 %125, 1
  %127 = sext i32 %126 to i64
  %128 = getelementptr inbounds i8* %122, i64 %127
  store i8* %128, i8** %rec_iter, align 8
  %129 = load i8** %rec_iter, align 8
  %130 = call i32 (i8*, i8*, ...)* @__isoc99_sscanf(i8* %129, i8* getelementptr inbounds ([6 x i8]* @.str8, i32 0, i32 0), float* %tmp_lat, float* %tmp_long) #7
  %131 = load float* %tmp_lat, align 4
  %132 = load float* %target_lat, align 4
  %133 = fsub float %131, %132
  %134 = load float* %tmp_lat, align 4
  %135 = load float* %target_lat, align 4
  %136 = fsub float %134, %135
  %137 = fmul float %133, %136
  %138 = load float* %tmp_long, align 4
  %139 = load float* %target_long, align 4
  %140 = fsub float %138, %139
  %141 = load float* %tmp_long, align 4
  %142 = load float* %target_long, align 4
  %143 = fsub float %141, %142
  %144 = fmul float %140, %143
  %145 = fadd float %137, %144
  %146 = fpext float %145 to double
  %147 = call double @sqrt(double %146) #7
  %148 = fptrunc double %147 to float
  %149 = load i32* %i, align 4
  %150 = sext i32 %149 to i64
  %151 = load float** %z, align 8
  %152 = getelementptr inbounds float* %151, i64 %150
  store float %148, float* %152, align 4
  br label %153

; <label>:153                                     ; preds = %121
  %154 = load i32* %i, align 4
  %155 = add nsw i32 %154, 1
  store i32 %155, i32* %i, align 4
  br label %117

; <label>:156                                     ; preds = %117
  store i32 0, i32* %i, align 4
  br label %157

; <label>:157                                     ; preds = %234, %156
  %158 = load i32* %i, align 4
  %159 = load i32* %rec_count, align 4
  %160 = icmp slt i32 %158, %159
  br i1 %160, label %161, label %237

; <label>:161                                     ; preds = %157
  store float -1.000000e+00, float* %max_dist, align 4
  store i32 0, i32* %max_idx, align 4
  store i32 0, i32* %j, align 4
  br label %162

; <label>:162                                     ; preds = %186, %161
  %163 = load i32* %j, align 4
  %164 = load i32* %k, align 4
  %165 = icmp slt i32 %163, %164
  br i1 %165, label %166, label %189

; <label>:166                                     ; preds = %162
  %167 = load i32* %j, align 4
  %168 = sext i32 %167 to i64
  %169 = load %struct.neighbor** %neighbors, align 8
  %170 = getelementptr inbounds %struct.neighbor* %169, i64 %168
  %171 = getelementptr inbounds %struct.neighbor* %170, i32 0, i32 1
  %172 = load double* %171, align 8
  %173 = load float* %max_dist, align 4
  %174 = fpext float %173 to double
  %175 = fcmp ogt double %172, %174
  br i1 %175, label %176, label %185

; <label>:176                                     ; preds = %166
  %177 = load i32* %j, align 4
  %178 = sext i32 %177 to i64
  %179 = load %struct.neighbor** %neighbors, align 8
  %180 = getelementptr inbounds %struct.neighbor* %179, i64 %178
  %181 = getelementptr inbounds %struct.neighbor* %180, i32 0, i32 1
  %182 = load double* %181, align 8
  %183 = fptrunc double %182 to float
  store float %183, float* %max_dist, align 4
  %184 = load i32* %j, align 4
  store i32 %184, i32* %max_idx, align 4
  br label %185

; <label>:185                                     ; preds = %176, %166
  br label %186

; <label>:186                                     ; preds = %185
  %187 = load i32* %j, align 4
  %188 = add nsw i32 %187, 1
  store i32 %188, i32* %j, align 4
  br label %162

; <label>:189                                     ; preds = %162
  %190 = load i32* %i, align 4
  %191 = sext i32 %190 to i64
  %192 = load float** %z, align 8
  %193 = getelementptr inbounds float* %192, i64 %191
  %194 = load float* %193, align 4
  %195 = fpext float %194 to double
  %196 = load i32* %max_idx, align 4
  %197 = sext i32 %196 to i64
  %198 = load %struct.neighbor** %neighbors, align 8
  %199 = getelementptr inbounds %struct.neighbor* %198, i64 %197
  %200 = getelementptr inbounds %struct.neighbor* %199, i32 0, i32 1
  %201 = load double* %200, align 8
  %202 = fcmp olt double %195, %201
  br i1 %202, label %203, label %233

; <label>:203                                     ; preds = %189
  %204 = load i32* %i, align 4
  %205 = add nsw i32 %204, 1
  %206 = mul nsw i32 %205, 49
  %207 = sub nsw i32 %206, 1
  %208 = sext i32 %207 to i64
  %209 = getelementptr inbounds [490 x i8]* %sandbox, i32 0, i64 %208
  store i8 0, i8* %209, align 1
  %210 = load i32* %max_idx, align 4
  %211 = sext i32 %210 to i64
  %212 = load %struct.neighbor** %neighbors, align 8
  %213 = getelementptr inbounds %struct.neighbor* %212, i64 %211
  %214 = getelementptr inbounds %struct.neighbor* %213, i32 0, i32 0
  %215 = getelementptr inbounds [49 x i8]* %214, i32 0, i32 0
  %216 = getelementptr inbounds [490 x i8]* %sandbox, i32 0, i32 0
  %217 = load i32* %i, align 4
  %218 = mul nsw i32 %217, 49
  %219 = sext i32 %218 to i64
  %220 = getelementptr inbounds i8* %216, i64 %219
  %221 = call i8* @strcpy(i8* %215, i8* %220) #7
  %222 = load i32* %i, align 4
  %223 = sext i32 %222 to i64
  %224 = load float** %z, align 8
  %225 = getelementptr inbounds float* %224, i64 %223
  %226 = load float* %225, align 4
  %227 = fpext float %226 to double
  %228 = load i32* %max_idx, align 4
  %229 = sext i32 %228 to i64
  %230 = load %struct.neighbor** %neighbors, align 8
  %231 = getelementptr inbounds %struct.neighbor* %230, i64 %229
  %232 = getelementptr inbounds %struct.neighbor* %231, i32 0, i32 1
  store double %227, double* %232, align 8
  br label %233

; <label>:233                                     ; preds = %203, %189
  br label %234

; <label>:234                                     ; preds = %233
  %235 = load i32* %i, align 4
  %236 = add nsw i32 %235, 1
  store i32 %236, i32* %i, align 4
  br label %157

; <label>:237                                     ; preds = %157
  br label %75

; <label>:238                                     ; preds = %75
  %239 = call %struct._IO_FILE* @fopen(i8* getelementptr inbounds ([11 x i8]* @.str9, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8]* @.str10, i32 0, i32 0))
  store %struct._IO_FILE* %239, %struct._IO_FILE** %out, align 8
  %240 = load %struct._IO_FILE** %out, align 8
  %241 = load i32* %k, align 4
  %242 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %240, i8* getelementptr inbounds ([31 x i8]* @.str11, i32 0, i32 0), i32 %241)
  %243 = load i32* %k, align 4
  %244 = sub nsw i32 %243, 1
  store i32 %244, i32* %j, align 4
  br label %245

; <label>:245                                     ; preds = %272, %238
  %246 = load i32* %j, align 4
  %247 = icmp sge i32 %246, 0
  br i1 %247, label %248, label %275

; <label>:248                                     ; preds = %245
  %249 = load i32* %j, align 4
  %250 = sext i32 %249 to i64
  %251 = load %struct.neighbor** %neighbors, align 8
  %252 = getelementptr inbounds %struct.neighbor* %251, i64 %250
  %253 = getelementptr inbounds %struct.neighbor* %252, i32 0, i32 1
  %254 = load double* %253, align 8
  %255 = fcmp oeq double %254, 1.000000e+04
  br i1 %255, label %271, label %256

; <label>:256                                     ; preds = %248
  %257 = load %struct._IO_FILE** %out, align 8
  %258 = load i32* %j, align 4
  %259 = sext i32 %258 to i64
  %260 = load %struct.neighbor** %neighbors, align 8
  %261 = getelementptr inbounds %struct.neighbor* %260, i64 %259
  %262 = getelementptr inbounds %struct.neighbor* %261, i32 0, i32 0
  %263 = getelementptr inbounds [49 x i8]* %262, i32 0, i32 0
  %264 = load i32* %j, align 4
  %265 = sext i32 %264 to i64
  %266 = load %struct.neighbor** %neighbors, align 8
  %267 = getelementptr inbounds %struct.neighbor* %266, i64 %265
  %268 = getelementptr inbounds %struct.neighbor* %267, i32 0, i32 1
  %269 = load double* %268, align 8
  %270 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %257, i8* getelementptr inbounds ([11 x i8]* @.str12, i32 0, i32 0), i8* %263, double %269)
  br label %271

; <label>:271                                     ; preds = %256, %248
  br label %272

; <label>:272                                     ; preds = %271
  %273 = load i32* %j, align 4
  %274 = add nsw i32 %273, -1
  store i32 %274, i32* %j, align 4
  br label %245

; <label>:275                                     ; preds = %245
  %276 = load %struct._IO_FILE** %out, align 8
  %277 = call i32 @fclose(%struct._IO_FILE* %276)
  %278 = load %struct._IO_FILE** %flist, align 8
  %279 = call i32 @fclose(%struct._IO_FILE* %278)
  ret i32 0
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
