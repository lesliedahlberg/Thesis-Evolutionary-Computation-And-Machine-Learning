function PlotSurfaceD(f, IPR, IPR2, OVR, prec)
%PLOTSURFACE Display graph of any function f(x,y)
%IPR is parameter range
%OVR is output value range
%prec is precision in graph
    step = (abs(IPR(1)) + abs(IPR(2)))/prec;
    step2 = (abs(IPR2(1)) + abs(IPR2(2)))/prec;
    [X,Y] = meshgrid(IPR(1):step:IPR(2),IPR2(1):step2:IPR2(2));
    
    n = size(X);
    
    for i = 1:n(1)
        for j = 1:n(2)
            z = [X(i,j),Y(i,j)];
            Z(i,j) = f(z);
        end
    end
    
    figure;
    mesh(X,Y,Z);
    
    axis([IPR(1) IPR(2) IPR2(1) IPR2(2) OVR(1) OVR(2)]);
   
end

