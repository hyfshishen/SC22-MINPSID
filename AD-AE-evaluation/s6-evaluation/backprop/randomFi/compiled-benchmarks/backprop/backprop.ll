; ModuleID = 'backprop_kernel.ll'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }
%struct.timeval = type { i64, i64 }
%struct.timezone = type { i32, i32 }
%struct.BPNN = type { i32, i32, i32, float*, float*, float*, float*, float*, float*, float**, float**, float**, float** }

@.str = private unnamed_addr constant [28 x i8] c"Performing CPU computation\0A\00", align 1
@.str1 = private unnamed_addr constant [49 x i8] c"ALLOC_1D_DBL: Couldn't allocate array of floats\0A\00", align 1
@.str12 = private unnamed_addr constant [51 x i8] c"ALLOC_2D_DBL: Couldn't allocate array of dbl ptrs\0A\00", align 1
@.str2 = private unnamed_addr constant [34 x i8] c"Random number generator seed: %d\0A\00", align 1
@.str3 = private unnamed_addr constant [47 x i8] c"BPNN_CREATE: Couldn't allocate neural network\0A\00", align 1
@.str4 = private unnamed_addr constant [3 x i8] c"w+\00", align 1
@.str5 = private unnamed_addr constant [33 x i8] c"Saving %dx%dx%d network to '%s'\0A\00", align 1
@.str6 = private unnamed_addr constant [14 x i8] c"Reading '%s'\0A\00", align 1
@.str7 = private unnamed_addr constant [34 x i8] c"'%s' contains a %dx%dx%d network\0A\00", align 1
@.str8 = private unnamed_addr constant [25 x i8] c"Reading input weights...\00", align 1
@.str9 = private unnamed_addr constant [31 x i8] c"Done\0AReading hidden weights...\00", align 1
@.str10 = private unnamed_addr constant [6 x i8] c"Done\0A\00", align 1
@layer_size = global i32 0, align 4
@.str11 = private unnamed_addr constant [23 x i8] c"Input layer size : %d\0A\00", align 1
@.str112 = private unnamed_addr constant [26 x i8] c"Starting training kernel\0A\00", align 1
@.str213 = private unnamed_addr constant [11 x i8] c"output.dat\00", align 1
@.str314 = private unnamed_addr constant [15 x i8] c"Training done\0A\00", align 1
@stderr = external global %struct._IO_FILE*
@.str415 = private unnamed_addr constant [41 x i8] c"usage: backprop <num of input elements>\0A\00", align 1
@.str516 = private unnamed_addr constant [50 x i8] c"The number of input points must be divided by 16\0A\00", align 1

; Function Attrs: nounwind uwtable
define double @gettime() #0 {
  %t = alloca %struct.timeval, align 8
  %1 = call i32 @gettimeofday(%struct.timeval* %t, %struct.timezone* null) #5
  %2 = getelementptr inbounds %struct.timeval* %t, i32 0, i32 0
  %3 = load i64* %2, align 8
  %4 = sitofp i64 %3 to double
  %5 = getelementptr inbounds %struct.timeval* %t, i32 0, i32 1
  %6 = load i64* %5, align 8
  %7 = sitofp i64 %6 to double
  %8 = fmul double %7, 1.000000e-06
  %9 = fadd double %4, %8
  ret double %9
}

; Function Attrs: nounwind
declare i32 @gettimeofday(%struct.timeval*, %struct.timezone*) #1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i8**, align 8
  store i32 %argc, i32* %1, align 4
  store i8** %argv, i8*** %2, align 8
  %3 = load i32* %1, align 4
  %4 = load i8*** %2, align 8
  %5 = call i32 @setup(i32 %3, i8** %4)
  ret i32 0
}

; Function Attrs: nounwind uwtable
define void @bpnn_train_kernel(%struct.BPNN* %net, float* %eo, float* %eh) #0 {
  %1 = alloca %struct.BPNN*, align 8
  %2 = alloca float*, align 8
  %3 = alloca float*, align 8
  %in = alloca i32, align 4
  %hid = alloca i32, align 4
  %out = alloca i32, align 4
  %out_err = alloca float, align 4
  %hid_err = alloca float, align 4
  store %struct.BPNN* %net, %struct.BPNN** %1, align 8
  store float* %eo, float** %2, align 8
  store float* %eh, float** %3, align 8
  %4 = load %struct.BPNN** %1, align 8
  %5 = getelementptr inbounds %struct.BPNN* %4, i32 0, i32 0
  %6 = load i32* %5, align 4
  store i32 %6, i32* %in, align 4
  %7 = load %struct.BPNN** %1, align 8
  %8 = getelementptr inbounds %struct.BPNN* %7, i32 0, i32 1
  %9 = load i32* %8, align 4
  store i32 %9, i32* %hid, align 4
  %10 = load %struct.BPNN** %1, align 8
  %11 = getelementptr inbounds %struct.BPNN* %10, i32 0, i32 2
  %12 = load i32* %11, align 4
  store i32 %12, i32* %out, align 4
  %13 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([28 x i8]* @.str, i32 0, i32 0))
  %14 = load %struct.BPNN** %1, align 8
  %15 = getelementptr inbounds %struct.BPNN* %14, i32 0, i32 3
  %16 = load float** %15, align 8
  %17 = load %struct.BPNN** %1, align 8
  %18 = getelementptr inbounds %struct.BPNN* %17, i32 0, i32 4
  %19 = load float** %18, align 8
  %20 = load %struct.BPNN** %1, align 8
  %21 = getelementptr inbounds %struct.BPNN* %20, i32 0, i32 9
  %22 = load float*** %21, align 8
  %23 = load i32* %in, align 4
  %24 = load i32* %hid, align 4
  call void @bpnn_layerforward(float* %16, float* %19, float** %22, i32 %23, i32 %24)
  %25 = load %struct.BPNN** %1, align 8
  %26 = getelementptr inbounds %struct.BPNN* %25, i32 0, i32 4
  %27 = load float** %26, align 8
  %28 = load %struct.BPNN** %1, align 8
  %29 = getelementptr inbounds %struct.BPNN* %28, i32 0, i32 5
  %30 = load float** %29, align 8
  %31 = load %struct.BPNN** %1, align 8
  %32 = getelementptr inbounds %struct.BPNN* %31, i32 0, i32 10
  %33 = load float*** %32, align 8
  %34 = load i32* %hid, align 4
  %35 = load i32* %out, align 4
  call void @bpnn_layerforward(float* %27, float* %30, float** %33, i32 %34, i32 %35)
  %36 = load %struct.BPNN** %1, align 8
  %37 = getelementptr inbounds %struct.BPNN* %36, i32 0, i32 7
  %38 = load float** %37, align 8
  %39 = load %struct.BPNN** %1, align 8
  %40 = getelementptr inbounds %struct.BPNN* %39, i32 0, i32 8
  %41 = load float** %40, align 8
  %42 = load %struct.BPNN** %1, align 8
  %43 = getelementptr inbounds %struct.BPNN* %42, i32 0, i32 5
  %44 = load float** %43, align 8
  %45 = load i32* %out, align 4
  call void @bpnn_output_error(float* %38, float* %41, float* %44, i32 %45, float* %out_err)
  %46 = load %struct.BPNN** %1, align 8
  %47 = getelementptr inbounds %struct.BPNN* %46, i32 0, i32 6
  %48 = load float** %47, align 8
  %49 = load i32* %hid, align 4
  %50 = load %struct.BPNN** %1, align 8
  %51 = getelementptr inbounds %struct.BPNN* %50, i32 0, i32 7
  %52 = load float** %51, align 8
  %53 = load i32* %out, align 4
  %54 = load %struct.BPNN** %1, align 8
  %55 = getelementptr inbounds %struct.BPNN* %54, i32 0, i32 10
  %56 = load float*** %55, align 8
  %57 = load %struct.BPNN** %1, align 8
  %58 = getelementptr inbounds %struct.BPNN* %57, i32 0, i32 4
  %59 = load float** %58, align 8
  call void @bpnn_hidden_error(float* %48, i32 %49, float* %52, i32 %53, float** %56, float* %59, float* %hid_err)
  %60 = load %struct.BPNN** %1, align 8
  %61 = getelementptr inbounds %struct.BPNN* %60, i32 0, i32 7
  %62 = load float** %61, align 8
  %63 = load i32* %out, align 4
  %64 = load %struct.BPNN** %1, align 8
  %65 = getelementptr inbounds %struct.BPNN* %64, i32 0, i32 4
  %66 = load float** %65, align 8
  %67 = load i32* %hid, align 4
  %68 = load %struct.BPNN** %1, align 8
  %69 = getelementptr inbounds %struct.BPNN* %68, i32 0, i32 10
  %70 = load float*** %69, align 8
  %71 = load %struct.BPNN** %1, align 8
  %72 = getelementptr inbounds %struct.BPNN* %71, i32 0, i32 12
  %73 = load float*** %72, align 8
  call void @bpnn_adjust_weights(float* %62, i32 %63, float* %66, i32 %67, float** %70, float** %73)
  %74 = load %struct.BPNN** %1, align 8
  %75 = getelementptr inbounds %struct.BPNN* %74, i32 0, i32 6
  %76 = load float** %75, align 8
  %77 = load i32* %hid, align 4
  %78 = load %struct.BPNN** %1, align 8
  %79 = getelementptr inbounds %struct.BPNN* %78, i32 0, i32 3
  %80 = load float** %79, align 8
  %81 = load i32* %in, align 4
  %82 = load %struct.BPNN** %1, align 8
  %83 = getelementptr inbounds %struct.BPNN* %82, i32 0, i32 9
  %84 = load float*** %83, align 8
  %85 = load %struct.BPNN** %1, align 8
  %86 = getelementptr inbounds %struct.BPNN* %85, i32 0, i32 11
  %87 = load float*** %86, align 8
  call void @bpnn_adjust_weights(float* %76, i32 %77, float* %80, i32 %81, float** %84, float** %87)
  ret void
}

declare i32 @printf(i8*, ...) #2

; Function Attrs: nounwind uwtable
define float @drnd() #0 {
  %1 = call i32 @rand() #5
  %2 = sitofp i32 %1 to float
  %3 = fdiv float %2, 0x41E0000000000000
  ret float %3
}

; Function Attrs: nounwind
declare i32 @rand() #1

; Function Attrs: nounwind uwtable
define float @dpn1() #0 {
  %1 = call float @drnd()
  %2 = fpext float %1 to double
  %3 = fmul double %2, 2.000000e+00
  %4 = fsub double %3, 1.000000e+00
  %5 = fptrunc double %4 to float
  ret float %5
}

; Function Attrs: nounwind uwtable
define float @squash(double) #0 {
  %2 = alloca float, align 4
  %m = alloca float, align 4
  %x = fptrunc double %0 to float
  store float %x, float* %2, align 4
  %3 = load float* %2, align 4
  %4 = fsub float -0.000000e+00, %3
  %5 = fpext float %4 to double
  %6 = call double @exp(double %5) #5
  %7 = fadd double 1.000000e+00, %6
  %8 = fdiv double 1.000000e+00, %7
  %9 = fptrunc double %8 to float
  ret float %9
}

; Function Attrs: nounwind
declare double @exp(double) #1

