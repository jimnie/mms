package com.rcbank.mms.util;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import java.io.File;
import java.io.FileOutputStream;

//import com.itextpdf.text.pdf.BaseFont;
//import com.itextpdf.text.Font;

public class PdfUtils {
    Document document1 = new Document();// 建立一个Document对象

    private static Font headfont;// 设置字体大小
    private static Font keyfont;// 设置字体大小
    private static Font textfont;// 设置字体大小
    private static Font font;// 设置字体大小

    static {
        BaseFont bfChinese;
        try {
//                     bfChinese = BaseFont.createFont("STSong-Light","UniGB-UCS2-H",BaseFont
// .NOT_EMBEDDED);
            bfChinese = BaseFont.createFont("C:\\Windows\\Fonts\\STSONG.TTF", BaseFont
                    .IDENTITY_H, BaseFont.NOT_EMBEDDED);
            headfont = new Font(bfChinese, 28, Font.BOLD);// 设置字体大小
            keyfont = new Font(bfChinese, 16, Font.BOLD);// 设置字体大小
            textfont = new Font(bfChinese, 16, Font.NORMAL);// 设置字体大小
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public PdfUtils(File file) {
        document1.setPageSize(PageSize.A4);// 设置页面大小
        try {
            PdfWriter.getInstance(document1, new FileOutputStream(file));

            document1.open();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    int maxWidth = 520;

    public PdfPCell createCell(String value, Font font, int align) {
        PdfPCell cell = new PdfPCell();
        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        cell.setHorizontalAlignment(align);
        cell.setPhrase(new Phrase(value, font));
        return cell;
    }

    public PdfPCell createCell(String value, Font font) {
        PdfPCell cell = new PdfPCell();
        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setPhrase(new Phrase(value, font));
        return cell;
    }

    public PdfPCell createCell(String value, Font font, int align, int colspan) {
        PdfPCell cell = new PdfPCell();
        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        cell.setHorizontalAlignment(align);
        cell.setColspan(colspan);
        cell.setPhrase(new Phrase(value, font));
        return cell;
    }

    public PdfPCell createCell(String value, Font font, int align, int colspan, boolean boderFlag) {
        PdfPCell cell = new PdfPCell();
        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        cell.setHorizontalAlignment(align);
        cell.setColspan(colspan);
        cell.setPhrase(new Phrase(value, font));
        cell.setPadding(3.0f);
        if (!boderFlag) {
            cell.setBorder(0);
            cell.setPaddingTop(15.0f);
            cell.setPaddingBottom(8.0f);
        }
        return cell;
    }

    public PdfPTable createTable(int colNumber) {
        PdfPTable table = new PdfPTable(colNumber);
        try {
            table.setTotalWidth(maxWidth);
            table.setLockedWidth(true);
            table.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.getDefaultCell().setBorder(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return table;
    }

    public PdfPTable createTable(float[] widths) {
        PdfPTable table = new PdfPTable(widths);
        try {
            table.setTotalWidth(maxWidth);
            table.setLockedWidth(true);
            table.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.getDefaultCell().setBorder(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return table;
    }

    public PdfPTable createBlankTable() {
        PdfPTable table = new PdfPTable(1);
        table.getDefaultCell().setBorder(0);
        table.addCell(createCell("", keyfont));
        table.setSpacingAfter(20.0f);
        table.setSpacingBefore(20.0f);
        return table;
    }

    /*public boolean generatePDF(Handover handover) {
        PdfPTable table = createTable(4);
        table.setTotalWidth(480);
        table.setLockedWidth(true);
        BaseFont bfChinese = null;
        BaseFont bfChinese1 = null;

        //bfChinese1 = BaseFont.createFont("STSong-Light","UniGB-UCS2-H",BaseFont.NOT_EMBEDDED);
//              keyfont = new Font(bfChinese1, 16, Font.BOLD);// 设置字体大小
//               bfChinese = BaseFont.createFont("C:\\Windows\\Fonts\\STSONG.TTF",BaseFont
// .IDENTITY_H,BaseFont.NOT_EMBEDDED) ;
        try {
            bfChinese = BaseFont.createFont("C:/windows/fonts/simsun.ttc,1", BaseFont.IDENTITY_H,
                    BaseFont.NOT_EMBEDDED);
            font = new Font(bfChinese, 16, Font.NORMAL);
            keyfont = new Font(bfChinese, 20, Font.NORMAL);
            headfont = new Font(bfChinese, 25, Font.NORMAL);
        } catch (Exception e) {
            e.printStackTrace();
        }


        PdfPCell cell = new PdfPCell();
        cell.setColspan(4);
        cell.setBorderWidth(0);
        cell = createCell("离职员工账务结算清单", headfont, Element.ALIGN_CENTER, 4);
        cell.setFixedHeight(60);
        cell.setBorder(0);
        //  Image img = Image.getInstance("webapps\\mms\\resources\\images\\cashwayLogo.PNG");
//               img.setBorderWidth(0);
//               table.addCell(img);
        table.addCell(cell);
        table.addCell(createCell("姓名", font, Element.ALIGN_CENTER));
        table.addCell(createCell("部门", font, Element.ALIGN_CENTER));
        table.addCell(createCell("岗位", font, Element.ALIGN_CENTER));
        table.addCell(createCell("联络电话", font, Element.ALIGN_CENTER));
        table.addCell(createCell(handover.getEntryName(), font, Element.ALIGN_CENTER));
        table.addCell(createCell(handover.getDepartmentName(), font, Element.ALIGN_CENTER));
        table.addCell(createCell(handover.getPositionName(), font, Element.ALIGN_CENTER));
        table.addCell(createCell(handover.getEntryPhone(), font, Element.ALIGN_CENTER));
        PdfPCell cell0 = new PdfPCell();
        cell0.setColspan(4);
        cell0.setBorderWidth(0);
        cell0 = createCell("结算清单明细", keyfont, Element.ALIGN_CENTER, 4);
        cell0.setFixedHeight(30);
        cell0.setBorder(0);
        table.addCell(cell0);
        table.addCell(createCell("名目", font, Element.ALIGN_CENTER));
        table.addCell(createCell("明细", font, Element.ALIGN_CENTER));
        table.addCell(createCell("金额", font, Element.ALIGN_CENTER));
        table.addCell(createCell("依据/备注", font, Element.ALIGN_CENTER));
        table.addCell(createCell("待发薪资", font, Element.ALIGN_CENTER, 2));
        table.addCell(createCell(handover.getSalary(), font, Element.ALIGN_CENTER));
        table.addCell(createCell(handover.getSalaryBasis(), font, Element.ALIGN_LEFT));
        table.addCell(createCell("待报销费用", font, Element.ALIGN_CENTER, 2));
        table.addCell(createCell(handover.getReimbursement(), font, Element.ALIGN_CENTER));
        table.addCell(createCell(handover.getReimbursementBasis(), font, Element.ALIGN_LEFT));
//
        PdfPCell cell1 = new PdfPCell();
        cell1 = this.createCell("工作交接", font, Element.ALIGN_CENTER);
        cell1.setRowspan(2);
        table.addCell(cell1);
        table.addCell(createCell("本职工作", font, Element.ALIGN_LEFT));
        table.addCell(createCell(handover.getJobs(), font, Element.ALIGN_CENTER));
        table.addCell(createCell(handover.getJobsBasis(), font, Element.ALIGN_LEFT));
        table.addCell(createCell("合同、单据等文件", font, Element.ALIGN_LEFT));
        table.addCell(createCell(handover.getDocument(), font, Element.ALIGN_CENTER));
        table.addCell(createCell(handover.getDocumentBasis(), font, Element.ALIGN_LEFT));

        PdfPCell cell2 = new PdfPCell();
        cell2 = this.createCell("物品交接", font, Element.ALIGN_CENTER);
        cell2.setRowspan(8);
        table.addCell(cell2);
        table.addCell(createCell("工作证件及饭卡", font, Element.ALIGN_LEFT));
        table.addCell(createCell(handover.getCertificate(), font, Element.ALIGN_CENTER));
        table.addCell(createCell(handover.getCertificateBasis(), font, Element.ALIGN_LEFT));
        table.addCell(createCell("维护备件", font, Element.ALIGN_LEFT));
        table.addCell(createCell(handover.getSpares(), font, Element.ALIGN_CENTER));
        table.addCell(createCell(handover.getSparesBasis(), font, Element.ALIGN_LEFT));
        table.addCell(createCell("维护工具", font, Element.ALIGN_LEFT));
        table.addCell(createCell(handover.getTools(), font, Element.ALIGN_CENTER));
        table.addCell(createCell(handover.getToolsBasis(), font, Element.ALIGN_LEFT));
        table.addCell(createCell("Ukey", font, Element.ALIGN_LEFT));
        table.addCell(createCell(handover.getUkey(), font, Element.ALIGN_CENTER));
        table.addCell(createCell(handover.getUkeyBasis(), font, Element.ALIGN_LEFT));
        table.addCell(createCell("办公设施", font, Element.ALIGN_LEFT));
        table.addCell(createCell(handover.getFacilities(), font, Element.ALIGN_CENTER));
        table.addCell(createCell(handover.getFacilitiesBasis(), font, Element.ALIGN_CENTER));
        table.addCell(createCell("办公用品", font, Element.ALIGN_LEFT));
        table.addCell(createCell(handover.getSupplies(), font, Element.ALIGN_CENTER));
        table.addCell(createCell(handover.getSuppliesBasis(), font, Element.ALIGN_CENTER));
        table.addCell(createCell("名片", font, Element.ALIGN_LEFT));
        table.addCell(createCell(handover.getCard(), font, Element.ALIGN_CENTER));
        table.addCell(createCell(handover.getCardBasis(), font, Element.ALIGN_CENTER));
        table.addCell(createCell("其他", font, Element.ALIGN_LEFT));
        table.addCell(createCell(handover.getOthers1(), font, Element.ALIGN_CENTER));
        table.addCell(createCell(handover.getOthers1Basis(), font, Element.ALIGN_LEFT));

        PdfPCell cell3 = new PdfPCell();
        cell3 = this.createCell("系统账号", font, Element.ALIGN_CENTER);
        cell3.setRowspan(8);
        table.addCell(cell3);
        table.addCell(createCell("OA系统", font, Element.ALIGN_LEFT));
        table.addCell(createCell(handover.getOa(), font, Element.ALIGN_CENTER));
        table.addCell(createCell(handover.getOaBasis(), font, Element.ALIGN_LEFT));
        table.addCell(createCell("企业邮箱", font, Element.ALIGN_LEFT));
        table.addCell(createCell(handover.getMailbox(), font, Element.ALIGN_CENTER));
        table.addCell(createCell(handover.getMailboxBasis(), font, Element.ALIGN_LEFT));
        table.addCell(createCell("SVN、Mantis", font, Element.ALIGN_LEFT));
        table.addCell(createCell(handover.getSvn(), font, Element.ALIGN_CENTER));
        table.addCell(createCell(handover.getSvnBasis(), font, Element.ALIGN_LEFT));
        table.addCell(createCell("产品生命周期系统", font, Element.ALIGN_LEFT));
        table.addCell(createCell(handover.getLifecycle(), font, Element.ALIGN_CENTER));
        table.addCell(createCell(handover.getLifecycleBasis(), font, Element.ALIGN_LEFT));
        table.addCell(createCell("ERP", font, Element.ALIGN_LEFT));
        table.addCell(createCell(handover.getErp(), font, Element.ALIGN_CENTER));
        table.addCell(createCell(handover.getErpBasis(), font, Element.ALIGN_LEFT));
        table.addCell(createCell("考试系统", font, Element.ALIGN_LEFT));
        table.addCell(createCell(handover.getExam(), font, Element.ALIGN_CENTER));
        table.addCell(createCell(handover.getExamBasis(), font, Element.ALIGN_LEFT));
        table.addCell(createCell("综合管理系统", font, Element.ALIGN_LEFT));
        table.addCell(createCell(handover.getManagement(), font, Element.ALIGN_CENTER));
        table.addCell(createCell(handover.getManagementBasis(), font, Element.ALIGN_LEFT));
        table.addCell(createCell("其他系统", font, Element.ALIGN_LEFT));
        table.addCell(createCell(handover.getOthers2(), font, Element.ALIGN_CENTER));
        table.addCell(createCell(handover.getOthers2Basis(), font, Element.ALIGN_LEFT));

        PdfPCell cell4 = new PdfPCell();
        cell4 = this.createCell("账务清算", font, Element.ALIGN_CENTER);
        cell4.setRowspan(2);
        table.addCell(cell4);
        table.addCell(createCell("各类借款", font, Element.ALIGN_LEFT));
        table.addCell(createCell(handover.getLoans(), font, Element.ALIGN_CENTER));
        table.addCell(createCell(handover.getLoansBasis(), font, Element.ALIGN_LEFT));
        table.addCell(createCell("发票及押金条", font, Element.ALIGN_LEFT));
        table.addCell(createCell(handover.getInvoice(), font, Element.ALIGN_CENTER));
        table.addCell(createCell(handover.getInvoiceBasis(), font, Element.ALIGN_LEFT));

        table.addCell(this.createCell("结余", font, Element.ALIGN_CENTER, 2));
        table.addCell(this.createCell(handover.getTotal(), font, Element.ALIGN_CENTER, 2));
        try {
            document1.add(table);
            document1.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

    }*/
}
