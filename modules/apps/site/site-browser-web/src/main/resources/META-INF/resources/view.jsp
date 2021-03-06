<%--
/**
 * Copyright (c) 2000-present Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>

<%@ include file="/init.jsp" %>

<%
String p_u_i_d = ParamUtil.getString(request, "p_u_i_d");
String displayStyle = siteBrowserDisplayContext.getDisplayStyle();
String eventName = ParamUtil.getString(request, "eventName", liferayPortletResponse.getNamespace() + "selectSite");
String target = ParamUtil.getString(request, "target");

User selUser = PortalUtil.getSelectedUser(request);

GroupSearch groupSearch = siteBrowserDisplayContext.getGroupSearch();
%>

<clay:navigation-bar
	navigationItems="<%= siteBrowserDisplayContext.getNavigationItems() %>"
/>

<clay:management-toolbar
	clearResultsURL="<%= siteBrowserDisplayContext.getClearResultsURL() %>"
	componentId="siteBrowserWebManagementToolbar"
	filterDropdownItems="<%= siteBrowserDisplayContext.getFilterDropdownItems() %>"
	itemsTotal="<%= siteBrowserDisplayContext.getTotalItems() %>"
	searchActionURL="<%= siteBrowserDisplayContext.getSearchActionURL() %>"
	searchFormName="searchFm"
	selectable="<%= false %>"
	showSearch='<%= !Objects.equals(siteBrowserDisplayContext.getType(), "parent-sites") %>'
	sortingOrder="<%= siteBrowserDisplayContext.getOrderByType() %>"
	sortingURL="<%= siteBrowserDisplayContext.getSortingURL() %>"
	viewTypeItems="<%= siteBrowserDisplayContext.getViewTypeItems() %>"
/>

<aui:form action="<%= siteBrowserDisplayContext.getPortletURL() %>" cssClass="container-fluid-1280" method="post" name="selectGroupFm">
	<liferay-ui:search-container
		searchContainer="<%= groupSearch %>"
	>
		<liferay-ui:search-container-row
			className="com.liferay.portal.kernel.model.Group"
			escapedModel="<%= true %>"
			keyProperty="groupId"
			modelVar="group"
			rowIdProperty="friendlyURL"
			rowVar="row"
		>

			<%
			Map<String, Object> data = new HashMap<String, Object>();

			data.put("entityid", group.getGroupId());
			data.put("entityname", group.getDescriptiveName(locale));
			data.put("grouptarget", target);
			data.put("grouptype", LanguageUtil.get(request, group.getTypeLabel()));
			data.put("url", group.getDisplayURL(themeDisplay));
			%>

			<c:choose>
				<c:when test='<%= displayStyle.equals("descriptive") %>'>
					<liferay-ui:search-container-column-icon
						icon="sites"
					/>

					<liferay-ui:search-container-column-text
						colspan="<%= 2 %>"
					>
						<h5>
							<c:choose>
								<c:when test="<%= Validator.isNull(p_u_i_d) || SiteMembershipPolicyUtil.isMembershipAllowed((selUser != null) ? selUser.getUserId() : 0, group.getGroupId()) %>">
									<aui:a cssClass="selector-button" data="<%= data %>" href="javascript:;">
										<%= HtmlUtil.escape(group.getDescriptiveName(locale)) %>
									</aui:a>
								</c:when>
								<c:otherwise>
									<%= HtmlUtil.escape(group.getDescriptiveName(locale)) %>
								</c:otherwise>
							</c:choose>
						</h5>

						<h6 class="text-default">
							<span><%= LanguageUtil.get(request, group.getScopeLabel(themeDisplay)) %></span>
						</h6>
					</liferay-ui:search-container-column-text>
				</c:when>
				<c:when test='<%= displayStyle.equals("icon") %>'>

					<%
					row.setCssClass("entry-card lfr-asset-item " + row.getCssClass());
					%>

					<liferay-ui:search-container-column-text>
						<c:choose>
							<c:when test="<%= Validator.isNull(p_u_i_d) || SiteMembershipPolicyUtil.isMembershipAllowed((selUser != null) ? selUser.getUserId() : 0, group.getGroupId()) %>">

								<%
								Map<String, Object> urlData = data;
								%>

								<%@ include file="/site_vertical_card.jspf" %>
							</c:when>
							<c:otherwise>

								<%
								Map<String, Object> urlData = null;
								%>

								<%@ include file="/site_vertical_card.jspf" %>
							</c:otherwise>
						</c:choose>
					</liferay-ui:search-container-column-text>
				</c:when>
				<c:when test='<%= displayStyle.equals("list") %>'>
					<liferay-ui:search-container-column-text
						name="name"
						truncate="<%= true %>"
					>
						<c:choose>
							<c:when test="<%= Validator.isNull(p_u_i_d) || SiteMembershipPolicyUtil.isMembershipAllowed((selUser != null) ? selUser.getUserId() : 0, group.getGroupId()) %>">
								<aui:a cssClass="selector-button" data="<%= data %>" href="javascript:;">
									<%= HtmlUtil.escape(group.getDescriptiveName(locale)) %>
								</aui:a>
							</c:when>
							<c:otherwise>
								<%= HtmlUtil.escape(group.getDescriptiveName(locale)) %>
							</c:otherwise>
						</c:choose>
					</liferay-ui:search-container-column-text>

					<liferay-ui:search-container-column-text
						name="type"
						value="<%= LanguageUtil.get(request, group.getScopeLabel(themeDisplay)) %>"
					/>
				</c:when>
			</c:choose>
		</liferay-ui:search-container-row>

		<liferay-ui:search-iterator
			displayStyle="<%= displayStyle %>"
			markupView="lexicon"
		/>
	</liferay-ui:search-container>
</aui:form>

<aui:script use="aui-base">
	var Util = Liferay.Util;

	var openingLiferay = Util.getOpener().Liferay;

	openingLiferay.fire(
		'<portlet:namespace />enableRemovedSites',
		{
			selectors: A.all('.selector-button:disabled')
		}
	);

	Util.selectEntityHandler('#<portlet:namespace />selectGroupFm', '<%= HtmlUtil.escapeJS(eventName) %>', <%= selUser != null %>);
</aui:script>