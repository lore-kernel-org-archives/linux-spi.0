Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B8747DF86;
	Tue, 29 Sep 2026 06:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663876; cv=fail; b=Oew33PBKjP2bsmLni5bx3nC0T/sm6PY/aGVczbc14jyDFx0W7T6Rb6PDqbmeWpwe/7HIDuzXX1zgLb85o+d6JndAmbz814M+5qpl6DhT19yrvLcCQL+j20htlLQAF1HMc/H5vweaA63QWuvY4ce2DyhcM3CfmvV7yer9Wsx0MzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663876; c=relaxed/simple;
	bh=owzxzQGTsYdiA0OkV1pD4UnirazoxYOsFxi2BCks5V4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pl5MxybcAAqVKmKwkWlHuVjVJC/VKjTaJAKxJTNSRWs3Apg5kG9N4ArliY+Gpv/m7Ntupc/w6A9cqkMeb9liHCxpJRo1TU5UNBCIwybfO7H68fqncENRt6O88VAR3zNjwDOI2km6i3YoegIFaBBh8OS87mogNuimhUqIHw95iV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=lcrXabhe; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=jJXVPj/W; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="lcrXabhe";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="jJXVPj/W"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68T46SFH037366;
	Tue, 29 Sep 2026 01:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=spQHzhOfFeDqkPLM/aeMmqMvqF1SPf9wS/eqYEWDj
	Yc=; b=lcrXabhejrK6GnR7aFTP455mQU7CeJiI3LeCcsvwrtHKR1Y3x9OTxX6JS
	6A1JswRFQj7HXXO1zDrLqa60mvoMDcwGr2AOHiHnqH+64mA+5nJ4Y9+VtMHN01Ui
	zQ87wfeTjp0zHSkB26zhRs/A8iNEZMUNjoaNzHlNGrxtQ25A5OPTjF5TfUeHZ03t
	4yL6ZAq8cbxem2USxNuEyZxcNamUqW3RVnwDM0WlCDV2Rt061XMSqE93DYzYIiMt
	H0B72TJoLNiFSBqYGsV0kkCi9LaRou2O6ws/W7KDXiQICG9MdSTNAPzZqitFDEi5
	2VVm0600b/oC6Q2E7uzUl2NaAsKVw==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
	by m0384305.ppops.net (PPS) with ESMTPS id 4h02j69x25-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 01:37:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7rbYEIP+7qm6HugZyx8CmvTm1sLoL7f2Y793TLvkksFW4MAEHXfMdqpOO+/ZCFwlLZR9d8X/Ru5zC7Ra+suPSeKhGEahza07P5PkEgb6DwBex4b3IcjXy9mL4J/a6/pTthToyWOpqpi2NIdK+M2bytVi5Rqg9W0ju2sunlZNBxQpzqux7sMZuIrGHuEKoxyPHFBIWch9pSTVYMJUgzfqKQkqAxWDGlkrbzh+BmGpDO5Tf7cBOcZ5+NQZxwW+Uhk4jdagPOWcQejCX55//IA/cp1zA27TBSL7nZq7fnZKLWcHbNJ2W8Q+ooGcTtLZ8oEJyMKW59jBIuh5q6cC3SzQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spQHzhOfFeDqkPLM/aeMmqMvqF1SPf9wS/eqYEWDjYc=;
 b=StEnKix/EmGUm52Hd3BP3LBnBv7/Lz/PkecFea/eYed3gttsDxe3Wy/DmqiTE5Cw8nqEd1CNn5/+3l7uYPkiJaxQgpiiv6gwPe82R+/2hQgMBdrzSrAiQzEMRd4pj9XjvEaJNgmn7K3+FjPLUVzqzt7JCmETNYPNicD+S8PSKaPc8cjiWJjw2+as/KXtp4f6BgmqtcHETO05RfrlJAWOicULoZtQWum3S6kr70quYz2pv4fmEH9taJxqGS9oSUwVcR6AyoA5s2nmApz7v9xP4w8LUn+a2QVdqUmeQjAknmO41brcUx1wvASKrcwLz0Bhyz9dHw2dAiImiUWNVpszRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spQHzhOfFeDqkPLM/aeMmqMvqF1SPf9wS/eqYEWDjYc=;
 b=jJXVPj/WvlD+vIhjQDkA84LMuTjVbWPksARhkvgy2tyS5/T0KdUPVtXKEE8DIWSNnpc8zuTJTSdofq0s8BKRmW8xkJKXKFKuieSwig3QgZ9MG1YLO5tqawKCrUUiJWcI6gyzfLkF61wQaQGoBdyBuB8of2maFxjWc42ovxSoG2E=
