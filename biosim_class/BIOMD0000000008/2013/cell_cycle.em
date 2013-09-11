Stepper ODEStepper(ODE) {}

System System(/) {
    StepperID ODE;
}

System System(/CELL) {
    StepperID ODE;

    Variable Variable(cyclin)    { Value 0.0; }
    Variable Variable(protease)  { Value 0.0; }
    Variable Variable(cdc2k)     { Value 0.0; }
    Variable Variable(inhibitor) { Value 1.0; }
    Variable Variable(complex)   { Value 1.0; }

    Process ExpressionFluxProcess(cyclin_creation) {
        VariableReferenceList [C :.:cyclin 1];
        vi 0.1;
        Expression "vi";
    }

    Process ExpressionFluxProcess(cdc2_triggered_cyclin_degradation) {
        VariableReferenceList [C :.:cyclin -1] [X :.:protease 0];
        k1 0.5;
        k5 0.02;
        Expression "C.Value * k1 * X.Value / (C.Value + k5)";
    }

    Process ExpressionFluxProcess(cyclin_degradation) {
        VariableReferenceList [C :.:cyclin -1];
        kd 0.02;
        Expression "C.Value * kd";
    }

    Process ExpressionFluxProcess(cdc2k_activation) {
        VariableReferenceList [C :.:cyclin 0] [M :.:cdc2k 1];
        k1 0.1;
        v1p 0.75;
        k6 0.3;
        Expression "C.Value * v1p / (C.Value + k6) * (1 - M.Value) / (k1 - M.Value + 1)";
    }

    Process ExpressionFluxProcess(cdc2k_deactivation) {
        VariableReferenceList [M :.:cdc2k -1];
        v2 0.25;
        k2 0.1;
        Expression "M.Value * v2 / (k2 + M.Value)";
    }

    Process ExpressionFluxProcess(protease_activation) {
        VariableReferenceList [M :.:cdc2k 0] [X :.:protease 1];
        k3 0.2;
        v3p 0.3;
        Expression "M.Value * v3p * (1 - X.Value) / (k3 + (-1) * X.Value + 1)";
    }

    Process ExpressionFluxProcess(protease_deactivation) {
        VariableReferenceList [X :.:protease -1];
        k4 0.1;
        v4 0.1;
        Expression "v4 * X.Value / (k4 + X.Value)";
    }

    Process ExpressionFluxProcess(cyclin_inhibitor_complexation) {
        VariableReferenceList [C :.:cyclin -1] [Y :.:inhibitor -1] [Z :.:complex 1];
        a1 0.05;
        Expression "a1 * C.Value * Y.Value";
    }

    Process ExpressionFluxProcess(cyclin_inhibitor_decomplexation) {
        VariableReferenceList [C :.:cyclin 1] [Y :.:inhibitor 1] [Z :.:complex -1];
        a2 0.05;
        Expression "a2 * Z.Value";
    }

    Process ExpressionFluxProcess(cyclin_desinhibition) {
        VariableReferenceList [C :.:cyclin 1] [Z :.:complex -1];
        alpha 0.1;
        d1 0.05;
        Expression "alpha * d1 * Z.Value";
    }

    Process ExpressionFluxProcess(inhibited_cyclin_degradation) {
        VariableReferenceList [Y :.:inhibitor 1] [Z :.:complex -1];
        kd 0.02;
        alpha 0.1;
        Expression "alpha * kd * Z.Value";
    }

    Process ExpressionFluxProcess(inhibitor_creation) {
        VariableReferenceList [Y :.:inhibitor 1];
        vs 0.2;
        Expression "vs";
    }

    Process ExpressionFluxProcess(inhibitor_degra) {
        VariableReferenceList [Y :.:inhibitor -1];
        d1 0.05;
        Expression "d1 * Y.Value";
    }
}
