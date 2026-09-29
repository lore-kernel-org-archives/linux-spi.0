Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744EB44238D;
	Tue, 29 Sep 2026 06:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663843; cv=fail; b=i9/2BDExqEvSCbDph44mzxDoPdCMQBmCbjg6bQf/l2SMK+1mPMvqqwu27IZq/LBrwsLFGKY/8VWX3KTuS50Kr13bsCpRkXwjWPUNBRZchTdQQFUm8TQ92sbpdEFccgXQl/Ii21jmJCqnRyIUOA9VKmroWy7C+CvbhW+sErcAH7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663843; c=relaxed/simple;
	bh=v6ww6XIH8TcUT23LUPoMxzFGFmhFMyzO6/EXwGCMXPU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jPkLN+urf/zDN+MPhXTDLa1zZgMg2TN0VsX2H1MWSkAjos+kJOOIBjHBT4pjLi+i6xV0cYHEpqgfZ+U/orCB0DomCp6+QXGSVNEwqT4BAHESndjhTvKegPs3CPt4e9e5p9VAwXVozMSNxMUQsrFohjHrM1hUqX36GW+QZQ565Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=LQWuhChR; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=MfPeYFxl; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="LQWuhChR";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="MfPeYFxl"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T46Qd53284093;
	Tue, 29 Sep 2026 01:36:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=vRIdRiZggGVJbvsgQ0voaqOH53asB/hPokr2J9K8C
	Qk=; b=LQWuhChRf1E04C9eKLRNmkym4m2U8rk6vh0BEsHDSgB/hUE95Qr978d+4
	c4SjeTR+mESNsgEkB9z4PolBRTBpmSTsON0H5e813TTDKd87b5vlP6aXCYNSv2xS
	W2za0GFU9kj3dAgUOgCxh4V8Pklq//+4XTkAS0pJP3hYEex03RWrGF6oYxDCArzj
	nJB/4kdtRI08rRc0gO7pWWAlKOZKuXWQ+2AWmCG71qCHeea1josfrAPWgSmD08yy
	1vxsdPIeNlUF4xX9NOMLe+Z13pmbJIM/q0+W/WgZv6tKneb1o16NLRFTrhS92ivs
	uFnxbhQLk9Sfd3v1uQ06KJ1a5yxQQ==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h03ad9q25-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 01:36:54 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljmigVERpxVgS7o3EEeLkXHik9zlOStjzhfp5/a1NrVm2uu7QMnCRienzG7YG82LPAxPIyrTkvMJCuj/DWvDIwUpWsZKIP4MNo5zP7g+apXXeqqLm8XklMyEJixUIRn+hZYQNVnsoFP9SRRhFaO3ax2bDqYtQ9belI3xAtcHfFXDvzntBWNrKkLBnKfFGse6brstc6samuehwsqJmLxiunv+Bq3j9FO057/scEaHIIlHYSt+P1g7FATXSr8NSNEmQfTFfEGeARibWvNRwDx/K1lfzO/zXvD0Aze8o7PVgfaO/oxNq4jqLKKfocOFV9dev0Uw9NDUXS3NYwx98QRUzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRIdRiZggGVJbvsgQ0voaqOH53asB/hPokr2J9K8CQk=;
 b=Q3t9cmu1W075cgXOKpCSjEs249bOTJ3B8If21/n2R1AHMyfXpFvUHWOiOxLTp6lUsgmQgecjEHYRViqRi5yVuq5000EX+KTzp0LpSj6/tV8yT89O4ZpTJU+BXOgSIVgtP1FapqI7n1ukW7HJ19xFpVFwU6jRWwO7xDYnyYcB1V5hEjmStioKEvDk8eiUvjeQaloUrZ0fXw6qvac/8cFu+OP83UFaGMh9Z7vtdO64FM9hmwak/b+FpN/l+T86r5Y9XhFKkuiCHhUVsIgueZLWytgB6EwjZBEJvpHTVoZO7uB7NYmNjEWomoNhJRFWozv2k2nX9ZWbGrjDGaCvCp4faw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRIdRiZggGVJbvsgQ0voaqOH53asB/hPokr2J9K8CQk=;
 b=MfPeYFxlMl/3FOWMsEXk3VfeR3xfg4dprFNLIRN6+f2EBlFJjoM+8Ihvc7UsDkdulCmdeSX/MAXECWoRXy2U9fpwHINUjKbdNPCDmyF+sysSO2bE1QttNaAf11BxdunR+AZ/wIiDR6ppTouUKidgd5bBycxH1C3Zv4EB81Ia3Ng=
