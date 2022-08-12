; ModuleID = 'kmeans.ll'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }

@.str = private unnamed_addr constant [305 x i8] c"Usage: %s [switches] -i filename\0A       -i filename     \09\09: file containing data to be clustered\0A       -b                 \09: input file is in binary format\0A       -k                 \09: number of clusters (default is 5) \0A       -t threshold\09\09: threshold value\0A       -n no. of threads\09: number of threads\00", align 1
@stderr = external global %struct._IO_FILE*
@.str1 = private unnamed_addr constant [12 x i8] c"i:k:t:b:n:?\00", align 1
@optarg = external global i8*
@.str2 = private unnamed_addr constant [5 x i8] c"0600\00", align 1
@.str3 = private unnamed_addr constant [26 x i8] c"Error: no such file (%s)\0A\00", align 1
@.str4 = private unnamed_addr constant [2 x i8] c"r\00", align 1
@.str5 = private unnamed_addr constant [4 x i8] c" \09\0A\00", align 1
@.str6 = private unnamed_addr constant [5 x i8] c" ,\09\0A\00", align 1
@.str7 = private unnamed_addr constant [15 x i8] c"I/O completed\0A\00", align 1
@.str8 = private unnamed_addr constant [23 x i8] c"number of Clusters %d\0A\00", align 1
@.str9 = private unnamed_addr constant [26 x i8] c"number of Attributes %d\0A\0A\00", align 1
@.str10 = private unnamed_addr constant [11 x i8] c"output.txt\00", align 1
@.str11 = private unnamed_addr constant [3 x i8] c"w+\00", align 1
@.str12 = private unnamed_addr constant [5 x i8] c"%d: \00", align 1
@.str13 = private unnamed_addr constant [6 x i8] c"%.2f \00", align 1
@.str14 = private unnamed_addr constant [3 x i8] c"\0A\0A\00", align 1

; Function Attrs: uwtable
define void @_Z5usagePc(i8* %argv0) #0 {
  %1 = alloca i8*, align 8
  %help = alloca i8*, align 8
  store i8* %argv0, i8** %1, align 8
  store i8* getelementptr inbounds ([305 x i8]* @.str, i32 0, i32 0), i8** %help, align 8
  %2 = load %struct._IO_FILE** @stderr, align 8
  %3 = load i8** %help, align 8
  %4 = load i8** %1, align 8
  %5 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %2, i8* %3, i8* %4)
  call void @exit(i32 -1) #8
  unreachable
                                                  ; No predecessors!
  ret void
}

declare i32 @fprintf(%struct._IO_FILE*, i8*, ...) #1

; Function Attrs: noreturn nounwind
declare void @exit(i32) #2

; Function Attrs: uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %opt = alloca i32, align 4
  %nclusters = alloca i32, align 4
  %filename = alloca i8*, align 8
  %buf = alloca float*, align 8
  %attributes = alloca float**, align 8
  %cluster_centres = alloca float**, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %numAttributes = alloca i32, align 4
  %numObjects = alloca i32, align 4
  %line = alloca [1024 x i8], align 16
  %isBinaryFile = alloca i32, align 4
  %nloops = alloca i32, align 4
  %threshold = alloca float, align 4
  %timing = alloca double, align 8
  %infile = alloca i32, align 4
  %infile1 = alloca %struct._IO_FILE*, align 8
  %file = alloca %struct._IO_FILE*, align 8
  store i32 0, i32* %1
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  store i32 5, i32* %nclusters, align 4
  store i8* null, i8** %filename, align 8
  store float** null, float*** %cluster_centres, align 8
  store i32 0, i32* %isBinaryFile, align 4
  store i32 1, i32* %nloops, align 4
  store float 0x3F50624DE0000000, float* %threshold, align 4
  br label %4

; <label>:4                                       ; preds = %29, %0
  %5 = load i32* %2, align 4
  %6 = load i8*** %3, align 8
  %7 = call i32 @getopt(i32 %5, i8** %6, i8* getelementptr inbounds ([12 x i8]* @.str1, i32 0, i32 0)) #5
  store i32 %7, i32* %opt, align 4
  %8 = icmp ne i32 %7, -1
  br i1 %8, label %9, label %30

; <label>:9                                       ; preds = %4
  %10 = load i32* %opt, align 4
  switch i32 %10, label %25 [
    i32 105, label %11
    i32 98, label %13
    i32 116, label %14
    i32 107, label %18
    i32 63, label %21
  ]

; <label>:11                                      ; preds = %9
  %12 = load i8** @optarg, align 8
  store i8* %12, i8** %filename, align 8
  br label %29

; <label>:13                                      ; preds = %9
  store i32 1, i32* %isBinaryFile, align 4
  br label %29

; <label>:14                                      ; preds = %9
  %15 = load i8** @optarg, align 8
  %16 = call double @atof(i8* %15) #9
  %17 = fptrunc double %16 to float
  store float %17, float* %threshold, align 4
  br label %29

; <label>:18                                      ; preds = %9
  %19 = load i8** @optarg, align 8
  %20 = call i32 @atoi(i8* %19) #9
  store i32 %20, i32* %nclusters, align 4
  br label %29

; <label>:21                                      ; preds = %9
  %22 = load i8*** %3, align 8
  %23 = getelementptr inbounds i8** %22, i64 0
  %24 = load i8** %23, align 8
  call void @_Z5usagePc(i8* %24)
  br label %29

; <label>:25                                      ; preds = %9
  %26 = load i8*** %3, align 8
  %27 = getelementptr inbounds i8** %26, i64 0
  %28 = load i8** %27, align 8
  call void @_Z5usagePc(i8* %28)
  br label %29

; <label>:29                                      ; preds = %25, %21, %18, %14, %13, %11
  br label %4

; <label>:30                                      ; preds = %4
  %31 = load i8** %filename, align 8
  %32 = icmp eq i8* %31, null
  br i1 %32, label %33, label %37

; <label>:33                                      ; preds = %30
  %34 = load i8*** %3, align 8
  %35 = getelementptr inbounds i8** %34, i64 0
  %36 = load i8** %35, align 8
  call void @_Z5usagePc(i8* %36)
  br label %37

; <label>:37                                      ; preds = %33, %30
  store i32 0, i32* %numObjects, align 4
  store i32 0, i32* %numAttributes, align 4
  %38 = load i32* %isBinaryFile, align 4
  %39 = icmp ne i32 %38, 0
  br i1 %39, label %40, label %109

; <label>:40                                      ; preds = %37
  %41 = load i8** %filename, align 8
  %42 = call i32 (i8*, i32, ...)* @open(i8* %41, i32 0, i8* getelementptr inbounds ([5 x i8]* @.str2, i32 0, i32 0))
  store i32 %42, i32* %infile, align 4
  %43 = icmp eq i32 %42, -1
  br i1 %43, label %44, label %48

