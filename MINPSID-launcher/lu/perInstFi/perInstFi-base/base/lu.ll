; ModuleID = 'lud.ll'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }
%struct.__stopwatch_t = type { %struct.timeval, %struct.timeval }
%struct.timeval = type { i64, i64 }
%struct.option = type { i8*, i32, i32*, i32 }
%struct.timezone = type { i32, i32 }

@omp_num_threads = global i32 1, align 4
@.str = private unnamed_addr constant [8 x i8] c"::vs:i:\00", align 1
@optarg = external global i8*
@do_verify = internal global i32 0, align 4
@stderr = external global %struct._IO_FILE*
@.str1 = private unnamed_addr constant [16 x i8] c"invalid option\0A\00", align 1
@.str2 = private unnamed_addr constant [18 x i8] c"missing argument\0A\00", align 1
@.str3 = private unnamed_addr constant [47 x i8] c"Usage: %s [-v] [-s matrix_size|-i input_file]\0A\00", align 1
@optind = external global i32
@.str4 = private unnamed_addr constant [67 x i8] c"Usage: %s [-v] [-n no. of threads] [-s matrix_size|-i input_file]\0A\00", align 1
@.str5 = private unnamed_addr constant [34 x i8] c"error create matrix from file %s\0A\00", align 1
@.str6 = private unnamed_addr constant [40 x i8] c"error create matrix internally size=%d\0A\00", align 1
@.str7 = private unnamed_addr constant [26 x i8] c"No input file specified!\0A\00", align 1
@.str8 = private unnamed_addr constant [6 x i8] c"input\00", align 1
@.str9 = private unnamed_addr constant [5 x i8] c"size\00", align 1
@.str10 = private unnamed_addr constant [7 x i8] c"verify\00", align 1
@long_options = internal global <{ { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] } }> <{ { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([6 x i8]* @.str8, i32 0, i32 0), i32 1, i32* null, i32 105, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([5 x i8]* @.str9, i32 0, i32 0), i32 1, i32* null, i32 115, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* getelementptr inbounds ([7 x i8]* @.str10, i32 0, i32 0), i32 0, i32* null, i32 118, [4 x i8] undef }, { i8*, i32, i32*, i32, [4 x i8] } { i8* null, i32 0, i32* null, i32 0, [4 x i8] undef } }>, align 16
@.str11 = private unnamed_addr constant [3 x i8] c"rb\00", align 1
@.str112 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@.str213 = private unnamed_addr constant [4 x i8] c"%f \00", align 1
@.str314 = private unnamed_addr constant [35 x i8] c"dismatch at (%d, %d): (o)%f (n)%f\0A\00", align 1
@.str415 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1

; Function Attrs: nounwind uwtable
define void @lud_omp(float* %a, i32 %size) #0 {
  %1 = alloca float*, align 8
  %2 = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %sum = alloca float, align 4
  store float* %a, float** %1, align 8
  store i32 %size, i32* %2, align 4
  store i32 0, i32* %i, align 4
  br label %3

; <label>:3                                       ; preds = %135, %0
  %4 = load i32* %i, align 4
  %5 = load i32* %2, align 4
  %6 = icmp slt i32 %4, %5
  br i1 %6, label %7, label %138

; <label>:7                                       ; preds = %3
  %8 = load i32* %i, align 4
  store i32 %8, i32* %j, align 4
  br label %9

; <label>:9                                       ; preds = %62, %7
  %10 = load i32* %j, align 4
  %11 = load i32* %2, align 4
  %12 = icmp slt i32 %10, %11
  br i1 %12, label %13, label %65

; <label>:13                                      ; preds = %9
  %14 = load i32* %i, align 4
  %15 = load i32* %2, align 4
  %16 = mul nsw i32 %14, %15
  %17 = load i32* %j, align 4
  %18 = add nsw i32 %16, %17
  %19 = sext i32 %18 to i64
  %20 = load float** %1, align 8
  %21 = getelementptr inbounds float* %20, i64 %19
  %22 = load float* %21, align 4
  store float %22, float* %sum, align 4
  store i32 0, i32* %k, align 4
  br label %23

; <label>:23                                      ; preds = %49, %13
  %24 = load i32* %k, align 4
  %25 = load i32* %i, align 4
  %26 = icmp slt i32 %24, %25
  br i1 %26, label %27, label %52

; <label>:27                                      ; preds = %23
  %28 = load i32* %i, align 4
  %29 = load i32* %2, align 4
  %30 = mul nsw i32 %28, %29
  %31 = load i32* %k, align 4
  %32 = add nsw i32 %30, %31
  %33 = sext i32 %32 to i64
  %34 = load float** %1, align 8
  %35 = getelementptr inbounds float* %34, i64 %33
  %36 = load float* %35, align 4
  %37 = load i32* %k, align 4
  %38 = load i32* %2, align 4
  %39 = mul nsw i32 %37, %38
  %40 = load i32* %j, align 4
  %41 = add nsw i32 %39, %40
  %42 = sext i32 %41 to i64
  %43 = load float** %1, align 8
  %44 = getelementptr inbounds float* %43, i64 %42
  %45 = load float* %44, align 4
  %46 = fmul float %36, %45
  %47 = load float* %sum, align 4
  %48 = fsub float %47, %46
  store float %48, float* %sum, align 4
  br label %49

; <label>:49                                      ; preds = %27
  %50 = load i32* %k, align 4
  %51 = add nsw i32 %50, 1
  store i32 %51, i32* %k, align 4
  br label %23

; <label>:52                                      ; preds = %23
  %53 = load float* %sum, align 4
  %54 = load i32* %i, align 4
  %55 = load i32* %2, align 4
  %56 = mul nsw i32 %54, %55
  %57 = load i32* %j, align 4
  %58 = add nsw i32 %56, %57
  %59 = sext i32 %58 to i64
  %60 = load float** %1, align 8
  %61 = getelementptr inbounds float* %60, i64 %59
  store float %53, float* %61, align 4
  br label %62

; <label>:62                                      ; preds = %52
  %63 = load i32* %j, align 4
  %64 = add nsw i32 %63, 1
  store i32 %64, i32* %j, align 4
  br label %9

; <label>:65                                      ; preds = %9
  %66 = load i32* %i, align 4
  %67 = add nsw i32 %66, 1
  store i32 %67, i32* %j, align 4
  br label %68

; <label>:68                                      ; preds = %131, %65
  %69 = load i32* %j, align 4
  %70 = load i32* %2, align 4
  %71 = icmp slt i32 %69, %70
  br i1 %71, label %72, label %134

; <label>:72                                      ; preds = %68
  %73 = load i32* %j, align 4
  %74 = load i32* %2, align 4
  %75 = mul nsw i32 %73, %74
  %76 = load i32* %i, align 4
  %77 = add nsw i32 %75, %76
  %78 = sext i32 %77 to i64
  %79 = load float** %1, align 8
  %80 = getelementptr inbounds float* %79, i64 %78
  %81 = load float* %80, align 4
  store float %81, float* %sum, align 4
  store i32 0, i32* %k, align 4
  br label %82

; <label>:82                                      ; preds = %108, %72
  %83 = load i32* %k, align 4
  %84 = load i32* %i, align 4
  %85 = icmp slt i32 %83, %84
  br i1 %85, label %86, label %111

; <label>:86                                      ; preds = %82
  %87 = load i32* %j, align 4
  %88 = load i32* %2, align 4
  %89 = mul nsw i32 %87, %88
  %90 = load i32* %k, align 4
  %91 = add nsw i32 %89, %90
  %92 = sext i32 %91 to i64
  %93 = load float** %1, align 8
  %94 = getelementptr inbounds float* %93, i64 %92
  %95 = load float* %94, align 4
  %96 = load i32* %k, align 4
  %97 = load i32* %2, align 4
  %98 = mul nsw i32 %96, %97
  %99 = load i32* %i, align 4
  %100 = add nsw i32 %98, %99
  %101 = sext i32 %100 to i64
  %102 = load float** %1, align 8
  %103 = getelementptr inbounds float* %102, i64 %101
  %104 = load float* %103, align 4
  %105 = fmul float %95, %104
  %106 = load float* %sum, align 4
  %107 = fsub float %106, %105
  store float %107, float* %sum, align 4
  br label %108

