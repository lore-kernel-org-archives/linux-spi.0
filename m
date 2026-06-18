Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F047D1A9FBC;
	Thu, 18 Jun 2026 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768326; cv=fail; b=k9J1osPUwQ0habjW+1HG8I5oH5FJWWmCnRx+lJDb8J0NrxaCDu5HTQCRws6nerC6jzgsA+bS+LWp1FOjtNtDxx1cbOGqnX6dWVQ4hXPnBcm8aXNBRmSg5OI+4mG6NmqMfqZywytpeSQ0ByZDlsvRalfmfWy0ZVgMxZspToE9zMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768326; c=relaxed/simple;
	bh=SPXUbum80aBQXY+3i3Pecu7ySp4hADkjyHw+4bh7V78=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eVSkphRpA3iPaee81p4dkvyLgTMXGa25tDn29kA811ijiFtOwMg/SWml4QY6F370u2VTWubflSet2noBCejzfiCizWfvkKbkloXafifdciVZE7Q08ksMECDeqRVkE0kUqBFohendsFiYwfmzyhau/flp7TO7pFMzpS75uE/mLEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=I93UvRcU; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lvTWDSn6; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="I93UvRcU";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lvTWDSn6"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65I7AhTJ2383685;
	Thu, 18 Jun 2026 02:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=0ivWwogJkYOorimiUnRp2KrXCkZKHDm/wzRVhkB6p
	3s=; b=I93UvRcUk4OaSA08D+8GR1oyo3wG49e5h2V/uDc5XJOp5eKCORel9R2QD
	EQ6HbYPm8iEycsk8Xgoxec65vRGRWVkazONg/ErCHgV/NA+YvZnW6IDPcCjGVffS
	vnsNWS53dmYSqMIsJ2kReFyzmBE7zQg/tUrH83crnsMYOKipg/9C7bxIq8rdhLOg
	QEaX6gjIcEnphuP/gtSvjxecnEv9e4noEOstsGOrUF4D6JxK07wTyfrp0NulBVWr
	iJNYBaSPAJbYI6FaqZ5FwYJMp4SIgnOuzjhl6wrTl6XZ5C2yIkqg5L4C8CHDdwxj
	hgOFp9X6roUOtdSi8+niC6nQWqX1A==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012052.outbound.protection.outlook.com [52.101.48.52])
	by m0380145.ppops.net (PPS) with ESMTPS id 4euthp6s43-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 02:38:35 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFUwxS+AVuxKoqW35wMT9Bj8su8eVIKoZI8Bk3jjBpSlMC4A/gLpl0hjpLamBApKuZdsNaYbfI6k63DWgojDggHfEW5Sm7+XoSji4mt6p0M8JdrBCFTD0AM1D1aRnXJ2enRZd2wrI7LLc3ZRfiE+OBiGKdFy5/lZDVnLYmiZpDFMfiLqRUDIwr2a9X3Zv4RXPNWbv97prPbrGSQ2dUAZl5NR2UacJ+j/nu25KbcPU3yVjBt/4G3PJzzogZqRow6ksOiQSgWHr/6kfgNIpfHcHkrKAFTI/SvW3NrC0le2t4gE58cjoLczesr+4Tm0y+xpBJZFf3e3uR8PxSY1mh/fXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ivWwogJkYOorimiUnRp2KrXCkZKHDm/wzRVhkB6p3s=;
 b=VllwveDgHTYsq2gKQet+RVixo0MxJb2kF8hR+Y0fCkIYGQ25R36nqEWhh/pd+zuDmFQglFyyGEescQiEHTDJ0x3p2vLZKnCAfMhNPfLqeEAGAq/cyZf2tmyPeNatbRqD9VuSFw9VjkGvMpX9SDN2+0I5Ws24oJDb9+yLzihJuMSRiGjcDy8spT2bMoxQrSEgA3pSGFpXb4mB903XELCQDSk43/Ou3ZZ3ekM1jiMhd8GiTA0K5SdKM5KMh7G47iXfdq3Cl8cu6VO3sXUDDbYZzXVvHISCrv89IFufNmLiz/m/UOA1kbb5yCS3Ln13gMOCe55MhaIRpx4NtTDwp7BNyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ivWwogJkYOorimiUnRp2KrXCkZKHDm/wzRVhkB6p3s=;
 b=lvTWDSn6ovDuqzH27KZ6PloZ7lIa04Ih8GtOj9RxhnBBMJ28tVHIssFRkPP6T15jf8egbQfLBVwoK5redhRfCG5GnccH2+WGv7EdBinf6Okg6wjsE+ZI9G3FxeR7D539NNJbT731+N9XPpvVETxgLc1GLTWpCjuVwTtJdTc3KaU=
