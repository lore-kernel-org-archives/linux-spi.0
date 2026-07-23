Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1B945DF4D;
	Thu, 23 Jul 2026 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804661; cv=fail; b=f7+Apj1c+NzE88Nqj9RaEJY7Ta56jkuEkmp+mblKHyC3YoxU8v7qFis81kIYe3IQId1Bp0+xdYa1ImIOzOk/zQqFE6pKwKTRVKfJ6ZR2jqNrw27ZCpmPwPGVHy/0f+YoLL10fR3ikQAJTknyd7uvPReNaPZG/bWC/oj0apSQ7fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804661; c=relaxed/simple;
	bh=QCZfApz0WI4MJamsj+4VqpsLIBBqXuUtwo6CKXU3FV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HY837s389IVrh9apvA7YAwW1OYd9bhKsxFGikBGhrlJPjCeAxnSFkMgs70PGiYvI52RToHmSYi/n5bpOkd62Gs3/VM6LedJ4564y6QY4WO0ZuYlF9ovrNX3dHbrJK+LqagoTnHXPhQ9qgzIAQgxSYinMlgYviABVEfzERVATS8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=BNMYfKdP; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BIqXxrFb; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="BNMYfKdP";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BIqXxrFb"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66N9I7Zk2039430;
	Thu, 23 Jul 2026 06:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=CaKka2TXrNmZxg/2rKa+E19ixmWvfwzQpJ0sWclJR
	yk=; b=BNMYfKdP05qySWf/e9FYv1EhVoGyURvq621yqKQ/7c2VrjFqZRWYyWDdW
	qpdQlQHzRb4ED+l+KoccU0RRutnsSTelobmvKoKTxGxGzpa8CB5pqpyNn4oUUNX8
	G7637jJMYTrBDbtVzcUC4z+MH8YDWZ7/ZHjBbKZWeXsSkEh6xwiSYrh5+6tJzU7H
	/GQ3dy1lB3Og0hSrZlKe37kfYfjqKQNmkv9o/bJa+SH58OIlcDh/AqgXeAc6nKIZ
	2t+o8+y4Mr/Rs7FW7Kh+hw1EOtnRis9R4oeQOWlR/Ta0IUPlfkczQKpAnaETiKsz
	LZ+q53qjtycx8D84G3HrkHdR2i8ug==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010051.outbound.protection.outlook.com [52.101.56.51])
	by m0380145.ppops.net (PPS) with ESMTPS id 4fkg730ca5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 06:04:09 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIwou2kTvwDeXMgwuAEJBnU0QKVk1/JCCdNQxyNCZCGTAnX6ZPiCi0GAIeBO9k6xB89WwxLneSR+ekVJ8B7JcNjaAlZgIjAel47TWPfLDpTp2lojlUAS4k9Xg3zlvt5uv4mm+YcMmKFqxAmJto0XKA7rKX3HKVFL28/x6lmSsav8yOKxN/9kE8pgMth6UAX5by7TRZPiBg/MmmqZyIgs6oZqkjcIt1LXLPpq5gWI3W7ajubM4+T4F4IXF8EE+yeAt80+mQSXG8X1J07AuRn7yhrMD6j+K80xg7L5A70uQgwYSRolu5SvjNqxGmk+XCxuCctYWY5OIbL3Q394OYM2yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaKka2TXrNmZxg/2rKa+E19ixmWvfwzQpJ0sWclJRyk=;
 b=hsgI9h91OCb+FOLm5mxvVPNd/gQsIV6TIqxdjxMyU4a8Zu6SznLHoWGYBiyIGGxU3bk+sqVEXK5qe+Q1UfHm5LGiGQFwemuU7oMUDzp296a/sBNFvH65kc+RRmqZvvpUakLoaTVbrrgX68u2nTAlnXl0P3PxfjTX4FyDPEHHg4xMzwu7Hj1/0z90J0AtVXo9W22Rk4f1v5iZFZ8N8pURUhCap6/r+Re8BnIBt0Vs90AW0EP/g5pqfgFLXbW1Ixn8RlG58p43DP5lyaEXVrMIv8X5ti1IfaPG6y6dCXhLozIg8OFa7ZKGZ8ZbuAW/wd1KA97OjS0zK0EvAz7bh8oStg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaKka2TXrNmZxg/2rKa+E19ixmWvfwzQpJ0sWclJRyk=;
 b=BIqXxrFbWHMiCY0ID/QfHN2auWX2auxEpukmLe/tNGvuifffSlslQILZQd2YSDQcmRWD0LxFjOSfdeYYsJXn3cL5kb1esNNGL2hfvOgLN36gnyKQ6IA9Ed3zztyTbbSfkl6Tqk4HO7hVNA5g5y679jWwMPyzKoOP46o5mlRNZjo=