; <label>:108                                     ; preds = %86
  %109 = load i32* %k, align 4
  %110 = add nsw i32 %109, 1
  store i32 %110, i32* %k, align 4
  br label %82

; <label>:111                                     ; preds = %82
  %112 = load float* %sum, align 4
  %113 = load i32* %i, align 4
  %114 = load i32* %2, align 4
  %115 = mul nsw i32 %113, %114
  %116 = load i32* %i, align 4
  %117 = add nsw i32 %115, %116
  %118 = sext i32 %117 to i64
  %119 = load float** %1, align 8
  %120 = getelementptr inbounds float* %119, i64 %118
  %121 = load float* %120, align 4
  %122 = fdiv float %112, %121
  %123 = load i32* %j, align 4
  %124 = load i32* %2, align 4
  %125 = mul nsw i32 %123, %124
  %126 = load i32* %i, align 4
  %127 = add nsw i32 %125, %126
  %128 = sext i32 %127 to i64
  %129 = load float** %1, align 8
  %130 = getelementptr inbounds float* %129, i64 %128
  store float %122, float* %130, align 4
  br label %131

; <label>:131                                     ; preds = %111
  %132 = load i32* %j, align 4
  %133 = add nsw i32 %132, 1
  store i32 %133, i32* %j, align 4
  br label %68

; <label>:134                                     ; preds = %68
  br label %135

; <label>:135                                     ; preds = %134
  %136 = load i32* %i, align 4
  %137 = add nsw i32 %136, 1
  store i32 %137, i32* %i, align 4
  br label %3

; <label>:138                                     ; preds = %3
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %matrix_dim = alloca i32, align 4
  %opt = alloca i32, align 4
  %option_index = alloca i32, align 4
  %ret = alloca i32, align 4
  %input_file = alloca i8*, align 8
  %m = alloca float*, align 8
  %mm = alloca float*, align 8
  %sw = alloca %struct.__stopwatch_t, align 8
  store i32 0, i32* %1
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  store i32 32, i32* %matrix_dim, align 4
  store i32 0, i32* %option_index, align 4
  store i8* null, i8** %input_file, align 8
  br label %4

; <label>:4                                       ; preds = %29, %0
  %5 = load i32* %2, align 4
  %6 = load i8*** %3, align 8
  %7 = call i32 @getopt_long(i32 %5, i8** %6, i8* getelementptr inbounds ([8 x i8]* @.str, i32 0, i32 0), %struct.option* getelementptr inbounds ([4 x %struct.option]* bitcast (<{ { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] }, { i8*, i32, i32*, i32, [4 x i8] } }>* @long_options to [4 x %struct.option]*), i32 0, i32 0), i32* %option_index) #5
  store i32 %7, i32* %opt, align 4
  %8 = icmp ne i32 %7, -1
  br i1 %8, label %9, label %30

; <label>:9                                       ; preds = %4
  %10 = load i32* %opt, align 4
  switch i32 %10, label %23 [
    i32 105, label %11
    i32 118, label %13
    i32 115, label %14
    i32 63, label %17
    i32 58, label %20
  ]

; <label>:11                                      ; preds = %9
  %12 = load i8** @optarg, align 8
  store i8* %12, i8** %input_file, align 8
  br label %29

; <label>:13                                      ; preds = %9
  store i32 1, i32* @do_verify, align 4
  br label %29

; <label>:14                                      ; preds = %9
  %15 = load i8** @optarg, align 8
  %16 = call i32 @atoi(i8* %15) #7
  store i32 %16, i32* %matrix_dim, align 4
  br label %29

; <label>:17                                      ; preds = %9
  %18 = load %struct._IO_FILE** @stderr, align 8
  %19 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %18, i8* getelementptr inbounds ([16 x i8]* @.str1, i32 0, i32 0))
  br label %29

; <label>:20                                      ; preds = %9
  %21 = load %struct._IO_FILE** @stderr, align 8
  %22 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %21, i8* getelementptr inbounds ([18 x i8]* @.str2, i32 0, i32 0))
  br label %29

; <label>:23                                      ; preds = %9
  %24 = load %struct._IO_FILE** @stderr, align 8
  %25 = load i8*** %3, align 8
  %26 = getelementptr inbounds i8** %25, i64 0
  %27 = load i8** %26, align 8
  %28 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %24, i8* getelementptr inbounds ([47 x i8]* @.str3, i32 0, i32 0), i8* %27)
  call void @exit(i32 1) #8
  unreachable

; <label>:29                                      ; preds = %20, %17, %14, %13, %11
  br label %4

; <label>:30                                      ; preds = %4
  %31 = load i32* @optind, align 4
  %32 = load i32* %2, align 4
  %33 = icmp slt i32 %31, %32
  br i1 %33, label %37, label %34

; <label>:34                                      ; preds = %30
  %35 = load i32* @optind, align 4
  %36 = icmp eq i32 %35, 1
  br i1 %36, label %37, label %43

; <label>:37                                      ; preds = %34, %30
  %38 = load %struct._IO_FILE** @stderr, align 8
  %39 = load i8*** %3, align 8
  %40 = getelementptr inbounds i8** %39, i64 0
  %41 = load i8** %40, align 8
  %42 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %38, i8* getelementptr inbounds ([67 x i8]* @.str4, i32 0, i32 0), i8* %41)
  call void @exit(i32 1) #8
  unreachable

; <label>:43                                      ; preds = %34
  %44 = load i8** %input_file, align 8
  %45 = icmp ne i8* %44, null
  br i1 %45, label %46, label %56

; <label>:46                                      ; preds = %43
  %47 = load i8** %input_file, align 8
  %48 = call i32 @create_matrix_from_file(float** %m, i8* %47, i32* %matrix_dim)
  store i32 %48, i32* %ret, align 4
  %49 = load i32* %ret, align 4
  %50 = icmp ne i32 %49, 0
  br i1 %50, label %51, label %55

; <label>:51                                      ; preds = %46
  store float* null, float** %m, align 8
  %52 = load %struct._IO_FILE** @stderr, align 8
  %53 = load i8** %input_file, align 8
  %54 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %52, i8* getelementptr inbounds ([34 x i8]* @.str5, i32 0, i32 0), i8* %53)
  call void @exit(i32 1) #8
  unreachable

; <label>:55                                      ; preds = %46
  br label %72

; <label>:56                                      ; preds = %43
  %57 = load i32* %matrix_dim, align 4
  %58 = icmp ne i32 %57, 0
  br i1 %58, label %59, label %69

; <label>:59                                      ; preds = %56
  %60 = load i32* %matrix_dim, align 4
  %61 = call i32 @create_matrix(float** %m, i32 %60)
  store i32 %61, i32* %ret, align 4
  %62 = load i32* %ret, align 4
  %63 = icmp ne i32 %62, 0
  br i1 %63, label %64, label %68

; <label>:64                                      ; preds = %59
  store float* null, float** %m, align 8
  %65 = load %struct._IO_FILE** @stderr, align 8
  %66 = load i32* %matrix_dim, align 4
  %67 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %65, i8* getelementptr inbounds ([40 x i8]* @.str6, i32 0, i32 0), i32 %66)
  call void @exit(i32 1) #8
  unreachable

; <label>:68                                      ; preds = %59
  br label %71

