Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A245390C95;
	Fri, 17 Jul 2026 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314344; cv=fail; b=IPjiqF8WwTokK3P1p0IktSvES+igzRZvFrhoOkAup8jFE1o3c9Cdb23n8zwpb9uwOUODAerTKLWvP5O3haLugrL31daydpiG+75pfw8f/zMxiBN/ZLbw+1rEUJgLYzWJrQoMu6yYB0Kj3rZhU6HlMdrIujrZprBEHBM3OkbHIsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314344; c=relaxed/simple;
	bh=v6ww6XIH8TcUT23LUPoMxzFGFmhFMyzO6/EXwGCMXPU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZzVo3EuAmhx/6efy/egXYEM9p8Hdq0+XkRMXc/rWntd+8BACBTQgboYPlFZYQdx7K2qTwOW37+ggGjYzgm5RKAlhh61f5cVYtftytz8jhQAtRINB2usAf+eDatUtrxN9sMr+KCWuBK7vvUpk302Oy1ngxwfD837KNxG7NaZttFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=LVabmH+B; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cya8Rpn0; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="LVabmH+B";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cya8Rpn0"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66HIlUBl1570175;
	Fri, 17 Jul 2026 13:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=vRIdRiZggGVJbvsgQ0voaqOH53asB/hPokr2J9K8C
	Qk=; b=LVabmH+BjzcGKDhhD99CYUwfvTI/sVkoDNGI4OH5DnbUDW0hBxLU/08bt
	IXlrsvyxQt9YgWDcU430OEJMiy0gm/ePw2k3dDlHqqaeogtOz8FnM3irnxLULn//
	4wE/hgWCmtlSKp6ll59E6sSgmryujIq0FCAKMj3Hz+2e+10JRmgN/M4u6UCf6nYS
	CoIzI2l2HKud00760ZCIsio+4MQ03BNTEcOuWN5YRNV0hmheml45kdvnf5pAFyJg
	DQSco5Qqjx9FI/mKAWh5L8NlQfDt1frrQr94ydPTR+ETuGzIO/PZqr0RKeIOH7SI
	6clWTFlwn1CKH16Whuc8K3ObdNAVg==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
	by m0384305.ppops.net (PPS) with ESMTPS id 4ffgsmbgr2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 13:52:12 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKXKcA1YqI8W3hPRyd5KZTj1fGlsqqjosQPoc1dn8lOWdRVXC3H//pkQcnCpxTSk/K9HA2W/1DUn4wG30LpJNIU6ilS5+iaXrGeM6qWA+ZOUGbcSSFOTxFyOHZIkqtoA8Ln3w+8JZulo0GrYDLuvA6d3c/FITja6Qxx9wx/X6Axd0PT2PnCG2UTmHpvC4PXg8LtGwbTEvpTYOOTxl1RnyVsufP+YHsl74uEXtLBxwVZ92wgqxe+IEsJr6NzeejePUHDHXvwRFAUDwSVsP+yPeaO/9/wsrpi2uhjhTxlHZTt6gwNuzS2Jz2FJnoVLZi/VDqNpP9Nn5srRS0l7UsGUJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRIdRiZggGVJbvsgQ0voaqOH53asB/hPokr2J9K8CQk=;
 b=xfHTReXgwB7FO8WYHRE84FD36oXAZqzEOqCnDa35MjaoFd2blZKCUZVOyoE4085fnbHH1ADZXr+S1pBYgZJiyrK7pjHRiXq83Em++IdjyPti+Gwx1jrL2hfjjqluxpOleHCxKvlawahUXxw7O6kYOdTXdt1aUnLRiQmCKXKPFhnGXyS9P9H3qtfbjpnPMcxluxpJDd/1NGxLYfnNPI6hImFfr5HV84VGGanYrbNjMpxS2w30DwRlmNxoW4UE/NFGUY7gyRY7c8U/HvX9qLlv8SkU9/LPHgpPkniVE62kmGjw2tx2vAo4645gRjE+C5AJ9sSEOBeYxOjOqGGhtdg5eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRIdRiZggGVJbvsgQ0voaqOH53asB/hPokr2J9K8CQk=;
 b=cya8Rpn0TLQs8lcgKjjRD+KdrQa00zIanwLPkqATKdp1xkuoGVsdObHUsFrub+verPe0nh8SVeLlja39Sdyb0XhzWOprOmn1ieSJRKgMWNxblhWGkLdh8+KPhezLmSYCfYjrkSW8yLC+QsKYw9TBH0iQMNh7qzYol688DqZdxzw=
Received: from MN2PR03CA0011.namprd03.prod.outlook.com (2603:10b6:208:23a::16)
 by CH4PR10MB8148.namprd10.prod.outlook.com (2603:10b6:610:244::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 18:52:09 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:23a:cafe::27) by MN2PR03CA0011.outlook.office365.com
 (2603:10b6:208:23a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 18:52:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 18:52:07 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:52:05 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:52:05 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 13:52:05 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HIpU4q240969;
	Fri, 17 Jul 2026 13:52:01 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v5 06/17] spi: cadence-quadspi: move cqspi_readdata_capture earlier
