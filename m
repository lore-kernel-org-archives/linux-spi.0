Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6183D6479;
	Thu, 18 Jun 2026 07:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768363; cv=fail; b=chZMX0Ct7L4s6CmI6LhbwPpkzWc9H4BJjBroadxEy8+7PmkyaRPYfTSfXS5ZKIQWoImao/KpzE2of6k6DcGSXKgDXPerMkasXQXN9Jw2LZtH5pUxzIIXPsgzY9yzbHxfDjw4KoVEFxpYObEvpRV4q5VwXQDQrrlicVIdIFkQ118=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768363; c=relaxed/simple;
	bh=SFy56xr8X3A5c0K9TRUzjbxLxfG6dwgBA5mPXymSw+E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sF7sNutAqRmqELYTUW6U7sPAqy8JjBQsbaQ+0gsYS5RajxRfQ2TzNkU2O2HRlCKWUWCD2rtxa+cQNdejQd4zlJx87pdl2mv0EXPFmDHmhye5KQt6CHtvIqqb2PmDa9s9yoOQu2FxzCGxbDmgRJK+wO4X6g6LYAHjBE96KN6QWv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=CICJGCSu; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FY1RJmhM; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="CICJGCSu";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FY1RJmhM"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I6VtEl3436102;
	Thu, 18 Jun 2026 02:39:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=JS4NTtIv1+BmR/53INOlP8U0bUMW8tU2EKG0i0H2N
	KQ=; b=CICJGCSua8woNAGSvAzhG7i4Gj1IobqBRWmYzsIg08HselD7HxfVhrFxZ
	T27zQYaifuW6bGpRw2/edqqlakz3ewZZQReyXYgzI3AIDImQKP8CZ8sYGoCHt0jm
	AdI9KRUwoTyIEZamXKSiHUHKyDYuUq7cLOoZ1KpzAuqDxILoiZ6egA3r2QwsjHzk
	eJSbQHzVw+aSsskoMQUnMiIELFCPcvRVFvdnqZxP3B2072mBSutrVIXCsjx95adl
	Zj7EOLk6MV3VmaG799euTl9NpqZgH5fyQsVRq9jVYb4qx9ynaaqOKQJolHGgiyYA
	mK7kWY1rhnhC4J4cefE3esPU/f2LQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ev63rj15k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 02:39:12 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLwK/CRoMuBjDOHIfQy/hnm2l5o6cP0orFmSXUFIDbxiCdSxrNVKu9BT+saJTR6sHe8Ti+/+Usf2Cb/uam9BPbFt6nlBxbHI5jerx1Bxpa8ZFlURtF2mb5OKKQKeEbJXDF/FCmbuK87HcGMeJsCEt4HxLhhrywCeBJaYWOa6nyGMkaTb4dgbPgH2xd6qqPXnKB1R16wKN05eWQeDRUKMy5q83SBA14zD/EodwHQ7cJtRkPF6JoAzTaP+BTToVBlypLqJSv5ZLspH8QmjMEe9AiY4fNu43nG4f+XpkEFV8aA31VULkPPgCq9Zqrc4kuQl9PrvsG0HVN/lE84V5nM38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JS4NTtIv1+BmR/53INOlP8U0bUMW8tU2EKG0i0H2NKQ=;
 b=fj/47AcIFBmcJCcZzn9R0nQ8w0JTBlSq5j6433bCazYme9IqKw9bWBTIaNbI1hXJFxSqyhuTL9f4aRMnc55Tbcrzr2Kg6coQSZOynf3Uww+iJ7wCv3arOsl6PEY+vePkwOJ3+/Yxoc8VRrZejimdPkk9kZdxxk3CitRWow1jHJE6CeglEF6XTx5n+AWI1ii+DYG1wRkJcaqgZESW/FDi8Ojj05T4alJIhc0yYC/4ybpW4G83SzraK8E4OjKHgDBp8mQOV42BuqRd9lGuXP+CMDhJmsLYihkK8PoUYiAT5qhmyRoHCLGsHdl29OzaQzr6ouWDrJyn/tP9zF2KiWcnbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JS4NTtIv1+BmR/53INOlP8U0bUMW8tU2EKG0i0H2NKQ=;
 b=FY1RJmhMUEub35SnEGDnfp9rhPyx99YE/6Sw/2ZKaiLE4Vazly/zchkFD5CRbLVXWVw9lfFaEtwLjRd2qzV+k/MbNaIlHf948GOtvFeRdaw3VfDgagpMMl8N4Xkms/yjrV7XKYgbOe0uK+qVWt8KWlQsQslx3RfaYbuS9f2UkiE=
