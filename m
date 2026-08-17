Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012049.outbound.protection.outlook.com [52.103.66.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26313FA5CC;
	Mon, 17 Aug 2026 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786979718; cv=fail; b=fOveA1rdsGnqN7Ko5sp34qn0+H8KDlqF6QVp8WZEOaoE7JWUBA7cO/+pyDQZwcaKI/r2Ol0Qla8YtH59lXjiDD6+UiH9KOZYg5g4CFAuU1np8keD9RcEmX8OZVJILmawS7GxYJu3wcrvO77IyiC0bm1A5GdkyiYhWeGPqTMWQCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786979718; c=relaxed/simple;
	bh=3z3LVeJxif4e5wOaxvj6mGGlWce4pp7+XEHC7q82qCA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=i4hB3GAnYldtQO3wJohV+LgUhILGYh9Iaiykr1JHyhqk/viXoyaKfOIec1yP/4+VJqTNSknR0mkPsNVk52f+9TF6VRUXk2WTFy16DvVNjmnpnbL7hQy+Pc7jO5Fxc0MT98nAQsKUk3XQr/jlsRPZO4KVTjBp3Q9wCtpT2Xq1TBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LyOIpjIt; arc=fail smtp.client-ip=52.103.66.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LyOIpjIt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Df9kUSPTgFuMrcsobkTQpslXaFarMsfWkNW3hYxc5L3TyBYPATsoXO1Qu5nbsbW3/Vfo+6Y0LaCahC7xWKmG7FepCvmSk4y+IP2PmNdo1E2OUn8NyRWY23BLICngxnjKAtSxztW9A3qsOgls9AvmTkPyYss6tp7Hglr7Jn3F7U7bA4sKFNExQrdwliMdP5Gv7ldebXRVzRLAj8iBkSUBSRJnbzxG47wyYojbT9T2Gu7RzIIWDkN4wVO28olMczgh/1dR1dsEJEed1xj70LNU7OcHQ4bl9cfh1YKUyJnHpSWjCjobfSW2Hsq2/burM6Eu16sqF/BlLtGOUNIbH/7oVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B084FPNLJf35yLxF2k5Xqat+T6IPRdQcmJhzw60WBn0=;
 b=GCenmrmkPeb/YI1F1mIc1TqsIAtd/j23FFxehc2JR8VOy6U80XY7kLOOMBJUa/Ui8LDPlUN+cXsshQ6OgiDozWTXjAtFT4h48jfx6yjfo7nhAuVJMi8l7xHacENTOvz+FXRsFWwRx/M7XSIG+2ty7p2eb+mBo51soxKDfwbOCDCV61bsVeGqciQn7BifjvUkwbnDUOuDnWzmaLi9Pi4oG68Z1hX3bEI9UCGVbunhOWq2frVFu7MIMVBTu/gMFwCsJ3ShcQ1WZpzcPSFo/X5jXic6Yog+7jGSy1sJNG2a1smmyXSbAN1bGXPSqBnA5OYU7/fPRkHpPe0vbz7rH5vC3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B084FPNLJf35yLxF2k5Xqat+T6IPRdQcmJhzw60WBn0=;
 b=LyOIpjItf5NcaSw6Td1ZKhIbbAQ35fKfNwbS9+YMsTtNbQR2Q15HIoLQxYOwmLz6B2WWsNKuhUdwWMXIKlONAwRjf5faLNd7ksxcmMxoW5m9Iz/8Agkl/xIJm3V8N85IOUtvuYEPhoUZyIG58TkXbZV7gORO8wuiHCyrhghuzx/3ahXmg8rQkZnjZoM+jJpZ901u0+vmsGR81RE80MhbBk1bfvfqy3CD4uwyIvkmzLo9tZ+4lIXH3KSINzasJ+w9d1fTu1CoDfyjbR5O+XyLDMls19LDIHJXBDBw1ACDRfkX1XlOorfDenkBVqPxFRk9WVO3VYATcY5PRfKg+10mcg==
Received: from SEYPR01MB5882.apcprd01.prod.exchangelabs.com
 (2603:1096:101:1e1::9) by TY8PR01MB8350.apcprd01.prod.exchangelabs.com
 (2603:1096:405:3aa::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 15:15:13 +0000
Received: from SEYPR01MB5882.apcprd01.prod.exchangelabs.com
 ([fe80::36dc:66d8:26a6:5612]) by SEYPR01MB5882.apcprd01.prod.exchangelabs.com
 ([fe80::36dc:66d8:26a6:5612%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 15:15:13 +0000
From: Ziyang Huang <hzyitc@outlook.com>
To: quic_mdalam@quicinc.com
Cc: j4g8y7@gmail.com,
	broonie@kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: [PATCH v2] spi: spi-qpic-snand: reject when no enough OOB space
Date: Mon, 17 Aug 2026 23:15:02 +0800
Message-ID:
 <SEYPR01MB5882463D860A9670617D5834C9A72@SEYPR01MB5882.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0041.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::19) To SEYPR01MB5882.apcprd01.prod.exchangelabs.com
 (2603:1096:101:1e1::9)
X-Microsoft-Original-Message-ID: <20260817151502.3951684-1-hzyitc@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB5882:EE_|TY8PR01MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c7e6f3-e894-4327-45be-08defc725587
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|51005399006|41001999006|15080799012|24021099003|8060799015|19110799012|5062599005|5072599009|25010399006|4140399003|40105399003|2607281247196008|12091999003|3412199025|440099028|26104999009|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hty06w427ijXFoTBUginoCJgftp70pkDbPdwjmZW+lkwa/EFZn6Y9B48uIX9?=
 =?us-ascii?Q?PLLErT99dktBiqh5k+H3NiLTv4jnxHoSfMsRQ/bsmV+JCRC61AhIhGhDs6Iv?=
 =?us-ascii?Q?+Uc5F0tODkzu7ahcOTRY+2Mee91MnLsYOceEGqXb8wSR7e4kz05AJA4ZL6PJ?=
 =?us-ascii?Q?nuuYLnpVmICez+HbBDdzyDRPuTVdqeW+8aoBsipn3cGhJCJfVScA44LZJ3dn?=
 =?us-ascii?Q?iiVW+zsuJyLmd4jhEUJcpzWCt1ey9XXk8MuTfkbRhKutCkK0LAxxvhgmLZfA?=
 =?us-ascii?Q?XxwaoAIQLma7evPhq3MSPNoSn1SFl3DlflgjpBEnodvWhDH93SYzREUKslcB?=
 =?us-ascii?Q?sTjwkH961+cZB8NBskeMZBKT908UPbcpWXxPFzYTiny92yOqfnxbnrc9UlYn?=
 =?us-ascii?Q?amaUyUjG1eeMnKyqcaKsooMJ9WxuIvgjY2kLygySZZFZcmIOnUQ9GpU1i2bl?=
 =?us-ascii?Q?IXxKMcD+Bx9kP+InCULBHxA7qTNRGpp1ySNKXThq/UfmWtrRL/jifHd4IHpR?=
 =?us-ascii?Q?KGFdIfXUyE9aLAZ5quPkkvY6+YLfhfvmXeRi3lbAZ4iJjbsA6X37wbARH/Yu?=
 =?us-ascii?Q?gm0h3E8TaQ/QsS++wIF3I7BD6L3+HcLNhk2kVHmACeSKPEpaQ2ShRvPK81MS?=
 =?us-ascii?Q?GExrzdQqeWahkJ9FdMQ49aw/pYpR8xxkVWXFPD6lIzsovHEcG9plTJP2EpI8?=
 =?us-ascii?Q?qyXRCQlrFnW5GIevExCV+l0kNcOkYs+uW+h6KemzWFZk9R2oqVE+cn46FS7C?=
 =?us-ascii?Q?Zt7EtVX6r7m8qV7Z4vWjzGNCEKHWB2wMD3sijdyXxWCUpsuo4c5/r+Kj5kSu?=
 =?us-ascii?Q?r4zNZn9XqSIz8jZlRZe5W3kK5brEhncxwhUpKcmXmWlYnTq97TjsJsAPh5ob?=
 =?us-ascii?Q?RbxVi1tFJhrU5Q7xX1ucwSNvMJiZwI7M8hLzImnygVlzBLJPWZk3QoSZ93er?=
 =?us-ascii?Q?8uQc9VkMfTxMm+hdizhhi7NY03QJyrFEEhMy44juGK5sz2AHOpGuHkh21mvq?=
 =?us-ascii?Q?jh0OJI2ohc1oz6ODuAzTas9sw3QnUdmmBXP3dao1mxowW+++A0H1UkVdCMyd?=
 =?us-ascii?Q?XpRNxcey?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z8Z3YQ1xwYKoTSBqbAufBJabZqAXbuKxC8ljjSjFYvcidrK3PVQy6d6gt3L/?=
 =?us-ascii?Q?iX1RPzgf14qXbzD7zgqafGlie/a5tgiEKz55WZMkfWODl0wvpZLkGURxmDhL?=
 =?us-ascii?Q?c2P+IdB5UJuQTx8c71y46onA/rUgCxsAU1GLHfbDyYZgxOpPph/NLcbKuDnC?=
 =?us-ascii?Q?hioryCvctoN3xV5I+Wrbs/em/Ze0SIIdmur6MgxD12VBDgKdppOOcm/VLdmh?=
 =?us-ascii?Q?NFeJCM02skDc0ipik2xG6EHzPu5X/ntWkEuJ37W/25KOR9RIRdOA4ZKMS2sd?=
 =?us-ascii?Q?K3acQLzPZAfRN8N3/CqGBa+hzRB1Xs03lmq4yXw4F8ZpVTtw2ScPBKMtAfMk?=
 =?us-ascii?Q?katSYRioJmLTEsSKN+JlvTfTYrWkNAIu07O91LPuA+VdG5j1rqrqXtqtEs5G?=
 =?us-ascii?Q?XKcFs3AHAD19y1lodR3Aq9NW5KJvxs3iFvMQh8FxxMBnIwG3UMjkLDtFikRv?=
 =?us-ascii?Q?SMkNQbLvctghLEwcWU8Z7Nhm84487d+UtdrqUMHe6Wuad6c3UxJf/CrEHX9M?=
 =?us-ascii?Q?E3lpENt3iifZg0I9qKIvQdcUerktlqRJ5LRM6K4Ijw1L3Aqn+YTG81itsnXA?=
 =?us-ascii?Q?Iv78Chzi6J/Mr5sraVkxzQ4stQhRGQihukE83vz4YvdT/rmhkwxQwg1wvo7K?=
 =?us-ascii?Q?5M/PKKcPAiLgb+6p0Z44l+7uOJ5AVu22RBe0LF8z00HpwpmtOkZ3obpqFfQQ?=
 =?us-ascii?Q?4V1Zuddut1SnqM5Ug/HVFXshBZcaq6KhocJpL4bJ4n7gLcbWUHo5c6HO9/ke?=
 =?us-ascii?Q?SIfmTM8hCIWcLF1eWnUfVXE3+EyUUZhJ1yHC2UdQbMalWa8kAr8dXswIgwcf?=
 =?us-ascii?Q?QJXiIPZLlgceEDjx+Yzi8zRppiRvwBow2g1nXNGEaPBtgmJQIa/4GytYdxuH?=
 =?us-ascii?Q?pLSlfPD2eP3rqNEntX0dSOzbnExrpz5ionaW8twMx4ydbgOaVi6cGgb3A6t9?=
 =?us-ascii?Q?YvUzxTCq4BdMwDIMI0UIPrLZFY6PV3dZXM05auejhn1V70jCPETQeHbyRPet?=
 =?us-ascii?Q?6BGg5pdZQSVzK2CNQfGUSN4sqz3BxmlAPU8Qd96U6mTdjxQr8qnWXPB5Fu5Q?=
 =?us-ascii?Q?C7mjTVOt5UmPQUMqIw1kI9XQ7O0UWg9BVJgGYHVB30ILfmcNo7Rl49pxd3NW?=
 =?us-ascii?Q?07BxQjzTNLX4+Tu9CL/wMsCEkCjhVRMgpmSvMHEq/E9wi4adSV6YJIlFzrMG?=
 =?us-ascii?Q?RA07TrNTz6EerlwG5s+Af04AB+FEj6GAWFdP9oRzT4PTniT4uhp7JUIByeW1?=
 =?us-ascii?Q?S5usXf0rT1G15eMrEzuMx6TLnxR3Tn2m8M/NtF+UWT0lig3itQeNcFeo8qCW?=
 =?us-ascii?Q?px15gYb7D/ruojhDQMx0wfZV41ziGYXkpdgpfk/jpe3oudip1otSS1MlK5DJ?=
 =?us-ascii?Q?4VOilaeuiBaoAL6pIH5v41TNN3/8?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c7e6f3-e894-4327-45be-08defc725587
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB5882.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 15:15:13.2103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY8PR01MB8350

Print a clear error when the flash doesn't have enough space, instand of
return -EBADMSG silently in read or write functions.

ECC4 requires 64B OOB space.
ECC8 requires 80B OOB space.

Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
---
Changes since v1:
  Remove the mistaken lint.

 drivers/spi/spi-qpic-snand.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index b6c58d9cfe14..624550bff40a 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -323,6 +323,15 @@ static int qcom_spi_ecc_init_ctx_pipelined(struct nand_device *nand)
 	ecc_cfg->cw_size = ecc_cfg->cw_data + ecc_cfg->bytes;
 	bad_block_byte = mtd->writesize - ecc_cfg->cw_size * (cwperpage - 1) + 1;
 
+	if ((ecc_cfg->cw_size * cwperpage) > (mtd->writesize + mtd->oobsize)) {
+		dev_err(snandc->dev,
+			"Current ECC settings require %d bytes, but the flash only has %d+%d bytes.\n",
+			(ecc_cfg->cw_size * cwperpage), mtd->writesize,
+			mtd->oobsize);
+		ret = -EINVAL;
+		goto err_free_ecc_cfg;
+	}
+
 	mtd_set_ooblayout(mtd, &qcom_spi_ooblayout);
 
 	/*
-- 
2.40.1

