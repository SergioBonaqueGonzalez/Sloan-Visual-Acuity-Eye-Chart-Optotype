function letter=generateLetter(pixels)

number=randi([1 11],1,1);
nombre=[num2str(number) 's.mat'];
loading=load(nombre);
letter=loading.letter;
if pixels<12
    letter=imresize(letter,[pixels pixels],'nearest');
else
    letter=imresize(letter,[pixels pixels],'nearest');
end