; <label>:44                                      ; preds = %40
  %45 = load %struct._IO_FILE** @stderr, align 8
  %46 = load i8** %filename, align 8
  %47 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %45, i8* getelementptr inbounds ([26 x i8]* @.str3, i32 0, i32 0), i8* %46)
  call void @exit(i32 1) #8
  unreachable

; <label>:48                                      ; preds = %40
  %49 = load i32* %infile, align 4
  %50 = bitcast i32* %numObjects to i8*
  %51 = call i64 @read(i32 %49, i8* %50, i64 4)
  %52 = load i32* %infile, align 4
  %53 = bitcast i32* %numAttributes to i8*
  %54 = call i64 @read(i32 %52, i8* %53, i64 4)
  %55 = load i32* %numObjects, align 4
  %56 = load i32* %numAttributes, align 4
  %57 = mul nsw i32 %55, %56
  %58 = sext i32 %57 to i64
  %59 = mul i64 %58, 4
  %60 = call noalias i8* @malloc(i64 %59) #5
  %61 = bitcast i8* %60 to float*
  store float* %61, float** %buf, align 8
  %62 = load i32* %numObjects, align 4
  %63 = sext i32 %62 to i64
  %64 = mul i64 %63, 8
  %65 = call noalias i8* @malloc(i64 %64) #5
  %66 = bitcast i8* %65 to float**
  store float** %66, float*** %attributes, align 8
  %67 = load i32* %numObjects, align 4
  %68 = load i32* %numAttributes, align 4
  %69 = mul nsw i32 %67, %68
  %70 = sext i32 %69 to i64
  %71 = mul i64 %70, 4
  %72 = call noalias i8* @malloc(i64 %71) #5
  %73 = bitcast i8* %72 to float*
  %74 = load float*** %attributes, align 8
  %75 = getelementptr inbounds float** %74, i64 0
  store float* %73, float** %75, align 8
  store i32 1, i32* %i, align 4
  br label %76

; <label>:76                                      ; preds = %94, %48
  %77 = load i32* %i, align 4
  %78 = load i32* %numObjects, align 4
  %79 = icmp slt i32 %77, %78
  br i1 %79, label %80, label %97

; <label>:80                                      ; preds = %76
  %81 = load i32* %i, align 4
  %82 = sub nsw i32 %81, 1
  %83 = sext i32 %82 to i64
  %84 = load float*** %attributes, align 8
  %85 = getelementptr inbounds float** %84, i64 %83
  %86 = load float** %85, align 8
  %87 = load i32* %numAttributes, align 4
  %88 = sext i32 %87 to i64
  %89 = getelementptr inbounds float* %86, i64 %88
  %90 = load i32* %i, align 4
  %91 = sext i32 %90 to i64
  %92 = load float*** %attributes, align 8
  %93 = getelementptr inbounds float** %92, i64 %91
  store float* %89, float** %93, align 8
  br label %94

; <label>:94                                      ; preds = %80
  %95 = load i32* %i, align 4
  %96 = add nsw i32 %95, 1
  store i32 %96, i32* %i, align 4
  br label %76

; <label>:97                                      ; preds = %76
  %98 = load i32* %infile, align 4
  %99 = load float** %buf, align 8
  %100 = bitcast float* %99 to i8*
  %101 = load i32* %numObjects, align 4
  %102 = load i32* %numAttributes, align 4
  %103 = mul nsw i32 %101, %102
  %104 = sext i32 %103 to i64
  %105 = mul i64 %104, 4
  %106 = call i64 @read(i32 %98, i8* %100, i64 %105)
  %107 = load i32* %infile, align 4
  %108 = call i32 @close(i32 %107)
  br label %228

; <label>:109                                     ; preds = %37
  %110 = load i8** %filename, align 8
  %111 = call %struct._IO_FILE* @fopen(i8* %110, i8* getelementptr inbounds ([2 x i8]* @.str4, i32 0, i32 0))
  store %struct._IO_FILE* %111, %struct._IO_FILE** %infile1, align 8
  %112 = icmp eq %struct._IO_FILE* %111, null
  br i1 %112, label %113, label %117

; <label>:113                                     ; preds = %109
  %114 = load %struct._IO_FILE** @stderr, align 8
  %115 = load i8** %filename, align 8
  %116 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %114, i8* getelementptr inbounds ([26 x i8]* @.str3, i32 0, i32 0), i8* %115)
  call void @exit(i32 1) #8
  unreachable

; <label>:117                                     ; preds = %109
  br label %118

; <label>:118                                     ; preds = %130, %117
  %119 = getelementptr inbounds [1024 x i8]* %line, i32 0, i32 0
  %120 = load %struct._IO_FILE** %infile1, align 8
  %121 = call i8* @fgets(i8* %119, i32 1024, %struct._IO_FILE* %120)
  %122 = icmp ne i8* %121, null
  br i1 %122, label %123, label %131

; <label>:123                                     ; preds = %118
  %124 = getelementptr inbounds [1024 x i8]* %line, i32 0, i32 0
  %125 = call i8* @strtok(i8* %124, i8* getelementptr inbounds ([4 x i8]* @.str5, i32 0, i32 0)) #5
  %126 = icmp ne i8* %125, null
  br i1 %126, label %127, label %130

; <label>:127                                     ; preds = %123
  %128 = load i32* %numObjects, align 4
  %129 = add nsw i32 %128, 1
  store i32 %129, i32* %numObjects, align 4
  br label %130

; <label>:130                                     ; preds = %127, %123
  br label %118

; <label>:131                                     ; preds = %118
  %132 = load %struct._IO_FILE** %infile1, align 8
  call void @rewind(%struct._IO_FILE* %132)
  br label %133

; <label>:133                                     ; preds = %150, %131
  %134 = getelementptr inbounds [1024 x i8]* %line, i32 0, i32 0
  %135 = load %struct._IO_FILE** %infile1, align 8
  %136 = call i8* @fgets(i8* %134, i32 1024, %struct._IO_FILE* %135)
  %137 = icmp ne i8* %136, null
  br i1 %137, label %138, label %151

; <label>:138                                     ; preds = %133
  %139 = getelementptr inbounds [1024 x i8]* %line, i32 0, i32 0
  %140 = call i8* @strtok(i8* %139, i8* getelementptr inbounds ([4 x i8]* @.str5, i32 0, i32 0)) #5
  %141 = icmp ne i8* %140, null
  br i1 %141, label %142, label %150

; <label>:142                                     ; preds = %138
  br label %143

; <label>:143                                     ; preds = %146, %142
  %144 = call i8* @strtok(i8* null, i8* getelementptr inbounds ([5 x i8]* @.str6, i32 0, i32 0)) #5
  %145 = icmp ne i8* %144, null
  br i1 %145, label %146, label %149

; <label>:146                                     ; preds = %143
  %147 = load i32* %numAttributes, align 4
  %148 = add nsw i32 %147, 1
  store i32 %148, i32* %numAttributes, align 4
  br label %143

; <label>:149                                     ; preds = %143
  br label %151

; <label>:150                                     ; preds = %138
  br label %133