Received: from SJ0PR03CA0223.namprd03.prod.outlook.com (2603:10b6:a03:39f::18)
 by CHAPR10MB997722.namprd10.prod.outlook.com (2603:10b6:610:2f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 07:39:08 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:39f::4) by SJ0PR03CA0223.outlook.office365.com
 (2603:10b6:a03:39f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Thu,
 18 Jun 2026 07:39:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 07:39:06 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:38:42 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:38:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 18 Jun 2026 02:38:41 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65I7bYvn3521710;
	Thu, 18 Jun 2026 02:38:37 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v4 12/16] spi: cadence-quadspi: enable PHY for indirect writes
Date: Thu, 18 Jun 2026 13:07:21 +0530
Message-ID: <20260618073725.84733-13-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|CHAPR10MB997722:EE_
X-MS-Office365-Filtering-Correlation-Id: 49952809-37a6-48de-908f-08decd0cad77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|23010399003|1800799024|921020|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	O8GTEzHE0DAEOT+7Mioip/VUGIzH1PvA07P+T0JJe2Iz976e9xCzaR2q3gCrt72RzexXxL29JxCbMyj7XcOzbE4zWCjpbcOQ5V48tlykSbvpb+5Y/fvxzi7wiWswFaYj6FHUPxwzjB+Sh5AkchNURkkN0Eh4YvkIsGZJHlbhATnuvfdSzNry0Hn+fEXxq9xVcDWM3C0sbceui6YwedEgfTyaPvc3IcW3EJH+TA7WvPs1BbS4VzD15SNxvfPNFffQNq+ltF9vU//vj3o5E2N9JipFVCstR6WsUyvODwNW96MEY/bzu0V9UldRQW7FMdBNg4bKmuPG5Q5JQrzNmBvyUsKQlS3uIQiGiwpv7spmMVcB3i6iBzaL5R4qzO3OxxVo2ReDD4Xx7LzEFR7+cQcUshdFRtN9Z+qCdkvnEcaCAznPMHRtAor/9dr9hQ+dBtr74T/7pVchdgtuePqF9AzLAP34fdsvgqZ7Ibb3SHOuo2W1jynXYWXUW0oMmbYV8vyzkSLIa6cDBXjBKJN10IATCrvoq9SefFGGKhwJXrUjnztfX07stk3g5rhWYPmIjIu/hmY7FQCAOsvYa8841ARESU1rPh/DCeTbHaPDBhtPXyvjjh3rtvpiMGpCDkOGlWcXUUBacD6/YMvAeLqVsD3N87GpLcTVOmfDh0QTw9OiLHVC/ojaPqOba9OMQ9Oai3QXZO1KG1Ve4byEFCMUgFtdzDyEkFiSW+rexDKYbMw1LcCL+v1aBL8mkdDs5/6v5VL9x682yelJUg8hsmKIN43CNg==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(23010399003)(1800799024)(921020)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YLQiXD7I80ASjoEMQF5bNl1lqLFe7UZpx5edSUX8WsIcGFmwk0/QNRHNNutRL+2oTe+tvBPketBKJOZw+KT3LMOP8eSoWOKhc6W/sOaPq6aEM7yfaiYpEnS1theGNaiJEPTNqVUwdykKhwymF58nCgwpLj++0Ss1gnGUhP6psvyNEL9/rFYMZTop9+zJoV0jd24Cccd694MjzLFlUGVYEg6/jU4QpDngO3HKmKq7IGGN1QA/Xvf3hGx8W2ZLrdC3CRneEr4Gv+PKzq1To5LofkZVr8X6+sFLGOX/Hgs3z50lIyekS2s9slakwKVS/KlbsRUms4hF2046kXGDchIpR/H8zTS/Q8AqEKdLXllhaWzZ6S5GfBDFx6/YmRgFCQUxn+mFY5d8n6Mh0m5ZEdJ+/rcVDfanWoqfZmsPwvZPpOyCAVlRmmGmGRLatj6isTAN
X-Exchange-RoutingPolicyChecked:
	hUhEtuECp9UdRdBZc0yxXrzYYTERhYAhBpp6ZuSAapgslAON+b4DwjRLCPFnRu261CWwWXrF/3F8PKYmizYL7xUW9dCTNrbC57OZVfn1vAB64v6nUIcETEG2S/o33dQLTNWxBLmDvPpPkhpy0ySA1Ki3zImqi1lIS+c34dq/gRsx8b6FHtKVQ8Y6TyEbmPluNiikjGKRORiyrcWigioBvkYHuHEpsvHqKP2zrp7JKVoKorTSlGyXMQjhtCepYrcy+NFpLAZhdh3ejZ4C+P87UMTXmeWXeacMt4RpyGKiVbTrXXLwhiaRVS8w24ZxIWoRgLOYNpepQggUWt4+qWfhfQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:39:06.5473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49952809-37a6-48de-908f-08decd0cad77
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR10MB997722
X-Authority-Analysis: v=2.4 cv=LpqiDHdc c=1 sm=1 tr=0 ts=6a33a0a0 cx=c_pps
 a=Qv0FdJiMAyQkWbHkl99ofg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=-A2lziRS1w5XIjWNnAEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA2OSBTYWx0ZWRfX/RIj5tigelQk
 MyWLNK5JORxODzk7gW879C3ZiSp3Bnzg54a9EQz1VZDwkyKj5DGPN/hAN9Ko1rGSgQ1NdAzdUPb
 cnwrqO7UWT7MaTSd1zQLDaShnG7svTM6MsLmcjRwzPM+fS2r9B/Wf9JAoMokTMAjOKP/00O3mEz
 LzbE/gzwB9flop03uLjvnqGRuhe1IJJxlocj27P4jxpDz1w5sksXzotlBwykte901hNBbIvU8hp
 H3nM16D2v+AVomv7SqFQwTx5l4jmc0aV3eoHkUE86WGp1LzJUgyPZk9gSxEJd9oBx13Os4Sfjx0
 71Zo4nCbrV/pq/njYxEwAUAWM6uqgqNV4JICxfgDYp9BEsLJhmdaZYlAx/T6/i4EyLTsjz97SuM
 k//9BR9R0gPEpW7AfEMUUhlSv1rYHsMBhU9mgOCxNKeMGrdUr0deByBgWZsSIcozuoinRAm7t5o
 ktFR9DZfvC24gDxhbJQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA2OSBTYWx0ZWRfX4mJ4ViQ8Cndi
 nNnXTV0P9A6EfEZFYOMaTBF8P28EME1DOWN9x+ydtsPvSjNEVfgXc4VxOBwnG/8sLz5y8NNEAl/
 Z8gjRIDJbbw0BQmJ8gnTdui0sdJP96c=
