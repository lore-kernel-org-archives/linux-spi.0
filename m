Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636171A9FBC;
	Thu, 18 Jun 2026 07:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768332; cv=fail; b=i64cjip6uNaCvelemm7ChzUX9ZRSzKZyV3Vx5dQ77UPUk/VTWePlcEGQPGKWzD1M3HMcNaPvDoUEyvQPOWfL/0F+hy7ao4fgKvToshzxAp922lYlCZmr8NqJB5PQZpw1trfrgRm8YuN3ibOxpUEfF1Ao1/WR6NHzRmBrxYT+ZpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768332; c=relaxed/simple;
	bh=ApRKDGZgT3ZmWL1jBrsrFpKTcyJA1rVtOslVwz1c4MU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNYjjovt6n8eG/3//+IJ8grFpIJLCSJjShgPxgb1nfEFnBnkf3FjalLIea6xiuVg8fS0HrxoQkrAGZgBheTC/BGBreA3INO7huyA9/3rVu6tkbnCDFFXbvJ4wOBgTp6B5hf1DatGUupQ49JxYi1bLd8KA57Sr/8pO6G8cNNkqX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=JdW+h2am; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=j1d+t7KX; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="JdW+h2am";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="j1d+t7KX"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I3ndbL3790559;
	Thu, 18 Jun 2026 02:38:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=Sk4XXVlQqbE0LCfZCUDloawVlmQZjdCxXegzpG/6h
	bQ=; b=JdW+h2am5R8aHVjR+v2viw6PsjeylwmBkekb9/0erJWCQYQ2iPrvbgcHq
	aeUCX9XstrAQKm660vh9CyRPIKJ8a9Xd7p4HkpHEwtCIgalqQB4F8SSiZ49EhnV3
	rGBSwIIywdTIwBFuSyh4gdUUn8JeP9ga2VthrSnWnF+57iSHEKXd1OLjpy+lIdKH
	95gbx73R9Mz3ZDBzbQKud41TS76VtJre5QWXNcykRir9xDSrdpJPfkC146nYi5hD
	r79OpX3NLzpDlyJWZtXdK7kxcBAsQuIYgK4HGkTZgR0GfITWEkfXkEqoS9CwQkiu
	GgM2FUlKOKPjeiGEPtMZCF+X1Awag==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ev9449354-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 02:38:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+24+q5CPVPLoiCf/q7VX7IWHkKD+3Pz8fjXFfGGSSQEuJcigugJh6XmHJm7YWBbzTUoMkVlh8Ne7/qBy3lo2CbY5CoAjX4U2Zj9NYuRCX05drQ6udsx5lIxkAun48Qxwgc9fMcNUWdMg7LZDIST4rEfsNRQuPF6kJ0Y/NcXlLDemdLCqbdc4HJ7vUDALvrJCS7xVpxej7v3zOLJQ1bkVnsGjQQBHJS/qDldRKbtJq05qU6f9WPT141V7aK2lMFwgW52NA8ZtW/BoIkLDIh874GLiUuqTnCkZPc+sVhTmonJ5xRQrS2lpHbSiaA/xxsHYt7lIuX9YpvnbxxhCk1Mzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sk4XXVlQqbE0LCfZCUDloawVlmQZjdCxXegzpG/6hbQ=;
 b=XVcD5dDb8EOieuvX18ohG+2YAk7kPioPLcQ+PUXqhU+MdjFbykhUoNtUB+UyzdQy9LOn83ri5/KKNy8WjD40RsTwc1imZgBP2uKtjaUfg7abN7hVW8eyUZahMkU3GXJ03cvZXZWq+sgsk4OqK2OiMrOsDSdCy2EEOgKDXtLQ6nm7mpFH0ITr7VJog8EESkx8LKtJOWOHjxEKebbGcPj4GxzBj+xU4WnYZbbqEh43Xm4bj5HrXj+tdmh/MBlJa8O2lanDNmkBPDCNxOMV5liZJPqUS1IN4lZiT5QAZuIxn2ypzKDZVm2ojTS5W3x54Bv4R9vp763ssD5TZjt2okH6bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sk4XXVlQqbE0LCfZCUDloawVlmQZjdCxXegzpG/6hbQ=;
 b=j1d+t7KX4M1Se9iRrmpru2OLbYNs/NnJToGIkuOSAvO669LyhvBqWLPkiZQmRYzbCsAyOJVWBNPfqfQAdL3GvOk6dJ7X2Lx5h9RDcPL9S5zqNpgKhz0WAXBq4cb2IrhT6Ng/ks4KIav9i8WAn+nQEokiC57PZEo8WTELidECZNA=