; <label>:151                                     ; preds = %149, %133
  %152 = load i32* %numObjects, align 4
  %153 = load i32* %numAttributes, align 4
  %154 = mul nsw i32 %152, %153
  %155 = sext i32 %154 to i64
  %156 = mul i64 %155, 4
  %157 = call noalias i8* @malloc(i64 %156) #5
  %158 = bitcast i8* %157 to float*
  store float* %158, float** %buf, align 8
  %159 = load i32* %numObjects, align 4
  %160 = sext i32 %159 to i64
  %161 = mul i64 %160, 8
  %162 = call noalias i8* @malloc(i64 %161) #5
  %163 = bitcast i8* %162 to float**
  store float** %163, float*** %attributes, align 8
  %164 = load i32* %numObjects, align 4
  %165 = load i32* %numAttributes, align 4
  %166 = mul nsw i32 %164, %165
  %167 = sext i32 %166 to i64
  %168 = mul i64 %167, 4
  %169 = call noalias i8* @malloc(i64 %168) #5
  %170 = bitcast i8* %169 to float*
  %171 = load float*** %attributes, align 8
  %172 = getelementptr inbounds float** %171, i64 0
  store float* %170, float** %172, align 8
  store i32 1, i32* %i, align 4
  br label %173

; <label>:173                                     ; preds = %191, %151
  %174 = load i32* %i, align 4
  %175 = load i32* %numObjects, align 4
  %176 = icmp slt i32 %174, %175
  br i1 %176, label %177, label %194

; <label>:177                                     ; preds = %173
  %178 = load i32* %i, align 4
  %179 = sub nsw i32 %178, 1
  %180 = sext i32 %179 to i64
  %181 = load float*** %attributes, align 8
  %182 = getelementptr inbounds float** %181, i64 %180
  %183 = load float** %182, align 8
  %184 = load i32* %numAttributes, align 4
  %185 = sext i32 %184 to i64
  %186 = getelementptr inbounds float* %183, i64 %185
  %187 = load i32* %i, align 4
  %188 = sext i32 %187 to i64
  %189 = load float*** %attributes, align 8
  %190 = getelementptr inbounds float** %189, i64 %188
  store float* %186, float** %190, align 8
  br label %191

; <label>:191                                     ; preds = %177
  %192 = load i32* %i, align 4
  %193 = add nsw i32 %192, 1
  store i32 %193, i32* %i, align 4
  br label %173

; <label>:194                                     ; preds = %173
  %195 = load %struct._IO_FILE** %infile1, align 8
  call void @rewind(%struct._IO_FILE* %195)
  store i32 0, i32* %i, align 4
  br label %196

; <label>:196                                     ; preds = %224, %205, %194
  %197 = getelementptr inbounds [1024 x i8]* %line, i32 0, i32 0
  %198 = load %struct._IO_FILE** %infile1, align 8
  %199 = call i8* @fgets(i8* %197, i32 1024, %struct._IO_FILE* %198)
  %200 = icmp ne i8* %199, null
  br i1 %200, label %201, label %225

; <label>:201                                     ; preds = %196
  %202 = getelementptr inbounds [1024 x i8]* %line, i32 0, i32 0
  %203 = call i8* @strtok(i8* %202, i8* getelementptr inbounds ([4 x i8]* @.str5, i32 0, i32 0)) #5
  %204 = icmp eq i8* %203, null
  br i1 %204, label %205, label %206

; <label>:205                                     ; preds = %201
  br label %196

; <label>:206                                     ; preds = %201
  store i32 0, i32* %j, align 4
  br label %207

; <label>:207                                     ; preds = %221, %206
  %208 = load i32* %j, align 4
  %209 = load i32* %numAttributes, align 4
  %210 = icmp slt i32 %208, %209
  br i1 %210, label %211, label %224

; <label>:211                                     ; preds = %207
  %212 = call i8* @strtok(i8* null, i8* getelementptr inbounds ([5 x i8]* @.str6, i32 0, i32 0)) #5
  %213 = call double @atof(i8* %212) #9
  %214 = fptrunc double %213 to float
  %215 = load i32* %i, align 4
  %216 = sext i32 %215 to i64
  %217 = load float** %buf, align 8
  %218 = getelementptr inbounds float* %217, i64 %216
  store float %214, float* %218, align 4
  %219 = load i32* %i, align 4
  %220 = add nsw i32 %219, 1
  store i32 %220, i32* %i, align 4
  br label %221

; <label>:221                                     ; preds = %211
  %222 = load i32* %j, align 4
  %223 = add nsw i32 %222, 1
  store i32 %223, i32* %j, align 4
  br label %207

; <label>:224                                     ; preds = %207
  br label %196

; <label>:225                                     ; preds = %196
  %226 = load %struct._IO_FILE** %infile1, align 8
  %227 = call i32 @fclose(%struct._IO_FILE* %226)
  br label %228

; <label>:228                                     ; preds = %225, %97
  %229 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str7, i32 0, i32 0))
  %230 = load float*** %attributes, align 8
  %231 = getelementptr inbounds float** %230, i64 0
  %232 = load float** %231, align 8
  %233 = bitcast float* %232 to i8*
  %234 = load float** %buf, align 8
  %235 = bitcast float* %234 to i8*
  %236 = load i32* %numObjects, align 4
  %237 = load i32* %numAttributes, align 4
  %238 = mul nsw i32 %236, %237
  %239 = sext i32 %238 to i64
  %240 = mul i64 %239, 4
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %233, i8* %235, i64 %240, i32 4, i1 false)
  store i32 0, i32* %i, align 4
  br label %241

; <label>:241                                     ; preds = %252, %228
  %242 = load i32* %i, align 4
  %243 = load i32* %nloops, align 4
  %244 = icmp slt i32 %242, %243
  br i1 %244, label %245, label %255

; <label>:245                                     ; preds = %241
  store float** null, float*** %cluster_centres, align 8
  %246 = load i32* %numObjects, align 4
  %247 = load i32* %numAttributes, align 4
  %248 = load float*** %attributes, align 8
  %249 = load i32* %nclusters, align 4
  %250 = load float* %threshold, align 4
  %251 = call i32 @_Z7clusteriiPPfifPS0_(i32 %246, i32 %247, float** %248, i32 %249, float %250, float*** %cluster_centres)
  br label %252

; <label>:252                                     ; preds = %245
  %253 = load i32* %i, align 4
  %254 = add nsw i32 %253, 1
  store i32 %254, i32* %i, align 4
  br label %241

; <label>:255                                     ; preds = %241
  %256 = load i32* %nclusters, align 4
  %257 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str8, i32 0, i32 0), i32 %256)
  %258 = load i32* %numAttributes, align 4
  %259 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([26 x i8]* @.str9, i32 0, i32 0), i32 %258)
  %260 = call %struct._IO_FILE* @fopen(i8* getelementptr inbounds ([11 x i8]* @.str10, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8]* @.str11, i32 0, i32 0))
  store %struct._IO_FILE* %260, %struct._IO_FILE** %file, align 8
  store i32 0, i32* %i, align 4
  br label %261

