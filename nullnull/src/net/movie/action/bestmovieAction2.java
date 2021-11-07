package net.movie.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;



public class bestmovieAction2 implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	     
		 
	     final String WEB_DRIVER_ID = "webdriver.chrome.driver";
	     final String WEB_DRIVER_PATH = "C:\\Users\\82109\\Desktop\\eclipse(21.5.10~)\\nullnull\\chromedriver_92/chromedriver.exe"; //웤스페이스
	     //final String WEB_DRIVER_PATH = "C:\\Users\\win10\\Desktop\\selenium-java-3.141.59\\chromedriver_92/chromedriver.exe";
	    
	     //크롤링 할 URL
	     String base_url="http://www.cgv.co.kr/movies";
	     WebElement webElement;
	     WebDriver driver;
	     //System Property SetUp 드라이버설정
	     System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);
	                   
	        //Driver SetUp
	         ChromeOptions options = new ChromeOptions();
	         options.setCapability("ignoreProtectedModeSettings", true);
	         options.addArguments("headless"); //이부분이 있어야 get()할때 창을 안띄움
	         driver = new ChromeDriver(options);
	         
	         int state =1;
	         state=Integer.parseInt(request.getParameter("state"));
	         JsonArray jarray = new JsonArray();
		     if(state == 1) { //기본순  	  
	        try {
	            //get page (= 브라우저에서 url을 주소창에 넣은 후 request 한 것과 같다)
	            driver.get(base_url);
	        //    webElement = driver.findElement(By.xpath("//*[@id=\"contents\"]/div[1]/div[1]/div/ul/li[3]/a"));
	    	//	webElement.click();
	          //브라우저 이동시 생기는 로드시간을 기다린다.
	    	 //HTTP응답속도보다 자바의 컴파일 속도가 더 빠르기 때문에 임의적으로 1초를 대기한다.
	    		try {Thread.sleep(1000);} catch (InterruptedException e) {}
	    		
	    		 for(int i =0; i< 3; i++) {
	    		     JsonObject object =new JsonObject();
	    			object.addProperty("rank", (driver.findElements(By.className("rank")).get(i).getText())); //넘버
	    			object.addProperty("name", (driver.findElements(By.className("title")).get(i).getText())); //제목
	    			object.addProperty("ticket", (driver.findElements(By.className("percent")).get((i*2)).getText()));//예매율
	    			object.addProperty("good", (driver.findElements(By.className("percent")).get((i*2)+1).getText()));//평점
	    			object.addProperty("src", (driver.findElement(By.xpath("//*[@id=\"contents\"]/div[1]/div[3]/ol[1]/li["+(i+1)+"]/div[1]/a/span/img")).getAttribute("src")));
	    			jarray.add(object);
	    		 }
	    		 for(int i =0; i< 4; i++) {
	    		     JsonObject object =new JsonObject();
	    			object.addProperty("rank", (driver.findElements(By.className("rank")).get(i+3).getText())); //넘버
	    			object.addProperty("name", (driver.findElements(By.className("title")).get(i+3).getText())); //제목
	    			object.addProperty("ticket", (driver.findElements(By.className("percent")).get((i+3)*2).getText()));//예매율
	    			object.addProperty("good", (driver.findElements(By.className("percent")).get((i+3)*2+1).getText()));//평점
	    			object.addProperty("src", (driver.findElement(By.xpath("//*[@id=\"contents\"]/div[1]/div[3]/ol[2]/li["+(i+1)+"]/div[1]/a/span/img")).getAttribute("src")));
	    			jarray.add(object);
	     		 }
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            driver.close();
	        }//try end
	        
	        }else{//satate==1 end
	        	
	        try {
	            //get page (= 브라우저에서 url을 주소창에 넣은 후 request 한 것과 같다)
	            driver.get(base_url);
	            webElement = driver.findElement(By.xpath("//*[@id=\"contents\"]/div[1]/div[1]/div/ul/li[3]/a"));
	    		webElement.click();
	          //브라우저 이동시 생기는 로드시간을 기다린다.
	    	 //HTTP응답속도보다 자바의 컴파일 속도가 더 빠르기 때문에 임의적으로 1초를 대기한다.
	    		try {Thread.sleep(1000);} catch (InterruptedException e) {}
	    		
	    		 for(int i =0; i< 3; i++) {
	    		     JsonObject object =new JsonObject();
	    			object.addProperty("rank", (driver.findElements(By.className("rank")).get(i).getText())); //넘버
	    			object.addProperty("name", (driver.findElements(By.className("title")).get(i).getText())); //제목
	    			object.addProperty("ticket", (driver.findElements(By.className("percent")).get((i*2)).getText()));//예매율
	    			object.addProperty("good", (driver.findElements(By.className("percent")).get((i*2)+1).getText()));//평점
	    			object.addProperty("src", (driver.findElement(By.xpath("//*[@id=\"contents\"]/div[1]/div[3]/ol[1]/li["+(i+1)+"]/div[1]/a/span/img")).getAttribute("src")));
	    			jarray.add(object);
	    		 }
	    		 for(int i =0; i< 4; i++) {
	    		     JsonObject object =new JsonObject();
	    			object.addProperty("rank", (driver.findElements(By.className("rank")).get(i+3).getText())); //넘버
	    			object.addProperty("name", (driver.findElements(By.className("title")).get(i+3).getText())); //제목
	    			object.addProperty("ticket", (driver.findElements(By.className("percent")).get((i+3)*2).getText()));//예매율
	    			object.addProperty("good", (driver.findElements(By.className("percent")).get((i+3)*2+1).getText()));//평점
	    			object.addProperty("src", (driver.findElement(By.xpath("//*[@id=\"contents\"]/div[1]/div[3]/ol[2]/li["+(i+1)+"]/div[1]/a/span/img")).getAttribute("src")));
	    			jarray.add(object);
	     		 }
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            driver.close();
	        }
	        
	}//else end  
		     JsonArray ajaxarray = jarray;
		     JsonObject object =new JsonObject();
				JsonElement je = new Gson().toJsonTree(ajaxarray);
				object.add("movielist", je); //나올부분
				
				response.setContentType("text/html;charset=utf-8");
				PrintWriter out = response.getWriter();
				
				out.print(object.toString());
				System.out.println(object.toString());
				//response.getWriter().append(object.toString())
				return null;
	}
}
