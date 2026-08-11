Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BCE3C1D73;
	Tue, 11 Aug 2026 18:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473312; cv=fail; b=Jc8nfznIJBzOnt+nQITj2QQ7cidjxPRosd4EfiIyOQ4uRTFksAtO55fxHaPqs8+Opnsxc7jH3A0B7UKDeMlPxWDzDY19U2B/EeEbX/P7AzqlNa6XrvnSL+2p8YoMVo1tlqhZb4Rkc7ut2W6Hwf+k0c6BjZR8qqL7Xl0rYv30TLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473312; c=relaxed/simple;
	bh=F/AnUyhlV2AtS07KGqLS/htPuNT5wzyKdLdJIRHf0Yg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KalGT9oS3gwDNu/b2/8po4o62fSLIn7HJk6UdBJsddYPkrOKJtAKc0NIJyPOQxysjr3Cvkp17b0lv0Abfu9G7ILopPJK6Lkle22pdU5SCDuv8mrMeTQi/GYeXtrHCK8vtCukvqWWL68J8t/cpkZIyLcaP5iqZaQfNqAmwGTmxoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=KXyDUeW2; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MbrejMw3; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="KXyDUeW2";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MbrejMw3"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGMcJd2174910;
	Tue, 11 Aug 2026 13:35:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=Tt2uwvzIqMNehFK76PrQJ6oaooM0SB13UAqWfokUR
	pU=; b=KXyDUeW2ISmVZ+b/UqMP3eNIuS/n2NqQgbstkjfUkZQmoNiUTqjiUFNx5
	AYjO4rzqTwM/rMaEOWxIoYuJQ9l2Etb4BXz0ttTDoIax1mw8BMzXR3FJdWf+tOwn
	Uqo6F86vfvd90HWibu/F0A5pyA/Np6wUhugOtkd6yQYfdD5IkeRZ77XweMnLrfVD
	mAhWJq9wTT/piJ5B1brkpwUIkS4WFlvUSR9VVRAkzA5y/dDYGpgzXxNq+Ct+5AgL
	AlfiJrFd5HedVeM5VtnaUEUHKoss9Sanlax5TzQtV7oHG/8txpQ4b5ywp7FYFCsp
	EQMQ1gm+cj62H512nYxuGtY8VTyRQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010071.outbound.protection.outlook.com [52.101.193.71])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g00w4uj4q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:35:00 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQnXqeSeWaaFRfzsS9mCh4BzsHaK4ID4037DUP8gsUT7Z5EWFL5XWYf6YVX/4YJotCjklCGHIUkSZnIiiiPT/xlR5aXaKg9BpLjsMseP9ejql7Hqi+U8gqhJXMqPEwcwqZnE3FhiHO6+8QdFTjGcCqm74E/Ww787cqh+/YQCgTIywcLRNXHMHMg+pW3oisH2H+GZMeIXwxDw5g3Sp6iZF1XeowcIqQeUADbOUlXQtvsaFKq615Zs5xxqyNALpY2dPJoTeuKrXMs/HaMbe4rnP3E879LAym66gU1czLg2ztMGIyOR75bLzwTy/lMTA0+6fo8/ogmnfbs283SfdcM9rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tt2uwvzIqMNehFK76PrQJ6oaooM0SB13UAqWfokURpU=;
 b=lVWmujQjLORBMUFl++fdbMo34U5Dir8CF0ZxqBAXtlT+oNMdUmJf8QyTmnLBcg6o681U7QeYmkEBuzRuat2lJ0ti0WDA8fTB/W5uuMZ/QSy7C6towWoMdUCX/2o4eKsOV4T0atGgrqqvCaOVi3msvTfoaDo6Lra8Gz3LVEE5gcz41q5A84eO2fa2CXn3ldrVOKHGBDNItnxSJZYUSb0AQ5CFKnbIlEzRtLwJmE+HTc/fUEePNjIHdhKsRokUvOfjwHQhw87tkYpP/zh3nYI7b+vl1wXMrcArlo3HIjqL4lRJkadPhazxCE1Wpaf/kt2BySgB/4MHZOdL6O3Ut4LeLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tt2uwvzIqMNehFK76PrQJ6oaooM0SB13UAqWfokURpU=;
 b=MbrejMw3jpbzvOS6hSP2ISH2M/WxYuI9nOP3u3MJwsvhRouHLOT10EW0AkEmtmfW7lCcGaBYwzzRi4k1D4TRcd/aJhUafZ5E4W6Qd4tYb8HDrbEGihNnlIeqMu/+hxStvRRgGLKoWafs16HaacV6+hHvTEq41Wx9H/M3WqIDPPs=
