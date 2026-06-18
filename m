Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681773D301D;
	Thu, 18 Jun 2026 07:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768338; cv=fail; b=kXWPJNpNjoTei9cOvZeHFOqfy2Iar7vidb9Ke0TyAgmKl3tJ3P8bmglWlEHut9EcFUvetNQ2CLUs34UCLibCavfOi2gJBTv60HNDZfEhWeydzgqKTbuyL5KlJP+r+rLipY3UHlxjtmQ3k7GDIw0F4B0EJamT8rmJ+RiT0THoWuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768338; c=relaxed/simple;
	bh=jw3B9yi+hmX7DsJIwVzasLjy4Zy1mAqhau2w2IMS3zQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rsd0/8E3Qxa0ShgTreKGy79MyJqCQ92erh6Vp8SEwYU0gJ1cFRYwS16fP+Ki0oDD+1+h4Tv4rNTEFVJnJb5ewihGYNVBcaxYtxS09LVIsXDYK+Ed8ygZlLzqkFDcq+GyZ2mXFTmeiTG9fBx817y9QcyBZp7EstHNAGHAVX/xF9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=o6rryniB; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZZZxF/Ut; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="o6rryniB";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZZZxF/Ut"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I3ndbN3790559;
	Thu, 18 Jun 2026 02:38:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=wCZc0wIVBtDCh1p0IprYueCIB6QFm2p/C8s4JQKgh
	v4=; b=o6rryniBkjClmnIVXZu5kvtTg0SLW7a/NXdSxK6gkdIHYoYPr4Az29Q6q
	vrJdpKZbVy3enSo17MG8Dv61eQrxNp78qFO1fqgFliNUD4QnJlSsQVYGc8oYCPFk
	jxlsFPCtOuMC1uq0v+YjcVSSo5WfbqBXxM9WvXatPAgeErzlNhepXZB9AY7OYyCb
	ZU764H+KdnnHPCIvBTvSjQ8cN+VN1bWg+w68hP3WCu76Mr1nuYWst+/yW1ksK78C
	7RTsOvjgqfXlkS4/o+blgbOPHcn0ns1hvVNTReOwwefBUY4/doBMiz/fKIzuhSyJ
	6j+QFGu9KBmuD3XXnxyiwL3BXIQFA==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010009.outbound.protection.outlook.com [52.101.56.9])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ev944935g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 02:38:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfgoAzLyJygW3s1S+gfaYvrCuneJaxE9SQtm3TBJ5JUUHt4cWwsAYo2VH3GExEk5m3UUqffnj0QxtfsU3NybVhUH/I2M3o+OkkYwVfCMKdcYk3ZEfauOQ/I67XBr4zc09FZ3SOTtQecoLMfljg0KUacU9bqDGcZnh6mGnbgKNbIuTr6FFC18el4Mlg7xHTozqqi4NMicS0aNcsagppYQz4dIdm6Dv0RxU3xoGFtiGYPO1xfPuMZ9w1FgBt/d4+Bg3agmPEPFmcxGJmFSUg8BDYMyr2HVxLpDM0YQMsyw0AOXKo52ooHO9+1luGh1c1fwFAQmqse1ygFSmVQRPCL4aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCZc0wIVBtDCh1p0IprYueCIB6QFm2p/C8s4JQKghv4=;
 b=QsZ7jxMShCXLUnkGSEMZL7SH3OSwgeQFL9ewOCUbUuiwXnMLER1VTUwDBoLxAfTz34Bi3ypBnpOItnBM2oVVkujAuOszUuq3mW9fbcsDN95w9BfQcXaXqdx1rZwSQKDWrUvUiRh25Cijqsz6O3XVxzVazWDFIXH6Fj/50XVX0/SXJgC2cCK3Zd+rR0vwo6lZBTX0dC3P0ZaeARCL9G5rfTkPnSiZwMBOWgls8MSksUspIHfep2HahZSwWqo0He06HI8PLpx7A4cu1yvn3euATE7tpaKmJ/7u63lVLfQ0jUoU0Sgk2k56k0/p7tAguMlDtDEoFipyRWiFy2+AGjhEbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCZc0wIVBtDCh1p0IprYueCIB6QFm2p/C8s4JQKghv4=;
 b=ZZZxF/UtDBCvgGfE4wHw9Ga2dpGx8urMB6VV/tho8ZUG+bRRZAn7s8Lcn+RxqfoC4vZ3WwS2V7L4nQDsAUVYr3m0DFbDNNIy2jPw5l2hIDsCMkx3G5TlUkWjyFBz0vs6sq8INDLNUKBEmJ+b5LkUoxG099j6IWYcXc0xQ63ASVI=
