Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B16F3321C2;
	Tue, 25 Aug 2026 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678329; cv=fail; b=mMTlhO/EgW9S5SIST/VaUx++lJLmsFRzDYloUPzi2m+sxKbmu+1VtqBA5qbGodYqKPsPGzaMa2WZtgFRJIPuUg8ZBGMpLzXmq87UxQ8CH1/RPoZmkDYITPVFNupQecj/4E610SZb8eB0nCAj6dceFjZScz+vXHgJEWy9rt9hZE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678329; c=relaxed/simple;
	bh=nHERynUITfg5e3Nh2yAHKyBReZZf4m9KBYLOhEczroA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFJyo7FcOXidLgJXXgS560RIwMKjdjSsFkXrAOnzy+LVaPt8jWTz6QUN/gxhW8Htk8iZGcnjEQnr7KuQxv7+nPIdq8/qMrCILU05YWecH7aoozmquyxmiAbaltjZQW4ftRsM0RZsrnEUqG+N7dwMXKwdqSMM/1/QaORYMOPs+GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=DVIcXWOd; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kyW49/ev; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="DVIcXWOd";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kyW49/ev"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67PEVZDQ1165228;
	Tue, 25 Aug 2026 12:18:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=UDgIqenZB3DR5a29o3tuvANtwgRl7SpThCxLM+b+1
	nQ=; b=DVIcXWOdFAl9LyPz5LdJ0OL45RxIAJSEY24qqM6mPRMWShlwLX5DWNQFS
	3BoYQGZ+5EiV/kfCmP9wkE77k1JFsoAaTPLzUsGFfd9XJKgVYrA36kzpYTvE/jUv
	TmJSvPm5HqZ3Ciyu3ZfrreEWWtpL++K+X5Kn7/vH6ZZvUkTshTt2kjFhroYrn/+t
	R+yFWGbzvptTiTw+rI42hkdfhkNS2oQj/onC7BD21Wg1AQdTVHWCv2m1mBCFo3RN
	w10d+mCffDVthzrHMhmfclEXpGOQH1VHFcdvYnxNp8qBkSo6r+oCiaopVv8KSLrD
	TwMqwfJT1kHHxmovJE+R/G6x4QfrA==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
	by m0384305.ppops.net (PPS) with ESMTPS id 4g91sxmjgm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 12:18:36 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkT42k8PNkweSfhlDkG9FVCH7lEWRVqDu2TPHqFgzJIPDTOlVIO7FOhECtjbgbDZAXWHG7Kii3zTrTvE8bcjxDFsIzL1tf5tsER+zJu+VeevcvrpLiWUF+hGewk0Ep8Q5lsbDyj2Upxp9Vv/GlegJ5V/9G3Upc5HXa15YXg6WI5RNFCpw4iShSFWDDj/pZobOMcaYmxK2utrSxFFG3I8zZ4KwEtRhovvldVy62Ob7HvzpKKbY6v0yakOALTMxkGp/yNo06K4gVMqLkKqH+yRNDw184Os5Rs0sLgct9QziH5OffUFRLDZ8ztVGOzmi8ZWU5/u+lhT5hkOm+f23Mo+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDgIqenZB3DR5a29o3tuvANtwgRl7SpThCxLM+b+1nQ=;
 b=dnDxcrvfqaYK5OPh9bZ70yYgaYCqaLL8Aqs6MJAhe3xTsJmd0VCziELmfFzEIquk7/2LXexBckT3sowD2mKRrzUne0u3u4oCrU0S/70qwQ5wHu+mYxqqvsyDVZ3N4DSqBXKj5k4bH8Dy1GNj7+wNgyPCn1gKFg3mcMNRVouY3BfgpUZpLmzRxZ74XPWemQnzAVD6LrJgWr7/B1JxB1nzRBA8oLPQ1RGuFYCdd2XGYWSxDS7JqCVJzfT8Y/c0UPtgzZbD6k3buVt8FvfOfmSj1Uq5zC1STE9GEEjAARDFd86tetEf9IAk/EEJv5YHyTIRHx1E1YX9IGYYhrRA3LRhhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDgIqenZB3DR5a29o3tuvANtwgRl7SpThCxLM+b+1nQ=;
 b=kyW49/evCize2THY/MBGpPWhheNsgNu7Yon3A8C2xGjlXmRwCH2hv/AsRpz9WutVJU/zjjZJS9pY2N+mgfATzwIrHkRfx4xJwb2J5j7iOCThkrpovpnARiL3WzPmTSk8uCQwWrdXTikVZmwp5HlmPM9Zff6wzRRWdyZw5AnBZ8Q=