; <label>:261                                     ; preds = %292, %255
  %262 = load i32* %i, align 4
  %263 = load i32* %nclusters, align 4
  %264 = icmp slt i32 %262, %263
  br i1 %264, label %265, label %295

; <label>:265                                     ; preds = %261
  %266 = load %struct._IO_FILE** %file, align 8
  %267 = load i32* %i, align 4
  %268 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %266, i8* getelementptr inbounds ([5 x i8]* @.str12, i32 0, i32 0), i32 %267)
  store i32 0, i32* %j, align 4
  br label %269

; <label>:269                                     ; preds = %286, %265
  %270 = load i32* %j, align 4
  %271 = load i32* %numAttributes, align 4
  %272 = icmp slt i32 %270, %271
  br i1 %272, label %273, label %289

; <label>:273                                     ; preds = %269
  %274 = load %struct._IO_FILE** %file, align 8
  %275 = load i32* %j, align 4
  %276 = sext i32 %275 to i64
  %277 = load i32* %i, align 4
  %278 = sext i32 %277 to i64
  %279 = load float*** %cluster_centres, align 8
  %280 = getelementptr inbounds float** %279, i64 %278
  %281 = load float** %280, align 8
  %282 = getelementptr inbounds float* %281, i64 %276
  %283 = load float* %282, align 4
  %284 = fpext float %283 to double
  %285 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %274, i8* getelementptr inbounds ([6 x i8]* @.str13, i32 0, i32 0), double %284)
  br label %286

; <label>:286                                     ; preds = %273
  %287 = load i32* %j, align 4
  %288 = add nsw i32 %287, 1
  store i32 %288, i32* %j, align 4
  br label %269

; <label>:289                                     ; preds = %269
  %290 = load %struct._IO_FILE** %file, align 8
  %291 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %290, i8* getelementptr inbounds ([3 x i8]* @.str14, i32 0, i32 0))
  br label %292

; <label>:292                                     ; preds = %289
  %293 = load i32* %i, align 4
  %294 = add nsw i32 %293, 1
  store i32 %294, i32* %i, align 4
  br label %261

; <label>:295                                     ; preds = %261
  %296 = load %struct._IO_FILE** %file, align 8
  %297 = call i32 @fclose(%struct._IO_FILE* %296)
  %298 = load float*** %attributes, align 8
  %299 = bitcast float** %298 to i8*
  call void @free(i8* %299) #5
  %300 = load float*** %cluster_centres, align 8
  %301 = getelementptr inbounds float** %300, i64 0
  %302 = load float** %301, align 8
  %303 = bitcast float* %302 to i8*
  call void @free(i8* %303) #5
  %304 = load float*** %cluster_centres, align 8
  %305 = bitcast float** %304 to i8*
  call void @free(i8* %305) #5
  %306 = load float** %buf, align 8
  %307 = bitcast float* %306 to i8*
  call void @free(i8* %307) #5
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @getopt(i32, i8**, i8*) #3

; Function Attrs: nounwind readonly
declare double @atof(i8*) #4

; Function Attrs: nounwind readonly
declare i32 @atoi(i8*) #4

declare i32 @open(i8*, i32, ...) #1

declare i64 @read(i32, i8*, i64) #1

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #3

declare i32 @close(i32) #1

declare %struct._IO_FILE* @fopen(i8*, i8*) #1

declare i8* @fgets(i8*, i32, %struct._IO_FILE*) #1

; Function Attrs: nounwind
declare i8* @strtok(i8*, i8*) #3

declare void @rewind(%struct._IO_FILE*) #1

declare i32 @fclose(%struct._IO_FILE*) #1

declare i32 @printf(i8*, ...) #1

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #5

; Function Attrs: nounwind
declare void @free(i8*) #3

; Function Attrs: uwtable
define i32 @_Z7clusteriiPPfifPS0_(i32 %numObjects, i32 %numAttributes, float** %attributes, i32 %nclusters, float %threshold, float*** %cluster_centres) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca float**, align 8
  %4 = alloca i32, align 4
  %5 = alloca float, align 4
  %6 = alloca float***, align 8
  %membership = alloca i32*, align 8
  %tmp_cluster_centres = alloca float**, align 8
  store i32 %numObjects, i32* %1, align 4
  store i32 %numAttributes, i32* %2, align 4
  store float** %attributes, float*** %3, align 8
  store i32 %nclusters, i32* %4, align 4
  store float %threshold, float* %5, align 4
  store float*** %cluster_centres, float**** %6, align 8
  %7 = load i32* %1, align 4
  %8 = sext i32 %7 to i64
  %9 = mul i64 %8, 4
  %10 = call noalias i8* @malloc(i64 %9) #5
  %11 = bitcast i8* %10 to i32*
  store i32* %11, i32** %membership, align 8
  call void @srand(i32 7) #5
  %12 = load float*** %3, align 8
  %13 = load i32* %2, align 4
  %14 = load i32* %1, align 4
  %15 = load i32* %4, align 4
  %16 = load float* %5, align 4
  %17 = load i32** %membership, align 8
  %18 = call float** @_Z17kmeans_clusteringPPfiiifPi(float** %12, i32 %13, i32 %14, i32 %15, float %16, i32* %17)
  store float** %18, float*** %tmp_cluster_centres, align 8
  %19 = load float**** %6, align 8
  %20 = load float*** %19, align 8
  %21 = icmp ne float** %20, null
  br i1 %21, label %22, label %31

; <label>:22                                      ; preds = %0
  %23 = load float**** %6, align 8
  %24 = load float*** %23, align 8
  %25 = getelementptr inbounds float** %24, i64 0
  %26 = load float** %25, align 8
  %27 = bitcast float* %26 to i8*
  call void @free(i8* %27) #5
  %28 = load float**** %6, align 8
  %29 = load float*** %28, align 8
  %30 = bitcast float** %29 to i8*
  call void @free(i8* %30) #5
  br label %31

; <label>:31                                      ; preds = %22, %0
  %32 = load float*** %tmp_cluster_centres, align 8
  %33 = load float**** %6, align 8
  store float** %32, float*** %33, align 8
  %34 = load i32** %membership, align 8
  %35 = bitcast i32* %34 to i8*
  call void @free(i8* %35) #5
  ret i32 0
}

; Function Attrs: nounwind
declare void @srand(i32) #3

; Function Attrs: uwtable
define i32 @_Z18find_nearest_pointPfiPS_i(float* %pt, i32 %nfeatures, float** %pts, i32 %npts) #0 {
  %1 = alloca float*, align 8
  %2 = alloca i32, align 4
  %3 = alloca float**, align 8
  %4 = alloca i32, align 4
  %index = alloca i32, align 4
  %i = alloca i32, align 4
  %min_dist = alloca float, align 4
  %dist = alloca float, align 4
  store float* %pt, float** %1, align 8
  store i32 %nfeatures, i32* %2, align 4
  store float** %pts, float*** %3, align 8
  store i32 %npts, i32* %4, align 4
  store float 0x47EFFFFFE0000000, float* %min_dist, align 4
  store i32 0, i32* %i, align 4
  br label %5

