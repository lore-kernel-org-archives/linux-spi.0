Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB85459AE3;
	Thu, 23 Jul 2026 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804589; cv=fail; b=j2fRrlPCi5vB1ZFa+AMOi+7fPm0eCMy8rdbKW7AJ5QcUwKbSelBwfeFNRFn1y6DNOOtknpf9jLnvjeASribs7MAPz2rkP0aLninMG6lfchIQ7IZYf/5u43UhZ15iXb8ABiDfJL6XkM4w2rnj8k/DSnhGr6VJwOHhvRuEk7k5nZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804589; c=relaxed/simple;
	bh=4oa26rSgSzLAyhplzRa510WlcMbc4I0GAPg7DwxDKWM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W5L8X+s8vgbbAnXUPu3/a0nNqfoqDDeIIwPoRmMcLpukzRTW6rrhYc0lG1tcASC/+uPYZ0RY1/qB1O4hxqK1MRcrbfnZslpDx9W4SgxypkPt1gBGM2KkuHrPRc9iIDzNuuZcBnkJqUz57AGK87rvXrTiN6CBpo+jNiBafTMPAFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=H8q1TZdE; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fN3l5KVg; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="H8q1TZdE";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fN3l5KVg"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66N9I94E2039663;
	Thu, 23 Jul 2026 06:02:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=wthubxrx0wa3saAG/KwRvS2nadAg6fNYlJEYHhse0
	H8=; b=H8q1TZdEtABAx1y+1P+kI6OKeAtQfk+lTKMrW6/E7KrxGo1jseN9DAs3C
	q+n47BuMXXjyUvXF0h17fKgy/qiVPenDNqIa04m+3dy6dEbyB0ejAN5JSKBgsZWS
	EpJDmAaCTspTKQ5yt9boJhbRwO/5bX59T2qydB8O5v4MidXyUyf1IQhanUby0sCg
	OBixYYr8iNgW27IiboLMrzvbLgWxtxIVqvOvs075mHUgFzQ5+KUboQet0tCYePHc
	gRYgZLB8WYyDHkFSA5HPpvWARwli2hlMEFV7NuEo9r+FCc/VnzbxT3TVTR7emUT5
	S/bkdhoNPFP9L73DKBL1kjv4yD8Sg==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
	by m0380145.ppops.net (PPS) with ESMTPS id 4fkg730c3s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 06:02:53 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cR/X59Gfu3qa1n3hzvU8t0tRLPXaDFx2nJWp1QhQD2xqc4a0Wq5qjygEhPsYTSDs+eeF4TkY+pIY0Rh+8bjp2O2evWbkvfDHz75i3mabEAMSnJT/yhrDx4NYKTFHaDA1uZOrl5/k2fUIyMPT+9iltkIvrJzviaLITapELOlnZxSkCkEt+MXQcOQ4k/NGpdpIz/r3vU35lYwbfQg3YlmoMMh34IpIatDCuCsbfrOqEPyKzEMSnvnPjdoX6sqZ0QLY+UkbIe5MKzC1+RduNfNx0s6PjFpK4FtO5bbHUAkjHpD0UXb6Yf904SY7A9+zBw1lWuF1XvkKD+BXzaj/CciOqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wthubxrx0wa3saAG/KwRvS2nadAg6fNYlJEYHhse0H8=;
 b=co6RbIN6RoLydMC5MxjdVmeH9I/4uTWh4xSNhcC+8muVpuQ4JeaRZ31EZUSCZ/Qu8NALUwv2CRFhXFgmuEv6QRGKoel0ITKmZii5u0kPH+rPEzRhY/K8d/dyKmn9+BruOlAJq6sN25JTqw1ObQVRWxwpSa8+TqauhtGAywdts1mx8p3/7bIUzXMmNQ3PVBP0S4mX4AnDN2JLhkagQoSjrmNpemGDVa3qHwJhY682F+j2cy4Ca48DKJPuRjvM/t5XjijL5zAajAaSrkq6iBtjkLuH96XcW/mf96JoyzMBAYxFJV2pmqz+z0K8DFVItc6jfMR3RGx7SwMmR9g83qLOrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wthubxrx0wa3saAG/KwRvS2nadAg6fNYlJEYHhse0H8=;
 b=fN3l5KVglZS4VBpJnYuM5mOq5QWJqs+gLl1+0CH15SaNxBukhQJOEhWy+bXbgN/TZ3s4+wcxwZIbyMllTCmxsxM6r+YzAItl1ICH6jHitCkal9k0glzqlMUpB7hfPU5hYiV75JHzs59GKoogNWVVAUdYhndGYXUE/gHHQp3Rnkc=