X-Proofpoint-GUID: khwwr9m3-Dem76JktHeaeggYe9IFacrH
X-Proofpoint-ORIG-GUID: khwwr9m3-Dem76JktHeaeggYe9IFacrH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180069

Enable PHY for indirect writes of at least CQSPI_PHY_MIN_INDIRECT_WRITE_LEN
bytes. PHY is activated only when tuning completed successfully and the
write op runs at the calibrated post-config frequency, matching the same
frequency guard used by the read path.

Thread max_speed_hz from cqspi_mem_process() through cqspi_write() into
cqspi_indirect_write_execute() for the frequency check.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 32 +++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 16e3b843f0aa..df7fcdf404a6 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -151,6 +151,8 @@ struct cqspi_driver_platdata {
 #define CQSPI_DLL_TIMEOUT_US			300
 /* Minimum transfer length to use DMA for direct reads */
 #define CQSPI_PHY_MIN_DIRECT_READ_LEN		17
+/* Minimum indirect write length to amortize PHY enable/disable overhead */
+#define CQSPI_PHY_MIN_INDIRECT_WRITE_LEN	SZ_1K
 
 /* Runtime_pm autosuspend delay */
 #define CQSPI_AUTOSUSPEND_TIMEOUT		2000
@@ -1240,13 +1242,15 @@ static int cqspi_write_setup(struct cqspi_flash_pdata *f_pdata,
 
 static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 					loff_t to_addr, const u8 *txbuf,
-					const size_t n_tx)
+					const size_t n_tx,
+					u32 post_config_max_speed_hz)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	struct device *dev = &cqspi->pdev->dev;
 	void __iomem *reg_base = cqspi->iobase;
 	unsigned int remaining = n_tx;
 	unsigned int write_bytes;
