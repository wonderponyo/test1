package net.dao;

import com.mchange.v2.c3p0.ComboPooledDataSource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;


public class DaoUtil
{

	private static net.dao.DaoUtil DaoUtil;
	private Connection conn;
	private Properties properties;
	private ComboPooledDataSource comboPooledDataSource;
	public static net.dao.DaoUtil getDaoUtil() {

		if (DaoUtil == null) {
			DaoUtil = new DaoUtil();
		}
		return DaoUtil;
	}
	public ComboPooledDataSource getDataSource()
	{
		return comboPooledDataSource;
	}

	public Connection getConn(){
		try
		{
			if (conn==null){
				conn=comboPooledDataSource.getConnection();

			}
		} catch (SQLException e)
		{
			e.printStackTrace();
		}
		return conn;
	}

	private DaoUtil()
	{
		comboPooledDataSource = new ComboPooledDataSource("mysql");
	}


	public void close(PreparedStatement pstmt, ResultSet set) {
		try {
			if (set != null) {
				set.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
