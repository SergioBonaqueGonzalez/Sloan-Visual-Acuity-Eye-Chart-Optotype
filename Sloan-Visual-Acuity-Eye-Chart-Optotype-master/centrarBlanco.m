
function [imCentrada] = centrarBlanco(im, cent_size)

maxVal = max(im(:));

% Valores de ancho y alto de la imagen
[i,j,k] = size(im);
% Offset total de la imagen respecto al "marco"
offset_i = fix((cent_size(1) - i)/2);
offset_j = fix((cent_size(2) - j)/2);
% Marco inicializado 
if k == 3
    cent_size(3) = 3;
    imCentrada = maxVal*ones(cent_size);
else
    imCentrada = maxVal*ones(cent_size);
end
% Indices de la matriz
ind_i = 1:i;
ind_j = 1:j;
% Imagen centrada 
imCentrada(ind_i + offset_i, ind_j + offset_j,:) = im(ind_i, ind_j,:);

end

