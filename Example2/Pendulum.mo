within CCC_test.Example2;
model Pendulum "A simple pendulum model"
  // Parameters
  parameter Real L = 1 "Length of the pendulum";
  parameter Real m = 1 "Mass of the pendulum";
  parameter Real g = 9.81 "Gravity";

  // Variables
  Real theta(start = 0.5) "Angle of the pendulum";
  Real omega(start = 0) "Angular velocity of the pendulum";

  // Equations
  Modelica.Blocks.Sources.RealExpression realExpression(y=theta)
    annotation (Placement(transformation(extent={{-104,4},{-84,24}})));
equation
  der(theta) = omega;
  der(omega) = -g/L * sin(theta);

  // Animation
  annotation (
    experiment(StartTime = 0, StopTime = 10),
    __Dymola_Commands(file = "Pendulum.mos" "Pendulum"),
    __Dymola_experimentSetupOutput,
    Documentation(info = "<html>
      <p>
        A simple pendulum model.
      </p>
    </html>"));
end Pendulum;
