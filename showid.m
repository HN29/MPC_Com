function viet_ten = showid(xxd,pos)
viet_ten = zeros(1, size(xxd,1));
for a=1:size(xxd,1)
    id=num2str(a);
    if pos==1
        viet_ten(a) = text(xxd(a,1),xxd(a,2),id,'VerticalAlignment','bottom','HorizontalAlignment','right');
    else
        viet_ten(a) = text(xxd(a,1),xxd(a,2),id,'VerticalAlignment','top','HorizontalAlignment','left','color','m');
    end
end