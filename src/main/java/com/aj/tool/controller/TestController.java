package com.aj.tool.controller;

import com.aj.tool.core.office.excel.ExportExcel;
import com.aj.tool.core.office.param.ExeclColumnParam;
import com.aj.tool.core.office.param.ExeclTableParam;
import com.aj.tool.core.utils.SecurityMUtils;
import com.aj.tool.domain.DTO.ShopDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedOutputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;

/**
 * @ClassName: TestController
 *
 * @Description: TODO
 * @date: 2020-04-02  2:07
 */
@Controller
@RequestMapping(value = "test")
public class TestController {
    private static Logger logger = LoggerFactory.getLogger(TestController.class);

    @Autowired
    ExecutorService executorService;

    /**
     *
     */
    @RequestMapping("cal")
    @ResponseBody
    public Object threadPoolCal(Integer i) {
        for (int i1 = 0; i1 < i; i1++) {
            int finalI = i1;
            executorService.submit(() -> {
                try {
                    System.out.println("---->>>>>" + finalI + "-->Thread.currentThread().getName()" + Thread.currentThread().getName());
//                    Thread.sleep(5000L);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            });
        }
        return "success!";
    }

    /**
     * 导出报表工具测试
     *
     * @param request
     * @param response
     * @param fileName
     * @param sheetName
     */
    @RequestMapping(value = "downLoad")
    public void test1(HttpServletRequest request,
                      HttpServletResponse response,
                      @RequestParam("fileName") String fileName,
                      @RequestParam("sheetName") String sheetName) {

        String ip = SecurityMUtils.getIpAddr(request);
//        OutputStream out = null;
        try (OutputStream out = new BufferedOutputStream(response.getOutputStream())) {
            List<ShopDTO> voLst = new ArrayList<>();
            ShopDTO shop;
            ExeclTableParam execlTableParam = new ExeclTableParam();
            for (int i = 0; i < 100000; i++) {
                shop = new ShopDTO();
                shop.setShopId(i * 2L);
                shop.setUserId(i * 3L);
                shop.setSellerNick("sellerNick-->" + i);
                shop.setSaleAmount(i * 4.0D);
                voLst.add(shop);
            }
            execlTableParam.setData(voLst);
            List<ExeclColumnParam> columnParams = new ArrayList<>();
            execlTableParam.setColumnParams(columnParams);
            columnParams.add(new ExeclColumnParam("店铺ID", "shopId"));
            columnParams.add(new ExeclColumnParam("用户ID", "userId"));
            columnParams.add(new ExeclColumnParam("卖家昵称", "sellerNick"));
            columnParams.add(new ExeclColumnParam("销售额", "saleAmount"));
            response.reset();
            String headStr = "attachment; filename=" + URLEncoder.encode(fileName + ".xlsx", "utf-8");
            response.setContentType("application/vnd.ms-excel;charset=UTF-8");
            response.setHeader("Content-Disposition", headStr);
            exportData(out, execlTableParam, fileName, sheetName);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return;
    }


    public void exportData(OutputStream out, ExeclTableParam tableParam, String fileName, String sheetName) throws Exception {
        try {
            logger.info("filename={} 开始导出...threadName={}", fileName, Thread.currentThread().getName());
            long s = System.currentTimeMillis();
            ExportExcel exort = new ExportExcel();
            exort.execlExport(sheetName, tableParam, out);
            long e = System.currentTimeMillis();
            String name = Thread.currentThread().getName();
            logger.info("filename={}->导出完成...threadName={},耗时={}", fileName, name, e - s);
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            throw new RuntimeException("导出失败");
        }
    }

}
