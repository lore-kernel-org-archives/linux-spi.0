Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D537317158;
	Thu, 18 Jun 2026 07:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768348; cv=fail; b=iivUdmeLquppKtVGEuF/8GZY41S1sNmrNVjwNjnNwiu9fKO6yzcKfSy4OrRGWnH2j2z1T7KWM/hfXizV33CNLguhpUGIQjrxEPbkc4v5OkaALMLuYMxJUQuFSj1P/3bit2c+bruLc2bSeMnjAaNFsIRFgF/eRowKvS8N7mBadmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768348; c=relaxed/simple;
	bh=1TNaL961Cge3k7wU6h0EQ4Y86FKi/4AiwNfqTwOJcWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MN9UDmVG8znfFMizRW/OubJRXXbg5aAILuCktnqBGB5YkhnhW+44FnhiBvMnM9i2/MueLOOI495F6Jij0GDoBQKiXRO04xi4VF3pyes7uBlBnAG94pEGYwxN0KAQlDEYGixqrHLtvxLd3x6VqF7aWN90koB+NzQi2+8n3EBZixg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=nI9gbxqt; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LNXlM9DA; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="nI9gbxqt";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LNXlM9DA"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I6StIo3435889;
	Thu, 18 Jun 2026 02:38:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=mWYfQJUfKbZZJ9k0BCHgnlW6JIDDm6EOLXaVsX8Kd
	e4=; b=nI9gbxqtUhQReS/y7A7Ii7TPoIV2x5ACRrideeMqNoC4WCA2CrOv9eipr
	T765px8dbLjyk+F4Nq1X+XCmpu+z5kqMwCsLSt0NT+dnJjT5nH+pG09/eLG9jn4L
	ELyKdFaHFwRiAMAD9+98wH0D5+0u5xtaIYtS4NzKHzAW7dNBAcB8Plz9VnZ8tlGd
	P0iMcNy+Fn+HcFudHkzgf2oliFocPqse8hajMf79vU0Pzxjp1iCZODrdZq1d9kuf
	TcN+egddwzwFNUwRDkFiA3Dwp5cYDCkb+gegHFxzIBIi6m871kWPLf0rFmIzmnhA
	8kn4uz9qwunfX/Ys7nLg4DSnvKvfw==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013070.outbound.protection.outlook.com [40.93.196.70])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ev63rj14r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 02:38:58 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbzXzfdBPDrx8q9kUNnKLnUpFhOSVdWiZePR0vPVN3bAoFfo0dWyPcYSREvKJKlCo0NwytgbK+tdonuYZRmsEvsL+r2KDOfbJbOqb5rgsF2SQDscsJB6IAIe7ND0et6zDPXRLKSrNOcQfNIpo7wXPiPZHx8XlFe5QhikImIJrWvdSHD9p/EPLAGGNmdrDdEtNT8Jeme3x2OeOdZybJEFMYx0B/yQArU9Y42QHOeD2C0H14pKZ8cLWDmAC3+pwYGBK8mhB3OjI0WsQMyaKJO517bowjg4YTA8AVy8iqzD7UKzspWP+mljbVt+vBK1+Jh6sHNA9fi5MXRkAm32UFv/9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWYfQJUfKbZZJ9k0BCHgnlW6JIDDm6EOLXaVsX8Kde4=;
 b=yuCVQxQUI4zF3s4BXZ+vwgmiz66subbPUaCNnc1UXJnvOYLE6Bcuyowbm6/fwlKWXZq274D22zzppy8zY5kNyMwmAQgNvxuZ65hLANb/zB1rf5qPUS1J7txRob0qFfMh9PFUy7JE5yD6r/f4V+G0C0M4/ga4+Nu4gUOxw8KKOwL/QYhhQgVBZw2BADKnxmayiBPzpvXlYV9KfJoWc5TwfiCELYyjdde2XS6Vf/MWoMvB48rSebzhgrPvmq//8ltiuX/9LH7Ckd5MaBcagzq9MxAhDNSxl6jiGgs3d2/GJzIkwrF0HSScsj0OeAvZfOSnfVr/xb/nemrnm3M9DlqRWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWYfQJUfKbZZJ9k0BCHgnlW6JIDDm6EOLXaVsX8Kde4=;
 b=LNXlM9DAEGLE/xyFbeAhBlaa+i8ZIWT+ADXyky02hvelDHII0e62AjP0i8rj8XK6O3pdc0vsWehoN0JhV2RjxEdeN5c7L18f67TxDg8WXyzSm3Q55TdZZsgbMQ25/fdXxA3+/w+QcYDH8Atlc66um+HbU53idrZTHtJq5emSAJo=
