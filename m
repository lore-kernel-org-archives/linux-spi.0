Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63E038E5DE;
	Fri, 17 Jul 2026 18:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314377; cv=fail; b=cf06QrQRUjS6ebWFabHEP2y+NWyPVfD3ZIYsF9BxCXJvoogNZW2oJzzJHVPAjK8+ajsRJLeviio7TBtqPn0j2UVYWueWR9pDoEmm8lmsRe47achzPryXep5HT7Dfvj/1a3XEjjpWsAudctOmlZX3f3/nNjoaQuSXTaiAH9iqx8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314377; c=relaxed/simple;
	bh=Sm4ubbEEN4Az76qfVMNZTIkkcnGNEOC/u3U9uX+LeJ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3f0VsrGy7EJ2YpYSEiepblO4SfNAV9qWJXpSDssmTRI1+YuMU/WiwhijBh1jgMEs20AFW2+XXAgiK41fHXPiicicmTOIqYW5wnrsj6DjUC+BEOeDoKsZ7pvNl6jFCSqbj+4FlNM6a50S6npE/lsSSMMCmgHkcSUvCD/YZ899Oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=nAy6Nz56; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xbGOU6i7; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="nAy6Nz56";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xbGOU6i7"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66HIlHdG1570008;
	Fri, 17 Jul 2026 13:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=hB6pzNq3ewbcs9k9dCtsJN2CaWmJWpAUfqG98Iw46
	N0=; b=nAy6Nz56ON6AXbqK4TuBN7CxXbtBeBLEcHPZnyklt0Mp6apnCXAFUeU/B
	q6LCG0xPG4Yh0s2/CcFD8OB/pA3OuTO4j49E7hDJBrSNJtCU5LKR182ERoJtqWvX
	n3PLkMe3Pg8q400ZgYnO2Pc1e1o1B9FKTFSM9sk2S69uAqodxvDJcNCoNLcOYOCh
	CZMoxKM3dIy8Z0b0gqduWOX9ZlVBTwT/+Vgw641tV9OJYrXmr7FKKZ0pqz4L8Qw2
	LjBhTUFMV4hdFXp4Zg+tXKxJOEALAHNGfw3gZjNGy+hPnoNspyKjNjUHee4Su0u2
	A1w9dEeaAaTG4H5luG2N9EEW/RtUA==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013029.outbound.protection.outlook.com [40.93.196.29])
	by m0384305.ppops.net (PPS) with ESMTPS id 4ffgsmbgum-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 13:52:45 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CnGM3FC7E0Itb0ZcgGB38YyGCV67QPKJJOvmyJzv7TcXqTSDZeQpUjwFXinWpiZ03iX7s1+9wqIsjLOhkLKkIzz9Xs50uRT6e6/37enh8pgDqL3URBBX1iAtnpdvYa29sI8dTjWH1Mz/Qq3cAAO4R2ile8rWf492O6/iAZRVwlRJyzK/2GWiAyiV9ps3cdvd93Nqft0gLLiYjTK6APhK+u2NkBOlHCVjYT+8SRjIvSPl79GrLhmS5HuTjp6vigd4BhWXrGIh5lnF2dypjLn+BtbEpgVUSVXfWO4cXjhMidULJ2c5MOCWRahmgnG/dGabSg87YChc7QJ4VWTrH9OMkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hB6pzNq3ewbcs9k9dCtsJN2CaWmJWpAUfqG98Iw46N0=;
 b=eQKOn1sIHA7QfCBgsZQrv2n4Hxa2tssi+3sd9TAOQiTYNd2kq26zLYxK02tzDPeXr3OJAlsu4v0Ak0iO4wXXuud19zZQMw7lOgxRCl50vpsd9z9tAK4QWmM4tsHOiitWiOlZENMPRFbjUEh6no01KHHdl9nnokQPjnW1G9vHPBe6fzXuhGSB7DEC2G+ZiQ0v6cefCZHltTGhKCkGg7wMOKELhKKyOaxCWayoC3GQFfowct16I9u59pf9qlbbwTSQCVMI0mDHLrN5Jshxm8yEHafQPPJlZnsWl0YuGuGtW+TPnluT0iwJVHJWdamoFZpV+DDGGrRDl4B+OGHP8VPdBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hB6pzNq3ewbcs9k9dCtsJN2CaWmJWpAUfqG98Iw46N0=;
 b=xbGOU6i7ioTu4+eEx77tizXmjRDj0rvswWNglVDZombDBtJdByybfRIJD0OWRkGcZYMSbFaPA5UXETlX3dIeyMAB3d4m0BqpZtZZ94LQFV5eoYw/G+GZ/zS/GQkFhKY23LVmpiVI8Zind4JXJfPuyxYWe5Iw7eguIPj/Xd31DtE=
