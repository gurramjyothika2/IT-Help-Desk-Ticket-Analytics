import pandas as pd
import joblib

model = joblib.load("sla_prediction_model.joblib")

ticket = pd.DataFrame([{
    "Department": input("Department: "),
    "Category": input("Category: "),
    "Priority": input("Priority: "),
    "Assigned_Agent": input("Assigned Agent: "),
    "First_Response_Hours": float(input("First Response Hours: ")),
    "Resolution_Time_Hours": float(input("Resolution Time Hours: "))
}])

prediction = model.predict(ticket)[0]
probability = model.predict_proba(ticket)[0, 1]

print("\nPrediction:", "SLA BREACH RISK" if prediction == 1 else "LIKELY TO MEET SLA")
print("Breach probability:", f"{probability:.2%}")