Received: from BL1PR13CA0437.namprd13.prod.outlook.com (2603:10b6:208:2c3::22)
 by DS0PR10MB6948.namprd10.prod.outlook.com (2603:10b6:8:144::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 17:18:28 +0000
Received: from BN2PEPF0000A7FE.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::4b) by BL1PR13CA0437.outlook.office365.com
 (2603:10b6:208:2c3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Tue, 25
 Aug 2026 17:18:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF0000A7FE.mail.protection.outlook.com (10.167.245.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 17:18:27 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:18:27 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:18:27 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 12:18:27 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67PHHf3W1436664;
	Tue, 25 Aug 2026 12:18:22 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v9 07/18] spi: cadence-quadspi: add DQS support to read data capture
Date: Tue, 25 Aug 2026 22:47:26 +0530
Message-ID: <20260825171737.776052-8-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FE:EE_|DS0PR10MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 63fa2913-efe7-4893-8311-08df02cce0c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|7416014|36860700016|376014|56012099006|10067099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	v5mf2GB+Uo9KEciIUSshr/3nRPs9SgAxVTFHJW245VQCREEXzNRKyHE99TL6OF9p4NEOBuj+ksvwd+Y5mTn1V6EL7B9/sO+Opc5hQMGmt85HofEPgRRQyuU/yIIi5Tn38o1AW5JztHl8i2KANBkfiSX1nef24mMRAZ0zzjvZfUNbrRtSQ85+sNJAfChl6UUO7vi13L/eNjcmH0YP9Y6oGm+tXQ8yaQqrqgtXl1CTEeNxd6grfgooqt3ywlNJh0Id4/6igZ3/v772D/8EAT7LKS1PJ1Awpz2q+YZQo2YAG0YdoJGIE3wGkEfeNRn/Gz8fWQ47kL/45fwM+T+RhO7ruOw16zFv902qFMpH1wpOKMMptvCTXZpCcZwQPaYA39hu4w2s6MiJw1uB/kckIEBodOY5KUSQf9XXPx4Cy4gG1o2gti6/Z6USJ2TXNwvopysrJbcQpe9laWpL1GRWw8YJ+/ZboWJ4kNSkmqYUIyIluSAxF2oSiNxxVaAF0kEbm/26SOnWpiAyDPKAvnZazmij0pEU/IVXZteXG7ObxQ+MpFEN7s1VpDxO+zSVoPuTUwSVWciRr6h625lSHs0rPA3HVISvdwbHFJVDACZFlHMSMcMLYbhsxKRcfePkrneE0BjxG3rb6QdbeJm7eWz8qxJcNip8mQeR5nGIPo57Xijef6ikhouy0yKrFPy8GeH9gLTWWLEXhzGTa3eU3rydbVWo2J2jk0OGoRz565O+eXzeOtyPI3Q7nQxqle7cT1xokJy6
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(7416014)(36860700016)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xY/UOL8FpsxsASXO9h2vZDRCfkLAzd8UwgX5AbaZWmHHMmGwAYdVBo3mSH6I2GQscESi5NBvniiPINi7XkWYKc92Hi7DCBYptEiGVEvrpcl3Ly0JXlgHxBAn7OvSHTqMEZzbv7KiacjWe/o1IR0ZbVzGYwa+Yp/8VTMfUw1cosSBw9Mvn0dtmTAPYolCspO+PVea/I0Sy5Za677BW1+1MpvPcsGe/IEAd65p2NJhxn+hUStVsnsANR9uAD68SGbom/DinR3MZIa470HI7/PMMdcyg/xHXANQiz8Mo3VHAHil/S74ix7HvA5+4VT3z5oK2t6d9XgRmcyKr5coxB4xmwsBAJ9cVkk4ueM2hCQbcl9tGjOP+UFKb93gH6Q1Zk7DJWvusWoWkcEGew1GRfQimBX2HBMZzrVflRLeuOZbuasGITgzZu/ebaEiSNIaR3dP
X-Exchange-RoutingPolicyChecked:
	WXnS6Brdnjbw8mGFQr82MOVku+1RemkmmEB05p/F6sGL0m/0O6VXFjBoa97yZBUI38800x9Wfhk1Gs3gCaqrTQInHukwpIdwVUjrkmLqWwHwbXzISMm+4oJK5qsT6MqjNPPH53JFGIlSiqCMkz6EMGHxAaK+1ycs5ZZnlNJUgOMjB2kO2vL1qxr2MvnAtLNo2DXlJbzDsrwrwge4C9eR+vdYnKeCpUdYBejXIdv+QYr5OIKVbGPpuNzvDkRobUwftsIo09ZmJiANoWs+tLR0t5EV6H6KIseY1LmlziCvhcKomdKh90XrnBx3eRlg2AEEThmVJjd/Z9pXJKzCAKluhA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 17:18:27.6080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63fa2913-efe7-4893-8311-08df02cce0c2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A7FE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6948
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfX7lKE39WD54Ok
 P8mqQbZmBvpKi1e0TLIBwKGFLGG0UW2I/YqBby9ufaExwUW70H+JZuf4qx1789zZkpbt26Wlunk
 q73UFDueF7Fu0TEySkcYtXJmiY8BFQI=
X-Authority-Analysis: v=2.4 cv=HackiCE8 c=1 sm=1 tr=0 ts=6a8dce6c cx=c_pps
 a=BYzTVJwijQ+wlo0xVi9Hgw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8
 a=by1YfaDFVIW1-MDklf4A:9 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: g99Rg4kKqh5-0pjYnC6tFv-JYTxR6Lv-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfXxUI7S+vxUdXy
 +bry8GS80SSbid7kvqhLeAK/hHKT6W/YfX9hVTceXw0ULTqCLzAxi+f1zJNdI8JHagCh7PPMeZc
 hUPpIX0vLA7NI9kiLG/2E2t1qFKTTjvEnaePCWrTj2hz2eZ9kdXCKjTyAAJkwjaRw6Q5JpAmqie
 fC6RoKwkiynERM/bwZEUvqlFIyTgq2pYww1hAotzF32YTP2ovpIKBNXxbFS3JQP9eoAFuMZ6xhk
 CZIiDv+hv2JvyOjNLbkTBcfx08FMROzCDZ4iROEaWcrVowSNFZcIsY75ZFPI6hs8LToK0LPPjxD
 H12iegdr7lmoo1iF3ZEesi8wSxiBZrOxHYHQg7/P3ZcwWWKBr3xVb6GzkGsVqZQWa3d/gdQqd22
 waqFgoWm+ucztBTqQdyvqxVUOD3cIC1geD6gFKfpkDsg4kGU3V+kOE2F6LeEX9n+K17Typq/8A1
 NXCC/QK5URTjwtygw7g==
X-Proofpoint-ORIG-GUID: g99Rg4kKqh5-0pjYnC6tFv-JYTxR6Lv-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250147

Add DQS (Data Strobe) parameter to cqspi_readdata_capture() to control
data capture timing. DQS mode uses a dedicated strobe signal for
improved timing margins in high-speed SPI modes.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index f8e266372367..046fa5d69b0f 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -192,6 +192,7 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_READCAPTURE_BYPASS_LSB	0
 #define CQSPI_REG_READCAPTURE_DELAY_LSB		1
 #define CQSPI_REG_READCAPTURE_DELAY_MASK	0xF
+#define CQSPI_REG_READCAPTURE_DQS_LSB		8
 
 #define CQSPI_REG_SIZE				0x14
 #define CQSPI_REG_SIZE_ADDRESS_LSB		0
@@ -458,7 +459,7 @@ static int cqspi_wait_idle(struct cqspi_st *cqspi)
 }
 
 static void cqspi_readdata_capture(struct cqspi_st *cqspi, const bool bypass,
-				   const unsigned int delay)
+				   const bool dqs, const unsigned int delay)
 {
 	void __iomem *reg_base = cqspi->iobase;
 	unsigned int reg;
@@ -476,6 +477,11 @@ static void cqspi_readdata_capture(struct cqspi_st *cqspi, const bool bypass,
 	reg |= (delay & CQSPI_REG_READCAPTURE_DELAY_MASK)
 	       << CQSPI_REG_READCAPTURE_DELAY_LSB;
 
+	if (dqs)
+		reg |= BIT(CQSPI_REG_READCAPTURE_DQS_LSB);
+	else
+		reg &= ~BIT(CQSPI_REG_READCAPTURE_DQS_LSB);
+
 	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
 }
 
@@ -1317,7 +1323,7 @@ static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 		cqspi->sclk = sclk;
 		cqspi_config_baudrate_div(cqspi);
 		cqspi_delay(f_pdata);
-		cqspi_readdata_capture(cqspi, !cqspi->rclk_en,
+		cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
 				       f_pdata->read_delay);
 	}
 
-- 
2.34.1