Received: from SJ0PR03CA0223.namprd03.prod.outlook.com (2603:10b6:a03:39f::18)
 by SJ2PR10MB7057.namprd10.prod.outlook.com (2603:10b6:a03:4c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 07:38:32 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::38) by SJ0PR03CA0223.outlook.office365.com
 (2603:10b6:a03:39f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Thu,
 18 Jun 2026 07:38:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 07:38:31 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:38:06 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:38:05 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 18 Jun 2026 02:38:05 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65I7bYvg3521710;
	Thu, 18 Jun 2026 02:38:01 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v4 05/16] spi: spi-mem: add execute_tuning callback and spi_mem_execute_tuning()
Date: Thu, 18 Jun 2026 13:07:14 +0530
Message-ID: <20260618073725.84733-6-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|SJ2PR10MB7057:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2247f2-8292-4cfa-fdc3-08decd0c9851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|7416014|376014|921020|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	DKT8Okzy/DimRwCOT4B1X89V/mz/pUK7+lBUCe7x55K5c6jLdSBjvTacR6+++hTTQw+ATiGq7/OHPZ+H5GubOfYsUhG3HufVI773hxQis+cFegT8fmOaxa01hj/rlG+jLQUafi4Wp4XlET+2ikOxKlWrO3zUxaFfxzzjwsmR0Gl/g9mi3K13g4U1bICCXgGdIyWeJnuhhgB59DHntTsgn0uSaq2jVXzwbnKOR/Qfki26jznrQLDJqfTzf4rpjt8K3C/KMKXZj2UI+gdUXOAjPERKrlnD9Yom221keIOYdSkbke5KCS8cKKuLokg86DvwTlekk2qnsWhWxRGRsHwMcpH1pyF3SdbKzFohz+Nj5PTyunGhR2r+ygbypG6jWnaUNIcclJsH427/anGnS9pGU3m5eO7CqgdZdC/Q/zqI+tJgyle2KrzKbSJmbPDQGCI6DQTJ2hxfP8xopYTAUezoMzZqWpesJqZQyJxzYcnemqKFVAvmzY13Y5ObWgK98UMzSjmQMgExKg6yMcQC5teTdYhSiK9b9yViKc1xbxjNcOTEBxUSxVOKRcbbeLFWyEbCqsWrtEuP050myaSE3qaBzbIUOz1eVpqm22lZ07Q6ZWhq5IyrOitOd557UsdYb4+EFC3xqUNUVBubfNO6cEJhHlJ+FnchXsSmdJKCy44BOCN8kBOEaXubVGRsOIP6vzS9SWWDQbtrXHBfBBKwL2xCtKl0QQvo64Wq4XyelStFF9g2OTGKjdWogb6K5BvPRBy5OagMoZzcG4Vq5jrdUvi8fw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(7416014)(376014)(921020)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GYAdUjZ7ISJ/mKTdcgmXSBGuzt8k+A2v+J9DN/0soFJiwTpRxuuXFMZTopnTAJRNW2jJxYsIgR9pbhaLOKANODbN7Yniph6ChjTBV8+3FFsfopYuJyI0K1HVpcr+YASzWoVWeQ8GfGmcV13X7LL91dht1oLYlR5bc/VWFGSdhqH8fJY1SfV10jrhzsv4DoDhZ667zaoOiHEiYKn0OLhRoIU1PELJRtqg2eFBS52HvnHxfIuC8d9uuIYDcuZxUoNg0r68yL+znl0NWI6B4f+jiKNQPTePUJZWQdFo99D458XLjWWHJvjXmmQIc76/IWrsU2yasjtK+kgcNfkbuEmH/wEzs0AxdHb/s5UBH2AAFTSji2vBjuQ42HRQteTg2KyR1gzjU/EYyQeB7w2msDtQYPvFnTodPQga5oqZ10n9++rhcUGk4LcWrkfMuSft0c6Y
X-Exchange-RoutingPolicyChecked:
	CRzzt7xpUKOLyo0a+XzbHejg6UrgOG89au5LD9xAfrHULz3NGHysBcudTT3fnmq6c75PIXH/JeLLPBexak9MpGvcwuP8bSH/UmkbtD3Mv/uA0bQQRVgUw3tpsB3J+pTz6tQI3q+KY9R+DLB7fFR4Kc9NjgZwV0JhAefwtruD73DPajyYwQ8ZcDCU3A2iaBSA5sshQxjQSDlXD6xCsg61RBcK7CINJzryEju8cpvbD5ThbIqQah+wN0ojiBFsQcT7+MRDYEeKvu+pvhDJRMZp/MD4pM9cVkenpqXYbR6O5J7UcMVfc+wpwMiIxBZAmrHix6MEjLfgziKvY0jJbIPj3w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:38:31.0750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2247f2-8292-4cfa-fdc3-08decd0c9851
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7057
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA2NyBTYWx0ZWRfX8BzDSO8zBlLe
 s1kSz7TXyGCE5JdcTsuCBqoDwQqG/07g99RxdGbQ1q2YmGxG2RPFmPCKN3QxIY8tQjiXHh6C94G
 CdwJF42odU/I5AE7o7ZoyecFeDSLldA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA2NyBTYWx0ZWRfXxGTPQVkOJsdO
 O+BxpDJwfkiAAx7xP9JdVPsBVnCuyQjYzKZhmc8e3zq9dNrBE0jmwHv9Zbs5kqleHyKXNDcOyFy
 +YyJhk/DtxC7TFBhcsficvojEPo8HH/Pj5Ik1rUZxnOx5KDueJK/+q4QKxFgixY/HuZ3NkycNWD
 icMYfL5Y1P6k834f8BbHHMNCC9X7NP6iCqg1AuAEcwGtuYN4/5yw0+dOCtj+dvHOan/aNvUoReW
 O5U7AkP12s487l2I2P81bx4u91Z5rg4laCLS8Yx0bHV9txnBG6aofRWQ1nxXop+N0yUlOjKcPPY
 psojPEnUAW8xoFL6Fz7m4E0/RXmeYQeoZ4ylSCfsLv7JffL6HDsQMFwX/YpK2JQ2Y6n8xBidFBr
 VhZNbbl3zaRW8flaiUk9VkklsSCkAojHUAvfov6E0vQAmEiOU07qbiMJTH4c/Vk9xU61vtz0UBr
 X4LoddeUS5UrO1/T+Fw==