Received: from BY1P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::7)
 by DS7PR10MB4878.namprd10.prod.outlook.com (2603:10b6:5:3a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Tue, 29 Sep
 2026 06:37:35 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::29) by BY1P220CA0020.outlook.office365.com
 (2603:10b6:a03:5c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 06:37:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 06:37:33 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:36:59 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 01:36:59 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 29 Sep 2026 01:36:59 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68T6ZZnE1395904;
	Tue, 29 Sep 2026 01:36:54 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v10 14/19] spi: cadence-quadspi: reprogram PHY DLL on runtime resume
Date: Tue, 29 Sep 2026 12:05:24 +0530
Message-ID: <20260929063529.1235417-15-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|DS7PR10MB4878:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a35dfb0-242c-49a3-a743-08df1df4250c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|7416014|376014|36860700016|22082099003|18002099003|921020|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	b7FHYB3XZqxqIhMvA4jb4nF32m6HTtnZaIJxRUNvsNYnAKsD+il48ccfp4vUlo0jl77TMZ/UIK9Z7EpQLhXfniV0XxpFopVP32NCqc7+RSAE0Ltn8EGefRSrNyu/3oXdpM9rJDyFmcQdwM/RXbD8sJv3vaFSkHk1tTwTbHe9HQtfa0K/TAhkbDRb8Sl8nFkhtILkjuwFy7i7cd/u/oyFEwAFNm3XBm/jKT+kOYEGOlxzJIHL01ZFvuq6GF533jzkmG+0Y3cxDOxBREmz/cEvDmuKYwnGqFyhYCMH46aKvPtitQeLn0Wfo0VVTEOedc+AR7R+KWe5iKZQHk4cL3tOeFjqH+tsKgLeLAvgjqi2KHolNic154xZWqFDYV/wrbVqfWbFzJNe4gX6YRxrQf3/If223+rYSb97mpVc0+MeK6VmDEv168OZDQcmOpTGp1FJr5FAIlVfsFufv0gCG2Rb4Kh0yzbJZQjILg44ArIqdKMeBfbh3AXTSML/14BPHB/qUPOtd93s3Q3IwlD4CodXncKfHUBTDX/1XaC4ktdPb4p79FyQy+PB9xaJkC0GzLw6FBgvrmc3q/HHfKu2Ty+KwRC/saWk1GKL5ttLiRLCMb9+KgDbaiHNPJGEQBnNFiO7aR28tX75VMgQ+NXe82mFOp0o1KlJwOcn2JiK6I2M4MNnTP7qruw5xV4BEro/uqMhjbX3yj2/1FdIG7bm33Pi2L31yEI2L0VWHnWUzLw+rx8ZwIY/N8wYVhxXpi2WCAZk
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(7416014)(376014)(36860700016)(22082099003)(18002099003)(921020)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vx6VOHdBvI7HmjlkQjg/mnQ9BYn04LAUQftGpWkeXtYrcGEm5C+QlSgVJdtU+pNOAwEkJZOr1Jjm+nkEjlor6zbOyc8NxLlQf4+HhCu0d/xxFlOX45BCE5IU00Kr3FvSUMVc9ebQ8dTWWPLmH6w7GiUmuzR8Hb6l8QARhdCWCU/Pp/AOAyE6WUmnucLXfTFFwxegOow2/oeyKGUxNjMCeg3Iqmh2qByDYucopvR2DtMTmdq2U+zVPfiqJ0MYSx7tpo+vklRa+8GOvfvHWpqwTE3M2jH2JRQmHEaxGjv73xHaNMcP1xx3g88wN5ZIjLITP826Q2fLsXjDnMqLFO6pJSqcLjF5juNQRG45DcUhczniJNB1n3XTkM2hjyyz3n+IRTYRwG1YoozMrWACv2VkgVPrcz//W80ZQ0lVSHgEFV4b90EPOHI7YO/ZfmJUN2Np
X-Exchange-RoutingPolicyChecked:
	ReRg/EZA3B0m8hRBJKDEEoCfBWLgHU3Bx8RQPsWhiBA9HvuDGDEHCJPd+juEo1cQ/yK2lkS8yHzGSCVyq+wdqfm49cTAxsVaqErJCrV6v6sux+As+KJhWOFMxhpl3v2MXT+qMzazEXGO3mNw7b2jWyKfnrCiUH5MB+rmzm/4Qn0zzG5bJvYusiOWbev+i4qiRMJSHgi9omriMqL+bxP3A2YgebsAqr6nwNsHyGbWp1SOaf8FzljZmnuL28Vvkp3SMxesrHBz4KgmtmPkKxK7Cjcemt7SQ9AoERa2B8jmdv3u3Ron+6Zr4k6KOdU/o41cOCGB48V1c+TzNIlI4qpZhA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 06:37:33.9362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a35dfb0-242c-49a3-a743-08df1df4250c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4878
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfX4XMAf3XIHFqM
 nKVlhJ3gLdPTNUlmpx4SkAA+yhruY75mr2tBc7O8fAHIResTmcokwmqF7jd2bTapcpz+HgpB8ca
 W0FrQ/RYttrbiPrb4zeN7mXzEDElSgQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyNiBTYWx0ZWRfX6NRSCBZIv6l8
 zS3sBbYWjLOaUpLV1xEz8BiQo4HjlD41tcc0Kit0hiXhU7LsXg7gVCkJCBRwBBVXHTN9gspqorD
 n7qbcN/WtuNMwXt7LGbNtE969taiizf74JkWheN/ifaUV0yGvFxNZzSvIIHmWRQETDX5QQjPCNU
 +CWwteaxQycEYDziXSya0DQQK6s1GEaQV6JMZH/xU8Lv0ZGA5QWbAvjLrUQi0mUMSpPMjK6/KMY
 9vRwtyF8mOrGWNCa6APwB5eOVl9HtOqd/FfYGR21b9TXBc+qgOJtlLs+2pEdV28y63X/My6C1cb
 cZw3oK6TzX1U88ESutIJr8ZEXkrwEFhkmpAH1cUI9Lz9ykfkrUQ2b213xwPIuTPFqHIzc50Nm9w
 WsGJPn6plDkMeP8lS7oy5OKckyApLanv6foZu9dvllju68t5/C7haNT4IyNtNBn/uJrUVReYl2S
 Ixp4VVRIVWU1w5Xq6Yw==