; <label>:5                                       ; preds = %25, %0
  %6 = load i32* %i, align 4
  %7 = load i32* %4, align 4
  %8 = icmp slt i32 %6, %7
  br i1 %8, label %9, label %28

; <label>:9                                       ; preds = %5
  %10 = load float** %1, align 8
  %11 = load i32* %i, align 4
  %12 = sext i32 %11 to i64
  %13 = load float*** %3, align 8
  %14 = getelementptr inbounds float** %13, i64 %12
  %15 = load float** %14, align 8
  %16 = load i32* %2, align 4
  %17 = call float @_Z13euclid_dist_2PfS_i(float* %10, float* %15, i32 %16)
  store float %17, float* %dist, align 4
  %18 = load float* %dist, align 4
  %19 = load float* %min_dist, align 4
  %20 = fcmp olt float %18, %19
  br i1 %20, label %21, label %24

; <label>:21                                      ; preds = %9
  %22 = load float* %dist, align 4
  store float %22, float* %min_dist, align 4
  %23 = load i32* %i, align 4
  store i32 %23, i32* %index, align 4
  br label %24

; <label>:24                                      ; preds = %21, %9
  br label %25

; <label>:25                                      ; preds = %24
  %26 = load i32* %i, align 4
  %27 = add nsw i32 %26, 1
  store i32 %27, i32* %i, align 4
  br label %5

; <label>:28                                      ; preds = %5
  %29 = load i32* %index, align 4
  ret i32 %29
}

; Function Attrs: nounwind uwtable
define float** @_Z17kmeans_clusteringPPfiiifPi(float** %feature, i32 %nfeatures, i32 %npoints, i32 %nclusters, float %threshold, i32* %membership) #6 {
  %1 = alloca float**, align 8
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca float, align 4
  %6 = alloca i32*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %n = alloca i32, align 4
  %index = alloca i32, align 4
  %loop = alloca i32, align 4
  %new_centers_len = alloca i32*, align 8
  %new_centers = alloca float**, align 8
  %clusters = alloca float**, align 8
  %delta = alloca float, align 4
  %timing = alloca double, align 8
  %nthreads = alloca i32, align 4
  %partial_new_centers_len = alloca i32**, align 8
  %partial_new_centers = alloca float***, align 8
  store float** %feature, float*** %1, align 8
  store i32 %nfeatures, i32* %2, align 4
  store i32 %npoints, i32* %3, align 4
  store i32 %nclusters, i32* %4, align 4
  store float %threshold, float* %5, align 4
  store i32* %membership, i32** %6, align 8
  store i32 0, i32* %n, align 4
  store i32 0, i32* %loop, align 4
  store i32 1, i32* %nthreads, align 4
  %7 = load i32* %4, align 4
  %8 = sext i32 %7 to i64
  %9 = mul i64 %8, 8
  %10 = call noalias i8* @malloc(i64 %9) #5
  %11 = bitcast i8* %10 to float**
  store float** %11, float*** %clusters, align 8
  %12 = load i32* %4, align 4
  %13 = load i32* %2, align 4
  %14 = mul nsw i32 %12, %13
  %15 = sext i32 %14 to i64
  %16 = mul i64 %15, 4
  %17 = call noalias i8* @malloc(i64 %16) #5
  %18 = bitcast i8* %17 to float*
  %19 = load float*** %clusters, align 8
  %20 = getelementptr inbounds float** %19, i64 0
  store float* %18, float** %20, align 8
  store i32 1, i32* %i, align 4
  br label %21

; <label>:21                                      ; preds = %39, %0
  %22 = load i32* %i, align 4
  %23 = load i32* %4, align 4
  %24 = icmp slt i32 %22, %23
  br i1 %24, label %25, label %42

; <label>:25                                      ; preds = %21
  %26 = load i32* %i, align 4
  %27 = sub nsw i32 %26, 1
  %28 = sext i32 %27 to i64
  %29 = load float*** %clusters, align 8
  %30 = getelementptr inbounds float** %29, i64 %28
  %31 = load float** %30, align 8
  %32 = load i32* %2, align 4
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds float* %31, i64 %33
  %35 = load i32* %i, align 4
  %36 = sext i32 %35 to i64
  %37 = load float*** %clusters, align 8
  %38 = getelementptr inbounds float** %37, i64 %36
  store float* %34, float** %38, align 8
  br label %39

; <label>:39                                      ; preds = %25
  %40 = load i32* %i, align 4
  %41 = add nsw i32 %40, 1
  store i32 %41, i32* %i, align 4
  br label %21

; <label>:42                                      ; preds = %21
  store i32 0, i32* %i, align 4
  br label %43

; <label>:43                                      ; preds = %76, %42
  %44 = load i32* %i, align 4
  %45 = load i32* %4, align 4
  %46 = icmp slt i32 %44, %45
  br i1 %46, label %47, label %79

; <label>:47                                      ; preds = %43
  store i32 0, i32* %j, align 4
  br label %48

; <label>:48                                      ; preds = %70, %47
  %49 = load i32* %j, align 4
  %50 = load i32* %2, align 4
  %51 = icmp slt i32 %49, %50
  br i1 %51, label %52, label %73

; <label>:52                                      ; preds = %48
  %53 = load i32* %j, align 4
  %54 = sext i32 %53 to i64
  %55 = load i32* %n, align 4
  %56 = sext i32 %55 to i64
  %57 = load float*** %1, align 8
  %58 = getelementptr inbounds float** %57, i64 %56
  %59 = load float** %58, align 8
  %60 = getelementptr inbounds float* %59, i64 %54
  %61 = load float* %60, align 4
  %62 = load i32* %j, align 4
  %63 = sext i32 %62 to i64
  %64 = load i32* %i, align 4
  %65 = sext i32 %64 to i64
  %66 = load float*** %clusters, align 8
  %67 = getelementptr inbounds float** %66, i64 %65
  %68 = load float** %67, align 8
  %69 = getelementptr inbounds float* %68, i64 %63
  store float %61, float* %69, align 4
  br label %70

; <label>:70                                      ; preds = %52
  %71 = load i32* %j, align 4
  %72 = add nsw i32 %71, 1
  store i32 %72, i32* %j, align 4
  br label %48

; <label>:73                                      ; preds = %48
  %74 = load i32* %n, align 4
  %75 = add nsw i32 %74, 1
  store i32 %75, i32* %n, align 4
  br label %76

; <label>:76                                      ; preds = %73
  %77 = load i32* %i, align 4
  %78 = add nsw i32 %77, 1
  store i32 %78, i32* %i, align 4
  br label %43