Received: from SJ0PR13CA0020.namprd13.prod.outlook.com (2603:10b6:a03:2c0::25)
 by CY8PR10MB7292.namprd10.prod.outlook.com (2603:10b6:930:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Tue, 29 Sep
 2026 06:36:49 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::2c) by SJ0PR13CA0020.outlook.office365.com
 (2603:10b6:a03:2c0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 06:36:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 06:36:47 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:36:15 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:36:15 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 29 Sep 2026 01:36:15 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68T6ZZn61395904;
	Tue, 29 Sep 2026 01:36:10 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v10 06/19] spi: cadence-quadspi: move cqspi_readdata_capture earlier
Date: Tue, 29 Sep 2026 12:05:16 +0530
Message-ID: <20260929063529.1235417-7-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929063529.1235417-1-s-k6@ti.com>
References: <20260929063529.1235417-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|CY8PR10MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: 188ca9df-8d22-44fd-4e7f-08df1df4093f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|7416014|376014|1800799024|10067099003|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	aKryoSN58Mgxqlla6SbJoIMy83jvP7UhxeInLpvJjw5inNmLR721jRYJoNJqxkItLJ8g8Fk8qzTiYdlTxxp8VNI3omWw1TzGcoTaulicbcUszhVJ4ZiE8vel9OnLPotqEZqmv7vrHIhaVLmfHCJ1vya1nlaPryIKcciiexFGZyBMJD+/iULLFuPH5oSDpMpBcpLWQtwMMiJvMH0jFu0mqD3BLs/YuQPD+UWu5+/OYnrnAXmUt0ZqMgPTZLQBSzd8WpoTuVAm2Wa7gknB3LUXGAWDzvihMsK1sAjiWF2JZSSqQ1C693yNisnTNBI+qEqDHDsmZRNPIwRdA8QJLIMpFuGVjykF1p8Dcp0OSkrFL9EzGp3SSosQ/fY0dxfJKY7pJWMhY3yy0OGtc+mq78HWpFnogz//+6zrSzFgQEE3hlV5WKk0BMmA52VhjJzPcnWCs08cvYFrx3KjhuJWRBNojyXx5ZW8IzfQo0Sgvcj0BpRc220CxuyEfZeoRWLHAlYdb5UVGrq2yY3WgsH2hXWvDN+G6A6PQyM/8aYhzpW/ztWnUaJiJdHIvSk4JCHzUKM0I2nR1yr3xn1pfok3IpGWg9JGRA1nW2NrkNOSIVzDuH0Ob1PJZGygdfeErGqXJX2zD52gPN2E2aUeDopRdEOwuWcAFOkYVF10v1qbNh1Mw16v5RuL13GoBY4BRjSH/vbfO8biuQ8/ZJe7AzKE+Ld0DgJS3dvpj7tpZps92kPLO+kC9Kc85jGWqBRhx6XMqaD/
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(7416014)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yt92ReBy+vReWw6XjCfd4TnoIU+g86g4L9sxhdxyg/UI/8W39FuQs4Fb4Kp/kpxozLzas9JOB1sVLQCAv61rNUjXdNhYzbh43bPBhObF4e/QASMqzz84lr6VyN/rbc1PUBz5zujVl+avYFnmw1+KER895FQpWmxYTrQ/59p65HQzyz28/hhwFi743NbiEwe0F1qu770Oi5mndEjdHRgeWwk6FBirCl8iX8hoEFHcWEKemsLN2Z86vHnb7xMRHeCHXp5/YkgKeMuc6YqBuQfrHI7vE7Jdew3MUZRBe9QZmC5OUjExstPr8d2xPGuExFIHqSVdKDSFMlkqR7eVHRBrQ1FDlWduoU9GrUMYvQxTFE41QK8IdjctVN2IulsPKcgdf+cptxC8/qOCLPr1cjMjDOF0C+/p0funnwyo5LQu47YvZQdJ+7AxxRC80eA30roN
X-Exchange-RoutingPolicyChecked:
	F8TMbIoye8VnWzdiw7mHRSEs/Bqas7UjrJ7KfOTeV3Jrsj1YCiIPPjOEInWjwxZqB/nc8s4SZd2TeEsAMQRe1ndE22XmbVVZ8LIcVR9kk20YzsrN/sHhkoRnN+XRDVpZkq9cXJnoF3CI3Q544Kt3rhuaJLNTNk71gWP0TedYp1VlX6aLc0jqrMkTRPEtt0GWCVcFGXYGD//Wbt+FET0gUH/G77Eylb7KxKaB0f5Yr1xh1wesrKBvGTljbGLp350XXo3LF13wFpei8RM1trh/4AWsynIeP1Tw8+yw8TSE0A6aJhxUToIO9fYWCEubN6bVnMDta7W/RTpPjlEMARXN6Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 06:36:47.2957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 188ca9df-8d22-44fd-4e7f-08df1df4093f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7292
