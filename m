Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41439361DDC;
	Tue, 25 Aug 2026 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678423; cv=fail; b=JSnlv5uVeLjKmclFV7nI0jmKzShc6VNzvNkWb+spW+yN0rDYAiNC7i/YRuVDDr9ra9xWCV/fJ/W1qLnRe9M9ZDNhcrJnTI4zPmuTs2hb05w/uI0IB3wme8AvOV+SDSKTH2dfclYclclE4QbjReYT2YDGGA6ZUX+0eoLamw0+4xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678423; c=relaxed/simple;
	bh=zyzIHZWkbZiJeCTqvhBe5bpyE69d/84Z/bMFLKqBSj4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+B6m5InXSeMmAExCCyX+uoJnpvQTXnK+FmYABqdHtrf58D63Rs6+pfRQiN47a34FtXTKPyFQMVkU7oJxieQyk3UjFL8K1PVsPOa9U8T9wM9TnCXNsVRqNTEaiFxGRuO8zYOM+isiZoOfeYOUGI3QgzwmxfA+wzJQ4b1MGmrEkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Dnmp1Fmb; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uRicLuN2; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Dnmp1Fmb";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uRicLuN2"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PEVbZ92046023;
	Tue, 25 Aug 2026 12:20:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=NjiltEpWKo8+XGVIPeclBhOkyH3dhzzS6Rxspq0yy
	U4=; b=Dnmp1Fmbk4Q4dVKJ4U1pZKTwxIcn2AR54t0lh9MUtOhwLtY5Iue7D0xP/
	xHreHA7VJE35UegK3WpOEz8ns5Tb6CST4+0b/TBNesOoBVQING06hBemuSRNmAEd
	T2zDymB+KvGEP+EacjwBLE8VSdHq1QpWYxcDl2ohg/8Y2v2E2HUkyAy+Ts6LYvfU
	2RG8MyVapp+ob34y3YG01mF4cOMG6m+fy5IerN12q33AZbUWxTfUqmts4WQBy3yf
	fsh3khxJHsTCDOP7lqNmxG+7aj2lkZ4zfZDh7YTKLOgNyCmFI9aTeFu9r6i23YS7
	iGzsbN+wUQJe0ia6YjX97CBppVR4g==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g92xnm9n8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 12:20:13 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cd6axpU23IgZ52MNZ+/icW9rKmgOWok+SOzOjLfSDGa2bfQoEiAvyJ36hZbtcjGFfXJFEKCto3t8frtCXBKQCKbgi3AdJ4n+qNvZ5kuFe5OKgPWIICCiKlIsbDYXiSl0Z5/elc1rmB0iKrqJ8S9S36Cs+z0+vCOS+GzuWnqVRisMQLwC3ej8bRAJ9JSWOZabCvseCf+/8Bl4yocKyuh3YNfFdvJdMmVHDb/qgH4UVA2rLWePmKOqu/cgH5sskdc/rPOpwuE8U7VU/6AGwXpXOj4CeXDh+lbRkZEhtTKQ7j74wlo6dUZC18OynLJ+iw/HZd1gLK1pClMDoOoyKZ1OUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjiltEpWKo8+XGVIPeclBhOkyH3dhzzS6Rxspq0yyU4=;
 b=JXdgJmbTAeOjEMbk45LyorJytb/a4lJOaV7Hhgtr8ppEHAF3xFhSzWbU8p65dijuqTUL+PlMWgqGX87WLMdE1qry5PiZZredPiSGLvwBJrEAugr9ma9wSkJP0LNlGq4TrLE4guunlXpSD11qYybuGTrVfJhnrkN3LgpplYExCVTyGLTMpn5ICiivdFaGxDwDrX6qehutKfuhikzTuC/rd9Cjy75qeXyThW754YDIYjvETYsu6gjWp/34nEall+DV8eG4fldS0wwOOWWXDk73aJ3Zkf1kVVYx5xIK/+NuX/8PY7f1PIO6KsB25+3+hKbwHvXF0GvfzHhev8neYezEjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjiltEpWKo8+XGVIPeclBhOkyH3dhzzS6Rxspq0yyU4=;
 b=uRicLuN2LjkKeQSCF1tExmcXGKrfTZ6FHuHieuYK5TvNxU20rVtTC3bwsRTevmCvnEXeFjeebIep2iCmngpmGAIFVrjKSJb+nA2+ixTpQSbiRb7CNkfNo5+cD/p9MgVKzEUugXN5EP4A/zWJKp2e+uMfz4gfbSdM9LWEOloBfRI=
