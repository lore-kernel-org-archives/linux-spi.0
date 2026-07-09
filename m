Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2096.outbound.protection.partner.outlook.cn [139.219.146.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B503C140D;
	Thu,  9 Jul 2026 06:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578356; cv=fail; b=PmjAImsY+eIXLVuMbfwgML/iYQACV16+AQqtXs+SzIpMjp17gsqRh22zTzx3CU5DfvyR7HOWGC22ZuGwuurhFx4AgzNgDE61rhefCM4ZMKV6xAf4GcDlcIu0jcqw430TGqcbgenotdDWu+sSobwWoIGgPyyEw1emMeGh2Ogf2Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578356; c=relaxed/simple;
	bh=hmf9j2i63gMsqRy7PiP5TN1QK5CsdMECT4bauo11+54=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=t8tixjefpboiXi47g0bZJgmCA45/GHakxUSqgXZGY/85JcXWOi+d7elTcjLbnZ/eLpHjBRtyccMUabRpDvDc4zptkMHz2ydpYO/i1PQW5dcmbM3ngItJssfRz758nlrxCQCXFk3sUH7gN9iaOzUsusDQ/FoCk8eT9ntGvzKUb8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H32q0L/p07YDhUKlqKL3fWqO1TZ+ZLADn50ReW6JeV7kASlVcps979DWeTgzTmHp7RHz0b9U2Bq59gfnsR3ogfMoALwogO7Z0jXvGzAfSlGp9c1j8geevFxyNJAaWoyAcn0aocSR3kuzoQsRCoauyhfq9hT5V2JmCScHQxRE7+mF6muiE0wucJmj1tMcoj78XfYTeKK3dmMwA0UABSKcJD/fVxLV+e1j6iHHSvZTT9C2UlyywaFwYtoXtjN078Ay+6+GuizRQHefJLyAVuKsBGoiT2Oqv3fG0za4JRP+ddwlsp/+o0d1ajx99HgZ3Dy9n4K7LEBXVitIPuVoC73g/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNu/z5d0YcYAvDBazbHh9We4FsyhQnbycJpASjFk7Cs=;
 b=gXXbLTLj8kwxHV3J387WLHoWbEmkImB6NQP1KQUY5rOdAxegFu/KG7UiojEgOyTxqbW2/lDfm+dJtcwY/B9J9B09MYRnK6rYWxyLeKYl/QE0qT79+gh08OHiMUgVaQqCol/kT/xCRPOxWWicBLMifnn17M5ug3YeByZfS5U4g1efsZLNLKsGqvJ3tYirbI3+yk+OvpEvvN9gwny2I+FsMbi9F2b+grSt/GJ8y/mYKgk6+xgEyb6lOQYYTttdJgfk/XejnUZnRb/+MqzuOJITiTjdnbdScSEW00bGDf4Qtv71o58b9VOEeQUVsiYbJdKvPPN9l3Boyl213tJ3TTxlog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1282.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.23; Thu, 9 Jul
 2026 05:52:16 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%2])
 with mapi id 15.21.0139.024; Thu, 9 Jul 2026 05:52:16 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Sudip Mukherjee <sudip.mukherjee@sifive.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v1 00/11] Add support for StarFive JHB100 SFC
