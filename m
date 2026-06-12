Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2123.outbound.protection.partner.outlook.cn [139.219.17.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FA03EA940;
	Fri, 12 Jun 2026 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270018; cv=fail; b=QHeObApM0CeKWoCz+zJT0TuuRo8BRIPrOkNrRB8Lv1j1epsj4qbJAM/8pTnfx7k0i5jQeGyETee+EWibjKK7bkcY6UwEmPJq/1x7fZJcWzCzelfCoPm/OvqPcZokjAvr36AiYK07c7oZ/krsriUzkuY5MBwdJX0pYiK2XWzKt6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270018; c=relaxed/simple;
	bh=WKs/+BVroKcxhyoN9GXRTuRMhgjUaA7f5gRB4RJl/RU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bjKBgnTF5Y2sik5MNs/jDIz2yzoy8BWb0NNPAGso8zzZNrsb7FPHqOw8qqGAuy0LqT1dgY+bbysoUDRKo/J10RNCPMVoY5gS0pl9dIgITQSmEdulkTuJd95EDTcCIQKU3odoIzo7d+ygHCyv+PDmx+jUrmFz4fS5jmeVS3xAngI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TV0b7BvRR+/jS4D/dKmt5cmCw3GEtF9RY95OqkXyAXHkvMHfg+or9YuQMiv2V+Ri+PAnaIwqkZvjnZAd8PfooVHfQsmBemqS8/GIY9WnuxGWggosZ4HB6UqsS4uXqHbjhFa/Lv/kHvPTqtLMLXEOk226RF+7Bo43deLTKL62EvivNtwFOQAQqNaEwjh5LuegUqzRkYVkvMk+R+450Qje2Z3IMC2tx5DIiR541aiH6w58LqFgRwyMyoKRv8P5WUFDTocqkXhrhzpg6oY3LV4iRU+u5cjJdd+wDmU+JNjpchTlvsyksMzyFrxXhMKuY/OP/DiaZk5qubrg+YrVDYXmiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snGAmiPzCbI2MCF5iBofbJu9tA6iQmGRMbZmGltHpw8=;
 b=WC+E2wLqwrfptDk3gPsf79cOes/J3gEUOGpaNkL+7OIbk+usuNX1PWiJKHtAWvYDKgnZWTmhrzvY+PVvuVBozX/3vbMWljWXCP5OidDwAcfre1Cf98Nm3GpVpoYKZNmQ5Bqyek7gW1y7ch60Yclg5iAPFRSmpZCCVO88ZFbrdClULpuHlt54Y+3/GSdcPQAOFzqLOalAT2l5jL996DyOkayqhyv9STM1AX//oxtm+JGMNKoq5/628I8zWHFGXmympf/I9aWIprTssWMrRF1ecptNZVpomUMs0F+A72k7W8wc6t8XcPg+yl95UOpkR61sIhdevlvkALA9e9giJ8rgJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1201.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:13::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Fri, 12 Jun
 2026 12:59:10 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%5])
 with mapi id 15.21.0113.014; Fri, 12 Jun 2026 12:59:10 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v1 2/2] spi: dw: Add support for snps,dwc-ssi-2.00a
