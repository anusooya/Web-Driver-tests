package com.leaftaps.testcases;

import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;

import com.framework.testng.api.base.ProjectHooks;
import com.leaftaps.pages.LoginPage;

public class TC001_JustLogin extends ProjectHooks{
	@BeforeTest
	public void setValues() {
		testcaseName = "Login";

		testDescription ="Login to TestLeaf Platform";
		authors="Babu Sir";
		testDescription ="Login to Leaftaps";
		authors="Sairam Pasunuri";
		category ="Activity 2";
		authors="Babu";
		// authors="Jerald";
		category ="Smoke";
		excelFileName="Login";
	}
	
	@Test(dataProvider = "fetchData")
	public void runLogin(String username, String password) {
		new LoginPage()
		.enterUsername(username)
		.enterPassword(password)
		.clickLogin();

	}

}
