clc;clear all;

testcase = input('Enter the test case number: ');
 switch testcase
     
      case 0
      A=input('Enter matrix A=');
      
      case 1
      A=[5 6 70 8 2 1;5 8 9 7 91 1;1 2 5 8 9 6;8 7 30 6 9 1;8 7 3 4 6 9;5 8 9 7 9 1];
      b=[5 8 9 7 2 9]';%take any value   
     
     case 2
       A=[5 6 7 8 2 1;5 8 9 7 9 1;1 2 5 8 9 6;8 7 3 6 9 1;2 0 8 9 3 7];  
       b=[2 8 9 7 3]';% take any value 
     
     case 3
         A=[5 6 7 8;5 8 9 7 ;1 2 5 8;8 7 3 6 ;2 0 8 9];
        % here i did not take value of b bcz it is not solvable for any
        % value
         
     case 4
         A=[5 6 7 8;5 8 9 7 ;1 2 5 8;5 8 9 7 ;5 6 7 8];
        % here i did not take value of b bcz it is not solvable for every 
        % value of b
         
 otherwise
 error('invalid test case');
 end
 
[n,m]=size(A);
r= rank( A );
%%




%% a

R = rref( A );

%%

%%b

Z = null(A) ;
Dimension_null_space= size(Z, 2); 
Dimension_column_space = r;



%%

%%c(special solution of AX=0)
 if rank(A)<m && rank(A)<n
     x2=input('Enter free variabe x2= ');
     x4=input('Enter free variabe x4= ');
         syms x1  x3  
         X=[x1;x2;x3;x4];
         eq=A*X==0;
         solx=solve(eq);
          x1=solx.x1;
       x3=solx.x3;
      N=[x1;x2;x3;x4];


elseif n==m
    syms x1 x2 x3 x4 x5 x6
         X=[x1;x2;x3;x4;x5;x6];
         eq=A*X==0;
         solx=solve(eq);
          x1=solx.x1;
         x2=solx.x2;
       x3=solx.x3;
       x4=solx.x4;
      x5=solx.x5;
       x6=solx.x6;
      N=[x1;x2;x3;x4;x5;x6];
      
elseif n<m     
    x6=input('Enter free variabe x6= ');
         syms x1 x2 x3 x4 x5 
         X=[x1;x2;x3;x4;x5;x6];
         eq=A*X==0;
         solx=solve(eq);
          x1=solx.x1;
         x2=solx.x2;
       x3=solx.x3;
       x4=solx.x4;
      x5=solx.x5;
      N=[x1;x2;x3;x4;x5;x6]; 

      
 elseif n>m
      syms x1 x2 x3 x4 
         X=[x1;x2;x3;x4];
         eq=A*X==0;
         solx=solve(eq);
          x1=solx.x1;
         x2=solx.x2;
       x3=solx.x3;
        x4=solx.x4;
      N=[x1;x2;x3;x4] ;
end
    %%
    
    
    %% d(Particular solution of AX=b)
    if rank(A)<m && rank(A)<n
        
   b=input('Enter the matrix b=');
   Xp=R\b;  
    
    elseif n==m
    
    Xp=R\b;
    
    elseif n<m 
    
   Xp=R\b;
        
        
   elseif n>m
   b=input('Enter the matrix b=');
   Xp=R\b;
    
    end
    
  
    %%
    disp(R)
    disp(Dimension_null_space)
    disp(Dimension_column_space)
    disp(N)
    disp(Xp)
   
    
    
    
    
    
    
    
    



     