Date: Wed,  8 Jul 2026 22:51:53 -0700
Message-Id: <20260709055204.138168-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0024.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::8) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1282:EE_
X-MS-Office365-Filtering-Correlation-Id: 8efc9f69-11ec-4f02-a849-08dedd7e3b32
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|23010399003|376014|366016|38350700014|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IQInybGgNBG0T/frrvW4IizcAjplIA1G10k8i7SaXBmYXQJEcZZLTr9yFvWJh99U8y2R+YV3VjEk3qO+mqWbSiusPo2NplMSPcTE32+RM3snBPLMOtJBmALbaTKeRwk7Y0vboZFh/jqjRhlb8lNmVYETAWW1w0ORzIiY9LLHIgK9tp4kXmJWoBDDzba0whc+PF08KWuUydO2snl/s3LbreC6BAGm0tgIMLYyePcwYZrfOjg2iNIRoqb+1pzHv7wGabERZorlGo1nyFUWaz1rQ1eRISgyhuu3bRLXmR6hS7majAKQJPX9TZF+bcrJ2CIuYVXTIQwVUXba9UhckksfB1La7novcs3hOj5+xlKR1VZTDxcQN3WlrVgi2Yqq1Sf1t/lrzk3NX/tmFo8sdQE6LBAogxEjokEODRKgpr4rwS0X9+XqHZIWjU8cBxptIYEGtkotDIH4Ybd/Esz4g3jVSMTzR0uw53oKiJdnAgP0LZauz7eF6vfZTHhx3Ol8peioEvdWT7OK3tuirGrrLFW46LHxade2YkSYzI5HxXV4nhl/q7zZ7QbLS3nVRHMz3lcc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(23010399003)(376014)(366016)(38350700014)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0uRUgELEiDnHWTsxmoerNI3ld5OGMZ+3SAyFXH1ErR9Cw6OOxzMw1idTZFpr?=
 =?us-ascii?Q?53p3ECg0PqW7y9BSqxZfMj2K6gktTc87dTbDpfyh4FcuCFqutEQSHghYq8xO?=
 =?us-ascii?Q?F4JKM+lojVMcoTATwppK4SrciUorwcfUxpKoMhf0tC3rfBA5VtMldOTte+gd?=
 =?us-ascii?Q?/pt1h4wtiANp/LDLF7icwZEMNn6nMTuuitnP2GtZ0qBdBNlgjJCCeCCjjx3Z?=
 =?us-ascii?Q?9qReErAKJckMZtnmAQPRCupi/3m2DG+ZBpQrnPnRzroPeMNWrcq0uhMDtEFH?=
 =?us-ascii?Q?XR5gfewZvdhx2c7RgG3aRfyeFOJh/NHfNkNpQINm6Q33RWXtgEFxCaSLa1xs?=
 =?us-ascii?Q?QwbjiL8VANq15rpTzBvn9iY7bW3/9XiH07plRh4CwNXUTAaegHgsU/z9BFde?=
 =?us-ascii?Q?NNueZe5m97l7uQR5w3+WP7r8+1Mp/sMG4jvthqgR4AAGmN68nNi6UCKAGVTJ?=
 =?us-ascii?Q?/Du5HKFIfJDB1o/KTXm5Ex7ZozZDQP0yi7Kr2mtUQXnGlsfs9VXDYK4KqZmn?=
 =?us-ascii?Q?roJpbocp3GTpkWTop1J2rgOg9mj+YfWvdo8OylqUtWWn/GsDrpPO8oj0dPVt?=
 =?us-ascii?Q?yfySXlfa3T5Ol6z/KE2D1c0ZOOtBx5McU6GgF7niYWxuGOOOJbWl6rsiqyIz?=
 =?us-ascii?Q?aOvGYko5RDVDWL47+OUSj/qWzNihMvNoSLe/8hF/sifHC/Z166wWH64KoNz6?=
 =?us-ascii?Q?0huH0Y56EvypIiTR3rMukzdAZrzNQQbJNJdwP976WEzxaliR1OEZD/3xIKyL?=
 =?us-ascii?Q?lBGvD1Njl1JCuAHG3BpsrDBR82Pgx2nr8MDM5M6A9y4/5665bCV7dgwIriJH?=
 =?us-ascii?Q?cDXRjJ8ZplvJBK6fIYOnb6/EbINbQpHta3SMst+k5OPHnInIUse/DHBSPsn5?=
 =?us-ascii?Q?ph3BBEAs29UQtZlvXS5T2u7Zg6M+O5eKkhoVXc9wgOZCAas2YI2ISMHKJWp9?=
 =?us-ascii?Q?MdAsPUp2+gHAsDKOYL3exG5JE2D86PpoqrYHZWQMJaaEbjewLsly9ckRdgNB?=
 =?us-ascii?Q?SWyuAbeSWqCntzUzwAxkUoRvlN5sWjmbXJ9JJLg5y/+fhwx0k32xzqzKO/V1?=
 =?us-ascii?Q?FzRkl7/e7kkgThg/kWT6H6OzUuLD+OkNWOFhF9rCBauopEEH66OpKiZkaPTR?=
 =?us-ascii?Q?owxGT/AGgJWAIi3BAmLUA+eMMrtfS9c72E5kpXfe+9zVqRrT3qIgSIrUyyAn?=
 =?us-ascii?Q?ngsQjHTUsh+OKlViK/fcX2dN9oBaC3C4Z+/waifbWNxkjof64ITad8W7p68Z?=
 =?us-ascii?Q?OECMC9YG/EkFqnxxZFEHHD/sz6gVCc+3awxGHtZnmiEXI6fb92wzSmiE+CI8?=
 =?us-ascii?Q?kO8iaR0BhAUsGVOutR5HKylbOAHEN2JgVbBjFx73ltSbvJKw8UxaxPHl4VkV?=
 =?us-ascii?Q?w31i5tGi/57x1ftjxRASxCP6lLneoQTyga6P332QjXmInxEB5C+vgStKQv9C?=
 =?us-ascii?Q?mdC0Hmov6eMOtMj8NmI9GK88lWFRa439SpGmDKgZpKI9zsXL0/QdYVEkGmd1?=
 =?us-ascii?Q?TsT87wp4rCj2dFG2AWk/XYRIavTZQfSahJoKOT52gISt0F/kh60yPK3vJ/Tr?=
 =?us-ascii?Q?/tl9ZRJK/On53/OtkO6g8QwlzfhB/vMMlNAmLtxqo5T8m8ldA/kd1GLKV9+o?=
 =?us-ascii?Q?EQZTXU41fo6mJab2G3iafS8SNuBXD/5luUdo9ZcDvNQkrGNcViwpSOrdDdRd?=
 =?us-ascii?Q?o9m1X/V4KzyzlochyPCA6g/XoCLIp8r7Nm8eTSgxVhy0qfsX3BGQuak52NyQ?=
 =?us-ascii?Q?TGMiPgr1c5PeuyWEclk+/WuPGD9ZUOR832Dfk4kyR59z7xcuUGjy?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efc9f69-11ec-4f02-a849-08dedd7e3b32
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:52:16.3370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wv+lWx7flE/YwBH8i+o+3odNwfx8MYu8Q7I+CK6TqgHg2tJTWtB0feEZsT/1faaEVnnuuw6iUXx+5Ssso2rBCQCHnrcLxQ+ys7ixB7JvnzX3aAZJdNYQeJAxL5+2ys3Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1282