Received: from BN9PR03CA0875.namprd03.prod.outlook.com (2603:10b6:408:13c::10)
 by CH3PR10MB7610.namprd10.prod.outlook.com (2603:10b6:610:171::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 07:38:37 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:13c:cafe::9f) by BN9PR03CA0875.outlook.office365.com
 (2603:10b6:408:13c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Thu,
 18 Jun 2026 07:38:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 07:38:37 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:38:36 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 18 Jun
 2026 02:38:36 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 18 Jun 2026 02:38:36 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65I7bYvm3521710;
	Thu, 18 Jun 2026 02:38:32 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v4 11/16] spi: cadence-quadspi: enable PHY for direct reads
Date: Thu, 18 Jun 2026 13:07:20 +0530
Message-ID: <20260618073725.84733-12-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|CH3PR10MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: 9268a2cd-5092-4d1a-83a0-08decd0c9c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|376014|7416014|36860700016|6133799003|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	kXtcaBp4XbAJsP3K0QedV2M8BQc4+bqkPDyOtl9kET6S5kxd9tNP5wTs8AvHVPf8Dg4lvOtnuH69HcJpe/DVArOYFJ60Wt3zt+YRUmGDzyYSYktj5/mjCAZzXogrnT5dgVt4hbJ/gU7KGdjXnJvUJawzApuTo8Ltl0uuqqyMdTZQeASlsc80P/rMZXlHjDgB56Z9zHQxoTzHzklauzHC9iRnTlxkK0qB72Nj1ZEfD/C9BkXG5NAc2n/9Tgcvb4FHc2gZToBYvPHtPbRzvuhc+hK0RYLvxjy0u7S3Aq+SphPstZBEafGiYn7pvSuHAx6K6zybCuVONHTxBPoN6v4DKnwrTP4vRUVSmUiyr0QEmT8BlCC+BOnAqAJlAD79IVCiBo55oliF8eBR1qGERFndGhgxEPjT3W5tcdNeMwKyMfum+U4iufnC2fRSIx+ufOxtGpx8bJGts8o5ezjZEEdITwN0fNs22o//o5+NjuR6ipqg/7oIST/z4tQw68Wrco6nr9x/85JVfu8JM/cLcRIw0IxvxkFWPLYgVjfoCWn/bYXR5Nki114S6zCKKkEVl6lCaCHVNW1jiVVqty5RwH6BrCGE7w2hGsFHG4AYLsf5F55aliqNX/l58HDt5LHQDo9F/sFqxAUbt7lKgU2Yj7pHBH/PjMyjWZvF4kPnSHkcz4ZgslsB8CSu/eKAgLV4j2K+Q9lSOrt2V4wvogi1dBTvnXZHM3w1RfvJWt2kmi2BFzm5kPavbapk+4ox6WUhkS8GDD6YvFTrXWsSE2NnI5O96A==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(7416014)(36860700016)(6133799003)(56012099006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p+eBBIvNmNvnozYbTgpFTvSdYRhKnWsn/hK60XlAQbifXaV5yklJZ8lT5SWUpm6xJGLLPXOmcG0klRbzCg98zCHlTQgD6Xjx5B2NuOPjkpgfS/dZWudKosz4mLnSckxKeAsfYW/bedFsbFeEeKhZcz59yyF/UOL7tB8WsFJGkG66koKCPoygK7uyTbnicEy0RlMGjsUpS0Wss0U1b8ztnwVlxPlK3/EzBVq96R2SVBXSvuM7iizdXIS01MNT1GX8W2HEBnKg4tVRd9CvMNtYF2+J9knCvUUxvz8CejhrkxEDxMYzcXePupBPWQHI/ssXY96FJeZ3v1ealy5fonlmxeJl02dhRFw6Na/cZthi6xa3MXKyPBJyYKinWtjdQ7Qjn5kxSZyGGRY2XJaqlkuFvp/BtQOMkR4+re+89JOmHskxYcJ7gbi369hO0+su2h+Q
X-Exchange-RoutingPolicyChecked:
	CZGDLTBmdR2yoV9IQQE3O/h//72froTb2pD4lQG/jCxTNauxx8VBDi3fF6FE955sKFUgShf4H5u6UNyFFL/4JdWIIXi75cRfM0roUkLysa/Hb/EOEWawoUuKvDRtu/j3dn7m4pH/leSQIJ7EsKE4WU+AuE7+y+0gOfEwa8gaXlpCxFFajySVFtwo+nvYtTwPakx/oZwX/XodT4ctSsrv6FAbp71LR+WTijnxh4qu74P1YsRgJhFZmnojlks7TaoLjY7XqEQi1kWT1XRdtwyNWV2QIuerIyqQLqffmlxKoVM/qNU7XOahrX2TIW7SDigFvUy3sx49Hb0XObkWojHBxg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 07:38:37.3845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9268a2cd-5092-4d1a-83a0-08decd0c9c14
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7610
X-Proofpoint-GUID: vCHwsZdrflJ_sHre7IbjHJ0gRUiYgil5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA2NyBTYWx0ZWRfX4GQJm/3VB0RQ
 iK2v8WjpNUJ/rWk8aitaObgLq7kO5HGGoxIittx5krbUwgTZB9fmI6oNX3aTqELQI6/ZWU4PsiQ
 JmbDo83mmK/1i92PAWzi+2VlpAjT2AM=