Received: from CH2PR02CA0016.namprd02.prod.outlook.com (2603:10b6:610:4e::26)
 by PH7PR10MB6578.namprd10.prod.outlook.com (2603:10b6:510:205::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 18:34:48 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::98) by CH2PR02CA0016.outlook.office365.com
 (2603:10b6:610:4e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 18:34:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 18:34:44 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 11 Aug
 2026 13:34:18 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 11 Aug
 2026 13:34:18 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 11 Aug 2026 13:34:18 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67BIXIe3659766;
	Tue, 11 Aug 2026 13:34:13 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v7 11/18] spi: cadence-quadspi: enable PHY for direct reads
Date: Wed, 12 Aug 2026 00:03:06 +0530
Message-ID: <20260811183313.1550425-12-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811183313.1550425-1-s-k6@ti.com>
References: <20260811183313.1550425-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|PH7PR10MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ce881b-4cf2-4f6f-6253-08def7d7371a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|7416014|56012099006|10067099003|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	X0JoRnAHNCbbV8PbxzHGUt+zpF/gBTPkcvMFCweqDRfdx1z1qd9wWjnkXxjjGi4pJbNLDAyih8XIzQyxnI2KFNJkOqdcLtcp6+KZlCNhD5r/TZ0PkGeAefyqsu7d4laScD7a0aZ7UB5/zI6zh5g/zlDZijR/ks99yBEuGsbDi1torqcX/TMWZ0huqo+V12S6MlhM5kCqUCzirNbac73Td5SzaKekdRcDEYHWIahwG0uRl059ar1UibJereYDQDDBrQsIxLLM/SJmOsFQxkUqIk625L82SFXMFfuTpWGvWj9/jhkE2umYSn6+jfM/DCTtHjy5z3Y1RlGCn0skASsrxwNRDrwwLDlkaSIpdOHx6GuH7dnnBN7SHuhY8JH0Qslkb2jMLljmIBLRwy/9ebxOgZhIEljbWyiKj7Llkr8DVSBO2d/DsOzTHLfXqgqlGGiiDzwiO+pB6ajEiK+2+VdbzILh2UYDHcE4t6p5CnNxdjPGOqYeSkXeDjuQtPfr8tekjLTG6xU7oOxpl9Xy+FuYN3wc5OBO8XFLSAXoSNeLxqRKpeac9W25jp2xYdakuofnhuHt8bVUwL2Wxmycz4B0/g0DxfPw/yhOp11Y/sRqNAZS/3uNxl3K4bw5QpqxG8xTMxsTntuSecP1nNm3eCwf1YfkhzS83z9sy2M38fEv5HnJqmdFLDR5t0lW2EFn4AfFfXo+Yrd0tQigZ23QOxp9jGy6c3hR0vj3TBipS6G5FYkjY3k6iCpHT+trxeTQirg9
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(7416014)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TbQJB3mXuh4RCdJwc6Xmss1RkIogp0IdX2tLAnumxT7DZrpd9vL1TlQDTl77kmlpwtBbDHVuy6BdvGsHqOmHaYuCQwap27cXwZAR7eAIlDWMMWkx9t0iwZp9EhWqa+YRu6W+tIHVkHxAh0YijpE68s65/zhTcTb5orgM0ss75rmGe/5x7oda5ESK43JI2CH/drwlZPpWqkVgkq+hGzXPflAva05Nth12auZr+TCn2Bi8aUcwtWMEVKDAa+o0G/Og5Cmkd7vGFtts6aHDBUNdel6G2HlxEU2VoPBqVAu6XV1utuCc3ecAeqQXg8DXAikB++67eSuCWvpe+Nsl3AW4VT1V2LxYYnSkQTCVpOLDXqP3NUH7tiB6pZuGUDUVU6IGCumQfVb26bZYJi21ex3hnYPsvFQ/yIHbC8aqSzfc2sFKOWQnD414LxBhTf9V6vLp
X-Exchange-RoutingPolicyChecked:
	GIpLPqYC18RECghvJUGuv7K28Fig5dRgZSJ5FW85maHghfFrc2HOiHUgjjXNPeCChzbQLnJ4ytnEKXNTWd1ec/rqFzD0C+RBJGDMuEck5dQVyhnHoqFRf+sMzVn4bk5Dh2QJD3RqKFF8DCgmfecz3ihLUmuySGeCkJZfR2IwgciLa6RbnmvlmaTOeYcRDrh2xow7ic/C2+f7pg9+YIg8yYs4nZXujqvmhGXTbtPva/wh5sX4Kwvfm4YwAgiHNkwqo/f9PwnJqf9prc63BG0CZtozqGjlHw5xX+v8M/Ny1hZ7M0kz4CLlwZc+6EACE9I+QCYIqG8MO2LaCWdCTKMqEw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 18:34:44.6754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ce881b-4cf2-4f6f-6253-08def7d7371a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6578
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NiBTYWx0ZWRfX3ERnjMTTuMC8
 QJDHiSvEvT+XnC29QylcNSp8PXCFVpX9NPtSmVXfUgr2in8FP2MRBR9M5hpMEvCBRdm4cHe5Qkf
 KQlx5kfnTKE6LlJNlytWGocjxC/bQn8I0vjbPP2ezlXv1ZBhh9gGZsS4L7zeIwDpchY8ybNSL92
 IClOg6uRP22On41tOZiPte8X1zhMgTxoW+S2qcC0LXRV3J9+Wg8auHfck/lOpX1J8Y2DDI1/Z36
 bWEG9YG2fHHawdqf5TkgXBNtC8Hky3WPGWog8u6u30pk0ZLQ1IcedWtDFKU2MTUDdYgK3BhVaHB
 MfMr1RqKwPLcESVSFW1i3SAzKFUVutvfZPYSr+X0PGMTPAEkobvcwN7VGYTAgPJJANiIIizWHxp
 wuP9dgsGKC1jFk7OSci2FrzvRMZtEnj6igJFnV+m8Jd+dWXuZdMuxasXA3c3rzg9nNsnMLb4Zli
 rFYzkIBBz3e8yyHBi+Q==