; <label>:79                                      ; preds = %43
  store i32 0, i32* %i, align 4
  br label %80

; <label>:80                                      ; preds = %89, %79
  %81 = load i32* %i, align 4
  %82 = load i32* %3, align 4
  %83 = icmp slt i32 %81, %82
  br i1 %83, label %84, label %92

; <label>:84                                      ; preds = %80
  %85 = load i32* %i, align 4
  %86 = sext i32 %85 to i64
  %87 = load i32** %6, align 8
  %88 = getelementptr inbounds i32* %87, i64 %86
  store i32 -1, i32* %88, align 4
  br label %89

; <label>:89                                      ; preds = %84
  %90 = load i32* %i, align 4
  %91 = add nsw i32 %90, 1
  store i32 %91, i32* %i, align 4
  br label %80

; <label>:92                                      ; preds = %80
  %93 = load i32* %4, align 4
  %94 = sext i32 %93 to i64
  %95 = call noalias i8* @calloc(i64 %94, i64 4) #5
  %96 = bitcast i8* %95 to i32*
  store i32* %96, i32** %new_centers_len, align 8
  %97 = load i32* %4, align 4
  %98 = sext i32 %97 to i64
  %99 = mul i64 %98, 8
  %100 = call noalias i8* @malloc(i64 %99) #5
  %101 = bitcast i8* %100 to float**
  store float** %101, float*** %new_centers, align 8
  %102 = load i32* %4, align 4
  %103 = load i32* %2, align 4
  %104 = mul nsw i32 %102, %103
  %105 = sext i32 %104 to i64
  %106 = call noalias i8* @calloc(i64 %105, i64 4) #5
  %107 = bitcast i8* %106 to float*
  %108 = load float*** %new_centers, align 8
  %109 = getelementptr inbounds float** %108, i64 0
  store float* %107, float** %109, align 8
  store i32 1, i32* %i, align 4
  br label %110

; <label>:110                                     ; preds = %128, %92
  %111 = load i32* %i, align 4
  %112 = load i32* %4, align 4
  %113 = icmp slt i32 %111, %112
  br i1 %113, label %114, label %131

; <label>:114                                     ; preds = %110
  %115 = load i32* %i, align 4
  %116 = sub nsw i32 %115, 1
  %117 = sext i32 %116 to i64
  %118 = load float*** %new_centers, align 8
  %119 = getelementptr inbounds float** %118, i64 %117
  %120 = load float** %119, align 8
  %121 = load i32* %2, align 4
  %122 = sext i32 %121 to i64
  %123 = getelementptr inbounds float* %120, i64 %122
  %124 = load i32* %i, align 4
  %125 = sext i32 %124 to i64
  %126 = load float*** %new_centers, align 8
  %127 = getelementptr inbounds float** %126, i64 %125
  store float* %123, float** %127, align 8
  br label %128

; <label>:128                                     ; preds = %114
  %129 = load i32* %i, align 4
  %130 = add nsw i32 %129, 1
  store i32 %130, i32* %i, align 4
  br label %110

; <label>:131                                     ; preds = %110
  %132 = load i32* %nthreads, align 4
  %133 = sext i32 %132 to i64
  %134 = mul i64 %133, 8
  %135 = call noalias i8* @malloc(i64 %134) #5
  %136 = bitcast i8* %135 to i32**
  store i32** %136, i32*** %partial_new_centers_len, align 8
  %137 = load i32* %nthreads, align 4
  %138 = load i32* %4, align 4
  %139 = mul nsw i32 %137, %138
  %140 = sext i32 %139 to i64
  %141 = call noalias i8* @calloc(i64 %140, i64 4) #5
  %142 = bitcast i8* %141 to i32*
  %143 = load i32*** %partial_new_centers_len, align 8
  %144 = getelementptr inbounds i32** %143, i64 0
  store i32* %142, i32** %144, align 8
  store i32 1, i32* %i, align 4
  br label %145

; <label>:145                                     ; preds = %163, %131
  %146 = load i32* %i, align 4
  %147 = load i32* %nthreads, align 4
  %148 = icmp slt i32 %146, %147
  br i1 %148, label %149, label %166

; <label>:149                                     ; preds = %145
  %150 = load i32* %i, align 4
  %151 = sub nsw i32 %150, 1
  %152 = sext i32 %151 to i64
  %153 = load i32*** %partial_new_centers_len, align 8
  %154 = getelementptr inbounds i32** %153, i64 %152
  %155 = load i32** %154, align 8
  %156 = load i32* %4, align 4
  %157 = sext i32 %156 to i64
  %158 = getelementptr inbounds i32* %155, i64 %157
  %159 = load i32* %i, align 4
  %160 = sext i32 %159 to i64
  %161 = load i32*** %partial_new_centers_len, align 8
  %162 = getelementptr inbounds i32** %161, i64 %160
  store i32* %158, i32** %162, align 8
  br label %163

; <label>:163                                     ; preds = %149
  %164 = load i32* %i, align 4
  %165 = add nsw i32 %164, 1
  store i32 %165, i32* %i, align 4
  br label %145

; <label>:166                                     ; preds = %145
  %167 = load i32* %nthreads, align 4
  %168 = sext i32 %167 to i64
  %169 = mul i64 %168, 8
  %170 = call noalias i8* @malloc(i64 %169) #5
  %171 = bitcast i8* %170 to float***
  store float*** %171, float**** %partial_new_centers, align 8
  %172 = load i32* %nthreads, align 4
  %173 = load i32* %4, align 4
  %174 = mul nsw i32 %172, %173
  %175 = sext i32 %174 to i64
  %176 = mul i64 %175, 8
  %177 = call noalias i8* @malloc(i64 %176) #5
  %178 = bitcast i8* %177 to float**
  %179 = load float**** %partial_new_centers, align 8
  %180 = getelementptr inbounds float*** %179, i64 0
  store float** %178, float*** %180, align 8
  store i32 1, i32* %i, align 4
  br label %181

; <label>:181                                     ; preds = %199, %166
  %182 = load i32* %i, align 4
  %183 = load i32* %nthreads, align 4
  %184 = icmp slt i32 %182, %183
  br i1 %184, label %185, label %202

; <label>:185                                     ; preds = %181
  %186 = load i32* %i, align 4
  %187 = sub nsw i32 %186, 1
  %188 = sext i32 %187 to i64
  %189 = load float**** %partial_new_centers, align 8
  %190 = getelementptr inbounds float*** %189, i64 %188
  %191 = load float*** %190, align 8
  %192 = load i32* %4, align 4
  %193 = sext i32 %192 to i64
  %194 = getelementptr inbounds float** %191, i64 %193
  %195 = load i32* %i, align 4
  %196 = sext i32 %195 to i64
  %197 = load float**** %partial_new_centers, align 8
  %198 = getelementptr inbounds float*** %197, i64 %196
  store float** %194, float*** %198, align 8
  br label %199

; <label>:199                                     ; preds = %185
  %200 = load i32* %i, align 4
  %201 = add nsw i32 %200, 1
  store i32 %201, i32* %i, align 4
  br label %181