; Function Attrs: nounwind uwtable
define float* @alloc_1d_dbl(i32 %n) #0 {
  %1 = alloca float*, align 8
  %2 = alloca i32, align 4
  %new = alloca float*, align 8
  store i32 %n, i32* %2, align 4
  %3 = load i32* %2, align 4
  %4 = sext i32 %3 to i64
  %5 = mul i64 %4, 4
  %6 = trunc i64 %5 to i32
  %7 = zext i32 %6 to i64
  %8 = call noalias i8* @malloc(i64 %7) #5
  %9 = bitcast i8* %8 to float*
  store float* %9, float** %new, align 8
  %10 = load float** %new, align 8
  %11 = icmp eq float* %10, null
  br i1 %11, label %12, label %14

; <label>:12                                      ; preds = %0
  %13 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([49 x i8]* @.str1, i32 0, i32 0))
  store float* null, float** %1
  br label %16

; <label>:14                                      ; preds = %0
  %15 = load float** %new, align 8
  store float* %15, float** %1
  br label %16

; <label>:16                                      ; preds = %14, %12
  %17 = load float** %1
  ret float* %17
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #1

; Function Attrs: nounwind uwtable
define float** @alloc_2d_dbl(i32 %m, i32 %n) #0 {
  %1 = alloca float**, align 8
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %i = alloca i32, align 4
  %new = alloca float**, align 8
  store i32 %m, i32* %2, align 4
  store i32 %n, i32* %3, align 4
  %4 = load i32* %2, align 4
  %5 = sext i32 %4 to i64
  %6 = mul i64 %5, 8
  %7 = trunc i64 %6 to i32
  %8 = zext i32 %7 to i64
  %9 = call noalias i8* @malloc(i64 %8) #5
  %10 = bitcast i8* %9 to float**
  store float** %10, float*** %new, align 8
  %11 = load float*** %new, align 8
  %12 = icmp eq float** %11, null
  br i1 %12, label %13, label %15

; <label>:13                                      ; preds = %0
  %14 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([51 x i8]* @.str12, i32 0, i32 0))
  store float** null, float*** %1
  br label %32

; <label>:15                                      ; preds = %0
  store i32 0, i32* %i, align 4
  br label %16

; <label>:16                                      ; preds = %27, %15
  %17 = load i32* %i, align 4
  %18 = load i32* %2, align 4
  %19 = icmp slt i32 %17, %18
  br i1 %19, label %20, label %30

; <label>:20                                      ; preds = %16
  %21 = load i32* %3, align 4
  %22 = call float* @alloc_1d_dbl(i32 %21)
  %23 = load i32* %i, align 4
  %24 = sext i32 %23 to i64
  %25 = load float*** %new, align 8
  %26 = getelementptr inbounds float** %25, i64 %24
  store float* %22, float** %26, align 8
  br label %27

; <label>:27                                      ; preds = %20
  %28 = load i32* %i, align 4
  %29 = add nsw i32 %28, 1
  store i32 %29, i32* %i, align 4
  br label %16

; <label>:30                                      ; preds = %16
  %31 = load float*** %new, align 8
  store float** %31, float*** %1
  br label %32

; <label>:32                                      ; preds = %30, %13
  %33 = load float*** %1
  ret float** %33
}

; Function Attrs: nounwind uwtable
define void @bpnn_randomize_weights(float** %w, i32 %m, i32 %n) #0 {
  %1 = alloca float**, align 8
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store float** %w, float*** %1, align 8
  store i32 %m, i32* %2, align 4
  store i32 %n, i32* %3, align 4
  store i32 0, i32* %i, align 4
  br label %4

; <label>:4                                       ; preds = %29, %0
  %5 = load i32* %i, align 4
  %6 = load i32* %2, align 4
  %7 = icmp sle i32 %5, %6
  br i1 %7, label %8, label %32

; <label>:8                                       ; preds = %4
  store i32 0, i32* %j, align 4
  br label %9

; <label>:9                                       ; preds = %25, %8
  %10 = load i32* %j, align 4
  %11 = load i32* %3, align 4
  %12 = icmp sle i32 %10, %11
  br i1 %12, label %13, label %28

; <label>:13                                      ; preds = %9
  %14 = call i32 @rand() #5
  %15 = sitofp i32 %14 to float
  %16 = fdiv float %15, 0x41E0000000000000
  %17 = load i32* %j, align 4
  %18 = sext i32 %17 to i64
  %19 = load i32* %i, align 4
  %20 = sext i32 %19 to i64
  %21 = load float*** %1, align 8
  %22 = getelementptr inbounds float** %21, i64 %20
  %23 = load float** %22, align 8
  %24 = getelementptr inbounds float* %23, i64 %18
  store float %16, float* %24, align 4
  br label %25

; <label>:25                                      ; preds = %13
  %26 = load i32* %j, align 4
  %27 = add nsw i32 %26, 1
  store i32 %27, i32* %j, align 4
  br label %9

; <label>:28                                      ; preds = %9
  br label %29

; <label>:29                                      ; preds = %28
  %30 = load i32* %i, align 4
  %31 = add nsw i32 %30, 1
  store i32 %31, i32* %i, align 4
  br label %4

; <label>:32                                      ; preds = %4
  ret void
}

; Function Attrs: nounwind uwtable
define void @bpnn_randomize_row(float* %w, i32 %m) #0 {
  %1 = alloca float*, align 8
  %2 = alloca i32, align 4
  %i = alloca i32, align 4
  store float* %w, float** %1, align 8
  store i32 %m, i32* %2, align 4
  store i32 0, i32* %i, align 4
  br label %3

; <label>:3                                       ; preds = %12, %0
  %4 = load i32* %i, align 4
  %5 = load i32* %2, align 4
  %6 = icmp sle i32 %4, %5
  br i1 %6, label %7, label %15

; <label>:7                                       ; preds = %3
  %8 = load i32* %i, align 4
  %9 = sext i32 %8 to i64
  %10 = load float** %1, align 8
  %11 = getelementptr inbounds float* %10, i64 %9
  store float 0x3FB99999A0000000, float* %11, align 4
  br label %12

; <label>:12                                      ; preds = %7
  %13 = load i32* %i, align 4
  %14 = add nsw i32 %13, 1
  store i32 %14, i32* %i, align 4
  br label %3

; <label>:15                                      ; preds = %3
  ret void
}

; Function Attrs: nounwind uwtable
define void @bpnn_zero_weights(float** %w, i32 %m, i32 %n) #0 {
  %1 = alloca float**, align 8
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store float** %w, float*** %1, align 8
  store i32 %m, i32* %2, align 4
  store i32 %n, i32* %3, align 4
  store i32 0, i32* %i, align 4
  br label %4

; <label>:4                                       ; preds = %26, %0
  %5 = load i32* %i, align 4
  %6 = load i32* %2, align 4
  %7 = icmp sle i32 %5, %6
  br i1 %7, label %8, label %29

; <label>:8                                       ; preds = %4
  store i32 0, i32* %j, align 4
  br label %9

; <label>:9                                       ; preds = %22, %8
  %10 = load i32* %j, align 4
  %11 = load i32* %3, align 4
  %12 = icmp sle i32 %10, %11
  br i1 %12, label %13, label %25

; <label>:13                                      ; preds = %9
  %14 = load i32* %j, align 4
  %15 = sext i32 %14 to i64
  %16 = load i32* %i, align 4
  %17 = sext i32 %16 to i64
  %18 = load float*** %1, align 8
  %19 = getelementptr inbounds float** %18, i64 %17
  %20 = load float** %19, align 8
  %21 = getelementptr inbounds float* %20, i64 %15
  store float 0.000000e+00, float* %21, align 4
  br label %22

; <label>:22                                      ; preds = %13
  %23 = load i32* %j, align 4
  %24 = add nsw i32 %23, 1
  store i32 %24, i32* %j, align 4
  br label %9

; <label>:25                                      ; preds = %9
  br label %26

; <label>:26                                      ; preds = %25
  %27 = load i32* %i, align 4
  %28 = add nsw i32 %27, 1
  store i32 %28, i32* %i, align 4
  br label %4

; <label>:29                                      ; preds = %4
  ret void
}

; Function Attrs: nounwind uwtable
define void @bpnn_initialize(i32 %seed) #0 {
  %1 = alloca i32, align 4
  store i32 %seed, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str2, i32 0, i32 0), i32 %2)
  %4 = load i32* %1, align 4
  call void @srand(i32 %4) #5
  ret void
}

; Function Attrs: nounwind
declare void @srand(i32) #1

; Function Attrs: nounwind uwtable
define %struct.BPNN* @bpnn_internal_create(i32 %n_in, i32 %n_hidden, i32 %n_out) #0 {
  %1 = alloca %struct.BPNN*, align 8
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %newnet = alloca %struct.BPNN*, align 8
  store i32 %n_in, i32* %2, align 4
  store i32 %n_hidden, i32* %3, align 4
  store i32 %n_out, i32* %4, align 4
  %5 = call noalias i8* @malloc(i64 96) #5
  %6 = bitcast i8* %5 to %struct.BPNN*
  store %struct.BPNN* %6, %struct.BPNN** %newnet, align 8
  %7 = load %struct.BPNN** %newnet, align 8
  %8 = icmp eq %struct.BPNN* %7, null
  br i1 %8, label %9, label %11

; <label>:9                                       ; preds = %0
  %10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([47 x i8]* @.str3, i32 0, i32 0))
  store %struct.BPNN* null, %struct.BPNN** %1
  br label %80