; <label>:69                                      ; preds = %56
  %70 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([26 x i8]* @.str7, i32 0, i32 0))
  call void @exit(i32 1) #8
  unreachable

; <label>:71                                      ; preds = %68
  br label %72

; <label>:72                                      ; preds = %71, %55
  %73 = load i32* @do_verify, align 4
  %74 = icmp ne i32 %73, 0
  br i1 %74, label %75, label %78

; <label>:75                                      ; preds = %72
  %76 = load float** %m, align 8
  %77 = load i32* %matrix_dim, align 4
  call void @matrix_duplicate(float* %76, float** %mm, i32 %77)
  br label %78

; <label>:78                                      ; preds = %75, %72
  call void @stopwatch_start(%struct.__stopwatch_t* %sw)
  %79 = load float** %m, align 8
  %80 = load i32* %matrix_dim, align 4
  call void @lud_omp(float* %79, i32 %80)
  call void @stopwatch_stop(%struct.__stopwatch_t* %sw)
  %81 = load i32* @do_verify, align 4
  %82 = icmp ne i32 %81, 0
  br i1 %82, label %83, label %92

; <label>:83                                      ; preds = %78
  %84 = load float** %m, align 8
  %85 = load i32* %matrix_dim, align 4
  call void @print_matrix(float* %84, i32 %85)
  %86 = load float** %mm, align 8
  %87 = load float** %m, align 8
  %88 = load i32* %matrix_dim, align 4
  %89 = call i32 @lud_verify(float* %86, float* %87, i32 %88)
  %90 = load float** %mm, align 8
  %91 = bitcast float* %90 to i8*
  call void @free(i8* %91) #5
  br label %92

; <label>:92                                      ; preds = %83, %78
  %93 = load float** %m, align 8
  %94 = bitcast float* %93 to i8*
  call void @free(i8* %94) #5
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @getopt_long(i32, i8**, i8*, %struct.option*, i32*) #1

; Function Attrs: nounwind readonly
declare i32 @atoi(i8*) #2

declare i32 @fprintf(%struct._IO_FILE*, i8*, ...) #3

; Function Attrs: noreturn nounwind
declare void @exit(i32) #4

declare i32 @printf(i8*, ...) #3

; Function Attrs: nounwind
declare void @free(i8*) #1

; Function Attrs: nounwind uwtable
define void @stopwatch_start(%struct.__stopwatch_t* %sw) #0 {
  %1 = alloca %struct.__stopwatch_t*, align 8
  store %struct.__stopwatch_t* %sw, %struct.__stopwatch_t** %1, align 8
  %2 = load %struct.__stopwatch_t** %1, align 8
  %3 = icmp eq %struct.__stopwatch_t* %2, null
  br i1 %3, label %4, label %5

; <label>:4                                       ; preds = %0
  br label %15

; <label>:5                                       ; preds = %0
  %6 = load %struct.__stopwatch_t** %1, align 8
  %7 = getelementptr inbounds %struct.__stopwatch_t* %6, i32 0, i32 0
  %8 = bitcast %struct.timeval* %7 to i8*
  call void @llvm.memset.p0i8.i64(i8* %8, i8 0, i64 16, i32 8, i1 false)
  %9 = load %struct.__stopwatch_t** %1, align 8
  %10 = getelementptr inbounds %struct.__stopwatch_t* %9, i32 0, i32 1
  %11 = bitcast %struct.timeval* %10 to i8*
  call void @llvm.memset.p0i8.i64(i8* %11, i8 0, i64 16, i32 8, i1 false)
  %12 = load %struct.__stopwatch_t** %1, align 8
  %13 = getelementptr inbounds %struct.__stopwatch_t* %12, i32 0, i32 0
  %14 = call i32 @gettimeofday(%struct.timeval* %13, %struct.timezone* null) #5
  br label %15

; <label>:15                                      ; preds = %5, %4
  ret void
}

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #5

; Function Attrs: nounwind
declare i32 @gettimeofday(%struct.timeval*, %struct.timezone*) #1

; Function Attrs: nounwind uwtable
define void @stopwatch_stop(%struct.__stopwatch_t* %sw) #0 {
  %1 = alloca %struct.__stopwatch_t*, align 8
  store %struct.__stopwatch_t* %sw, %struct.__stopwatch_t** %1, align 8
  %2 = load %struct.__stopwatch_t** %1, align 8
  %3 = icmp eq %struct.__stopwatch_t* %2, null
  br i1 %3, label %4, label %5

; <label>:4                                       ; preds = %0
  br label %9

; <label>:5                                       ; preds = %0
  %6 = load %struct.__stopwatch_t** %1, align 8
  %7 = getelementptr inbounds %struct.__stopwatch_t* %6, i32 0, i32 1
  %8 = call i32 @gettimeofday(%struct.timeval* %7, %struct.timezone* null) #5
  br label %9

; <label>:9                                       ; preds = %5, %4
  ret void
}

; Function Attrs: nounwind uwtable
define double @get_interval_by_sec(%struct.__stopwatch_t* %sw) #0 {
  %1 = alloca double, align 8
  %2 = alloca %struct.__stopwatch_t*, align 8
  store %struct.__stopwatch_t* %sw, %struct.__stopwatch_t** %2, align 8
  %3 = load %struct.__stopwatch_t** %2, align 8
  %4 = icmp eq %struct.__stopwatch_t* %3, null
  br i1 %4, label %5, label %6

; <label>:5                                       ; preds = %0
  store double 0.000000e+00, double* %1
  br label %29

; <label>:6                                       ; preds = %0
  %7 = load %struct.__stopwatch_t** %2, align 8
  %8 = getelementptr inbounds %struct.__stopwatch_t* %7, i32 0, i32 1
  %9 = getelementptr inbounds %struct.timeval* %8, i32 0, i32 0
  %10 = load i64* %9, align 8
  %11 = load %struct.__stopwatch_t** %2, align 8
  %12 = getelementptr inbounds %struct.__stopwatch_t* %11, i32 0, i32 0
  %13 = getelementptr inbounds %struct.timeval* %12, i32 0, i32 0
  %14 = load i64* %13, align 8
  %15 = sub nsw i64 %10, %14
  %16 = sitofp i64 %15 to double
  %17 = load %struct.__stopwatch_t** %2, align 8
  %18 = getelementptr inbounds %struct.__stopwatch_t* %17, i32 0, i32 1
  %19 = getelementptr inbounds %struct.timeval* %18, i32 0, i32 1
  %20 = load i64* %19, align 8
  %21 = load %struct.__stopwatch_t** %2, align 8
  %22 = getelementptr inbounds %struct.__stopwatch_t* %21, i32 0, i32 0
  %23 = getelementptr inbounds %struct.timeval* %22, i32 0, i32 1
  %24 = load i64* %23, align 8
  %25 = sub nsw i64 %20, %24
  %26 = sitofp i64 %25 to double
  %27 = fdiv double %26, 1.000000e+06
  %28 = fadd double %16, %27
  store double %28, double* %1
  br label %29

; <label>:29                                      ; preds = %6, %5
  %30 = load double* %1
  ret double %30
}

; Function Attrs: nounwind uwtable
define i32 @get_interval_by_usec(%struct.__stopwatch_t* %sw) #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.__stopwatch_t*, align 8
  store %struct.__stopwatch_t* %sw, %struct.__stopwatch_t** %2, align 8
  %3 = load %struct.__stopwatch_t** %2, align 8
  %4 = icmp eq %struct.__stopwatch_t* %3, null
  br i1 %4, label %5, label %6

; <label>:5                                       ; preds = %0
  store i32 0, i32* %1
  br label %28