Received: from SA9PR13CA0072.namprd13.prod.outlook.com (2603:10b6:806:23::17)
 by DS7PR10MB5197.namprd10.prod.outlook.com (2603:10b6:5:3ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 07:38:54 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:23:cafe::32) by SA9PR13CA0072.outlook.office365.com
 (2603:10b6:806:23::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Thu,
 18 Jun 2026 07:38:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 07:38:53 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:38:26 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:38:25 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 18 Jun 2026 02:38:25 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65I7bYvh3521710;
	Thu, 18 Jun 2026 02:38:06 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v4 06/16] spi: cadence-quadspi: move cqspi_readdata_capture earlier
Date: Thu, 18 Jun 2026 13:07:15 +0530
Message-ID: <20260618073725.84733-7-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|DS7PR10MB5197:EE_
X-MS-Office365-Filtering-Correlation-Id: 26f7006e-90bc-487d-fc77-08decd0ca58a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|82310400026|23010399003|1800799024|921020|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pilhlJirT7ciUU5EeNMPEx8WlTukzpUG+0MBH4n+sDwFVejlTAZ1UWDYYN6KqR2nWLnOckt4CG339Kf98h8bW5EnCGJzu7FnSKEBVVOHmZdb3gCQ0cvH52N+e5wWmIqkGR+tZJtpcbt84ZOWWRSEGlIUkuNVDCJWeZEwSkq5JICm6HXkyHPiGaTGZbKbZUTFJze0T5igrTivnOqnPXsfJr4/L2Yk/B8njGuEfzfIs+tfkyP9iVdlMish8WOaacnrORcDAQ4MuZzwC0eaZH1t2li9Dkero1RjH7Qj6mkd75HBHDze7Uz6UsyzpnBPvOiK8uITTW0OfnwaDe+u+I1lsWbcGBoS5jusssnE8e3IarrAyPYz4QD4aQ24verGNqWhBfhaSiCFc32AyAH5FTtuqcumZf1tijkRdqF4yCkWNFtBOOdKuq/m4rmHpu74+SEC4GWeYlt0u35B6Jla9bqik4KwGbrLYXV4m9YOYBS5uZpyguXlRhs5kIKM1buhuXJH/VWag02nTbUH9Qcb+yy+fIyH+KtZGQfbAs7IHIr2aveYQ8b//mjftzWxdpKWQJmYnVPIUvviX/tdDccl5AR/5pjg39RKRJxjFAUw2kolw5MxdB+z57j2pe+/TbPKPWsrhJk4nu9GktVd7yFMx+rquIdj/XWK1pxShrJeAClQiZeaYNPUHlrkyYPp63ESzJQtVQ2i85+C+XMrFjnxGX+PxJ6z9wRGwbANYmHKCCFFUM6FvHcswhhl9+rA1bmMQ7hTGAbm14qTQAfYmIWPR5RQ4g==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(921020)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	e7y4Q6MafOq0Qr7SwutFQa3kpn/q9BClqAEOI01FxycmoAOo/5VrGKpWzsy3Hnl4ChNPQX+ZZBp/avCgcvKs33q5LMVd9vJR/dTV2NZdIghggaIjkUdCaMAnKS63TMi7oY7gImDtuu/pDxpqXJ3FrgVYnL21P6z4ES1pl6zXPuG9WD0XozGWhjynWe5AUo8feRAUw9GO8zangZHbp9oUcRM8pPGzFTiGIVrMuCEwVsiM9n0HGXredx8G7RvD19anN1aXkJD1z8fxn8KIjEZAeP8guGwAIaGbZ+0SIeEwB6HW1ebpEZLtG/JZqJkryJ6NdCaOpPU1yTBs62YdJP1E65TmT5i93RW5IW2p4Uo8qtb4PHg1t88S3Iq+v++YJF44mC4vel2zSSHNyKJLARDvPNPJ8ETSol0Drlr0G46wzN5RGYUZwZkWHQ1Jyx7dVtPD
X-Exchange-RoutingPolicyChecked:
	qf1/+A4mGYxW8pOcpr1ndjopdqztig3kybTJzOa3XYSrNNMCyrOLXO/OF82eZMzcer1paPJfJj2AcLinN1a1gimj02Gj4ep5LTk0t0XMJaJ5SNRJ20CKzSuLV11k+xm7/hJ5AJSdFUCw+nmyXj5nht5Tw2a09hT1M/DHeJ+mZswTmA4Frn24wpHNH/RVUFOffKdG1PYGnR4Bd53UVo7x4lPrbBwYz+4jejStuQdINHlMd9zOzQFWqT5le7GHNux/RdO2jsyn1vhelcXKAp/8oj0pC8wg12I3Z3nf45i2IF6wsx/VTidu24tFzFTcDximWA0Wwph12LUtqdfniKhpRg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:38:53.3094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f7006e-90bc-487d-fc77-08decd0ca58a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5197
