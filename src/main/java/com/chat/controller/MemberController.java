package com.chat.controller;

import com.chat.config.SHA256;
import com.chat.model.Member;
import com.chat.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.security.NoSuchAlgorithmException;
import java.util.List;

@Controller
public class MemberController {
  @Autowired
  MemberService memberService;

  @GetMapping("/")
  public String login(@CookieValue(required = false) String id, Model model) {
    if (id != null) model.addAttribute("id", id);
    return "member/login";
  }

  @GetMapping("/member/logout")
  public String logoutMembers(HttpSession session) {
    session.invalidate();
    return "redirect:/";
  }

  @GetMapping("/member/join")
  public String join() {
    return "member/join";
  }

  @GetMapping("/member/findId")
  public String findIdView() {
    return "member/findId";
  }

  @GetMapping("/member/findPwd")
  public String findPwd() {
    return "member/findPwd";
  }

  @RequestMapping(value = "/member/searchResult", method = { RequestMethod.POST })
  public String searchResult(Model model, String keyword) {
    List<Member> result = memberService.searchId(keyword);

    if (keyword == "" || result.size() == 0) {
      model.addAttribute("none", "검색결과가 존재하지 않습니다.");}
    else {    model.addAttribute("result", result);}

    return "member/searchResult";
  }

  @GetMapping("/member/myPage")
  public String myPage(HttpSession session, Model model) {
    model.addAttribute("member", memberService.myPage((String) session.getAttribute("id")));
    return "member/myPage";
  }

  @PostMapping("/join")
  @ResponseBody
    public int join(Member member) throws NoSuchAlgorithmException {
    return memberService.joinMember(member);
  }

  @PostMapping("/idCheck")
  @ResponseBody
  public int idCheck(String id) {
    return memberService.idCheck(id);
  }

  @PostMapping("/")
  public String loginMembers(String id, String pwd, HttpSession session, String rememberId, HttpServletResponse response, Model model) throws NoSuchAlgorithmException  {
    SHA256 sha256 = new SHA256();

    if (sha256.encrypt(pwd).equals(memberService.login(id))) {
      session.setAttribute("id", id);

      if (rememberId != null) {
        Cookie cookie = new Cookie("id", id);
        cookie.setMaxAge(10*60);
        response.addCookie(cookie);
        model.addAttribute("cookieId", id);
      }
      return "redirect:chat/list";

    } else {
      model.addAttribute("msg", "아이디와 비밀번호를 확인하세요.");
      return "member/login";
    }
  }

  @ResponseBody
  @RequestMapping(value = "/member/findId", method = { RequestMethod.POST })
  public String findId(String email) {
    return memberService.findId(email) == null? ( "해당 이메일의 아이디가 존재하지 않습니다." ) :  ( "아이디는 " + memberService.findId(email) + "입니다." );
  }

  @ResponseBody
  @RequestMapping(value = "/member/findPwd", method = { RequestMethod.POST })
  public int findPwd(String id, String email) {
    return memberService.findPwd(id, email);
  }

  @PostMapping("/updatePwd")
  @ResponseBody
  public void updatePwd(Member member) throws NoSuchAlgorithmException {
    SHA256 sha256 = new SHA256();
    member.setPwd(sha256.encrypt(member.getPwd()));
    memberService.updatePwd(member);
  }
}
