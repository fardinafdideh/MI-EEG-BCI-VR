if cue_type(counter)==1
    setfield(LeftRightCylinder,'translation',[-(cylinder_increase+length(find((1==C(k:end)) ))/stretch) 0 0]);%Set structure field contents.
    setfield(LeftRightCylinder,'scale',[.2 (cylinder_increase+length(find((1==C(k:end))))/stretch) 0.3]);%Set structure field contents.
    handles.C11=handles.C11+length(find(1==C(k:end)));cylinder_increase=cylinder_increase+length(find((1==C(k:end)) ))/stretch; 
    handles.C12=handles.C12+length(find(2==C(k:end)));
    handles.C13=handles.C13+length(find(3==C(k:end)));
elseif cue_type(counter)==2
    setfield(LeftRightCylinder,'translation',[cylinder_increase+length(find((2==C(k:end)) ))/stretch 0 0]);%Set structure field contents.
    setfield(LeftRightCylinder,'scale',[.2 cylinder_increase+length(find((2==C(k:end)) ))/stretch 0.3]);%Set structure field contents.
    handles.C22=handles.C22+length(find(2==C(k:end)));cylinder_increase=cylinder_increase+length(find((2==C(k:end)) ))/stretch; 
    handles.C21=handles.C21+length(find(1==C(k:end)));
    handles.C23=handles.C23+length(find(3==C(k:end)));
elseif cue_type(counter)==3 
    setfield(UpDownCylinder,'translation',[0 -(cylinder_increase+length(find((3==C(k:end)) ))/stretch)  0]);%Set structure field contents.
    setfield(UpDownCylinder,'scale',[.2 cylinder_increase+length(find((3==C(k:end)) ))/stretch 0.3]);%Set structure field contents.
    handles.C33=handles.C33+length(find(3==C(k:end)));cylinder_increase=cylinder_increase+length(find((3==C(k:end)) ))/stretch;%  | (2==C(k:end)) | (1==C(k:end)) 
    handles.C31=handles.C31+length(find(1==C(k:end)));
    handles.C32=handles.C32+length(find(2==C(k:end)));
end
vrdrawnow
k=length(C)+1;
