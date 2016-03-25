package com.guanglan.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.guanglan.domain.SearchResult;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/search")
public class SearchController {
	
	private static String keyValue = null;
	private static String chineseKey = null;
	private static int searchType = 1;
	
	@RequestMapping("/search_index")
	public String searchIndex(){
		return "search_index";
	}
	
	@RequestMapping(value="/search_key")//,method=RequestMethod.POST
	public ModelAndView searchKey(HttpServletRequest request,@RequestParam(value="start",defaultValue="0") int start) throws IOException{
		//String key = request.getParameter("key");
		
		if(request.getParameter("key") != null){
			String key=URLEncoder.encode(request.getParameter("key"), "utf-8");
			chineseKey = request.getParameter("key");
			keyValue = key;
			searchType = Integer.valueOf(request.getParameter("searchType"));
		}
		Map<String,Object> map = getSearchResult(keyValue, start,chineseKey,searchType);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("search_result");
		mv.addObject("searchResultList", map.get("searchResultList"));
		mv.addObject("searchTime", map.get("searchTime"));
		mv.addObject("resultCount", map.get("resultCount"));
		return mv;
	}
	
	public Map<String,Object> getSearchResult(String key,int start,String hightValue,int searchType) throws IOException{
		String str = null;
		if(searchType == 1){
			str = "https://www.googleapis.com/customsearch/v1element?"
					+ "key=AIzaSyCVAXiUzRYsML1Pv6RwSG1gunmMikTzQqY&rsz=filtered_cse&num=10"
					+ "&hl=zh_CN&prettyPrint=false&source=gcsc&gss=.com"
					+ "&sig=432dd570d1a386253361f581254f9ca1&start="+start+""
					+ "&cx=009710993526451159051:8ug4rm8321a&q="+key+""
					+ "&sort=&googlehost=www.google.com";
			
		}else if(searchType == 2){
			 str = "https://www.googleapis.com/customsearch/"
					+ "v1element?key=AIzaSyCVAXiUzRYsML1Pv6RwSG1gunmMikTzQqY&rsz=filtered_cse&num=10&"
					+ "hl=en&prettyPrint=false&source=gcsc&gss=.com&"
					+ "sig=432dd570d1a386253361f581254f9ca1&start="+start+"&"
					+ "cx=009710993526451159051:8msjtmiabv8&q="+key+""
					+ "&sort=&googlehost=www.google.com";
		}else{
			str = "https://www.googleapis.com/customsearch/"
					+ "v1element?key=AIzaSyCVAXiUzRYsML1Pv6RwSG1gunmMikTzQqY"
					+ "&rsz=filtered_cse&num=10&hl=en&prettyPrint=false&source=gcsc&gss"
					+ "=.com&sig=432dd570d1a386253361f581254f9ca1&start="+start+"&"
					+ "cx=009710993526451159051:ynq_fmd1sey&q="+key+""
					+ "&sort=&googlehost=www.google.com";
		}
		
		
		URL url = new URL(str);
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
	    connection.setRequestProperty("User-Agent","Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.154 Safari/537.36 LBBROWSER");
		InputStreamReader isr = new InputStreamReader(connection.getInputStream(),"UTF-8");
		BufferedReader br = new BufferedReader(isr);
		String line = null;
		StringBuffer sb = new StringBuffer();
		while((line=br.readLine()) != null){
			sb.append(line);
		}
		br.close();
		JSONObject jsonObject = JSONObject.fromObject(sb.toString());
		JSONObject jsonObject1  =  jsonObject.getJSONObject("cursor");
		String searchTime = jsonObject1.get("searchResultTime").toString();
		String resultCount = jsonObject1.get("resultCount").toString();
		JSONArray jsonArrayResults = jsonObject.getJSONArray("results");
		List<SearchResult> searchResultList = new ArrayList<SearchResult>();
		for(int i =0 ; i < jsonArrayResults.size(); i++){
			JSONObject j = (JSONObject) jsonArrayResults.get(i);
			SearchResult sr = new SearchResult();
			sr.setTitle(j.get("title").toString().replaceAll(hightValue, "<font color='red'>"+hightValue+"</font>"));
			sr.setContent(j.get("content").toString().replaceAll(hightValue, "<font color='red'>"+hightValue+"</font>"));
			sr.setUrl(j.get("unescapedUrl").toString());
			searchResultList.add(sr);
		}
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("searchResultList", searchResultList);
		map.put("searchTime", searchTime);
		map.put("resultCount", resultCount);
		return map;
	}
	
}