Received: from SJ0PR13CA0085.namprd13.prod.outlook.com (2603:10b6:a03:2c4::30)
 by CHAPR10MB997697.namprd10.prod.outlook.com (2603:10b6:610:2f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 11:04:06 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::ab) by SJ0PR13CA0085.outlook.office365.com
 (2603:10b6:a03:2c4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.6 via Frontend Transport; Thu, 23
 Jul 2026 11:04:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 11:04:04 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:04:03 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 06:04:03 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 23 Jul 2026 06:04:03 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66NB2OWD1577597;
	Thu, 23 Jul 2026 06:03:58 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v6 17/17] mtd: spi-nor: run controller optimization before dirmap creation
Date: Thu, 23 Jul 2026 16:32:19 +0530
Message-ID: <20260723110219.3180747-18-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|CHAPR10MB997697:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed72577-bd45-46fd-d387-08dee8aa1bfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|36860700016|82310400026|1800799024|56012099006|10067099003|6133799003|3023799007|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	ej6/IXDUdos+XKD/qmjeVJIqV8iV1En532qij/ioySokZ24nFDY/y9Eh5uhEytUOgHT8lOXJrv8Wk0Y/VVEwSen4uwgioBaIbTJv0WyClLAjW7q6KudwqZlXtTiKkv61NweHQ8MxafHPnOP8zy/v8I5zwP3txVsQqSwlcBkzEbNHtQFXR8jXJBKw935QnTRx+5zE74LNF/nYcr2vKcRXpZXEZ1+66/bGa3jxLrZEZRRuNf70GV/K3KQ6p0siKFSxGrbLDJM+PCuCR8cgncSxgM1fQAaXGKgfVrNok7Sb20YeZFBdwxpqaykt+2xJcDW8LY7Xur+4JFiiktcTI6MnLCbS7tEGFglamTG2Zt/wNjGPlxw7VUruFqI2jV5fZgXMRGwT+HFM6t5fQZ42/sctGrQWshJY3+MOxbXwoznL/HwwEo1EMNIFORkcOj/DmtPoFn1xvgQbksAeqlf+GM5vphkQtqonQImQRBo6FcShPDxqsFoIY72C161Gg6I0ziL+t6E47lXc5uzQ6A1fwd5cbcnQcLP8comzydou9xU6YwrhZCnLCe+AchwpWpCCs0t7izwY6m+YahTTTqwTli01IlzwNkBANVrHXD+D9x1xK963eedGLvgnLycPIS/ONGFWMbb5DvNxNunBws5yiypA7LxxsY7dEvYYyJa0BMIvCYfKq680GIgP9DSXkdGFiOnCif4s8ljExQ8TWmYIfA1FZdNuqQWL5DfvpWoSkpcd5jtWJGNrXY16Lv4qQaP8M20B
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vYuovQK656B9yhxrdVTwqN0vAAxzaIa+2UTocni0tSt66711HymRmJ/UxkONkZdWt4boqgSdk1qJyeTu2Q3Gld4yZD13I2Ii5I95ojowi8Jyug5DZg28eEcPsHe8ZYp1XwggzwtQoTnwmOwbbAQR14TX+Mtr+LPJJgJWiPESUu/IUkW6g6NoFpr2JNRcGCXLrwUIdO1s7TzMBXzvfQNvE358GnT2ueud8GaXwbDjBOdS6mb1hG64teJn26nBvYWnccytcrh7Pw0S2nYwT+yI79W9VqBZexjGXCY3JAEQqz8IZgYelKoVrdUUMfMQFhfv+Qhdg4gq0eqkW29HbGQqG56A1Btj6VRoxp1d5H9+VbUdCTfHLYSWG8K1C+CRjURKDjYIAV9kBNgHQ9bfAejbCZRe4LM0WwBWv7itBgQDJdy25Xs6BIK7u040uEDALeIT
X-Exchange-RoutingPolicyChecked:
	I7HbNZaHtvJRffMrylipZCE7roGGxZtmsJoarwoaziNFrPrZJsdhoLkEBrOYRlPdT4Eq01YwiT16/TSILNnRbE4fyUo0E0t6G4FHlIlhHz8WkIqTjhkvp6fgRUAD+kVqD9Woj6FU3khcgrsTusljNPPLv70+wRrWSPijUZzA528ZqrabwZhdv5q4+z8ebGtdwiXAxXiV+dt1Lr6nWZCH1Vpqv0ysITznY2je7rb9t6xGzi1epaMw8CPnyLBgyoMW8tcbix4ap8fQbtcS3ym0ArMscdI6LiS4yaXBvzcYokTO619OmpG0cFVsqVSREHEgddSWRdeia7H4DUdqUq9EgA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 11:04:04.3312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed72577-bd45-46fd-d387-08dee8aa1bfa
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR10MB997697
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEwOSBTYWx0ZWRfX7sFaf7EJYEc7
 9P4A7J8ppnkxVCsTqHoSjWTWI/ek43MFsbb0AvZPP7TjCDKhQTyjgFPqafKZNdLetSpB1kjMHGv
 nWynct7phTVclZKCw/XJ+xZXFOi6Pyc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEwOSBTYWx0ZWRfX+0LFjpnvtSGl
 L+PIFc2LtRRjj79ouZIVzzkIL7SbEnLd9JjuBWz4DWtY541+eK4c3ocrWtxsxbuB+lkbJK+vPmG
 /IfHq2+lmSu36lIxCiSd2UYrn37B3KxKEidnLoWgOt0f64LUx4ThamMb1xYLvbST2tKc5Tu7zdf
 uZIqFEWLdAuVaYdRcGtu6uwJCUIFuX516T+L5joOI6y68IhKrG1UDMUfnqy3juuLMaH6g/Y72OQ
 UorbO6zTF3iKcuWcwbqX0vgRkOz4bDT5QAMwVuomNg82PxI9EQ8V2BAYQqk9UbI10szsrFZO/Pz
 1WOsd4JaN937i8081uoxBYaSuu/qNl1EGp+gjW47GmMp1A3PVblprXA82uVUsZ8XCXOiBC4zDPe
 seUmEvd4W5rLKcd33gDly3mXuah9jiJ1vdxcB8nHrFJHNquyUS1dO3Xt3G2CxhUK/iW3i1x44e6
 9ioQICdtRgPcf5RGEiw==
