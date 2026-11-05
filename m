Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876391;
	b=IVeKovqnbpBzqQeAoCiC+ChMGERw2J7cxhIx6jC+aAx9cPDqF4YXh9mALNSDccOoMosr
	 hhIVboPcpe+5XH/4AIau0HnMznI2Npt1rA79FH7AhR8r7NkNL0+tr5FdXwU0HFeLsYuFr
	 ZQ8FxA/S8J0BBdnAA6aF3N9ppV2yRBPGgeyJ6PgHDdLMYgQMxIeBp7e3Eo5XgfYNrIu1j
	 eqbMAzW/jCcz+bSNnYLV3rSAmm/b1RcfzJrPJBBGOTpFYpj6rgASZMiGKCIDsD8MzM1Qg
	 CQdfmy26uyCCIwgPqlFBu3K9Nij9NxHpuUlhgeJEj/xpZvnSVKZqwTNz2RiY6TeDt6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876391;
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
	bh=ifW6Pk837tjJpb7MWJfCyMdJmjhtMHstsYXNo95WGR4=;
	b=KTClWmZjDbzDm2mDkS2GapXrbtElxGm8FBiYohdBYGkjIwjB5r1zP1tbk/unzX/UNvJ0
	 ujiOloX1xiNUbUQoyvRd6ZRasrcdG6/YpJ5TeOZlv/Py2g/vkcDbhC3QmynDaCdXWY4U2
	 tEab3kfJoR6DfQlQZx8EUuTjYsLmcCXlIlGBv3ewwrNHivYb798d9I6iUZDXMmxZHZDq7
	 0L64SIz0cTzbsmCx/tEdWhBQLP0YvVD8FnYwmGR1i8i2F1BESqsZXWne808LDKBOf9mhr
	 6Q5kB8ZViXaCH6zpMQvTryqu1BnNikB25RYmp7vG8/06JtAkQH3oecypbcUeNtxGgCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=ha9Mu0rW;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=oHqKn92G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCE5606A339;
	Thu,  5 Nov 2026 10:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BCE5606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=ha9Mu0rW;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=oHqKn92G
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6A59vuMm505862;
	Thu, 5 Nov 2026 04:59:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=ifW6Pk837tjJpb7MWJfCyMdJmjhtMHstsYXNo95WG
	R4=; b=ha9Mu0rW+I2ipHbm8IhIIbRfcgClfZ3Iv4skaHFFHqgn2Ycxf7efqmSpQ
	HWm5AhZCeHXs3+iMSmtWr+YIg3O7rKEzfKwRPJN4sVehUotMTTdqOnpXE17APYEp
	A+5DtWMtjaNalSKdig3M3G7SQ/p24Z5zezRw0lBHUNNiE7KhtLMCXzVCDEcuSFFx
	UHcGOO0HdmgMIUzeAjrfuZEwom1o2r0QEbIzchlhZdRHO3XPo9xdTm0+P/BwQnVP
	DZQ7n3Qk+UE/g0SRTQZ2wIZJ7DzxDi63y0kGRoXv/9IKGVIXBuTQr1VCyQzL2CQ7
	qg0/6fOqeOEBAjxjaDo+xU+bwSoAA==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012031.outbound.protection.outlook.com [52.101.53.31])
	by m0380145.ppops.net (PPS) with ESMTPS id 4hrq6tgcf3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 04:59:28 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMIXHd4aX7EYZw2uLUEcocEMXhFbv+Yh2Xh2LL8fUv/47HX/sbpUAGa7EkCrJYdgxAtV43A7QwEdUOnzfPmTWNBIKo6rVtczWYYDTh7A8xVjXX9HZEt1SDSXQtdZgpW/t6cYrzOdozsyrWi9FuAyeAr1i+3XsBtzdV8Q3Jf3WEs/a1XDG7k4IL/4mx/K3N/uaKTwAYgxTo1OQCIqc0npSpaHSkTUdBUFbvhno6Zg7JhKLL1ymeczqe0wrmgdMUCcHImC0GasxSrMlJWlAaReMp161MelRE2if5GCalHSCM346siXtih4WG/mkPiZeA+jqa4dOXSxCe6UmEIWs5bv8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifW6Pk837tjJpb7MWJfCyMdJmjhtMHstsYXNo95WGR4=;
 b=d9L/NtcaCafzbJCZfheL5VF/H3JJYD2jvYE8+8qvfnAqTKMQZ2p6XsAYXouLPpmClSAOOQQzYl95JZz/tljhjdF+9BYZmxd3lPyiZN/J8M4GLMPieK3rsGtpRiP7nHbtbwLXgtjLfCA6VJ5OGbHP+ywe37PVmOk00qmvcOtAlAeWCWmiPigNtYJVZt4iJvPdyzIrP4RIU+CzTowmGP2cnVl7zkNZ5K0n9O+EkyLjKbfqMSB74ZNEAKy2yhkTFlIBQmkfCAeyXKtpuRIkm6wwOFtBTbPioHRfRoVMcBiAHTtpNPpch3YEaRTr98uG8CdQ4r3/NrJx1VJJ/L2GiN7xYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifW6Pk837tjJpb7MWJfCyMdJmjhtMHstsYXNo95WGR4=;
 b=oHqKn92GynS+0XInLh8hIZoaYxOL0TSGEcKaajiIL0iwxqf5J+AAMtoZs4C4PqPwCXESxqNyF0rx6J3cwV2WI3AtWrDN1IKR59YP0ucnMw2PhkV+3OEDCQTH7EGqVspkYXJrnm7uCenOpD7Yvoht+ILcQycDK21Nn6rtZ8u/1XU=