X-Authority-Analysis: v=2.4 cv=Z4p5j3RA c=1 sm=1 tr=0 ts=6abb5cb3 cx=c_pps
 a=G+edI3GLQse3gACT8XNfSw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=00RIKaukA23DCyUQAnoA:9
X-Proofpoint-GUID: inSlRfopg7Cfbie-58mAyvR_l30oiNCX
X-Proofpoint-ORIG-GUID: inSlRfopg7Cfbie-58mAyvR_l30oiNCX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290026

The PHY DLL loses its programmed delay values and lock when the OSPI
controller is power-gated during runtime suspend. On resume,
cqspi_controller_init() reinitialises the controller but does not
touch the PHY DLL registers, leaving the DLL unlocked. Any subsequent
PHY read or write would then fail at the cqspi_resync_dll() call
inside cqspi_tune_phy_read()/cqspi_tune_phy_write(), because
CQSPI_REG_PHY_DLL_MASTER -- a prerequisite for cqspi_resync_dll() to
succeed -- is never reprogrammed after the power cycle.

Restore CQSPI_REG_PHY_DLL_MASTER and confirm the DLL can still lock
once per resume, not once per chip-select: CQSPI_REG_PHY_DLL_MASTER
and CQSPI_REG_PHY_CONFIG are both global, not per-CS, so iterating
over every tuned chip-select to resync its own RX/TX delay taps would
just have each iteration overwrite the last. Instead, mark every
tuned chip-select's DLL as unlocked so cqspi_phy_reprogram_dll()
reprograms its specific taps lazily the next time it is actually used.
If the one-time resync fails, disable PHY tuning for every tuned
chip-select, since the failure reflects the shared DLL mechanism
rather than any one flash's calibration.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 10a393105ca1..e4a06ef02d44 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -4076,7 +4076,7 @@ static int cqspi_runtime_suspend(struct device *dev)
 static int cqspi_runtime_resume(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
-	int ret;
+	int cs, ret;
 
 	ret = clk_bulk_prepare_enable(CLK_QSPI_NUM, cqspi->clks);
 	if (ret)
@@ -4089,6 +4089,31 @@ static int cqspi_runtime_resume(struct device *dev)
 
 	cqspi->current_cs = -1;
 	cqspi->sclk = 0;
+
+	for (cs = 0; cs < CQSPI_MAX_CHIPSELECT; cs++) {
+		if (cqspi->f_pdata[cs].use_tuned_phy)
+			break;
+	}
+	if (cs == CQSPI_MAX_CHIPSELECT)
+		return 0;
+
+	/* PHY_DLL_MASTER and PHY_CONFIG are global; resync once, not per-CS. */
+	cqspi_phy_set_dll_master(cqspi);
+	ret = cqspi_resync_dll(cqspi);
+	if (ret)
+		dev_warn(dev, "PHY DLL resync failed on resume: %d, disabling PHY\n", ret);
+
+	for (; cs < CQSPI_MAX_CHIPSELECT; cs++) {
+		struct cqspi_flash_pdata *f_pdata = &cqspi->f_pdata[cs];
+
+		if (!f_pdata->use_tuned_phy)
+			continue;
+
+		f_pdata->dll_locked = false;
+		if (ret)
+			f_pdata->use_tuned_phy = false;
+	}
+
 	return 0;
 }
 
-- 
2.34.1