; <label>:202                                     ; preds = %181
  store i32 0, i32* %i, align 4
  br label %203

; <label>:203                                     ; preds = %229, %202
  %204 = load i32* %i, align 4
  %205 = load i32* %nthreads, align 4
  %206 = icmp slt i32 %204, %205
  br i1 %206, label %207, label %232

; <label>:207                                     ; preds = %203
  store i32 0, i32* %j, align 4
  br label %208

; <label>:208                                     ; preds = %225, %207
  %209 = load i32* %j, align 4
  %210 = load i32* %4, align 4
  %211 = icmp slt i32 %209, %210
  br i1 %211, label %212, label %228

; <label>:212                                     ; preds = %208
  %213 = load i32* %2, align 4
  %214 = sext i32 %213 to i64
  %215 = call noalias i8* @calloc(i64 %214, i64 4) #5
  %216 = bitcast i8* %215 to float*
  %217 = load i32* %j, align 4
  %218 = sext i32 %217 to i64
  %219 = load i32* %i, align 4
  %220 = sext i32 %219 to i64
  %221 = load float**** %partial_new_centers, align 8
  %222 = getelementptr inbounds float*** %221, i64 %220
  %223 = load float*** %222, align 8
  %224 = getelementptr inbounds float** %223, i64 %218
  store float* %216, float** %224, align 8
  br label %225

; <label>:225                                     ; preds = %212
  %226 = load i32* %j, align 4
  %227 = add nsw i32 %226, 1
  store i32 %227, i32* %j, align 4
  br label %208

; <label>:228                                     ; preds = %208
  br label %229

; <label>:229                                     ; preds = %228
  %230 = load i32* %i, align 4
  %231 = add nsw i32 %230, 1
  store i32 %231, i32* %i, align 4
  br label %203

; <label>:232                                     ; preds = %203
  br label %233

; <label>:233                                     ; preds = %389, %232
  store float 0.000000e+00, float* %delta, align 4
  store i32 0, i32* %i, align 4
  br label %234

; <label>:234                                     ; preds = %315, %233
  %235 = load i32* %i, align 4
  %236 = load i32* %4, align 4
  %237 = icmp slt i32 %235, %236
  br i1 %237, label %238, label %318

; <label>:238                                     ; preds = %234
  store i32 0, i32* %j, align 4
  br label %239

; <label>:239                                     ; preds = %311, %238
  %240 = load i32* %j, align 4
  %241 = load i32* %nthreads, align 4
  %242 = icmp slt i32 %240, %241
  br i1 %242, label %243, label %314

; <label>:243                                     ; preds = %239
  %244 = load i32* %i, align 4
  %245 = sext i32 %244 to i64
  %246 = load i32* %j, align 4
  %247 = sext i32 %246 to i64
  %248 = load i32*** %partial_new_centers_len, align 8
  %249 = getelementptr inbounds i32** %248, i64 %247
  %250 = load i32** %249, align 8
  %251 = getelementptr inbounds i32* %250, i64 %245
  %252 = load i32* %251, align 4
  %253 = load i32* %i, align 4
  %254 = sext i32 %253 to i64
  %255 = load i32** %new_centers_len, align 8
  %256 = getelementptr inbounds i32* %255, i64 %254
  %257 = load i32* %256, align 4
  %258 = add nsw i32 %257, %252
  store i32 %258, i32* %256, align 4
  %259 = load i32* %i, align 4
  %260 = sext i32 %259 to i64
  %261 = load i32* %j, align 4
  %262 = sext i32 %261 to i64
  %263 = load i32*** %partial_new_centers_len, align 8
  %264 = getelementptr inbounds i32** %263, i64 %262
  %265 = load i32** %264, align 8
  %266 = getelementptr inbounds i32* %265, i64 %260
  store i32 0, i32* %266, align 4
  store i32 0, i32* %k, align 4
  br label %267

; <label>:267                                     ; preds = %307, %243
  %268 = load i32* %k, align 4
  %269 = load i32* %2, align 4
  %270 = icmp slt i32 %268, %269
  br i1 %270, label %271, label %310

; <label>:271                                     ; preds = %267
  %272 = load i32* %k, align 4
  %273 = sext i32 %272 to i64
  %274 = load i32* %i, align 4
  %275 = sext i32 %274 to i64
  %276 = load i32* %j, align 4
  %277 = sext i32 %276 to i64
  %278 = load float**** %partial_new_centers, align 8
  %279 = getelementptr inbounds float*** %278, i64 %277
  %280 = load float*** %279, align 8
  %281 = getelementptr inbounds float** %280, i64 %275
  %282 = load float** %281, align 8
  %283 = getelementptr inbounds float* %282, i64 %273
  %284 = load float* %283, align 4
  %285 = load i32* %k, align 4
  %286 = sext i32 %285 to i64
  %287 = load i32* %i, align 4
  %288 = sext i32 %287 to i64
  %289 = load float*** %new_centers, align 8
  %290 = getelementptr inbounds float** %289, i64 %288
  %291 = load float** %290, align 8
  %292 = getelementptr inbounds float* %291, i64 %286
  %293 = load float* %292, align 4
  %294 = fadd float %293, %284
  store float %294, float* %292, align 4
  %295 = load i32* %k, align 4
  %296 = sext i32 %295 to i64
  %297 = load i32* %i, align 4
  %298 = sext i32 %297 to i64
  %299 = load i32* %j, align 4
  %300 = sext i32 %299 to i64
  %301 = load float**** %partial_new_centers, align 8
  %302 = getelementptr inbounds float*** %301, i64 %300
  %303 = load float*** %302, align 8
  %304 = getelementptr inbounds float** %303, i64 %298
  %305 = load float** %304, align 8
  %306 = getelementptr inbounds float* %305, i64 %296
  store float 0.000000e+00, float* %306, align 4
  br label %307

; <label>:307                                     ; preds = %271
  %308 = load i32* %k, align 4
  %309 = add nsw i32 %308, 1
  store i32 %309, i32* %k, align 4
  br label %267

; <label>:310                                     ; preds = %267
  br label %311

; <label>:311                                     ; preds = %310
  %312 = load i32* %j, align 4
  %313 = add nsw i32 %312, 1
  store i32 %313, i32* %j, align 4
  br label %239

; <label>:314                                     ; preds = %239
  br label %315

; <label>:315                                     ; preds = %314
  %316 = load i32* %i, align 4
  %317 = add nsw i32 %316, 1
  store i32 %317, i32* %i, align 4
  br label %234

; <label>:318                                     ; preds = %234
  store i32 0, i32* %i, align 4
  br label %319

; <label>:319                                     ; preds = %377, %318
  %320 = load i32* %i, align 4
  %321 = load i32* %4, align 4
  %322 = icmp slt i32 %320, %321
  br i1 %322, label %323, label %380

; <label>:323                                     ; preds = %319
  store i32 0, i32* %j, align 4
  br label %324

