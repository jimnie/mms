package com.educonsulting.mms.controller;

import com.alibaba.fastjson.JSONObject;
import com.educonsulting.mms.Filter;
import com.educonsulting.mms.Message;
import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.entity.Lifetime;
import com.educonsulting.mms.service.LifetimeService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.beans.IntrospectionException;
import java.beans.PropertyDescriptor;
import java.io.*;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/lifetime")
public class LifetimeController extends BaseController {

    @Resource(name = "lifetimeServiceImpl")
    private LifetimeService lifetimeService;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index() {
        return "/lifetime/index";
    }

    @RequestMapping(value = "/query", method = RequestMethod.GET)
    public String query() {
        return "/lifetime/query";
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public Message save(Lifetime lifetime) {
        lifetimeService.save(lifetime);
        return SUCCESS_MESSAGE;
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public Object list(@RequestParam(value = "rows", required = false) String rows,
                       @RequestParam(value = "page", required = false) String page,
                       @RequestParam(value = "sort", required = false) String sort,
                       @RequestParam(value = "order", required = false) String order,
                       @RequestParam(value = "name", required = false) String name,
                       @RequestParam(value = "creator", required = false) String creator) {
        Pageable pageable = getPageable(rows, page, sort, order);
        List<Filter> filters = new ArrayList<Filter>();
        if (StringUtils.isNotEmpty(name)) {
            filters.add(Filter.eq("nickname", name));
            filters.add(Filter.eq("nickname", name));
        }
        if (StringUtils.isNotEmpty(creator)) {
            filters.add(Filter.eq("creator", creator));
        }
        pageable.setFilters(filters);
        Page<Lifetime> lifetimePage = lifetimeService.findPage(pageable);
        return getPageResultMap(lifetimePage);
    }

    @RequestMapping(value = "/export/{serviceNo}", method = {RequestMethod.POST, RequestMethod.GET})
    public void export(HttpServletRequest request,
                       HttpServletResponse response,
                       @PathVariable String serviceNo) {

        List<Lifetime> lifetimeList = lifetimeService.findLifetimeByServiceNo(serviceNo);
        if (CollectionUtils.isNotEmpty(lifetimeList)) {
            Lifetime lifetime = lifetimeList.get(0);
            if (null != lifetime) {
                String[] headers = {"业务编号", "逝者姓名", "性别", "年龄", "开幕选项", "闭幕选项", "主题", "第一页", "第二页", "第三页", "第四页", "第五页", "第六页", "第七页", "第八页", "第九页", "第十页", "第十一页", "第十二页", "第十三页", "第十四页", "第十五页", "第十六页", "第十七页", "第十八页", "第十九页", "第二十页", "第二十一页", "第二十二页", "第二十三页", "第二十四页", "第二十五页", "第二十六页", "第二十七页", "第二十八页", "第二十九页", "第三十页", "第三十一页", "第三十二页", "第三十三页", "第三十四页", "第三十五页", "第三十六页", "第三十七页", "第三十八页", "第三十九页", "第四十页", "第四十一页", "第四十二页", "第四十三页", "第四十四页", "第四十五页", "第四十六页", "第四十七页", "第四十八页", "第四十九页", "第五十页"};
                String[] columNames = {"serviceNo", "name", "sex", "age", "beginStat", "endStat", "theme", "act1", "act2", "act3", "act4", "act5", "act6", "act7", "act8", "act9", "act10", "act11", "act12", "act13", "act14", "act15", "act16", "act17", "act18", "act19", "act20", "act21", "act22", "act23", "act24", "act25", "act26", "act27", "act28", "act29", "act30", "act31", "act32", "act33", "act34", "act35", "act36", "act37", "act38", "act39", "act40", "act41", "act42", "act43", "act44", "act45", "act46", "act47", "act48", "act49", "act50"};

                Class clazz = lifetime.getClass();
                Field[] fields = lifetime.getClass().getDeclaredFields();//获得属性
                Object value = null;

                // 第一步，创建一个workbook，对应一个Excel文件
                HSSFWorkbook workbook = new HSSFWorkbook();

                // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
                HSSFSheet hssfSheet = workbook.createSheet("sheet1");

                // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
                HSSFRow row = null; // excel 每一行的实例的引用
                HSSFCell headerCell = null, valueCell = null; // 每一行中标题列和数值列单元格的实例的引用

                // 第四步，创建单元样式设置值表头 设置表头居中
                HSSFCellStyle hssfCellStyle = workbook.createCellStyle();
                //居中样式
                hssfCellStyle.setAlignment(HorizontalAlignment.CENTER);

                // 第五步，写入实体数据
                for (int i = 0; i < headers.length; i++) {
                    row = hssfSheet.createRow(i);
                    headerCell = row.createCell(0);
                    headerCell.setCellValue(headers[i]);
                    headerCell.setCellStyle(hssfCellStyle);

                    try {
                        value = getValueByField(lifetime, columNames[i], clazz, fields);
                    } catch (IntrospectionException e) {
                        e.printStackTrace();
                    } catch (IllegalAccessException e) {
                        e.printStackTrace();
                    } catch (InvocationTargetException e) {
                        e.printStackTrace();
                    }

                    valueCell = row.createCell(1);
                    if (null != value) {
                        if (value instanceof String) {
                            valueCell.setCellValue((String) value);
                        } else if (value instanceof Integer) {
                            valueCell.setCellValue(((Integer) value).toString());
                        }
                    }
                    valueCell.setCellStyle(hssfCellStyle);
                }

                // 第六步，将文件输出到客户端浏览器
                BufferedInputStream bis = null;
                BufferedOutputStream bos = null;
                try {
                    ByteArrayOutputStream os = new ByteArrayOutputStream();
                    workbook.write(os);
                    byte[] content = os.toByteArray();
                    InputStream is = new ByteArrayInputStream(content);
                    // 设置response参数，可以打开下载页面
                    String fileName = serviceNo + "_生平清单.xls";
                    //中文乱码下载解决方法
                    response.reset();
                    response.setHeader("Content-disposition", "attachment;filename*=UTF-8''" + URLEncoder.encode(fileName, "UTF-8"));
                    response.setContentType("application/vnd.ms-excel;charset=utf-8");
                    ServletOutputStream out = response.getOutputStream();
                    bis = new BufferedInputStream(is);
                    bos = new BufferedOutputStream(out);
                    byte[] buff = new byte[2048];
                    int bytesRead;
                    while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
                        bos.write(buff, 0, bytesRead);
                    }
                } catch (final Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (bis != null) {
                            bis.close();
                        }
                        if (bos != null) {
                            bos.close();
                        }
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }

    private Object getValueByField(Lifetime lifetime, String columName, Class clazz, Field[] fields) throws IntrospectionException, IllegalAccessException, InvocationTargetException {
        for (Field field : fields) {
            if (field.getName().equals(columName)) {
                PropertyDescriptor pd = new PropertyDescriptor(field.getName(),
                        clazz);
                // 获得get方法
                Method getMethod = pd.getReadMethod();
                // 执行get方法返回一个Object
                return getMethod.invoke(lifetime);
            }
        }
        return null;
    }

    @RequestMapping(value = "/exist", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public Object isServiceNoExist(@RequestParam(value = "sno", required = true) String sno) {
        boolean isExist = lifetimeService.isServiceNoExist(sno);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("result", isExist);
        return jsonObject;
    }
}
