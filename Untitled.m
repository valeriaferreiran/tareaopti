
clear all
% c = vector de costos
% A = matriz de coeficientes 
% b = lado derecho 
% max o min 

%min = true
%max= false

%verbose=true - quiere ver  las soluciones paso a paso

% Verificar si es formato estandar o canonico 

a=[1 2 3 4 ; 5 6 7 6 ; 8 9 6 3 ];
b=[1 2 3 ];
c=[1 2 3 1];
%fase1(a,b,c,true);

format(false,a,b,c,true);

function [c] = format(minmax,A,b,c,verbose)

if minmax==false 
    c=-1.*c;
    
     if verbose == true
        disp(['Vamos a maximizar por medio del metodo simplex']) 
        disp(['Nuevo vector de costos :'])
        disp(c)

     end
else
     if verbose == true
        disp(['Vamos a minimizar']) 

    end 
end

b=b' ;

dimA= size(A);
dimb= size(b);
dimc= size(c);

    if ~(dimA(1)==dimb(1) && dimA(2) == dimc(2))
        disp(['La matriz no tiene el formato adecuado, cambie la matriz '])
        error('Dimensiones invalidas')
    end

end

%Fase 1: encontrar solucion basica factible -------------

%format,,verbose
function [A,B]= fase1(A,b,c,verbose)

    if verbose == true
        disp(['Inicio metodo simplex']) 
        disp(['------Fase 1 -------'])
        disp('Añadimos variables arificiales')
    end

% Agregar n variables artificiales  
[m,n]=size(A)
I=eye(m);
A=[A I]

dimA= size(A);
dimb= size(b);
dimc= size(c);

% Definir variables basicas y no basicas
r=rank(A);
cas=ones(1,m);
cros=zeros(1,n);
ca=[cros cas]% Nuevo c para fase 1


IB=[dimA(2)-m+1:dimA(2)] 
IN=[1:dimA(2)-m]

%comienzan las iteraciones 

    if verbose == true
        disp(['Indices variables basicas:']) 
        disp(IB)
        disp(['Indices variables no basicas:'])
        disp(IN)
    end
    
B=[];
N=[];
cB=[];
cN=[];
    
B=[];
    for i= IB    
        B=[B A(:,i)];
    end
    
N=[];
    for i= IN    
        N=[N A(:,i)];
    end
    
cB=[];
    for i= IB    
        cB=[cB c(i)];
    end
    
cN=[];
    for i= IN    
        cN=[cN c(i)];
    end
    
XB(B,b) 
cr(cN,cB,B,N)


end
% Hallar XB

function[XB]= XB(B,b)%solucion basica
    XB=inv(B)*b'
    for i=IB
     X(IB(find(IB==i)))= XB(find(IB==i)) 
    end
    if verbose==true
        disp('Solucion basica : ') 
        disp(XB)
        disp('Vector solucion (X): ')
        disp(X)
    end
    
end

% Hallar costos reducidos (encontrar candidata a entrar a la base)
 function[cr]=cr(cN,cB,B,N)
  cr=cN-cB*inv(B)*N;  
    if verbose==true
        disp('Costos reducidos : ') 
        disp(cr)
    end
   
       if min(cr)<0
           xc=min(cr)
           %
           if verbose==true
                disp('No es optima : ') 
                disp(xc,'es candidata a entrar a la base : ')
            end
       else  
            if verbose==true
                disp('No es optima : ') 
                disp(xc,'es candidata a entrar a la base : ')
            end 
       end

   end
       
 end 
% Criterio de la razon minima (candidato a salir de la base)
function[]=yk(B)
end
% Hasta costos reducidos >= 0 ------------------------------

% Fase 2 (Segun restricciones al terminar fase )

% Eliminar variables artificiales 

% Metodo simplex

% Dar solucion optimo finito, ´optimo no finito, multiples soluciones y 
%solucion no factible. 