; <label>:6                                       ; preds = %0
  %7 = load %struct.__stopwatch_t** %2, align 8
  %8 = getelementptr inbounds %struct.__stopwatch_t* %7, i32 0, i32 1
  %9 = getelementptr inbounds %struct.timeval* %8, i32 0, i32 0
  %10 = load i64* %9, align 8
  %11 = load %struct.__stopwatch_t** %2, align 8
  %12 = getelementptr inbounds %struct.__stopwatch_t* %11, i32 0, i32 0
  %13 = getelementptr inbounds %struct.timeval* %12, i32 0, i32 0
  %14 = load i64* %13, align 8
  %15 = sub nsw i64 %10, %14
  %16 = mul nsw i64 %15, 1000000
  %17 = load %struct.__stopwatch_t** %2, align 8
  %18 = getelementptr inbounds %struct.__stopwatch_t* %17, i32 0, i32 1
  %19 = getelementptr inbounds %struct.timeval* %18, i32 0, i32 1
  %20 = load i64* %19, align 8
  %21 = load %struct.__stopwatch_t** %2, align 8
  %22 = getelementptr inbounds %struct.__stopwatch_t* %21, i32 0, i32 0
  %23 = getelementptr inbounds %struct.timeval* %22, i32 0, i32 1
  %24 = load i64* %23, align 8
  %25 = sub nsw i64 %20, %24
  %26 = add nsw i64 %16, %25
  %27 = trunc i64 %26 to i32
  store i32 %27, i32* %1
  br label %28

; <label>:28                                      ; preds = %6, %5
  %29 = load i32* %1
  ret i32 %29
}

; Function Attrs: nounwind uwtable
define i32 @create_matrix_from_file(float** %mp, i8* %filename, i32* %size_p) #0 {
  %1 = alloca i32, align 4
  %2 = alloca float**, align 8
  %3 = alloca i8*, align 8
  %4 = alloca i32*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %size = alloca i32, align 4
  %m = alloca float*, align 8
  %fp = alloca %struct._IO_FILE*, align 8
  store float** %mp, float*** %2, align 8
  store i8* %filename, i8** %3, align 8
  store i32* %size_p, i32** %4, align 8
  store %struct._IO_FILE* null, %struct._IO_FILE** %fp, align 8
  %5 = load i8** %3, align 8
  %6 = call %struct._IO_FILE* @fopen(i8* %5, i8* getelementptr inbounds ([3 x i8]* @.str11, i32 0, i32 0))
  store %struct._IO_FILE* %6, %struct._IO_FILE** %fp, align 8
  %7 = load %struct._IO_FILE** %fp, align 8
  %8 = icmp eq %struct._IO_FILE* %7, null
  br i1 %8, label %9, label %10

; <label>:9                                       ; preds = %0
  store i32 1, i32* %1
  br label %62

; <label>:10                                      ; preds = %0
  %11 = load %struct._IO_FILE** %fp, align 8
  %12 = call i32 (%struct._IO_FILE*, i8*, ...)* @__isoc99_fscanf(%struct._IO_FILE* %11, i8* getelementptr inbounds ([4 x i8]* @.str112, i32 0, i32 0), i32* %size)
  %13 = load i32* %size, align 4
  %14 = sext i32 %13 to i64
  %15 = mul i64 4, %14
  %16 = load i32* %size, align 4
  %17 = sext i32 %16 to i64
  %18 = mul i64 %15, %17
  %19 = call noalias i8* @malloc(i64 %18) #5
  %20 = bitcast i8* %19 to float*
  store float* %20, float** %m, align 8
  %21 = load float** %m, align 8
  %22 = icmp eq float* %21, null
  br i1 %22, label %23, label %26

; <label>:23                                      ; preds = %10
  %24 = load %struct._IO_FILE** %fp, align 8
  %25 = call i32 @fclose(%struct._IO_FILE* %24)
  store i32 1, i32* %1
  br label %62

; <label>:26                                      ; preds = %10
  store i32 0, i32* %i, align 4
  br label %27

; <label>:27                                      ; preds = %52, %26
  %28 = load i32* %i, align 4
  %29 = load i32* %size, align 4
  %30 = icmp slt i32 %28, %29
  br i1 %30, label %31, label %55

; <label>:31                                      ; preds = %27
  store i32 0, i32* %j, align 4
  br label %32

; <label>:32                                      ; preds = %48, %31
  %33 = load i32* %j, align 4
  %34 = load i32* %size, align 4
  %35 = icmp slt i32 %33, %34
  br i1 %35, label %36, label %51

; <label>:36                                      ; preds = %32
  %37 = load %struct._IO_FILE** %fp, align 8
  %38 = load float** %m, align 8
  %39 = load i32* %i, align 4
  %40 = load i32* %size, align 4
  %41 = mul nsw i32 %39, %40
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds float* %38, i64 %42
  %44 = load i32* %j, align 4
  %45 = sext i32 %44 to i64
  %46 = getelementptr inbounds float* %43, i64 %45
  %47 = call i32 (%struct._IO_FILE*, i8*, ...)* @__isoc99_fscanf(%struct._IO_FILE* %37, i8* getelementptr inbounds ([4 x i8]* @.str213, i32 0, i32 0), float* %46)
  br label %48

; <label>:48                                      ; preds = %36
  %49 = load i32* %j, align 4
  %50 = add nsw i32 %49, 1
  store i32 %50, i32* %j, align 4
  br label %32

; <label>:51                                      ; preds = %32
  br label %52

; <label>:52                                      ; preds = %51
  %53 = load i32* %i, align 4
  %54 = add nsw i32 %53, 1
  store i32 %54, i32* %i, align 4
  br label %27

; <label>:55                                      ; preds = %27
  %56 = load %struct._IO_FILE** %fp, align 8
  %57 = call i32 @fclose(%struct._IO_FILE* %56)
  %58 = load i32* %size, align 4
  %59 = load i32** %4, align 8
  store i32 %58, i32* %59, align 4
  %60 = load float** %m, align 8
  %61 = load float*** %2, align 8
  store float* %60, float** %61, align 8
  store i32 0, i32* %1
  br label %62

; <label>:62                                      ; preds = %55, %23, %9
  %63 = load i32* %1
  ret i32 %63
}

declare %struct._IO_FILE* @fopen(i8*, i8*) #3

declare i32 @__isoc99_fscanf(%struct._IO_FILE*, i8*, ...) #3

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #1

declare i32 @fclose(%struct._IO_FILE*) #3

; Function Attrs: nounwind uwtable
define i32 @create_matrix_from_random(float** %mp, i32 %size) #0 {
  %1 = alloca i32, align 4
  %2 = alloca float**, align 8
  %3 = alloca i32, align 4
  %l = alloca float*, align 8
  %u = alloca float*, align 8
  %m = alloca float*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  store float** %mp, float*** %2, align 8
  store i32 %size, i32* %3, align 4
  %4 = call i64 @time(i64* null) #5
  %5 = trunc i64 %4 to i32
  call void @srand(i32 %5) #5
  %6 = load i32* %3, align 4
  %7 = load i32* %3, align 4
  %8 = mul nsw i32 %6, %7
  %9 = sext i32 %8 to i64
  %10 = mul i64 %9, 4
  %11 = call noalias i8* @malloc(i64 %10) #5
  %12 = bitcast i8* %11 to float*
  store float* %12, float** %l, align 8
  %13 = load float** %l, align 8
  %14 = icmp eq float* %13, null
  br i1 %14, label %15, label %16

; <label>:15                                      ; preds = %0
  store i32 1, i32* %1
  br label %198

; <label>:16                                      ; preds = %0
  %17 = load i32* %3, align 4
  %18 = load i32* %3, align 4
  %19 = mul nsw i32 %17, %18
  %20 = sext i32 %19 to i64
  %21 = mul i64 %20, 4
  %22 = call noalias i8* @malloc(i64 %21) #5
  %23 = bitcast i8* %22 to float*
  store float* %23, float** %u, align 8
  %24 = load float** %u, align 8
  %25 = icmp eq float* %24, null
  br i1 %25, label %26, label %29