This serial add support for the StarFive JHB100 SoC SPI Flash
Controller (SFC), which is based on the Synopsys DesignWare SSI
version 2.00a but with some customizations and it also add
enhanced SPI for DesignWare SPI controllers.

I picked up some patches from series [1].
This series depends on the series [2]:

[1] https://lore.kernel.org/all/20221212180732.79167-1-sudip.mukherjee@sifive.com/
[2] https://lore.kernel.org/all/20260521012932.24163-1-changhuang.liang@starfivetech.com/

The expected SFC device tree configuration is as follows:

sfc0_filter_syscon: syscon@14090000 {
	compatible = "starfive,jhb100-sfc-filter-syscon", "syscon";
	reg = <0x0 0x14090000 0x0 0x1000>;
};

sfc0: spi@18000000 {
	compatible = "starfive,jhb100-sfc";
	reg = <0x0 0x18000000 0x0 0x10000>;
	#address-cells = <1>;
	#size-cells = <0>;
	interrupts = <111>;
	clocks = <&per1crg JHB100_PER1CLK_MAIN_ICG_EN_SFC0>;
	resets = <&per1crg JHB100_PER1RST_MAIN_RSTN_SFC0>;
	reset-names = "spi";
	starfive,sfc-filter-syscon = <&sfc0_filter_syscon>;
	num-cs = <2>;
	status = "disabled";
};

I will send a new version of series [2] to add the sfc0_filter_syscon node.

Changhuang Liang (2):
  spi: dt-bindings: snps,dw-apb-ssi: Add starfive,jhb100-sfc
  spi: dw: Add support for StarFive JHB100 SoC SFC

Sudip Mukherjee (9):
  spi: dw: Introduce spi_frf and STD_SPI
  spi: dw: update NDF while using enhanced spi mode
  spi: dw: update SPI_CTRLR0 register
  spi: dw: add check for support of enhanced spi
  spi: dw: Introduce enhanced single/dual/quad/octal spi
  spi: dw: send cmd and addr to start the spi transfer
  spi: dw: use irq handler for enhanced spi
  spi: dw: adjust size of mem_op
  spi: dw: detect enhanced spi mode

 .../bindings/spi/snps,dw-apb-ssi.yaml         |  22 ++
 drivers/spi/spi-dw-core.c                     | 344 +++++++++++++++++-
 drivers/spi/spi-dw-mmio.c                     |  42 +++
 drivers/spi/spi-dw.h                          |  52 ++-
 4 files changed, 450 insertions(+), 10 deletions(-)

--
2.25.1
