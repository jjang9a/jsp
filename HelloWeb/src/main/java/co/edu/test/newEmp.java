package co.edu.test;

import java.sql.Date;

public class newEmp {
	
	int id;
	String first;
	String last;
	String hire;
	String job;
	String email;
	String eId;
	
	public String geteId() {
		return eId;
	}

	public void seteId(String eId) {
		this.eId = eId;
	}

	public newEmp() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFirst() {
		return first;
	}

	public void setFirst(String first) {
		this.first = first;
	}

	public String getLast() {
		return last;
	}

	public void setLast(String last) {
		this.last = last;
	}

	public String getHire() {
		return hire;
	}

	public void setHire(String string) {
		this.hire = string;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "newEmp [id=" + id + ", first=" + first + ", last=" + last + ", hire=" + hire + ", job=" + job
				+ ", email=" + email + ", eId=" + eId + "]";
	}
	
	
}