X-Proofpoint-ORIG-GUID: P-ezgm4B89xyBlaze4ThOSe2qe27gATt
X-Authority-Analysis: v=2.4 cv=KZ/idwYD c=1 sm=1 tr=0 ts=6a7b6b54 cx=c_pps
 a=/fsfGrOPy16csppsbskbtg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=DtXw2DrE-T2x2gJjnU0A:9
X-Proofpoint-GUID: P-ezgm4B89xyBlaze4ThOSe2qe27gATt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NiBTYWx0ZWRfX2twu+OvHc7Jt
 mwZJhr9Z0PQhqlX90MLENXybxf+Z5Y4qlzF1aO/GUtl704guGOMCnVydQsQiuUfObXz7bEYvGtA
 qyFvGRSafZObSqZRwSNPD/yH9E2g/zQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110156

Add cqspi_tune_phy() to toggle PHY mode around a DMA transfer. On
enable: reprogramme the DLL from the per-CS calibration result when
the hardware values differ (handles alternating PHY reads across two
chip selects with different calibration), configure read-capture for
the tuned delay, assert PHY_EN and PHY_PIPELINE in CONFIG, and
decrement the dummy cycle count by one since the PHY data-capture
pipeline absorbs that latency. The original count is saved in
cqspi->phy_saved_dummy so the disable path restores it exactly,
handling the case where the original count was zero. On disable,
all settings are reversed using the saved count.

Add cqspi_use_tuned_phy() predicate: PHY is activated only when
calibration completed successfully and the op frequency equals the
post-config rate.

For direct reads, PHY is used only when both the start address and
end address are 16-byte aligned. Unaligned transfers fall back to
non-PHY DMA.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 119 +++++++++++++++++++++++++++++-
 1 file changed, 118 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 99a0ec0e769c..8903b4cf4f6f 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1074,6 +1074,102 @@ static int cqspi_resync_dll(struct cqspi_st *cqspi)
 	return ret;
 }
 
