function [pX, pY] = getPointAtBorder(x1,y1,x2,y2,borderX,borderY)
    % y = mx+b is used to get the line 
    m = (y1-y2)/(x1-x2);
    b = y1-m*x1;
    
    tempX = (borderY-b)/m;
    tempY = m*borderX+b;
    if(abs(tempX-x1) < abs(borderX-x1))
        pX = floor(tempX);
        pY = floor(borderY);
    else
        pX = floor(borderX);
        pY = floor(tempY);
    end
end