; <label>:26                                      ; preds = %16
  %27 = load float** %l, align 8
  %28 = bitcast float* %27 to i8*
  call void @free(i8* %28) #5
  store i32 1, i32* %1
  br label %198

; <label>:29                                      ; preds = %16
  store i32 0, i32* %i, align 4
  br label %30

; <label>:30                                      ; preds = %83, %29
  %31 = load i32* %i, align 4
  %32 = load i32* %3, align 4
  %33 = icmp slt i32 %31, %32
  br i1 %33, label %34, label %86

; <label>:34                                      ; preds = %30
  store i32 0, i32* %j, align 4
  br label %35

; <label>:35                                      ; preds = %79, %34
  %36 = load i32* %j, align 4
  %37 = load i32* %3, align 4
  %38 = icmp slt i32 %36, %37
  br i1 %38, label %39, label %82

; <label>:39                                      ; preds = %35
  %40 = load i32* %i, align 4
  %41 = load i32* %j, align 4
  %42 = icmp sgt i32 %40, %41
  br i1 %42, label %43, label %55

; <label>:43                                      ; preds = %39
  %44 = call i32 @rand() #5
  %45 = sitofp i32 %44 to float
  %46 = fdiv float %45, 0x41E0000000000000
  %47 = load i32* %i, align 4
  %48 = load i32* %3, align 4
  %49 = mul nsw i32 %47, %48
  %50 = load i32* %j, align 4
  %51 = add nsw i32 %49, %50
  %52 = sext i32 %51 to i64
  %53 = load float** %l, align 8
  %54 = getelementptr inbounds float* %53, i64 %52
  store float %46, float* %54, align 4
  br label %78

; <label>:55                                      ; preds = %39
  %56 = load i32* %i, align 4
  %57 = load i32* %j, align 4
  %58 = icmp eq i32 %56, %57
  br i1 %58, label %59, label %68

; <label>:59                                      ; preds = %55
  %60 = load i32* %i, align 4
  %61 = load i32* %3, align 4
  %62 = mul nsw i32 %60, %61
  %63 = load i32* %j, align 4
  %64 = add nsw i32 %62, %63
  %65 = sext i32 %64 to i64
  %66 = load float** %l, align 8
  %67 = getelementptr inbounds float* %66, i64 %65
  store float 1.000000e+00, float* %67, align 4
  br label %77

; <label>:68                                      ; preds = %55
  %69 = load i32* %i, align 4
  %70 = load i32* %3, align 4
  %71 = mul nsw i32 %69, %70
  %72 = load i32* %j, align 4
  %73 = add nsw i32 %71, %72
  %74 = sext i32 %73 to i64
  %75 = load float** %l, align 8
  %76 = getelementptr inbounds float* %75, i64 %74
  store float 0.000000e+00, float* %76, align 4
  br label %77

; <label>:77                                      ; preds = %68, %59
  br label %78

; <label>:78                                      ; preds = %77, %43
  br label %79

; <label>:79                                      ; preds = %78
  %80 = load i32* %j, align 4
  %81 = add nsw i32 %80, 1
  store i32 %81, i32* %j, align 4
  br label %35

; <label>:82                                      ; preds = %35
  br label %83

; <label>:83                                      ; preds = %82
  %84 = load i32* %i, align 4
  %85 = add nsw i32 %84, 1
  store i32 %85, i32* %i, align 4
  br label %30

; <label>:86                                      ; preds = %30
  store i32 0, i32* %j, align 4
  br label %87

; <label>:87                                      ; preds = %126, %86
  %88 = load i32* %j, align 4
  %89 = load i32* %3, align 4
  %90 = icmp slt i32 %88, %89
  br i1 %90, label %91, label %129

; <label>:91                                      ; preds = %87
  store i32 0, i32* %i, align 4
  br label %92

; <label>:92                                      ; preds = %122, %91
  %93 = load i32* %i, align 4
  %94 = load i32* %3, align 4
  %95 = icmp slt i32 %93, %94
  br i1 %95, label %96, label %125

; <label>:96                                      ; preds = %92
  %97 = load i32* %i, align 4
  %98 = load i32* %j, align 4
  %99 = icmp sgt i32 %97, %98
  br i1 %99, label %100, label %109

; <label>:100                                     ; preds = %96
  %101 = load i32* %j, align 4
  %102 = load i32* %3, align 4
  %103 = mul nsw i32 %101, %102
  %104 = load i32* %i, align 4
  %105 = add nsw i32 %103, %104
  %106 = sext i32 %105 to i64
  %107 = load float** %u, align 8
  %108 = getelementptr inbounds float* %107, i64 %106
  store float 0.000000e+00, float* %108, align 4
  br label %121

; <label>:109                                     ; preds = %96
  %110 = call i32 @rand() #5
  %111 = sitofp i32 %110 to float
  %112 = fdiv float %111, 0x41E0000000000000
  %113 = load i32* %j, align 4
  %114 = load i32* %3, align 4
  %115 = mul nsw i32 %113, %114
  %116 = load i32* %i, align 4
  %117 = add nsw i32 %115, %116
  %118 = sext i32 %117 to i64
  %119 = load float** %u, align 8
  %120 = getelementptr inbounds float* %119, i64 %118
  store float %112, float* %120, align 4
  br label %121

; <label>:121                                     ; preds = %109, %100
  br label %122

; <label>:122                                     ; preds = %121
  %123 = load i32* %i, align 4
  %124 = add nsw i32 %123, 1
  store i32 %124, i32* %i, align 4
  br label %92

; <label>:125                                     ; preds = %92
  br label %126

; <label>:126                                     ; preds = %125
  %127 = load i32* %j, align 4
  %128 = add nsw i32 %127, 1
  store i32 %128, i32* %j, align 4
  br label %87

; <label>:129                                     ; preds = %87
  store i32 0, i32* %i, align 4
  br label %130

; <label>:130                                     ; preds = %188, %129
  %131 = load i32* %i, align 4
  %132 = load i32* %3, align 4
  %133 = icmp slt i32 %131, %132
  br i1 %133, label %134, label %191

; <label>:134                                     ; preds = %130
  store i32 0, i32* %j, align 4
  br label %135

; <label>:135                                     ; preds = %184, %134
  %136 = load i32* %j, align 4
  %137 = load i32* %3, align 4
  %138 = icmp slt i32 %136, %137
  br i1 %138, label %139, label %187

; <label>:139                                     ; preds = %135
  store i32 0, i32* %k, align 4
  br label %140

; <label>:140                                     ; preds = %180, %139
  %141 = load i32* %k, align 4
  %142 = load i32* %i, align 4
  %143 = load i32* %j, align 4
  %144 = icmp slt i32 %142, %143
  br i1 %144, label %145, label %147

; <label>:145                                     ; preds = %140
  %146 = load i32* %i, align 4
  br label %149

; <label>:147                                     ; preds = %140
  %148 = load i32* %j, align 4
  br label %149

; <label>:149                                     ; preds = %147, %145
  %150 = phi i32 [ %146, %145 ], [ %148, %147 ]
  %151 = icmp sle i32 %141, %150
  br i1 %151, label %152, label %183

