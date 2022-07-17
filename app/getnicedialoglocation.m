function figure_size = getnicedialoglocation(figure_size, figure_units)
%GETNICEDIALOGLOCATION0 Version of GETNICEDIALOGLOCATION for private reuse.
%  See also GETNICEDIALOGLOCATION.

%  Copyright 1984-2005 The MathWorks, Inc.
%  $Revision: 1.1.6.1 $

parentHandle = gcbf;
propName = 'Position';
if isempty(parentHandle)
    parentHandle = 0;
    propName = 'ScreenSize';
end

old_u = get(parentHandle,'Units');
set(parentHandle,'Units',figure_units);
container_size=get(parentHandle,propName);
set(parentHandle,'Units',old_u);

figure_size(1) = container_size(1)  + 1/2*(container_size(3) - figure_size(3));
figure_size(2) = container_size(2)  + 2/3*(container_size(4) - figure_size(4));