X-Authority-Analysis: v=2.4 cv=LpqiDHdc c=1 sm=1 tr=0 ts=6a33a092 cx=c_pps
 a=gDBu5PZszbgJPyH+JdeeiQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8 a=H4zukSXeJ-NHMtihckAA:9
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA2OSBTYWx0ZWRfXyWbw84lAivCS
 YaaAit2MGgiRZIS9dgheBvpfGPsd7pxdLvgeJV83XmCo9lKgrcIMVj0gu7xo6Up0uPHaLQ/GMtL
 yqj3UJGKcan0aoT6t6BnBt/Gq7EZFhREtMl6JqvBfz1yNU+a6UpBC8tTWIMA+FIDRUuOV7prcjc
 cbBysq+CIU1B/Md6NoFQ5G5R2p9X3c7nisLHDSN+9d69qhpNrlddtyKgTSxjPXy7Lkrj6c8nd3i
 iYHm/MiSEyFTWxMpM8eyehgTOvauBXwjtMVor9NnQUDWUgkkLay9exipjhe+lWRs6g/HJGrYAAt
 wDtzufzUCKk5spORCxLlnQ0AI47bPUOrGUydrr6UxhzEzRt72IyuFakmidYlwxx0CZ3jBEq8+ab
 EZHFTN5Ma7K9vsI1AlwZl4OzM0bA0ajd4hLCwXmldHl0cpxsEUbY38+SaUOjragPlG5rbhpXVys
 xOG+4tLehfrEl8vWusw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA2OSBTYWx0ZWRfX1RKGEhwLN8j8
 YhJH8LSm9W65bvKxzDPBpQLgiu7MxsGtb868F2YREzsT5pKubIGHixDNSn7130BgdqVHwhotpX5
 ff47l/De/6V2Vu1zrTwmhBS80140kBk=
X-Proofpoint-GUID: UnJRMqf63kBWzcQbG_YiG1VRgUdL5LwI
X-Proofpoint-ORIG-GUID: UnJRMqf63kBWzcQbG_YiG1VRgUdL5LwI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180069

Move cqspi_readdata_capture() function earlier in the file. This is
preparatory refactoring for upcoming PHY tuning support for read and
write operations.

No functional changes.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 45 +++++++++++++++----------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index aaba1a3ad577..54fd7b591e06 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -453,6 +453,28 @@ static int cqspi_wait_idle(struct cqspi_st *cqspi)
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
@@ -1270,29 +1292,6 @@ static void cqspi_config_baudrate_div(struct cqspi_st *cqspi)
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

