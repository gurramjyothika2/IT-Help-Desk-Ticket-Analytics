import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.compose import ColumnTransformer
from sklearn.preprocessing import OneHotEncoder, StandardScaler
from sklearn.pipeline import Pipeline
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report, confusion_matrix, accuracy_score, roc_auc_score
import joblib

DATA = "data/helpdesk_tickets.csv"
MODEL_OUT = "sla_prediction_model.joblib"

df = pd.read_csv(DATA)

features = [
    "Department", "Category", "Priority", "Assigned_Agent",
    "First_Response_Hours", "Resolution_Time_Hours"
]
target = "SLA_Breached"

X = df[features]
y = df[target]

categorical = ["Department", "Category", "Priority", "Assigned_Agent"]
numeric = ["First_Response_Hours", "Resolution_Time_Hours"]

preprocessor = ColumnTransformer([
    ("cat", OneHotEncoder(handle_unknown="ignore"), categorical),
    ("num", StandardScaler(), numeric)
])

model = Pipeline([
    ("preprocessor", preprocessor),
    ("classifier", LogisticRegression(max_iter=1000, class_weight="balanced"))
])

X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.20, random_state=42, stratify=y
)

model.fit(X_train, y_train)

pred = model.predict(X_test)
prob = model.predict_proba(X_test)[:, 1]

print("Accuracy:", round(accuracy_score(y_test, pred), 4))
print("ROC-AUC:", round(roc_auc_score(y_test, prob), 4))
print("\nClassification Report:\n", classification_report(y_test, pred))
print("\nConfusion Matrix:\n", confusion_matrix(y_test, pred))

joblib.dump(model, MODEL_OUT)
print(f"\nSaved model to {MODEL_OUT}")