Received: from BN9PR03CA0573.namprd03.prod.outlook.com (2603:10b6:408:10d::8)
 by CH3PR10MB7646.namprd10.prod.outlook.com (2603:10b6:610:179::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 17 Jul
 2026 18:52:38 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:408:10d:cafe::25) by BN9PR03CA0573.outlook.office365.com
 (2603:10b6:408:10d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 18:52:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 18:52:36 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:52:36 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 13:52:35 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 13:52:35 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HIpU4w240969;
	Fri, 17 Jul 2026 13:52:31 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v5 12/17] spi: cadence-quadspi: enable PHY for indirect writes
Date: Sat, 18 Jul 2026 00:21:11 +0530
Message-ID: <20260717185116.2065505-13-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|CH3PR10MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: 260d484c-ed1c-4619-8c54-08dee43491a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|23010399003|1800799024|36860700016|6133799003|18002099003|22082099003|56012099006|921020|10067099003;
X-Microsoft-Antispam-Message-Info:
	nR5X9/1LCN6fuj5c/rFAvZezD21IOBZB7SKRi7emCHXu7iSC1DzVVbi3+AuNYfZkHXGTAG8Psj38k+pBiOr0/XHsqbHLt7xjAEL9kI2zzuDG0NprbvoJdN6bz0NT99ZjdStCFenic0buKe6/OEMbUMtsEC9kQE+0Ya8/ZSESMi52QItNMnBi59wkXpeGun2Hju1clGTXcpaARPDDGjN5A9985Z44I2Txm0uBFZM+em9Zw4BJ7PR8bBYyCRe3+GjN1JOdBaGfgi8BK9Wp2i5RDzbgxutW/N0MzbmCEwtBQtLsvhnRSjxaf4bOM8ivT4/1NiRG4ORAU2i6wHXO9YuSVjL8OKFCib6fP707XSA4zuCRZ9QnKbNLWo9Q2zny4QdgjFU/eBEWBAwMakfQbVGdHCJFkSrotPRanCR3XpimYn65d17hz5cLj8pxE/GJsAS10qpavgw0rOZ3bCGViXvG2YY6MmPU+DBccgaHxgLSUUYRS5Keamf+uKV/C646u4p8F1w0hVghwzbyNSKBCyRZw9zaCzb7Nde+bpT384WSN1i4TQqMuhGXtcH5oKe3FGRCAVqxrvRPKKSdjWeChjQhUgaSUmTgFVYPiXsYppBXqIXGDEMRdTuOSRb74KBmlRGA/j1RIG9M/OpQqSoM9Q4xlX5gIZTnZDtsIc7qjvk3NoCF6DtQDy5i4C/A8u6UgW5LEkJQLmi3LRtdFMWknuWyK+PDEXD/sX0miem2N8tr0qvzqS1Qk3KtZsKuNWK8toOn
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(23010399003)(1800799024)(36860700016)(6133799003)(18002099003)(22082099003)(56012099006)(921020)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	v5DY2ZSkoOhivu21Wi9NkUSinygkIJYjhBkDWPyOsJszJHqh2Rex8cKfvp8XlEI/A4mgMw3Jc5BvHONqQ4HzlFjxVdIWvyNgyXCwNbvo9P4bjW9xFeUqmYtFrNAT9IlFGmCY39qVgkC9y9dSjtyqc1p+cd9WO4hEdLGsFtJGrY2+MHKKHEkSWsxcDIimohLeritpMjPYfKriXNkVbqqV/dXH87QnkmqH9mjTCPwQd5tb9uKTFPiIbwp5oaEzocot7at7tOEEG1UO3uRd6VcRo00113ymlHU+JB2FdbtqlU5rN6eLbbQVhMJJZJv1yqSwVol45tUNy5BrbInWr9At5pHsfoTfOdM4ntwA21U9TJMHgcTkn3ZMQpv6wyrBZ1PhjVZVcf6af9tGqSpraiipPsjZwcr3mxNj6iqLZcJKeJVlsXmJ67JIAEDBZ7JJaphB
X-Exchange-RoutingPolicyChecked:
	sWvQCD6Gl2+F0SxgruRt0HqUr0DJTQ2JgH+CKNg/5VdZtj32NefD+8lR+MbOKU1hNnPp4Pxs3R3qkgUFG/fXur6VliYqP33s4kgNgCZs6m4X2QcjWWJcF1nPo8BNTy/dJwCL8fmnwKOmbIl6uWFz2q4Q95AcTZ0eaTZ8nVYy5c+R219l2nYPD9nhOFxES1d6baDxJqgwLu/E9phB2Ppsk+t2QaahqVRbR5c04X090ppN4q1yIsoemN1WKz1wA9cAGMDov3RA3/eMX3zqxQliyyglTTTIEDqZ6we67NJs0GvGtlFCN/awsMXsP3KlV3mE5lBUXR+xbfc4q3SXZtwSqQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 18:52:36.4667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 260d484c-ed1c-4619-8c54-08dee43491a0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7646