X-Authority-Analysis: v=2.4 cv=QMxYgALL c=1 sm=1 tr=0 ts=6a33a081 cx=c_pps
 a=m4QPU8/Yf0DQKtM+qTkXOQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=HwxfO7CK7rPlHD260gIA:9
X-Proofpoint-ORIG-GUID: vCHwsZdrflJ_sHre7IbjHJ0gRUiYgil5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA2NyBTYWx0ZWRfX2GYlHjAI3aVk
 pr8EEh0RZpAaovU/HH1DuNiur8u8MiI2vf+ynAaVB8sSBeiywUkI9sUr+DhjppS2oOO2DgiMX76
 C1sLM4QqOpwZP4+hvX4gX5veyO99QHSUZj6IKfxhJ9bfjUegVLbaFkHV6LhTv3/SDsErLjCo9E8
 uNqE2lAkEzWt1Rqf3COy8h2rID8c4I0xUnVM/eyZJSZgleimL+osxhV5qsZC/qHGjWNkZhrDfF6
 HIa8KXO8cDCqYFvtAEGiDiaH6Ad9F1GlM+wW3C5SEZs1X9vIb7OPqwTRGsW0ift9UzbSBmIaxrP
 XcYGi7ZHb8LYj95p2TuC5jJTdj/iC1JV89ZyhL66aKbtfEZRZ8vRYgYoIGrTn3a0kDFvlPyF83R
 AoGN4Aa19UTFi9/m0PrWv7sCfn9zmyOn8+gbt+S2/piypYc+Bs+zpYXoAX7vcBBkN9p7y0eZ7j/
 ZoGKj8shqclBHtY3TRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180067

Add cqspi_tune_phy() to toggle PHY mode. Enabling sets the calibrated
read-capture delay, asserts PHY_EN and PHY_PIPELINE, and decrements the
dummy cycle count by one since the PHY pipeline absorbs that latency.
Disabling reverses all three. Disable is best-effort.

For direct reads, split the transfer into an unaligned head, a
16-byte-aligned middle section with PHY active, and an unaligned tail.
PHY is used when tuning completed successfully and the transfer is at
the calibrated frequency.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 103 +++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index e41aeca47885..16e3b843f0aa 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -565,6 +565,61 @@ static void cqspi_readdata_capture(struct cqspi_st *cqspi, const bool bypass,
 	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
 }
 