Received: from BN9P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::32)
 by SJ0PR10MB4512.namprd10.prod.outlook.com (2603:10b6:a03:2dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 10:59:25 +0000
Received: from BN1PEPF0001806F.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::62) by BN9P221CA0020.outlook.office365.com
 (2603:10b6:408:10a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 10:59:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF0001806F.mail.protection.outlook.com (10.167.245.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 10:59:24 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 04:59:22 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 04:59:22 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 5 Nov 2026 04:59:22 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A5Awg2E4171076;
	Thu, 5 Nov 2026 04:59:17 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <srikanth.boyapally@amd.com>, <m-shah@ti.com>, <s-k6@ti.com>
Subject: [PATCH v11 06/19] spi: cadence-quadspi: move cqspi_readdata_capture earlier
Date: Thu, 5 Nov 2026 16:28:19 +0530
Message-ID: <20261105105832.2134313-7-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0001806F:EE_|SJ0PR10MB4512:EE_
X-MS-Office365-Filtering-Correlation-Id: 21062d90-d959-4269-d225-08df3b2bdab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|23010399003|1800799024|261026140227099003|261028144727099003|261009221227099003|261021121427099003|261022105027099003|261021123027099003|261009223027099003|56012099006|261102123227099003|10067099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	NKp7V8ZlixVUSqEm7WRqlXE33NpGpcLPD3Wt8JJQvAhVuP+wxpetMgNc5P6IMTkFvWQFs94w5Wlwb5RCXuJ0xyaTvehL8VeIm7X5eXMQ58Ep2WJAnz7U22Oka+DUNTZredc9cwUBd2qETfUljjK8Tczyw89DMPXO67/XCjo9uEHyb/Sl+jqL09Dy/kx09aPwaQ1tOTeS9NVGvH0Ml9k2GA+TpKBjBTfsdhwWlv4hcJAdokORPHccIAYzp6dyJ9s5Nl+yfj6+E7PVDHOyNz3OoZPiQzp4iqu3Zuj0eW35XM9kblrhz2vcDeal84BOl6vIzdkODMX378VL+OQ1wv2UFTLyjIW7yiLSWGi8e/lOuOekzYucCWjD/7JmH+RZz98lnvFZK8gx/RIaWM/mQhvIo99fTOvTK1lLDZfQUOJ+MtePHAzAJPhG/bOL8ojnmmP0LDEYxL8OwRt19vBOajmOld5IcBtbnOzgVJCGEpBLCC9aSlNNkhXy/vmN+x80mlyK67SXI6Yj5S/YOgDgv/1fYnsxP2N5snYqitKSE2kdg91+LU9dwhNtRSxBcl0Pme9dRC1j8Yd7QOLPXXow7kUsjanVk1RHxSt5E2eYAgsV6nnMiV7T6f9AsnhteLnIn4umkhMFygrd/dY16YWzSg8CEGnuIXVbH8GGNm3cgpyYxzbtbHNku/+G3XBlzdPQEyctFf14drVSOAVGdH7XU7ruXIL2dqbN6P/KRFSjGOsvfJJw8SlVLpo5/D3JLbNghHmY
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(23010399003)(1800799024)(261026140227099003)(261028144727099003)(261009221227099003)(261021121427099003)(261022105027099003)(261021123027099003)(261009223027099003)(56012099006)(261102123227099003)(10067099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	s5TB/5o2kM4yuBU6gTGDepX6QsCHuN2wZZKfKIdeJUkYAH1ty4RkE3i3bDqMHjAN1nV4SFrOaepfvZy/fB/QjERzIYxhKn3N18+wAM5+QvQDNmp/YSA+HaZ3eydsGNl5KoFV7LRHn9uoTupdJFwjxUU0VUVfgz1HAM0i+q+m1ssHmcD9T6Rv/AbdNJS4uzJAR/vyQlDz2pSK7RvqBfWhlRYAatXQsIFDebzh7aGMN480rP1TA/khWXxzN1id7e8oLjWFsfaywb4HSSNQ1b56mKHPJwtiEcL7lhDF3JfLfxdtdOgk2r3PmGH4H1jHfUVXq+wBmPmr4qtBL8sO5x8GOlWpfd8vuN4p0zDE7B0U8Hiih6axFVZKtv98gINHeHs+1mBHkqccPXA8VTx0o8WnD+ezBPG4yldFdqNv+i/OamvHpiljfBQAJReUw+hu6Qi/
X-Exchange-RoutingPolicyChecked:
	lzc/jS32wwE2fpK2jZCHduW56nTdUab4Yf/xNgWJGHFC2akPJHAmi8bNJ0Az6qFzFyDwZHhw3KrhDMTSq7uAmmY2ikHQCE+7Z7sxeSo/3yJV6Ww82coSxanDBjZsl4jGhTC9lZu7R0MtBDorkzWCRmZkd3cf1EJ6d7b0MaByNh9t+ImePM1cuBymZV+bQnoO9WpSvTGYfiMqqIXfFaxPCdv6+0PFYNhJ8ZQY2i9FEArL7bcIDHn0zTmAda78mxUGd48YmcPr5P8WkT6IU8wevX6vbMjlHwwCCOI0ARIgAB4CUlrTQ3KHxG8sbIm5eRrie0of7SxKIDjFMRuxPhPFZg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 10:59:24.7600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21062d90-d959-4269-d225-08df3b2bdab4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0001806F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4512
X-Proofpoint-GUID: P-Hi46l4k8hyUx1Mg6TOae1U1q_pICAI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX4LTAIQOwerF9
 OBBJ8oXWH1MwwgFpGEL8ofuxqdii8Zpo948bwdooY0ddS4tKURYz10iT58NFAj5G5FoCbEi/nRk
 1gbRziiSnFw9gkB/pHsvC6LC+IjFPq0=
X-Proofpoint-ORIG-GUID: P-Hi46l4k8hyUx1Mg6TOae1U1q_pICAI
X-Authority-Analysis: v=2.4 cv=Q6xHcI2a c=1 sm=1 tr=0 ts=6aec6190 cx=c_pps
 a=yf4wneJBeBA4fm5+j3KMTA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=P-IC7800AAAA:8 a=zd2uoN0lAAAA:8 a=sozttTNsAAAA:8
 a=Wyhe1Gx0t4Yb_bR_f1kA:9 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX+VSWrB9vYr2e
 CtbqBJR4XXiehcYEiTlHA9vxGnGnGkOVqgcWJU4yeTEsemAD7ERbPHIHHbelo+K7qz7x8VeigC3
 +4mx7uxL4++rsljDfddcvyF8nsrYvbeoiZavVroG0NtNzVvbxDJkNhsdTRIhiqCwRQUgtbNj9Th
 Jgn31Bxekk3zXfEGD5xn2xKiUymIb0D2zKbp14ZU6WF+gSCjLMwEKZjdSCsZSoWScQdOb6VTMtr
 2plDKu3KjrnPu0HdrctOLPnWCSmmWy7K5Y5ZTaSIU4OuTWPTkCiIMvKsNXKkVb7I588D901z1ET
 fOjBY5JpMFHlxUbSCOPJ5OdKf9pJ/UcxeplZwIE086+8dv9lgnK2OFO2CAqFYS8ZbD2z57D/FOY
 jcLqPmcgPKrvOOnioyHbMRotmYmoFfLJfJUcEyfj5ZGnJrYxsczk5It4ZhyYt2cRy4uDtxgL5qu
 2EO3oIjlSttCE5S3eSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050043

Move cqspi_readdata_capture() function earlier in the file. This is
preparatory refactoring for upcoming PHY tuning support that needs to
call it without a forward declaration.

No functional changes.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Tested-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
Tested-by: Moteen Shah <m-shah@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 45 +++++++++++++++----------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 73ea51c41f95..c2c6105798e1 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -457,6 +457,28 @@ static int cqspi_wait_idle(struct cqspi_st *cqspi)
 	}
 }
 
+static void cqspi_readdata_capture(struct cqspi_st *cqspi, const bool bypass,
+				   const unsigned int delay)
+{
+	void __iomem *reg_base = cqspi->iobase;
+	unsigned int reg;
+
+	reg = readl(reg_base + CQSPI_REG_READCAPTURE);
+
+	if (bypass)
+		reg |= BIT(CQSPI_REG_READCAPTURE_BYPASS_LSB);
+	else
+		reg &= ~BIT(CQSPI_REG_READCAPTURE_BYPASS_LSB);
+
+	reg &= ~(CQSPI_REG_READCAPTURE_DELAY_MASK
+		 << CQSPI_REG_READCAPTURE_DELAY_LSB);
+
+	reg |= (delay & CQSPI_REG_READCAPTURE_DELAY_MASK)
+	       << CQSPI_REG_READCAPTURE_DELAY_LSB;
+
+	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
+}
+
 static int cqspi_exec_flash_cmd(struct cqspi_st *cqspi, unsigned int reg)
 {
 	void __iomem *reg_base = cqspi->iobase;
@@ -1273,29 +1295,6 @@ static void cqspi_config_baudrate_div(struct cqspi_st *cqspi)
 	writel(reg, reg_base + CQSPI_REG_CONFIG);
 }
 
-static void cqspi_readdata_capture(struct cqspi_st *cqspi,
-				   const bool bypass,
-				   const unsigned int delay)
-{
-	void __iomem *reg_base = cqspi->iobase;
-	unsigned int reg;
-
-	reg = readl(reg_base + CQSPI_REG_READCAPTURE);
-
-	if (bypass)
-		reg |= BIT(CQSPI_REG_READCAPTURE_BYPASS_LSB);
-	else
-		reg &= ~BIT(CQSPI_REG_READCAPTURE_BYPASS_LSB);
-
-	reg &= ~(CQSPI_REG_READCAPTURE_DELAY_MASK
-		 << CQSPI_REG_READCAPTURE_DELAY_LSB);
-
-	reg |= (delay & CQSPI_REG_READCAPTURE_DELAY_MASK)
-		<< CQSPI_REG_READCAPTURE_DELAY_LSB;
-
-	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
-}
-
 static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 			    unsigned long sclk)
 {
-- 
2.34.1

