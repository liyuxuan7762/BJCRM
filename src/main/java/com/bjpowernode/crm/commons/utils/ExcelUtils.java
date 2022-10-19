package com.bjpowernode.crm.commons.utils;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import java.lang.reflect.Field;
import java.util.List;

public class ExcelUtils {
    public static String getCellValueForString(HSSFCell cell) {
        String result = "";
        switch (cell.getCellType()) {
            case HSSFCell.CELL_TYPE_STRING:
                result = cell.getStringCellValue();
                break;
            case HSSFCell.CELL_TYPE_NUMERIC:
                result = Double.toString(cell.getNumericCellValue());
                break;
            case HSSFCell.CELL_TYPE_BOOLEAN:
                result = cell.getBooleanCellValue() + "";
                break;
            case HSSFCell.CELL_TYPE_FORMULA:
                result = cell.getCellFormula();
                break;
            default:
                result = "";
        }
        return result;
    }

    public static HSSFWorkbook exportExcel(List list, String sheetName) throws NoSuchFieldException, IllegalAccessException {
        // 1.创建Excel文件
        // 2.创建工作簿
        HSSFWorkbook wb = new HSSFWorkbook();
        // 3.创建工作表
        HSSFSheet sheet = wb.createSheet(sheetName);
        // 4.创建行
        HSSFRow row = sheet.createRow(0);
        // 5.通过反射拿到表头
        Field[] declaredFields = list.get(0).getClass().getDeclaredFields();
        for (int i = 0; i < declaredFields.length; i++) {
            Field field = declaredFields[i];
            field.setAccessible(true);
            row.createCell(i).setCellValue(field.getName());
        }
        if (list != null && list.size() > 0) {
            Object obj = null;
            HSSFRow r = null;
            for (int i = 0; i < list.size(); i++) {
                obj = list.get(i);
                r = sheet.createRow(i + 1);
                for (int j = 0; j < declaredFields.length; j++) {
                    Field myField = obj.getClass().getDeclaredField(declaredFields[j].getName());
                    myField.setAccessible(true);
                    if (myField.get(obj) == null) {
                        r.createCell(j).setCellValue("");
                    } else {
                        String value = myField.get(obj).toString();
                        r.createCell(j).setCellValue(value);
                    }
                }
            }
        }
        return wb;
    }

    public static HSSFWorkbook exportExcel(List list) throws NoSuchFieldException, IllegalAccessException {
        return exportExcel(list, "sheet1");
    }
}