Received: from MW4PR04CA0210.namprd04.prod.outlook.com (2603:10b6:303:86::35)
 by IA3PR10MB8020.namprd10.prod.outlook.com (2603:10b6:208:50d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 17:20:09 +0000
Received: from MWH0EPF000C618F.namprd02.prod.outlook.com
 (2603:10b6:303:86:cafe::70) by MW4PR04CA0210.outlook.office365.com
 (2603:10b6:303:86::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Tue, 25
 Aug 2026 17:20:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000C618F.mail.protection.outlook.com (10.167.249.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 17:20:07 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:19:22 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:19:22 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 12:19:22 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67PHHf3g1436664;
	Tue, 25 Aug 2026 12:19:17 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v9 17/18] mtd: spi-nor: extract read op template construction into helper
Date: Tue, 25 Aug 2026 22:47:36 +0530
Message-ID: <20260825171737.776052-18-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260825171737.776052-1-s-k6@ti.com>
References: <20260825171737.776052-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618F:EE_|IA3PR10MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: ab2882d0-ffd9-401f-b074-08df02cd1c4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|23010399003|921020|3023799007|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Qj6OX1AXU9aa6ixMng6/8ffE9uORwLw9sE4jGSwcJGWg3rU4LB+2P4RfBVSggu3SB6RNaviEOi4EpJ70u2bxliswKASN0hlEdD3oKA5FpRGA7p+52n9aqDVq/FgFrLV15twNV6PgHx2sBlX26BtLsRBSK0fvtMoP0z1t6Jz9f64kY4zOY7FLm2QuButB5cxHcEHlywPyFIpIsUBsJXWvtBPO1s8cWd+4xlHg/cGUBKu5FOVPPiM3b5Ta3g+BPosCHfTDx58HC9xRufZ6kRhjVSbywOlltQBqwHV0YFkHwWoQmVSSRkxh2K+oQI20yeCsDWYWOdQp7hPCKzgkX3sKgde+LDOeH69vjP5GB4OUZyTy7X3x3921l2m5l6RPiSi0tXzaLv71H/N1/L1ZUdWL5SgS+dCfcXlugP+S9Ipc2910ztiXs97vbMiC/ncMg3zcs8z0MB43+VrTMOJO86GUe/yvOfKJjTyZt5HDRvNgv/OqQi261opJ6wZQ7paEfsUkFo8ElSbwyrYh7U8f2t0ZIDDRwl03lspwqI8f5o+OK2GPAkJ/4ftXDbWZ45lKa1krqJeplet717dMjhkdOSW7ETVPrtZvhuAh9fm0wORAI40FWvYZ2KxHwu8EteFjZRGFk1XKbZ2z/T+O8P6g8UZcbOR2QEzGAwXZqtnws5YvAS84p400DB46ZJ3A84ZsrKVO29jj3gi0qkQbwVM8jEvMDbXjbJR957aTTQIHCYaCytjJcLlMuTMMXP/g7OOGaz65
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(921020)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9zMtYhupqeneMNz9edySMFl3N3WiI6bEAYc4PMunGGk1XAS/w+bllxy+R6GcogdYL4qxQF8K9Lm0Te+14POGXcezMi+DjMQ2KX98Gu+23nHoVmeg/p6wt3Ar9S/LPGTWtixSKb4ExCccw28fO+xF/rVDjFtWxmn3xPwnQVVbKQFp8tlknlwyLlqVCOkbB9RVOKBhdryPSv5xbca7QtlcuVruGPbfvuLeTqY6yQ2sUR+IW3JGJxhxG+bW9jZ49Y9zuEIbgY8s42OCLvvO3zurY0Q9g381P11jMBpJjskMliJ68wRKzmY9UZALBvjGHm4Dto2+kawY18ORVtJVl+u0a+Tp5vy1kD+PstEeqAtCiJbvhYFCr+uxJzvWpIa7OpMF8UFw+ZZ1GyjN5Lt0cBSdcJH+2iCE/f5td41tbhmoknUZVNdpOCQpHT3lJvHBWRnj
X-Exchange-RoutingPolicyChecked:
	P1re1VUydztpJ+90BdTr/O2T1n1INp8V5q6jt920e1xAP7V6cUmQJ2yzoa07E9qR0Pop/1s2NVuJErDCvgAhuoPt7S4WFw+6mEb+TLaCBOySkqdWHe0JbA60BPL0PRkrrDHBRaAa7JEfAVIlFOQXWy5dvzEkPfMgAK2wREiV4wuYDeyz6veJ2b+H8N7GS0DsekIKfG9ZcmeKGrTmF44xMaCwFQ6eaqxVV0rKDQ+2WIwumHrXO1zrgHJgJ+Z/rBKFa38j7R/sLR6apYs6cLxIgEC52NXQp51+iFuKY8qNNa7fj5/SkExWl00v2x3GCOMjVBugV/5VyRj+ssGhb1bRdw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 17:20:07.4907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2882d0-ffd9-401f-b074-08df02cd1c4c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8020
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfX9GoJNqsUgPai
 DW6AslgGbotH+m7yPpkFuh5DyQubvq3ulgN9JT8SuNK4shoDn9B2CzhrHgcK65B/AO6q6ArPjf1
 ei5mIGERQSYxBTxoeyaytBkfzRfbIQk=
X-Proofpoint-GUID: _-2dlYaMrYLmNe0iT_GHLbDUGdH8_3Lm
X-Proofpoint-ORIG-GUID: _-2dlYaMrYLmNe0iT_GHLbDUGdH8_3Lm
X-Authority-Analysis: v=2.4 cv=PsijqQM3 c=1 sm=1 tr=0 ts=6a8dcecd cx=c_pps
 a=MBvOscNZ4ImqL1nQClNoCg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=XAftrYwPDLqUVEEHSKEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfXydZ5eqU/rRTr
 QYlTb6VeTJ8jDADpZOVGcCyJb+F7CD0FgltXjEYzftfVfonMR5jP5YGCQCBnm9l/GHPldTu/JQR
 Ik+YQnFnNvFB+nTfr74smeyS6sa96MWOIklMcqTyHgbF3w26HfvQc4P5CwZHyVmXr/EDlGAH5go
 ijrhMa0j2u4r1v5dk+JAIVUcxWobpe/WOvWazdxEVxt2M54vZkm5D2CUnIeHyUU75KbGyC70Z6W
 xByBPCAaubgZwa+CzcBJOP5u2TZkP8vfD2OblrrrV6DElPVLHRiCMgKQqZhOPNNFGypgmRezT0X
 3HxUFYa2aluMv0pC7lJjETeu7AXyQ+yGKXr8X+YbTNMcRGN6+OP6LkaX/QBtsRtUoMSnWuhiOrt
 V6JitYmlUHddaT4oc4WJwpPwksUP6+uVFrlBo6mCJ2LjRPQZuo/LdUCLSOi7xkOJueHPcH+ohkK
 T9xrZ3zVhtYaMaNvI1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250147

From: Pratyush Yadav <pratyush@kernel.org>

Extract spi_nor_spimem_get_read_op() from the duplicated op-template
construction in spi_nor_spimem_read_data() and
spi_nor_create_read_dirmap().

Using data.nbytes = 2 as a non-zero placeholder lets
spi_nor_spimem_setup_op() configure the data buswidth without a separate
override; callers replace data.nbytes with the actual transfer length
before use. No functional change.

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/spi-nor/core.c | 66 +++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index ccf4396cdcd0..b683c077a233 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -188,6 +188,37 @@ static int spi_nor_controller_ops_erase(struct spi_nor *nor, loff_t offs)
 	return nor->controller_ops->erase(nor, offs);
 }
 
+/**
+ * spi_nor_spimem_get_read_op() - build a configured read op template
+ * @nor:	the spi-nor device
+ *
+ * Returns a spi_mem_op with the command, address format, dummy cycles,
+ * and data buswidth configured for @nor. For direct reads, the caller
+ * must fill in addr.val, data.nbytes, and data.buf.in before use.
+ */
+static struct spi_mem_op spi_nor_spimem_get_read_op(struct spi_nor *nor)
+{
+	/*
+	 * data.nbytes must be non-zero so spi_nor_spimem_setup_op()
+	 * configures the data buswidth; callers replace it with the
+	 * actual transfer length.
+	 */
+	struct spi_mem_op op =
+		SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
+			   SPI_MEM_OP_ADDR(nor->addr_nbytes, 0, 0),
+			   SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
+			   SPI_MEM_OP_DATA_IN(2, NULL, 0));
+
+	spi_nor_spimem_setup_op(nor, &op, nor->read_proto);
+
+	/* convert the dummy cycles to the number of bytes */
+	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
+	if (spi_nor_protocol_is_dtr(nor->read_proto))
+		op.dummy.nbytes *= 2;
+
+	return op;
+}
+
 /**
  * spi_nor_spimem_read_data() - read data from flash's memory region via
  *                              spi-mem
@@ -201,21 +232,14 @@ static int spi_nor_controller_ops_erase(struct spi_nor *nor, loff_t offs)
 static ssize_t spi_nor_spimem_read_data(struct spi_nor *nor, loff_t from,
 					size_t len, u8 *buf)
 {
-	struct spi_mem_op op =
-		SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
-			   SPI_MEM_OP_ADDR(nor->addr_nbytes, from, 0),
-			   SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
-			   SPI_MEM_OP_DATA_IN(len, buf, 0));
+	struct spi_mem_op op = spi_nor_spimem_get_read_op(nor);
 	bool usebouncebuf;
 	ssize_t nbytes;
 	int error;
 
-	spi_nor_spimem_setup_op(nor, &op, nor->read_proto);
-
-	/* convert the dummy cycles to the number of bytes */
-	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
-	if (spi_nor_protocol_is_dtr(nor->read_proto))
-		op.dummy.nbytes *= 2;
+	op.addr.val = from;
+	op.data.nbytes = len;
+	op.data.buf.in = buf;
 
 	usebouncebuf = spi_nor_spimem_bounce(nor, &op);
 
