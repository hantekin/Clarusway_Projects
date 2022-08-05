import streamlit as st
import pickle
import pandas as pd
import base64
from sklearn.preprocessing import MinMaxScaler




# st.title('Employee Churn Analysis')
st.markdown(
			"<h2 style='font-size:200%;\
						font-family:cursive;\
						text-align:center;\
						background-color:;\
						color:purple;'>EMPLOYEE CHURN ANALYSIS\
			</h2>", unsafe_allow_html=True
			)

st.markdown(
			"<h2 style='font-size:200%;\
						font-family:cursive;\
						text-align:center;\
						background-color:;\
						color:purple;'>Streamlit Churn Prediction ML App\
			</h2>", unsafe_allow_html=True
			)

# html_temp = """
# <div style="background-color:blue;padding:10px">
# <h2 style="color:white;text-align:center;">Employee Churn Analysis </h2>
# </div>"""
# st.markdown(html_temp,unsafe_allow_html=True)




# st.markdown("""
# 			<div style="background-color:blue;\
# 						border-radius: 10px;\
# 						padding:15px">
# 			<h3 style="color:white;\
# 					   text-align:center;\
# 					   font-family:cursive;">Streamlit Churn Prediction ML App\
# 			</h3>
# 			</div>
# 			""", unsafe_allow_html=True
# 			)

st.write('\n')

st.write('\n')

st.markdown("""
			<center>
			<p style='font-size:200%;\
						font-family:cursive;\
						background-color:purple;\
						border-radius: 10px;\
						color:white;'>Select Your ML Model\
			</p>
			</center>
			""", unsafe_allow_html=True
			)

st.markdown("""
			<style>
    		[data-baseweb="select"] {
        							margin-top: -50px;
    								}
    		</style>
    		""", unsafe_allow_html=True,
			)

selection = st.selectbox("",["Gradient Boost", "CatBoost", "Random Forest", "KNN"])

if selection =="Gradient Boost":
	st.markdown("<p style='text-align:center; color:black; font-size:110%; background-color:#F2F3F4 ;'>\
				You selected \
				<span style='color:red;font-weight:bold'>\
				'Gradient Boost'\
				</span> model!\
				</p>", unsafe_allow_html=True
				)
	model = pickle.load(open('gradient_boosting_model.pkl', 'rb'))
elif selection =="Random Forest":
	st.markdown("<p style='text-align:center; color:black; font-size:110%; background-color:#F2F3F4 ;'>\
				You selected \
				<span style='color:red;font-weight:bold'>\
				'Random Forest'\
				</span> model!\
				</p>", unsafe_allow_html=True
				)
	model = pickle.load(open('random_forest_model.pkl', 'rb'))
elif selection =="CatBoost":
	st.markdown("<p style='text-align:center; color:black; font-size:110%; background-color:#F2F3F4 ;'>\
				You selected \
				<span style='color:red;font-weight:bold'>\
				'CatBoost'\
				</span> model!\
				</p>", unsafe_allow_html=True
				)
	model = pickle.load(open('catboost_model.pkl', 'rb'))
else:
	st.markdown("<p style='text-align:center; color:black; font-size:110%; background-color:#F2F3F4 ;'>\
				You selected \
				<span style='color:red;font-weight:bold'>\
				'KNN'\
				</span> model!\
				</p>", unsafe_allow_html=True
				)
	model = pickle.load(open('kneighbors_model.pkl', 'rb'))


st.sidebar.markdown(
			"<h1 style='text-align:center;\
						color: purple;font-family:cursive;font-size:115%;'>Will Your Employee Quit\
			</h1>", unsafe_allow_html=True
			)


st.sidebar.write('\n')

st.sidebar.markdown("""
			<p style='text-align:center;\
						border-radius: 10px;\
						color: white; background-color:purple;'>Please Slide\
			</p>
			""", unsafe_allow_html=True
			)

