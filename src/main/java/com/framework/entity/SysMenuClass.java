package com.framework.entity;
// Generated 2017-5-27 22:17:08 by Hibernate Tools 4.3.1.Final

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.CascadeType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * SysMenuClass generated by hbm2java
 */
@JsonIgnoreProperties(value = { "hibernateLazyInitializer", "handler" })
@Entity
@Table(name = "sys_menu_class", catalog = "uc")
@Cache(usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE, region = "com.framework.entity.SysMenuClass")
public class SysMenuClass implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8443136569999125517L;
	private Integer id;
	private SysMenu sysMenu;
	private String name;
	private String className;
	private String method;
	private Set<SysRolePermission> sysRolePermissions = new HashSet<SysRolePermission>(0);

	public SysMenuClass() {
	}

	public SysMenuClass(SysMenu sysMenu) {
		this.sysMenu = sysMenu;
	}

	public SysMenuClass(SysMenu sysMenu, String name, String className, String method,
			Set<SysRolePermission> sysRolePermissions) {
		this.sysMenu = sysMenu;
		this.name = name;
		this.className = className;
		this.method = method;
		this.sysRolePermissions = sysRolePermissions;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)

	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "menu_id", nullable = false)
	public SysMenu getSysMenu() {
		return this.sysMenu;
	}

	public void setSysMenu(SysMenu sysMenu) {
		this.sysMenu = sysMenu;
	}

	@Column(name = "name", length = 100)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "class_name", length = 100)
	public String getClassName() {
		return this.className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	@Column(name = "method", length = 50)
	public String getMethod() {
		return this.method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	@JsonIgnore
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "sysMenuClass", cascade = { CascadeType.ALL })
	public Set<SysRolePermission> getSysRolePermissions() {
		return this.sysRolePermissions;
	}

	public void setSysRolePermissions(Set<SysRolePermission> sysRolePermissions) {
		this.sysRolePermissions = sysRolePermissions;
	}

}