; <label>:324                                     ; preds = %369, %323
  %325 = load i32* %j, align 4
  %326 = load i32* %2, align 4
  %327 = icmp slt i32 %325, %326
  br i1 %327, label %328, label %372

; <label>:328                                     ; preds = %324
  %329 = load i32* %i, align 4
  %330 = sext i32 %329 to i64
  %331 = load i32** %new_centers_len, align 8
  %332 = getelementptr inbounds i32* %331, i64 %330
  %333 = load i32* %332, align 4
  %334 = icmp sgt i32 %333, 0
  br i1 %334, label %335, label %360

; <label>:335                                     ; preds = %328
  %336 = load i32* %j, align 4
  %337 = sext i32 %336 to i64
  %338 = load i32* %i, align 4
  %339 = sext i32 %338 to i64
  %340 = load float*** %new_centers, align 8
  %341 = getelementptr inbounds float** %340, i64 %339
  %342 = load float** %341, align 8
  %343 = getelementptr inbounds float* %342, i64 %337
  %344 = load float* %343, align 4
  %345 = load i32* %i, align 4
  %346 = sext i32 %345 to i64
  %347 = load i32** %new_centers_len, align 8
  %348 = getelementptr inbounds i32* %347, i64 %346
  %349 = load i32* %348, align 4
  %350 = sitofp i32 %349 to float
  %351 = fdiv float %344, %350
  %352 = load i32* %j, align 4
  %353 = sext i32 %352 to i64
  %354 = load i32* %i, align 4
  %355 = sext i32 %354 to i64
  %356 = load float*** %clusters, align 8
  %357 = getelementptr inbounds float** %356, i64 %355
  %358 = load float** %357, align 8
  %359 = getelementptr inbounds float* %358, i64 %353
  store float %351, float* %359, align 4
  br label %360

; <label>:360                                     ; preds = %335, %328
  %361 = load i32* %j, align 4
  %362 = sext i32 %361 to i64
  %363 = load i32* %i, align 4
  %364 = sext i32 %363 to i64
  %365 = load float*** %new_centers, align 8
  %366 = getelementptr inbounds float** %365, i64 %364
  %367 = load float** %366, align 8
  %368 = getelementptr inbounds float* %367, i64 %362
  store float 0.000000e+00, float* %368, align 4
  br label %369

; <label>:369                                     ; preds = %360
  %370 = load i32* %j, align 4
  %371 = add nsw i32 %370, 1
  store i32 %371, i32* %j, align 4
  br label %324

; <label>:372                                     ; preds = %324
  %373 = load i32* %i, align 4
  %374 = sext i32 %373 to i64
  %375 = load i32** %new_centers_len, align 8
  %376 = getelementptr inbounds i32* %375, i64 %374
  store i32 0, i32* %376, align 4
  br label %377

; <label>:377                                     ; preds = %372
  %378 = load i32* %i, align 4
  %379 = add nsw i32 %378, 1
  store i32 %379, i32* %i, align 4
  br label %319

; <label>:380                                     ; preds = %319
  br label %381

; <label>:381                                     ; preds = %380
  %382 = load float* %delta, align 4
  %383 = load float* %5, align 4
  %384 = fcmp ogt float %382, %383
  br i1 %384, label %385, label %389

; <label>:385                                     ; preds = %381
  %386 = load i32* %loop, align 4
  %387 = add nsw i32 %386, 1
  store i32 %387, i32* %loop, align 4
  %388 = icmp slt i32 %386, 500
  br label %389

; <label>:389                                     ; preds = %385, %381
  %390 = phi i1 [ false, %381 ], [ %388, %385 ]
  br i1 %390, label %233, label %391

; <label>:391                                     ; preds = %389
  %392 = load float*** %new_centers, align 8
  %393 = getelementptr inbounds float** %392, i64 0
  %394 = load float** %393, align 8
  %395 = bitcast float* %394 to i8*
  call void @free(i8* %395) #5
  %396 = load float*** %new_centers, align 8
  %397 = bitcast float** %396 to i8*
  call void @free(i8* %397) #5
  %398 = load i32** %new_centers_len, align 8
  %399 = bitcast i32* %398 to i8*
  call void @free(i8* %399) #5
  %400 = load float*** %clusters, align 8
  ret float** %400
}

; Function Attrs: nounwind
declare noalias i8* @calloc(i64, i64) #3

; Function Attrs: inlinehint nounwind uwtable
define linkonce_odr float @_Z13euclid_dist_2PfS_i(float* %pt1, float* %pt2, i32 %numdims) #7 {
  %1 = alloca float*, align 8
  %2 = alloca float*, align 8
  %3 = alloca i32, align 4
  %i = alloca i32, align 4
  %ans = alloca float, align 4
  store float* %pt1, float** %1, align 8
  store float* %pt2, float** %2, align 8
  store i32 %numdims, i32* %3, align 4
  store float 0.000000e+00, float* %ans, align 4
  store i32 0, i32* %i, align 4
  br label %4

; <label>:4                                       ; preds = %34, %0
  %5 = load i32* %i, align 4
  %6 = load i32* %3, align 4
  %7 = icmp slt i32 %5, %6
  br i1 %7, label %8, label %37

; <label>:8                                       ; preds = %4
  %9 = load i32* %i, align 4
  %10 = sext i32 %9 to i64
  %11 = load float** %1, align 8
  %12 = getelementptr inbounds float* %11, i64 %10
  %13 = load float* %12, align 4
  %14 = load i32* %i, align 4
  %15 = sext i32 %14 to i64
  %16 = load float** %2, align 8
  %17 = getelementptr inbounds float* %16, i64 %15
  %18 = load float* %17, align 4
  %19 = fsub float %13, %18
  %20 = load i32* %i, align 4
  %21 = sext i32 %20 to i64
  %22 = load float** %1, align 8
  %23 = getelementptr inbounds float* %22, i64 %21
  %24 = load float* %23, align 4
  %25 = load i32* %i, align 4
  %26 = sext i32 %25 to i64
  %27 = load float** %2, align 8
  %28 = getelementptr inbounds float* %27, i64 %26
  %29 = load float* %28, align 4
  %30 = fsub float %24, %29
  %31 = fmul float %19, %30
  %32 = load float* %ans, align 4
  %33 = fadd float %32, %31
  store float %33, float* %ans, align 4
  br label %34

; <label>:34                                      ; preds = %8
  %35 = load i32* %i, align 4
  %36 = add nsw i32 %35, 1
  store i32 %36, i32* %i, align 4
  br label %4

; <label>:37                                      ; preds = %4
  %38 = load float* %ans, align 4
  ret float %38
}

attributes #0 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }
attributes #6 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { inlinehint nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { noreturn nounwind }
attributes #9 = { nounwind readonly }

!llvm.ident = !{!0, !0, !0, !0}

!0 = metadata !{metadata !"clang version 3.4 (tags/RELEASE_34/final)"}