; <label>:152                                     ; preds = %149
  %153 = load i32* %i, align 4
  %154 = load i32* %3, align 4
  %155 = mul nsw i32 %153, %154
  %156 = load i32* %k, align 4
  %157 = add nsw i32 %155, %156
  %158 = sext i32 %157 to i64
  %159 = load float** %l, align 8
  %160 = getelementptr inbounds float* %159, i64 %158
  %161 = load float* %160, align 4
  %162 = load i32* %j, align 4
  %163 = load i32* %3, align 4
  %164 = mul nsw i32 %162, %163
  %165 = load i32* %k, align 4
  %166 = add nsw i32 %164, %165
  %167 = sext i32 %166 to i64
  %168 = load float** %u, align 8
  %169 = getelementptr inbounds float* %168, i64 %167
  %170 = load float* %169, align 4
  %171 = fmul float %161, %170
  %172 = load i32* %i, align 4
  %173 = load i32* %3, align 4
  %174 = mul nsw i32 %172, %173
  %175 = load i32* %j, align 4
  %176 = add nsw i32 %174, %175
  %177 = sext i32 %176 to i64
  %178 = load float** %m, align 8
  %179 = getelementptr inbounds float* %178, i64 %177
  store float %171, float* %179, align 4
  br label %180

; <label>:180                                     ; preds = %152
  %181 = load i32* %k, align 4
  %182 = add nsw i32 %181, 1
  store i32 %182, i32* %k, align 4
  br label %140

; <label>:183                                     ; preds = %149
  br label %184

; <label>:184                                     ; preds = %183
  %185 = load i32* %j, align 4
  %186 = add nsw i32 %185, 1
  store i32 %186, i32* %j, align 4
  br label %135

; <label>:187                                     ; preds = %135
  br label %188

; <label>:188                                     ; preds = %187
  %189 = load i32* %i, align 4
  %190 = add nsw i32 %189, 1
  store i32 %190, i32* %i, align 4
  br label %130

; <label>:191                                     ; preds = %130
  %192 = load float** %l, align 8
  %193 = bitcast float* %192 to i8*
  call void @free(i8* %193) #5
  %194 = load float** %u, align 8
  %195 = bitcast float* %194 to i8*
  call void @free(i8* %195) #5
  %196 = load float** %m, align 8
  %197 = load float*** %2, align 8
  store float* %196, float** %197, align 8
  store i32 0, i32* %1
  br label %198

; <label>:198                                     ; preds = %191, %26, %15
  %199 = load i32* %1
  ret i32 %199
}

; Function Attrs: nounwind
declare void @srand(i32) #1

; Function Attrs: nounwind
declare i64 @time(i64*) #1

; Function Attrs: nounwind
declare i32 @rand() #1

; Function Attrs: nounwind uwtable
define void @matrix_multiply(float* %inputa, float* %inputb, float* %output, i32 %size) #0 {
  %1 = alloca float*, align 8
  %2 = alloca float*, align 8
  %3 = alloca float*, align 8
  %4 = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  store float* %inputa, float** %1, align 8
  store float* %inputb, float** %2, align 8
  store float* %output, float** %3, align 8
  store i32 %size, i32* %4, align 4
  store i32 0, i32* %i, align 4
  br label %5

; <label>:5                                       ; preds = %55, %0
  %6 = load i32* %i, align 4
  %7 = load i32* %4, align 4
  %8 = icmp slt i32 %6, %7
  br i1 %8, label %9, label %58

; <label>:9                                       ; preds = %5
  store i32 0, i32* %k, align 4
  br label %10

; <label>:10                                      ; preds = %51, %9
  %11 = load i32* %k, align 4
  %12 = load i32* %4, align 4
  %13 = icmp slt i32 %11, %12
  br i1 %13, label %14, label %54

; <label>:14                                      ; preds = %10
  store i32 0, i32* %j, align 4
  br label %15

; <label>:15                                      ; preds = %47, %14
  %16 = load i32* %j, align 4
  %17 = load i32* %4, align 4
  %18 = icmp slt i32 %16, %17
  br i1 %18, label %19, label %50

; <label>:19                                      ; preds = %15
  %20 = load i32* %i, align 4
  %21 = load i32* %4, align 4
  %22 = mul nsw i32 %20, %21
  %23 = load i32* %k, align 4
  %24 = add nsw i32 %22, %23
  %25 = sext i32 %24 to i64
  %26 = load float** %1, align 8
  %27 = getelementptr inbounds float* %26, i64 %25
  %28 = load float* %27, align 4
  %29 = load i32* %k, align 4
  %30 = load i32* %4, align 4
  %31 = mul nsw i32 %29, %30
  %32 = load i32* %j, align 4
  %33 = add nsw i32 %31, %32
  %34 = sext i32 %33 to i64
  %35 = load float** %2, align 8
  %36 = getelementptr inbounds float* %35, i64 %34
  %37 = load float* %36, align 4
  %38 = fmul float %28, %37
  %39 = load i32* %i, align 4
  %40 = load i32* %4, align 4
  %41 = mul nsw i32 %39, %40
  %42 = load i32* %j, align 4
  %43 = add nsw i32 %41, %42
  %44 = sext i32 %43 to i64
  %45 = load float** %3, align 8
  %46 = getelementptr inbounds float* %45, i64 %44
  store float %38, float* %46, align 4
  br label %47

; <label>:47                                      ; preds = %19
  %48 = load i32* %j, align 4
  %49 = add nsw i32 %48, 1
  store i32 %49, i32* %j, align 4
  br label %15

; <label>:50                                      ; preds = %15
  br label %51

; <label>:51                                      ; preds = %50
  %52 = load i32* %k, align 4
  %53 = add nsw i32 %52, 1
  store i32 %53, i32* %k, align 4
  br label %10

; <label>:54                                      ; preds = %10
  br label %55

; <label>:55                                      ; preds = %54
  %56 = load i32* %i, align 4
  %57 = add nsw i32 %56, 1
  store i32 %57, i32* %i, align 4
  br label %5

; <label>:58                                      ; preds = %5
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @lud_verify(float* %m, float* %lu, i32 %matrix_dim) #0 {
  %1 = alloca i32, align 4
  %2 = alloca float*, align 8
  %3 = alloca float*, align 8
  %4 = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %tmp = alloca float*, align 8
  %sum = alloca float, align 4
  %l = alloca float, align 4
  %u = alloca float, align 4
  store float* %m, float** %2, align 8
  store float* %lu, float** %3, align 8
  store i32 %matrix_dim, i32* %4, align 4
  %5 = load i32* %4, align 4
  %6 = load i32* %4, align 4
  %7 = mul nsw i32 %5, %6
  %8 = sext i32 %7 to i64
  %9 = mul i64 %8, 4
  %10 = call noalias i8* @malloc(i64 %9) #5
  %11 = bitcast i8* %10 to float*
  store float* %11, float** %tmp, align 8
  store i32 0, i32* %i, align 4
  br label %12

; <label>:12                                      ; preds = %81, %0
  %13 = load i32* %i, align 4
  %14 = load i32* %4, align 4
  %15 = icmp slt i32 %13, %14
  br i1 %15, label %16, label %84

; <label>:16                                      ; preds = %12
  store i32 0, i32* %j, align 4
  br label %17

; <label>:17                                      ; preds = %77, %16
  %18 = load i32* %j, align 4
  %19 = load i32* %4, align 4
  %20 = icmp slt i32 %18, %19
  br i1 %20, label %21, label %80

; <label>:21                                      ; preds = %17
  store float 0.000000e+00, float* %sum, align 4
  store i32 0, i32* %k, align 4
  br label %22

; <label>:22                                      ; preds = %64, %21
  %23 = load i32* %k, align 4
  %24 = load i32* %i, align 4
  %25 = load i32* %j, align 4
  %26 = icmp slt i32 %24, %25
  br i1 %26, label %27, label %29

; <label>:27                                      ; preds = %22
  %28 = load i32* %i, align 4
  br label %31

; <label>:29                                      ; preds = %22
  %30 = load i32* %j, align 4
  br label %31

; <label>:31                                      ; preds = %29, %27
  %32 = phi i32 [ %28, %27 ], [ %30, %29 ]
  %33 = icmp sle i32 %23, %32
  br i1 %33, label %34, label %67

; <label>:34                                      ; preds = %31
  %35 = load i32* %i, align 4
  %36 = load i32* %k, align 4
  %37 = icmp eq i32 %35, %36
  br i1 %37, label %38, label %39