@@ -3712,28 +3736,10 @@ static int spi_nor_create_read_dirmap(struct spi_nor *nor)
 {
 	struct spi_mem_dirmap_info info = {
 		.op_tmpl = &info.primary_op_tmpl,
-		.primary_op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
-					      SPI_MEM_OP_ADDR(nor->addr_nbytes, 0, 0),
-					      SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
-					      SPI_MEM_OP_DATA_IN(0, NULL, 0)),
+		.primary_op_tmpl = spi_nor_spimem_get_read_op(nor),
 		.offset = 0,
 		.length = nor->params->size,
 	};
-	struct spi_mem_op *op = info.op_tmpl;
-
-	spi_nor_spimem_setup_op(nor, op, nor->read_proto);
-
-	/* convert the dummy cycles to the number of bytes */
-	op->dummy.nbytes = (nor->read_dummy * op->dummy.buswidth) / 8;
-	if (spi_nor_protocol_is_dtr(nor->read_proto))
-		op->dummy.nbytes *= 2;
-
-	/*
-	 * Since spi_nor_spimem_setup_op() only sets buswidth when the number
-	 * of data bytes is non-zero, the data buswidth won't be set here. So,
-	 * do it explicitly.
-	 */
-	op->data.buswidth = spi_nor_get_protocol_data_nbits(nor->read_proto);
 
 	nor->dirmap.rdesc = devm_spi_mem_dirmap_create(nor->dev, nor->spimem,
 						       &info);
-- 
2.34.1