; <label>:11                                      ; preds = %0
  %12 = load i32* %2, align 4
  %13 = load %struct.BPNN** %newnet, align 8
  %14 = getelementptr inbounds %struct.BPNN* %13, i32 0, i32 0
  store i32 %12, i32* %14, align 4
  %15 = load i32* %3, align 4
  %16 = load %struct.BPNN** %newnet, align 8
  %17 = getelementptr inbounds %struct.BPNN* %16, i32 0, i32 1
  store i32 %15, i32* %17, align 4
  %18 = load i32* %4, align 4
  %19 = load %struct.BPNN** %newnet, align 8
  %20 = getelementptr inbounds %struct.BPNN* %19, i32 0, i32 2
  store i32 %18, i32* %20, align 4
  %21 = load i32* %2, align 4
  %22 = add nsw i32 %21, 1
  %23 = call float* @alloc_1d_dbl(i32 %22)
  %24 = load %struct.BPNN** %newnet, align 8
  %25 = getelementptr inbounds %struct.BPNN* %24, i32 0, i32 3
  store float* %23, float** %25, align 8
  %26 = load i32* %3, align 4
  %27 = add nsw i32 %26, 1
  %28 = call float* @alloc_1d_dbl(i32 %27)
  %29 = load %struct.BPNN** %newnet, align 8
  %30 = getelementptr inbounds %struct.BPNN* %29, i32 0, i32 4
  store float* %28, float** %30, align 8
  %31 = load i32* %4, align 4
  %32 = add nsw i32 %31, 1
  %33 = call float* @alloc_1d_dbl(i32 %32)
  %34 = load %struct.BPNN** %newnet, align 8
  %35 = getelementptr inbounds %struct.BPNN* %34, i32 0, i32 5
  store float* %33, float** %35, align 8
  %36 = load i32* %3, align 4
  %37 = add nsw i32 %36, 1
  %38 = call float* @alloc_1d_dbl(i32 %37)
  %39 = load %struct.BPNN** %newnet, align 8
  %40 = getelementptr inbounds %struct.BPNN* %39, i32 0, i32 6
  store float* %38, float** %40, align 8
  %41 = load i32* %4, align 4
  %42 = add nsw i32 %41, 1
  %43 = call float* @alloc_1d_dbl(i32 %42)
  %44 = load %struct.BPNN** %newnet, align 8
  %45 = getelementptr inbounds %struct.BPNN* %44, i32 0, i32 7
  store float* %43, float** %45, align 8
  %46 = load i32* %4, align 4
  %47 = add nsw i32 %46, 1
  %48 = call float* @alloc_1d_dbl(i32 %47)
  %49 = load %struct.BPNN** %newnet, align 8
  %50 = getelementptr inbounds %struct.BPNN* %49, i32 0, i32 8
  store float* %48, float** %50, align 8
  %51 = load i32* %2, align 4
  %52 = add nsw i32 %51, 1
  %53 = load i32* %3, align 4
  %54 = add nsw i32 %53, 1
  %55 = call float** @alloc_2d_dbl(i32 %52, i32 %54)
  %56 = load %struct.BPNN** %newnet, align 8
  %57 = getelementptr inbounds %struct.BPNN* %56, i32 0, i32 9
  store float** %55, float*** %57, align 8
  %58 = load i32* %3, align 4
  %59 = add nsw i32 %58, 1
  %60 = load i32* %4, align 4
  %61 = add nsw i32 %60, 1
  %62 = call float** @alloc_2d_dbl(i32 %59, i32 %61)
  %63 = load %struct.BPNN** %newnet, align 8
  %64 = getelementptr inbounds %struct.BPNN* %63, i32 0, i32 10
  store float** %62, float*** %64, align 8
  %65 = load i32* %2, align 4
  %66 = add nsw i32 %65, 1
  %67 = load i32* %3, align 4
  %68 = add nsw i32 %67, 1
  %69 = call float** @alloc_2d_dbl(i32 %66, i32 %68)
  %70 = load %struct.BPNN** %newnet, align 8
  %71 = getelementptr inbounds %struct.BPNN* %70, i32 0, i32 11
  store float** %69, float*** %71, align 8
  %72 = load i32* %3, align 4
  %73 = add nsw i32 %72, 1
  %74 = load i32* %4, align 4
  %75 = add nsw i32 %74, 1
  %76 = call float** @alloc_2d_dbl(i32 %73, i32 %75)
  %77 = load %struct.BPNN** %newnet, align 8
  %78 = getelementptr inbounds %struct.BPNN* %77, i32 0, i32 12
  store float** %76, float*** %78, align 8
  %79 = load %struct.BPNN** %newnet, align 8
  store %struct.BPNN* %79, %struct.BPNN** %1
  br label %80

; <label>:80                                      ; preds = %11, %9
  %81 = load %struct.BPNN** %1
  ret %struct.BPNN* %81
}

; Function Attrs: nounwind uwtable
define void @bpnn_free(%struct.BPNN* %net) #0 {
  %1 = alloca %struct.BPNN*, align 8
  %n1 = alloca i32, align 4
  %n2 = alloca i32, align 4
  %i = alloca i32, align 4
  store %struct.BPNN* %net, %struct.BPNN** %1, align 8
  %2 = load %struct.BPNN** %1, align 8
  %3 = getelementptr inbounds %struct.BPNN* %2, i32 0, i32 0
  %4 = load i32* %3, align 4
  store i32 %4, i32* %n1, align 4
  %5 = load %struct.BPNN** %1, align 8
  %6 = getelementptr inbounds %struct.BPNN* %5, i32 0, i32 1
  %7 = load i32* %6, align 4
  store i32 %7, i32* %n2, align 4
  %8 = load %struct.BPNN** %1, align 8
  %9 = getelementptr inbounds %struct.BPNN* %8, i32 0, i32 3
  %10 = load float** %9, align 8
  %11 = bitcast float* %10 to i8*
  call void @free(i8* %11) #5
  %12 = load %struct.BPNN** %1, align 8
  %13 = getelementptr inbounds %struct.BPNN* %12, i32 0, i32 4
  %14 = load float** %13, align 8
  %15 = bitcast float* %14 to i8*
  call void @free(i8* %15) #5
  %16 = load %struct.BPNN** %1, align 8
  %17 = getelementptr inbounds %struct.BPNN* %16, i32 0, i32 5
  %18 = load float** %17, align 8
  %19 = bitcast float* %18 to i8*
  call void @free(i8* %19) #5
  %20 = load %struct.BPNN** %1, align 8
  %21 = getelementptr inbounds %struct.BPNN* %20, i32 0, i32 6
  %22 = load float** %21, align 8
  %23 = bitcast float* %22 to i8*
  call void @free(i8* %23) #5
  %24 = load %struct.BPNN** %1, align 8
  %25 = getelementptr inbounds %struct.BPNN* %24, i32 0, i32 7
  %26 = load float** %25, align 8
  %27 = bitcast float* %26 to i8*
  call void @free(i8* %27) #5
  %28 = load %struct.BPNN** %1, align 8
  %29 = getelementptr inbounds %struct.BPNN* %28, i32 0, i32 8
  %30 = load float** %29, align 8
  %31 = bitcast float* %30 to i8*
  call void @free(i8* %31) #5
  store i32 0, i32* %i, align 4
  br label %32

; <label>:32                                      ; preds = %53, %0
  %33 = load i32* %i, align 4
  %34 = load i32* %n1, align 4
  %35 = icmp sle i32 %33, %34
  br i1 %35, label %36, label %56

; <label>:36                                      ; preds = %32
  %37 = load i32* %i, align 4
  %38 = sext i32 %37 to i64
  %39 = load %struct.BPNN** %1, align 8
  %40 = getelementptr inbounds %struct.BPNN* %39, i32 0, i32 9
  %41 = load float*** %40, align 8
  %42 = getelementptr inbounds float** %41, i64 %38
  %43 = load float** %42, align 8
  %44 = bitcast float* %43 to i8*
  call void @free(i8* %44) #5
  %45 = load i32* %i, align 4
  %46 = sext i32 %45 to i64
  %47 = load %struct.BPNN** %1, align 8
  %48 = getelementptr inbounds %struct.BPNN* %47, i32 0, i32 11
  %49 = load float*** %48, align 8
  %50 = getelementptr inbounds float** %49, i64 %46
  %51 = load float** %50, align 8
  %52 = bitcast float* %51 to i8*
  call void @free(i8* %52) #5
  br label %53

; <label>:53                                      ; preds = %36
  %54 = load i32* %i, align 4
  %55 = add nsw i32 %54, 1
  store i32 %55, i32* %i, align 4
  br label %32

; <label>:56                                      ; preds = %32
  %57 = load %struct.BPNN** %1, align 8
  %58 = getelementptr inbounds %struct.BPNN* %57, i32 0, i32 9
  %59 = load float*** %58, align 8
  %60 = bitcast float** %59 to i8*
  call void @free(i8* %60) #5
  %61 = load %struct.BPNN** %1, align 8
  %62 = getelementptr inbounds %struct.BPNN* %61, i32 0, i32 11
  %63 = load float*** %62, align 8
  %64 = bitcast float** %63 to i8*
  call void @free(i8* %64) #5
  store i32 0, i32* %i, align 4
  br label %65

; <label>:65                                      ; preds = %86, %56
  %66 = load i32* %i, align 4
  %67 = load i32* %n2, align 4
  %68 = icmp sle i32 %66, %67
  br i1 %68, label %69, label %89

; <label>:69                                      ; preds = %65
  %70 = load i32* %i, align 4
  %71 = sext i32 %70 to i64
  %72 = load %struct.BPNN** %1, align 8
  %73 = getelementptr inbounds %struct.BPNN* %72, i32 0, i32 10
  %74 = load float*** %73, align 8
  %75 = getelementptr inbounds float** %74, i64 %71
  %76 = load float** %75, align 8
  %77 = bitcast float* %76 to i8*
  call void @free(i8* %77) #5
  %78 = load i32* %i, align 4
  %79 = sext i32 %78 to i64
  %80 = load %struct.BPNN** %1, align 8
  %81 = getelementptr inbounds %struct.BPNN* %80, i32 0, i32 12
  %82 = load float*** %81, align 8
  %83 = getelementptr inbounds float** %82, i64 %79
  %84 = load float** %83, align 8
  %85 = bitcast float* %84 to i8*
  call void @free(i8* %85) #5
  br label %86

; <label>:86                                      ; preds = %69
  %87 = load i32* %i, align 4
  %88 = add nsw i32 %87, 1
  store i32 %88, i32* %i, align 4
  br label %65

; <label>:89                                      ; preds = %65
  %90 = load %struct.BPNN** %1, align 8
  %91 = getelementptr inbounds %struct.BPNN* %90, i32 0, i32 10
  %92 = load float*** %91, align 8
  %93 = bitcast float** %92 to i8*
  call void @free(i8* %93) #5
  %94 = load %struct.BPNN** %1, align 8
  %95 = getelementptr inbounds %struct.BPNN* %94, i32 0, i32 12
  %96 = load float*** %95, align 8
  %97 = bitcast float** %96 to i8*
  call void @free(i8* %97) #5
  %98 = load %struct.BPNN** %1, align 8
  %99 = bitcast %struct.BPNN* %98 to i8*
  call void @free(i8* %99) #5
  ret void
}

; Function Attrs: nounwind
declare void @free(i8*) #1

; Function Attrs: nounwind uwtable
define %struct.BPNN* @bpnn_create(i32 %n_in, i32 %n_hidden, i32 %n_out) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %newnet = alloca %struct.BPNN*, align 8
  store i32 %n_in, i32* %1, align 4
  store i32 %n_hidden, i32* %2, align 4
  store i32 %n_out, i32* %3, align 4
  %4 = load i32* %1, align 4
  %5 = load i32* %2, align 4
  %6 = load i32* %3, align 4
  %7 = call %struct.BPNN* @bpnn_internal_create(i32 %4, i32 %5, i32 %6)
  store %struct.BPNN* %7, %struct.BPNN** %newnet, align 8
  %8 = load %struct.BPNN** %newnet, align 8
  %9 = getelementptr inbounds %struct.BPNN* %8, i32 0, i32 9
  %10 = load float*** %9, align 8
  %11 = load i32* %1, align 4
  %12 = load i32* %2, align 4
  call void @bpnn_randomize_weights(float** %10, i32 %11, i32 %12)
  %13 = load %struct.BPNN** %newnet, align 8
  %14 = getelementptr inbounds %struct.BPNN* %13, i32 0, i32 10
  %15 = load float*** %14, align 8
  %16 = load i32* %2, align 4
  %17 = load i32* %3, align 4
  call void @bpnn_randomize_weights(float** %15, i32 %16, i32 %17)
  %18 = load %struct.BPNN** %newnet, align 8
  %19 = getelementptr inbounds %struct.BPNN* %18, i32 0, i32 11
  %20 = load float*** %19, align 8
  %21 = load i32* %1, align 4
  %22 = load i32* %2, align 4
  call void @bpnn_zero_weights(float** %20, i32 %21, i32 %22)
  %23 = load %struct.BPNN** %newnet, align 8
  %24 = getelementptr inbounds %struct.BPNN* %23, i32 0, i32 12
  %25 = load float*** %24, align 8
  %26 = load i32* %2, align 4
  %27 = load i32* %3, align 4
  call void @bpnn_zero_weights(float** %25, i32 %26, i32 %27)
  %28 = load %struct.BPNN** %newnet, align 8
  %29 = getelementptr inbounds %struct.BPNN* %28, i32 0, i32 8
  %30 = load float** %29, align 8
  %31 = load i32* %3, align 4
  call void @bpnn_randomize_row(float* %30, i32 %31)
  %32 = load %struct.BPNN** %newnet, align 8
  ret %struct.BPNN* %32
}

