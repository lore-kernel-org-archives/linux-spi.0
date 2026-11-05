Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876401;
	b=GWbs3psKNk1wyg7zQUAW7mIu1pW9o3S2sFAV7JS6jFBdG52dG2L/fDo+5xBULmNhn5YO
	 73qCMASXEBe2wnjP2IFJF3dxwOy7g3u6SRA8xStMmGjtNjMjsfg/5iy3WlfTw920tEwip
	 2xD020TXfdl0R+BPnL0aaHRVLjcbVLnsm45YJFdoR3Iwzyk2eDLN0tHR9+V4yoXYT3WJd
	 B9luFIyZy46B9tiidthhbV0DZIg2kzmUgWn66/gdg3yNeoUCHf7EriCvZQ/t6lF2YTHZm
	 qtf/AYTK7gTUjOIiGKfrdj/Fezn2XK6kJ0aGvb90nDU6SY7wCbaZB/Ag65e6JF97PAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876401;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=chSa5+Gpy+FiAI0cn0lqa5uMLTjYpY9iFMxEtxvkr18=;
	b=WUl/UjlN/x13bQlfwNMYqNSqmzhFTr0ERkDBQbW0DomaW/yVr7veJtUyMgPYbBVumO+H
	 iMxyfE3qY4GygXY2RNPK3Asq8K79+j7QUt/jLr8ULzZu+fRWCRaZbr3cVpEueIZTSY8DM
	 4OjVrGyEFQ2HPO8JzydaqR0F8zvozVNq+DypTN9qU9MURz85/vWeKNMswGZlxPfTgKyZw
	 xjk6kAOZ2Th8EMfAk9PPwzE5nCTvj5NHs1F59DfieA/vRmTtA/pxkfMGPH/EL0tmMhoKE
	 houylimSaG4V1ri6A82fcSJSOkvkIV1Z95E+yzVEpqwLviBlf/qmxiJ1+ZzBgpm7QfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=YN2EPfOi;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=W24jprYV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591DB606A335;
	Thu,  5 Nov 2026 11:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 591DB606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=YN2EPfOi;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=W24jprYV
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6A59vniq505650;
	Thu, 5 Nov 2026 04:59:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=chSa5+Gpy+FiAI0cn0lqa5uMLTjYpY9iFMxEtxvkr
	18=; b=YN2EPfOiIhvllwICo/KvnSY5+eoJl0wLnUXeJXbuy1QEVIdSu/2w7VmsQ
	emptV/wazAPWFHtTJC0ki+ENOWEEg7DK+7kKXmfAbMMbsCiHmaUdeXWw+qIFpfmM
	e2gnp26+HXjxRds3AmzITWsniUDFOQIHO1iPA1Sw3RmPWegz7JiniJxdsZHKO09c
	EytHsTie+S6Lu3HZ+4Kt4F7FrxeCtei7yEli+4yoxU76HnUR1lyABefvs/xafmKy
	EQidaODMElfpWEQjw+rwF4bcfSzx7wrY16VPH27p/pJloKkxneeUCtKVZl4sH5gk
	NPaIgugQKLIDdLIFBsmKRGjXXfpjA==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
	by m0380145.ppops.net (PPS) with ESMTPS id 4hrq6tgcg6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 04:59:43 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VscI7VhGmQeyQhjrvF5Tj5sm/V/YQm4OuQ6piHP00uf67h2kDmGb+0+s9IhkZFIHCcMMpH742hyzheZYrCOE7me9cMiJTJjTUklEKDgeJhdD6uF23CaOQfwpazZBu25S8xomPC8g0F85jW7s5sEivDikOQ0Kc1+BaLmREV2+y8Z29Z4+ottC+VSsZzgilRiSftyoe1+RstfaILOmth3XIQPlXpbmMey1040fQed8hVLrNdRbnPAVtcPnvWEfM8oe6HyLgD26X0Q/LFp5V987t91J/GM3RUzUkzqiqzdC5qW3iBiREiMsehUhEFF/8Eib/UNTF6tG9l3FJl5aPFY1Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chSa5+Gpy+FiAI0cn0lqa5uMLTjYpY9iFMxEtxvkr18=;
 b=YAFQIACgkgXKHqMUCnW8tVtmATP2kJFgR7r4DP6quf6LjucMerRZs3fAlDGKRRqqUJcgRHlBX5LvIET9jFnS5SMzeUd9MoenTIYVVoxJPYFxthyv7MErvXjhd3buwht9QWu4OM+38w2D4tUKqcM/f4wVotkN0ZjKfqNrA9J5euF2XPESn3K34vepBNqSdZCzIDf7q0OBPbRksRCkz/nsWOVPRn3JIHLhQPZMzzqR2D3o2bYIWSkhuZIniPSlSjiJ1R+l+heS+sDfoH2qXT/Gu+OLFGjsSJSYKb82eJQodydlHwOAHXm5rcOEy3Y+H8xegSYMgPu/UlmY+O1UFiSaEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chSa5+Gpy+FiAI0cn0lqa5uMLTjYpY9iFMxEtxvkr18=;
 b=W24jprYVBTnbjBMN3L87Qx4k4wpDehfM5KOeJ93SoIUfsR4CgYqb6TtCCJN6DKwv9AsLjurIhLhFr1sEdyL3Df6GMTw2yKje/BqS8jeKxJyGselM9V8RXZWN2r2thuipZSBXvJS+pEIlcxH0OclSk0pDBJK8R7EO43sIYWcShVI=
