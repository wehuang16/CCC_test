within CCC_test.Examples;
model testSatReset
  Controller_G36_SAT_only conAHU(
    TSupSetMax=291.45,
    TSupSetUnocc=291.45,
    TSupSetMin=284.85,
    TSupSetDes=285.95,
    TOutMin=291.45,
    TOutMax=294.25,
    iniSetSupTem=291.45,
    maxSetSupTem=291.45,
    minSetSupTem=285.95,
    delTimSupTem=300,
    numIgnReqSupTem=0,
    triAmoSupTem=0.0833,
    resAmoSupTem=-0.1667,
    maxResSupTem=-0.6667)
    annotation (Placement(transformation(extent={{-16,-66},{64,70}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testSatReset;