; Function Attrs: nounwind uwtable
define void @bpnn_layerforward(float* %l1, float* %l2, float** %conn, i32 %n1, i32 %n2) #0 {
  %1 = alloca float*, align 8
  %2 = alloca float*, align 8
  %3 = alloca float**, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %sum = alloca float, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  store float* %l1, float** %1, align 8
  store float* %l2, float** %2, align 8
  store float** %conn, float*** %3, align 8
  store i32 %n1, i32* %4, align 4
  store i32 %n2, i32* %5, align 4
  %6 = load float** %1, align 8
  %7 = getelementptr inbounds float* %6, i64 0
  store float 1.000000e+00, float* %7, align 4
  store i32 1, i32* %j, align 4
  br label %8

; <label>:8                                       ; preds = %46, %0
  %9 = load i32* %j, align 4
  %10 = load i32* %5, align 4
  %11 = icmp sle i32 %9, %10
  br i1 %11, label %12, label %49

; <label>:12                                      ; preds = %8
  store float 0.000000e+00, float* %sum, align 4
  store i32 0, i32* %k, align 4
  br label %13

; <label>:13                                      ; preds = %35, %12
  %14 = load i32* %k, align 4
  %15 = load i32* %4, align 4
  %16 = icmp sle i32 %14, %15
  br i1 %16, label %17, label %38

; <label>:17                                      ; preds = %13
  %18 = load i32* %j, align 4
  %19 = sext i32 %18 to i64
  %20 = load i32* %k, align 4
  %21 = sext i32 %20 to i64
  %22 = load float*** %3, align 8
  %23 = getelementptr inbounds float** %22, i64 %21
  %24 = load float** %23, align 8
  %25 = getelementptr inbounds float* %24, i64 %19
  %26 = load float* %25, align 4
  %27 = load i32* %k, align 4
  %28 = sext i32 %27 to i64
  %29 = load float** %1, align 8
  %30 = getelementptr inbounds float* %29, i64 %28
  %31 = load float* %30, align 4
  %32 = fmul float %26, %31
  %33 = load float* %sum, align 4
  %34 = fadd float %33, %32
  store float %34, float* %sum, align 4
  br label %35

; <label>:35                                      ; preds = %17
  %36 = load i32* %k, align 4
  %37 = add nsw i32 %36, 1
  store i32 %37, i32* %k, align 4
  br label %13

; <label>:38                                      ; preds = %13
  %39 = load float* %sum, align 4
  %40 = fpext float %39 to double
  %41 = call float @squash(double %40)
  %42 = load i32* %j, align 4
  %43 = sext i32 %42 to i64
  %44 = load float** %2, align 8
  %45 = getelementptr inbounds float* %44, i64 %43
  store float %41, float* %45, align 4
  br label %46

; <label>:46                                      ; preds = %38
  %47 = load i32* %j, align 4
  %48 = add nsw i32 %47, 1
  store i32 %48, i32* %j, align 4
  br label %8

; <label>:49                                      ; preds = %8
  ret void
}

; Function Attrs: nounwind uwtable
define void @bpnn_output_error(float* %delta, float* %target, float* %output, i32 %nj, float* %err) #0 {
  %1 = alloca float*, align 8
  %2 = alloca float*, align 8
  %3 = alloca float*, align 8
  %4 = alloca i32, align 4
  %5 = alloca float*, align 8
  %j = alloca i32, align 4
  %o = alloca float, align 4
  %t = alloca float, align 4
  %errsum = alloca float, align 4
  store float* %delta, float** %1, align 8
  store float* %target, float** %2, align 8
  store float* %output, float** %3, align 8
  store i32 %nj, i32* %4, align 4
  store float* %err, float** %5, align 8
  store float 0.000000e+00, float* %errsum, align 4
  store i32 1, i32* %j, align 4
  br label %6

; <label>:6                                       ; preds = %61, %0
  %7 = load i32* %j, align 4
  %8 = load i32* %4, align 4
  %9 = icmp sle i32 %7, %8
  br i1 %9, label %10, label %64

; <label>:10                                      ; preds = %6
  %11 = load i32* %j, align 4
  %12 = sext i32 %11 to i64
  %13 = load float** %3, align 8
  %14 = getelementptr inbounds float* %13, i64 %12
  %15 = load float* %14, align 4
  store float %15, float* %o, align 4
  %16 = load i32* %j, align 4
  %17 = sext i32 %16 to i64
  %18 = load float** %2, align 8
  %19 = getelementptr inbounds float* %18, i64 %17
  %20 = load float* %19, align 4
  store float %20, float* %t, align 4
  %21 = load float* %o, align 4
  %22 = fpext float %21 to double
  %23 = load float* %o, align 4
  %24 = fpext float %23 to double
  %25 = fsub double 1.000000e+00, %24
  %26 = fmul double %22, %25
  %27 = load float* %t, align 4
  %28 = load float* %o, align 4
  %29 = fsub float %27, %28
  %30 = fpext float %29 to double
  %31 = fmul double %26, %30
  %32 = fptrunc double %31 to float
  %33 = load i32* %j, align 4
  %34 = sext i32 %33 to i64
  %35 = load float** %1, align 8
  %36 = getelementptr inbounds float* %35, i64 %34
  store float %32, float* %36, align 4
  %37 = load i32* %j, align 4
  %38 = sext i32 %37 to i64
  %39 = load float** %1, align 8
  %40 = getelementptr inbounds float* %39, i64 %38
  %41 = load float* %40, align 4
  %42 = fpext float %41 to double
  %43 = fcmp ogt double %42, 0.000000e+00
  br i1 %43, label %44, label %50

; <label>:44                                      ; preds = %10
  %45 = load i32* %j, align 4
  %46 = sext i32 %45 to i64
  %47 = load float** %1, align 8
  %48 = getelementptr inbounds float* %47, i64 %46
  %49 = load float* %48, align 4
  br label %57

; <label>:50                                      ; preds = %10
  %51 = load i32* %j, align 4
  %52 = sext i32 %51 to i64
  %53 = load float** %1, align 8
  %54 = getelementptr inbounds float* %53, i64 %52
  %55 = load float* %54, align 4
  %56 = fsub float -0.000000e+00, %55
  br label %57

; <label>:57                                      ; preds = %50, %44
  %58 = phi float [ %49, %44 ], [ %56, %50 ]
  %59 = load float* %errsum, align 4
  %60 = fadd float %59, %58
  store float %60, float* %errsum, align 4
  br label %61

; <label>:61                                      ; preds = %57
  %62 = load i32* %j, align 4
  %63 = add nsw i32 %62, 1
  store i32 %63, i32* %j, align 4
  br label %6

; <label>:64                                      ; preds = %6
  %65 = load float* %errsum, align 4
  %66 = load float** %5, align 8
  store float %65, float* %66, align 4
  ret void
}

; Function Attrs: nounwind uwtable
define void @bpnn_hidden_error(float* %delta_h, i32 %nh, float* %delta_o, i32 %no, float** %who, float* %hidden, float* %err) #0 {
  %1 = alloca float*, align 8
  %2 = alloca i32, align 4
  %3 = alloca float*, align 8
  %4 = alloca i32, align 4
  %5 = alloca float**, align 8
  %6 = alloca float*, align 8
  %7 = alloca float*, align 8
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %h = alloca float, align 4
  %sum = alloca float, align 4
  %errsum = alloca float, align 4
  store float* %delta_h, float** %1, align 8
  store i32 %nh, i32* %2, align 4
  store float* %delta_o, float** %3, align 8
  store i32 %no, i32* %4, align 4
  store float** %who, float*** %5, align 8
  store float* %hidden, float** %6, align 8
  store float* %err, float** %7, align 8
  store float 0.000000e+00, float* %errsum, align 4
  store i32 1, i32* %j, align 4
  br label %8

; <label>:8                                       ; preds = %82, %0
  %9 = load i32* %j, align 4
  %10 = load i32* %2, align 4
  %11 = icmp sle i32 %9, %10
  br i1 %11, label %12, label %85

; <label>:12                                      ; preds = %8
  %13 = load i32* %j, align 4
  %14 = sext i32 %13 to i64
  %15 = load float** %6, align 8
  %16 = getelementptr inbounds float* %15, i64 %14
  %17 = load float* %16, align 4
  store float %17, float* %h, align 4
  store float 0.000000e+00, float* %sum, align 4
  store i32 1, i32* %k, align 4
  br label %18

; <label>:18                                      ; preds = %40, %12
  %19 = load i32* %k, align 4
  %20 = load i32* %4, align 4
  %21 = icmp sle i32 %19, %20
  br i1 %21, label %22, label %43

; <label>:22                                      ; preds = %18
  %23 = load i32* %k, align 4
  %24 = sext i32 %23 to i64
  %25 = load float** %3, align 8
  %26 = getelementptr inbounds float* %25, i64 %24
  %27 = load float* %26, align 4
  %28 = load i32* %k, align 4
  %29 = sext i32 %28 to i64
  %30 = load i32* %j, align 4
  %31 = sext i32 %30 to i64
  %32 = load float*** %5, align 8
  %33 = getelementptr inbounds float** %32, i64 %31
  %34 = load float** %33, align 8
  %35 = getelementptr inbounds float* %34, i64 %29
  %36 = load float* %35, align 4
  %37 = fmul float %27, %36
  %38 = load float* %sum, align 4
  %39 = fadd float %38, %37
  store float %39, float* %sum, align 4
  br label %40

; <label>:40                                      ; preds = %22
  %41 = load i32* %k, align 4
  %42 = add nsw i32 %41, 1
  store i32 %42, i32* %k, align 4
  br label %18

; <label>:43                                      ; preds = %18
  %44 = load float* %h, align 4
  %45 = fpext float %44 to double
  %46 = load float* %h, align 4
  %47 = fpext float %46 to double
  %48 = fsub double 1.000000e+00, %47
  %49 = fmul double %45, %48
  %50 = load float* %sum, align 4
  %51 = fpext float %50 to double
  %52 = fmul double %49, %51
  %53 = fptrunc double %52 to float
  %54 = load i32* %j, align 4
  %55 = sext i32 %54 to i64
  %56 = load float** %1, align 8
  %57 = getelementptr inbounds float* %56, i64 %55
  store float %53, float* %57, align 4
  %58 = load i32* %j, align 4
  %59 = sext i32 %58 to i64
  %60 = load float** %1, align 8
  %61 = getelementptr inbounds float* %60, i64 %59
  %62 = load float* %61, align 4
  %63 = fpext float %62 to double
  %64 = fcmp ogt double %63, 0.000000e+00
  br i1 %64, label %65, label %71

