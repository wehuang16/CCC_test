within CCC_test.ESTCP;
model MainBlock
  parameter Integer numSubBlo(min=2)=4
    "Number of sub-blocks";

  SubBlock subBlo[numSubBlo]
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput u1 annotation (Placement(
        transformation(extent={{-140,40},{-100,80}}), iconTransformation(extent
          ={{-140,40},{-100,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput u2 annotation (Placement(
        transformation(extent={{-140,-80},{-100,-40}}), iconTransformation(
          extent={{-140,-80},{-100,-40}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput y1 annotation (Placement(
        transformation(extent={{100,40},{140,80}}), iconTransformation(extent={{
            100,40},{140,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput y2 annotation (Placement(
        transformation(extent={{100,-80},{140,-40}}), iconTransformation(extent={{100,-80},
            {140,-40}})));
equation
  for i in 1:numSubBlo-1 loop
    subBlo[i + 1].u1 = subBlo[i].y1;
    subBlo[i + 1].u2 = subBlo[i].y2;
  end for;
  u1=subBlo[1].u1;
  u2=subBlo[1].u2;
  y1=subBlo[numSubBlo].y1;
  y2=subBlo[numSubBlo].y2;


  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end MainBlock;