+static int cqspi_tune_phy(struct cqspi_flash_pdata *f_pdata, bool enable)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	void __iomem *reg_base = cqspi->iobase;
+	u32 reg;
+	u8 dummy;
+	int ret;
+
+	ret = cqspi_wait_idle(cqspi);
+	if (ret)
+		return ret;
+
+	if (enable) {
+		/*
+		 * CQSPI_REG_PHY_CONFIG holds the RX/TX delay line tap counts
+		 * and is a single global register with no per-CS equivalent.
+		 * Reprogramme and resync the DLL when the active device's
+		 * calibrated values differ from what is currently in hardware,
+		 * which happens when alternating PHY reads between two chip
+		 * selects with different calibration results.
+		 */
+		reg = readl(reg_base + CQSPI_REG_PHY_CONFIG);
+		if (((reg >> CQSPI_REG_PHY_CONFIG_RX_DEL_LSB) &
+		     CQSPI_REG_PHY_CONFIG_RX_DEL_MASK) != f_pdata->phy_setting.rx ||
+		    ((reg >> CQSPI_REG_PHY_CONFIG_TX_DEL_LSB) &
+		     CQSPI_REG_PHY_CONFIG_TX_DEL_MASK) != f_pdata->phy_setting.tx) {
+			cqspi_set_dll(reg_base, f_pdata->phy_setting.rx,
+				      f_pdata->phy_setting.tx);
+			ret = cqspi_resync_dll(cqspi);
+			if (ret)
+				return ret;
+		}
+
+		cqspi_readdata_capture(cqspi, !f_pdata->use_dqs, f_pdata->use_dqs,
+				       f_pdata->phy_setting.read_delay);
+
+		reg = readl(reg_base + CQSPI_REG_CONFIG);
+		reg |= CQSPI_REG_CONFIG_PHY_EN | CQSPI_REG_CONFIG_PHY_PIPELINE;
+		writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+		/*
+		 * The PHY data-capture pipeline absorbs one dummy cycle's
+		 * worth of latency; reduce the count to avoid over-compensation.
+		 * Save the original count so the disable path can restore it
+		 * exactly, regardless of whether the original was zero.
+		 */
+		reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+		dummy = FIELD_GET(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  reg);
+		cqspi->phy_saved_dummy = dummy;
+		if (dummy)
+			dummy--;
+		reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK
+			 << CQSPI_REG_RD_INSTR_DUMMY_LSB);
+		reg |= FIELD_PREP(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  dummy);
+		writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+
+		ret = cqspi_wait_idle(cqspi);
+		if (ret) {
+			reg = readl(reg_base + CQSPI_REG_CONFIG);
+			reg &= ~(CQSPI_REG_CONFIG_PHY_EN |
+				 CQSPI_REG_CONFIG_PHY_PIPELINE);
+			writel(reg, reg_base + CQSPI_REG_CONFIG);
+			reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+			reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK
+				 << CQSPI_REG_RD_INSTR_DUMMY_LSB);
+			reg |= FIELD_PREP(CQSPI_REG_RD_INSTR_DUMMY_MASK
+						  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+					  cqspi->phy_saved_dummy);
+			writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+		}
+		return ret;
+	}
+
+	cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
+			       f_pdata->read_delay);
+
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	reg &= ~(CQSPI_REG_CONFIG_PHY_EN |
+		 CQSPI_REG_CONFIG_PHY_PIPELINE);
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+	reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+	reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK
+		 << CQSPI_REG_RD_INSTR_DUMMY_LSB);
+	reg |= FIELD_PREP(CQSPI_REG_RD_INSTR_DUMMY_MASK
+				  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+			  cqspi->phy_saved_dummy);
+	writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+
+	return cqspi_wait_idle(cqspi);
+}
+
 static int cqspi_versal_indirect_read_dma(struct cqspi_flash_pdata *f_pdata,
 					  u_char *rxbuf, loff_t from_addr,
 					  size_t n_rx)
@@ -1524,6 +1620,14 @@ static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
 	return cqspi_indirect_write_execute(f_pdata, to, buf, len);
 }
 
+static bool cqspi_use_tuned_phy(struct cqspi_flash_pdata *f_pdata,
+				const struct spi_mem_op *op,
+				u32 post_config_max_speed_hz)
+{
+	return f_pdata->use_tuned_phy &&
+	       op->max_freq == post_config_max_speed_hz;
+}
+
 static void cqspi_rx_dma_callback(void *param)
 {
 	struct cqspi_st *cqspi = param;
@@ -1629,6 +1733,7 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 	loff_t from = op->addr.val;
 	size_t len = op->data.nbytes;
 	u_char *buf = op->data.buf.in;
+	int ret;
 
 	if (!cqspi->rx_chan || !virt_addr_valid(buf) ||
 	    len < CQSPI_PHY_MIN_DIRECT_READ_LEN) {
@@ -1636,7 +1741,19 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 		return 0;
 	}
 
-	return cqspi_direct_read_dma(f_pdata, buf, from, len);
+	if (!cqspi_use_tuned_phy(f_pdata, op, post_config_max_speed_hz))
+		return cqspi_direct_read_dma(f_pdata, buf, from, len);
+
+	if (!IS_ALIGNED(from, 16) || !IS_ALIGNED(from + len, 16))
+		return cqspi_direct_read_dma(f_pdata, buf, from, len);
+
+	ret = cqspi_tune_phy(f_pdata, true);
+	if (ret)
+		return ret;
+	ret = cqspi_direct_read_dma(f_pdata, buf, from, len);
+	cqspi_tune_phy(f_pdata, false);
+
+	return ret;
 }
 
 static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
-- 
2.34.1