Date: Fri, 12 Jun 2026 05:58:56 -0700
Message-Id: <20260612125856.8530-3-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260612125856.8530-1-changhuang.liang@starfivetech.com>
References: <20260612125856.8530-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0063.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::30) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1201:EE_
X-MS-Office365-Filtering-Correlation-Id: 322ccde9-edf2-468b-e872-08dec88264fd
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|1800799024|376014|366016|38350700014|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	PCv/l5WWbYmYGSvm8bL/8lP3XVbLt42C1z9HfTvOMRn3IujlIkgTl2qx/0ffmaSL6t8E5ElCKVdnOIv2E0FBsuB7WK5JOaYNUSMLvOkE7tIVmCaP/o/chj5TBWOpVHoHeq7JKe4G/SbzheTztc0++OhIrFJoktll7gvwL6kl345Wy/CwElg9dqzBuOG5SrTX98ZS58QbB+m4mZWCT7St9x6vsc36TBVk2VRuAP96iDUBC7qahwbSEhkFks3+RBuxtigM5RdwDthx6f+cYgBguOYtuvRJeM5qMoDpp7TJu+RdOZItR/nACEMeSGivnHq1w4Nh54NRNSLwnZu+I5zYYq5lGKBDC3aYsmjvHN7AtwJdShl/9IetS059xMHzKRtx+Diu8+HKfn0jcSpRvF/hitdrSbCW3C8F9EYM4Pt71j8fhP2l/O64gpTe0fEIHFHWTJdbXt2q9+zYkhquH10MS0AUyMLCc0g5nNJ8t92jX3PKE7b2K3xZqPJHifzJ/kcSGLXEe/D/vI4F5if2DSawVhMDdT2HVhwLJdcSxIdK0FrBwQexybdUtlrkZNCXV+Ef
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(1800799024)(376014)(366016)(38350700014)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tOz+sfkLAj097Sudk4UktFJzZHKsysdMOYJ6x/apMsou6UzNIuFSJfpXCHoI?=
 =?us-ascii?Q?YoXuY23dZu5SX7IifhUtSMNSMql1p2LGtK6PaL08oPU6+9DZM4OUo4CITPZe?=
 =?us-ascii?Q?5HSscC8VT3Kx++Faay7Q9q6quESBdCwxYZw81KYGjGJYpbU7Gpd/rwD9TiPZ?=
 =?us-ascii?Q?d2au8fMnBm9JliqbeoTcVonHaPz9og+XafeKUHNxRrtGdX3s74zjYMtKCebz?=
 =?us-ascii?Q?wh01ARdBML1pA7PIjVCsvS2KXEtWotk8EuIQiXMaHyFRIzaajIkZgZMeQnuw?=
 =?us-ascii?Q?Sywd45Tx1b9esh7OqEN3Y9EbDNZ/xhfKBnhnf0HrWYZKHP5zCJ5mFiRYVEPy?=
 =?us-ascii?Q?5JENpGbY5WVcxULS4MSiqqMe/tv94S+8oHqKzdYLHn/4b7erZCOWru2g17EO?=
 =?us-ascii?Q?w9uiHznOOQwHepXa+4jU1LVbJrB3Fn04NIV9jgAHrbbP87hR5BOHApkfX5y0?=
 =?us-ascii?Q?cKLfJI8Sx/sCiZIsAtbCW1RSewVvVErCYQ6xn4eHCzihxr50YcSCK256bcAF?=
 =?us-ascii?Q?3ZemtXc6x4DFi7nzYRi//x+Z7G2yom85crdx6bUMtkPZY+4gped6gHLL0y7a?=
 =?us-ascii?Q?T1BUclx+nc/S0vyhkcMPQ1wKrNURGIvdXYZGuMAu2ahq2qS8vRu08B1Jwvy9?=
 =?us-ascii?Q?0aYpM5rhaJSeYOQ4ETfKim8S18LMzTHmuprldG/Yb0jESMS1Js3BPWjkoYuR?=
 =?us-ascii?Q?NuH3TraDcCokxf9Oysf8+7DB6xyndIE0WoPCinnWvabi2aXBZgW6SIHeLrCb?=
 =?us-ascii?Q?hWxAvldU2j+XEHvhd4cJ103Ymq8to2tNIYU7ES16fSDfYeEy6RYyMfAF1E4a?=
 =?us-ascii?Q?pKK9pLBv4h24VdBODbLNhTC+vfRI54BvD6lIhgXPqgoyGYKhYnS63iPy8gFm?=
 =?us-ascii?Q?LUm2t1PuEElXhXEDrZ8kA0Gh9opLksQx/C4pDkikjAFKTsZlAPkymueMnLPi?=
 =?us-ascii?Q?27XUeWTcxIoZlIh/b7YoemBa8EgXDq5URI8Xo1Jp9E4hRP7HFahKz/+tn9Xp?=
 =?us-ascii?Q?cjGNCFFRXMg+l5q5AGjBck4shr5/XjPfATowAAZ4U+35LAAbVNYwQbR/vrE5?=
 =?us-ascii?Q?cFWktO1akCmgYK5ur0h5JbKRu6Z+n/bVuutKte8LoQ28w5qEox3GdY65ewg7?=
 =?us-ascii?Q?B6jd86hCu6RsqRoZJC2OMduexxq7qzD+9IsDrVsoy+xqPj8lz0/BU0SRzXJ8?=
 =?us-ascii?Q?bvpB/Ev1HUEYywtUmtzxRxMR4ZfRaiK0fAxw3kEtsEYkWV21uS+gb4D1PS5h?=
 =?us-ascii?Q?nNjci0jV9aCsOvhe2Qj3rAjrQZs5SXkdZMLS+lvBFRXqIqyM2klaUzRA72QU?=
 =?us-ascii?Q?ElwTRW5bQHTdU+N1L39NXpNbJ6+7lI4U3z98tUCttTPCjEANWM5AoKdic0wm?=
 =?us-ascii?Q?qQOF/VZoQseKWmhPiC4ICv9KB5SpFkGkRUxdkoAGlZ1adQjjINR77fbwJspz?=
 =?us-ascii?Q?9AelsVuuz/LUna794Iu+xgFqYmRvHMtH2L4QgJbWvyzR/cVquelhPHDFm+Qn?=
 =?us-ascii?Q?Y1S9pYLiyaxk0aey3iIG8U0bA+oVV7frzDROqnOCQf98+1cCQ7HHPsU0aiN6?=
 =?us-ascii?Q?OMMbbHwD7nkglU67f1kuBu/JFPOQ39uBbnlE088QIGQWk/rLGlVwJ67OqVfx?=
 =?us-ascii?Q?nqYQX+EVlta2barY9EIM36CtGmdI91JbvWEzo04Q3eGUDLM/t+iakIWOwbzb?=
 =?us-ascii?Q?M0UOHaUUcxJ4wDleqRO7m4tTpCKSKMKDKfwr/UZf128BJL/UKbOM+M+OsGR8?=
 =?us-ascii?Q?N7RirYfXfoQQ0/TJKKXswc4212lnkEvsN1VNSRK6kCW79qx49Pl4?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 322ccde9-edf2-468b-e872-08dec88264fd
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 12:59:09.9594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRWC2jlfmR7LycHGj1YUUU8RHZ0YGsffaGkRrIghff+zYyB66gB2vxlZdiRSSuHP+IaxTmNmgGQ5rA2UMyJ+CzQLjIt2eUZnkRi/HPzLcNu/P5j5Yd0dyostM4JQd/CQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1201

Add a new compatible entry "snps,dwc-ssi-2.00a" for the Synopsys
DesignWare SSI controller version 2.00a. This variant uses the same
initialization routine as snps,dwc-ssi-1.01a (dw_spi_hssi_init).

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-mmio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 4fc864d38cff..603e81a92c57 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -438,6 +438,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "amazon,alpine-dw-apb-ssi", .data = dw_spi_alpine_init},
 	{ .compatible = "renesas,rzn1-spi", .data = dw_spi_pssi_init},
 	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_hssi_init},
+	{ .compatible = "snps,dwc-ssi-2.00a", .data = dw_spi_hssi_init},
 	{ .compatible = "intel,keembay-ssi", .data = dw_spi_hssi_no_dma_init},
 	{
 		.compatible = "intel,mountevans-imc-ssi",
-- 
2.25.1