Received: from BY1P220CA0050.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::12)
 by CH2PR10MB4310.namprd10.prod.outlook.com (2603:10b6:610:ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 11:02:49 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:a03:59e:cafe::30) by BY1P220CA0050.outlook.office365.com
 (2603:10b6:a03:59e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 11:02:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 11:02:47 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:02:47 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:02:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 23 Jul 2026 06:02:47 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66NB2OVx1577597;
	Thu, 23 Jul 2026 06:02:42 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v6 03/17] spi: parse spi-max-post-config-frequency-hz into post_config_max_speed_hz
Date: Thu, 23 Jul 2026 16:32:05 +0530
Message-ID: <20260723110219.3180747-4-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723110219.3180747-1-s-k6@ti.com>
References: <20260723110219.3180747-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|CH2PR10MB4310:EE_
X-MS-Office365-Filtering-Correlation-Id: 41b91ff8-8ba0-4ea5-d5d1-08dee8a9ee51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|7416014|56012099006|10067099003|921020|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	PiBg5yB1aVM3V5Atn2SxYJHw0vSVy5e6Zoppg9T0r5Jf5XOBIRAmXgGIavu0ZKmTB1LIePnQRj2NZBS9HQl/13aACGBfCvj09nlFBrTuBzs0pPh6e3bAqBxh7HqKUksg5g/XD1lEUpGO62lFX3npeOcXCBjwUfKPpPoSmNmce/sgXocmtS37AfcfQ5LL65HiBD9UvOfsVc81AGtZK6Vbaxmnjv+gw92DW1wrxndbQmT7pHjLoas3US4bonauKeTeGQgzhIMvbvfW1gyZlN61+FMGY7f9yNg29GSVDo97RmmgJeC8adSy5CJy4Pu432O09bin7VbyKlHrUQMSeAqU2NmEHx3y/fnn78bMOeunESa4KFwBzQsjDyZYo5AJcOYTe37ygPjby1boOdRirtGx/ay8K9ug//l8vY3t7uVFe4N4UeOmh++uJeUVMvxmmYHNaV/8To9aO6CQruL9AP+kJc7BswwNFwgt1i1IRoQfVemc66BNbUSeKNUBePfG7z7KkhGm1xWKwI9hY8+H9nmRFnoSb/cmLcA2ayyii0okEMid3jkJHoRTiKy5RDyZHa4+aTDfFuVBS8PweK0xdUx+qnVpUrNJq1KGcCRY8s0YDhyLgwAM4oAAtblSHl4IcGA5WhXcegaGJQ3JzYZC1QY8LMz/Silhbv7kYVB6AilDdDmwZsote2OxMjhFOTlRwDhPRRKcEYryY2T7ClGC3CQwiTwxSR2x3vCtVrSkbbOHJpaBjpjMKg1EXRUOxe6XxRvL
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(7416014)(56012099006)(10067099003)(921020)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YAk2ZU8QvQB5gly4BqXLdJsyNQzK7Xp9I4ps3SADb3+BngJir7PwK81r/+10Yr9/PNcDyKtF7bI8m4cw4llhz9obwJpkZ3Oz31E0vRA3u6ZRarlS0waaqkVKWZtKAC8xcBtNiW7kok008UpA74YFCQbXMuegrl4zpn4xGn8H0/S4gdJt5TGTPlIHOx2RaDXuFUu5c1eE23kKquO26WNfkoNT6J1mCC6rwbxZFCEzw3bH9Oxlv6aMvZ5HMloDj2HZAjL+jvPpb8t8UE5wU2JYWUTSmg77UbMttH0Ks+vfUGEZnlalhbuxRkF12q3r8ZyFGbR9RLZLZ7s1A3sBAP7CVx8Ox0YY4u7v9vPgtKnf88y9/Xt1KzsbZKjPxClWaKKXzs5O7bsld9EGwl7h7cI5zmL+3yUvJwDdg5XlOfqUTUGBS21z1R7Ha0SPsLMzIfRT
X-Exchange-RoutingPolicyChecked:
	EjTmGsP1NjgyBHrWc77bicp5bpQFWl0pUAVEI0BiGyMdCJ2o8DIwZtrGGuVxNCulU/cV+SH9lGnw3BhjFrEuAQj24laqprM7Gu0Iiq6KLdAF9529ARe3oPx+VXB72Df06mLLrxBZ0op3KoP1zhaq2H7UogSO6Ll9mw31te21SDhfkKMko8b4KYVD4qtf5dVZ0H1seo9QdCCfpf2j/0bkEnyccf6XM6lvil9cPEXGeeEOwXBmxo7g+jgvtT2o1IOY9NxU7PGV0OgumY0FLltcg26H6TTcfcsgJeqQz3RgBVIUfds71C/5wY8F1mjN9on7AFeHKZeCSkgN3tQ4mR58QA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 11:02:47.7252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b91ff8-8ba0-4ea5-d5d1-08dee8a9ee51
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4310
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfXzkVxgachIDnA
 60yqFBJnHY9B/RkW1RAQA3NaMsezZx48in9FIzxqhgvRaCskbbaYi7a0AOz5qlaw43DoIx4PZmk
 GQtYmsCdcM4qTqnaQRa1AoE1Gib85j4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEwOCBTYWx0ZWRfX3aXMbKK8daMj
 kIPCHWzb5ROhLPW+JSKHs9gmTSl1u9zG2Ra4iidaL2ww4uX7vqf0SGsl2YaYnfBNasoArJssKs2
 5CMY8OuQgPTghv7daeVcvCUcJYVUZwGhZyFunLlbadEMLiU9IysStPfxgcP5W8e343kicaL1Owq
 CHEL/PfLEJf7D1ufvgLyEx70SF6u3KPA9eya2Yghck38S58szNkq0Nd7w3n2hVlpyxvCQr7DS8G
 aVTExRjzgqxG9gNOkyRwNZz/DxfpsmToyYBM3A5P6OxushcLLlN/aw1O7S15mQskObV30IiyJhH
 V5Id6rfzHvqzYSQKcucPwNzHIhJMdHfkGlUfiQnQhGsNPfR8KARHHVNWqYZA0HpdxQWAjK1sc+O
 753lPbbUlgusLq+46TD/WoMSm3dcYXM3mcG9wQjT5v1sbA3sumo+LOOuYSwsUm7A0ZqP2ldNy0Y
 zkxRKrJ5v6P2r0Yg5YQ==
