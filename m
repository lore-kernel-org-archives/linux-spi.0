Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876590;
	b=adcQwqceS/M+IfFIUkiswimlPdKOY3Luh57VH8tltHWP8/SoAy4HHw5XQyKvNqrVEoBB
	 7SXnspmKwE8KHPVKuc6jFroAd8730QGWD7A5au0C/YKt/uagbIzPOHRgmjOOs2nVt6dmd
	 gUJC6zUK+XMr1beVy8/MHpTzhMuv0tcS3DHpmLtUnjKpRPoUrOguG+tGGgJf9EUBa+g4w
	 zfDgFyrWbdubiCqvVqEOzHjLTdAX8WtaIn9bF6N8v/5VWRtyrAjdCHAR9N7wBa0YrM+iG
	 hRV183s8cZkFrPeH4wd8u2TEEJbC71IX1QNbC8sk0roahnMIgt7hxIiE2S0xU3rwfuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876590;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=JpNf/Q6l5QW2YHkyFt0gimUjEgxt7BYa1c9wyNiUrCs=;
	b=OrfV0qdW0S/FX2Wmmon6ftG9Kv3F+aFOVIg1lnxjY7k3bV2APr/DaMxZa9M8HkqcBp5T
	 jaX3d+HcB05Mnzx6Xf+FLbzZbWjYUz8ovFG5jxVY6J5SsSLCACCcQcuozHritXuWMGVI+
	 Gh6gD53vCjtpxk51FkOuqWYkDvC+6nuihwq3uNIQoynf2lZLxCFojUFg/Dtf5PEFhukis
	 PYT5xTQHDP+EIWW5h4dmiacmjYkr5vocEEiSw9mBo1djH0jwfR9y2QCgDslViQ28Lz+l8
	 90Q3QtKzlGUMrIwk5EzUkW2GoIc7rFfEw9arYRiJVMcCJR/thdF8NVzZ3qVnOTIVvWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=qI85h1S4;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=n8n0nlKv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CECA606A331;
	Thu,  5 Nov 2026 11:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CECA606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=qI85h1S4;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=n8n0nlKv
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59w90r102720;
	Thu, 5 Nov 2026 05:02:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=JpNf/Q6l5QW2YHkyFt0gimUjEgxt7BYa1c9wyNiUr
	Cs=; b=qI85h1S4M2XJzvFy/GF1a4Hw/Ji01pkyeU5vR89buhTexLiQBCDbTMvmH
	7enWV/jFfnlbpXthmNLzGsnZ0VZ/cwvqlBuzxlO9tPmHWr/ANmFaDhhOo53z+Cxk
	wYTqB++zIUBFdYIaxelsB6jboev/H8hMhfRsOeUA3FyJ4YJwuALWyDh0cFMrmOU2
	FhRFVvd2G3lL6rN1jxR1BYd8SngJFS9gbbEEJxgmeNEcR0zp2GfZdCewymlG/0da
	UdjMP+E2VHokTH4P8UtlqdclaodGHQxIL5bwAIhAe0MwS2FcDRvM6Ep7fBKu4aTG
	WwG3P1OC2A5/1zvaENhp7v36EJVGw==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010048.outbound.protection.outlook.com [52.101.193.48])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hrdte3vg8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 05:02:52 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZX4ZF67qBB3npv+JEjhgSNOuqBS4V//2r8d7J/YU74lswHH2I08fFRVsJEL8Ywh4s1viVEXoV3LkrudlqHtIRcP1zCBFsKy8Fjh7fF6nv//2MBjlwEbi/rYq4pfLYwz30cT3rdk7YGIga14GpZOIcO/WoGaHlPRoTwxSlop3kkAAcnl7c+l7t/Hc4LKyhDZc1++QFwALzIy9UVB8FzVYHcbNpU662vywqNi3Y9+jdUbmULgk9lE4omaBaGpKdzuDRdBV4ZEjyl0BLmCVGo+cinqSfeLmgGsqr+/ncbRVDvoBdk85T7Xn25JUgGfkoevtpzGd5Iroo361OdBL2n3DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpNf/Q6l5QW2YHkyFt0gimUjEgxt7BYa1c9wyNiUrCs=;
 b=SEKp54cXbInBUVsIyQiVUVnO7Ox9RfTJ+pOPymZ5xXRX07VchNKlCd79Xxeldkg3zprfyHQH1CM9CUxzriRS83cygosUMT5fRHZhygbZE29M3uBotjhz5NbaxWuPc9n5CSQRPq55vs77DaLtuaEoZTiyXs92CqXsCE+srnKiXqBvunP3+NVxKBmFI9hrTB1p5bQ7G5WRH2ZzCO2qEnYlMq433bYE/NKQPZRkp+2Cbah2eCtKUY/apqs/YJB8F7/7EN0yoUvOQKJHkqSh7PGeSmlDfPBO9wHyXsQVhwTt4WhAILr6HNj4s3ENs8SX/WRF7CCb7HYE9HJp/fGw6FE+Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpNf/Q6l5QW2YHkyFt0gimUjEgxt7BYa1c9wyNiUrCs=;
 b=n8n0nlKvLy/ngu7tofB3O3YLG1P990nRJbtHOS235pDN/YRDgpiHA8eHY1/vGzmcB1WBiFpJox4ywNxV7Ifw17zau6Ha7YwOGMvkeWELswa0a4Ur5fvHmae2vtr1aZYUCxoVwTSUMF7SUf8uP47QQGAnb7TFxeojKt8JIKxnFKg=