satisfaction_level = st.sidebar.slider(label = "Satisfaction Level", min_value=0.0, max_value=1.0, step=0.01)
last_evaluation = st.sidebar.slider(label="Last Evaluation", min_value=0.0, max_value=1.0, step=0.01)
time_spend_company = st.sidebar.slider("Time Spend in Company", min_value=0, max_value=30, step=1)

st.sidebar.write('\n')

st.sidebar.markdown("""
			<p style='text-align:center;\
						border-radius: 10px;\
						color: white; background-color:purple;'>Please Choose\
			</p>
			""", unsafe_allow_html=True
			)

work_accident = st.sidebar.radio("Work Accident", (1, 0))
promotion_last_5years = st.sidebar.radio("Promotion in Last 5 Years", (1, 0))

st.sidebar.write('\n')

st.sidebar.markdown("""
			<p style='text-align:center;\
						border-radius: 10px;\
						color: white; background-color:purple;'>Please Use "+" and "-" Buttons\
			</p>
			""", unsafe_allow_html=True
			)

number_project = st.sidebar.number_input(label="Number of Projects", min_value=1, max_value=200)
average_monthly_hours = st.sidebar.number_input("Average Monthly Hours", min_value=10, max_value=2000)

st.sidebar.write('\n')

st.sidebar.markdown("""
			<p style='text-align:center;\
						border-radius: 10px;\
						color: white; background-color:purple;'>Please Select From List\
			</p>
			""", unsafe_allow_html=True
			)


st.sidebar.markdown("""<p style='text-align:left;color:black;font-size:90%;'>Departments</p>""", unsafe_allow_html=True)
st.sidebar.write('\n')
department = st.sidebar.selectbox("Department", ['RandD', 'accounting', 'hr', 'management', 'marketing', 'product_mng',  'sales', 'support', 'technical', 'IT'])

st.sidebar.markdown("""<p style='text-align:left;color:black;font-size:90%;'>Salary</p>""", unsafe_allow_html=True)
st.sidebar.write('\n')
salary = st.sidebar.selectbox("Salary", ['low', 'medium', 'high'])


coll_dict = {'satisfaction_level':satisfaction_level, 'last_evaluation':last_evaluation, 'number_project':number_project, 'average_montly_hours':average_monthly_hours,\
			'time_spend_company':time_spend_company, 'work_accident':work_accident, 'promotion_last_5years':promotion_last_5years,\
			'departments': department, 'salary':salary}
columns = ['satisfaction_level', 'last_evaluation', 'number_project', 'average_montly_hours', 'time_spend_company',\
            'work_accident', 'promotion_last_5years', 'departments_RandD', 'departments_accounting', 'departments_hr',\
            'departments_management', 'departments_marketing', 'departments_product_mng', 'departments_sales',\
            'departments_support', 'departments_technical', 'salary_low', 'salary_medium']

df_coll = pd.DataFrame.from_dict([coll_dict])
user_inputs = pd.get_dummies(df_coll,drop_first=True).reindex(columns=columns, fill_value=0)


scalerfile = 'scaler.pkl'
scaler = pickle.load(open(scalerfile, 'rb'))

scaler.clip = False
user_inputs_transformed = scaler.transform(user_inputs)

prediction = model.predict(user_inputs_transformed)

st.markdown("""
			<center>
			<h1 style='font-size:200%;\
						background-color:purple;\
						border-radius: 10px;\
						color:white;'>Employee Information\
			</h1>
			</center>
			""", unsafe_allow_html=True
			)

st.write('\n')

st.dataframe(df_coll)

st.markdown("""
			<center>
			<p style='font-size:150%;\
						font-family:cursive;\
						background-color:purple;\
						border-radius: 10px;\
						color:white;'>PREDICTION\
			</p>
			</center>
			""", unsafe_allow_html=True
			)


col1, col2, = st.columns([1, 1.5])
if col2.button("PREDICT"):
	if prediction[0]==0:
		st.success(prediction[0])
		st.success(f'Employee will STAY')
	elif prediction[0]==1:
		st.warning(prediction[0])
		st.warning(f'Employee will QUIT')