Received: from SA9PR13CA0066.namprd13.prod.outlook.com (2603:10b6:806:23::11)
 by MW4PR10MB5678.namprd10.prod.outlook.com (2603:10b6:303:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 07:38:45 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:23:cafe::1a) by SA9PR13CA0066.outlook.office365.com
 (2603:10b6:806:23::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Thu,
 18 Jun 2026 07:38:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 07:38:43 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:38:16 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:38:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 18 Jun 2026 02:38:16 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65I7bYvi3521710;
	Thu, 18 Jun 2026 02:38:11 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v4 07/16] spi: cadence-quadspi: add DQS support to read data capture
Date: Thu, 18 Jun 2026 13:07:16 +0530
Message-ID: <20260618073725.84733-8-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618073725.84733-1-s-k6@ti.com>
References: <20260618073725.84733-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|MW4PR10MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c3a011-d7db-4d69-8d95-08decd0c9fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|7416014|921020|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7669C7Iz9St4oqhoJrn+u8c1ALBKLHPvEMyB31lB1eXWWICo5l9Z2ceqwLYimq083vdhfoFL3FYOjcAiKElf++JYJ30JOBf+Gz2AkwDR7Y8IXj2JmIsEfd4I+p6G9fssvVjaxHjfGMfqVyNKS+JLm6TlSNRqt4/Qd4ESyPjZ0Y7kV+85940w7sN8YEFg2KemYirwfSXrj5+Hf6KHNLjDWDtDDlD8/7+q5+jNRuQlVXafvYIiAf4hKRCmM/AoGbRNcXQDlOx1bZTQl7LFvq70cDkby4xdY73vuVnGfmIOhHCaRH+iIl+qOKNbYUVkfG+Jal/i/r7JTQv9k7rbXPcaLaGgVRW4nNM6GO5edlJidrUFeCgYbop7U3TAksfbu4fNV/r+N9xzVD5Z5+Dw0edHUXXTrGH+ZhuG8SYpqu9hiSznkxhFJu8CJVc0QEngnitaJkck4TR0J/IohWXej5rG5AU7uVtsPbTvPo0LIECW0VoKpgyCucKTN0IAOxc1Rq1gm4DCe5Wf5mnnpCOHD9FfPYBngsjBi6c4xA43/MNJEQtmGeVfVd/6OYPEr0oKZB2CKkfkhBI6UJ8fBbAqTMpDpuH2NPUuFHK3f4CG3yyY5I8/7ITVQMDCAMaltiRcseaYIKIY1rhcWVVVlmDoqjbeFADnbKPr2SLbcTG9t/tinOpiGBI97a5Jo3EzcIs+UEkaK0E0xWrlnNwg6pw6FKzb1mYanigSQiVIEsnBHmFlgG/QfQc2uxsJQpSa1BnKbh7C/CCuAkJ0E9WpkHJl3n0+Ng==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(7416014)(921020)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Eh++v4qoRGDr54zNn/1yKToHXUhxrY3PLbD/NxpKnvIQ7DPdrNTJHpnmNec9r8syaTUOXQD0IPUrLTbP1s05KOyCMTxeX7v7X0UlbcFOROalpugvZ5N7JMp7LcGFPUlOMKlbudy/NP/8IlKb6Cc512M9jSWTDimgrW4T6+BVjt8qTdx+FcRTsdNnBmffYOPEwgHS9JSAsWlx8vusraMAHB/6wZBDzTqB33v7UMbTRRvzXXA41pZ1ghBOmVVdQp6ezHe0bEebm8dpSRAvHWB/srJK2xGEDySZsCvjoBmGsd+yObCq29ZbU/AqJKeNKWxhUKdsgwdgw+jW4OggzuvsMSycQInV+7JxRODC4S96NorL/BCVujWce0Mxasry/AocQ+o8wTisbG2qxCx2Ruusxk7PBU4DIGW1kDBG/sxJ2N1Fn3Jzv/K8NK1ZSqLszQtH
X-Exchange-RoutingPolicyChecked:
	AegOBd2Yn1ErM9q2NVePmOIqb7BZL+1xnmwSu/ge+FrHksTYekSHytyJ800N8o9FswdoAu+T1car3AwUwMwec8sv2oB9Zlof0gVwNgWjGuNIih2UOswvKkdMrbYluDRPUcecLxC6Hgz9HL06z7EpOHYrPbv2BRtYQvQeu4IwzBVFa3IAMx/B76dSbPdLbznjFgd3aPCk/VksbOa1JWdD6ZltZrIuwGKoZm5/nPwqr+x5j5Cm+4Kyb2nIso/S3y/MVGSoeWl9eQBhVbIkxbtqQY3B/PtOv+DGP9UzdugsM8POlU8aed1q5ztMoGlGRVN1ZKNHBu3Q+x7vYwMuxe1zNg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:38:43.6198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c3a011-d7db-4d69-8d95-08decd0c9fc4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5678
