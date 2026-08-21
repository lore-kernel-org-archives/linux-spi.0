Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B87547FAE0;
	Fri, 21 Aug 2026 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787313014; cv=fail; b=d6pRtkZMefUPvhXTQ55nmpvHiz0iKYRqFsu9WD+s+MiHHevhnKewmFzD5QbWTBHCRgY1vbwKufYTGvzft7C+kcfegKBxNVmC5szfe8CFUAZ6RW6q+6wlQj5xDDhbDKlKad1DGhsMNU45fFrQkbr3qV+NxMa7L/w0VH6+n6MQhPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787313014; c=relaxed/simple;
	bh=WKVXHJB0AdeEulQEB73WpP8Du4kcQpGopGcbjSG6Kf0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G933y55uuv9dTWkkmA97o40T7jPdBulltdhFcK+WgfJpNF99J0MZRyJrDJZxnU7GvKV0WIXyUq4Yg7wPLjvoRY9i9d1gG3lXQwUbZGXLFY77HjdmNmRlsLvHZCJhJLJa4+jHEWy2rnuzTbEU9TG8p+uPfLiaBL0YBCZww/IdrAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=iqGlpFRD; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rh1kH8cB; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="iqGlpFRD";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rh1kH8cB"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67L9KN2W3254934;
	Fri, 21 Aug 2026 06:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=+X4OnFKe7SEw4gZmEqh997XautkroE44X9Vjvdyek
	nY=; b=iqGlpFRDaPysHv4E72i9fuTITfa4VtOuwQN8drNwLOVPsuhgpf5OUdU19
	1Zc0YFDQyxPXsLjqmKDTIPguoZRoWPl3IbsvI0g/Ea2EnHswQrO9e+kFTj6ojGiP
	xLhM98V71mBSg4n85ix5zkPRTksW6ms8mZWoY1qrk9vtLx2Xq4Gw380dEd3lmhJz
	603exmG7dfViYChgDMbPOVjvJM1ZJUGEDa/RGIpY5zJmphGpWKEOM7CjC9ykaIO1
	88dj4cngZxV5epEJesYwvFRSGPDEi3aAUTxTKk3JV0R6YndY2F6VdrkdU+8nhgxx
	r9QwxiAdcVQ4nbwAD2rFjMItvCq9g==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012022.outbound.protection.outlook.com [40.107.209.22])
	by m0380145.ppops.net (PPS) with ESMTPS id 4g6hfk1dfv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 06:49:51 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3zz3U6UmM8n1SQ9sb8zZ4tjTxTvLeeyFdvXyptKgc2v4dbd604BPxZHVucr9nvwd2Sk8IrAJjYQFgc22UllS6TKnNq9JNlWiWFkOfFjWq7F0U1chI3J6QliDfFhuDP/qiq8tGStahNB7Z0qfKhb1waD+1T/y47E5pnXOnOJqnPIaijDV2v9i4rEm+9G7eta7aCC+K+cvNqneYwryoyXBYtUHEgu1q1bdEnXq3soDQAsUXp284o9JaxUhf65LPuwbAf5QjOV3kK7mh8GYuiL+oCnrfg2Gki2xsbzRiSZrwTOuYqSYqZrefHiD41aGJERljem5Hw2Wi9qlfTsm5MagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+X4OnFKe7SEw4gZmEqh997XautkroE44X9VjvdyeknY=;
 b=PUxSFosNOXKN0/Dd6vA4oYs7fau5lCzGUvA3NlPzalxyLurcr3LUFcx+zXcoOrdhFFLp2lqRIirsBeghhOlOgrYgQcJ7O/3NjWXqji3PwGHKnC4DgjQYgizcmtNwqAmjt467VAr2tjgwyi/6cXZzPjewl1mhi54FLCqwuM8T8k9SjbceX1QnHGNTizysSaHlJ9Ox0pEqZ3BcC+o2miWsM5e+ylxkEqk7qhlmWsaksh/y9BRoLXhfc+YEqQ7TyFTT5PGiz0IsejYFRlTLVtRfZl1XB+uXyTxXtuBQhuWE0D6BN0mH5RD9ovcDPhL9MX2UJGha8QZjgguhq8J1rYTXlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+X4OnFKe7SEw4gZmEqh997XautkroE44X9VjvdyeknY=;
 b=rh1kH8cBml5zIQo4EG+m5iuBQYi43irI8HM5GBasq5SmgCNezWsxY16JgbL7d/xbIee2jAgmpHKSopScGerznosb/elHrEeLH2svdole7bahSlfaLGJgsD86IprDVV0EjNKVg0TkPxkk+B9VAIZypKHlebl3vva/MftNadtyjWU=
