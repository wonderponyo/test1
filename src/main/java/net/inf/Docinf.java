package net.inf;

import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import javax.annotation.Resources;

@Component
public class Docinf {
  @Resource
	private Userinf userinf;
  private String docname;
  private String docintro;
  private String downscore;
  private long id;
  private String username;
  private String time;
  private String doctype;
  private long downsum;
  private String docstate;
  private String doctitle;

  public Docinf()
  {
    System.out.println("docinf被实例化");
  }

	public Userinf getUserinf()
	{
		return userinf;
	}



	public Docinf(String doctitle, String docname,Userinf userinf){
		System.out.println("docinf有参构造");
  	this.doctitle=doctitle;
  	this.docname=docname;
  	this.userinf=userinf;
  }
  public String getDoctitle()
  {
    return doctitle;
  }

  public void setDoctitle(String doctitle)
  {
    this.doctitle = doctitle;
  }

  public String getDocname() {
    return docname;
  }

  public void setDocname(String docname) {
    this.docname = docname;
  }


  public String getDocintro() {
    return docintro;
  }

  public void setDocintro(String docintro) {
    this.docintro = docintro;
  }


  public String getDownscore()
  {
    return downscore;
  }

  public void setDownscore(String downscore)
  {
    this.downscore = downscore;
  }

  public long getId() {
    return id;
  }

  public void setId(long id) {
    this.id = id;
  }


  public String getUsername() {
    return username;
  }

  public void setUsername(String username) {
    this.username = username;
  }


  public String getTime() {
    return time;
  }

  public void setTime(String time) {
    this.time = time;
  }


  public String getDoctype() {
    return doctype;
  }

  public void setDoctype(String doctype) {
    this.doctype = doctype;
  }


  public long getDownsum() {
    return downsum;
  }

  public void setDownsum(long downsum) {
    this.downsum = downsum;
  }


  public String getDocstate() {
    return docstate;
  }

  public void setDocstate(String docstate) {
    this.docstate = docstate;
  }

	@Override
	public String toString()
	{
		return "Docinf{" + "docname='" + docname + '\'' + ", docintro='" + docintro + '\'' + ", downscore='" + downscore + '\'' + ", id=" + id + ", username='" + username + '\'' + ", time='" + time + '\'' + ", doctype='" + doctype + '\'' + ", downsum=" + downsum + ", docstate='" + docstate + '\'' + ", doctitle='" + doctitle + '\'' + '}';
	}
}
