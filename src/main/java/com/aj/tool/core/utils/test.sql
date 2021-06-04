

set @sharding = 'sg_pop_chat_peer_sku_presale shop_id hash';
        CREATE TABLE `sg_pop_chat_peer_sku_presale` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺Id',
        `date` date DEFAULT NULL COMMENT '聊天日期',
        `cs_nick` varchar(50) NOT NULL COMMENT '客服昵称',
        `customer` varchar(50) NOT NULL COMMENT '顾客pin',
        `sku_id` bigint(20) unsigned NOT NULL COMMENT '顾客咨询的sku/客服推荐的skuId',
        `is_order_created` tinyint(2) DEFAULT '0' COMMENT '买家有下单',
        `type` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '类型 1:客服推荐 2：顾客咨询',
        `sku_name` varchar(500) DEFAULT NULL COMMENT 'sku名称',
        `is_cross_chat_filter` tinyint(2) DEFAULT '0' COMMENT '跨天聊天过滤',
        `forward_type` tinyint(2) DEFAULT '0' COMMENT '转入：1,\n转出：2 ，\n非转发：0\n转接:3',
        `chat_flag` tinyint(2) unsigned DEFAULT '0' COMMENT '0:正常咨询  \n1:空聊天 \n2:团队内部过滤 \n3: 绩效系统客服过滤 \n4: 平台客服过滤 ',
        `cross_chat_flag` tinyint(2) unsigned DEFAULT '0' COMMENT '跨天聊天标识：默认0，无跨天聊天\n1：0点击前最长等待时间内有聊天\n2：0点前后最长等待时间内有聊天\n',
        `is_consult` tinyint(2) DEFAULT '0' COMMENT '是否是 咨询客户',
        `is_receive` tinyint(2) DEFAULT '0' COMMENT '是否是 接待的客户',
        `is_enquiry` tinyint(2) DEFAULT '0' COMMENT '是否是询单的顾客',
        `cs_chat_first_flag` tinyint(2) DEFAULT '0' COMMENT '0:非正常聊天\\n1:主动联系\\n2::非主动',
        `sys_dept_code` varchar(20) DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据\\n 事业群编码\\n 事业部编码'',',
        `erp_id` varchar(50) NOT NULL DEFAULT '' COMMENT 'ERP账号',
        `is_after_sale` tinyint(2) DEFAULT '0' COMMENT '售后咨询',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`),
        KEY `idx_shop_date` (`shop_id`,`date`) USING BTREE,
        KEY `idx_shop_cs_date` (`shop_id`,`cs_nick`,`date`) USING BTREE,
        KEY `idx_shop_buyer_date` (`shop_id`,`customer`,`date`) USING BTREE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POP预售聊天对象表';

        set @sharding = 'sg_pop_chat_peer_sku_reserve shop_id hash';
        CREATE TABLE `sg_pop_chat_peer_sku_reserve` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺Id',
        `date` date DEFAULT NULL COMMENT '聊天日期',
        `cs_nick` varchar(50) NOT NULL COMMENT '客服昵称',
        `customer` varchar(50) NOT NULL COMMENT '顾客pin',
        `sku_id` bigint(20) unsigned NOT NULL COMMENT '顾客咨询的sku/客服推荐的skuId',
        `sku_name` varchar(500) DEFAULT '' COMMENT 'sku名称',
        `type` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '类型 1:客服推荐 2：顾客咨询',
        `forward_type` tinyint(2) DEFAULT '0' COMMENT '转入：1,\n转出：2 ，\n非转发：0\n转接:3',
        `chat_flag` tinyint(2) unsigned DEFAULT '0' COMMENT '0:正常咨询  \n1:空聊天 \n2:团队内部过滤 \n3: 绩效系统客服过滤 \n4: 平台客服过滤 ',
        `is_cross_chat_filter` tinyint(2) DEFAULT '0' COMMENT '跨天聊天过滤',
        `cs_chat_first_flag` tinyint(2) DEFAULT '0' COMMENT '0:非正常聊天\\n1:主动联系\\n2::非主动',
        `cross_chat_flag` tinyint(2) unsigned DEFAULT '0' COMMENT '跨天聊天标识：默认0，无跨天聊天\n1：0点击前最长等待时间内有聊天\n2：0点前后最长等待时间内有聊天\n',
        `is_consult` tinyint(2) DEFAULT '0' COMMENT '是否是 咨询客户',
        `is_receive` tinyint(2) DEFAULT '0' COMMENT '是否是 接待的客户',
        `is_reserve` tinyint(2) DEFAULT '0' COMMENT '预约周期内，用户是否预约了 1 是  2 不是 0 默认值',
        `is_enquiry` tinyint(2) DEFAULT '0' COMMENT '是否是询单的顾客',
        `is_order_created` tinyint(2) DEFAULT '0' COMMENT '买家有下单',
        `is_after_sale` tinyint(2) DEFAULT '0' COMMENT '售后咨询',
        `sys_dept_code` varchar(20) DEFAULT '' COMMENT '根据哪个组织设置得系统设置跑出得数据\\n 事业群编码\\n 事业部编码'',',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`),
        KEY `idx_shop_date` (`shop_id`,`date`) USING BTREE,
        KEY `idx_shop_cs_date` (`shop_id`,`cs_nick`,`date`) USING BTREE,
        KEY `idx_shop_buyer_date` (`shop_id`,`customer`,`date`) USING BTREE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POP预约聊天对象表';

        set @sharding = 'sg_pop_cs_order_sku_bind_presale shop_id hash';
        CREATE TABLE `sg_pop_cs_order_sku_bind_presale` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺Id',
        `date` date DEFAULT NULL COMMENT '日期',
        `cs_nick` varchar(45) NOT NULL COMMENT '客服昵称',
        `buyer_nick` varchar(45) NOT NULL DEFAULT '' COMMENT '买家昵称',
        `sku_id` bigint(20) unsigned NOT NULL COMMENT 'sku_id`',
        `order_id` bigint(20) unsigned NOT NULL COMMENT '订单id',
        `order_created` datetime NOT NULL COMMENT '订单下单日期',
        `order_bargain_time` datetime DEFAULT NULL COMMENT '订单付定金时间',
        `order_balance_time` datetime DEFAULT NULL COMMENT '订单付尾款时间',
        `order_bargain_payment` double(20,3) unsigned DEFAULT NULL COMMENT '订单付定金金额',
        `order_balance_payment` double(20,3) unsigned DEFAULT NULL COMMENT '订单付尾款金额',
        `order_goods_num` int(11) unsigned DEFAULT '0' COMMENT '订单商品数量',
        `order_post_fee` double(20,3) unsigned NOT NULL COMMENT '邮费',
        `order_pay_type` tinyint(3) unsigned DEFAULT '0' COMMENT '支付方式（1货到付款, 2邮局汇款, 3自提, 4在线支付, 5公司转账, 6银行卡转账） ',
        `type` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '1：落实下单\n2：落实付款\n3：全静默绩效绑定',
        `is_pes` tinyint(2) DEFAULT '0' COMMENT '是否是绩效订单',
        `sys_dept_code` varchar(20) DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据\\n 事业群编码 \\n 事业部编码'',',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`),
        KEY `idx_order` (`order_id`) USING BTREE,
        KEY `idx_shop_cs_created` (`shop_id`,`cs_nick`,`order_created`) USING BTREE,
        KEY `idx_shop_buyer` (`shop_id`,`buyer_nick`) USING BTREE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POP 客服预售订单SKU绑定表';

        set @sharding = 'sg_pop_cs_order_sku_bind_reserve shop_id hash';
        CREATE TABLE `sg_pop_cs_order_sku_bind_reserve` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺Id',
        `date` date DEFAULT NULL COMMENT '日期',
        `cs_nick` varchar(45) NOT NULL COMMENT '客服昵称',
        `buyer_nick` varchar(45) NOT NULL DEFAULT '' COMMENT '买家昵称',
        `order_id` bigint(20) unsigned NOT NULL COMMENT '订单id',
        `sku_id` bigint(20) unsigned NOT NULL COMMENT 'sku_id`',
        `is_reserve` tinyint(20) DEFAULT '0' COMMENT '预约周期内，用户是否预约了 1 是  2 不是 0 默认值',
        `order_created` datetime NOT NULL COMMENT '订单下单日期',
        `order_pay_time` datetime DEFAULT NULL COMMENT '订单付款日期',
        `order_payment` double(20,3) unsigned DEFAULT NULL COMMENT '订单付款金额',
        `order_goods_num` int(11) unsigned DEFAULT '0' COMMENT '订单商品数量',
        `order_post_fee` double(20,3) unsigned NOT NULL COMMENT '邮费',
        `order_pay_type` tinyint(3) unsigned DEFAULT '0' COMMENT '支付方式（1货到付款, 2邮局汇款, 3自提, 4在线支付, 5公司转账, 6银行卡转账） ',
        `type` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '1：落实下单\n2：落实付款\n3：全静默绩效绑定',
        `is_pes` tinyint(2) DEFAULT '0' COMMENT '是否是绩效订单',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据\\n 事业群编码\\n 事业部编码'',',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`),
        KEY `idx_order` (`order_id`) USING BTREE,
        KEY `idx_shop_cs_created` (`shop_id`,`cs_nick`,`order_created`) USING BTREE,
        KEY `idx_shop_buyer` (`shop_id`,`buyer_nick`) USING BTREE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POP 客服预约订单SKU绑定表';


        set @sharding = 'sg_pop_dept_init singleShard';
        CREATE TABLE `sg_pop_dept_init` (
        `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `dept_code` varchar(255) NOT NULL DEFAULT '' COMMENT 'ERP账号',
        `status` tinyint(255) unsigned NOT NULL DEFAULT '0' COMMENT 'erp状态（0:未初始化,1:初始化进行中,2:初始化完成）',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `modified` datetime DEFAULT NULL COMMENT '修改时间',
        `modified_by` varchar(255) DEFAULT '' COMMENT '修改人',
        `yn` tinyint(2) DEFAULT '0' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`) USING BTREE,
        UNIQUE KEY `uniq_dept_code` (`dept_code`) USING BTREE
        ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='POP部门初始化表';

        set @sharding = 'sg_pop_erp singleShard';
        CREATE TABLE `sg_pop_erp` (
        `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `erp_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'ERP账号',
        `dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '部门编号',
        `dept_name` varchar(255) NOT NULL DEFAULT '' COMMENT '部门名称',
        `dept_type` tinyint(255) unsigned NOT NULL DEFAULT '0' COMMENT '部门类别（2:事业群,3:事业部,4:二级部门,5三级部门,6:业务组）',
        `user_name` varchar(255) NOT NULL DEFAULT '' COMMENT '用户姓名',
        `is_operation` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是运营经理 0:否 1:是',
        `position_code` varchar(255) NOT NULL DEFAULT '' COMMENT '岗位编码',
        `position_name` varchar(255) NOT NULL DEFAULT '' COMMENT '岗位名称',
        `level_code` varchar(255) NOT NULL DEFAULT '' COMMENT '职级编码',
        `level_name` varchar(255) NOT NULL DEFAULT '' COMMENT '职级名称',
        `dept_full_path` varchar(255) NOT NULL DEFAULT '' COMMENT '组织机构全路径',
        `dept_full_name` varchar(255) NOT NULL DEFAULT '' COMMENT '组织机构全名',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `modified` datetime DEFAULT NULL COMMENT '修改时间',
        `modified_by` varchar(255) DEFAULT '' COMMENT '修改人',
        `yn` tinyint(1) DEFAULT '0' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`) USING BTREE
        ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='POP erp账户表';


        set @sharding = 'sg_pop_erp_recal_recored singleShard';
        set @sharding = 'sg_pop_erp_recal_recored shop_id hash';
        CREATE TABLE `sg_pop_erp_recal_recored` (
        `id` bigint(20) NOT NULL COMMENT '主键',
        `dept_code` varchar(20) NOT NULL COMMENT '部门编码',
        `erp_id` varchar(20) NOT NULL COMMENT 'ERP账号',
        `start_time` datetime NOT NULL COMMENT '开始时间',
        `end_time` datetime NOT NULL COMMENT '结束时间',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POP ERP数据重算记录表';


        set @sharding = 'sg_pop_group_dept singleShard';
        CREATE TABLE `sg_pop_group_dept` (
        `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '部门编号',
        `dept_name` varchar(255) NOT NULL DEFAULT '' COMMENT '部门名称',
        `dept_type` tinyint(255) unsigned NOT NULL DEFAULT '0' COMMENT '部门类别（2:事业群,3:事业部,4:二级部门,5:三级部门,6:业务组）',
        `parent_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '父编号',
        `dept_full_path` varchar(255) NOT NULL DEFAULT '' COMMENT '组织机构全路径',
        `dept_full_name` varchar(255) NOT NULL DEFAULT '' COMMENT '组织机构全名',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `modified` datetime DEFAULT NULL COMMENT '修改时间',
        `modified_by` varchar(255) DEFAULT '' COMMENT '修改人',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`) USING BTREE
        ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='POP部门表';

        set @sharding = 'sg_pop_job_cal_record singleShard';
        set @sharding = 'sg_pop_job_cal_record shop_id hash';
        CREATE TABLE `sg_pop_job_cal_record` (
        `id` bigint(20) NOT NULL COMMENT '主键',
        `title` varchar(255) DEFAULT '' COMMENT '店铺名称',
        `shop_id` bigint(20) NOT NULL COMMENT '店铺ID',
        `date` date DEFAULT NULL COMMENT '日期',
        `result` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0:计算失败,1：计算成功',
        `run_status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '0:未执行,1:执行成功,2:执行中,4:执行失败',
        `erp_id` varchar(200) NOT NULL COMMENT '管理人员',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据 事业群\n编码/事业部编码',
        `msg` varchar(200) DEFAULT NULL COMMENT '失败原因',
        `consume_time` bigint(20) DEFAULT NULL COMMENT '店铺数据处理消耗的时长',
        `op_time` datetime DEFAULT NULL COMMENT '操作时间',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '数据创建时间',
        `modified` datetime DEFAULT NULL COMMENT '数据修改时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`),
        KEY `idx_shop_date` (`shop_id`,`date`) USING BTREE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='POP JOB计算记录表';

        set @sharding = 'sg_pop_shop singleShard';
        CREATE TABLE `sg_pop_shop` (
        `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺id',
        `title` varchar(100) NOT NULL COMMENT '店铺名',
        `vender_id` bigint(20) unsigned DEFAULT NULL COMMENT '商家ID',
        `dept2_code` varchar(50) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(50) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(50) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(50) DEFAULT NULL COMMENT '三级部门编号',
        `dept6_code` varchar(50) DEFAULT NULL COMMENT '业务组编号',
        `erp_id` varchar(50) NOT NULL COMMENT '管理人员',
        `init_data_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '店铺是否完成初始化',
        `mf_ordered_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否订购魔方',
        `mf_ordered_status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '订购魔方状态（1:有效,2:无效）',
        `mf_enquiry_valid_duration_time` int(11) DEFAULT '2' COMMENT '魔方询单有效时长(n天)n:2-15',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `modified` datetime DEFAULT NULL COMMENT '修改时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`),
        KEY `idx_shop_id` (`shop_id`) USING BTREE
        ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='POP 店铺表';

        set @sharding = 'sg_pop_shop_ov_presale_day shop_id hash';
        CREATE TABLE `sg_pop_shop_ov_presale_day` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺id',
        `date` date DEFAULT NULL COMMENT '时间',
        `title` varchar(255) DEFAULT '' COMMENT '店铺名',
        `ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度:下单人数',
        `ordered_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度:下单件数',
        `ordered_bargain_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单付定金人数',
        `ordered_bargain_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单付定金件数',
        `ordered_bargain_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单付定金金额',
        `ordered_balance_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单付尾款人数',
        `ordered_balance_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单付尾款件数',
        `ordered_balance_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单付尾款金额',
        `bargain_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付定金维度:付定金人数',
        `bargain_goods_num` int(11) unsigned DEFAULT '0' COMMENT '付定金维度:付定金件数',
        `bargain_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '付定金维度:付定金金额',
        `bargain_balance_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付定金维度:付定金后的付尾款人数',
        `balance_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付尾款维度:付尾款人数',
        `balance_goods_num` int(11) unsigned DEFAULT '0' COMMENT '付尾款维度:付尾款件数',
        `balance_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '付尾款维度:付尾款金额',
        `enquiry_ordered_conv_rate` double(20,3) DEFAULT NULL COMMENT '客服促成下单转化',
        `presale_start_time` datetime DEFAULT NULL COMMENT '预售开始时间',
        `presale_end_time` datetime DEFAULT NULL COMMENT '预售结束时间',
        `balance_start_time` datetime DEFAULT NULL COMMENT '尾款开始时间',
        `balance_end_time` datetime DEFAULT NULL COMMENT '尾款结束时间',
        `dept2_code` varchar(20) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(20) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(20) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(20) DEFAULT NULL COMMENT '业务组编号',
        `dept6_code` varchar(20) DEFAULT '' COMMENT '业务岗',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据\n 事业群编码/事业部编码',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POP 预售订单店铺维度每日总览数据表';


        set @sharding = 'sg_pop_shop_ov_reserve_day shop_id hash';
        CREATE TABLE `sg_pop_shop_ov_reserve_day` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺ID',
        `date` date DEFAULT NULL COMMENT '时间',
        `title` varchar(255) DEFAULT '' COMMENT '店铺名',
        `reserve_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '预约维度：\n预约人数',
        `reserve_ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '预约维度：\n预约下单人数',
        `reserve_paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '预约维度：\n预约付款人数',
        `ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度:下单人数',
        `ordered_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度:下单件数',
        `ordered_paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单付尾款人数',
        `ordered_paid_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单付尾款件数',
        `ordered_paid_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单付尾款金额',
        `paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付款维度:付款人数',
        `paid_goods_num` int(11) unsigned DEFAULT '0' COMMENT '付款维度:付款件数',
        `paid_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '付款维度:付款金额',
        `enquiry_ordered_conv_rate` double(20,3) DEFAULT NULL COMMENT '客服促成下单转化',
        `dept2_code` varchar(20) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(20) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(20) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(20) DEFAULT NULL COMMENT '业务组编号',
        `dept6_code` varchar(20) DEFAULT '' COMMENT '业务岗',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据\n 事业群\n编码/事业部编码',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POP （预售店铺维度）店铺每日总览数据表';

        set @sharding = 'sg_pop_shop_remind_word_history shop_id hash';
        CREATE TABLE `sg_pop_shop_remind_word_history` (
        `id` bigint(20) NOT NULL COMMENT '主键',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺ID',
        `date` date DEFAULT NULL COMMENT '日期',
        `word_id` bigint(20) unsigned DEFAULT NULL COMMENT '话术ID_用来做业务关联',
        `name` varchar(45) DEFAULT NULL COMMENT '话术名称',
        `type` tinyint(2) unsigned DEFAULT '0' COMMENT '话术类型:\n1：咨询未下单\n2：下单未付款\n3:  预售已下单未付定金\n4：已付定金待付尾款',
        `created` datetime DEFAULT NULL COMMENT '添加时间',
        `content` varchar(1000) DEFAULT NULL COMMENT '话术内容',
        `is_send_goods_url` tinyint(2) DEFAULT '0' COMMENT '是否发送顾客进店咨询的商品链接\n0:不发送，1：发送',
        `is_default` tinyint(2) DEFAULT '0' COMMENT '是否是默认话术',
        `scope` tinyint(2) unsigned DEFAULT '1' COMMENT '话术范围 1：通用 ,2：指定商品',
        `goods_type` tinyint(2) unsigned DEFAULT '1' COMMENT '维度： 1：sku维度，2：spu维度',
        `is_using` tinyint(1) DEFAULT '0' COMMENT '是否正在使用 0：否 1：是',
        `modified` datetime DEFAULT NULL COMMENT '修改时间',
        `dept2_code` varchar(50) DEFAULT '' COMMENT '事业群编码',
        `dept3_code` varchar(50) DEFAULT '' COMMENT '事业部编码',
        `dept4_code` varchar(50) DEFAULT '' COMMENT '二级部门编码',
        `dept5_code` varchar(50) DEFAULT '' COMMENT '三级部门编号',
        `dept6_code` varchar(50) DEFAULT '' COMMENT '业务组编号',
        `erp_id` varchar(50) DEFAULT '' COMMENT '管理人员',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POP 店铺提醒话术_history';

        set @sharding = 'sg_pop_shop_setting_batch_remind_cno_history shop_id hash';
        CREATE TABLE `sg_pop_shop_setting_batch_remind_cno_history` (
        `id` bigint(20) NOT NULL COMMENT '主键',
        `shop_id` bigint(20) NOT NULL COMMENT '店铺ID',
        `is_remind` tinyint(2) DEFAULT NULL COMMENT '是否提醒 1：是 0：否',
        `dept2_code` varchar(50) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(50) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(50) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(50) DEFAULT NULL COMMENT '三级部门编号',
        `dept6_code` varchar(50) DEFAULT NULL COMMENT '业务组编号',
        `erp_id` varchar(50) DEFAULT NULL COMMENT '管理人员',
        `cno_time` int(11) unsigned DEFAULT NULL COMMENT '提醒时间',
        `word_name` varchar(45) DEFAULT NULL COMMENT '话术名称',
        `word_content` varchar(1000) DEFAULT NULL COMMENT '话术内容',
        `scope` tinyint(2) unsigned DEFAULT '1' COMMENT '话术范围 1：通用 ,2：指定商品',
        `goods_type` tinyint(2) unsigned DEFAULT '1' COMMENT '维度： 1：sku维度，2：spu维度',
        `remind_start_dot` int(11) unsigned DEFAULT NULL COMMENT '提醒开始时间',
        `remind_end_dot` int(11) unsigned DEFAULT NULL COMMENT '提醒结束时间',
        `created` datetime DEFAULT NULL COMMENT '创建时间',
        `modified` datetime DEFAULT NULL COMMENT '修改时间',
        `date` date DEFAULT NULL COMMENT '日期',
        PRIMARY KEY (`id`) USING BTREE,
        KEY `idx_shop_id` (`shop_id`) USING BTREE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POP 咨询未下单-批量提醒设置_历史';

        set @sharding = 'sg_pop_shop_setting_batch_remind_history shop_id hash';
        CREATE TABLE `sg_pop_shop_setting_batch_remind_history` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺ID',
        `dept2_code` varchar(50) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(50) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(50) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(50) DEFAULT NULL COMMENT '三级部门编号',
        `dept6_code` varchar(50) DEFAULT NULL COMMENT '业务组编号',
        `erp_id` varchar(50) DEFAULT NULL COMMENT '管理人员',
        `is_remind` tinyint(2) DEFAULT '0' COMMENT '是否批量提醒',
        `silent_cs_nick` varchar(1000) DEFAULT NULL COMMENT '静默订单 指定的 客服昵称/所选客服',
        `silent_group_id` bigint(20) DEFAULT NULL COMMENT '静默订单客服组',
        `silent_flag` tinyint(2) DEFAULT '2' COMMENT '静默订单 标示 1：均分在线客服 2 指定客服',
        `silent_spare_cs_nick` varchar(1000) DEFAULT NULL COMMENT '兜底客服昵称',
        `silent_spare_group_id` bigint(20) DEFAULT NULL COMMENT '兜底客服组',
        `unpc_time` int(11) unsigned DEFAULT '5' COMMENT '普通下单 未付款 且未取消 提醒时间 (m)',
        `unpc_word_id` varchar(200) DEFAULT '0' COMMENT '普通下单 未付款 且未取消 提醒话术',
        `bargain_remind_dot` int(11) unsigned DEFAULT NULL COMMENT '预售已下单未付定金 提醒时间(m)',
        `bargain_remind_word_id` varchar(200) DEFAULT NULL COMMENT '预售已下单未付定金 提醒话术',
        `balance_remind_dot` int(11) unsigned DEFAULT NULL COMMENT '预售已付定金未付尾款 至付尾款截止日期 提醒时间 (m)\n\n',
        `balance_remind_word_id` varchar(200) DEFAULT NULL COMMENT '预售已付定金未付尾款 至付尾款截止日期 提醒话术\n\n',
        `remind_start_dot` int(11) unsigned DEFAULT NULL COMMENT '提醒时间段开始时间',
        `remind_end_dot` int(11) unsigned DEFAULT NULL COMMENT '提醒时间段结束时间',
        `created` datetime DEFAULT NULL COMMENT '创建时间',
        `modified` datetime DEFAULT NULL COMMENT '修改时间',
        `date` date DEFAULT NULL COMMENT '日期',
        PRIMARY KEY (`id`) USING BTREE,
        KEY `idx_shop_id` (`shop_id`) USING BTREE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POP插件管理-批量提醒设置';

        set @sharding = 'sg_pop_shop_sms_setting_history shop_id hash';
        CREATE TABLE `sg_pop_shop_sms_setting_history` (
        `id` bigint(20) NOT NULL COMMENT '主键',
        `shop_id` bigint(20) NOT NULL COMMENT '店铺ID',
        `is_remind` tinyint(2) DEFAULT '0' COMMENT '0:关闭 1：开启',
        `dept2_code` varchar(50) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(50) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(50) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(50) DEFAULT NULL COMMENT '三级部门编号',
        `dept6_code` varchar(50) DEFAULT NULL COMMENT '业务组编号',
        `erp_id` varchar(50) DEFAULT NULL COMMENT '管理人员',
        `remind_time` int(11) unsigned zerofill DEFAULT NULL COMMENT '提醒时间(m)',
        `unpc_content` varchar(100) DEFAULT '' COMMENT '普通下单未付款话术',
        `slinet_content` varchar(100) DEFAULT '' COMMENT '静默下单未付款话术',
        `remind_start_dot` int(11) unsigned zerofill DEFAULT NULL COMMENT '提醒开始时间(m)',
        `remind_end_dot` int(11) unsigned zerofill DEFAULT NULL COMMENT '提醒结束时间(m)',
        `created` datetime DEFAULT NULL COMMENT '创建时间',
        `modified` datetime DEFAULT NULL COMMENT '修改时间',
        `date` date DEFAULT NULL COMMENT '日期',
        PRIMARY KEY (`id`),
        KEY `idx_shop` (`shop_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POP 店铺短信设置_历史';

        set @sharding = 'sg_pop_shop_sms_word_history shop_id hash';
        CREATE TABLE `sg_pop_shop_sms_word_history` (
        `id` bigint(20) NOT NULL COMMENT '主键',
        `shop_id` bigint(20) NOT NULL COMMENT '店铺id',
        `cs_nick` varchar(50) DEFAULT NULL COMMENT '添加客服的昵称',
        `dept2_code` varchar(50) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(50) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(50) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(50) DEFAULT NULL COMMENT '三级部门编号',
        `dept6_code` varchar(50) DEFAULT NULL COMMENT '业务组编号',
        `erp_id` varchar(50) DEFAULT NULL COMMENT '管理人员',
        `name` varchar(45) DEFAULT NULL COMMENT '话术名称',
        `type` tinyint(2) DEFAULT '1' COMMENT '短信话术类型 1:普通咨询下单未付款 2静默下单未付款',
        `content` varchar(100) DEFAULT NULL COMMENT '话术类容',
        `sms_sign` varchar(45) DEFAULT NULL COMMENT '短信签名',
        `sms_suffix` varchar(20) DEFAULT NULL COMMENT '短信后缀',
        `created` datetime DEFAULT NULL COMMENT '创建时间',
        `modified` datetime DEFAULT NULL COMMENT '修改时间',
        `audit_status` tinyint(2) DEFAULT '0' COMMENT '话术审核状态: 1:待审核 2：审核通过 3:审核未通过',
        `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
        `audit_remark` varchar(200) DEFAULT NULL COMMENT '审核留言',
        `is_using` tinyint(2) DEFAULT '0' COMMENT '正在使用 1：是 0否',
        `word_id` bigint(20) unsigned DEFAULT NULL COMMENT '话术ID_用来做业务关联',
        `date` date DEFAULT NULL COMMENT '日期',
        PRIMARY KEY (`id`),
        KEY `idx_shop_status` (`shop_id`,`audit_status`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POP 店铺短信话术设置_history';

        set @sharding = 'sg_pop_shop_sov_presale_day shop_id hash';
        CREATE TABLE `sg_pop_shop_sov_presale_day` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺id',
        `title` varchar(200) NOT NULL COMMENT '店铺名',
        `date` date DEFAULT NULL COMMENT '时间',
        `order_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付定金期-下单人数',
        `order_goods_num` int(11) unsigned DEFAULT '0' COMMENT '付定金期-下单件数',
        `ordered_bargain_buyer_num` int(11) DEFAULT '0' COMMENT '下单付定金人数',
        `ordered_bargain_goods_num` int(11) DEFAULT '0' COMMENT '下单付定金件数',
        `ordered_bargain_amount` double(20,3) DEFAULT '0.000' COMMENT '下单付定金金额',
        `ordered_balance_buyer_num` int(11) DEFAULT '0' COMMENT '下单付尾款人数',
        `ordered_balance_goods_num` int(11) DEFAULT '0' COMMENT '下单付尾款件数',
        `ordered_balance_amount` double(20,3) DEFAULT '0.000' COMMENT '下单付尾款金额',
        `bargain_buyer_num` int(11) DEFAULT '0' COMMENT '付定金维度:付定金人数',
        `bargain_balance_buyer_num` int(11) DEFAULT '0' COMMENT '付定金维度:付定金后的付尾款人数',
        `pay_buyer_num_today` int(11) unsigned DEFAULT '0' COMMENT '下单付定金人数',
        `pay_goods_num_today` int(11) unsigned DEFAULT '0' COMMENT '下单付定金件数',
        `pay_amount_today` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单付定金金额',
        `balance_buyer_num_today` int(11) unsigned DEFAULT '0' COMMENT '下单付尾款人数',
        `balance_goods_num_today` int(11) unsigned DEFAULT '0' COMMENT '下单付尾款件数',
        `balance_amount_today` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单付尾款金额',
        `pay_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付定金人数：付定金期间，付定金预售商品的顾客数',
        `balance_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付尾款人数：付定金人数中，对预售商品付尾款的人数',
        `to_ordered_num` int(20) unsigned DEFAULT '0' COMMENT '客服促成下单人数',
        `enquiry_num` int(20) unsigned DEFAULT '0' COMMENT '询单人数',
        `dept2_code` varchar(20) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(20) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(20) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(20) DEFAULT NULL COMMENT '业务组编号',
        `dept6_code` varchar(20) DEFAULT '' COMMENT '业务岗',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据 事业群\n编码/事业部编码',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`),
        KEY `idx_shop_date` (`shop_id`,`date`) USING BTREE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POP 预售静默绩效表（下单维度）';

        set @sharding = 'sg_pop_shop_sov_reserve_day shop_id hash';
        CREATE TABLE `sg_pop_shop_sov_reserve_day` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺id',
        `title` varchar(200) NOT NULL COMMENT '店铺名',
        `date` date DEFAULT NULL COMMENT '时间',
        `reserve_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '预约维度：预约人数',
        `reserve_ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '预约维度：\n预约下单人数',
        `reserve_paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '预约维度：\n预约付款人数',
        `ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度:下单人数',
        `ordered_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度:下单件数',
        `ordered_paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单付尾款人数',
        `ordered_paid_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单付尾款件数',
        `ordered_paid_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单付尾款金额',
        `paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付款维度:付款人数',
        `paid_goods_num` int(11) unsigned DEFAULT '0' COMMENT '付款维度:付款件数',
        `paid_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '付款维度:付款金额',
        `dept2_code` varchar(20) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(20) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(20) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(20) DEFAULT NULL COMMENT '三级部门编码',
        `dept6_code` varchar(20) DEFAULT NULL COMMENT '业务组编号',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据 事业群\n编码/事业部编码',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`),
        KEY `idx_shop_date` (`shop_id`,`date`) USING BTREE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POP 预约静默绩效表（下单维度）';

        set @sharding = 'sg_pop_shop_team_performance_presale shop_id hash';
        CREATE TABLE `sg_pop_shop_team_performance_presale` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺id',
        `date` date DEFAULT NULL COMMENT '时间',
        `title` varchar(255) DEFAULT '' COMMENT '店铺名',
        `direct_receive_num` int(11) unsigned DEFAULT '0' COMMENT '直接接待人数',
        `forward_in_num` int(11) unsigned DEFAULT '0' COMMENT '转入人数',
        `forward_out_num` int(11) unsigned DEFAULT '0' COMMENT '转出人数',
        `consult_num` int(11) unsigned DEFAULT '0' COMMENT '咨询人数',
        `receive_num` int(11) unsigned DEFAULT '0' COMMENT '接待人数',
        `enquiry_num` int(11) unsigned DEFAULT '0' COMMENT '询单人数',
        `ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '询单维度（下单）：询单下单人数\n当日询单， 最终落实下单的人数（最终数据依据，询单有效期）',
        `ordered_goods_num` int(11) unsigned DEFAULT '0' COMMENT '询单维度（下单）：询单下单件数\n当日询单， 最终落实下单的订单的商品数（最终数据依据，询单有效期）',
        `ordered_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '询单维度（下单）：\n当日询单， 最终落实下单的订单的金额（最终数据依据，询单有效期）',
        `bargain_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '询单维度（定金）：\n当日询单，最终落实下单，  并且最终付了款的人数（最终数据依据，询单有效期+付款有效期）\n',
        `bargain_goods_num` int(11) unsigned DEFAULT '0' COMMENT '询单维度（定金）：\n当日询单，最终落实下单，  并且最终付了款的订单件数（最终数据依据，询单有效期+付款有效期）',
        `bargain_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '询单维度（定金）：\n当日询单，最终落实下单，  并且最终付了款的订单金额（最终数据依据，询单有效期+付款有效期）',
        `balance_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '询单维度（尾款）：\n当日询单，最终落实下单，  并且最终付了尾款的人数（最终数据依据，询单有效期+付尾款有效期）\n',
        `balance_goods_num` int(11) unsigned DEFAULT '0' COMMENT '询单维度（尾款）：\n当日询单，最终落实下单，  并且最终付了尾款的件数（最终数据依据，询单有效期+付尾款有效期）\n',
        `balance_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '询单维度（尾款）：\n当日询单，最终落实下单，  并且最终付了尾款的金额（最终数据依据，询单有效期+付尾款有效期）\n',
        `to_bargain_buyer_num` int(11) DEFAULT '0' COMMENT '落实付定金人数',
        `to_bargain_balance_buyer_num` int(11) DEFAULT '0' COMMENT '落实付尾款人数',
        `dept2_code` varchar(20) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(20) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(20) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(20) DEFAULT NULL COMMENT '业务组编号',
        `dept6_code` varchar(20) DEFAULT '' COMMENT '业务岗',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据 事业群\n编码/事业部编码',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`),
        KEY `idx_shop_cs_date` (`shop_id`,`date`) USING BTREE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POP 预售绩效表（SKU维度下询单维度）';

        set @sharding = 'sg_pop_shop_team_performance_reserve shop_id hash';
        CREATE TABLE `sg_pop_shop_team_performance_reserve` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺id',
        `date` date DEFAULT NULL COMMENT '时间',
        `title` varchar(255) DEFAULT '' COMMENT '店铺名',
        `direct_receive_num` int(11) unsigned DEFAULT '0' COMMENT '直接接待人数',
        `forward_in_num` int(11) unsigned DEFAULT '0' COMMENT '转入人数',
        `forward_out_num` int(11) unsigned DEFAULT '0' COMMENT '转出人数',
        `consult_num` int(11) unsigned DEFAULT '0' COMMENT '咨询人数',
        `receive_num` int(11) unsigned DEFAULT '0' COMMENT '接待人数',
        `enquiry_num` int(11) unsigned DEFAULT '0' COMMENT '询单人数',
        `ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '询单维度（下单）：\n当日询单， 最终落实下单的人数（最终数据依据，询单有效期）',
        `ordered_goods_num` int(11) unsigned DEFAULT '0' COMMENT '询单维度（下单）：\n当日询单， 最终落实下单的订单的商品数（最终数据依据，询单有效期）',
        `ordered_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '询单维度（下单）：\n当日询单， 最终落实下单的订单的金额（最终数据依据，询单有效期）',
        `paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '询单维度（付款）：\n当日询单，最终落实下单，  并且最终付了款的人数（最终数据依据，询单有效期+付款有效期）\n',
        `paid_goods_num` int(11) unsigned DEFAULT '0' COMMENT '询单维度（付款）：\n当日询单，最终落实下单，  并且最终付了款的订单件数（最终数据依据，询单有效期+付款有效期）',
        `paid_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '询单维度（付款）：\n当日询单，最终落实下单，  并且最终付了款的订单金额（最终数据依据，询单有效期+付款有效期）',
        `reserve_num` int(11) unsigned DEFAULT '0' COMMENT '询单-预约维度：\n预约人数',
        `reserve_ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '询单-预约维度（下单）：\n当日询单， 最终落实下单的人数（最终数据依据，询单有效期）',
        `reserve_ordered_goods_num` int(11) unsigned DEFAULT '0' COMMENT '询单-预约维度（下单）：\n当日询单， 最终落实下单的订单的商品数（最终数据依据，询单有效期）',
        `reserve_ordered_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '询单-预约维度（下单）：\n当日询单， 最终落实下单的订单的金额（最终数据依据，询单有效期）',
        `reserve_paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '询单-预约维度（付款）：\n当日询单，最终落实下单，  并且最终付了款的人数（最终数据依据，询单有效期+付款有效期）\n',
        `reserve_paid_goods_num` int(11) unsigned DEFAULT '0' COMMENT '询单-预约维度（付款）：\n当日询单，最终落实下单，  并且最终付了款的订单件数（最终数据依据，询单有效期+付款有效期）',
        `reserve_paid_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '询单-预约维度（付款）：\n当日询单，最终落实下单，  并且最终付了款的订单金额（最终数据依据，询单有效期+付款有效期）',
        `dept2_code` varchar(20) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(20) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(20) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(20) DEFAULT NULL COMMENT '业务组编号',
        `dept6_code` varchar(20) DEFAULT '' COMMENT '业务岗',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据\n 事业群编码/事业部编码',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POP 预约绩效表（店铺下客服团队维度下的询单维度）';

        set @sharding = 'sg_pop_shop_team_to_performance_presale shop_id hash';
        CREATE TABLE `sg_pop_shop_team_to_performance_presale` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺id',
        `date` date DEFAULT NULL COMMENT '时间',
        `title` varchar(255) DEFAULT '' COMMENT '店铺标题',
        `to_ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单的，下单人数',
        `to_ordered_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单的，下单件数',
        `to_ordered_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单维度：\n促成下单的，下单金额',
        `to_ordered_bargain_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单并最终付款的，付款人数',
        `to_ordered_bargain_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单并最终付款的，付款件数',
        `to_ordered_bargain_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单维度：\n促成下单并最终付款的，付款金额',
        `to_ordered_balance_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单并最终付款的，付款人数',
        `to_ordered_balance_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单并最终付款的，付款件数',
        `to_ordered_balance_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单维度：\n促成下单并最终付款的，付款金额',
        `bargain_balance_buyer_num` int(11) DEFAULT '0' COMMENT '付定金单维度：\\n付付定人数中，最终付了尾款的人数',
        `bargain_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付定金维度：\n付定金人数',
        `bargain_goods_num` int(11) unsigned DEFAULT '0' COMMENT '付定金维度：\n付定金件数',
        `bargain_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '付定金单维度：\n付定金金额',
        `balance_num` int(11) unsigned DEFAULT '0' COMMENT '付尾款维度：\n付尾款人数',
        `balance_goods_num` int(11) unsigned DEFAULT '0' COMMENT '付尾款维度：\n付尾款件数',
        `balance_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '付尾款维度：\n付尾款金额',
        `dept2_code` varchar(20) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(20) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(20) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(20) DEFAULT NULL COMMENT '业务组编号',
        `dept6_code` varchar(20) DEFAULT '' COMMENT '业务岗',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据\n 事业群编码/事业部编码',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POP 预售绩效表（店铺维度下的客服团队的促成下单维度/付定金维度/付尾款维度）';

        set @sharding = 'sg_pop_shop_team_to_performance_reserve shop_id hash';
        CREATE TABLE `sg_pop_shop_team_to_performance_reserve` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺id',
        `date` date DEFAULT NULL COMMENT '时间',
        `title` varchar(255) DEFAULT '' COMMENT '店铺标题',
        `reserve_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '预约维度：\n预约人数',
        `reserve_ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '预约维度：\n预约下单人数',
        `reserve_paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '预约维度：\n预约付款人数',
        `to_ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单的，下单人数',
        `to_ordered_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单的，下单件数',
        `to_ordered_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单维度：\n促成下单的，下单金额',
        `to_ordered_paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单并最终付款的，付款人数',
        `to_ordered_paid_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单并最终付款的，付款件数',
        `to_ordered_paid_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单维度：\n促成下单并最终付款的，付款金额',
        `paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付款维度：\n付款人数',
        `paid_buyer_goods_num` int(11) unsigned DEFAULT '0' COMMENT '付款维度：\n付款件数',
        `paid_buyer_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '付款维度：\n付款金额',
        `dept2_code` varchar(20) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(20) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(20) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(20) DEFAULT NULL COMMENT '业务组编号',
        `dept6_code` varchar(20) DEFAULT '' COMMENT '业务岗',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据\n 事业群编码/事业部编码',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POP 预约绩效表（店铺维度下的客服团队的预约维度/促成下单维度/付款维度）';

        set @sharding = 'sg_pop_shop_use_analysis_collect shop_id hash';
        CREATE TABLE `sg_pop_shop_use_analysis_collect` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `shop_id` bigint(20) unsigned DEFAULT NULL COMMENT '店铺id',
        `date` date DEFAULT NULL COMMENT '时间',
        `title` varchar(100) NOT NULL COMMENT '店铺名',
        `use_convert_pool` tinyint(1) unsigned DEFAULT '0' COMMENT '是否使用待转化池',
        `common_sale_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '普通订单销售额',
        `presale_sale_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '预售订单销售额',
        `reserve_sale_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '预约订单销售额',
        `word_num` int(10) DEFAULT '0' COMMENT '话术数量',
        `all_task_num` int(10) DEFAULT '0' COMMENT '总任务数',
        `allot_valid_task_num` int(10) DEFAULT '0' COMMENT '已分配有效任务数',
        `execute_task_num` int(10) DEFAULT '0' COMMENT '已执行任务数',
        `dd_execute_task_num` int(10) DEFAULT '0' COMMENT '咚咚执行任务数',
        `dd_valid_task_num` int(10) DEFAULT '0' COMMENT '咚咚有效任务数',
        `sms_success_task_num` int(10) DEFAULT '0' COMMENT '短信发送成功任务数',
        `sms_send_task_num` int(10) DEFAULT '0' COMMENT '短信发送任务数',
        `one_remind_clinch_amount` double(20,3) DEFAULT '0.000' COMMENT '一键提醒成交金额',
        `auto_remind_clinch_amount` double(20,3) DEFAULT '0.000' COMMENT '自动提醒成交金额',
        `all_urge_clinch_amount` double(20,3) DEFAULT '0.000' COMMENT '总催付成交金额',
        `redeem_amount` double(20,3) DEFAULT '0.000' COMMENT '挽回金额',
        `un_allot_task_num` int(11) DEFAULT '0' COMMENT '未分配数',
        `un_execute_task_num` int(11) DEFAULT '0' COMMENT '未执行数',
        `dept2_code` varchar(20) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(20) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(20) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(20) DEFAULT NULL COMMENT '三级部门',
        `dept6_code` varchar(20) DEFAULT NULL COMMENT '业务组编号',
        `erp_id` varchar(50) DEFAULT NULL COMMENT 'ERP账号',
        PRIMARY KEY (`id`),
        KEY `idx_shop_date` (`shop_id`,`date`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='POP 催付使用销售汇总表';

        set @sharding = 'sg_pop_shop_use_analysis_detail shop_id hash';
        CREATE TABLE `sg_pop_shop_use_analysis_detail` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `shop_id` bigint(20) unsigned DEFAULT NULL COMMENT '店铺id',
        `date` date DEFAULT NULL COMMENT '时间',
        `title` varchar(100) NOT NULL COMMENT '店铺名',
        `all_task_num` int(10) unsigned DEFAULT '0' COMMENT '总任务数',
        `allot_valid_task_num` int(10) unsigned DEFAULT '0' COMMENT '已分配有效任务数',
        `execute_task_num` int(10) unsigned DEFAULT '0' COMMENT '已执行任务数',
        `dd_execute_task_num` int(10) unsigned DEFAULT '0' COMMENT '咚咚执行任务数',
        `dd_valid_task_num` int(10) unsigned DEFAULT '0' COMMENT '咚咚有效任务数',
        `sms_success_task_num` int(10) unsigned DEFAULT '0' COMMENT '短信发送成功任务数',
        `sms_send_task_num` int(10) unsigned DEFAULT '0' COMMENT '短信发送任务数',
        `one_remind_clinch_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '一键提醒成交金额',
        `auto_remind_clinch_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '自动提醒成交金额',
        `all_urge_clinch_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '总催付成交金额',
        `un_execute_task_num` int(11) DEFAULT '0' COMMENT '未执行数',
        `un_allot_task_num` int(11) DEFAULT '0' COMMENT '未分配数',
        `redeem_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '挽回金额',
        `task_type` tinyint(2) unsigned DEFAULT '0' COMMENT '任务类型：\r\n1.普通 2.预售 3.预约',
        `order_type` tinyint(2) unsigned DEFAULT '0' COMMENT '/**\r\n  * 任务类型\r\n  *   1:咨询未下单\r\n  *   2咨询下单未付款\r\n  *   3静默下单未付款\r\n  *   4：预约咨询未预约\r\n  *   5：预约咨询预约未下单\r\n  *   6：预约静默预约未下单\r\n  *   7：预约咨询未预约未下单(是指在抢购期，针对不预约可以购买的进行\r\n  *     提醒咨询了但在预约期未预约的进行下单)\r\n  *   8: 预约咨询下单未付款\r\n  *   9: 预约静默下单未付款\r\n  *   10: 预售咨询未下单\r\n  *   11: 预售咨询下单未付定金\r\n  *   12: 预售静默下单未付定金金\r\n  *   13: 预售咨询付定金未付尾款\r\n  *   14: 预售静默付定金未付尾款\r\n  */',
        `dept2_code` varchar(20) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(20) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(20) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(20) DEFAULT '' COMMENT '三级部门',
        `dept6_code` varchar(20) DEFAULT '' COMMENT '业务组编号',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        PRIMARY KEY (`id`),
        KEY `idx_shop_date` (`shop_id`,`date`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='POP 催付使用分析详情表';

        set @sharding = 'sg_pop_sku_ov_presale_day shop_id hash';
        CREATE TABLE `sg_pop_sku_ov_presale_day` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `sku_id` bigint(20) unsigned NOT NULL  COMMENT '商品id',
        `sku_name` varchar(200) DEFAULT NULL COMMENT '商品名称',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺ID',
        `title` varchar(255) DEFAULT '' COMMENT '店铺名',
        `date` date DEFAULT NULL COMMENT '时间',
        `ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度:下单人数',
        `ordered_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度:下单件数',
        `ordered_bargain_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单付定金人数',
        `ordered_bargain_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单付定金件数',
        `ordered_bargain_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单付定金金额',
        `ordered_balance_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单付尾款人数',
        `ordered_balance_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单付尾款件数',
        `ordered_balance_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单付尾款金额',
        `bargain_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付定金维度:付定金人数',
        `bargain_goods_num` int(11) unsigned DEFAULT '0' COMMENT '付定金维度:付定金件数',
        `bargain_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '付定金维度:付定金金额',
        `bargain_balance_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付定金维度:付定金后的付尾款人数',
        `balance_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付尾款维度:付尾款人数',
        `balance_goods_num` int(11) unsigned DEFAULT '0' COMMENT '付尾款维度:付尾款件数',
        `balance_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '付尾款维度:付尾款金额',
        `enquiry_ordered_conv_rate` double(20,3) DEFAULT NULL COMMENT '客服促成下单转化',
        `presale_start_time` datetime DEFAULT NULL COMMENT '预售开始时间',
        `presale_end_time` datetime DEFAULT NULL COMMENT '预售结束时间',
        `balance_start_time` datetime DEFAULT NULL COMMENT '尾款开始时间',
        `balance_end_time` datetime DEFAULT NULL COMMENT '尾款结束时间',
        `dept2_code` varchar(20) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(20) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(20) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(20) DEFAULT NULL COMMENT '业务组编号',
        `dept6_code` varchar(20) DEFAULT '' COMMENT '业务岗',
        `category1_code` varchar(20) DEFAULT NULL COMMENT '一级类目',
        `category2_code` varchar(20) DEFAULT NULL COMMENT '二级类目',
        `category3_code` varchar(20) DEFAULT NULL COMMENT '三级类目',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据 事业群编码/事业部编码',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POP 预售订单店铺sku维度每日总览数据表';

        set @sharding = 'sg_pop_sku_ov_reserve_day shop_id hash';
        CREATE TABLE `sg_pop_sku_ov_reserve_day` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `sku_id` bigint(20) NOT NULL COMMENT '商品id',
        `sku_name` varchar(255) DEFAULT NULL COMMENT '商品名称',
        `reserve_group_id` bigint(20) DEFAULT NULL COMMENT '预约组ID',
        `date` date DEFAULT NULL COMMENT '时间',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '商品id',
        `title` varchar(255) DEFAULT '' COMMENT '店铺名',
        `enquiry_ordered_conv_rate` double(20,3) DEFAULT '0.000' COMMENT '客服促成下单转化',
        `reserve_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '预约维度：\n预约人数',
        `reserve_ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '预约维度：\n预约下单人数',
        `reserve_paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '预约维度：\n预约付款人数',
        `ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度:下单人数',
        `ordered_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度:下单件数',
        `ordered_paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单付尾款人数',
        `ordered_paid_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单付尾款件数',
        `ordered_paid_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单付尾款金额',
        `paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付款维度:付款人数',
        `paid_goods_num` int(11) unsigned DEFAULT '0' COMMENT '付款维度:付款件数',
        `paid_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '付款维度:付款金额',
        `reserve_start_time` datetime NOT NULL COMMENT '预约开始时间',
        `reserve_end_time` datetime NOT NULL COMMENT '预约结束时间',
        `rtp_start_time` datetime NOT NULL COMMENT '抢购开始时间',
        `rtp_end_time` datetime NOT NULL COMMENT '抢购结束时间',
        `dept2_code` varchar(20) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(20) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(20) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(20) DEFAULT NULL COMMENT '业务组编号',
        `dept6_code` varchar(20) DEFAULT '' COMMENT '业务岗',
        `category1_code` varchar(20) DEFAULT NULL COMMENT '一级类目',
        `category2_code` varchar(20) DEFAULT NULL COMMENT '二级类目',
        `category3_code` varchar(20) DEFAULT NULL COMMENT '三级类目',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据\n 事业群编码\n/事业部编码',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POP （预约sku维度）SKU每日总览数据表';

        set @sharding = 'sg_pop_sku_performance_presale shop_id hash';
        CREATE TABLE `sg_pop_sku_performance_presale` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `sku_id` bigint(20) NOT NULL COMMENT '商品id',
        `sku_name` varchar(200) NOT NULL DEFAULT '' COMMENT '商品名称',
        `date` date DEFAULT NULL COMMENT '时间',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺ID',
        `title` varchar(255) DEFAULT '' COMMENT '店铺名称',
        `direct_receive_num` int(11) unsigned DEFAULT '0' COMMENT '直接接待人数',
        `forward_in_num` int(11) unsigned DEFAULT '0' COMMENT '转入人数',
        `forward_out_num` int(11) unsigned DEFAULT '0' COMMENT '转出人数',
        `consult_num` int(11) unsigned DEFAULT '0' COMMENT '咨询人数',
        `receive_num` int(11) unsigned DEFAULT '0' COMMENT '接待人数',
        `enquiry_num` int(11) unsigned DEFAULT '0' COMMENT '询单人数',
        `ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '询单维度（下单）：\n当日询单， 最终落实下单的人数（最终数据依据，询单有效期）',
        `ordered_goods_num` int(11) unsigned DEFAULT '0' COMMENT '询单维度（下单）：\n当日询单， 最终落实下单的订单的商品数（最终数据依据，询单有效期）',
        `ordered_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '询单维度（下单）：\n当日询单， 最终落实下单的订单的金额（最终数据依据，询单有效期）',
        `bargain_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '询单维度（定金）：\n当日询单，最终落实下单，  并且最终付了款的人数（最终数据依据，询单有效期+付款有效期）\n',
        `bargain_goods_num` int(11) unsigned DEFAULT '0' COMMENT '询单维度（定金）：\n当日询单，最终落实下单，  并且最终付了款的订单件数（最终数据依据，询单有效期+付款有效期）',
        `bargain_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '询单维度（定金）：\n当日询单，最终落实下单，  并且最终付了款的订单金额（最终数据依据，询单有效期+付款有效期）',
        `balance_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付尾款维度:付尾款人数',
        `balance_goods_num` int(11) unsigned DEFAULT '0' COMMENT '付尾款维度:付尾款件数',
        `balance_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '付尾款维度:付尾款金额',
        `bargain_start_time` datetime NOT NULL COMMENT '定金开始时间',
        `bargain_end_time` datetime NOT NULL COMMENT '预售结束时间',
        `balance_start_time` datetime NOT NULL COMMENT '尾款开始时间',
        `balance_end_time` datetime NOT NULL COMMENT '尾款结束时间',
        `to_bargain_buyer_num` int(11) DEFAULT '0' COMMENT '落实付定金人数',
        `to_bargain_balance_buyer_num` int(11) DEFAULT '0' COMMENT '落实付尾款人数',
        `dept2_code` varchar(20) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(20) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(20) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(20) DEFAULT NULL COMMENT '三级部门编码',
        `dept6_code` varchar(20) DEFAULT '' COMMENT '业务组编号',
        `category1_code` varchar(20) DEFAULT NULL COMMENT '一级类目',
        `category2_code` varchar(20) DEFAULT NULL COMMENT '二级类目',
        `category3_code` varchar(20) DEFAULT NULL COMMENT '三级类目',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据\n 事业群编码\n/事业部编码',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`),
        KEY `idx_shop_cs_date` (`shop_id`,`date`) USING BTREE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POP 预售绩效表（SKU维度下询单维度）';

        set @sharding = 'sg_pop_sku_performance_reserve shop_id hash';
        CREATE TABLE `sg_pop_sku_performance_reserve` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺ID',
        `date` date DEFAULT NULL COMMENT '时间',
        `sku_id` bigint(20) unsigned NOT NULL COMMENT '商品id',
        `sku_name` varchar(200) NOT NULL DEFAULT '' COMMENT '商品名称',
        `title` varchar(255) DEFAULT '' COMMENT '店铺名',
        `reserve_group_id` bigint(20) unsigned DEFAULT '0' COMMENT '预约组ID',
        `direct_receive_num` int(11) unsigned DEFAULT '0' COMMENT '直接接待人数',
        `forward_in_num` int(11) unsigned DEFAULT '0' COMMENT '转入人数',
        `forward_out_num` int(11) unsigned DEFAULT '0' COMMENT '转出人数',
        `consult_num` int(11) unsigned DEFAULT '0' COMMENT '咨询人数',
        `receive_num` int(11) unsigned DEFAULT '0' COMMENT '接待人数',
        `enquiry_num` int(11) unsigned DEFAULT '0' COMMENT '询单人数',
        `ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '询单维度（下单）：\n当日询单， 最终落实下单的人数（最终数据依据，询单有效期）',
        `ordered_goods_num` int(11) unsigned DEFAULT '0' COMMENT '询单维度（下单）：\n当日询单， 最终落实下单的订单的商品数（最终数据依据，询单有效期）',
        `ordered_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '询单维度（下单）：\n当日询单， 最终落实下单的订单的金额（最终数据依据，询单有效期）',
        `paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '询单维度（付款）：\n当日询单，最终落实下单，  并且最终付了款的人数（最终数据依据，询单有效期+付款有效期）\n',
        `paid_goods_num` int(11) unsigned DEFAULT '0' COMMENT '询单维度（付款）：\n当日询单，最终落实下单，  并且最终付了款的订单件数（最终数据依据，询单有效期+付款有效期）',
        `paid_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '询单维度（付款）：\n当日询单，最终落实下单，  并且最终付了款的订单金额（最终数据依据，询单有效期+付款有效期）',
        `reserve_num` int(11) unsigned DEFAULT '0' COMMENT '询单-预约维度：\n预约人数',
        `reserve_ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '询单-预约维度（下单）：\n当日询单， 最终落实下单的人数（最终数据依据，询单有效期）',
        `reserve_ordered_goods_num` int(11) unsigned DEFAULT '0' COMMENT '询单-预约维度（下单）：\n当日询单， 最终落实下单的订单的商品数（最终数据依据，询单有效期）',
        `reserve_ordered_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '询单-预约维度（下单）：\n当日询单， 最终落实下单的订单的金额（最终数据依据，询单有效期）',
        `reserve_paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '询单-预约维度（付款）：\n当日询单，最终落实下单，  并且最终付了款的人数（最终数据依据，询单有效期+付款有效期）\n',
        `reserve_paid_goods_num` int(11) unsigned DEFAULT '0' COMMENT '询单-预约维度（付款）：\n当日询单，最终落实下单，  并且最终付了款的订单件数（最终数据依据，询单有效期+付款有效期）',
        `reserve_paid_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '询单-预约维度（付款）：\n当日询单，最终落实下单，  并且最终付了款的订单金额（最终数据依据，询单有效期+付款有效期）',
        `reserve_start_time` datetime NOT NULL COMMENT '预约开始时间',
        `reserve_end_time` datetime NOT NULL COMMENT '预约结束时间',
        `rtp_start_time` datetime NOT NULL COMMENT '抢购开始时间',
        `rtp_end_time` datetime NOT NULL COMMENT '抢购结束时间',
        `dept2_code` varchar(20) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(20) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(20) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(20) DEFAULT NULL COMMENT '三级部门编码',
        `dept6_code` varchar(20) DEFAULT NULL COMMENT '业务组编号',
        `category1_code` varchar(20) DEFAULT NULL COMMENT '一级类目',
        `category2_code` varchar(20) DEFAULT NULL COMMENT '二级类目',
        `category3_code` varchar(20) DEFAULT NULL COMMENT '三级类目',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据 事业群\n编码/事业部编码',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`),
        KEY `idx_sku_date` (`sku_id`,`date`) USING BTREE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POP 预约绩效表（SKU维度下询单维度）';

        set @sharding = 'sg_pop_sku_sov_presale_day shop_id hash';
        CREATE TABLE `sg_pop_sku_sov_presale_day` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺ID',
        `sku_id` bigint(20) unsigned NOT NULL COMMENT '商品ID',
        `sku_name` varchar(255) DEFAULT NULL COMMENT '商品名称',
        `title` varchar(255) DEFAULT '' COMMENT '店铺名',
        `date` date DEFAULT NULL COMMENT '时间',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        `ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度:下单人数',
        `ordered_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度:下单件数',
        `ordered_bargain_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单付定金人数',
        `ordered_bargain_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单付定金件数',
        `ordered_bargain_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单付定金金额',
        `ordered_balance_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单付尾款人数',
        `ordered_balance_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单付尾款件数',
        `ordered_balance_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单付尾款金额',
        `bargain_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付定金维度:付定金人数',
        `bargain_goods_num` int(11) unsigned DEFAULT '0' COMMENT '付定金维度:付定金件数',
        `bargain_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '付定金维度:付定金金额',
        `bargain_balance_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付定金维度:付定金后的付尾款人数',
        `balance_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付尾款维度:付尾款人数',
        `balance_goods_num` int(11) unsigned DEFAULT '0' COMMENT '付尾款维度:付尾款件数',
        `balance_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '付尾款维度:付尾款金额',
        `presale_start_time` datetime DEFAULT NULL COMMENT '预售开始时间',
        `presale_end_time` datetime DEFAULT NULL COMMENT '预售结束时间',
        `balance_start_time` datetime DEFAULT NULL COMMENT '尾款开始时间',
        `balance_end_time` datetime DEFAULT NULL COMMENT '尾款结束时间',
        `dept2_code` varchar(20) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(20) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(20) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(20) DEFAULT NULL COMMENT '三级部门编码',
        `dept6_code` varchar(20) DEFAULT NULL COMMENT '业务组编号',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据\n 事业群\n编码/事业部编码',
        `category1_code` varchar(20) DEFAULT NULL COMMENT '一级类目',
        `category2_code` varchar(20) DEFAULT NULL COMMENT '二级类目',
        `category3_code` varchar(20) DEFAULT NULL COMMENT '三级类目',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POP（预售sku维度）SKU每日静默总览数据表';

        set @sharding = 'sg_pop_sku_sov_reserve_day shop_id hash';
        CREATE TABLE `sg_pop_sku_sov_reserve_day` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `sku_id` bigint(20) unsigned NOT NULL COMMENT '商品id',
        `sku_name` varchar(200) DEFAULT NULL COMMENT '商品名称',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        `reserve_group_id` bigint(20) unsigned DEFAULT NULL COMMENT '预约组ID',
        `date` date DEFAULT NULL COMMENT '时间',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '商品id',
        `title` varchar(200) NOT NULL COMMENT '商品名',
        `reserve_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '预约维度：\n预约人数',
        `reserve_ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '预约维度：\n预约下单人数',
        `reserve_paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '预约维度：\n预约付款人数',
        `ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度:下单人数',
        `ordered_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度:下单件数',
        `ordered_paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单付尾款人数',
        `ordered_paid_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单付尾款件数',
        `ordered_paid_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单付尾款金额',
        `paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付款维度:付款人数',
        `paid_goods_num` int(11) unsigned DEFAULT '0' COMMENT '付款维度:付款件数',
        `paid_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '付款维度:付款金额',
        `reserve_start_time` datetime NOT NULL COMMENT '预约开始时间',
        `reserve_end_time` datetime NOT NULL COMMENT '预约结束时间',
        `rtp_start_time` datetime NOT NULL COMMENT '抢购开始时间',
        `rtp_end_time` datetime NOT NULL COMMENT '抢购结束时间',
        `dept2_code` varchar(20) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(20) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(20) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(20) DEFAULT NULL COMMENT '业务组编号',
        `dept6_code` varchar(20) DEFAULT '' COMMENT '业务岗编号',
        `category1_code` varchar(20) DEFAULT NULL COMMENT '一级类目',
        `category2_code` varchar(20) DEFAULT NULL COMMENT '二级类目',
        `category3_code` varchar(20) DEFAULT NULL COMMENT '三级类目',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据 事业群\n编码/事业部编码',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POP （预约sku维度）SKU每日静默总览数据表';

        set @sharding = 'sg_pop_sku_to_performance_presale shop_id hash';
        CREATE TABLE `sg_pop_sku_to_performance_presale` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `sku_id` bigint(20) unsigned NOT NULL COMMENT '商品ID',
        `sku_name` varchar(200) DEFAULT NULL COMMENT '商品名称',
        `title` varchar(255) DEFAULT '' COMMENT '店铺名称',
        `date` date DEFAULT NULL COMMENT '时间',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '商品ID',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据\n 事业群编码/事业部编码',
        `to_ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单的，下单人数',
        `to_ordered_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单的，下单件数',
        `to_ordered_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单维度：\n促成下单的，下单金额',
        `to_ordered_bargain_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单并最终付款的，付款人数\n（*保留字段）',
        `to_ordered_bargain_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单并最终付款的，付款件数\n（*保留字段）',
        `to_ordered_bargain_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单维度：\n促成下单并最终付款的，付款金额\n（*保留字段）',
        `to_ordered_balance_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单并最终付款的，付款人数\n（*保留字段）',
        `to_ordered_balance_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单并最终付款的，付款件数\n（*保留字段）',
        `to_ordered_balance_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单维度：\n促成下单并最终付款的，付款金额\n（*保留字段）',
        `to_bargain_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付定金维度：\n付定金人数',
        `to_bargain_goods_num` int(11) unsigned DEFAULT '0' COMMENT '付定金维度：\n付定金件数',
        `to_bargain_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '付定金单维度：\n付定金金额',
        `to_bargain_balance_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付定金维度：\n付定金人数里最终付了尾款的人数',
        `to_balance_num` int(11) unsigned DEFAULT '0' COMMENT '付尾款维度：\n付尾款人数\n（*保留字段）',
        `to_balance_goods_num` int(11) unsigned DEFAULT '0' COMMENT '付尾款维度：\n付尾款件数\n（*保留字段）',
        `to_balance_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '付尾款维度：\n付尾款金额\n（*保留字段）',
        `bargain_start_time` datetime NOT NULL COMMENT '定金开始时间',
        `bargain_end_time` datetime NOT NULL COMMENT '预售结束时间',
        `balance_start_time` datetime NOT NULL COMMENT '尾款开始时间',
        `balance_end_time` datetime NOT NULL COMMENT '尾款结束时间',
        `dept2_code` varchar(20) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(20) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(20) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(20) DEFAULT NULL COMMENT '三级部门编码',
        `dept6_code` varchar(20) DEFAULT NULL COMMENT '业务组编号',
        `category1_code` varchar(20) DEFAULT NULL COMMENT '一级类目',
        `category2_code` varchar(20) DEFAULT NULL COMMENT '二级类目',
        `category3_code` varchar(20) DEFAULT NULL COMMENT '三级类目',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POP 预售绩效表（SKU维度下的促成下单维度/付定金维度/付尾款维度）';

        set @sharding = 'sg_pop_sku_to_performance_reserve shop_id hash';
        CREATE TABLE `sg_pop_sku_to_performance_reserve` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `sku_id` bigint(20) unsigned NOT NULL COMMENT '商品ID',
        `sku_name` varchar(200) DEFAULT '' COMMENT '商品名称',
        `erp_id` varchar(50) DEFAULT NULL COMMENT 'ERP账号',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据\n 事业群编码/事业部编码',
        `reserve_group_id` bigint(20) unsigned NOT NULL COMMENT '预约组ID',
        `title` varchar(255) DEFAULT '' COMMENT '店铺标题',
        `date` date DEFAULT NULL COMMENT '时间',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '商品ID',
        `reserve_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '预约维度：\n预约人数',
        `reserve_ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '预约维度：\n预约下单人数',
        `reserve_paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '预约维度：\n预约付款人数',
        `to_ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单的，下单人数',
        `to_ordered_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单的，下单件数',
        `to_ordered_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单维度：\n促成下单的，下单金额',
        `to_ordered_paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单并最终付款的，付款人数',
        `to_ordered_paid_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单并最终付款的，付款件数',
        `to_ordered_paid_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单维度：\n促成下单并最终付款的，付款金额',
        `to_paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付款维度：\n付款人数',
        `to_paid_buyer_goods_num` int(11) unsigned DEFAULT '0' COMMENT '付款维度：\n付款件数',
        `to_paid_buyer_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '付款维度：\n付款金额',
        `reserve_start_time` datetime NOT NULL COMMENT '预约开始时间',
        `reserve_end_time` datetime NOT NULL COMMENT '预约结束时间',
        `rtp_start_time` datetime NOT NULL COMMENT '抢购开始时间',
        `rtp_end_time` datetime NOT NULL COMMENT '抢购结束时间',
        `dept2_code` varchar(20) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(20) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(20) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(20) DEFAULT NULL COMMENT '三级部门编码',
        `dept6_code` varchar(20) DEFAULT NULL COMMENT '业务组编号',
        `category1_code` varchar(20) DEFAULT NULL COMMENT '一级类目',
        `category2_code` varchar(20) DEFAULT NULL COMMENT '二级类目',
        `category3_code` varchar(20) DEFAULT NULL COMMENT '三级类目',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POP 预约绩效表（SKU维度下的预约维度/促成下单维度/付款维度）';

        set @sharding = 'sg_pop_syn_mf_shop_record singleShard';
        CREATE TABLE `sg_pop_syn_mf_shop_record` (
        `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `date` datetime DEFAULT NULL COMMENT '日期',
        `title` varchar(255) DEFAULT '' COMMENT '店铺名称',
        `shop_id` bigint(20) DEFAULT '0' COMMENT '店铺ID',
        `result` tinyint(2) DEFAULT '0' COMMENT '0:失败,1：成功',
        `syn_word` tinyint(2) DEFAULT NULL COMMENT '同步话术',
        `syn_word_setting` tinyint(2) DEFAULT NULL COMMENT '同步话术设置',
        `syn_remind_detail` tinyint(2) DEFAULT NULL COMMENT '同步魔方催付话术',
        `msg` varchar(255) DEFAULT NULL COMMENT '失败原因',
        `consume_time` bigint(20) DEFAULT NULL COMMENT '店铺数据处理消耗的时长',
        `op_time` datetime DEFAULT NULL COMMENT '操作时间',
        `run_status` tinyint(2) DEFAULT '0' COMMENT '0:未执行,1:执行成功,2:执行中,4:执行失败',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '数据创建时间',
        `modified` datetime DEFAULT NULL COMMENT '修改时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '1:有效,0:无效',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='POP 魔方数据同步记录';

        set @sharding = 'sg_pop_sysetting_base singleShard';
        CREATE TABLE `sg_pop_sysetting_base` (
        `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
        `dept_code` varchar(20) DEFAULT '0' COMMENT '部门ID（指向事业部）',
        `dept_type` int(11) unsigned DEFAULT '0' COMMENT '部门类型（1:事业群 2:事业部）',
        `aftersell_acount_filter` tinyint(2) DEFAULT '0' COMMENT '售后账号不参与过滤',
        `sell_after` int(11) unsigned DEFAULT '0' COMMENT '售后天数（天:3-180）',
        `max_wait_time` int(11) unsigned DEFAULT '0' COMMENT '最长等待时间(分钟)',
        `slow_response_time` int(11) unsigned DEFAULT '0' COMMENT '慢响应时间（慢响应设设定）',
        `slow_response_times_num` int(11) unsigned DEFAULT '0' COMMENT '慢响应次数（慢响应设设定）',
        `quick_response_time` int(11) unsigned DEFAULT '0' COMMENT '快速应答设定（秒）',
        `long_reception_time` int(11) unsigned DEFAULT '0' COMMENT '长接待设定',
        `scheduling_time_dot` int(11) unsigned DEFAULT '0' COMMENT '业务天分割点',
        `cs_recommend_switch` tinyint(2) DEFAULT '0' COMMENT '客服推荐关键字匹配-开关',
        `cs_recommend_mark` varchar(255) DEFAULT '' COMMENT '客服推荐关键字\r\n开启本功能后，客服发送商品链接时需要以关键字开头，才会判断为客服推荐。',
        `duty_record_export_unit` int(1) unsigned DEFAULT '0' COMMENT '值班记录导出时长单位设置（分钟/秒）',
        `silent_all_follow_up_switch` tinyint(2) DEFAULT '0' COMMENT '全静默开关',
        `duty_rid_cs_switch` tinyint(2) DEFAULT '0' COMMENT '值班记录剔除未上班客服',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `modified` datetime DEFAULT NULL COMMENT '修改时间',
        `modified_by` varchar(255) DEFAULT '' COMMENT '修改人',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='POP 导购 > 系统设置 > 基础设置';


        set @sharding = 'sg_pop_sysetting_pes singleShard';
        CREATE TABLE `sg_pop_sysetting_pes` (
        `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
        `dept_code` varchar(20) DEFAULT '0' COMMENT '部门ID（指向事业部）',
        `dept_type` int(11) unsigned DEFAULT '0' COMMENT '部门类型（指向事业部）',
        `judge_rule_ascription` tinyint(4) unsigned DEFAULT '0' COMMENT '订单归属规则（1:聊天时间判定归属,2:回合数判定归属）',
        `judge_rule` tinyint(4) unsigned DEFAULT '0' COMMENT '绩效判定规则（1:下单判定,2:下单优先判定,3:付款判定）',
        `enquiry_valid_duration_time` tinyint(4) unsigned DEFAULT '0' COMMENT '询单有效时长（天:2-15）',
        `out_stock_valid_duration_time` tinyint(4) unsigned DEFAULT '0' COMMENT '出库有效时长（天:2-15）',
        `silent_all_switch` tinyint(2) DEFAULT '0' COMMENT '全静默订单跟进统计-开关',
        `silent_all_follow_up_time` tinyint(4) unsigned DEFAULT '0' COMMENT '全静默订单跟进业绩统计 \r\n付款(1-60)分钟内跟进有效',
        `silent_all_follow_up_switch` tinyint(2) DEFAULT '0' COMMENT '全静默订单跟进统计;算客服绩效，不算客服绩效 -开关',
        `cs_to_csut_first_lost_switch` tinyint(2) DEFAULT '0' COMMENT '客服主动联系不算询单流失-开关',
        `cust_first_reply_day` tinyint(4) unsigned DEFAULT '0' COMMENT '客服主动联系不算询单流失\\n买家首次回复识别天数(1-5天)\\n默认2天',
        `silent_urgepay_switch` tinyint(2) DEFAULT '0' COMMENT '静默下单催付时间限制',
        `silent_urgepay_time` tinyint(4) unsigned DEFAULT '0' COMMENT '静默下单后在（1-60）分钟内客服跟进无效',
        `order_flag_switch` tinyint(2) DEFAULT '0' COMMENT '指定订单不算客服业绩（插旗）-开关',
        `order_flag` tinyint(4) unsigned DEFAULT '0' COMMENT '插旗过滤旗帜',
        `enquiry_loss_switch` tinyint(2) DEFAULT '0' COMMENT '跨天聊天只算一次询单流失',
        `cs_forward_aftersell_switch` tinyint(2) DEFAULT '0' COMMENT '转售后客服不算询单人数',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `modified` datetime DEFAULT NULL COMMENT '修改时间',
        `modified_by` varchar(255) DEFAULT '' COMMENT '修改人',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='POP 导购 > 系统设置 > 绩效设置';

        set @sharding = 'sg_pop_sysetting_receive singleShard';
        CREATE TABLE `sg_pop_sysetting_receive` (
        `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `dept_code` varchar(20) DEFAULT '0' COMMENT '部门ID（指向事业部）',
        `team_chat_filte_switch` tinyint(2) DEFAULT '0' COMMENT '自家账号过滤',
        `sys_cs_chat_filte_switch` tinyint(2) DEFAULT '0' COMMENT '绩效软件客服过滤',
        `non_chat_filte_switch` tinyint(2) DEFAULT '0' COMMENT '空聊天过滤',
        `chose_cs_filte_switch` tinyint(2) DEFAULT '0' COMMENT '指定客服过滤',
        `cs_forward_switch` tinyint(2) DEFAULT '0' COMMENT '客服转发过滤-开关',
        `cs_forward_num` tinyint(4) unsigned DEFAULT '0' COMMENT '客服转发过滤句数\r\n客服最多回复（0-10）句（含）',
        `cs_watchword_switch` tinyint(2) DEFAULT '0' COMMENT '暗语过滤-开关',
        `cs_watchword` varchar(255) DEFAULT '' COMMENT '暗语关键词(1-50个字)',
        `cs_watchword_send_times_num` tinyint(4) unsigned DEFAULT '0' COMMENT '设置客服暗语{}，发送（1-10）次（含）以上过滤',
        `main_account_auto_reply_switch` tinyint(2) DEFAULT '0' COMMENT '主账号回复过滤-开关',
        `main_account_auto_reply_content` varchar(255) DEFAULT '' COMMENT '主号自动回复内容',
        `cust_sigchat_switch` tinyint(2) DEFAULT '0' COMMENT '顾客单句过滤-开关',
        `sigchat_min_reply_num` tinyint(4) DEFAULT '0' COMMENT '顾客咨询客服一句，客服回复指定句数以上\\n(客服最少回复句数{}（含）)',
        `cs_single_chat_filter` tinyint(2) DEFAULT '0' COMMENT '客服单口相声过滤',
        `cust_single_chat_num` tinyint(4) unsigned DEFAULT '0' COMMENT '客户回复{}句 以内，不算接待',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `modified` datetime DEFAULT NULL COMMENT '修改时间',
        `modified_by` varchar(255) DEFAULT NULL COMMENT '修改人',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='POP 导购 > 系统设置 > 接待过滤';


        set @sharding = 'sg_pop_systemsetting_fieid_limit singleShard';
        CREATE TABLE `sg_pop_systemsetting_fieid_limit` (
        `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
        `dept_code` varchar(20) NOT NULL COMMENT '部门编码',
        `enquiry_valid_duration_time` int(11) DEFAULT NULL COMMENT '询单有效时长验证',
        `out_stock_valid_duration_time` int(11) DEFAULT NULL COMMENT '出库有效时长验证',
        `modify_enquiry_out_stock` date DEFAULT NULL COMMENT '修改时间（询单、出库）',
        PRIMARY KEY (`id`) USING BTREE
        ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='POP 系统设置字段修改限制表';


        set @sharding = 'sg_pop_ultra_power singleShard';
        CREATE TABLE `sg_pop_ultra_power` (
        `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `erp_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'ERP账号',
        `dept_type` tinyint(255) unsigned NOT NULL DEFAULT '0' COMMENT '部门类别（2:事业群,3:事业部,4:二级部门,5三级部门,6:业务组）',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `modified` datetime DEFAULT NULL COMMENT '修改时间',
        `modified_by` varchar(255) DEFAULT '' COMMENT '修改人',
        `yn` tinyint(1) DEFAULT '0' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`) USING BTREE,
        UNIQUE KEY `uniq_erp_id` (`erp_id`) USING BTREE
        ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='POP 特殊权限用户表';

        set @sharding = 'sg_pop_ware_category singleShard';
        CREATE TABLE `sg_pop_ware_category` (
        `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `vender_id` bigint(20) unsigned NOT NULL COMMENT '商家编号',
        `category_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '类目id',
        `category_name` varchar(500) NOT NULL COMMENT '类目名称',
        `parent_id` bigint(20) unsigned DEFAULT '0' COMMENT '父id',
        `category_level` tinyint(2) unsigned DEFAULT NULL COMMENT '类目级别',
        `yn` tinyint(2) NOT NULL DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`),
        KEY `idx_shop` (`vender_id`) USING BTREE
        ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='POP 类目表';

        set @sharding = 'sg_pop_xxl_job_group singleShard';
        CREATE TABLE `sg_pop_xxl_job_group` (
        `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `app_name` varchar(64) NOT NULL COMMENT '执行器AppName',
        `title` varchar(12) NOT NULL COMMENT '执行器名称',
        `order` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
        `address_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '执行器地址类型：0=自动注册、1=手动录入',
        `address_list` varchar(512) DEFAULT NULL COMMENT '执行器地址列表，多地址逗号分隔',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='POP job分组表';

        set @sharding = 'sg_pop_xxl_job_info singleShard';
        CREATE TABLE `sg_pop_xxl_job_info` (
        `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
        `job_cron` varchar(128) NOT NULL COMMENT '任务执行CRON',
        `job_desc` varchar(255) NOT NULL COMMENT '任务详情',
        `add_time` datetime DEFAULT NULL COMMENT '添加时间',
        `update_time` datetime DEFAULT NULL COMMENT '更新时间',
        `author` varchar(64) DEFAULT NULL COMMENT '作者',
        `alarm_email` varchar(255) DEFAULT NULL COMMENT '报警邮件',
        `executor_route_strategy` varchar(50) DEFAULT NULL COMMENT '执行器路由策略',
        `executor_handler` varchar(255) DEFAULT NULL COMMENT '执行器任务handler',
        `executor_param` varchar(512) DEFAULT NULL COMMENT '执行器任务参数',
        `executor_block_strategy` varchar(50) DEFAULT NULL COMMENT '阻塞处理策略',
        `executor_timeout` int(11) NOT NULL DEFAULT '0' COMMENT '任务执行超时时间，单位秒',
        `executor_fail_retry_count` int(11) NOT NULL DEFAULT '0' COMMENT '失败重试次数',
        `glue_type` varchar(50) NOT NULL COMMENT 'GLUE类型',
        `glue_source` mediumtext COMMENT 'GLUE源代码',
        `glue_remark` varchar(128) DEFAULT NULL COMMENT 'GLUE备注',
        `glue_updatetime` datetime DEFAULT NULL COMMENT 'GLUE更新时间',
        `child_jobid` varchar(255) DEFAULT NULL COMMENT '子任务ID，多个逗号分隔',
        `trigger_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '调度状态：0-停止，1-运行',
        `trigger_last_time` bigint(13) NOT NULL DEFAULT '0' COMMENT '上次调度时间',
        `trigger_next_time` bigint(13) NOT NULL DEFAULT '0' COMMENT '下次调度时间',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='POP job分组信息表';

        set @sharding = 'sg_pop_xxl_job_lock singleShard';
        CREATE TABLE `sg_pop_xxl_job_lock` (
        `lock_name` varchar(50) NOT NULL COMMENT '锁名称',
        PRIMARY KEY (`lock_name`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='POP job锁信息表';


        set @sharding = 'sg_pop_xxl_job_log singleShard';
        CREATE TABLE `sg_pop_xxl_job_log` (
        `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
        `job_id` int(11) NOT NULL COMMENT '任务，主键ID',
        `executor_address` varchar(255) DEFAULT NULL COMMENT '执行器地址，本次执行的地址',
        `executor_handler` varchar(255) DEFAULT NULL COMMENT '执行器任务handler',
        `executor_param` varchar(512) DEFAULT NULL COMMENT '执行器任务参数',
        `executor_sharding_param` varchar(20) DEFAULT NULL COMMENT '执行器任务分片参数，格式如 1/2',
        `executor_fail_retry_count` int(11) NOT NULL DEFAULT '0' COMMENT '失败重试次数',
        `trigger_time` datetime DEFAULT NULL COMMENT '调度-时间',
        `trigger_code` int(11) NOT NULL COMMENT '调度-结果',
        `trigger_msg` text COMMENT '调度-日志',
        `handle_time` datetime DEFAULT NULL COMMENT '执行-时间',
        `handle_code` int(11) NOT NULL COMMENT '执行-状态',
        `handle_msg` text COMMENT '执行-日志',
        `alarm_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '告警状态：0-默认、1-无需告警、2-告警成功、3-告警失败',
        PRIMARY KEY (`id`),
        KEY `idx_I_trigger_time` (`trigger_time`),
        KEY `idx_I_handle_code` (`handle_code`)
        ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='POP job日志表';

        set @sharding = 'sg_pop_xxl_job_log_report singleShard';
        CREATE TABLE `sg_pop_xxl_job_log_report` (
        `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `trigger_day` datetime DEFAULT NULL COMMENT '调度-时间',
        `running_count` int(11) NOT NULL DEFAULT '0' COMMENT '运行中-日志数量',
        `suc_count` int(11) NOT NULL DEFAULT '0' COMMENT '执行成功-日志数量',
        `fail_count` int(11) NOT NULL DEFAULT '0' COMMENT '执行失败-日志数量',
        PRIMARY KEY (`id`),
        UNIQUE KEY `uniq_i_trigger_day` (`trigger_day`) USING BTREE
        ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='POP job日志报表';

        set @sharding = 'sg_pop_xxl_job_logglue singleShard';
        CREATE TABLE `sg_pop_xxl_job_logglue` (
        `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `job_id` int(11) NOT NULL COMMENT '任务，主键ID',
        `glue_type` varchar(50) DEFAULT NULL COMMENT 'GLUE类型',
        `glue_source` mediumtext COMMENT 'GLUE源代码',
        `glue_remark` varchar(128) NOT NULL COMMENT 'GLUE备注',
        `add_time` datetime DEFAULT NULL COMMENT '添加时间',
        `update_time` datetime DEFAULT NULL COMMENT '修改时间',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='POP job运行模式表';


        set @sharding = 'sg_pop_xxl_job_registry singleShard';
        CREATE TABLE `sg_pop_xxl_job_registry` (
        `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `registry_group` varchar(50) NOT NULL COMMENT '分组信息',
        `registry_key` varchar(255) NOT NULL COMMENT '注册key',
        `registry_value` varchar(255) NOT NULL COMMENT '注册value',
        `update_time` datetime DEFAULT NULL COMMENT '修改时间',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='POP job注册表';


        set @sharding = 'sg_pop_xxl_job_user singleShard';
        CREATE TABLE `sg_pop_xxl_job_user` (
        `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `username` varchar(50) NOT NULL COMMENT '账号',
        `password` varchar(50) NOT NULL COMMENT '密码',
        `role` tinyint(4) NOT NULL COMMENT '角色：0-普通用户、1-管理员',
        `permission` varchar(255) DEFAULT NULL COMMENT '权限：执行器ID列表，多个逗号分割',
        PRIMARY KEY (`id`),
        UNIQUE KEY `uniq_i_username` (`username`) USING BTREE
        ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='POP job用户表';

        set @sharding = 'sg_self_chat_peer_sku_presale shop_id hash';
        CREATE TABLE `sg_self_chat_peer_sku_presale` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺Id',
        `date` date DEFAULT NULL COMMENT '聊天日期',
        `cs_nick` varchar(50) NOT NULL COMMENT '客服昵称',
        `customer` varchar(50) NOT NULL COMMENT '顾客pin',
        `sku_id` bigint(20) unsigned NOT NULL COMMENT '顾客咨询的sku/客服推荐的skuId',
        `cs_chat_first_flag` tinyint(2) DEFAULT '0' COMMENT '0:非正常聊天\\n1:主动联系\\n2::非主动',
        `sku_name` varchar(500) DEFAULT '' COMMENT '商品名称',
        `type` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '类型 1:客服推荐 2：顾客咨询',
        `forward_type` tinyint(2) DEFAULT '0' COMMENT '转入：1,\n转出：2 ，\n非转发：0\n转接:3',
        `chat_flag` tinyint(2) unsigned DEFAULT '0' COMMENT '0:正常咨询  \n1:空聊天 \n2:团队内部过滤 \n3: 绩效系统客服过滤 \n4: 平台客服过滤 ',
        `is_cross_chat_filter` tinyint(2) DEFAULT '0' COMMENT '跨天聊天过滤',
        `cross_chat_flag` tinyint(2) unsigned DEFAULT '0' COMMENT '跨天聊天标识：默认0，无跨天聊天\n1：0点击前最长等待时间内有聊天\n2：0点前后最长等待时间内有聊天\n',
        `is_consult` tinyint(2) DEFAULT '0' COMMENT '是否是 咨询客户',
        `is_receive` tinyint(2) DEFAULT '0' COMMENT '是否是 接待的客户',
        `is_enquiry` tinyint(2) DEFAULT '0' COMMENT '是否是询单的顾客',
        `is_order_created` tinyint(2) DEFAULT '0' COMMENT '买家有下单',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据 事业群编码/事业部编码',
        `erp_id` varchar(50) NOT NULL DEFAULT '' COMMENT 'ERP账号',
        `is_after_sale` tinyint(2) DEFAULT '0' COMMENT '售后咨询',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`),
        KEY `idx_shop_date` (`shop_id`,`date`) USING BTREE,
        KEY `idx_shop_cs_date` (`shop_id`,`cs_nick`,`date`) USING BTREE,
        KEY `idx_shop_buyer_date` (`shop_id`,`customer`,`date`) USING BTREE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='self预售聊天对象表';

        set @sharding = 'sg_self_chat_peer_sku_reserve shop_id hash';
        CREATE TABLE `sg_self_chat_peer_sku_reserve` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺Id',
        `date` date DEFAULT NULL COMMENT '聊天日期',
        `cs_nick` varchar(50) NOT NULL COMMENT '客服昵称',
        `customer` varchar(50) NOT NULL COMMENT '顾客pin',
        `sku_id` bigint(20) unsigned NOT NULL COMMENT '顾客咨询的sku/客服推荐的skuId',
        `sku_name` varchar(500) DEFAULT '' COMMENT '商品名称',
        `type` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '类型 1:客服推荐 2：顾客咨询',
        `forward_type` tinyint(2) DEFAULT '0' COMMENT '转入：1,\n转出：2 ，\n非转发：0\n转接:3',
        `chat_flag` tinyint(2) unsigned DEFAULT '0' COMMENT '0:正常咨询  \n1:空聊天 \n2:团队内部过滤 \n3: 绩效系统客服过滤 \n4: 平台客服过滤 ',
        `is_cross_chat_filter` tinyint(2) DEFAULT '0' COMMENT '跨天聊天过滤',
        `cs_chat_first_flag` tinyint(2) DEFAULT '0' COMMENT '0:非正常聊天\\n1:主动联系\\n2::非主动',
        `cross_chat_flag` tinyint(2) unsigned DEFAULT '0' COMMENT '跨天聊天标识：默认0，无跨天聊天\n1：0点击前最长等待时间内有聊天\n2：0点前后最长等待时间内有聊天\n',
        `is_consult` tinyint(2) DEFAULT '0' COMMENT '是否是 咨询客户',
        `is_receive` tinyint(2) DEFAULT '0' COMMENT '是否是 接待的客户',
        `is_reserve` tinyint(2) DEFAULT '0' COMMENT '预约周期内，用户是否预约了 1 是  2 不是 0 默认值',
        `is_enquiry` tinyint(2) DEFAULT '0' COMMENT '是否是询单的顾客',
        `is_after_sale` tinyint(2) DEFAULT '0' COMMENT '售后咨询',
        `is_order_created` tinyint(2) DEFAULT '0' COMMENT '买家有下单',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据 事业群编码/事业部编码',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`),
        KEY `idx_shop_date` (`shop_id`,`date`) USING BTREE,
        KEY `idx_shop_cs_date` (`shop_id`,`cs_nick`,`date`) USING BTREE,
        KEY `idx_shop_buyer_date` (`shop_id`,`customer`,`date`) USING BTREE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='self预约聊天对象表';

        set @sharding = 'sg_self_cs_order_sku_bind_presale shop_id hash';
        CREATE TABLE `sg_self_cs_order_sku_bind_presale` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '商品ID',
        `date` date DEFAULT NULL COMMENT '日期',
        `cs_nick` varchar(45) NOT NULL COMMENT '客服昵称',
        `buyer_nick` varchar(45) NOT NULL DEFAULT '' COMMENT '买家昵称',
        `sku_id` bigint(20) unsigned NOT NULL COMMENT '商品ID',
        `order_id` bigint(20) unsigned NOT NULL COMMENT '订单ID',
        `order_created` datetime NOT NULL COMMENT '订单下单日期',
        `order_bargain_time` datetime DEFAULT NULL COMMENT '订单付定金时间',
        `order_balance_time` datetime DEFAULT NULL COMMENT '订单付尾款时间',
        `order_bargain_payment` double(20,3) unsigned DEFAULT NULL COMMENT '订单付定金金额',
        `order_balance_payment` double(20,3) unsigned DEFAULT NULL COMMENT '订单付尾款金额',
        `order_goods_num` int(11) unsigned DEFAULT '0' COMMENT '订单商品数量',
        `order_post_fee` double(20,3) unsigned NOT NULL COMMENT '邮费',
        `order_pay_type` tinyint(3) unsigned DEFAULT '0' COMMENT '支付方式（1货到付款, 2邮局汇款, 3自提, 4在线支付, 5公司转账, 6银行卡转账） ',
        `type` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '1：落实下单\n2：落实付款\n3：全静默绩效绑定',
        `is_pes` tinyint(2) DEFAULT '0' COMMENT '是否是绩效订单',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据 事业群编码/事业部编码',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`),
        KEY `idx_order` (`order_id`) USING BTREE,
        KEY `idx_shop_cs_created` (`shop_id`,`cs_nick`,`order_created`) USING BTREE,
        KEY `idx_shop_buyer` (`shop_id`,`buyer_nick`) USING BTREE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='self 客服预售订单SKU绑定表';

        set @sharding = 'sg_self_cs_order_sku_bind_reserve shop_id hash';
        CREATE TABLE `sg_self_cs_order_sku_bind_reserve` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '商品ID',
        `date` date DEFAULT NULL COMMENT '时间',
        `cs_nick` varchar(45) NOT NULL COMMENT '客服昵称',
        `buyer_nick` varchar(45) NOT NULL DEFAULT '' COMMENT '买家昵称',
        `order_id` bigint(20) unsigned NOT NULL COMMENT '订单ID',
        `sku_id` bigint(20) unsigned NOT NULL COMMENT '商品ID',
        `order_created` datetime NOT NULL COMMENT '订单下单日期',
        `order_pay_time` datetime DEFAULT NULL COMMENT '订单付款日期',
        `order_payment` double(20,3) unsigned DEFAULT NULL COMMENT '订单付款金额',
        `order_goods_num` int(11) unsigned DEFAULT '0' COMMENT '订单商品数量',
        `order_post_fee` double(20,3) unsigned NOT NULL COMMENT '邮费',
        `order_pay_type` tinyint(3) unsigned DEFAULT '0' COMMENT '支付方式（1货到付款, 2邮局汇款, 3自提, 4在线支付, 5公司转账, 6银行卡转账） ',
        `type` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '1：落实下单\n2：落实付款\n3：全静默绩效绑定',
        `is_pes` tinyint(2) DEFAULT '0' COMMENT '是否是绩效订单',
        `is_reserve` tinyint(4) DEFAULT '0' COMMENT '预约周期内，用户是否预约了 1 是  2 不是 0 默认值'',',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据 事业群编码/事业部编码',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`),
        KEY `idx_order` (`order_id`) USING BTREE,
        KEY `idx_shop_cs_created` (`shop_id`,`cs_nick`,`order_created`) USING BTREE,
        KEY `idx_shop_buyer` (`shop_id`,`buyer_nick`) USING BTREE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='self 客服预约订单SKU绑定表';

        set @sharding = 'sg_self_dept_init singleShard';
        CREATE TABLE `sg_self_dept_init` (
        `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `dept_code` varchar(255) NOT NULL DEFAULT '' COMMENT 'ERP账号',
        `status` tinyint(255) unsigned NOT NULL DEFAULT '0' COMMENT 'erp状态（0:未初始化,1:初始化进行中,2:初始化完成）',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `modified` datetime DEFAULT NULL COMMENT '修改时间',
        `modified_by` varchar(255) DEFAULT '' COMMENT '修改人',
        `yn` tinyint(2) DEFAULT '0' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`) USING BTREE,
        UNIQUE KEY `uniq_dept_code` (`dept_code`) USING BTREE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='self部门初始化表';


        set @sharding = 'sg_self_erp_recal_recored shop_id hash';
        CREATE TABLE `sg_self_erp_recal_recored` (
        `id` bigint(20) NOT NULL COMMENT '主键',
        `dept_code` varchar(20) NOT NULL COMMENT '部门编码',
        `erp_id` varchar(20) NOT NULL COMMENT 'ERP账号',
        `start_time` datetime NOT NULL COMMENT '开始时间',
        `end_time` datetime NOT NULL COMMENT '结束时间',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='self ERP数据重算记录表';


        set @sharding = 'sg_self_job_cal_record shop_id hash';
        CREATE TABLE `sg_self_job_cal_record` (
        `id` bigint(20) NOT NULL COMMENT '主键',
        `title` varchar(255) DEFAULT '' COMMENT '店铺名称',
        `shop_id` bigint(20) NOT NULL COMMENT '店铺ID',
        `date` date DEFAULT NULL COMMENT '日期',
        `result` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0:计算失败,1：计算成功',
        `run_status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '0:未执行,1:执行成功,2:执行中,4:执行失败',
        `erp_id` varchar(200) NOT NULL COMMENT '管理人员',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据 事业群编码/事业部编码',
        `msg` varchar(200) DEFAULT NULL COMMENT '失败原因',
        `consume_time` bigint(20) DEFAULT NULL COMMENT '店铺数据处理消耗的时长',
        `op_time` datetime DEFAULT NULL COMMENT '操作时间',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '数据创建时间',
        `modified` datetime DEFAULT NULL COMMENT '数据修改时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`),
        KEY `idx_shop_date` (`shop_id`,`date`) USING BTREE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='self JOB计算记录表';


        set @sharding = 'sg_self_shop_remind_word_history shop_id hash';
        CREATE TABLE `sg_self_shop_remind_word_history` (
        `id` bigint(20) NOT NULL COMMENT '主键',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺ID',
        `date` date DEFAULT NULL COMMENT '日期',
        `word_id` bigint(20) unsigned NOT NULL COMMENT '话术ID_用来做业务关联',
        `name` varchar(45) NOT NULL COMMENT '话术名称',
        `type` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '话术类型:\n1：咨询未下单\n2：下单未付款\n3:  预售已下单未付定金\n4：已付定金待付尾款',
        `created` datetime NOT NULL COMMENT '添加时间',
        `content` varchar(1000) NOT NULL COMMENT '话术内容',
        `is_send_goods_url` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否发送顾客进店咨询的商品链接\n0:不发送，1：发送',
        `is_default` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否是默认话术',
        `scope` tinyint(2) unsigned DEFAULT '1' COMMENT '话术范围 1：通用 ,2：指定商品',
        `goods_type` tinyint(2) unsigned DEFAULT '1' COMMENT '维度： 1：sku维度，2：spu维度',
        `is_using` tinyint(2) DEFAULT '0' COMMENT '是否正在使用 0：否 1：是',
        `modified` datetime DEFAULT NULL COMMENT '修改时间',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='self店铺提醒话术_history';

        set @sharding = 'sg_self_shop_setting_batch_remind_cno_history shop_id hash';
        CREATE TABLE `sg_self_shop_setting_batch_remind_cno_history` (
        `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `shop_id` bigint(20) NOT NULL COMMENT 'shopId',
        `is_remind` tinyint(2) DEFAULT NULL COMMENT '是否提醒 1：是 0：否',
        `dept2_code` varchar(50) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(50) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(50) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(50) DEFAULT NULL COMMENT '三级部门编号',
        `dept6_code` varchar(50) DEFAULT NULL COMMENT '业务组编号',
        `erp_id` varchar(50) DEFAULT NULL COMMENT '管理人员',
        `cno_time` int(11) unsigned DEFAULT NULL COMMENT '提醒时间',
        `word_name` varchar(45) DEFAULT NULL COMMENT '话术名称',
        `word_content` varchar(1000) DEFAULT NULL COMMENT '话术内容',
        `scope` tinyint(2) unsigned DEFAULT '1' COMMENT '话术范围 1：通用 ,2：指定商品',
        `goods_type` tinyint(2) unsigned DEFAULT '1' COMMENT '维度： 1：sku维度，2：spu维度',
        `remind_start_dot` int(11) unsigned DEFAULT NULL COMMENT '提醒开始时间',
        `remind_end_dot` int(11) unsigned DEFAULT NULL COMMENT '提醒结束时间',
        `created` datetime DEFAULT NULL COMMENT '创建时间',
        `modified` datetime DEFAULT NULL COMMENT '修改时间',
        `date` date DEFAULT NULL COMMENT '日期',
        PRIMARY KEY (`id`) USING BTREE,
        KEY `idx_shop_id` (`shop_id`) USING BTREE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='咨询未下单-批量提醒设置_历史';

        set @sharding = 'sg_self_shop_setting_batch_remind_history shop_id hash';
        CREATE TABLE `sg_self_shop_setting_batch_remind_history` (
        `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺ID',
        `is_remind` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否批量提醒',
        `silent_cs_nick` varchar(1000) DEFAULT NULL COMMENT '静默订单 指定的 客服昵称/所选客服',
        `silent_group_id` bigint(20) DEFAULT NULL COMMENT '静默订单客服组',
        `silent_flag` tinyint(2) DEFAULT '2' COMMENT '静默订单 标示 1：均分在线客服 2 指定客服',
        `silent_spare_cs_nick` varchar(1000) DEFAULT NULL COMMENT '兜底客服昵称',
        `silent_spare_group_id` bigint(20) DEFAULT NULL COMMENT '兜底客服组',
        `unpc_time` int(11) unsigned DEFAULT '5' COMMENT '普通下单 未付款 且未取消 提醒时间 (m)',
        `unpc_word_id` varchar(200) DEFAULT '0' COMMENT '普通下单 未付款 且未取消 提醒话术',
        `bargain_remind_dot` int(11) unsigned DEFAULT NULL COMMENT '预售已下单未付定金 提醒时间(m)',
        `bargain_remind_word_id` varchar(200) DEFAULT NULL COMMENT '预售已下单未付定金 提醒话术',
        `balance_remind_dot` int(11) unsigned DEFAULT NULL COMMENT '预售已付定金未付尾款 至付尾款截止日期 提醒时间 (m)\n\n',
        `balance_remind_word_id` varchar(200) DEFAULT NULL COMMENT '预售已付定金未付尾款 至付尾款截止日期 提醒话术\n\n',
        `remind_start_dot` int(11) unsigned DEFAULT NULL COMMENT '提醒时间段开始时间',
        `remind_end_dot` int(11) unsigned DEFAULT NULL COMMENT '提醒时间段结束时间',
        `created` datetime DEFAULT NULL COMMENT '创建时间',
        `modified` datetime DEFAULT NULL COMMENT '修改时间',
        `date` date DEFAULT NULL COMMENT '日期',
        PRIMARY KEY (`id`) USING BTREE,
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='插件管理-批量提醒设置';

        set @sharding = 'sg_self_shop_sms_setting_history shop_id hash';
        CREATE TABLE `sg_self_shop_sms_setting_history` (
        `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `shop_id` bigint(20) NOT NULL COMMENT '店铺ID',
        `is_remind` tinyint(2) NOT NULL DEFAULT '0' COMMENT '0:关闭 1：开启',
        `remind_time` int(11) unsigned zerofill DEFAULT NULL COMMENT '提醒时间(m)',
        `unpc_content` varchar(100) DEFAULT '' COMMENT '普通下单未付款话术',
        `slinet_content` varchar(100) DEFAULT '' COMMENT '静默下单未付款话术',
        `remind_start_dot` int(11) unsigned zerofill DEFAULT NULL COMMENT '提醒开始时间(m)',
        `remind_end_dot` int(11) unsigned zerofill DEFAULT NULL COMMENT '提醒结束时间(m)',
        `created` datetime DEFAULT NULL COMMENT '创建时间',
        `modified` datetime DEFAULT NULL COMMENT '修改时间',
        `date` date DEFAULT NULL COMMENT '日期',
        PRIMARY KEY (`id`),
        KEY `idx_shop` (`shop_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='店铺短信设置_历史';

        set @sharding = 'sg_self_shop_sms_word_history shop_id hash';
        CREATE TABLE `sg_self_shop_sms_word_history` (
        `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `shop_id` bigint(20) NOT NULL COMMENT '店铺id',
        `cs_nick` varchar(50) DEFAULT NULL COMMENT '添加客服的昵称',
        `name` varchar(45) DEFAULT NULL COMMENT '话术名称',
        `type` tinyint(2) DEFAULT '1' COMMENT '短信话术类型 1:普通咨询下单未付款 2静默下单未付款',
        `content` varchar(100) DEFAULT NULL COMMENT '话术类容',
        `sms_sign` varchar(45) DEFAULT NULL COMMENT '短信签名',
        `sms_suffix` varchar(20) DEFAULT NULL COMMENT '短信后缀',
        `created` datetime DEFAULT NULL COMMENT '创建时间',
        `modified` datetime DEFAULT NULL COMMENT '修改时间',
        `audit_status` tinyint(2) DEFAULT '0' COMMENT '话术审核状态: 1:待审核 2：审核通过 3:审核未通过',
        `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
        `audit_remark` varchar(200) DEFAULT NULL COMMENT '审核留言',
        `is_using` tinyint(2) DEFAULT '0' COMMENT '正在使用 1：是 0否',
        `word_id` bigint(20) unsigned DEFAULT NULL COMMENT '话术ID_用来做业务关联',
        `date` date DEFAULT NULL COMMENT '日期',
        PRIMARY KEY (`id`),
        KEY `idx_shop_status` (`shop_id`,`audit_status`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='店铺短信话术设置_history';

        set @sharding = 'sg_self_shop_use_analysis_collect shop_id hash';
        CREATE TABLE `sg_self_shop_use_analysis_collect` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `shop_id` bigint(20) unsigned DEFAULT NULL COMMENT '店铺ID',
        `date` date DEFAULT NULL COMMENT '时间',
        `title` varchar(100) DEFAULT NULL COMMENT '店铺名',
        `use_convert_pool` tinyint(1) unsigned DEFAULT '0' COMMENT '是否使用待转化池',
        `common_sale_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '普通订单销售额',
        `presale_sale_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '预售订单销售额',
        `reserve_sale_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '预约订单销售额',
        `word_num` int(10) DEFAULT '0' COMMENT '话术数量',
        `all_task_num` int(10) DEFAULT NULL COMMENT '总任务数',
        `allot_valid_task_num` int(10) DEFAULT NULL COMMENT '已分配有效任务数',
        `execute_task_num` int(10) DEFAULT NULL COMMENT '已执行任务数',
        `dd_execute_task_num` int(10) DEFAULT NULL COMMENT '咚咚执行任务数',
        `dd_valid_task_num` int(10) DEFAULT NULL COMMENT '咚咚有效任务数',
        `sms_success_task_num` int(10) DEFAULT NULL COMMENT '短信发送成功任务数',
        `sms_send_task_num` int(10) DEFAULT NULL COMMENT '短信发送任务数',
        `one_remind_clinch_amount` double(20,3) DEFAULT '0.000' COMMENT '一键提醒成交金额',
        `auto_remind_clinch_amount` double(20,3) DEFAULT '0.000' COMMENT '自动提醒成交金额',
        `all_urge_clinch_amount` double(20,3) DEFAULT '0.000' COMMENT '总催付成交金额',
        `redeem_amount` double(20,3) DEFAULT '0.000' COMMENT '挽回金额',
        `un_allot_task_num` int(11) DEFAULT '0' COMMENT '未分配数',
        `un_execute_task_num` int(11) DEFAULT '0' COMMENT '未执行数',
        `dept2_code` varchar(20) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(20) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(20) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(20) DEFAULT NULL COMMENT '三级部门',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        PRIMARY KEY (`id`),
        KEY `idx_shop_date` (`shop_id`,`date`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='self催付使用销售汇总表';

        set @sharding = 'sg_self_shop_use_analysis_detail shop_id hash';
        CREATE TABLE `sg_self_shop_use_analysis_detail` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `shop_id` bigint(20) unsigned DEFAULT NULL COMMENT '店铺ID',
        `date` date DEFAULT NULL COMMENT '时间',
        `title` varchar(100) DEFAULT NULL COMMENT '店铺名',
        `all_task_num` int(10) unsigned DEFAULT '0' COMMENT '总任务数',
        `allot_valid_task_num` int(10) unsigned DEFAULT '0' COMMENT '已分配有效任务数',
        `execute_task_num` int(10) unsigned DEFAULT '0' COMMENT '已执行任务数',
        `dd_execute_task_num` int(10) unsigned DEFAULT '0' COMMENT '咚咚执行任务数',
        `dd_valid_task_num` int(10) unsigned DEFAULT '0' COMMENT '咚咚有效任务数',
        `sms_success_task_num` int(10) unsigned DEFAULT '0' COMMENT '短信发送成功任务数',
        `sms_send_task_num` int(10) unsigned DEFAULT '0' COMMENT '短信发送任务数',
        `one_remind_clinch_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '一键提醒成交金额',
        `auto_remind_clinch_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '自动提醒成交金额',
        `all_urge_clinch_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '总催付成交金额',
        `redeem_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '挽回金额',
        `un_allot_task_num` int(11) DEFAULT '0' COMMENT '未分配数',
        `un_execute_task_num` int(11) DEFAULT '0' COMMENT '未执行数',
        `task_type` tinyint(2) unsigned DEFAULT '0' COMMENT '任务类型：\r\n1.普通 2.预售 3.预约',
        `order_type` tinyint(2) unsigned DEFAULT '0' COMMENT '/**\r\n  * 任务类型\r\n  *   1:咨询未下单\r\n  *   2咨询下单未付款\r\n  *   3静默下单未付款\r\n  *   4：预约咨询未预约\r\n  *   5：预约咨询预约未下单\r\n  *   6：预约静默预约未下单\r\n  *   7：预约咨询未预约未下单(是指在抢购期，针对不预约可以购买的进行\r\n  *     提醒咨询了但在预约期未预约的进行下单)\r\n  *   8: 预约咨询下单未付款\r\n  *   9: 预约静默下单未付款\r\n  *   10: 预售咨询未下单\r\n  *   11: 预售咨询下单未付定金\r\n  *   12: 预售静默下单未付定金金\r\n  *   13: 预售咨询付定金未付尾款\r\n  *   14: 预售静默付定金未付尾款\r\n  */',
        PRIMARY KEY (`id`),
        KEY `idx_shop_date` (`shop_id`,`date`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='self催付使用分析详情表';

        set @sharding = 'sg_self_sku_ov_presale_day sku_id hash';
        CREATE TABLE `sg_self_sku_ov_presale_day` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `sku_id` bigint(20) unsigned NOT NULL COMMENT '商品ID',
        `date` date DEFAULT NULL COMMENT '时间',
        `sku_name` varchar(200) DEFAULT NULL COMMENT '商品名称',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '商品ID',
        `title` varchar(200) DEFAULT '' COMMENT '店铺名称',
        `ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度:下单人数',
        `ordered_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度:下单件数',
        `ordered_bargain_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单付定金人数',
        `ordered_bargain_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单付定金件数',
        `ordered_bargain_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单付定金金额',
        `ordered_balance_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单付尾款人数',
        `ordered_balance_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单付尾款件数',
        `ordered_balance_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单付尾款金额',
        `bargain_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付定金维度:付定金人数',
        `bargain_goods_num` int(11) unsigned DEFAULT '0' COMMENT '付定金维度:付定金件数',
        `bargain_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '付定金维度:付定金金额',
        `bargain_balance_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付定金维度:付定金后的付尾款人数',
        `balance_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付尾款维度:付尾款人数',
        `balance_goods_num` int(11) unsigned DEFAULT '0' COMMENT '付尾款维度:付尾款件数',
        `balance_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '付尾款维度:付尾款金额',
        `enquiry_ordered_conv_rate` double(20,3) DEFAULT NULL COMMENT '客服促成下单转化',
        `presale_start_time` datetime DEFAULT NULL COMMENT '预售开始时间',
        `presale_end_time` datetime DEFAULT NULL COMMENT '预售结束时间',
        `balance_start_time` datetime DEFAULT NULL COMMENT '尾款开始时间',
        `balance_end_time` datetime DEFAULT NULL COMMENT '尾款结束时间',
        `dept2_code` varchar(20) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(20) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(20) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(20) DEFAULT NULL COMMENT '业务组编号',
        `category1_code` varchar(20) DEFAULT NULL COMMENT '一级类目',
        `category2_code` varchar(20) DEFAULT NULL COMMENT '二级类目',
        `category3_code` varchar(20) DEFAULT NULL COMMENT '三级类目',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据 事业群编码/事业部编码',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='self预售订单店铺sku维度每日总览数据表';

        set @sharding = 'sg_self_sku_ov_reserve_day sku_id hash';
        CREATE TABLE `sg_self_sku_ov_reserve_day` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `sku_id` bigint(20) NOT NULL COMMENT '商品ID',
        `sku_name` varchar(255) DEFAULT NULL COMMENT '商品名称',
        `reserve_group_id` bigint(20) DEFAULT NULL COMMENT '预约组ID',
        `date` date DEFAULT NULL COMMENT '时间',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺ID',
        `title` varchar(50) DEFAULT '' COMMENT '店铺标题',
        `reserve_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '预约维度：\n预约人数',
        `reserve_ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '预约维度：\n预约下单人数',
        `reserve_paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '预约维度：\n预约付款人数',
        `ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度:下单人数',
        `ordered_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度:下单件数',
        `ordered_paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单付尾款人数',
        `ordered_paid_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单付尾款件数',
        `ordered_paid_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单付尾款金额',
        `paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付款维度:付款人数',
        `paid_goods_num` int(11) unsigned DEFAULT '0' COMMENT '付款维度:付款件数',
        `paid_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '付款维度:付款金额',
        `enquiry_ordered_conv_rate` double(20,3) DEFAULT NULL COMMENT '客服促成下单转化',
        `reserve_start_time` datetime NOT NULL COMMENT '预约开始时间',
        `reserve_end_time` datetime NOT NULL COMMENT '预约结束时间',
        `rtp_start_time` datetime NOT NULL COMMENT '抢购开始时间',
        `rtp_end_time` datetime NOT NULL COMMENT '抢购结束时间',
        `dept2_code` varchar(20) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(20) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(20) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(20) DEFAULT NULL COMMENT '业务组编号',
        `category1_code` varchar(20) DEFAULT NULL COMMENT '一级类目',
        `category2_code` varchar(20) DEFAULT NULL COMMENT '二级类目',
        `category3_code` varchar(20) DEFAULT NULL COMMENT '三级类目',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据\n 事业群编码/事业部编码',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='self（预约sku维度）SKU每日总览数据表';

        set @sharding = 'sg_self_sku_performance_presale sku_id hash';
        CREATE TABLE `sg_self_sku_performance_presale` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `sku_id` bigint(20) NOT NULL COMMENT '商品ID',
        `sku_name` varchar(200) NOT NULL DEFAULT '' COMMENT '商品名称',
        `date` date DEFAULT NULL COMMENT '日期',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺ID',
        `title` varchar(20) DEFAULT '' COMMENT '店铺名称',
        `direct_receive_num` int(11) unsigned DEFAULT '0' COMMENT '直接接待人数',
        `forward_in_num` int(11) unsigned DEFAULT '0' COMMENT '转入人数',
        `forward_out_num` int(11) unsigned DEFAULT '0' COMMENT '转出人数',
        `consult_num` int(11) unsigned DEFAULT '0' COMMENT '咨询人数',
        `receive_num` int(11) unsigned DEFAULT '0' COMMENT '接待人数',
        `enquiry_num` int(11) unsigned DEFAULT '0' COMMENT '询单人数',
        `ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '询单维度（下单）：\n当日询单， 最终落实下单的人数（最终数据依据，询单有效期）',
        `ordered_goods_num` int(11) unsigned DEFAULT '0' COMMENT '询单维度（下单）：\n当日询单， 最终落实下单的订单的商品数（最终数据依据，询单有效期）',
        `ordered_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '询单维度（下单）：\n当日询单， 最终落实下单的订单的金额（最终数据依据，询单有效期）',
        `bargain_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '询单维度（定金）：\n当日询单，最终落实下单，  并且最终付了款的人数（最终数据依据，询单有效期+付款有效期）\n',
        `bargain_goods_num` int(11) unsigned DEFAULT '0' COMMENT '询单维度（定金）：\n当日询单，最终落实下单，  并且最终付了款的订单件数（最终数据依据，询单有效期+付款有效期）',
        `bargain_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '询单维度（定金）：\n当日询单，最终落实下单，  并且最终付了款的订单金额（最终数据依据，询单有效期+付款有效期）',
        `balance_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付尾款维度:付尾款人数',
        `balance_goods_num` int(11) unsigned DEFAULT '0' COMMENT '付尾款维度:付尾款件数',
        `balance_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '付尾款维度:付尾款金额',
        `to_bargain_buyer_num` int(11) DEFAULT NULL COMMENT '落实付定金人数',
        `to_bargain_balance_buyer_num` int(11) DEFAULT NULL COMMENT '落实付尾款人数',
        `bargain_start_time` datetime NOT NULL COMMENT '定金开始时间',
        `bargain_end_time` datetime NOT NULL COMMENT '预售结束时间',
        `balance_start_time` datetime NOT NULL COMMENT '尾款开始时间',
        `balance_end_time` datetime NOT NULL COMMENT '尾款结束时间',
        `dept2_code` varchar(20) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(20) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(20) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(20) DEFAULT NULL COMMENT '业务组编号',
        `category1_code` varchar(20) DEFAULT NULL COMMENT '一级类目',
        `category2_code` varchar(20) DEFAULT NULL COMMENT '二级类目',
        `category3_code` varchar(20) DEFAULT NULL COMMENT '三级类目',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据 事业群\n编码/事业部编码',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`),
        KEY `idx_shop_cs_date` (`shop_id`,`date`) USING BTREE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='self预售绩效表（SKU维度下询单维度）';

        set @sharding = 'sg_self_sku_performance_reserve sku_id hash';
        CREATE TABLE `sg_self_sku_performance_reserve` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺ID',
        `title` varchar(200) DEFAULT NULL COMMENT '店铺名称',
        `date` date DEFAULT NULL COMMENT '时间',
        `sku_id` bigint(20) unsigned NOT NULL COMMENT '商品ID',
        `sku_name` varchar(200) NOT NULL DEFAULT '' COMMENT '商品名称',
        `reserve_group_id` bigint(20) unsigned DEFAULT '0' COMMENT '预约组ID',
        `direct_receive_num` int(11) unsigned DEFAULT '0' COMMENT '直接接待人数',
        `forward_in_num` int(11) unsigned DEFAULT '0' COMMENT '转入人数',
        `forward_out_num` int(11) unsigned DEFAULT '0' COMMENT '转出人数',
        `consult_num` int(11) unsigned DEFAULT '0' COMMENT '咨询人数',
        `receive_num` int(11) unsigned DEFAULT '0' COMMENT '接待人数',
        `enquiry_num` int(11) unsigned DEFAULT '0' COMMENT '询单人数',
        `ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '询单维度（下单）：\n当日询单， 最终落实下单的人数（最终数据依据，询单有效期）',
        `ordered_goods_num` int(11) unsigned DEFAULT '0' COMMENT '询单维度（下单）：\n当日询单， 最终落实下单的订单的商品数（最终数据依据，询单有效期）',
        `ordered_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '询单维度（下单）：\n当日询单， 最终落实下单的订单的金额（最终数据依据，询单有效期）',
        `paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '询单维度（付款）：\n当日询单，最终落实下单，  并且最终付了款的人数（最终数据依据，询单有效期+付款有效期）\n',
        `paid_goods_num` int(11) unsigned DEFAULT '0' COMMENT '询单维度（付款）：\n当日询单，最终落实下单，  并且最终付了款的订单件数（最终数据依据，询单有效期+付款有效期）',
        `paid_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '询单维度（付款）：\n当日询单，最终落实下单，  并且最终付了款的订单金额（最终数据依据，询单有效期+付款有效期）',
        `reserve_num` int(11) unsigned DEFAULT '0' COMMENT '询单-预约维度：\n预约人数',
        `reserve_ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '询单-预约维度（下单）：\n当日询单， 最终落实下单的人数（最终数据依据，询单有效期）',
        `reserve_ordered_goods_num` int(11) unsigned DEFAULT '0' COMMENT '询单-预约维度（下单）：\n当日询单， 最终落实下单的订单的商品数（最终数据依据，询单有效期）',
        `reserve_ordered_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '询单-预约维度（下单）：\n当日询单， 最终落实下单的订单的金额（最终数据依据，询单有效期）',
        `reserve_paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '询单-预约维度（付款）：\n当日询单，最终落实下单，  并且最终付了款的人数（最终数据依据，询单有效期+付款有效期）\n',
        `reserve_paid_goods_num` int(11) unsigned DEFAULT '0' COMMENT '询单-预约维度（付款）：\n当日询单，最终落实下单，  并且最终付了款的订单件数（最终数据依据，询单有效期+付款有效期）',
        `reserve_paid_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '询单-预约维度（付款）：\n当日询单，最终落实下单，  并且最终付了款的订单金额（最终数据依据，询单有效期+付款有效期）',
        `reserve_start_time` datetime NOT NULL COMMENT '预约开始时间',
        `reserve_end_time` datetime NOT NULL COMMENT '预约结束时间',
        `rtp_start_time` datetime NOT NULL COMMENT '抢购开始时间',
        `rtp_end_time` datetime NOT NULL COMMENT '抢购结束时间',
        `dept2_code` varchar(20) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(20) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(20) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(20) DEFAULT NULL COMMENT '业务组编号',
        `category1_code` varchar(20) DEFAULT NULL COMMENT '一级类目',
        `category2_code` varchar(20) DEFAULT NULL COMMENT '二级类目',
        `category3_code` varchar(20) DEFAULT NULL COMMENT '三级类目',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据\n 事业群编码\n/事业部编码',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`),
        KEY `idx_sku_date` (`sku_id`,`date`) USING BTREE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='self预约绩效表（SKU维度下询单维度）';

        set @sharding = 'sg_self_sku_sov_presale_day sku_id hash';
        CREATE TABLE `sg_self_sku_sov_presale_day` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺ID',
        `title` varchar(200) DEFAULT NULL COMMENT '店铺名称',
        `sku_id` bigint(20) unsigned NOT NULL COMMENT '商品ID',
        `sku_name` varchar(255) DEFAULT NULL COMMENT '商品名称',
        `date` date DEFAULT NULL COMMENT '时间',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        `ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度:下单人数',
        `ordered_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度:下单件数',
        `ordered_bargain_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单付定金人数',
        `ordered_bargain_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单付定金件数',
        `ordered_bargain_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单付定金金额',
        `ordered_balance_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单付尾款人数',
        `ordered_balance_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单付尾款件数',
        `ordered_balance_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单付尾款金额',
        `bargain_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付定金维度:付定金人数',
        `bargain_goods_num` int(11) unsigned DEFAULT '0' COMMENT '付定金维度:付定金件数',
        `bargain_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '付定金维度:付定金金额',
        `bargain_balance_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付定金维度:付定金后的付尾款人数',
        `balance_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付尾款维度:付尾款人数',
        `balance_goods_num` int(11) unsigned DEFAULT '0' COMMENT '付尾款维度:付尾款件数',
        `balance_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '付尾款维度:付尾款金额',
        `presale_start_time` datetime DEFAULT NULL COMMENT '预售开始时间',
        `presale_end_time` datetime DEFAULT NULL COMMENT '预售结束时间',
        `balance_start_time` datetime DEFAULT NULL COMMENT '尾款开始时间',
        `balance_end_time` datetime DEFAULT NULL COMMENT '尾款结束时间',
        `dept2_code` varchar(20) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(20) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(20) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(20) DEFAULT NULL COMMENT '业务组编号',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据\n 事业群编码\n/事业部编码',
        `category1_code` varchar(20) DEFAULT NULL COMMENT '一级类目',
        `category2_code` varchar(20) DEFAULT NULL COMMENT '二级类目',
        `category3_code` varchar(20) DEFAULT NULL COMMENT '三级类目',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='self（预售sku维度）SKU每日静默总览数据表';

        set @sharding = 'sg_self_sku_sov_reserve_day sku_id hash';
        CREATE TABLE `sg_self_sku_sov_reserve_day` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `sku_id` bigint(20) unsigned NOT NULL COMMENT '商品ID',
        `sku_name` varchar(200) DEFAULT NULL COMMENT '商品名称',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        `reserve_group_id` bigint(20) unsigned DEFAULT NULL COMMENT '预约组ID',
        `date` date DEFAULT NULL COMMENT '时间',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '商品ID',
        `title` varchar(255) DEFAULT NULL COMMENT '店铺名称',
        `reserve_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '预约维度：\n预约人数',
        `reserve_ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '预约维度：\n预约下单人数',
        `reserve_paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '预约维度：\n预约付款人数',
        `ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度:下单人数',
        `ordered_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度:下单件数',
        `ordered_paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单付尾款人数',
        `ordered_paid_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单付尾款件数',
        `ordered_paid_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单付尾款金额',
        `paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付款维度:付款人数',
        `paid_goods_num` int(11) unsigned DEFAULT '0' COMMENT '付款维度:付款件数',
        `paid_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '付款维度:付款金额',
        `reserve_start_time` datetime NOT NULL COMMENT '预约开始时间',
        `reserve_end_time` datetime NOT NULL COMMENT '预约结束时间',
        `rtp_start_time` datetime NOT NULL COMMENT '抢购开始时间',
        `rtp_end_time` datetime NOT NULL COMMENT '抢购结束时间',
        `dept2_code` varchar(20) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(20) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(20) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(20) DEFAULT NULL COMMENT '业务组编号',
        `category1_code` varchar(20) DEFAULT NULL COMMENT '一级类目',
        `category2_code` varchar(20) DEFAULT NULL COMMENT '二级类目',
        `category3_code` varchar(20) DEFAULT NULL COMMENT '三级类目',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据 事业群编码\n/事业部编码',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='self（预约sku维度）SKU每日静默总览数据表';

        set @sharding = 'sg_self_sku_to_performance_presale sku_id hash';
        CREATE TABLE `sg_self_sku_to_performance_presale` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `sku_id` bigint(20) unsigned NOT NULL COMMENT '商品ID',
        `sku_name` varchar(200) DEFAULT NULL COMMENT '商品名称',
        `date` date DEFAULT NULL COMMENT '时间',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺ID',
        `title` varchar(20) DEFAULT '' COMMENT '店铺名称',
        `erp_id` varchar(50) DEFAULT '' COMMENT 'ERP账号',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据\n 事业群编码/事业部编码',
        `to_ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单的，下单人数',
        `to_ordered_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单的，下单件数',
        `to_ordered_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单维度：\n促成下单的，下单金额',
        `to_ordered_bargain_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单并最终付款的，付款人数\n（*保留字段）',
        `to_ordered_bargain_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单并最终付款的，付款件数\n（*保留字段）',
        `to_ordered_bargain_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单维度：\n促成下单并最终付款的，付款金额\n（*保留字段）',
        `to_ordered_balance_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单并最终付款的，付款人数\n（*保留字段）',
        `to_ordered_balance_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单并最终付款的，付款件数\n（*保留字段）',
        `to_ordered_balance_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单维度：\n促成下单并最终付款的，付款金额\n（*保留字段）',
        `to_bargain_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付定金维度：\n付定金人数',
        `to_bargain_goods_num` int(11) unsigned DEFAULT '0' COMMENT '付定金维度：\n付定金件数',
        `to_bargain_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '付定金单维度：\n付定金金额',
        `to_bargain_balance_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付定金维度：\n付定金人数里最终付了尾款的人数',
        `to_balance_num` int(11) unsigned DEFAULT '0' COMMENT '付尾款维度：\n付尾款人数\n（*保留字段）',
        `to_balance_goods_num` int(11) unsigned DEFAULT '0' COMMENT '付尾款维度：\n付尾款件数\n（*保留字段）',
        `to_balance_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '付尾款维度：\n付尾款金额\n（*保留字段）',
        `bargain_start_time` datetime NOT NULL COMMENT '定金开始时间',
        `bargain_end_time` datetime NOT NULL COMMENT '预售结束时间',
        `balance_start_time` datetime NOT NULL COMMENT '尾款开始时间',
        `balance_end_time` datetime NOT NULL COMMENT '尾款结束时间',
        `dept2_code` varchar(20) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(20) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(20) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(20) DEFAULT NULL COMMENT '业务组编号',
        `category1_code` varchar(20) DEFAULT NULL COMMENT '一级类目',
        `category2_code` varchar(20) DEFAULT NULL COMMENT '二级类目',
        `category3_code` varchar(20) DEFAULT NULL COMMENT '三级类目',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='self预售绩效表（SKU维度下的促成下单维度/付定金维度/付尾款维度）';

        set @sharding = 'sg_self_sku_to_performance_reserve sku_id hash';
        CREATE TABLE `sg_self_sku_to_performance_reserve` (
        `id` bigint(20) unsigned NOT NULL COMMENT '主键',
        `sku_id` bigint(20) unsigned NOT NULL COMMENT '商品ID',
        `sku_name` varchar(200) DEFAULT '' COMMENT '商品名称',
        `erp_id` varchar(50) DEFAULT NULL COMMENT 'ERP账号',
        `sys_dept_code` varchar(20) NOT NULL DEFAULT '0' COMMENT '根据哪个组织设置得系统设置跑出得数据 事业群编码/事业部编码',
        `reserve_group_id` bigint(20) unsigned NOT NULL COMMENT '预约组ID',
        `date` date DEFAULT NULL COMMENT '时间',
        `title` varchar(50) DEFAULT '' COMMENT '店铺名',
        `shop_id` bigint(20) unsigned NOT NULL COMMENT '店铺ID',
        `reserve_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '预约维度：\n预约人数',
        `reserve_ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '预约维度：\n预约下单人数',
        `reserve_paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '预约维度：\n预约付款人数',
        `to_ordered_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单的，下单人数',
        `to_ordered_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单的，下单件数',
        `to_ordered_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单维度：\n促成下单的，下单金额',
        `to_ordered_paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单并最终付款的，付款人数',
        `to_ordered_paid_goods_num` int(11) unsigned DEFAULT '0' COMMENT '下单维度：\n促成下单并最终付款的，付款件数',
        `to_ordered_paid_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '下单维度：\n促成下单并最终付款的，付款金额',
        `to_paid_buyer_num` int(11) unsigned DEFAULT '0' COMMENT '付款维度：\n付款人数',
        `to_paid_buyer_goods_num` int(11) unsigned DEFAULT '0' COMMENT '付款维度：\n付款件数',
        `to_paid_buyer_amount` double(20,3) unsigned DEFAULT '0.000' COMMENT '付款维度：\n付款金额',
        `reserve_start_time` datetime NOT NULL COMMENT '预约开始时间',
        `reserve_end_time` datetime NOT NULL COMMENT '预约结束时间',
        `rtp_start_time` datetime NOT NULL COMMENT '抢购开始时间',
        `rtp_end_time` datetime NOT NULL COMMENT '抢购结束时间',
        `dept2_code` varchar(20) DEFAULT NULL COMMENT '事业群编码',
        `dept3_code` varchar(20) DEFAULT NULL COMMENT '事业部编码',
        `dept4_code` varchar(20) DEFAULT NULL COMMENT '二级部门编码',
        `dept5_code` varchar(20) DEFAULT NULL COMMENT '业务组编号',
        `category1_code` varchar(20) DEFAULT NULL COMMENT '一级类目',
        `category2_code` varchar(20) DEFAULT NULL COMMENT '二级类目',
        `category3_code` varchar(20) DEFAULT NULL COMMENT '三级类目',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='self预约绩效表（SKU维度下的预约维度/促成下单维度/付款维度）';

        set @sharding = 'sg_self_syn_mf_shop_record singleShard';
        CREATE TABLE `sg_self_syn_mf_shop_record` (
        `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `date` datetime DEFAULT NULL COMMENT '日期',
        `title` varchar(255) DEFAULT '' COMMENT '店铺名称',
        `shop_id` bigint(20) DEFAULT '0' COMMENT '店铺ID',
        `result` tinyint(2) DEFAULT '0' COMMENT '0:失败,1：成功',
        `syn_word` tinyint(2) DEFAULT NULL COMMENT '同步话术',
        `syn_word_setting` tinyint(2) DEFAULT NULL COMMENT '同步话术设置',
        `syn_remind_detail` tinyint(2) DEFAULT NULL COMMENT '同步魔方催付话术',
        `msg` varchar(255) DEFAULT NULL COMMENT '失败原因',
        `consume_time` bigint(20) DEFAULT NULL COMMENT '店铺数据处理消耗的时长',
        `op_time` datetime DEFAULT NULL COMMENT '操作时间',
        `run_status` tinyint(2) DEFAULT '0' COMMENT '0:未执行,1:执行成功,2:执行中,4:执行失败',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '数据创建时间',
        `modified` datetime DEFAULT NULL COMMENT '修改时间',
        `yn` tinyint(2) DEFAULT '1' COMMENT '1:有效,0:无效',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='self魔方数据同步记录';

        set @sharding = 'sg_self_sysetting_base singleShard';

        CREATE TABLE `sg_self_sysetting_base` (
        `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
        `dept_code` varchar(20) DEFAULT '0' COMMENT '部门ID（指向事业部）',
        `dept_type` int(11) unsigned DEFAULT '0' COMMENT '部门类型（1:事业群 2:事业部）',
        `aftersell_acount_filter` tinyint(2) DEFAULT '0' COMMENT '售后账号不参与过滤',
        `sell_after` int(11) unsigned DEFAULT '0' COMMENT '售后天数（天:3-180）',
        `max_wait_time` int(11) unsigned DEFAULT '0' COMMENT '最长等待时间(分钟)',
        `slow_response_time` int(11) unsigned DEFAULT '0' COMMENT '慢响应时间（慢响应设设定）',
        `slow_response_times_num` int(11) unsigned DEFAULT '0' COMMENT '慢响应次数（慢响应设设定）',
        `quick_response_time` int(11) unsigned DEFAULT '0' COMMENT '快速应答设定（秒）',
        `long_reception_time` int(11) unsigned DEFAULT '0' COMMENT '长接待设定',
        `scheduling_time_dot` int(11) unsigned DEFAULT '0' COMMENT '业务天分割点',
        `cs_recommend_switch` tinyint(2) DEFAULT '0' COMMENT '客服推荐关键字匹配-开关',
        `cs_recommend_mark` varchar(255) DEFAULT '' COMMENT '客服推荐关键字\r\n开启本功能后，客服发送商品链接时需要以关键字开头，才会判断为客服推荐。',
        `duty_record_export_unit` int(1) unsigned DEFAULT '0' COMMENT '值班记录导出时长单位设置（分钟/秒）',
        `duty_rid_cs_switch` tinyint(2) DEFAULT '0' COMMENT '值班记录剔除未上班客服',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `modified` datetime DEFAULT NULL COMMENT '修改时间',
        `modified_by` varchar(255) DEFAULT '' COMMENT '修改人',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='self导购 > 系统设置 > 基础设置';

        set @sharding = 'sg_self_sysetting_pes singleShard';

        CREATE TABLE `sg_self_sysetting_pes` (
        `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
        `dept_code` varchar(20) DEFAULT '0' COMMENT '部门ID（指向事业部）',
        `dept_type` int(11) unsigned DEFAULT '0' COMMENT '部门类型（指向事业部）',
        `judge_rule_ascription` tinyint(4) unsigned DEFAULT '0' COMMENT '订单归属规则（1:聊天时间判定归属,2:回合数判定归属）',
        `judge_rule` tinyint(4) unsigned DEFAULT '0' COMMENT '绩效判定规则（1:下单判定,2:下单优先判定,3:付款判定）',
        `enquiry_valid_duration_time` tinyint(4) unsigned DEFAULT '0' COMMENT '询单有效时长（天:2-15）',
        `out_stock_valid_duration_time` tinyint(4) unsigned DEFAULT '0' COMMENT '出库有效时长（天:2-15）',
        `silent_all_switch` tinyint(2) DEFAULT '0' COMMENT '全静默订单跟进统计-开关',
        `silent_all_follow_up_time` tinyint(4) unsigned DEFAULT '0' COMMENT '全静默订单跟进业绩统计 \r\n付款(1-60)分钟内跟进有效',
        `silent_all_follow_up_switch` tinyint(2) DEFAULT '0' COMMENT '全静默订单跟进统计;算客服绩效，不算客服绩效 -开关',
        `cs_to_csut_first_lost_switch` tinyint(2) DEFAULT '0' COMMENT '客服主动联系不算询单流失-开关',
        `cust_first_reply_day` tinyint(4) unsigned DEFAULT '0' COMMENT '客服主动联系不算询单流失\\n买家首次回复识别天数(1-5天)\\n默认2天',
        `silent_urgepay_switch` tinyint(2) DEFAULT '0' COMMENT '静默下单催付时间限制',
        `silent_urgepay_time` tinyint(4) unsigned DEFAULT '0' COMMENT '静默下单后在（1-60）分钟内客服跟进无效',
        `order_flag_switch` tinyint(2) DEFAULT '0' COMMENT '指定订单不算客服业绩（插旗）-开关',
        `order_flag` tinyint(4) unsigned DEFAULT '0' COMMENT '插旗过滤旗帜',
        `enquiry_loss_switch` tinyint(2) DEFAULT '0' COMMENT '跨天聊天只算一次询单流失',
        `cs_forward_aftersell_switch` tinyint(2) DEFAULT '0' COMMENT '转售后客服不算询单人数',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `modified` datetime DEFAULT NULL COMMENT '修改时间',
        `modified_by` varchar(255) DEFAULT '' COMMENT '修改人',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='self导购 > 系统设置 > 绩效设置';

        set @sharding = 'sg_self_sysetting_receive singleShard';

        CREATE TABLE `sg_self_sysetting_receive` (
        `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `dept_code` varchar(20) DEFAULT '0' COMMENT '部门ID（指向事业部）',
        `team_chat_filte_switch` tinyint(2) DEFAULT '0' COMMENT '自家账号过滤',
        `sys_cs_chat_filte_switch` tinyint(2) DEFAULT '0' COMMENT '绩效软件客服过滤',
        `non_chat_filte_switch` tinyint(2) DEFAULT '0' COMMENT '空聊天过滤',
        `chose_cs_filte_switch` tinyint(2) DEFAULT '0' COMMENT '指定客服过滤',
        `cs_forward_switch` tinyint(2) DEFAULT '0' COMMENT '客服转发过滤-开关',
        `cs_forward_num` tinyint(4) unsigned DEFAULT '0' COMMENT '客服转发过滤句数\r\n客服最多回复（0-10）句（含）',
        `cs_watchword_switch` tinyint(2) DEFAULT '0' COMMENT '暗语过滤-开关',
        `cs_watchword` varchar(255) DEFAULT '' COMMENT '暗语关键词(1-50个字)',
        `cs_watchword_send_times_num` tinyint(4) unsigned DEFAULT '0' COMMENT '设置客服暗语{}，发送（1-10）次（含）以上过滤',
        `main_account_auto_reply_switch` tinyint(2) DEFAULT '0' COMMENT '主账号回复过滤-开关',
        `main_account_auto_reply_content` varchar(255) DEFAULT '' COMMENT '主号自动回复内容',
        `cust_sigchat_switch` tinyint(2) DEFAULT '0' COMMENT '顾客单句过滤-开关',
        `sigchat_min_reply_num` tinyint(4) DEFAULT '0' COMMENT '顾客咨询客服一句，客服回复指定句数以上\\n(客服最少回复句数{}（含）)',
        `cs_single_chat_filter` tinyint(2) DEFAULT '0' COMMENT '客服单口相声过滤',
        `cust_single_chat_num` tinyint(4) unsigned DEFAULT '0' COMMENT '客户回复{}句 以内，不算接待',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `modified` datetime DEFAULT NULL COMMENT '修改时间',
        `modified_by` varchar(255) DEFAULT NULL COMMENT '修改人',
        `yn` tinyint(2) DEFAULT '1' COMMENT '是否有效',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='self导购 > 系统设置 > 接待过滤';

        set @sharding = 'sg_self_systemsetting_fieid_limit singleShard';

        CREATE TABLE `sg_self_systemsetting_fieid_limit` (
        `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
        `dept_code` varchar(20) NOT NULL COMMENT '部门编码',
        `enquiry_valid_duration_time` int(11) DEFAULT NULL COMMENT '询单有效时长验证',
        `out_stock_valid_duration_time` int(11) DEFAULT NULL COMMENT '出库有效时长验证',
        `modify_enquiry_out_stock` date DEFAULT NULL COMMENT '修改时间（询单、出库）',
        PRIMARY KEY (`id`) USING BTREE
        ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='self系统设置字段修改限制表';

        set @sharding = 'sg_self_ultra_power singleShard';

        CREATE TABLE `sg_self_ultra_power` (
        `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `erp_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'ERP账号',
        `dept_type` tinyint(255) unsigned NOT NULL DEFAULT '0' COMMENT '部门类别（2:事业群,3:事业部,4:二级部门,5三级部门,6:业务组）',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `modified` datetime DEFAULT NULL COMMENT '修改时间',
        `modified_by` varchar(255) DEFAULT '' COMMENT '修改人',
        `yn` tinyint(1) DEFAULT '0' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`) USING BTREE,
        UNIQUE KEY `uniq_erp_id` (`erp_id`) USING BTREE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='self特殊权限用户表';

        set @sharding = 'sg_self_ware_category singleShard';
        CREATE TABLE `sg_self_ware_category` (
        `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `vender_id` bigint(20) unsigned NOT NULL COMMENT '商家编号',
        `category_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '类目id',
        `category_name` varchar(500) NOT NULL COMMENT '类目名称',
        `parent_id` bigint(20) unsigned DEFAULT '0' COMMENT '父id',
        `category_level` tinyint(2) unsigned DEFAULT NULL COMMENT '类目级别',
        `yn` tinyint(2) NOT NULL DEFAULT '1' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`),
        KEY `idx_shop` (`vender_id`) USING BTREE
        ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='self 类目表';

        set @sharding = 'sg_self_xxl_job_group singleShard';

        CREATE TABLE `sg_self_xxl_job_group` (
        `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `app_name` varchar(64) NOT NULL COMMENT '执行器AppName',
        `title` varchar(12) NOT NULL COMMENT '执行器名称',
        `order` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
        `address_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '执行器地址类型：0=自动注册、1=手动录入',
        `address_list` varchar(512) DEFAULT NULL COMMENT '执行器地址列表，多地址逗号分隔',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='self job分组表';

        set @sharding = 'sg_self_xxl_job_info singleShard';

        CREATE TABLE `sg_self_xxl_job_info` (
        `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
        `job_cron` varchar(128) NOT NULL COMMENT '任务执行CRON',
        `job_desc` varchar(255) NOT NULL COMMENT '任务描述',
        `add_time` datetime DEFAULT NULL COMMENT '添加时间',
        `update_time` datetime DEFAULT NULL COMMENT '更新时间',
        `author` varchar(64) DEFAULT NULL COMMENT '作者',
        `alarm_email` varchar(255) DEFAULT NULL COMMENT '报警邮件',
        `executor_route_strategy` varchar(50) DEFAULT NULL COMMENT '执行器路由策略',
        `executor_handler` varchar(255) DEFAULT NULL COMMENT '执行器任务handler',
        `executor_param` varchar(512) DEFAULT NULL COMMENT '执行器任务参数',
        `executor_block_strategy` varchar(50) DEFAULT NULL COMMENT '阻塞处理策略',
        `executor_timeout` int(11) NOT NULL DEFAULT '0' COMMENT '任务执行超时时间，单位秒',
        `executor_fail_retry_count` int(11) NOT NULL DEFAULT '0' COMMENT '失败重试次数',
        `glue_type` varchar(50) NOT NULL COMMENT 'GLUE类型',
        `glue_source` mediumtext COMMENT 'GLUE源代码',
        `glue_remark` varchar(128) DEFAULT NULL COMMENT 'GLUE备注',
        `glue_updatetime` datetime DEFAULT NULL COMMENT 'GLUE更新时间',
        `child_jobid` varchar(255) DEFAULT NULL COMMENT '子任务ID，多个逗号分隔',
        `trigger_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '调度状态：0-停止，1-运行',
        `trigger_last_time` bigint(13) NOT NULL DEFAULT '0' COMMENT '上次调度时间',
        `trigger_next_time` bigint(13) NOT NULL DEFAULT '0' COMMENT '下次调度时间',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='self job信息表';

        set @sharding = 'sg_self_xxl_job_lock singleShard';

        CREATE TABLE `sg_self_xxl_job_lock` (
        `lock_name` varchar(50) NOT NULL COMMENT '锁名称',
        PRIMARY KEY (`lock_name`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='self job锁信息表';

        set @sharding = 'sg_self_xxl_job_log singleShard';

        CREATE TABLE `sg_self_xxl_job_log` (
        `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
        `job_id` int(11) NOT NULL COMMENT '任务，主键ID',
        `executor_address` varchar(255) DEFAULT NULL COMMENT '执行器地址，本次执行的地址',
        `executor_handler` varchar(255) DEFAULT NULL COMMENT '执行器任务handler',
        `executor_param` varchar(512) DEFAULT NULL COMMENT '执行器任务参数',
        `executor_sharding_param` varchar(20) DEFAULT NULL COMMENT '执行器任务分片参数，格式如 1/2',
        `executor_fail_retry_count` int(11) NOT NULL DEFAULT '0' COMMENT '失败重试次数',
        `trigger_time` datetime DEFAULT NULL COMMENT '调度-时间',
        `trigger_code` int(11) NOT NULL COMMENT '调度-结果',
        `trigger_msg` text COMMENT '调度-日志',
        `handle_time` datetime DEFAULT NULL COMMENT '执行-时间',
        `handle_code` int(11) NOT NULL COMMENT '执行-状态',
        `handle_msg` text COMMENT '执行-日志',
        `alarm_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '告警状态：0-默认、1-无需告警、2-告警成功、3-告警失败',
        PRIMARY KEY (`id`),
        KEY `idx_I_trigger_time` (`trigger_time`),
        KEY `idx_I_handle_code` (`handle_code`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='self job日志表';

        set @sharding = 'sg_self_xxl_job_log_report singleShard';

        CREATE TABLE `sg_self_xxl_job_log_report` (
        `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `trigger_day` datetime DEFAULT NULL COMMENT '调度-时间',
        `running_count` int(11) NOT NULL DEFAULT '0' COMMENT '运行中-日志数量',
        `suc_count` int(11) NOT NULL DEFAULT '0' COMMENT '执行成功-日志数量',
        `fail_count` int(11) NOT NULL DEFAULT '0' COMMENT '执行失败-日志数量',
        PRIMARY KEY (`id`),
        UNIQUE KEY `uniq_i_trigger_day` (`trigger_day`) USING BTREE
        ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='self job日志报表';

        set @sharding = 'sg_self_xxl_job_logglue singleShard';

        CREATE TABLE `sg_self_xxl_job_logglue` (
        `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `job_id` int(11) NOT NULL COMMENT '任务，主键ID',
        `glue_type` varchar(50) DEFAULT NULL COMMENT 'GLUE类型',
        `glue_source` mediumtext COMMENT 'GLUE源代码',
        `glue_remark` varchar(128) NOT NULL COMMENT 'GLUE备注',
        `add_time` datetime DEFAULT NULL COMMENT '添加时间',
        `update_time` datetime DEFAULT NULL COMMENT '更新时间',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='self job运行模式表';

        set @sharding = 'sg_self_xxl_job_registry singleShard';

        CREATE TABLE `sg_self_xxl_job_registry` (
        `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `registry_group` varchar(50) NOT NULL COMMENT '注册组',
        `registry_key` varchar(255) NOT NULL COMMENT '注册key',
        `registry_value` varchar(255) NOT NULL COMMENT '注册value',
        `update_time` datetime DEFAULT NULL COMMENT '更新时间',
        PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='self job注册表';

        set @sharding = 'sg_self_xxl_job_user singleShard';

        CREATE TABLE `sg_self_xxl_job_user` (
        `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `username` varchar(50) NOT NULL COMMENT '账号',
        `password` varchar(50) NOT NULL COMMENT '密码',
        `role` tinyint(4) NOT NULL COMMENT '角色：0-普通用户、1-管理员',
        `permission` varchar(255) DEFAULT NULL COMMENT '权限：执行器ID列表，多个逗号分割',
        PRIMARY KEY (`id`),
        UNIQUE KEY `uniq_i_username` (`username`) USING BTREE
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='self job用户表';

        set @sharding = 'sg_data_push_log singleShard';

        CREATE TABLE `sg_data_push_log` (
        `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
        `type` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '系统类型:1 自营  2 POP',
        `state` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '状态:1 成功  0 失败',
        `version` varchar(10) NOT NULL COMMENT '版本：1 导购1期，2 导购2期, 2.1 导购2期一阶段',
        `date` date DEFAULT NULL COMMENT '推送日期',
        `created` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
        `yn` tinyint(1) DEFAULT '0' COMMENT '是否有效（0:无效,1:有效）',
        PRIMARY KEY (`id`) USING BTREE
        ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='大数据推送状态记录';

        set @sequence='sg_self_chat_peer_sku_presale id';
        set @sequence='sg_self_chat_peer_sku_reserve id';
        set @sequence='sg_self_cs_order_sku_bind_presale id';
        set @sequence='sg_self_cs_order_sku_bind_reserve id';
        set @sequence='sg_self_job_cal_record id';
        set @sequence='sg_self_shop_remind_word_history id';
        set @sequence='sg_self_shop_setting_batch_remind_cno_history id';
        set @sequence='sg_self_shop_setting_batch_remind_history id';
        set @sequence='sg_self_shop_sms_setting_history id';
        set @sequence='sg_self_shop_sms_word_history id';
        set @sequence='sg_self_shop_use_analysis_collect id';
        set @sequence='sg_self_shop_use_analysis_detail id';
        set @sequence='sg_self_sku_ov_presale_day id';
        set @sequence='sg_self_sku_ov_reserve_day id';
        set @sequence='sg_self_sku_performance_presale id';
        set @sequence='sg_self_sku_performance_reserve id';
        set @sequence='sg_self_sku_sov_presale_day id';
        set @sequence='sg_self_sku_sov_reserve_day id';
        set @sequence='sg_self_sku_to_performance_presale id';
        set @sequence='sg_self_sku_to_performance_reserve id';
        set @sequence='sg_self_sku_sov_presale_day id';
        set @sequence='sg_self_sku_sov_reserve_day id';
        set @sequence='sg_self_sku_to_performance_presale id';
        set @sequence='sg_self_sku_to_performance_reserve id';

        set @sequence='sg_pop_chat_peer_sku_presale id';
        set @sequence='sg_pop_chat_peer_sku_reserve id';
        set @sequence='sg_pop_cs_order_sku_bind_presale id';
        set @sequence='sg_pop_cs_order_sku_bind_reserve id';
        set @sequence='sg_pop_erp_recal_recored id';
        set @sequence='sg_pop_job_cal_record id';
        set @sequence='sg_pop_shop_ov_presale_day id';
        set @sequence='sg_pop_shop_ov_reserve_day id';
        set @sequence='sg_pop_shop_remind_word_history id';
        set @sequence='sg_pop_shop_setting_batch_remind_cno_history id';
        set @sequence='sg_pop_shop_setting_batch_remind_history id';
        set @sequence='sg_pop_shop_sms_setting_history id';
        set @sequence='sg_pop_shop_sms_word_history id';
        set @sequence='sg_pop_shop_sov_presale_day id';
        set @sequence='sg_pop_shop_sov_reserve_day id';
        set @sequence='sg_pop_shop_team_performance_presale id';
        set @sequence='sg_pop_shop_team_performance_reserve id';
        set @sequence='sg_pop_shop_team_to_performance_presale id';
        set @sequence='sg_pop_shop_team_to_performance_reserve id';
        set @sequence='sg_pop_shop_use_analysis_collect id';
        set @sequence='sg_pop_shop_use_analysis_detail id';
        set @sequence='sg_pop_sku_ov_presale_day id';
        set @sequence='sg_pop_sku_ov_reserve_day id';
        set @sequence='sg_pop_sku_performance_presale id';
        set @sequence='sg_pop_sku_performance_reserve id';
        set @sequence='sg_pop_sku_sov_presale_day id';
        set @sequence='sg_pop_sku_sov_reserve_day id';
        set @sequence='sg_pop_sku_to_performance_presale id';
        set @sequence='sg_pop_sku_to_performance_reserve id';