; <label>:65                                      ; preds = %43
  %66 = load i32* %j, align 4
  %67 = sext i32 %66 to i64
  %68 = load float** %1, align 8
  %69 = getelementptr inbounds float* %68, i64 %67
  %70 = load float* %69, align 4
  br label %78

; <label>:71                                      ; preds = %43
  %72 = load i32* %j, align 4
  %73 = sext i32 %72 to i64
  %74 = load float** %1, align 8
  %75 = getelementptr inbounds float* %74, i64 %73
  %76 = load float* %75, align 4
  %77 = fsub float -0.000000e+00, %76
  br label %78

; <label>:78                                      ; preds = %71, %65
  %79 = phi float [ %70, %65 ], [ %77, %71 ]
  %80 = load float* %errsum, align 4
  %81 = fadd float %80, %79
  store float %81, float* %errsum, align 4
  br label %82

; <label>:82                                      ; preds = %78
  %83 = load i32* %j, align 4
  %84 = add nsw i32 %83, 1
  store i32 %84, i32* %j, align 4
  br label %8

; <label>:85                                      ; preds = %8
  %86 = load float* %errsum, align 4
  %87 = load float** %7, align 8
  store float %86, float* %87, align 4
  ret void
}

; Function Attrs: nounwind uwtable
define void @bpnn_adjust_weights(float* %delta, i32 %ndelta, float* %ly, i32 %nly, float** %w, float** %oldw) #0 {
  %1 = alloca float*, align 8
  %2 = alloca i32, align 4
  %3 = alloca float*, align 8
  %4 = alloca i32, align 4
  %5 = alloca float**, align 8
  %6 = alloca float**, align 8
  %new_dw = alloca float, align 4
  %k = alloca i32, align 4
  %j = alloca i32, align 4
  store float* %delta, float** %1, align 8
  store i32 %ndelta, i32* %2, align 4
  store float* %ly, float** %3, align 8
  store i32 %nly, i32* %4, align 4
  store float** %w, float*** %5, align 8
  store float** %oldw, float*** %6, align 8
  %7 = load float** %3, align 8
  %8 = getelementptr inbounds float* %7, i64 0
  store float 1.000000e+00, float* %8, align 4
  store i32 1, i32* %j, align 4
  br label %9

; <label>:9                                       ; preds = %70, %0
  %10 = load i32* %j, align 4
  %11 = load i32* %2, align 4
  %12 = icmp sle i32 %10, %11
  br i1 %12, label %13, label %73

; <label>:13                                      ; preds = %9
  store i32 0, i32* %k, align 4
  br label %14

; <label>:14                                      ; preds = %66, %13
  %15 = load i32* %k, align 4
  %16 = load i32* %4, align 4
  %17 = icmp sle i32 %15, %16
  br i1 %17, label %18, label %69

; <label>:18                                      ; preds = %14
  %19 = load i32* %j, align 4
  %20 = sext i32 %19 to i64
  %21 = load float** %1, align 8
  %22 = getelementptr inbounds float* %21, i64 %20
  %23 = load float* %22, align 4
  %24 = fpext float %23 to double
  %25 = fmul double 3.000000e-01, %24
  %26 = load i32* %k, align 4
  %27 = sext i32 %26 to i64
  %28 = load float** %3, align 8
  %29 = getelementptr inbounds float* %28, i64 %27
  %30 = load float* %29, align 4
  %31 = fpext float %30 to double
  %32 = fmul double %25, %31
  %33 = load i32* %j, align 4
  %34 = sext i32 %33 to i64
  %35 = load i32* %k, align 4
  %36 = sext i32 %35 to i64
  %37 = load float*** %6, align 8
  %38 = getelementptr inbounds float** %37, i64 %36
  %39 = load float** %38, align 8
  %40 = getelementptr inbounds float* %39, i64 %34
  %41 = load float* %40, align 4
  %42 = fpext float %41 to double
  %43 = fmul double 3.000000e-01, %42
  %44 = fadd double %32, %43
  %45 = fptrunc double %44 to float
  store float %45, float* %new_dw, align 4
  %46 = load float* %new_dw, align 4
  %47 = load i32* %j, align 4
  %48 = sext i32 %47 to i64
  %49 = load i32* %k, align 4
  %50 = sext i32 %49 to i64
  %51 = load float*** %5, align 8
  %52 = getelementptr inbounds float** %51, i64 %50
  %53 = load float** %52, align 8
  %54 = getelementptr inbounds float* %53, i64 %48
  %55 = load float* %54, align 4
  %56 = fadd float %55, %46
  store float %56, float* %54, align 4
  %57 = load float* %new_dw, align 4
  %58 = load i32* %j, align 4
  %59 = sext i32 %58 to i64
  %60 = load i32* %k, align 4
  %61 = sext i32 %60 to i64
  %62 = load float*** %6, align 8
  %63 = getelementptr inbounds float** %62, i64 %61
  %64 = load float** %63, align 8
  %65 = getelementptr inbounds float* %64, i64 %59
  store float %57, float* %65, align 4
  br label %66

; <label>:66                                      ; preds = %18
  %67 = load i32* %k, align 4
  %68 = add nsw i32 %67, 1
  store i32 %68, i32* %k, align 4
  br label %14

; <label>:69                                      ; preds = %14
  br label %70

; <label>:70                                      ; preds = %69
  %71 = load i32* %j, align 4
  %72 = add nsw i32 %71, 1
  store i32 %72, i32* %j, align 4
  br label %9

; <label>:73                                      ; preds = %9
  ret void
}

; Function Attrs: nounwind uwtable
define void @bpnn_feedforward(%struct.BPNN* %net) #0 {
  %1 = alloca %struct.BPNN*, align 8
  %in = alloca i32, align 4
  %hid = alloca i32, align 4
  %out = alloca i32, align 4
  store %struct.BPNN* %net, %struct.BPNN** %1, align 8
  %2 = load %struct.BPNN** %1, align 8
  %3 = getelementptr inbounds %struct.BPNN* %2, i32 0, i32 0
  %4 = load i32* %3, align 4
  store i32 %4, i32* %in, align 4
  %5 = load %struct.BPNN** %1, align 8
  %6 = getelementptr inbounds %struct.BPNN* %5, i32 0, i32 1
  %7 = load i32* %6, align 4
  store i32 %7, i32* %hid, align 4
  %8 = load %struct.BPNN** %1, align 8
  %9 = getelementptr inbounds %struct.BPNN* %8, i32 0, i32 2
  %10 = load i32* %9, align 4
  store i32 %10, i32* %out, align 4
  %11 = load %struct.BPNN** %1, align 8
  %12 = getelementptr inbounds %struct.BPNN* %11, i32 0, i32 3
  %13 = load float** %12, align 8
  %14 = load %struct.BPNN** %1, align 8
  %15 = getelementptr inbounds %struct.BPNN* %14, i32 0, i32 4
  %16 = load float** %15, align 8
  %17 = load %struct.BPNN** %1, align 8
  %18 = getelementptr inbounds %struct.BPNN* %17, i32 0, i32 9
  %19 = load float*** %18, align 8
  %20 = load i32* %in, align 4
  %21 = load i32* %hid, align 4
  call void @bpnn_layerforward(float* %13, float* %16, float** %19, i32 %20, i32 %21)
  %22 = load %struct.BPNN** %1, align 8
  %23 = getelementptr inbounds %struct.BPNN* %22, i32 0, i32 4
  %24 = load float** %23, align 8
  %25 = load %struct.BPNN** %1, align 8
  %26 = getelementptr inbounds %struct.BPNN* %25, i32 0, i32 5
  %27 = load float** %26, align 8
  %28 = load %struct.BPNN** %1, align 8
  %29 = getelementptr inbounds %struct.BPNN* %28, i32 0, i32 10
  %30 = load float*** %29, align 8
  %31 = load i32* %hid, align 4
  %32 = load i32* %out, align 4
  call void @bpnn_layerforward(float* %24, float* %27, float** %30, i32 %31, i32 %32)
  ret void
}