X-Proofpoint-GUID: 7P4YJCt5m8JpUrz_Gvt-hPwBcw1bQ5UZ
X-Proofpoint-ORIG-GUID: 7P4YJCt5m8JpUrz_Gvt-hPwBcw1bQ5UZ
X-Authority-Analysis: v=2.4 cv=Z/Dc2nRA c=1 sm=1 tr=0 ts=6a61f4dd cx=c_pps
 a=AG4d6nCg1awo7HAtkzPOig==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8
 a=2Gi1gDZmOG9PIfG5304A:9 a=O8hF6Hzn-FEA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230108

Add post_config_max_speed_hz to struct spi_device and parse it from
the spi-max-post-config-frequency-hz DT property in of_spi_parse_dt().

This supports SPI devices that operate at two distinct clock rates: a
conservative rate always reachable without controller configuration,
and a higher rate achievable only after controller-side configuration
such as PHY tuning. With both properties set, spi-max-frequency gives
the conservative pre-configuration rate and post_config_max_speed_hz
carries the post-configuration target for the SPI-MEM layer.

Zero when not set, preserving existing behaviour.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi.c       | 2 ++
 include/linux/spi/spi.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d9e6b4b87c89..7e7393d25810 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2602,6 +2602,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	/* Device speed */
 	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
 		spi->max_speed_hz = value;
+	if (!of_property_read_u32(nc, "spi-max-post-config-frequency-hz", &value))
+		spi->post_config_max_speed_hz = value;
 
 	/* Device CS delays */
 	of_spi_parse_dt_cs_delay(nc, &spi->cs_setup, "spi-cs-setup-delay-ns");
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 4c285d3ede1d..aa7b1b34a594 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -141,6 +141,8 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  * @max_speed_hz: Maximum clock rate to be used with this chip
  *	(on this board); may be changed by the device's driver.
  *	The spi_transfer.speed_hz can override this for each transfer.
+ * @post_config_max_speed_hz: Maximum clock rate achievable after controller
+ *	configuration (e.g. PHY tuning); zero when not assigned.
  * @bits_per_word: Data transfers involve one or more words; word sizes
  *	like eight or 12 bits are common.  In-memory wordsizes are
  *	powers of two bytes (e.g. 20 bit samples use 32 bits).
@@ -193,6 +195,7 @@ struct spi_device {
 	struct device		dev;
 	struct spi_controller	*controller;
 	u32			max_speed_hz;
+	u32			post_config_max_speed_hz;
 	u8			bits_per_word;
 	bool			rt;
 #define SPI_NO_TX		BIT(31)		/* No transmit wire */
-- 
2.34.1

