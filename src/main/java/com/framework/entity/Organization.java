package com.framework.entity;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.Range;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(value = { "hibernateLazyInitializer", "handler" })
@Entity
@Table(name = "sys_organization")
@Cache(usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE, region = "com.framework.entity.Organization")
public class Organization implements Comparable<Organization> {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	@NotBlank
	@Length(max = 64)
	@Column(length = 64, nullable = false, unique = true)
	private String name;

	/**
	 * 越小优先级越高
	 */
	@NotNull
	@Range(min = 1, max = 999)
	@Column(length = 3, nullable = false)
	private Integer priority;

	@Length(max = 256)
	@Column(length = 256)
	private String description;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "parentId")
	private Organization parent;

	@JsonIgnore
	@OneToMany(mappedBy = "parent", cascade = { CascadeType.PERSIST,
			CascadeType.REMOVE })
	@OrderBy("priority ASC")
	private List<Organization> children = new ArrayList<Organization>();

	@OneToMany(mappedBy = "organization", cascade = { CascadeType.PERSIST,
			CascadeType.REMOVE }, orphanRemoval = true)
	private Set<User> users = new HashSet<User>();

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	/**
	 * 返回 name 的值
	 * 
	 * @return name
	 */
	public String getName() {
		return name;
	}

	/**
	 * 设置 name 的值
	 * 
	 * @param name
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the priority
	 */
	public Integer getPriority() {
		return priority;
	}

	/**
	 * @param priority
	 *            the priority to set
	 */
	public void setPriority(Integer priority) {
		this.priority = priority;
	}

	/**
	 * 返回 description 的值
	 * 
	 * @return description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * 设置 description 的值
	 * 
	 * @param description
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	/**
	 * 返回 parent 的值
	 * 
	 * @return parent
	 */
	public Organization getParent() {
		return parent;
	}

	/**
	 * 设置 parent 的值
	 * 
	 * @param parent
	 */
	public void setParent(Organization parent) {
		this.parent = parent;
	}

	/**
	 * 返回 children 的值
	 * 
	 * @return children
	 */
	public List<Organization> getChildren() {
		return children;
	}

	/**
	 * 设置 children 的值
	 * 
	 * @param children
	 */
	public void setChildren(List<Organization> children) {
		this.children = children;
	}

	/**
	 * 返回 users 的值
	 * 
	 * @return users
	 */
	public Set<User> getUsers() {
		return users;
	}

	/**
	 * 设置 users 的值
	 * 
	 * @param users
	 */
	public void setUsers(Set<User> users) {
		this.users = users;
	}

	@Override
	public int compareTo(Organization org) {
		if (org == null) {
			return -1;
		} else if (org == this) {
			return 0;
		} else if (this.priority < org.getPriority()) {
			return -1;
		} else if (this.priority > org.getPriority()) {
			return 1;
		}

		return 0;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
