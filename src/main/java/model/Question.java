package model;

public class Question {
	private int questionId;
	private int surveyId;
	private String questionCategory;
	private String questionTest;
	public int getQuestionId() {
		return questionId;
	}
	public void setQuestionId(int questionId) {
		this.questionId = questionId;
	}
	public int getSurveyId() {
		return surveyId;
	}
	public void setSurveyId(int surveyId) {
		this.surveyId = surveyId;
	}
	public String getQuestionCategory() {
		return questionCategory;
	}
	public void setQuestionCategory(String questionCategory) {
		this.questionCategory = questionCategory;
	}
	public String getQuestionTest() {
		return questionTest;
	}
	public void setQuestionTest(String questionTest) {
		this.questionTest = questionTest;
	}

	
}