X-Proofpoint-GUID: ipLGOF56BzN1Ts5mTewgdVGUZ9BrfzmI
X-Proofpoint-ORIG-GUID: ipLGOF56BzN1Ts5mTewgdVGUZ9BrfzmI
X-Authority-Analysis: v=2.4 cv=Z/Dc2nRA c=1 sm=1 tr=0 ts=6a61f529 cx=c_pps
 a=oox2QBUX2gBgMMQWkhdftA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=dAWDYLcBFR4q-bF-ZFAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230109

Run controller optimization in spi_nor_probe() before creating dirmaps
so the validated frequency is available at dirmap construction time.

Store the configured read op template in nor->max_read_op and pass it
to spi_mem_execute_tuning(). On success the controller sets
max_read_op.max_freq to the calibrated rate.
spi_nor_spimem_get_read_op() propagates nor->max_read_op.max_freq into
every op it returns, so the validated frequency flows automatically into
the dirmap template and into regular read ops.

Optimization failure is non-fatal; the device operates at the
conservative base rate.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/spi-nor/core.c  | 14 ++++++++++++++
 include/linux/mtd/spi-nor.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index b683c077a233..2efcdc7f637f 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -216,6 +216,9 @@ static struct spi_mem_op spi_nor_spimem_get_read_op(struct spi_nor *nor)
 	if (spi_nor_protocol_is_dtr(nor->read_proto))
 		op.dummy.nbytes *= 2;
 
+	/* Propagate the validated frequency; zero before tuning. */
+	op.max_freq = nor->max_read_op.max_freq;
+
 	return op;
 }
 
@@ -3843,6 +3846,17 @@ static int spi_nor_probe(struct spi_mem *spimem)
 			return -ENOMEM;
 	}
 
+	/*
+	 * Populate the persistent template and run PHY tuning before dirmap
+	 * creation so the validated frequency feeds into the dirmap op.
+	 * Tuning failure is non-fatal; the device operates at base speed.
+	 */
+	nor->max_read_op = spi_nor_spimem_get_read_op(nor);
+
+	ret = spi_mem_execute_tuning(spimem, &nor->max_read_op, NULL);
+	if (ret && ret != -EOPNOTSUPP)
+		dev_dbg(dev, "Controller optimization failed: %d\n", ret);
+
 	ret = spi_nor_create_read_dirmap(nor);
 	if (ret)
 		return ret;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 4b92494827b1..ab498a50f15f 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -422,6 +422,9 @@ struct spi_nor {
 		struct spi_mem_dirmap_desc *wdesc;
 	} dirmap;
 
+	/* Persistent op template updated by execute_tuning with validated speed. */
+	struct spi_mem_op max_read_op;
+
 	void *priv;
 };
 
-- 
2.34.1