X-Proofpoint-GUID: xFhlT6EI9ll3zw_Ki5LaMp5s-DD6o-T7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfXx9YTBIy3gekd
 sDbTd8FpGq6xhWBXyA0SFz9gLtrtycTeQDzLcUPivWyeKOtpGghtULeo2zznd/8uNWPIsesbMgO
 pwTHDdj/0PRP6DAIV8k+ByOjCr9eJBOLm/e7EQLSxoFY5lJMCpEmbxXGuCeZymWLs01OdJmuw3Z
 hC2oQ0XP7QViVr9l1VMavDQMsPCaKMY5N6zkeZqkxCtvgzxR94Xzyv+d6C4iB2haI5qR0aThypE
 W3eHeeMfW8DRFJZuTvzR//ttOVtc+pkWT4wvDgYesVHN4sAIjsBytu0UyVbdKq7FXEy0m4xpfNa
 bxY9oiR6cMYXqcywwRaoSzwm1+7BXPXAse6QXwu/oh1TybgUpmwn1xXljfxftIbRMDZFWLYAsAr
 eJksav0qtUUwtFNWa5f/hLLfJMsLJP8uFXPeX/7q4mbZcIkksJ5DwcEAwl1bo0ZCvffkLpuwGy7
 pxdW+C7k/IQTWpTHjcw==
X-Authority-Analysis: v=2.4 cv=GJ841ONK c=1 sm=1 tr=0 ts=6a5a79fd cx=c_pps
 a=y599upwrfiZ3HV94zaFOUg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=-A2lziRS1w5XIjWNnAEA:9
X-Proofpoint-ORIG-GUID: xFhlT6EI9ll3zw_Ki5LaMp5s-DD6o-T7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5MiBTYWx0ZWRfX8VV5dPRUTihW
 3ybxPmewdgwe3i49AuTJYYYf8GgqyhbCZksUR/cjshLahZ4x+wM9VI9SosXVVX+deo+CmbGdQiW
 SD/62r7f0W6pWOq5WjEL2Rm4WqQu6OE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170192

Enable PHY for indirect writes of at least CQSPI_PHY_MIN_INDIRECT_WRITE_LEN
bytes. PHY is activated only when tuning completed successfully and the
write op runs at the calibrated post-config frequency, matching the same
frequency guard used by the read path.

Thread post_config_max_speed_hz from cqspi_mem_process() through
cqspi_write() into cqspi_indirect_write_execute() for the frequency check.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 32 +++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 35a400073944..542ad331ff16 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -153,6 +153,8 @@ struct cqspi_driver_platdata {
 #define CQSPI_DLL_TIMEOUT_US			300
 /* Minimum transfer length to use DMA for direct reads */
 #define CQSPI_PHY_MIN_DIRECT_READ_LEN		17
+/* Minimum indirect write length to amortize PHY enable/disable overhead */
+#define CQSPI_PHY_MIN_INDIRECT_WRITE_LEN	SZ_1K
 
 /* Runtime_pm autosuspend delay */
 #define CQSPI_AUTOSUSPEND_TIMEOUT		2000
@@ -1335,13 +1337,15 @@ static int cqspi_write_setup(struct cqspi_flash_pdata *f_pdata,
 
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
@@ -1377,6 +1381,18 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
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
 
@@ -1425,9 +1441,15 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 
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
 
@@ -1562,7 +1584,8 @@ static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 }
 
 static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
-			   const struct spi_mem_op *op)
+			   const struct spi_mem_op *op,
+			   u32 post_config_max_speed_hz)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	loff_t to = op->addr.val;
@@ -1589,7 +1612,8 @@ static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
 		return cqspi_wait_idle(cqspi);
 	}
 
-	return cqspi_indirect_write_execute(f_pdata, to, buf, len);
+	return cqspi_indirect_write_execute(f_pdata, to, buf, len,
+					    post_config_max_speed_hz);
 }
 
 static bool cqspi_use_tuned_phy(struct cqspi_flash_pdata *f_pdata,
@@ -1805,7 +1829,7 @@ static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (!op->addr.nbytes || !op->data.buf.out)
 		return cqspi_command_write(f_pdata, op);
 
-	return cqspi_write(f_pdata, op);
+	return cqspi_write(f_pdata, op, mem->spi->post_config_max_speed_hz);
 }
 
 static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
-- 
2.34.1

