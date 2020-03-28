%Genera el fractal de Mandelbrot en tonos de grises usando el algoritmo de 
%tiempo de escape.
%El algoritmo itera hasta que el numero de pixeles dentro del conjunto de
%Mandelbrot deja de cambiar o hasta que se alcanze el número máximo de 
%iteraciones permitidas.
%Algoritmo descrito en detalle en: https://www.aglarick.com/?p=869

lado=720; 
tamano=[lado, lado];
zn=zeros(tamano);
mandelbrot=zeros(tamano);

%Se puebla la matriz 'c' con las coordenadas del plano complejo de -2 a 2 y de 
%-2i a 2i alrededor del origen.
paso=4/lado;
[X,Y]=meshgrid(1:lado,1:lado);
c=((X-lado/2)+(lado/2-Y)*i)*paso;

pixelesAntes=0;   %Cantidad de pixeles dentro del Mandelbrot antes de comenzar.
dentro=find(c+1);   %1.- Lista todos los pixeles dentro del conjunto de Mandelbrot.
pixelesDespues=length(dentro); %Cantidad de pixeles dentro del Mandelbrot después de la iteración.
iteracion=0;
while( pixelesAntes!=pixelesDespues )
  iteracion=iteracion+1;
  pixelesAntes=pixelesDespues;   %Cantidad de pixeles que pertenecían al Mandelbrot al final de la iteración anterior.
  zn(dentro)=zn(dentro).^2+c(dentro);   %2.- Iteramos Zn+1 = Zn^2 + c sobre los valores que sobrevivieron la iteración anterior.
  dentro=find(zn<2);   %3.- Encontramos los pixeles que sobreviven la presente iteración.
  pixelesDespues=length(dentro);   %Cantidad de pixeles que sobreviven la presente iteración.
  mandelbrot(dentro)=iteracion;    %Asignamos el número de la iteración como color de los pixeles que sobrevivieron.
endwhile
mandelbrot=mandelbrot/iteracion;  %Renormaliza la imagen a una escala [0,1].

figure(1)
imshow(mandelbrot);   %Despliega el fractal en blanco y negro.

printf("Se alcanzo convergencia en la iteracion: %d.\n", iteracion);