; Function Attrs: nounwind uwtable
define void @bpnn_train(%struct.BPNN* %net, float* %eo, float* %eh) #0 {
  %1 = alloca %struct.BPNN*, align 8
  %2 = alloca float*, align 8
  %3 = alloca float*, align 8
  %in = alloca i32, align 4
  %hid = alloca i32, align 4
  %out = alloca i32, align 4
  %out_err = alloca float, align 4
  %hid_err = alloca float, align 4
  store %struct.BPNN* %net, %struct.BPNN** %1, align 8
  store float* %eo, float** %2, align 8
  store float* %eh, float** %3, align 8
  %4 = load %struct.BPNN** %1, align 8
  %5 = getelementptr inbounds %struct.BPNN* %4, i32 0, i32 0
  %6 = load i32* %5, align 4
  store i32 %6, i32* %in, align 4
  %7 = load %struct.BPNN** %1, align 8
  %8 = getelementptr inbounds %struct.BPNN* %7, i32 0, i32 1
  %9 = load i32* %8, align 4
  store i32 %9, i32* %hid, align 4
  %10 = load %struct.BPNN** %1, align 8
  %11 = getelementptr inbounds %struct.BPNN* %10, i32 0, i32 2
  %12 = load i32* %11, align 4
  store i32 %12, i32* %out, align 4
  %13 = load %struct.BPNN** %1, align 8
  %14 = getelementptr inbounds %struct.BPNN* %13, i32 0, i32 3
  %15 = load float** %14, align 8
  %16 = load %struct.BPNN** %1, align 8
  %17 = getelementptr inbounds %struct.BPNN* %16, i32 0, i32 4
  %18 = load float** %17, align 8
  %19 = load %struct.BPNN** %1, align 8
  %20 = getelementptr inbounds %struct.BPNN* %19, i32 0, i32 9
  %21 = load float*** %20, align 8
  %22 = load i32* %in, align 4
  %23 = load i32* %hid, align 4
  call void @bpnn_layerforward(float* %15, float* %18, float** %21, i32 %22, i32 %23)
  %24 = load %struct.BPNN** %1, align 8
  %25 = getelementptr inbounds %struct.BPNN* %24, i32 0, i32 4
  %26 = load float** %25, align 8
  %27 = load %struct.BPNN** %1, align 8
  %28 = getelementptr inbounds %struct.BPNN* %27, i32 0, i32 5
  %29 = load float** %28, align 8
  %30 = load %struct.BPNN** %1, align 8
  %31 = getelementptr inbounds %struct.BPNN* %30, i32 0, i32 10
  %32 = load float*** %31, align 8
  %33 = load i32* %hid, align 4
  %34 = load i32* %out, align 4
  call void @bpnn_layerforward(float* %26, float* %29, float** %32, i32 %33, i32 %34)
  %35 = load %struct.BPNN** %1, align 8
  %36 = getelementptr inbounds %struct.BPNN* %35, i32 0, i32 7
  %37 = load float** %36, align 8
  %38 = load %struct.BPNN** %1, align 8
  %39 = getelementptr inbounds %struct.BPNN* %38, i32 0, i32 8
  %40 = load float** %39, align 8
  %41 = load %struct.BPNN** %1, align 8
  %42 = getelementptr inbounds %struct.BPNN* %41, i32 0, i32 5
  %43 = load float** %42, align 8
  %44 = load i32* %out, align 4
  call void @bpnn_output_error(float* %37, float* %40, float* %43, i32 %44, float* %out_err)
  %45 = load %struct.BPNN** %1, align 8
  %46 = getelementptr inbounds %struct.BPNN* %45, i32 0, i32 6
  %47 = load float** %46, align 8
  %48 = load i32* %hid, align 4
  %49 = load %struct.BPNN** %1, align 8
  %50 = getelementptr inbounds %struct.BPNN* %49, i32 0, i32 7
  %51 = load float** %50, align 8
  %52 = load i32* %out, align 4
  %53 = load %struct.BPNN** %1, align 8
  %54 = getelementptr inbounds %struct.BPNN* %53, i32 0, i32 10
  %55 = load float*** %54, align 8
  %56 = load %struct.BPNN** %1, align 8
  %57 = getelementptr inbounds %struct.BPNN* %56, i32 0, i32 4
  %58 = load float** %57, align 8
  call void @bpnn_hidden_error(float* %47, i32 %48, float* %51, i32 %52, float** %55, float* %58, float* %hid_err)
  %59 = load float* %out_err, align 4
  %60 = load float** %2, align 8
  store float %59, float* %60, align 4
  %61 = load float* %hid_err, align 4
  %62 = load float** %3, align 8
  store float %61, float* %62, align 4
  %63 = load %struct.BPNN** %1, align 8
  %64 = getelementptr inbounds %struct.BPNN* %63, i32 0, i32 7
  %65 = load float** %64, align 8
  %66 = load i32* %out, align 4
  %67 = load %struct.BPNN** %1, align 8
  %68 = getelementptr inbounds %struct.BPNN* %67, i32 0, i32 4
  %69 = load float** %68, align 8
  %70 = load i32* %hid, align 4
  %71 = load %struct.BPNN** %1, align 8
  %72 = getelementptr inbounds %struct.BPNN* %71, i32 0, i32 10
  %73 = load float*** %72, align 8
  %74 = load %struct.BPNN** %1, align 8
  %75 = getelementptr inbounds %struct.BPNN* %74, i32 0, i32 12
  %76 = load float*** %75, align 8
  call void @bpnn_adjust_weights(float* %65, i32 %66, float* %69, i32 %70, float** %73, float** %76)
  %77 = load %struct.BPNN** %1, align 8
  %78 = getelementptr inbounds %struct.BPNN* %77, i32 0, i32 6
  %79 = load float** %78, align 8
  %80 = load i32* %hid, align 4
  %81 = load %struct.BPNN** %1, align 8
  %82 = getelementptr inbounds %struct.BPNN* %81, i32 0, i32 3
  %83 = load float** %82, align 8
  %84 = load i32* %in, align 4
  %85 = load %struct.BPNN** %1, align 8
  %86 = getelementptr inbounds %struct.BPNN* %85, i32 0, i32 9
  %87 = load float*** %86, align 8
  %88 = load %struct.BPNN** %1, align 8
  %89 = getelementptr inbounds %struct.BPNN* %88, i32 0, i32 11
  %90 = load float*** %89, align 8
  call void @bpnn_adjust_weights(float* %79, i32 %80, float* %83, i32 %84, float** %87, float** %90)
  ret void
}

; Function Attrs: nounwind uwtable
define void @bpnn_save(%struct.BPNN* %net, i8* %filename) #0 {
  %1 = alloca %struct.BPNN*, align 8
  %2 = alloca i8*, align 8
  %n1 = alloca i32, align 4
  %n2 = alloca i32, align 4
  %n3 = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %memcnt = alloca i32, align 4
  %dvalue = alloca float, align 4
  %w = alloca float**, align 8
  %mem = alloca i8*, align 8
  %pFile = alloca %struct._IO_FILE*, align 8
  %_to = alloca i8*, align 8
  %_from = alloca i8*, align 8
  %_i = alloca i32, align 4
  %_l = alloca i32, align 4
  %_to1 = alloca i8*, align 8
  %_from2 = alloca i8*, align 8
  %_i3 = alloca i32, align 4
  %_l4 = alloca i32, align 4
  store %struct.BPNN* %net, %struct.BPNN** %1, align 8
  store i8* %filename, i8** %2, align 8
  %3 = load i8** %2, align 8
  %4 = call %struct._IO_FILE* @fopen(i8* %3, i8* getelementptr inbounds ([3 x i8]* @.str4, i32 0, i32 0))
  store %struct._IO_FILE* %4, %struct._IO_FILE** %pFile, align 8
  %5 = load %struct.BPNN** %1, align 8
  %6 = getelementptr inbounds %struct.BPNN* %5, i32 0, i32 0
  %7 = load i32* %6, align 4
  store i32 %7, i32* %n1, align 4
  %8 = load %struct.BPNN** %1, align 8
  %9 = getelementptr inbounds %struct.BPNN* %8, i32 0, i32 1
  %10 = load i32* %9, align 4
  store i32 %10, i32* %n2, align 4
  %11 = load %struct.BPNN** %1, align 8
  %12 = getelementptr inbounds %struct.BPNN* %11, i32 0, i32 2
  %13 = load i32* %12, align 4
  store i32 %13, i32* %n3, align 4
  %14 = load i32* %n1, align 4
  %15 = load i32* %n2, align 4
  %16 = load i32* %n3, align 4
  %17 = load i8** %2, align 8
  %18 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([33 x i8]* @.str5, i32 0, i32 0), i32 %14, i32 %15, i32 %16, i8* %17)
  %19 = bitcast i32* %n1 to i8*
  %20 = load %struct._IO_FILE** %pFile, align 8
  %21 = call i64 @fwrite(i8* %19, i64 4, i64 1, %struct._IO_FILE* %20)
  %22 = bitcast i32* %n2 to i8*
  %23 = load %struct._IO_FILE** %pFile, align 8
  %24 = call i64 @fwrite(i8* %22, i64 4, i64 1, %struct._IO_FILE* %23)
  %25 = bitcast i32* %n3 to i8*
  %26 = load %struct._IO_FILE** %pFile, align 8
  %27 = call i64 @fwrite(i8* %25, i64 4, i64 1, %struct._IO_FILE* %26)
  store i32 0, i32* %memcnt, align 4
  %28 = load %struct.BPNN** %1, align 8
  %29 = getelementptr inbounds %struct.BPNN* %28, i32 0, i32 9
  %30 = load float*** %29, align 8
  store float** %30, float*** %w, align 8
  %31 = load i32* %n1, align 4
  %32 = add nsw i32 %31, 1
  %33 = load i32* %n2, align 4
  %34 = add nsw i32 %33, 1
  %35 = mul nsw i32 %32, %34
  %36 = sext i32 %35 to i64
  %37 = mul i64 %36, 4
  %38 = trunc i64 %37 to i32
  %39 = zext i32 %38 to i64
  %40 = call noalias i8* @malloc(i64 %39) #5
  store i8* %40, i8** %mem, align 8
  store i32 0, i32* %i, align 4
  br label %41

; <label>:41                                      ; preds = %87, %0
  %42 = load i32* %i, align 4
  %43 = load i32* %n1, align 4
  %44 = icmp sle i32 %42, %43
  br i1 %44, label %45, label %90

; <label>:45                                      ; preds = %41
  store i32 0, i32* %j, align 4
  br label %46

; <label>:46                                      ; preds = %83, %45
  %47 = load i32* %j, align 4
  %48 = load i32* %n2, align 4
  %49 = icmp sle i32 %47, %48
  br i1 %49, label %50, label %86

; <label>:50                                      ; preds = %46
  %51 = load i32* %j, align 4
  %52 = sext i32 %51 to i64
  %53 = load i32* %i, align 4
  %54 = sext i32 %53 to i64
  %55 = load float*** %w, align 8
  %56 = getelementptr inbounds float** %55, i64 %54
  %57 = load float** %56, align 8
  %58 = getelementptr inbounds float* %57, i64 %52
  %59 = load float* %58, align 4
  store float %59, float* %dvalue, align 4
  %60 = load i32* %memcnt, align 4
  %61 = sext i32 %60 to i64
  %62 = load i8** %mem, align 8
  %63 = getelementptr inbounds i8* %62, i64 %61
  store i8* %63, i8** %_to, align 8
  %64 = bitcast float* %dvalue to i8*
  store i8* %64, i8** %_from, align 8
  store i32 4, i32* %_l, align 4
  store i32 0, i32* %_i, align 4
  br label %65

; <label>:65                                      ; preds = %75, %50
  %66 = load i32* %_i, align 4
  %67 = load i32* %_l, align 4
  %68 = icmp slt i32 %66, %67
  br i1 %68, label %69, label %78

; <label>:69                                      ; preds = %65
  %70 = load i8** %_from, align 8
  %71 = getelementptr inbounds i8* %70, i32 1
  store i8* %71, i8** %_from, align 8
  %72 = load i8* %70, align 1
  %73 = load i8** %_to, align 8
  %74 = getelementptr inbounds i8* %73, i32 1
  store i8* %74, i8** %_to, align 8
  store i8 %72, i8* %73, align 1
  br label %75

; <label>:75                                      ; preds = %69
  %76 = load i32* %_i, align 4
  %77 = add nsw i32 %76, 1
  store i32 %77, i32* %_i, align 4
  br label %65

; <label>:78                                      ; preds = %65
  %79 = load i32* %memcnt, align 4
  %80 = sext i32 %79 to i64
  %81 = add i64 %80, 4
  %82 = trunc i64 %81 to i32
  store i32 %82, i32* %memcnt, align 4
  br label %83

; <label>:83                                      ; preds = %78
  %84 = load i32* %j, align 4
  %85 = add nsw i32 %84, 1
  store i32 %85, i32* %j, align 4
  br label %46

; <label>:86                                      ; preds = %46
  br label %87

; <label>:87                                      ; preds = %86
  %88 = load i32* %i, align 4
  %89 = add nsw i32 %88, 1
  store i32 %89, i32* %i, align 4
  br label %41

; <label>:90                                      ; preds = %41
  %91 = load i8** %mem, align 8
  %92 = load i32* %n1, align 4
  %93 = add nsw i32 %92, 1
  %94 = load i32* %n2, align 4
  %95 = add nsw i32 %94, 1
  %96 = mul nsw i32 %93, %95
  %97 = zext i32 %96 to i64
  %98 = load %struct._IO_FILE** %pFile, align 8
  %99 = call i64 @fwrite(i8* %91, i64 4, i64 %97, %struct._IO_FILE* %98)
  %100 = load i8** %mem, align 8
  call void @free(i8* %100) #5
  store i32 0, i32* %memcnt, align 4
  %101 = load %struct.BPNN** %1, align 8
  %102 = getelementptr inbounds %struct.BPNN* %101, i32 0, i32 10
  %103 = load float*** %102, align 8
  store float** %103, float*** %w, align 8
  %104 = load i32* %n2, align 4
  %105 = add nsw i32 %104, 1
  %106 = load i32* %n3, align 4
  %107 = add nsw i32 %106, 1
  %108 = mul nsw i32 %105, %107
  %109 = sext i32 %108 to i64
  %110 = mul i64 %109, 4
  %111 = trunc i64 %110 to i32
  %112 = zext i32 %111 to i64
  %113 = call noalias i8* @malloc(i64 %112) #5
  store i8* %113, i8** %mem, align 8
  store i32 0, i32* %i, align 4
  br label %114