X-Proofpoint-GUID: dYAfudZ4_Swbe0qVXqEMNo79_Zz2S6Zt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA2OSBTYWx0ZWRfX/9IUSFUdmQ45
 10V0h3YxGXTMgTvRfYvhnOfmKkS3WcMBEuNzjiL+IlQXIG47gBN1+8+RpZna/1ZbXFPKiHrxrVq
 BlRW43ae2IewdF3Kq7sHxV3rMzVgBxo=
X-Authority-Analysis: v=2.4 cv=QMxYgALL c=1 sm=1 tr=0 ts=6a33a088 cx=c_pps
 a=St4LTB+eVnQVBP+Ivca1Dg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8 a=by1YfaDFVIW1-MDklf4A:9
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: dYAfudZ4_Swbe0qVXqEMNo79_Zz2S6Zt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA2OSBTYWx0ZWRfX1SMcCcw4tqTq
 sKyTPcQlbwF1GwO9KIyJtKeiOlHMSCyuKeYp27pcQejUxY62S2kHkYYaYtznbFwoPnB5x8tIT5O
 AYJ9oegGKrWNJeH7+uV8F+AuyQzNcl4HdLZdNfLCqbgE8qfIFblkLX9AmFL/QF4gefzPuPw9bXN
 +uYaP6bDNB0Ku3m32pUBjQc3vn4Z/p8gL4h6KlEJQSUMU7bxEfEWMjDpzwlhPLah0zVj5ncJw9Y
 jq5SsJt4muz+/amaiuewXUooeZm+Ui+ZaKg1x1Nirmb76zYebC66/turkX2yJwSdCQhWiRMbNL/
 tjNl1qCH2AM4e7c/a7rmnhHXT2IMLEG27ZASNng5h8RBCWafJRUqzZGdV3uHGZ9djSWAf3qUY2T
 922Hw99EDIcEhGqTAc/f4Mp0gVqoW8FPukWXNrw+/Gy6JDzJgT6mhHepERd7+xatsQQjrYqlAbj
 i7rq4c/MVPymjQGFbrw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180069

Add DQS (Data Strobe) parameter to cqspi_readdata_capture() to control
data capture timing. DQS mode uses a dedicated strobe signal for
improved timing margins in high-speed SPI modes.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 54fd7b591e06..201d69c64c49 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -192,6 +192,7 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_READCAPTURE_BYPASS_LSB	0
 #define CQSPI_REG_READCAPTURE_DELAY_LSB		1
 #define CQSPI_REG_READCAPTURE_DELAY_MASK	0xF
+#define CQSPI_REG_READCAPTURE_DQS_LSB		8
 
 #define CQSPI_REG_SIZE				0x14
 #define CQSPI_REG_SIZE_ADDRESS_LSB		0
@@ -454,7 +455,7 @@ static int cqspi_wait_idle(struct cqspi_st *cqspi)
 }
 
 static void cqspi_readdata_capture(struct cqspi_st *cqspi, const bool bypass,
-				   const unsigned int delay)
+				   const bool dqs, const unsigned int delay)
 {
 	void __iomem *reg_base = cqspi->iobase;
 	unsigned int reg;
@@ -472,6 +473,11 @@ static void cqspi_readdata_capture(struct cqspi_st *cqspi, const bool bypass,
 	reg |= (delay & CQSPI_REG_READCAPTURE_DELAY_MASK)
 	       << CQSPI_REG_READCAPTURE_DELAY_LSB;
 
+	if (dqs)
+		reg |= BIT(CQSPI_REG_READCAPTURE_DQS_LSB);
+	else
+		reg &= ~BIT(CQSPI_REG_READCAPTURE_DQS_LSB);
+
 	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
 }
 
@@ -1313,7 +1319,7 @@ static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 		cqspi->sclk = sclk;
 		cqspi_config_baudrate_div(cqspi);
 		cqspi_delay(f_pdata);
-		cqspi_readdata_capture(cqspi, !cqspi->rclk_en,
+		cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
 				       f_pdata->read_delay);
 	}
 
-- 
2.34.1

