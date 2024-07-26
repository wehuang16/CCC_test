within CCC_test.Examples;
model testIntegral
  Buildings.Controls.OBC.CDL.Reals.IntegratorWithReset intWitRes
    annotation (Placement(transformation(extent={{-42,8},{-22,28}})));
  Buildings.Controls.OBC.CDL.Discrete.Sampler sam
    annotation (Placement(transformation(extent={{-84,-4},{-64,16}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testIntegral;
