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

package com.liferay.portal.tools.java.parser;

import java.util.List;

/**
 * @author Hugo Huijser
 */
public class JavaAnnotation extends JavaExpression {

	public JavaAnnotation(String name) {
		_name = new JavaSimpleValue(name);
	}

	public void setAnnotationMemberValuePairs(
		List<JavaAnnotationMemberValuePair> annotationMemberValuePairs) {

		_annotationMemberValuePairs = annotationMemberValuePairs;
	}

	public void setValue(JavaExpression value) {
		_value = value;
	}

	private List<JavaAnnotationMemberValuePair> _annotationMemberValuePairs;
	private final JavaSimpleValue _name;
	private JavaExpression _value;

}