X-Authority-Analysis: v=2.4 cv=N/wZ0W9B c=1 sm=1 tr=0 ts=6a33a07b cx=c_pps
 a=NkapyFR+xBWi1egQVwNhyQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8 a=89-jStNdFWHnqtgceuoA:9
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: _1sPQngn34-yFmw26P9bMRNuLc0GDQWN
X-Proofpoint-GUID: _1sPQngn34-yFmw26P9bMRNuLc0GDQWN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180067

SPI memory controllers that support high-speed operating modes often
require a tuning procedure to calibrate internal timing before operating
at maximum frequency. There is currently no standard spi-mem interface
for drivers to trigger this procedure.

Add an execute_tuning callback to struct spi_controller_mem_ops. The
callback receives a mandatory read op template and an optional write op
template. On success the controller sets op->max_freq in each provided
template to the validated clock rate.

Add the corresponding spi_mem_execute_tuning() wrapper that validates
inputs and returns -EOPNOTSUPP when the controller has not implemented
the callback, allowing callers to handle controllers that do not support
tuning gracefully.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-mem.c       | 31 +++++++++++++++++++++++++++++++
 include/linux/spi/spi-mem.h | 14 ++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index e20eca1b8245..571a7dd9c2a4 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -660,6 +660,37 @@ u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op *op)
 }
 EXPORT_SYMBOL_GPL(spi_mem_calc_op_duration);
 