; <label>:38                                      ; preds = %34
  store float 1.000000e+00, float* %l, align 4
  br label %49

; <label>:39                                      ; preds = %34
  %40 = load i32* %i, align 4
  %41 = load i32* %4, align 4
  %42 = mul nsw i32 %40, %41
  %43 = load i32* %k, align 4
  %44 = add nsw i32 %42, %43
  %45 = sext i32 %44 to i64
  %46 = load float** %3, align 8
  %47 = getelementptr inbounds float* %46, i64 %45
  %48 = load float* %47, align 4
  store float %48, float* %l, align 4
  br label %49

; <label>:49                                      ; preds = %39, %38
  %50 = load i32* %k, align 4
  %51 = load i32* %4, align 4
  %52 = mul nsw i32 %50, %51
  %53 = load i32* %j, align 4
  %54 = add nsw i32 %52, %53
  %55 = sext i32 %54 to i64
  %56 = load float** %3, align 8
  %57 = getelementptr inbounds float* %56, i64 %55
  %58 = load float* %57, align 4
  store float %58, float* %u, align 4
  %59 = load float* %l, align 4
  %60 = load float* %u, align 4
  %61 = fmul float %59, %60
  %62 = load float* %sum, align 4
  %63 = fadd float %62, %61
  store float %63, float* %sum, align 4
  br label %64

; <label>:64                                      ; preds = %49
  %65 = load i32* %k, align 4
  %66 = add nsw i32 %65, 1
  store i32 %66, i32* %k, align 4
  br label %22

; <label>:67                                      ; preds = %31
  %68 = load float* %sum, align 4
  %69 = load i32* %i, align 4
  %70 = load i32* %4, align 4
  %71 = mul nsw i32 %69, %70
  %72 = load i32* %j, align 4
  %73 = add nsw i32 %71, %72
  %74 = sext i32 %73 to i64
  %75 = load float** %tmp, align 8
  %76 = getelementptr inbounds float* %75, i64 %74
  store float %68, float* %76, align 4
  br label %77

; <label>:77                                      ; preds = %67
  %78 = load i32* %j, align 4
  %79 = add nsw i32 %78, 1
  store i32 %79, i32* %j, align 4
  br label %17

; <label>:80                                      ; preds = %17
  br label %81

; <label>:81                                      ; preds = %80
  %82 = load i32* %i, align 4
  %83 = add nsw i32 %82, 1
  store i32 %83, i32* %i, align 4
  br label %12

; <label>:84                                      ; preds = %12
  store i32 0, i32* %i, align 4
  br label %85

; <label>:85                                      ; preds = %146, %84
  %86 = load i32* %i, align 4
  %87 = load i32* %4, align 4
  %88 = icmp slt i32 %86, %87
  br i1 %88, label %89, label %149

; <label>:89                                      ; preds = %85
  store i32 0, i32* %j, align 4
  br label %90

; <label>:90                                      ; preds = %142, %89
  %91 = load i32* %j, align 4
  %92 = load i32* %4, align 4
  %93 = icmp slt i32 %91, %92
  br i1 %93, label %94, label %145

; <label>:94                                      ; preds = %90
  %95 = load i32* %i, align 4
  %96 = load i32* %4, align 4
  %97 = mul nsw i32 %95, %96
  %98 = load i32* %j, align 4
  %99 = add nsw i32 %97, %98
  %100 = sext i32 %99 to i64
  %101 = load float** %2, align 8
  %102 = getelementptr inbounds float* %101, i64 %100
  %103 = load float* %102, align 4
  %104 = load i32* %i, align 4
  %105 = load i32* %4, align 4
  %106 = mul nsw i32 %104, %105
  %107 = load i32* %j, align 4
  %108 = add nsw i32 %106, %107
  %109 = sext i32 %108 to i64
  %110 = load float** %tmp, align 8
  %111 = getelementptr inbounds float* %110, i64 %109
  %112 = load float* %111, align 4
  %113 = fsub float %103, %112
  %114 = fpext float %113 to double
  %115 = call double @fabs(double %114) #9
  %116 = fcmp ogt double %115, 1.000000e-04
  br i1 %116, label %117, label %141

; <label>:117                                     ; preds = %94
  %118 = load i32* %i, align 4
  %119 = load i32* %j, align 4
  %120 = load i32* %i, align 4
  %121 = load i32* %4, align 4
  %122 = mul nsw i32 %120, %121
  %123 = load i32* %j, align 4
  %124 = add nsw i32 %122, %123
  %125 = sext i32 %124 to i64
  %126 = load float** %2, align 8
  %127 = getelementptr inbounds float* %126, i64 %125
  %128 = load float* %127, align 4
  %129 = fpext float %128 to double
  %130 = load i32* %i, align 4
  %131 = load i32* %4, align 4
  %132 = mul nsw i32 %130, %131
  %133 = load i32* %j, align 4
  %134 = add nsw i32 %132, %133
  %135 = sext i32 %134 to i64
  %136 = load float** %tmp, align 8
  %137 = getelementptr inbounds float* %136, i64 %135
  %138 = load float* %137, align 4
  %139 = fpext float %138 to double
  %140 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str314, i32 0, i32 0), i32 %118, i32 %119, double %129, double %139)
  br label %141

; <label>:141                                     ; preds = %117, %94
  br label %142

; <label>:142                                     ; preds = %141
  %143 = load i32* %j, align 4
  %144 = add nsw i32 %143, 1
  store i32 %144, i32* %j, align 4
  br label %90

; <label>:145                                     ; preds = %90
  br label %146

; <label>:146                                     ; preds = %145
  %147 = load i32* %i, align 4
  %148 = add nsw i32 %147, 1
  store i32 %148, i32* %i, align 4
  br label %85

; <label>:149                                     ; preds = %85
  %150 = load float** %tmp, align 8
  %151 = bitcast float* %150 to i8*
  call void @free(i8* %151) #5
  %152 = load i32* %1
  ret i32 %152
}

; Function Attrs: nounwind readnone
declare double @fabs(double) #6

; Function Attrs: nounwind uwtable
define void @matrix_duplicate(float* %src, float** %dst, i32 %matrix_dim) #0 {
  %1 = alloca float*, align 8
  %2 = alloca float**, align 8
  %3 = alloca i32, align 4
  %s = alloca i32, align 4
  %p = alloca float*, align 8
  store float* %src, float** %1, align 8
  store float** %dst, float*** %2, align 8
  store i32 %matrix_dim, i32* %3, align 4
  %4 = load i32* %3, align 4
  %5 = load i32* %3, align 4
  %6 = mul nsw i32 %4, %5
  %7 = sext i32 %6 to i64
  %8 = mul i64 %7, 4
  %9 = trunc i64 %8 to i32
  store i32 %9, i32* %s, align 4
  %10 = load i32* %s, align 4
  %11 = sext i32 %10 to i64
  %12 = call noalias i8* @malloc(i64 %11) #5
  %13 = bitcast i8* %12 to float*
  store float* %13, float** %p, align 8
  %14 = load float** %p, align 8
  %15 = bitcast float* %14 to i8*
  %16 = load float** %1, align 8
  %17 = bitcast float* %16 to i8*
  %18 = load i32* %s, align 4
  %19 = sext i32 %18 to i64
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %15, i8* %17, i64 %19, i32 4, i1 false)
  %20 = load float** %p, align 8
  %21 = load float*** %2, align 8
  store float* %20, float** %21, align 8
  ret void
}

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #5

; Function Attrs: nounwind uwtable
define void @print_matrix(float* %m, i32 %matrix_dim) #0 {
  %1 = alloca float*, align 8
  %2 = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store float* %m, float** %1, align 8
  store i32 %matrix_dim, i32* %2, align 4
  store i32 0, i32* %i, align 4
  br label %3