Date: Sat, 18 Jul 2026 00:21:05 +0530
Message-ID: <20260717185116.2065505-7-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717185116.2065505-1-s-k6@ti.com>
References: <20260717185116.2065505-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CH4PR10MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: 3842ffe6-634f-4b70-e266-08dee4348015
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|23010399003|56012099006|22082099003|18002099003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	Xffn9T5IwJlGnukuuRZZty+TkTrRFt7+OL25DzXZZPnYX47/IzjNBiDdVA+Q7TObe1n2/tDgnx4BhtdGnF2z52iLpMaYQhMqV6yzj9dQjgahwgU4gx9wCedcKIEUi5o61FiQRB0viu9t1sTxxE0PfFcfcUGlTE0Y4/HVJgJ2kDH/wA9Pq959cluyMmN4m6NVkJHIY1SRpMSC1JBs1AtzYaRJbwzooUYc2d4zAHJHrDClsLJM4SdbyA0HDml7BK4JLYTC2y2PkHyXjPt+9Sm79QDe0gp47VY3fEovVsx6Ezj0Drkah6GdAZZGIhf79oljH7WP+akxTa99YvNyveSh6ZmPBIOPACPaFlapmOV0cojyb0U6j3yk3WWmotJ1nG7XK1BxxZdRd9Xo7jswMs3rnDRe/iGrYeK55L/8skatW6AhuN1dOkX5Ge0RT8SljoNb2ffFzV2g9SZrpD8ByDRiwL89VDucAnAfyhNZVnucUaOjJjA/X37+YY4sx9x0rpZ0TOOKHLRc9cOfvc73L4li5Sg3KeWL47EIwJCj6rnFh/NUaaDGWjl6FT0TWJCeHkihktLwd+/aOaoq/qPd6f0EiRtZeMiBW2Z6Jmzr6UMuxRzDxoCeg5LCoT0jVn99jLeKRvLozqWazV/Gpd8+CwfC7hEz1JSZ0/KY+eXZ2wLIELltPQLqPl791Wd2SUnNdZh/xsR797KHX8/+43aiF/0OSoBPLOV2Nv3Lexy6hQa/+xQMIolib/4Kc2lSRKrnCkEU
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(23010399003)(56012099006)(22082099003)(18002099003)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	N/O4SVHLrzzZFHXN6gXhLHAyv5uK84q//TjoG6Zfu0rEQFxR6wTYwuwhNO//478CQUIGBwExVRiRdPgsYf3BH4ZYQSoakfujYPGThy4W10gkANiO5ti+OjFXM7drsT5HX67aa14bYY0WJrXzT7Fh4wQWJrkF+okPA4z+U4IsrVsM3Yfd2tfStC65LtB6w139EEnnXOWF4fxP/NDDgwbduRVmVTs4AD3tQry5kDZDCyYi2vo2QndXacMFKDqa1GBIZImv8DHP00a7hUnrBGu9jz2iBlE13jMDBpzbdpkYvaKzW/vWodo/Cznj70hS9wd0ZROj6KpAtBIIhLSQV15GtneiXeY0QNonfQ0LdcYOtxcpeFwqGKBHdac1JlTWb8+s4Ch0NARD6EyTe0AUqGiS2R0F556V/OZlL7rp2zu88Y4NR6M25H5JkglE7VQVP6OC
X-Exchange-RoutingPolicyChecked:
	Nbqa3poZdiiZI5/A230u2vSOuo616jKF7BWVLD7pbx9HVMpEm/LrE0DJKeCJqOzgzpMcHdIBEMpFoSAwMmiris7LSUdS5fNFsnST89nsEw2Y0kdO3gjH/8TTALSwNCs99zBYBYMekrpucXiF+3mOoKCIQyyFTl9pyptiDylR1MNI5zXGswc0lc48IjqkrPb+fKBjqGDZwaDU8WtXKF1Guu5/HWrKRDcU4qoJx6EvCd/7+YfldXwabn6qEG+aMRnhk8LWJRymPVpppGMpLy5KrqFLn2fcyp4rPCAFMYKQZqJpLOxnb4bPQMHCn1YNWMfRA9HR5PR6mBnsiKr+Wmuhyg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 18:52:07.0383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3842ffe6-634f-4b70-e266-08dee4348015
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8148
X-Proofpoint-GUID: rx4R1AeMRGiCRvBdcFTyzUk4wQ0WuOdN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfXxvCNY6DfQQrI
 lvI6MDBKxnNt4vpOkEuCFPdeAFZA0XKsAFSFkjecZ+O87b5mM4XVaI6cMKNl4JN1rH+S+8yedZ6
 dFYwHqbk7iPQiaNHYWB7VUaMbW04i6skCleYtjBq3AK1pemzrEHoQReoRYlEgMdbQbaQISel7ts
 8HRUs/WdNrbRmQ0Ywdnyptn/ZqME/XpXhxzxQi0XsqoBnabnTGY4DEnYNRqkglcuTGxXqYVwCw3
 pZKt1cMiIIGqWLP6/dSrYO1SdVqEcenRijtBC+a+7h+IF3Y+2Nn58sySHe+mPv98X37SYDl1LkZ
 igJgFHUZ8lwUcvt6F5/Pon4njbio0x/UXRr64TbSpcp9lNzZ6QKbOdyiyaC3QMYzEwwEZY1tmuG
 Z0W/Dvmrx8/LGb9KtAyj/pS3EZ0HdZItzHOktQrz3hiU22+BwDfx+e6BfHszgzfNcSL0HBnaJZ6
 1gUMw/2PF2+Kw9H77Bw==
X-Authority-Analysis: v=2.4 cv=GJ841ONK c=1 sm=1 tr=0 ts=6a5a79dc cx=c_pps
 a=sh1HRyDNv5RGx04/W1QObA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8 a=2vpyfyhlguDYHLkT4YcA:9
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: rx4R1AeMRGiCRvBdcFTyzUk4wQ0WuOdN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfX6q30SVopgJsI
 h63ZSZIMGENUBG+0kb3Uxq0KdudiRycvlc/0DRDeX3wV9aYSgHw7pmJNZk0hEJTdl1NTHe7Q9/p
 1CoIxT110cuuccF3dgLikjJrqL0DsTg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170192

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