Received: from BN0PR02CA0035.namprd02.prod.outlook.com (2603:10b6:408:e5::10)
 by CY5PR10MB6010.namprd10.prod.outlook.com (2603:10b6:930:29::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 5 Nov
 2026 10:59:47 +0000
Received: from BN1PEPF00018074.namprd04.prod.outlook.com
 (2603:10b6:408:e5:cafe::20) by BN0PR02CA0035.outlook.office365.com
 (2603:10b6:408:e5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 10:59:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00018074.mail.protection.outlook.com (10.167.245.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 10:59:46 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 04:59:45 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 04:59:44 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 5 Nov 2026 04:59:45 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A5Awg2I4171076;
	Thu, 5 Nov 2026 04:59:39 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <srikanth.boyapally@amd.com>, <m-shah@ti.com>, <s-k6@ti.com>
Subject: [PATCH v11 10/19] spi: cadence-quadspi: refactor direct read path for PHY support
Date: Thu, 5 Nov 2026 16:28:23 +0530
Message-ID: <20261105105832.2134313-11-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018074:EE_|CY5PR10MB6010:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ea7bd1-2b5f-4b14-59db-08df3b2be7f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|7416014|3023799007|260925021911599003|18002099003|261102123227099003|261026121527099003|22082099003|6133799003|261026135527099003|260925022911599003|921020|5023799004|261022113327099003|261022075727099003|261021121427099003|261021130227099003|261009221227099003|261022115727099003|261009223027099003|10067099003|261022105027099003|261021135927099003|56012099006|261021123027099003|261028144727099003|261026140227099003|261026130827099003|260925021311599003|261021133027099003;
X-Microsoft-Antispam-Message-Info:
	xA0i60pPSdFs/fyO9W9XcTSB7qA7bLAP+uUD2by6C1QKAfby8sGKg4Gc2rcXj46iLOPJzsa/8HWVSfQSbXrEzx3FxRHHk9ftgTMmUXL7uxOvOPZJ8djyUCQ8KHyPuffeiXKfdJ4hy+WuyVq/xHgMzVnhegouUsy89Pu+QR5lCGzEO3gOmr3wB94QO0OqBER1GodkKsQEXYI3xsvh5vcdvEIHPvE9ABx3KY/c/vEAmlIdFoIcLubN7rQ+nPb3OVbE6lQNVIu3k6AN7fyxn73rO0O8AgWQNv/Uzb1pzoxu8MLMLjJFnPuzqrMoCEz9Uh8FGdKjBESlk0gVC1kd9NxLtu6bP9a29kbo4jOX/Au8GzKphEgE1mfmKiU+r1eaHmZ9ChI8B+6oK4yvFBfGDjghOtUd+mwLbHu9WXs5ulBmVjogrmn9r/6caLmvZqEZnvovMaQAbvWXkjZMhVZM+EugEkSirRb2ajTX5UZyzJsbp0dzw+eFi/OedJ7c6x74XEaT0nsrL8FF1s4vGi6tdDJ0IJqHvfRvEXq6cl/AxxpFRf9v3shkCKN7u34K47dEbTBQcRTAN7EDx6i4E6zisbGOy4fxitR/avblUkZA2RogSeydmhVBKjamH88HYPI4MXh69P7y+BxFgriWaNc59irqrdFQx3aEDbVZT89yhUTImqAR/pJznQMW92BcpYhnWUKeAYlyJcmIXGM/UEo8Pb+33kKYJYZJVG0NMtKtnS87GDWtDvC/SqAnATssfuPteiVH
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(7416014)(3023799007)(260925021911599003)(18002099003)(261102123227099003)(261026121527099003)(22082099003)(6133799003)(261026135527099003)(260925022911599003)(921020)(5023799004)(261022113327099003)(261022075727099003)(261021121427099003)(261021130227099003)(261009221227099003)(261022115727099003)(261009223027099003)(10067099003)(261022105027099003)(261021135927099003)(56012099006)(261021123027099003)(261028144727099003)(261026140227099003)(261026130827099003)(260925021311599003)(261021133027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fRJPoUYHjeNEL7x6u0W3c+rSivcpMQ2Ie79vLeJGUb1PaYtjsE73ppMqdh43VyYJvsKoMY+RACc2dYVaM13g6e5bUPrswXuqBrx3/3NjcA6Mw/r5bBkZgpZa1J8shIKWqA2EtDR5ndmWsX+OQoazTMtTTodTqCLCJueLP/XfC9/kaSEyoUw7gqrVCUYQephXjzR8aSgHdPIbr9PwiEV61sbyxyfWcaqyKoiVBs19cvfEHLGEdGpXz4kdg5Vr6v0MpZggYsOYGyD/93AJ4i2WXdno0+9epQGPCFjy+g9vXmlh3AbaAPHPs8tEQ3jVDGNpUbrigKb6bGupfqw6QVLEyEkvSURmAJ/p/JClAF2WBdEGt72z3rC2fx6M1+Kp912uax57Wa67rDEXqHf6v1RzrApo9w7WtXLhUe3r4WfU3uAR1Fnv0VsQeW4I+bhaSCYa
X-Exchange-RoutingPolicyChecked:
	DDgjKmOoXSzHMXvpYvTPCFI939YjvWuwiNNJJUWFQZvAALh3zuomc70dwHgmpbIlAE3zk/fbFjnb1W10H6FEMRWQ5uPls0qH5voyJ/DjQZM8z2K2Jm1az5u2+8a6aPng/C+uDVTAxSZWx3r/GpXkEToeX59jx5ja2ZmkHtz75pQgQGXBtSa56pF/gkfPCvwStCS14LCTwaFBTjj7N8m8DLK0xdqnRogZGLRQhSCuCvdQfpaETY4NkcHL2qSK9F+jXf3KnLUGcnb1/q7nJ92mXZEBK+6Mwz+2GNLpvMmFL+bKjNaTXmU07Gn1/PSbronSz5etOFvrItu9ERxJ6wFh/Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 10:59:46.9941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ea7bd1-2b5f-4b14-59db-08df3b2be7f4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6010
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX+ydWq8UKKs8V
 u5A7Vy939oAP3d3kl+tE5cWCn9YUTgOCUt/V780brUqFiWD9152iZV4OHPoaFNw5lol0LirM1wH
 x8vw1cLT7LAVMge2dSrOmfA1dC8pTdZ/8FphE4FJWjC7DO+C/AqOjz/T5qHHYOiJksmn9+8XkHP
 pgeQPf6jY5owg7avWZ0Urkuc+u7rdUNnTyhNP2DIlil7BckUz8O7L0HvhlQmBWG3qp9ebudaBKW
 j1MpDTAdMgjLxmwOhdUVZxh/WNaDN/QrrCuKbuYsDKFPVmuluAFQWOgBy9PaP0JbesqJ5VRX8ik
 raNhnb8fMX0UJIAzeP/FEU8E+xgE6l/Fk1pplVcQcukIn4pn3QZn8tN9sAuZAWNitL2CdwD4kTu
 BxtGXX6TLGc7PHZ4YsiP/AU4dT1BvALYfjj1K5lNVzwt5gENBQm6OTMdpCR2HudPgCFTZCDTNL+
 7oNI9LV4h/zj1MIvx1A==
X-Authority-Analysis: v=2.4 cv=ePyGH3p1 c=1 sm=1 tr=0 ts=6aec625c cx=c_pps
 a=lZTGddAnKZ6AR5Pw1xQKMQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=zd2uoN0lAAAA:8 a=sozttTNsAAAA:8
 a=aauMkRGVHSVL3AvwFNMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MyBTYWx0ZWRfX8cvTKYKXZvet
 R80tk1Rb6C5Fl/2ep+oqPAIykuPXKPFAkj9p0KbnUOa2jzMyQjHmaKpbgWy2oxRyvXu6++IzCST
 FocYXAs2j2O7SqILKCaiPH0fJeSeD0k=
X-Proofpoint-GUID: G7WYj1vgOXbkr9oTQz_a0rzp6NPnfJI-
X-Proofpoint-ORIG-GUID: G7WYj1vgOXbkr9oTQz_a0rzp6NPnfJI-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050043

Extract the DMA transfer code from cqspi_direct_read_execute() into a
new cqspi_direct_read_dma() helper. Add cqspi_memcpy_fromio() to handle
non-DMA transfers, using 2-byte-aligned I/O reads for 8D-8D-8D mode to
satisfy the minimum 16-bit AHB transaction width required by the Cadence
OSPI controller in that mode.

Change cqspi_direct_read_execute() to take the full spi_mem_op and
post_config_max_speed_hz instead of separate buf/from/len parameters,
matching the interface needed by the PHY-aware version in the following
patch. Thread post_config_max_speed_hz from cqspi_mem_process() through
cqspi_read().

Transfers shorter than CQSPI_PHY_MIN_DIRECT_READ_LEN bytes always use
the memcpy path; longer transfers use DMA when available.

Tested-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
Tested-by: Moteen Shah <m-shah@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 76 +++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 7993029207e9..c324451a9a28 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -30,6 +30,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 #include <linux/timer.h>
+#include <linux/unaligned.h>
 
 #define CQSPI_NAME			"cadence-qspi"
 #define CQSPI_MAX_CHIPSELECT		4
@@ -155,6 +156,8 @@ struct cqspi_driver_platdata {
 #define CQSPI_READ_TIMEOUT_MS			10
 #define CQSPI_BUSYWAIT_TIMEOUT_US		500
 #define CQSPI_DLL_TIMEOUT_US			300
+/* Minimum transfer length to use DMA for direct reads */
+#define CQSPI_PHY_MIN_DIRECT_READ_LEN		17
 
 /* Runtime_pm autosuspend delay */
 #define CQSPI_AUTOSUSPEND_TIMEOUT		2000
@@ -1528,8 +1531,8 @@ static void cqspi_rx_dma_callback(void *param)
 	complete(&cqspi->rx_dma_complete);
 }
 
-static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
-				     u_char *buf, loff_t from, size_t len)
+static int cqspi_direct_read_dma(struct cqspi_flash_pdata *f_pdata, u_char *buf,
+				 loff_t from, size_t len)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	struct device *dev = &cqspi->pdev->dev;
@@ -1541,11 +1544,6 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 	dma_addr_t dma_dst;
 	struct device *ddev;
 
-	if (!cqspi->rx_chan || !virt_addr_valid(buf)) {
-		memcpy_fromio(buf, cqspi->ahb_base + from, len);
-		return 0;
-	}
-
 	ddev = dmaengine_get_dma_device(cqspi->rx_chan);
 	dma_dst = dma_map_single(ddev, buf, len, DMA_FROM_DEVICE);
 	if (dma_mapping_error(ddev, dma_dst)) {
@@ -1587,8 +1585,64 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 	return ret;
 }
 
+static void cqspi_memcpy_fromio(const struct spi_mem_op *op, void *to,
+				const void __iomem *from, size_t count)
+{
+	if (op->data.buswidth == 8 && op->data.dtr) {
+		/* Handle unaligned start with 2-byte read */
+		if (count && !IS_ALIGNED((unsigned long)from, 4)) {
+			put_unaligned(__raw_readw(from), (u16 *)to);
+			from += 2;
+			to += 2;
+			count -= 2;
+		}
+
+		/*
+		 * Use an explicit 32-bit read loop for the bulk; this
+		 * guarantees the minimum 16-bit AHB transaction width required
+		 * in 8D-8D-8D mode on all architectures. Pairing the
+		 * endian-agnostic __raw_read*() with native put_unaligned()
+		 * (rather than put_unaligned_le*()) preserves the byte stream
+		 * exactly as memcpy_fromio() would, on both LE and BE hosts.
+		 */
+		while (count >= 4) {
+			put_unaligned(__raw_readl(from), (u32 *)to);
+			from += 4;
+			to += 4;
+			count -= 4;
+		}
+
+		/* Handle remaining 2 bytes */
+		if (count)
+			put_unaligned(__raw_readw(from), (u16 *)to);
+
+		return;
+	}
+
+	memcpy_fromio(to, from, count);
+}
+
+static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
+				     const struct spi_mem_op *op,
+				     u32 post_config_max_speed_hz)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	loff_t from = op->addr.val;
+	size_t len = op->data.nbytes;
+	u_char *buf = op->data.buf.in;
+
+	if (!cqspi->rx_chan || !virt_addr_valid(buf) ||
+	    len < CQSPI_PHY_MIN_DIRECT_READ_LEN) {
+		cqspi_memcpy_fromio(op, buf, cqspi->ahb_base + from, len);
+		return 0;
+	}
+
+	return cqspi_direct_read_dma(f_pdata, buf, from, len);
+}
+
 static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
-			  const struct spi_mem_op *op)
+			  const struct spi_mem_op *op,
+			  u32 post_config_max_speed_hz)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	const struct cqspi_driver_platdata *ddata = cqspi->ddata;
@@ -1604,7 +1658,8 @@ static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 
 	if ((cqspi->use_direct_mode && ((from + len) <= cqspi->ahb_size)) ||
 	    (cqspi->ddata && cqspi->ddata->quirks & CQSPI_NO_INDIRECT_MODE))
-		return cqspi_direct_read_execute(f_pdata, buf, from, len);
+		return cqspi_direct_read_execute(f_pdata, op,
+						 post_config_max_speed_hz);
 
 	if (cqspi->use_dma_read && ddata && ddata->indirect_read_dma &&
 	    virt_addr_valid(buf) && ((dma_align & CQSPI_DMA_UNALIGN) == 0))
@@ -1632,7 +1687,8 @@ static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 		     !cqspi->disable_stig_mode))
 			return cqspi_command_read(f_pdata, op);
 
-		return cqspi_read(f_pdata, op);
+		return cqspi_read(f_pdata, op,
+				  mem->spi->post_config_max_speed_hz);
 	}
 
 	if (!op->addr.nbytes || !op->data.buf.out)
-- 
2.34.1

