/*!
 * Datepicker for Bootstrap
 *
 * Copyright 2012 Stefan Petre
 * Improvements by Andrew Rowls
 * Licensed under the Apache License v2.0
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 */

.datepicker {
	padding: 4px;
	.border-radius(4px);
	&-inline {
		width: 220px;
	}
	direction: ltr;
	&&-rtl {
		direction: rtl;
		table tr td span {
			float: right;
		}
	}
	&-dropdown {
		top: 0;
		left: 0;
		&:before {
			content: '';
			display: inline-block;
			border-left:   7px solid transparent;
			border-right:  7px solid transparent;
			border-bottom: 7px solid #ccc;
			border-top:    0;
			border-bottom-color: rgba(0,0,0,.2);
			position: absolute;
		}
		&:after {
			content: '';
			display: inline-block;
			border-left:   6px solid transparent;
			border-right:  6px solid transparent;
			border-bottom: 6px solid @white;
			border-top:    0;
			position: absolute;
		}
		&.datepicker-orient-left:before   { left: 6px; }
		&.datepicker-orient-left:after    { left: 7px; }
		&.datepicker-orient-right:before  { right: 6px; }
		&.datepicker-orient-right:after   { right: 7px; }
		&.datepicker-orient-top:before    { top: -7px; }
		&.datepicker-orient-top:after     { top: -6px; }
		&.datepicker-orient-bottom:before {
			bottom: -7px;
			border-bottom: 0;
			border-top:    7px solid #999;
		}
		&.datepicker-orient-bottom:after {
			bottom: -6px;
			border-bottom: 0;
			border-top:    6px solid @white;
		}
	}
	>div {
		display: none;
	}
	&.days div.datepicker-days {
		display: block;
	}
	&.months div.datepicker-months {
		display: block;
	}
	&.years div.datepicker-years {
		display: block;
	}
	table{
		margin: 0;
		-webkit-touch-callout: none;
		-webkit-user-select: none;
		-khtml-user-select: none;
		-moz-user-select: none;
		-ms-user-select: none;
		user-select: none;
	}
	td,
	th{
		text-align: center;
		width: 20px;
		height: 20px;
		.border-radius(4px);

		border: none;
	}
	// Inline display inside a table presents some problems with
	// border and background colors.
	.table-striped & table tr {
		td, th {
			background-color:transparent;
		}
	}
	table tr td {
		&.day:hover, &.day.focused {
			background: @grayLighter;
			cursor: pointer;
		}
		&.old,
		&.new {
			color: @grayLight;
		}
		&.disabled,
		&.disabled:hover {
			background: none;
			color: @grayLight;
			cursor: default;
		}
		&.today,
		&.today:hover,
		&.today.disabled,
		&.today.disabled:hover {
			@todayBackground: lighten(@orange, 30%);
			.buttonBackground(@todayBackground, spin(@todayBackground, 20));
			color: #000;
		}
		&.today:hover:hover { // Thank bootstrap 2.0 for this selector...
			// TODO: Bump min BS to 2.1, use @textColor in buttonBackground above
			color: #000;
		}
		&.today.active:hover {
			color: #fff;
		}
		&.range,
		&.range:hover,
		&.range.disabled,
		&.range.disabled:hover {
			background:@grayLighter;
			.border-radius(0);
		}
		&.range.today,
		&.range.today:hover,
		&.range.today.disabled,
		&.range.today.disabled:hover {
			@todayBackground: mix(@orange, @grayLighter, 50%);
			.buttonBackground(@todayBackground, spin(@todayBackground, 20));
			.border-radius(0);
		}
		&.selected,
		&.selected:hover,
		&.selected.disabled,
		&.selected.disabled:hover {
			.buttonBackground(lighten(@grayLight, 10), darken(@grayLight, 10));
			color: #fff;
			text-shadow: 0 -1px 0 rgba(0,0,0,.25);
		}
		&.active,
		&.active:hover,
		&.active.disabled,
		&.active.disabled:hover {
			.buttonBackground(@btnPrimaryBackground, spin(@btnPrimaryBackground, 20));
			color: #fff;
			text-shadow: 0 -1px 0 rgba(0,0,0,.25);
		}
		span {
			display: block;
			width: 23%;
			height: 54px;
			line-height: 54px;
			float: left;
			margin: 1%;
			cursor: pointer;
			.border-radius(4px);
			&:hover {
				background: @grayLighter;
			}
			&.disabled,
			&.disabled:hover {
				background:none;
				color: @grayLight;
				cursor: default;
			}
			&.active,
			&.active:hover,
			&.active.disabled,
			&.active.disabled:hover {
				.buttonBackground(@btnPrimaryBackground, spin(@btnPrimaryBackground, 20));
				color: #fff;
				text-shadow: 0 -1px 0 rgba(0,0,0,.25);
			}
			&.old,
			&.new {
				color: @grayLight;
			}
		}
	}

	th.datepicker-switch {
		width: 145px;
	}

	thead tr:first-child th,
	tfoot tr th {
		cursor: pointer;
		&:hover{
			background: @grayLighter;
		}
	}
	/*.dow {
		border-top: 1px solid #ddd !important;
	}*/

	// Basic styling for calendar-week cells
	.cw {
		font-size: 10px;
		width: 12px;
		padding: 0 2px 0 5px;
		vertical-align: middle;
	}
	thead tr:first-child th.cw {
		cursor: default;
		background-color: transparent;
	}
}
.input-append,
.input-prepend {
	&.date {
		.add-on i {
			cursor: pointer;
			width: 16px;
			height: 16px;
		}
	}
}
.input-daterange {
	input {
		text-align:center;
	}
	input:first-child {
		.border-radius(3px 0 0 3px);
	}
	input:last-child {
		.border-radius(0 3px 3px 0);
	}
	.add-on {
		display: inline-block;
		width: auto;
		min-width: 16px;
		height: @baseLineHeight;
		padding: 4px 5px;
		font-weight: normal;
		line-height: @baseLineHeight;
		text-align: center;
		text-shadow: 0 1px 0 @white;
		vertical-align: middle;
		background-color: @grayLighter;
		border: 1px solid #ccc;
		margin-left:-5px;
		margin-right:-5px;
	}
}