; <label>:114                                     ; preds = %160, %90
  %115 = load i32* %i, align 4
  %116 = load i32* %n2, align 4
  %117 = icmp sle i32 %115, %116
  br i1 %117, label %118, label %163

; <label>:118                                     ; preds = %114
  store i32 0, i32* %j, align 4
  br label %119

; <label>:119                                     ; preds = %156, %118
  %120 = load i32* %j, align 4
  %121 = load i32* %n3, align 4
  %122 = icmp sle i32 %120, %121
  br i1 %122, label %123, label %159

; <label>:123                                     ; preds = %119
  %124 = load i32* %j, align 4
  %125 = sext i32 %124 to i64
  %126 = load i32* %i, align 4
  %127 = sext i32 %126 to i64
  %128 = load float*** %w, align 8
  %129 = getelementptr inbounds float** %128, i64 %127
  %130 = load float** %129, align 8
  %131 = getelementptr inbounds float* %130, i64 %125
  %132 = load float* %131, align 4
  store float %132, float* %dvalue, align 4
  %133 = load i32* %memcnt, align 4
  %134 = sext i32 %133 to i64
  %135 = load i8** %mem, align 8
  %136 = getelementptr inbounds i8* %135, i64 %134
  store i8* %136, i8** %_to1, align 8
  %137 = bitcast float* %dvalue to i8*
  store i8* %137, i8** %_from2, align 8
  store i32 4, i32* %_l4, align 4
  store i32 0, i32* %_i3, align 4
  br label %138

; <label>:138                                     ; preds = %148, %123
  %139 = load i32* %_i3, align 4
  %140 = load i32* %_l4, align 4
  %141 = icmp slt i32 %139, %140
  br i1 %141, label %142, label %151

; <label>:142                                     ; preds = %138
  %143 = load i8** %_from2, align 8
  %144 = getelementptr inbounds i8* %143, i32 1
  store i8* %144, i8** %_from2, align 8
  %145 = load i8* %143, align 1
  %146 = load i8** %_to1, align 8
  %147 = getelementptr inbounds i8* %146, i32 1
  store i8* %147, i8** %_to1, align 8
  store i8 %145, i8* %146, align 1
  br label %148

; <label>:148                                     ; preds = %142
  %149 = load i32* %_i3, align 4
  %150 = add nsw i32 %149, 1
  store i32 %150, i32* %_i3, align 4
  br label %138

; <label>:151                                     ; preds = %138
  %152 = load i32* %memcnt, align 4
  %153 = sext i32 %152 to i64
  %154 = add i64 %153, 4
  %155 = trunc i64 %154 to i32
  store i32 %155, i32* %memcnt, align 4
  br label %156

; <label>:156                                     ; preds = %151
  %157 = load i32* %j, align 4
  %158 = add nsw i32 %157, 1
  store i32 %158, i32* %j, align 4
  br label %119

; <label>:159                                     ; preds = %119
  br label %160

; <label>:160                                     ; preds = %159
  %161 = load i32* %i, align 4
  %162 = add nsw i32 %161, 1
  store i32 %162, i32* %i, align 4
  br label %114

; <label>:163                                     ; preds = %114
  %164 = load i8** %mem, align 8
  %165 = load i32* %n2, align 4
  %166 = add nsw i32 %165, 1
  %167 = load i32* %n3, align 4
  %168 = add nsw i32 %167, 1
  %169 = mul nsw i32 %166, %168
  %170 = zext i32 %169 to i64
  %171 = load %struct._IO_FILE** %pFile, align 8
  %172 = call i64 @fwrite(i8* %164, i64 4, i64 %170, %struct._IO_FILE* %171)
  %173 = load i8** %mem, align 8
  call void @free(i8* %173) #5
  %174 = load %struct._IO_FILE** %pFile, align 8
  %175 = call i32 @fclose(%struct._IO_FILE* %174)
  ret void
}

declare %struct._IO_FILE* @fopen(i8*, i8*) #2

declare i64 @fwrite(i8*, i64, i64, %struct._IO_FILE*) #2

declare i32 @fclose(%struct._IO_FILE*) #2

; Function Attrs: nounwind uwtable
define %struct.BPNN* @bpnn_read(i8* %filename) #0 {
  %1 = alloca %struct.BPNN*, align 8
  %2 = alloca i8*, align 8
  %mem = alloca i8*, align 8
  %new = alloca %struct.BPNN*, align 8
  %fd = alloca i32, align 4
  %n1 = alloca i32, align 4
  %n2 = alloca i32, align 4
  %n3 = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %memcnt = alloca i32, align 4
  %_to = alloca i8*, align 8
  %_from = alloca i8*, align 8
  %_i = alloca i32, align 4
  %_l = alloca i32, align 4
  %_to1 = alloca i8*, align 8
  %_from2 = alloca i8*, align 8
  %_i3 = alloca i32, align 4
  %_l4 = alloca i32, align 4
  store i8* %filename, i8** %2, align 8
  %3 = load i8** %2, align 8
  %4 = call i32 (i8*, i32, ...)* @open(i8* %3, i32 0, i32 420)
  store i32 %4, i32* %fd, align 4
  %5 = icmp eq i32 %4, -1
  br i1 %5, label %6, label %7

; <label>:6                                       ; preds = %0
  store %struct.BPNN* null, %struct.BPNN** %1
  br label %188

; <label>:7                                       ; preds = %0
  %8 = load i8** %2, align 8
  %9 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str6, i32 0, i32 0), i8* %8)
  %10 = load i32* %fd, align 4
  %11 = bitcast i32* %n1 to i8*
  %12 = call i64 @read(i32 %10, i8* %11, i64 4)
  %13 = load i32* %fd, align 4
  %14 = bitcast i32* %n2 to i8*
  %15 = call i64 @read(i32 %13, i8* %14, i64 4)
  %16 = load i32* %fd, align 4
  %17 = bitcast i32* %n3 to i8*
  %18 = call i64 @read(i32 %16, i8* %17, i64 4)
  %19 = load i32* %n1, align 4
  %20 = load i32* %n2, align 4
  %21 = load i32* %n3, align 4
  %22 = call %struct.BPNN* @bpnn_internal_create(i32 %19, i32 %20, i32 %21)
  store %struct.BPNN* %22, %struct.BPNN** %new, align 8
  %23 = load i8** %2, align 8
  %24 = load i32* %n1, align 4
  %25 = load i32* %n2, align 4
  %26 = load i32* %n3, align 4
  %27 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([34 x i8]* @.str7, i32 0, i32 0), i8* %23, i32 %24, i32 %25, i32 %26)
  %28 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([25 x i8]* @.str8, i32 0, i32 0))
  store i32 0, i32* %memcnt, align 4
  %29 = load i32* %n1, align 4
  %30 = add nsw i32 %29, 1
  %31 = load i32* %n2, align 4
  %32 = add nsw i32 %31, 1
  %33 = mul nsw i32 %30, %32
  %34 = sext i32 %33 to i64
  %35 = mul i64 %34, 4
  %36 = trunc i64 %35 to i32
  %37 = zext i32 %36 to i64
  %38 = call noalias i8* @malloc(i64 %37) #5
  store i8* %38, i8** %mem, align 8
  %39 = load i32* %fd, align 4
  %40 = load i8** %mem, align 8
  %41 = load i32* %n1, align 4
  %42 = add nsw i32 %41, 1
  %43 = load i32* %n2, align 4
  %44 = add nsw i32 %43, 1
  %45 = mul nsw i32 %42, %44
  %46 = sext i32 %45 to i64
  %47 = mul i64 %46, 4
  %48 = call i64 @read(i32 %39, i8* %40, i64 %47)
  store i32 0, i32* %i, align 4
  br label %49

; <label>:49                                      ; preds = %96, %7
  %50 = load i32* %i, align 4
  %51 = load i32* %n1, align 4
  %52 = icmp sle i32 %50, %51
  br i1 %52, label %53, label %99

; <label>:53                                      ; preds = %49
  store i32 0, i32* %j, align 4
  br label %54

; <label>:54                                      ; preds = %92, %53
  %55 = load i32* %j, align 4
  %56 = load i32* %n2, align 4
  %57 = icmp sle i32 %55, %56
  br i1 %57, label %58, label %95

; <label>:58                                      ; preds = %54
  %59 = load i32* %j, align 4
  %60 = sext i32 %59 to i64
  %61 = load i32* %i, align 4
  %62 = sext i32 %61 to i64
  %63 = load %struct.BPNN** %new, align 8
  %64 = getelementptr inbounds %struct.BPNN* %63, i32 0, i32 9
  %65 = load float*** %64, align 8
  %66 = getelementptr inbounds float** %65, i64 %62
  %67 = load float** %66, align 8
  %68 = getelementptr inbounds float* %67, i64 %60
  %69 = bitcast float* %68 to i8*
  store i8* %69, i8** %_to, align 8
  %70 = load i32* %memcnt, align 4
  %71 = sext i32 %70 to i64
  %72 = load i8** %mem, align 8
  %73 = getelementptr inbounds i8* %72, i64 %71
  store i8* %73, i8** %_from, align 8
  store i32 4, i32* %_l, align 4
  store i32 0, i32* %_i, align 4
  br label %74

; <label>:74                                      ; preds = %84, %58
  %75 = load i32* %_i, align 4
  %76 = load i32* %_l, align 4
  %77 = icmp slt i32 %75, %76
  br i1 %77, label %78, label %87

; <label>:78                                      ; preds = %74
  %79 = load i8** %_from, align 8
  %80 = getelementptr inbounds i8* %79, i32 1
  store i8* %80, i8** %_from, align 8
  %81 = load i8* %79, align 1
  %82 = load i8** %_to, align 8
  %83 = getelementptr inbounds i8* %82, i32 1
  store i8* %83, i8** %_to, align 8
  store i8 %81, i8* %82, align 1
  br label %84

; <label>:84                                      ; preds = %78
  %85 = load i32* %_i, align 4
  %86 = add nsw i32 %85, 1
  store i32 %86, i32* %_i, align 4
  br label %74

; <label>:87                                      ; preds = %74
  %88 = load i32* %memcnt, align 4
  %89 = sext i32 %88 to i64
  %90 = add i64 %89, 4
  %91 = trunc i64 %90 to i32
  store i32 %91, i32* %memcnt, align 4
  br label %92

; <label>:92                                      ; preds = %87
  %93 = load i32* %j, align 4
  %94 = add nsw i32 %93, 1
  store i32 %94, i32* %j, align 4
  br label %54

; <label>:95                                      ; preds = %54
  br label %96

; <label>:96                                      ; preds = %95
  %97 = load i32* %i, align 4
  %98 = add nsw i32 %97, 1
  store i32 %98, i32* %i, align 4
  br label %49