; <label>:3                                       ; preds = %29, %0
  %4 = load i32* %i, align 4
  %5 = load i32* %2, align 4
  %6 = icmp slt i32 %4, %5
  br i1 %6, label %7, label %32

; <label>:7                                       ; preds = %3
  store i32 0, i32* %j, align 4
  br label %8

; <label>:8                                       ; preds = %24, %7
  %9 = load i32* %j, align 4
  %10 = load i32* %2, align 4
  %11 = icmp slt i32 %9, %10
  br i1 %11, label %12, label %27

; <label>:12                                      ; preds = %8
  %13 = load i32* %i, align 4
  %14 = load i32* %2, align 4
  %15 = mul nsw i32 %13, %14
  %16 = load i32* %j, align 4
  %17 = add nsw i32 %15, %16
  %18 = sext i32 %17 to i64
  %19 = load float** %1, align 8
  %20 = getelementptr inbounds float* %19, i64 %18
  %21 = load float* %20, align 4
  %22 = fpext float %21 to double
  %23 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str213, i32 0, i32 0), double %22)
  br label %24

; <label>:24                                      ; preds = %12
  %25 = load i32* %j, align 4
  %26 = add nsw i32 %25, 1
  store i32 %26, i32* %j, align 4
  br label %8

; <label>:27                                      ; preds = %8
  %28 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([2 x i8]* @.str415, i32 0, i32 0))
  br label %29

; <label>:29                                      ; preds = %27
  %30 = load i32* %i, align 4
  %31 = add nsw i32 %30, 1
  store i32 %31, i32* %i, align 4
  br label %3

; <label>:32                                      ; preds = %3
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @create_matrix(float** %mp, i32 %size) #0 {
  %1 = alloca i32, align 4
  %2 = alloca float**, align 8
  %3 = alloca i32, align 4
  %m = alloca float*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %lamda = alloca float, align 4
  %4 = alloca i8*
  %coe_i = alloca float, align 4
  %5 = alloca i32
  store float** %mp, float*** %2, align 8
  store i32 %size, i32* %3, align 4
  store float 0xBF50624DE0000000, float* %lamda, align 4
  %6 = load i32* %3, align 4
  %7 = mul nsw i32 2, %6
  %8 = sub nsw i32 %7, 1
  %9 = zext i32 %8 to i64
  %10 = call i8* @llvm.stacksave()
  store i8* %10, i8** %4
  %11 = alloca float, i64 %9, align 16
  store float 0.000000e+00, float* %coe_i, align 4
  store i32 0, i32* %i, align 4
  br label %12

; <label>:12                                      ; preds = %41, %0
  %13 = load i32* %i, align 4
  %14 = load i32* %3, align 4
  %15 = icmp slt i32 %13, %14
  br i1 %15, label %16, label %44

; <label>:16                                      ; preds = %12
  %17 = load float* %lamda, align 4
  %18 = load i32* %i, align 4
  %19 = sitofp i32 %18 to float
  %20 = fmul float %17, %19
  %21 = fpext float %20 to double
  %22 = call double @exp(double %21) #5
  %23 = fmul double 1.000000e+01, %22
  %24 = fptrunc double %23 to float
  store float %24, float* %coe_i, align 4
  %25 = load i32* %3, align 4
  %26 = sub nsw i32 %25, 1
  %27 = load i32* %i, align 4
  %28 = add nsw i32 %26, %27
  store i32 %28, i32* %j, align 4
  %29 = load float* %coe_i, align 4
  %30 = load i32* %j, align 4
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds float* %11, i64 %31
  store float %29, float* %32, align 4
  %33 = load i32* %3, align 4
  %34 = sub nsw i32 %33, 1
  %35 = load i32* %i, align 4
  %36 = sub nsw i32 %34, %35
  store i32 %36, i32* %j, align 4
  %37 = load float* %coe_i, align 4
  %38 = load i32* %j, align 4
  %39 = sext i32 %38 to i64
  %40 = getelementptr inbounds float* %11, i64 %39
  store float %37, float* %40, align 4
  br label %41

; <label>:41                                      ; preds = %16
  %42 = load i32* %i, align 4
  %43 = add nsw i32 %42, 1
  store i32 %43, i32* %i, align 4
  br label %12

; <label>:44                                      ; preds = %12
  %45 = load i32* %3, align 4
  %46 = sext i32 %45 to i64
  %47 = mul i64 4, %46
  %48 = load i32* %3, align 4
  %49 = sext i32 %48 to i64
  %50 = mul i64 %47, %49
  %51 = call noalias i8* @malloc(i64 %50) #5
  %52 = bitcast i8* %51 to float*
  store float* %52, float** %m, align 8
  %53 = load float** %m, align 8
  %54 = icmp eq float* %53, null
  br i1 %54, label %55, label %56

; <label>:55                                      ; preds = %44
  store i32 1, i32* %1
  store i32 1, i32* %5
  br label %94

; <label>:56                                      ; preds = %44
  store i32 0, i32* %i, align 4
  br label %57

; <label>:57                                      ; preds = %88, %56
  %58 = load i32* %i, align 4
  %59 = load i32* %3, align 4
  %60 = icmp slt i32 %58, %59
  br i1 %60, label %61, label %91

; <label>:61                                      ; preds = %57
  store i32 0, i32* %j, align 4
  br label %62

; <label>:62                                      ; preds = %84, %61
  %63 = load i32* %j, align 4
  %64 = load i32* %3, align 4
  %65 = icmp slt i32 %63, %64
  br i1 %65, label %66, label %87

; <label>:66                                      ; preds = %62
  %67 = load i32* %3, align 4
  %68 = sub nsw i32 %67, 1
  %69 = load i32* %i, align 4
  %70 = sub nsw i32 %68, %69
  %71 = load i32* %j, align 4
  %72 = add nsw i32 %70, %71
  %73 = sext i32 %72 to i64
  %74 = getelementptr inbounds float* %11, i64 %73
  %75 = load float* %74, align 4
  %76 = load i32* %i, align 4
  %77 = load i32* %3, align 4
  %78 = mul nsw i32 %76, %77
  %79 = load i32* %j, align 4
  %80 = add nsw i32 %78, %79
  %81 = sext i32 %80 to i64
  %82 = load float** %m, align 8
  %83 = getelementptr inbounds float* %82, i64 %81
  store float %75, float* %83, align 4
  br label %84

; <label>:84                                      ; preds = %66
  %85 = load i32* %j, align 4
  %86 = add nsw i32 %85, 1
  store i32 %86, i32* %j, align 4
  br label %62

; <label>:87                                      ; preds = %62
  br label %88

; <label>:88                                      ; preds = %87
  %89 = load i32* %i, align 4
  %90 = add nsw i32 %89, 1
  store i32 %90, i32* %i, align 4
  br label %57

; <label>:91                                      ; preds = %57
  %92 = load float** %m, align 8
  %93 = load float*** %2, align 8
  store float* %92, float** %93, align 8
  store i32 0, i32* %1
  store i32 1, i32* %5
  br label %94

; <label>:94                                      ; preds = %91, %55
  %95 = load i8** %4
  call void @llvm.stackrestore(i8* %95)
  %96 = load i32* %1
  ret i32 %96
}

; Function Attrs: nounwind
declare i8* @llvm.stacksave() #5

; Function Attrs: nounwind
declare double @exp(double) #1

; Function Attrs: nounwind
declare void @llvm.stackrestore(i8*) #5

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }
attributes #6 = { nounwind readnone "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nounwind readonly }
attributes #8 = { noreturn nounwind }
attributes #9 = { nounwind readnone }

!llvm.ident = !{!0, !0}

!0 = metadata !{metadata !"clang version 3.4 (tags/RELEASE_34/final)"}
