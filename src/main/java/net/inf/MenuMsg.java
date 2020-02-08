package net.inf;

import java.util.ArrayList;
import java.util.Map;

public class MenuMsg
{
	private Map<String, ArrayList<Menuinf>> menuMap;
	private  Map<String, ArrayList<Menuinf>>undistributedMenu;

	public Map<String, ArrayList<Menuinf>> getMenuMap()
	{
		return menuMap;
	}

	public void setMenuMap(Map<String, ArrayList<Menuinf>> menuMap)
	{
		this.menuMap = menuMap;
	}

	public Map<String, ArrayList<Menuinf>> getUndistributedMenu()
	{
		return undistributedMenu;
	}

	public void setUndistributedMenu(Map<String, ArrayList<Menuinf>> undistributedMenu)
	{
		this.undistributedMenu = undistributedMenu;
	}
}
