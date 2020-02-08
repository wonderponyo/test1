package net.inf;


import org.springframework.stereotype.Component;

import java.util.List;
@Component
public class Userinf
{

  private String username;
  private String password;
  private long id;
  private String regtime;
  private long score;
  private long uploadsum;
  private long downloadsum;
  private String userstate;
  private String sex;
  private String education;
  private String profession;
  private String phone;
  private String mail;
  private List<Deptinf> deptinfs;

  public Userinf()
  {
    System.out.println("userinf实例化");
  }

  public List<Deptinf> getDeptinfs()
  {
    return deptinfs;
  }

  public void setDeptinfs(List<Deptinf> deptinfs)
  {
    this.deptinfs = deptinfs;
  }

  public String getSex()
  {
    return sex;
  }

  public void setSex(String sex)
  {
    this.sex = sex;
  }

  public String getEducation()
  {
    return education;
  }

  public void setEducation(String education)
  {
    this.education = education;
  }

  public String getProfession()
  {
    return profession;
  }

  public void setProfession(String profession)
  {
    this.profession = profession;
  }

  public String getPhone()
  {
    return phone;
  }

  public void setPhone(String phone)
  {
    this.phone = phone;
  }

  public String getMail()
  {
    return mail;
  }

  public void setMail(String mail)
  {
    this.mail = mail;
  }

  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }


  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }


  public long getId() {
    return id;
  }

  public void setId(long id) {
    this.id = id;
  }


  public String getRegtime() {
    return regtime;
  }

  public void setRegtime(String regtime) {
    this.regtime = regtime;
  }


  public long getScore() {
    return score;
  }

  public void setScore(long score) {
    this.score = score;
  }


  public long getUploadsum() {
    return uploadsum;
  }

  public void setUploadsum(long uploadsum) {
    this.uploadsum = uploadsum;
  }


  public long getDownloadsum() {
    return downloadsum;
  }

  public void setDownloadsum(long downloadsum) {
    this.downloadsum = downloadsum;
  }


  public String getUserstate() {
    return userstate;
  }

  public void setUserstate(String userstate) {
    this.userstate = userstate;
  }

}