Received: from BN9PR03CA0513.namprd03.prod.outlook.com (2603:10b6:408:131::8)
 by MW4PR10MB5810.namprd10.prod.outlook.com (2603:10b6:303:186::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 10:59:41 +0000
Received: from BL2PEPF000352CE.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::75) by BN9PR03CA0513.outlook.office365.com
 (2603:10b6:408:131::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 10:59:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL2PEPF000352CE.mail.protection.outlook.com (10.167.249.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 10:59:38 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 04:59:16 -0600
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 04:59:16 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 5 Nov 2026 04:59:16 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A5Awg2D4171076;
	Thu, 5 Nov 2026 04:59:11 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <srikanth.boyapally@amd.com>, <m-shah@ti.com>, <s-k6@ti.com>
Subject: [PATCH v11 05/19] spi: spi-mem: add execute_tuning callback and spi_mem_execute_tuning()
Date: Thu, 5 Nov 2026 16:28:18 +0530
Message-ID: <20261105105832.2134313-6-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105105832.2134313-1-s-k6@ti.com>
References: <20261105105832.2134313-1-s-k6@ti.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL2PEPF000352CE:EE_|MW4PR10MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 328d932a-b1e7-4074-9036-08df3b2be31a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|7416014|23010399003|1800799024|6133799003|22082099003|10067099003|18002099003|261102130727099003|921020|56012099006|261022105027099003|261026140227099003|261021121427099003|261028144727099003|261026121527099003|261102123227099003|261022075727099003|261009223027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	4QxbYMuyaSIQfz1YJeV3YG28ZTX1dYRARxYiBpoKvDUrlPCX5fUAyWxibfeQY2NK/ZRiPsuE7tr4iacIywLU+AtLita+SAtjnBQQ5TA+40lRehOgi47f/xW2wm3KbB1SqRVhZ2xPLQ+vNrjU6TmobvUdylzrBWtwAqz/6lilKHWEUwWgTzMX5mymAVLuDOP6oORwE1LgH8jhdCqQPpFdx9XfDzp7WSQ2I8XazxyMX8pcR4XYrUjqw1BPo9pCk/6PCOZze3tZiINvdnAPMCWqRRTgBPD0jN4XXS+VZyfNTE8iPPAm7EdTVnmpyvShVPg2pv2Zooi8+pHjIYvk0Cq7YoHNgq+qlYUisUJFH7pVrdp1LpEF8d52CGNIiguR23pJcKCZ5Qe5DBJA0f+Gdjv2tYtfZHA27RP2dOEVCQACTAeeXELM93rwlqLcA4ATX1KRCRUOIitZKDgOwc+prGJX453bYNwaJq3i4QmYDKEULMLGWUXai1iMi6pOe7BnQOJLVv9nXrFH0HKeMY35JV56Mp20Pnh3zm0nm0lhaTHfhivrark5uQCAQeYpQsG3eFrRKIhUffzpQ820hbvwAvSF7WZL+C+LX+3zmsPEAKUDJ/khTptb1diBkqOGuOqcFCWmCbDuPhbOu4YLrdWYeQaK/1EWFDW4fK83TiL89YIT39/L+ZjVbd6YBXybeWOyUpOu4AfIgiTzFQo2xcsnhI5ZEO6ElUvbn7+oVVezEDtIqfau939x1VxFzgaPFtqQlyGP
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(7416014)(23010399003)(1800799024)(6133799003)(22082099003)(10067099003)(18002099003)(261102130727099003)(921020)(56012099006)(261022105027099003)(261026140227099003)(261021121427099003)(261028144727099003)(261026121527099003)(261102123227099003)(261022075727099003)(261009223027099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	k4yxqzov4StHToruIKk0TJpAnqhq6iy7e+qPhrcZT8HSdWDI4aUe3Dq0oYenHec5J1ySTPKWf1V9JTEfc6j0wdWsMhzOrRAmCdytpFgk+T0pyuZyhhI2R1AYjme/RVixmpNOhPezAxhIQsplQLXAn0x5s+0VoIQlRFPRghGCdnnuM1MJLgSzs76rUTteI7YV9PvnKw4HA5KH6N9vqgmw4ApJtQmjtD8GPXKFtQ5K9smPS3JsiWQMPu5gUTJTgC+95xQTEYPeupcTV07r6ZI32+jrz5p52J4+cHvIh4qqkEDQmfnfRdPKdM08yDEzHe7LQuvdl69DY1a4mmUNwsHVlCQRKU3rzQqLPG+qKJKRn1Md8ifQH4kvvzN/HiEFhnf8OO5uTwdSmpGn9Z40IAhnWhSTVs5PLmK5o5WQDXIumgzSV1E/v77JlxexMNWbzdEm
X-Exchange-RoutingPolicyChecked:
	QxSKIs1VP2awALnm7YS2IqsdxeAyX6UAzwWknm2/Q0pnN+ZXnyy8F3N74jeNVRvdr1us9nzTxVdn9VC7Fmzcgq+HSqFRDdfJA+CsR6V5EPTyHoNimw13ARrjboYkEba7jbmnzwNacoiCklxRGX9MSJuBqxiJdz9TgwjFXuxpJh7AGLwaWvhsHQkXyzLTuM3LojLaklwx+3dpFraJgkwOcGhwrg646Pp+2yARUXANPhQ0fpArgkDX+MWiotguFdJlET+RKZ3uCDBhcxKF6Ow56erLLXohXb8hjBtmPrba7m8dsktIs6VSCWKsbHIFWsc4QxkbfG/hm3ICmhJ92si/sQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 10:59:38.8563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 328d932a-b1e7-4074-9036-08df3b2be31a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL2PEPF000352CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5810
X-Proofpoint-GUID: Dmi2EFD9gvManl6Dm8xbGgZR6h44cIBM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX0BshftO5Yc0u
 FW+9dpFO+fXtK7fd7nwPbO2f7Nd0IlezDMLPP0MSyyKtiI9EXHJM6l4hym0IDNvNi1XWsMq1udd
 hEitVaSvwj+r21fbhSKCzvgVVlrPu/k=
X-Proofpoint-ORIG-GUID: Dmi2EFD9gvManl6Dm8xbGgZR6h44cIBM
X-Authority-Analysis: v=2.4 cv=Q6xHcI2a c=1 sm=1 tr=0 ts=6aec619f cx=c_pps
 a=YKnEkNs9mh/nosOxSBBx4Q==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=P-IC7800AAAA:8 a=zd2uoN0lAAAA:8 a=sozttTNsAAAA:8 a=XczTfz52Gg2yNcvB9tIA:9
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX60x2EUDuHqQi
 sdPw8/3sv/uLgOajFQn3O/+prdN6l9pjdFlYuuFEHH0QdNuzIYRyqtH1TJ6t6h/RfdSx5K50OgW
 T6TIbtGnhUqrsEeFQUx1qjgh57TzCTZcyWB4HqwUpV9UbBG+BtB/aKuJyR2tPzvWpeiwuto+LLI
 GKVDNFvMLpvI1dXjG2kTWCt3Oc8mqNGW07/Wf4Zf6YXZfHjsCDcnUx5FvMAiNIDce/0L69Ng/5D
 FDkyLNeXs3aKcofCTGJLEA16ers6izAXw/fQjwTlUa11h1RRkc4OaTWHSLwzul+28X5OkLBDhjB
 GDX7Og1cVytPv0+w3qT8xLEXv0sZaF/VWXu+/60AZrcJaN/JZY9CffWRnepcbkshuDMGNz7XESA
 HJ4JD9540FRoPTPCVIXGVWCndrQpFjIqoPFXK4HD+964goEQt1a6Vle4GIFYXD3kef647UV3RlB
 OP8WAZ5d9Grk01PlgBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1011 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050043

Add an execute_tuning callback to struct spi_controller_mem_ops. The
callback receives a mandatory read op template and an optional write op
template. On success the controller sets op->max_freq in each provided
template to the validated clock rate. A callback return of 0 with
max_freq left at zero signals that this specific op variant cannot be
PHY-tuned (e.g. a hardware erratum blocks it), allowing the caller to
try a different variant without treating it as a hard error.

Add the corresponding spi_mem_execute_tuning() wrapper. Like other
mem_ops paths it serialises access with spi_mem_access_start/end for
serialisation and runtime PM, and rejects GPIO CS configurations which
cannot support hardware-level tuning.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Tested-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
Tested-by: Moteen Shah <m-shah@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-mem.c       | 43 +++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi-mem.h | 14 ++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 7916387a4f1d..ff085b8bd54e 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -697,6 +697,49 @@ u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op *op)
 }
 EXPORT_SYMBOL_GPL(spi_mem_calc_op_duration);
 
+/**
+ * spi_mem_execute_tuning() - Execute controller tuning procedure
+ * @mem: the SPI memory device
+ * @read_op: read operation template (mandatory)
+ * @write_op: write operation template (optional, may be NULL)
+ *
+ * Requests the controller to perform tuning for high-speed operation
+ * using the provided op templates. On success the controller callback
+ * sets @read_op->max_freq (and @write_op->max_freq when non-NULL) to
+ * the validated clock rate.
+ *
+ * Return: 0 on success, -EINVAL if @mem or @read_op is NULL,
+ *         -EOPNOTSUPP if the controller doesn't support tuning,
+ *         or a negative error code on failure.
+ */
+int spi_mem_execute_tuning(struct spi_mem *mem, struct spi_mem_op *read_op,
+			   struct spi_mem_op *write_op)
+{
+	struct spi_controller *ctlr;
+	int ret;
+
+	if (!mem || !read_op)
+		return -EINVAL;
+
+	ctlr = mem->spi->controller;
+	if (!ctlr->mem_ops || !ctlr->mem_ops->execute_tuning)
+		return -EOPNOTSUPP;
+
+	if (spi_get_csgpiod(mem->spi, 0))
+		return -EOPNOTSUPP;
+
+	ret = spi_mem_access_start(mem);
+	if (ret)
+		return ret;
+
+	ret = ctlr->mem_ops->execute_tuning(mem, read_op, write_op);
+
+	spi_mem_access_end(mem);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(spi_mem_execute_tuning);
+
 static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				      u64 offs, size_t len, void *buf)
 {
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 0cce6b57242a..b69f671c40e7 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -348,6 +348,15 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
  * @poll_status: poll memory device status until (status & mask) == match or
  *               when the timeout has expired. It fills the data buffer with
  *               the last status value.
+ * @execute_tuning: run the controller tuning procedure using the provided
+ *		    read and optional write op templates. On success, set
+ *		    @read_op->max_freq (and @write_op->max_freq when non-NULL)
+ *		    to the validated clock rate. Return a negative errno on
+ *		    error. Return -EOPNOTSUPP if the controller has no tuning
+ *		    capability at all. Return 0 with @read_op->max_freq left at
+ *		    zero to signal that this specific op cannot be PHY-tuned
+ *		    (e.g. a hardware erratum blocks it) but another variant may
+ *		    succeed; the caller will iterate remaining op variants.
  *
  * This interface should be implemented by SPI controllers providing an
  * high-level interface to execute SPI memory operation, which is usually the
@@ -378,6 +387,8 @@ struct spi_controller_mem_ops {
 			   unsigned long initial_delay_us,
 			   unsigned long polling_rate_us,
 			   unsigned long timeout_ms);
+	int (*execute_tuning)(struct spi_mem *mem, struct spi_mem_op *read_op,
+			      struct spi_mem_op *write_op);
 };
 
 /**
@@ -469,6 +480,9 @@ int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
 void spi_mem_adjust_op_freq(struct spi_mem *mem, struct spi_mem_op *op);
 u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op *op);
 
+int spi_mem_execute_tuning(struct spi_mem *mem, struct spi_mem_op *read_op,
+			   struct spi_mem_op *write_op);
+
 bool spi_mem_supports_op(struct spi_mem *mem,
 			 const struct spi_mem_op *op);
 
-- 
2.34.1

