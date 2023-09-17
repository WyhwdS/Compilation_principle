define i32 @gcd(i32 %a,i32 %b){
entry:
    %retval = alloca i32, align 4
    %a.addr = alloca i32, align 4
    store i32 %a, i32* %a.addr, align 4
    %b.addr = alloca i32, align 4
    store i32 %a, i32* %b.addr, align 4
    %0 = load i32, i32* %a.addr, align 4
    %1 = load i32, i32* %b.addr, align 4
    %2 = srem i32 %0, %1
    %3 = icmp eq i32 %2, 0
    br i1 %3, label %if.then, label %if.else

if.then:
    store i32 %1, i32* %retval, align 4
    br label %return 

if.else:
    %call1 = call i32 @gcd(i32 %1, i32 %2)
    store i32 %call1, i32* %retval, align 4
    br label %return 

return:
    %4 = load i32, i32* %retval, align 4
    ret i32 %4
}

declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)

@formatStr1 = private constant [5 x i8] c"%d%d\00" 
@formatStr2 = private unnamed_addr constant [3 x i8] c"%d\00", align 1

define i32 @main()#0{
entry:
    %a = alloca [10 x i32], align 16
    %b = alloca [10 x i32], align 16
    %i = alloca i32, align 4
    store i32 0, i32* %i, align 4
    br label %for.bond

for.bond:
    %0 = load i32, i32* %i, align 4
    %1 = icmp slt i32 %0, 10
    br i1 %1, label %for.body, label %for.end

for.body:
    %array_a = getelementptr inbounds [10 x i32], [10 x i32]* %a, i32 0, i32 %0
    %array_b = getelementptr inbounds [10 x i32], [10 x i32]* %b, i32 0, i32 %0
    %formatStrPtr1 = getelementptr [5 x i8], [5 x i8]* @formatStr1, i32 0, i32 0
    call i32 (i8*, ...) @scanf(i8* %formatStrPtr1, i32* %array_a, i32* %array_b)
    %add = add nsw i32 %0, 1
    store i32 %add, i32* %i, align 4
    br label %for.bond

for.end:
    %print_a = getelementptr inbounds [10 x i32], [10 x i32]* %a, i32 0, i32 0
    %print_b = getelementptr inbounds [10 x i32], [10 x i32]* %b, i32 0, i32 0
    %3 = load i32, i32* %print_a, align 16
    %4 = load i32, i32* %print_b, align 16
    %call1 = call i32 @gcd(i32 %3,i32 %4)
    %formatStrPtr2 = getelementptr [3 x i8], [3 x i8]* @formatStr2, i32 0, i32 0
    %call2 = call i32(i8*,...)@printf(i8* %formatStrPtr2, i32 %call1)
    ret i32 0
}
