package net.dao;

import net.inf.Userinf;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

@Mapper
public class UserDao
{

	/**
	 * 带条件分页搜索用户信息
	 * @param nowpage 当前页数
	 * @param num  每页显示的记录条数
	 * @param conditions  搜索条件
	 * @return
	 */
	public List<Userinf> showUser(int nowpage, int num, Map<String,String[]> conditions, String startdate, String enddate) {
		int start=(nowpage-1)*num; //计算开始条数
		//int end=start-1+num; //计算结束条数
		//StringBuilder sql=new StringBuilder("SELECT * FROM usertable  WHERE 1=1 ");
		SqlSession session = MyBatisUtil.getSession();
		RowBounds rb=new RowBounds(start,5);
		List<Object> findAll=new ArrayList<>();
		if (startdate!=null&&enddate!=null)
		{
			if (!startdate.equals("") && !enddate.equals(""))
			{
				Map map=new HashMap();
				map.put("start",startdate);
				map.put("end",enddate);
				findAll =session.selectList("findUserbydate", map, rb);
				//sql.append("AND regtime BETWEEN '" + startdate + "' AND '" + enddate + "'");
			} else if (!startdate.equals("") && enddate.equals(""))
			{
				findAll =session.selectList("findUserbyonedate", startdate, rb);
				//sql.append("AND regtime ='" + startdate + "'");
			} else if (startdate.equals("") && !enddate.equals(""))
			{
				findAll =session.selectList("findUserbyonedate", enddate, rb);
				//sql.append("AND regtime ='" + enddate + "'");
			}
		}else {
			findAll =session.selectList("findAll", null, rb);
		}
		List<Userinf> userinfs=new ArrayList<>();
		for (int i = 0; i <findAll.size() ; i++)
		{
			Userinf u=(Userinf) findAll.get(i);
			userinfs.add(u);
		}

		return userinfs;
	}

	/**
	 * 带条件搜索结果总记录数统计
	 * @param conditions
	 * @return
	 */
	public int count(Map<String,String[]> conditions,String startdate,String enddate ) {
		StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM userinf where 1=1 ");
		if (startdate!=null&&enddate!=null)
		{
			if (!startdate.equals("") && !enddate.equals(""))
			{
				sql.append( "AND regtime BETWEEN '" + startdate + "' AND '" + enddate + "'");
			} else if (!startdate.equals("") && enddate.equals(""))
			{
				sql.append("AND regtime ='" + startdate + "'");
			} else if (startdate.equals("") && !enddate.equals(""))
			{
				sql.append("AND regtime ='" + enddate + "'");
			}
		}
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		Connection conn = DaoUtil.getDaoUtil().getConn();
		try {
			sql=conditionAppend(sql,conditions);
			pstmt = conn.prepareStatement(sql.toString());
			set = pstmt.executeQuery();
			while (set.next()) {
				count = set.getInt("count(*)");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DaoUtil.getDaoUtil().close(pstmt, set);
		}
		return count;
	}

	/**
	 * 条件封装
	 * @param sql
	 * @param conditions
	 * @return
	 */
	public StringBuilder conditionAppend(StringBuilder sql,Map<String,String[]> conditions){
		if (conditions!=null){
			Set<String> keyset = conditions.keySet();
			for (String key : keyset)
			{
				if (key.equals("page")||key.equals("limit")||key.equals("methodName")||key.equals("dateStart")||key.equals("dateEnd")){ //跳过提交的页数参数
					continue;
				}
				String value = conditions.get(key)[0];
				if ((value != null && !"".equals(value)))
				{
					if (!value.equals("--"))
					{
						sql.append(" and " + key + " like '" + "%" + value + "%" + "'"); //条件语句拼接
					}
				}
			}
		}

		return sql;
	}
	public boolean userUpdate(String sql){
		boolean flag=false;

		QueryRunner queryRunner=new QueryRunner();
		Connection conn = DaoUtil.getDaoUtil().getConn();
		try
		{
			int i=queryRunner.update(conn,sql);
			System.out.println(i);
			if (i==1){
				flag=true;
			}
		} catch (SQLException e)
		{
			e.printStackTrace();
		}
		return flag;

	}


}