X-Authority-Analysis: v=2.4 cv=c94+0h9l c=1 sm=1 tr=0 ts=6abb5c86 cx=c_pps
 a=ReLZl+GdXdFt35wSL8r9Ug==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8 a=2vpyfyhlguDYHLkT4YcA:9
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: DrkzhUuaT7BhI8YBoo1a-NUpLzbeDbW2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfX6c1Z6yivzbj8
 /sw1pO6i8cZi9X8xZf9D0HcxyL+m2XVt018UzYleJyOIDylarhRhUyKO1AS8SEqdrFhZRWZ1hvO
 uEdFRMp9PgH4q68iRWEOQU4CoiftHeDOgGGTSHsaYVSX68EScBJEqZbZhpo4G6H8bm/gba8nzmk
 WJ4bqoT5PuD5XZ/DiJLnDWXeXKTZbU5lSvujKE8b0MWZgQchEAlByHYcMxeUyzK8n4g4Fp0rr/l
 S20YZqaQ1eIl4Xty72C+HxN/qPyCiiUqweBeLFPrBLxFcySEwE+VSP+ERjX8c4ejEivA/NqQALu
 56qh2MkzGIjufHzQExd9zMfd/yB0tquytdgqRrepC5gnxXLnusLlEqayexKRhxzaBlEY8p2Wt3x
 aHD9tpTdcCHYZyphgSTxlBhYfr4HsfD6WKvuWH9MZjw6FYuISTe220YkLq46DyiEDur9adSBxTk
 Di1e192wpLBLl3kR0Tg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfX/UpsbR0AnSkM
 AMXNJTOnyesw+XKI1J2V9oZV41BB7M4j8pjM5KKTaJ3G5gECFhYXHMo4Q0DNzXOb+CgV87CfCMu
 L7+K+raVJUOzb55Qj6Kh1ZrXYtbOZu8=
X-Proofpoint-GUID: DrkzhUuaT7BhI8YBoo1a-NUpLzbeDbW2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290026

Move cqspi_readdata_capture() function earlier in the file. This is
preparatory refactoring for upcoming PHY tuning support that needs to
call it without a forward declaration.

No functional changes.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 45 +++++++++++++++----------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index ecb0be394696..f8e266372367 100644
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
@@ -1274,29 +1296,6 @@ static void cqspi_config_baudrate_div(struct cqspi_st *cqspi)
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

