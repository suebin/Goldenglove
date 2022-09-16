package com.example.golden_glove;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Test {
	@RequestMapping("/header")
	public String header() {
		return "components/header";
	}
}