+/**
+ * spi_mem_execute_tuning() - Execute controller tuning procedure
+ * @mem: the SPI memory device
+ * @read_op: read operation template (mandatory)
+ * @write_op: write operation template (optional, may be NULL)
+ *
+ * Requests the controller to perform tuning for high-speed operation
+ * using the provided op templates. On success the controller callback
+ * sets @read_op->max_freq (and @write_op->max_freq when non-NULL) to
+ * the validated clock rate.
+ *
+ * Return: 0 on success, -EINVAL if @mem or @read_op is NULL,
+ *         -EOPNOTSUPP if controller doesn't support tuning,
+ *         or a controller-specific error code on failure.
+ */
+int spi_mem_execute_tuning(struct spi_mem *mem, struct spi_mem_op *read_op,
+			   struct spi_mem_op *write_op)
+{
+	struct spi_controller *ctlr;
+
+	if (!mem || !read_op)
+		return -EINVAL;
+
+	ctlr = mem->spi->controller;
+	if (!ctlr->mem_ops || !ctlr->mem_ops->execute_tuning)
+		return -EOPNOTSUPP;
+
+	return ctlr->mem_ops->execute_tuning(mem, read_op, write_op);
+}
+EXPORT_SYMBOL_GPL(spi_mem_execute_tuning);
+
 static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				      u64 offs, size_t len, void *buf)
 {
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index f660bb2e9f85..ef5a6d60bae9 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -346,6 +346,15 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
  * @poll_status: poll memory device status until (status & mask) == match or
  *               when the timeout has expired. It fills the data buffer with
  *               the last status value.
+ * @execute_tuning: run the controller tuning procedure using the provided
+ *		    read and optional write op templates. On success, set
+ *		    @read_op->max_freq (and @write_op->max_freq when non-NULL)
+ *		    to the validated clock rate. Return a negative errno on
+ *		    error. Return -EOPNOTSUPP if the controller has no tuning
+ *		    capability at all. Return 0 with @read_op->max_freq left at
+ *		    zero to signal that this specific op cannot be PHY-tuned
+ *		    (e.g. a hardware erratum blocks it) but another variant may
+ *		    succeed; the caller will iterate remaining op variants.
  *
  * This interface should be implemented by SPI controllers providing an
  * high-level interface to execute SPI memory operation, which is usually the
@@ -376,6 +385,8 @@ struct spi_controller_mem_ops {
 			   unsigned long initial_delay_us,
 			   unsigned long polling_rate_us,
 			   unsigned long timeout_ms);
+	int (*execute_tuning)(struct spi_mem *mem, struct spi_mem_op *read_op,
+			      struct spi_mem_op *write_op);
 };
 
 /**
@@ -465,6 +476,9 @@ int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
 void spi_mem_adjust_op_freq(struct spi_mem *mem, struct spi_mem_op *op);
 u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op *op);
 
+int spi_mem_execute_tuning(struct spi_mem *mem, struct spi_mem_op *read_op,
+			   struct spi_mem_op *write_op);
+
 bool spi_mem_supports_op(struct spi_mem *mem,
 			 const struct spi_mem_op *op);
 
-- 
2.34.1