+static int cqspi_tune_phy(struct cqspi_flash_pdata *f_pdata, bool enable)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	void __iomem *reg_base = cqspi->iobase;
+	u32 reg;
+	u8 dummy;
+
+	if (enable) {
+		cqspi_readdata_capture(cqspi, true, f_pdata->use_dqs,
+				       f_pdata->phy_setting.read_delay);
+
+		reg = readl(reg_base + CQSPI_REG_CONFIG);
+		reg |= CQSPI_REG_CONFIG_PHY_EN | CQSPI_REG_CONFIG_PHY_PIPELINE;
+		writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+		/*
+		 * The PHY data-capture pipeline absorbs one dummy cycle's
+		 * worth of latency; reduce the count to avoid over-compensation.
+		 */
+		reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+		dummy = FIELD_GET(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  reg);
+		dummy--;
+		reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK
+			 << CQSPI_REG_RD_INSTR_DUMMY_LSB);
+		reg |= FIELD_PREP(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  dummy);
+		writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+	} else {
+		cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
+				       f_pdata->read_delay);
+
+		reg = readl(reg_base + CQSPI_REG_CONFIG);
+		reg &= ~(CQSPI_REG_CONFIG_PHY_EN |
+			 CQSPI_REG_CONFIG_PHY_PIPELINE);
+		writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+		reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+		dummy = FIELD_GET(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  reg);
+		dummy++;
+		reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK
+			 << CQSPI_REG_RD_INSTR_DUMMY_LSB);
+		reg |= FIELD_PREP(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  dummy);
+		writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+	}
+
+	return cqspi_wait_idle(cqspi);
+}
+
 static int cqspi_exec_flash_cmd(struct cqspi_st *cqspi, unsigned int reg)
 {
 	void __iomem *reg_base = cqspi->iobase;
@@ -1442,6 +1497,14 @@ static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
 	return cqspi_indirect_write_execute(f_pdata, to, buf, len);
 }
 
+static bool cqspi_use_tuned_phy(struct cqspi_flash_pdata *f_pdata,
+				const struct spi_mem_op *op,
+				u32 post_config_max_speed_hz)
+{
+	return f_pdata->use_tuned_phy &&
+	       op->max_freq == post_config_max_speed_hz;
+}
+
 static void cqspi_rx_dma_callback(void *param)
 {
 	struct cqspi_st *cqspi = param;
@@ -1543,8 +1606,11 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	loff_t from = op->addr.val;
+	loff_t from_aligned, to_aligned;
 	size_t len = op->data.nbytes;
+	size_t len_aligned;
 	u_char *buf = op->data.buf.in;
+	int ret;
 
 	if (!cqspi->rx_chan || !virt_addr_valid(buf) ||
 	    len < CQSPI_PHY_MIN_DIRECT_READ_LEN) {
@@ -1552,7 +1618,42 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 		return 0;
 	}
 
-	return cqspi_direct_read_dma(f_pdata, buf, from, len);
+	if (!cqspi_use_tuned_phy(f_pdata, op, post_config_max_speed_hz))
+		return cqspi_direct_read_dma(f_pdata, buf, from, len);
+
+	/* Split into unaligned head, aligned middle, unaligned tail */
+	from_aligned = ALIGN(from, 16);
+	to_aligned = ALIGN_DOWN(from + len, 16);
+	len_aligned = to_aligned - from_aligned;
+
+	if (from != from_aligned) {
+		ret = cqspi_direct_read_dma(f_pdata, buf, from,
+					    from_aligned - from);
+		if (ret)
+			return ret;
+		buf += from_aligned - from;
+	}
+
+	if (len_aligned) {
+		ret = cqspi_tune_phy(f_pdata, true);
+		if (ret)
+			return ret;
+		ret = cqspi_direct_read_dma(f_pdata, buf, from_aligned,
+					    len_aligned);
+		cqspi_tune_phy(f_pdata, false);
+		if (ret)
+			return ret;
+		buf += len_aligned;
+	}
+
+	if (to_aligned != (from + len)) {
+		ret = cqspi_direct_read_dma(f_pdata, buf, to_aligned,
+					    (from + len) - to_aligned);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
-- 
2.34.1