+	bool use_tuned_phy_write;
 	int ret;
 
 	if (!refcount_read(&cqspi->refcount))
@@ -1282,6 +1286,18 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	if (cqspi->apb_ahb_hazard)
 		readl(reg_base + CQSPI_REG_INDIRECTWR);
 
+	/* Use PHY only for large writes at the calibrated rate */
+	use_tuned_phy_write = n_tx >= CQSPI_PHY_MIN_INDIRECT_WRITE_LEN &&
+			      f_pdata->use_tuned_phy &&
+			      f_pdata->phy_write_op.max_freq ==
+				      post_config_max_speed_hz;
+
+	if (use_tuned_phy_write) {
+		ret = cqspi_tune_phy(f_pdata, true);
+		if (ret)
+			goto failwr;
+	}
+
 	while (remaining > 0) {
 		size_t write_words, mod_bytes;
 
@@ -1330,9 +1346,15 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 
 	cqspi_wait_idle(cqspi);
 
+	if (use_tuned_phy_write)
+		cqspi_tune_phy(f_pdata, false);
+
 	return 0;
 
 failwr:
+	if (use_tuned_phy_write)
+		cqspi_tune_phy(f_pdata, false);
+
 	/* Disable interrupt. */
 	writel(0, reg_base + CQSPI_REG_IRQMASK);
 
@@ -1467,7 +1489,8 @@ static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 }
 
 static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
-			   const struct spi_mem_op *op)
+			   const struct spi_mem_op *op,
+			   u32 post_config_max_speed_hz)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	loff_t to = op->addr.val;
@@ -1494,7 +1517,8 @@ static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
 		return cqspi_wait_idle(cqspi);
 	}
 
-	return cqspi_indirect_write_execute(f_pdata, to, buf, len);
+	return cqspi_indirect_write_execute(f_pdata, to, buf, len,
+					    post_config_max_speed_hz);
 }
 
 static bool cqspi_use_tuned_phy(struct cqspi_flash_pdata *f_pdata,
@@ -1710,7 +1734,7 @@ static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (!op->addr.nbytes || !op->data.buf.out)
 		return cqspi_command_write(f_pdata, op);
 
-	return cqspi_write(f_pdata, op);
+	return cqspi_write(f_pdata, op, mem->spi->post_config_max_speed_hz);
 }
 
 static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
-- 
2.34.1