; <label>:99                                      ; preds = %49
  %100 = load i8** %mem, align 8
  call void @free(i8* %100) #5
  %101 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([31 x i8]* @.str9, i32 0, i32 0))
  store i32 0, i32* %memcnt, align 4
  %102 = load i32* %n2, align 4
  %103 = add nsw i32 %102, 1
  %104 = load i32* %n3, align 4
  %105 = add nsw i32 %104, 1
  %106 = mul nsw i32 %103, %105
  %107 = sext i32 %106 to i64
  %108 = mul i64 %107, 4
  %109 = trunc i64 %108 to i32
  %110 = zext i32 %109 to i64
  %111 = call noalias i8* @malloc(i64 %110) #5
  store i8* %111, i8** %mem, align 8
  %112 = load i32* %fd, align 4
  %113 = load i8** %mem, align 8
  %114 = load i32* %n2, align 4
  %115 = add nsw i32 %114, 1
  %116 = load i32* %n3, align 4
  %117 = add nsw i32 %116, 1
  %118 = mul nsw i32 %115, %117
  %119 = sext i32 %118 to i64
  %120 = mul i64 %119, 4
  %121 = call i64 @read(i32 %112, i8* %113, i64 %120)
  store i32 0, i32* %i, align 4
  br label %122

; <label>:122                                     ; preds = %169, %99
  %123 = load i32* %i, align 4
  %124 = load i32* %n2, align 4
  %125 = icmp sle i32 %123, %124
  br i1 %125, label %126, label %172

; <label>:126                                     ; preds = %122
  store i32 0, i32* %j, align 4
  br label %127

; <label>:127                                     ; preds = %165, %126
  %128 = load i32* %j, align 4
  %129 = load i32* %n3, align 4
  %130 = icmp sle i32 %128, %129
  br i1 %130, label %131, label %168

; <label>:131                                     ; preds = %127
  %132 = load i32* %j, align 4
  %133 = sext i32 %132 to i64
  %134 = load i32* %i, align 4
  %135 = sext i32 %134 to i64
  %136 = load %struct.BPNN** %new, align 8
  %137 = getelementptr inbounds %struct.BPNN* %136, i32 0, i32 10
  %138 = load float*** %137, align 8
  %139 = getelementptr inbounds float** %138, i64 %135
  %140 = load float** %139, align 8
  %141 = getelementptr inbounds float* %140, i64 %133
  %142 = bitcast float* %141 to i8*
  store i8* %142, i8** %_to1, align 8
  %143 = load i32* %memcnt, align 4
  %144 = sext i32 %143 to i64
  %145 = load i8** %mem, align 8
  %146 = getelementptr inbounds i8* %145, i64 %144
  store i8* %146, i8** %_from2, align 8
  store i32 4, i32* %_l4, align 4
  store i32 0, i32* %_i3, align 4
  br label %147

; <label>:147                                     ; preds = %157, %131
  %148 = load i32* %_i3, align 4
  %149 = load i32* %_l4, align 4
  %150 = icmp slt i32 %148, %149
  br i1 %150, label %151, label %160

; <label>:151                                     ; preds = %147
  %152 = load i8** %_from2, align 8
  %153 = getelementptr inbounds i8* %152, i32 1
  store i8* %153, i8** %_from2, align 8
  %154 = load i8* %152, align 1
  %155 = load i8** %_to1, align 8
  %156 = getelementptr inbounds i8* %155, i32 1
  store i8* %156, i8** %_to1, align 8
  store i8 %154, i8* %155, align 1
  br label %157

; <label>:157                                     ; preds = %151
  %158 = load i32* %_i3, align 4
  %159 = add nsw i32 %158, 1
  store i32 %159, i32* %_i3, align 4
  br label %147

; <label>:160                                     ; preds = %147
  %161 = load i32* %memcnt, align 4
  %162 = sext i32 %161 to i64
  %163 = add i64 %162, 4
  %164 = trunc i64 %163 to i32
  store i32 %164, i32* %memcnt, align 4
  br label %165

; <label>:165                                     ; preds = %160
  %166 = load i32* %j, align 4
  %167 = add nsw i32 %166, 1
  store i32 %167, i32* %j, align 4
  br label %127

; <label>:168                                     ; preds = %127
  br label %169

; <label>:169                                     ; preds = %168
  %170 = load i32* %i, align 4
  %171 = add nsw i32 %170, 1
  store i32 %171, i32* %i, align 4
  br label %122

; <label>:172                                     ; preds = %122
  %173 = load i8** %mem, align 8
  call void @free(i8* %173) #5
  %174 = load i32* %fd, align 4
  %175 = call i32 @close(i32 %174)
  %176 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str10, i32 0, i32 0))
  %177 = load %struct.BPNN** %new, align 8
  %178 = getelementptr inbounds %struct.BPNN* %177, i32 0, i32 11
  %179 = load float*** %178, align 8
  %180 = load i32* %n1, align 4
  %181 = load i32* %n2, align 4
  call void @bpnn_zero_weights(float** %179, i32 %180, i32 %181)
  %182 = load %struct.BPNN** %new, align 8
  %183 = getelementptr inbounds %struct.BPNN* %182, i32 0, i32 12
  %184 = load float*** %183, align 8
  %185 = load i32* %n2, align 4
  %186 = load i32* %n3, align 4
  call void @bpnn_zero_weights(float** %184, i32 %185, i32 %186)
  %187 = load %struct.BPNN** %new, align 8
  store %struct.BPNN* %187, %struct.BPNN** %1
  br label %188

; <label>:188                                     ; preds = %172, %6
  %189 = load %struct.BPNN** %1
  ret %struct.BPNN* %189
}

declare i32 @open(i8*, i32, ...) #2

declare i64 @read(i32, i8*, i64) #2

declare i32 @close(i32) #2

; Function Attrs: nounwind uwtable
define void @backprop_face() #0 {
  %net = alloca %struct.BPNN*, align 8
  %i = alloca i32, align 4
  %out_err = alloca float, align 4
  %hid_err = alloca float, align 4
  %1 = load i32* @layer_size, align 4
  %2 = call %struct.BPNN* (i32, i32, i32, ...)* bitcast (%struct.BPNN* (i32, i32, i32)* @bpnn_create to %struct.BPNN* (i32, i32, i32, ...)*)(i32 %1, i32 16, i32 1)
  store %struct.BPNN* %2, %struct.BPNN** %net, align 8
  %3 = load i32* @layer_size, align 4
  %4 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str11, i32 0, i32 0), i32 %3)
  %5 = load %struct.BPNN** %net, align 8
  %6 = call i32 @load(%struct.BPNN* %5)
  %7 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([26 x i8]* @.str112, i32 0, i32 0))
  %8 = load %struct.BPNN** %net, align 8
  call void @bpnn_train_kernel(%struct.BPNN* %8, float* %out_err, float* %hid_err)
  %9 = load %struct.BPNN** %net, align 8
  call void (%struct.BPNN*, i8*, ...)* bitcast (void (%struct.BPNN*, i8*)* @bpnn_save to void (%struct.BPNN*, i8*, ...)*)(%struct.BPNN* %9, i8* getelementptr inbounds ([11 x i8]* @.str213, i32 0, i32 0))
  %10 = load %struct.BPNN** %net, align 8
  call void (%struct.BPNN*, ...)* bitcast (void (%struct.BPNN*)* @bpnn_free to void (%struct.BPNN*, ...)*)(%struct.BPNN* %10)
  %11 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str314, i32 0, i32 0))
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @setup(i32 %argc, i8** %argv) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %seed = alloca i32, align 4
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  %4 = load i32* %2, align 4
  %5 = icmp ne i32 %4, 2
  br i1 %5, label %6, label %9

; <label>:6                                       ; preds = %0
  %7 = load %struct._IO_FILE** @stderr, align 8
  %8 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %7, i8* getelementptr inbounds ([41 x i8]* @.str415, i32 0, i32 0))
  call void @exit(i32 1) #6
  unreachable

; <label>:9                                       ; preds = %0
  %10 = load i8*** %3, align 8
  %11 = getelementptr inbounds i8** %10, i64 1
  %12 = load i8** %11, align 8
  %13 = call i32 @atoi(i8* %12) #7
  store i32 %13, i32* @layer_size, align 4
  %14 = load i32* @layer_size, align 4
  %15 = srem i32 %14, 16
  %16 = icmp ne i32 %15, 0
  br i1 %16, label %17, label %20

; <label>:17                                      ; preds = %9
  %18 = load %struct._IO_FILE** @stderr, align 8
  %19 = call i32 (%struct._IO_FILE*, i8*, ...)* @fprintf(%struct._IO_FILE* %18, i8* getelementptr inbounds ([50 x i8]* @.str516, i32 0, i32 0))
  call void @exit(i32 1) #6
  unreachable

; <label>:20                                      ; preds = %9
  store i32 7, i32* %seed, align 4
  %21 = load i32* %seed, align 4
  call void (i32, ...)* bitcast (void (i32)* @bpnn_initialize to void (i32, ...)*)(i32 %21)
  call void @backprop_face()
  call void @exit(i32 0) #6
  unreachable
                                                  ; No predecessors!
  %23 = load i32* %1
  ret i32 %23
}

declare i32 @fprintf(%struct._IO_FILE*, i8*, ...) #2

; Function Attrs: noreturn nounwind
declare void @exit(i32) #3

; Function Attrs: nounwind readonly
declare i32 @atoi(i8*) #4

; Function Attrs: nounwind uwtable
define i32 @load(%struct.BPNN* %net) #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.BPNN*, align 8
  %units = alloca float*, align 8
  %nr = alloca i32, align 4
  %nc = alloca i32, align 4
  %imgsize = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  store %struct.BPNN* %net, %struct.BPNN** %2, align 8
  %3 = load i32* @layer_size, align 4
  store i32 %3, i32* %nr, align 4
  %4 = load i32* %nr, align 4
  %5 = load i32* %nc, align 4
  %6 = mul nsw i32 %4, %5
  store i32 %6, i32* %imgsize, align 4
  %7 = load %struct.BPNN** %2, align 8
  %8 = getelementptr inbounds %struct.BPNN* %7, i32 0, i32 3
  %9 = load float** %8, align 8
  store float* %9, float** %units, align 8
  store i32 1, i32* %k, align 4
  store i32 0, i32* %i, align 4
  br label %10

; <label>:10                                      ; preds = %24, %0
  %11 = load i32* %i, align 4
  %12 = load i32* %nr, align 4
  %13 = icmp slt i32 %11, %12
  br i1 %13, label %14, label %27

; <label>:14                                      ; preds = %10
  %15 = call i32 @rand() #5
  %16 = sitofp i32 %15 to float
  %17 = fdiv float %16, 0x41E0000000000000
  %18 = load i32* %k, align 4
  %19 = sext i32 %18 to i64
  %20 = load float** %units, align 8
  %21 = getelementptr inbounds float* %20, i64 %19
  store float %17, float* %21, align 4
  %22 = load i32* %k, align 4
  %23 = add nsw i32 %22, 1
  store i32 %23, i32* %k, align 4
  br label %24

; <label>:24                                      ; preds = %14
  %25 = load i32* %i, align 4
  %26 = add nsw i32 %25, 1
  store i32 %26, i32* %i, align 4
  br label %10

; <label>:27                                      ; preds = %10
  %28 = load i32* %1
  ret i32 %28
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }
attributes #6 = { noreturn nounwind }
attributes #7 = { nounwind readonly }

!llvm.ident = !{!0, !0, !0, !0}

!0 = metadata !{metadata !"clang version 3.4 (tags/RELEASE_34/final)"}