Received: from SJ0PR03CA0143.namprd03.prod.outlook.com (2603:10b6:a03:33c::28)
 by CC6PR10MB411082.namprd10.prod.outlook.com (2603:10b6:170:200::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:49:49 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:33c:cafe::15) by SJ0PR03CA0143.outlook.office365.com
 (2603:10b6:a03:33c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Fri,
 21 Aug 2026 11:49:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 11:49:48 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:49:48 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 06:49:48 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 06:49:48 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67LBmVlo2022942;
	Fri, 21 Aug 2026 06:49:43 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v8 13/18] spi: cadence-quadspi: reprogram CS timing on every chip-select switch
Date: Fri, 21 Aug 2026 17:18:17 +0530
Message-ID: <20260821114822.4040338-14-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260821114822.4040338-1-s-k6@ti.com>
References: <20260821114822.4040338-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|CC6PR10MB411082:EE_
X-MS-Office365-Filtering-Correlation-Id: 13d571da-9e95-41f4-5ec3-08deff7a4dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|82310400026|7416014|376014|921020|22082099003|18002099003|3023799007|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ePbkB/3l05np7cf5b2baKOUUUsRN9JSBIyVo0U6vDRV2NBs1hI09F94pRbH93koAsxJrR9x1aKZZpvDtCXuPGa2eub6N/02Iek871CnWimFeh9Efcd094DUGGHqhLBj27h8AhK5xplEc1d2S3cYOzBEK5HCqc77MDUNkVdBTEM1aIT01DC7zRSp71AhzLhi4e+0hpblUYe2KceqVqcQohff4HqjzSD4ubloqK42a9PRgu43Lh48FB9M5PUMhYDJDJ9aHZ0Yf1zmGfXEM9sv5kWu8IuOmxhrtc4VtVy6AP3J4bUy0/s+7MB2XpoZyqPZ08Im08qTCibl2M/ffmOMW5k/mb3Y21Fx/hp3yLytd6Rg4NG5J94GvBESwb1ph8A4v7i/g18XWV253fHTgcsT9g1Wp7Zi1eWbgL7F2yMnSzt/StZTB4DylMXVGZy2wa0doWfNjhF5gH/+/BdBMJaKXjHWLgOSlLSrgAJhuNPGMRvEyLChViG6O32VtlpP2cPgWvu6VjazTy7BodbLTlwWhOeG43AU6I25Jw8RNmBTUQgn8KaWaZvSrtNo+hRskIXCfWHXYPewMh+P7VGa73leTBlA0VDjXn/vnvlrnhMqO/qvHXU/2rXwVXEA/HZqoQxVkdweGlk5kAgoUYAHu+0shqWMYialkhCb7+pPvFFjyXwDgJ17FHwAaEVit8O/5aAiyoPJCaZ+uzS56U2B244VaSp3hItrBrDbnhz+y9J2+WC2wKwX+7z7xV8qAKKyCA1Xe
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(7416014)(376014)(921020)(22082099003)(18002099003)(3023799007)(56012099006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oq8NW/RRNd85996MR7T9y7HtXOPccyl21g6vOcm6T+/o7VXTVd6CnoxUp/S0x4MnUqrFLZIRlHYKS7J0I0QW0OQ40PyfxL0MOuPzGxQq7xM8KpvCyeN7mSeWUZrvX62D6LqFtlPGPJs/O0i+SchcxxedadxNyfcoCnjfLNqzTiLE3JAMKxbgUj6rJlGRgneR8R1fa4BYL4K3Hu95WsIaYq+ezH6mYa0OnL0WlMysvQsI/VHsOKSc7SuiIe5hF37ExW7ZQ2Tlb51+l9LM4/2uv6Ba9g5gT8TNl5jaGkJkOf5vNZk6xjPLR8IkA2AFvbAfFeJfh//aBsXlCeMFQWf9gXcNHTvwLiYiQwXzLkw3GDFN2RXZ3+rNzCiRBW2UHs6P9JMCxGb/O0dh/Iw7H2hTbqOAS6uPHtJPXUc59SjdOhikKlD9GnPMgYzQKYREBC5U
X-Exchange-RoutingPolicyChecked:
	tNd/I5HavheVm+hqkh0ey90DNv06lEk+m3K36+j0SJSZiuIM6iF1cJBnWGFC2mDeD90Tdevf/TaLJeNmISMU//+RuFbw01j9YEgbN3afrZTcq2gHzud5RQqvfhcP+qh+c9wHEQZ48iiohpGkD7hWe8RioGJR7Y9zyZJSu+A6lgXHVjywmxiNd4R02sKlF7mRzyk6SnbeHEvb7S59kJ2Orm6kFbhBlYyYCkNQ3tIJQSdR8siO75qM+gdKsx0P8bynkX4kACH+sl1rGhSpKdV6DHrdqBMNamBAFb/Um+XbXAtHd81d1+CiSlPQJt/N19/ZgTqNGiaeLykxDQiGmEAI0w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:49:48.7610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d571da-9e95-41f4-5ec3-08deff7a4dc2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CC6PR10MB411082
X-Authority-Analysis: v=2.4 cv=O7AJeh9W c=1 sm=1 tr=0 ts=6a883b60 cx=c_pps
 a=LdSsacNKwWtvIYfRw5AjOg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=okWzP3EbMLmikBYkquQA:9
X-Proofpoint-ORIG-GUID: KHn_u0ca5Kz4pUuu9ab7nqHFEaTd3_8D
X-Proofpoint-GUID: KHn_u0ca5Kz4pUuu9ab7nqHFEaTd3_8D
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfXxny1Ar7kc3+g
 QoZdrSRaxW6NXjUbLPKqu+hGawC42a8hldU4hQZkcuYj35BI76JGKYJe/siTwAsY5YxhJEEbywt
 m5VELE85TX5o6Pl4v6AzC3nEDt66CTA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5MCBTYWx0ZWRfX3xAOVks8RWeN
 jU4Q4TLlruIXGueQMqZ3caK7OJByr1DiR4Dt9mhgdxRZCUx8wJE8pLAP6DGSAc/dZrVmJFTsVBa
 aOAxZnXxu8wBiC6QlMhI6F0n+K4jnJjB8DZiu/CkS638L4mKh7b8Ic7zUaYo8KmmQqHvrF7k/Zk
 bS7GKohtST0RXLWTIAsNZXYDQiBpqhl7MjXtzhc7S8tTvkAKJcoacQOzxMe2NpEvmdDggBXqc5F
 k4/BoGrMH0Z8AOGn+wBZqM3fAcbE/sOFOrhonYElvKCS+gPFJe8vGtZNI2PUwh1Yn9aa/RGBMRx
 +NZ67sJs/H0+AeiTpKdk5Dme8M3/uIxcZSfUVi1S10N4RNLdSCA5NFakq9l5sWVlQxhEfs2Ossr
 8909qzJU3dQMYXbJgFa01ZBOwOSWKowX9XW1g8QIQQCawaISnwwMgWn2SH40Uy02QPN5MdU291S
 WogGWeUunXb0VISqz9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210090

cqspi_configure() only reprogrammed per-device CS timing (CQSPI_REG_DELAY)
and the non-PHY read-capture register when the clock frequency changed, not
when the chip-select changed. In a multi-device setup where both devices
operate at the same frequency, a CS switch leaves the previous device's
timing parameters in hardware.

Split the update condition: baud rate divisor is updated on clock change
only (it is frequency-derived), but the per-device delay and read-capture
registers are now updated on any CS or clock switch.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 940cfb72b946..d4181b501d8d 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1602,10 +1602,19 @@ static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 		cqspi_chipselect(f_pdata);
 	}
 
-	/* Setup baudrate divisor and delays */
+	/* Update baudrate only on clock change. */
 	if (switch_ck) {
 		cqspi->sclk = sclk;
 		cqspi_config_baudrate_div(cqspi);
+	}
+
+	/*
+	 * Reprogram per-device CS timing and non-PHY read capture on any
+	 * chip-select or clock switch. Without this, two devices at the same
+	 * frequency would each see the other's timing parameters after a CS
+	 * switch, since the lazy clock-only check would never trigger.
+	 */
+	if (switch_cs || switch_ck) {
 		cqspi_delay(f_pdata);
 		if (!cqspi->phy_tuning_active)
 			cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
-- 
2.34.1

