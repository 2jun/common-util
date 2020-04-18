package com.aj.tool.domain.DTO;

import lombok.Data;

import java.util.Date;
@Data
public class ReserveInfoDTO {
    private Long id;

    private Long reserveId;

    private Long skuId;

    private String skuName;

    private Long shopId;

    private Date startTime;//'预约开始时间'

    private Date endTime;//'预约结束时间'

    private Date panicbuyingStartTime;//'抢购开始时间'

    private Date panicbuyingEndTime;//'抢购结束时间'

    private Date dt;

    private Date created;

    private Boolean yn;

}