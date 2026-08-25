Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570E42066DE;
	Tue, 25 Aug 2026 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678391; cv=fail; b=DF7vgvchLGHmciA2kK2L6r84cpVrb+HczwpBj6KWf4FLDmbgz0gyo6V4BEL1OfGp++N1KSB/nUvERgvJJGbywsmbBXi1RVwO4KpxzVu1Kmk/8joYmraGXgHbXVewxU4Vgs8mi7NX1GLqUVJt9zBi1fEedFAeMBD0fV9m7kjzEUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678391; c=relaxed/simple;
	bh=hkKco6X8wcjkLpa3L3D1CahX6KEUTNvfbinEZLnIRq0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SUDNQV+iW+vYJ1QPnSaoaFrIBz/736NXePNhQHfG2ldWHjOHKjRBC6GK5jE80AsC4N5qFqB4j5ghovZld4LNAmf7QC+0znKUOGKYvcpdb9+UQo5J0W96rV6H+6kxKTxpj7JXnTjT5mFcNJXfn7QrMst5jk3J/sgiTJPSV9tKy84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=ZuAk2COq; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=opJhW80G; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="ZuAk2COq";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="opJhW80G"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67PEUwp41882698;
	Tue, 25 Aug 2026 12:19:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=kvm3o+naurPZ5OIpAUyE9izGbqJYvxn5vIE9lIVKf
	6E=; b=ZuAk2COqTzvEnPZaHLeh9PfPiPExlxw4RVjYG3szjAUXTEn5ErzZzps4r
	QU5axpbtbEHjJnFeRuYsMqs2uZALecQM93++93lD9IkYfhDYlgVs6QaSly1rkFzu
	HNWFbZrjOoTIIBVq9br7hdfCLsg4ZYX4HLvmzELr9j5lfmXTMVRiaQMrGDoEeiO6
	52jwxI7STBzFGDSli7Fb4hWVSV9tHwh872s1tXLNaJfswA7gsrBQUP8V6sPYWMhT
	Y0DYVUyDfop+fuFfprMsg6l9MApKuBhz/cGdF8ee8cOhvVP3r55FntvmGHRLe09K
	wIDW3y9WqXZHsztAQ7cFjJD3VN82A==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010053.outbound.protection.outlook.com [52.101.193.53])
	by m0380145.ppops.net (PPS) with ESMTPS id 4g8xga5gcw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 12:19:40 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJeE3BBk5gxDi24RqQnDlvSVaEENi5AXQ8Z2BUpjhpDc4FMx3ed5rMwn9L+iNxIFJBsayjsGebSg18GjnXvOG1ok9ojKT7IJHeVRPL9fxXRPV0bpeC4E+fZjw4hAtAz94sCShDjGAGMfhnnMRyofJdyCoUrP39rpnRTOr+wroSPWu5OF0LwH1OmIvWzxFK1Ot7j5uDEz+edFpOHv6EhhvqeKC2RHR2P3orIZ4fu/1IUsnrNwyEVdp5dMJbiICP4LknHczN8PuEj5k2GkDxj2uDyO0RVDPTL8UCc2gOChOa/tZBPRjIXsiewFXEN3KiTJq8MFBtTPCfWbbYt36u7jLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvm3o+naurPZ5OIpAUyE9izGbqJYvxn5vIE9lIVKf6E=;
 b=oPRrDVA7a7NgrXOtOCu7sY7Bf8sXzv7PuBTzGr56mfvlf8ef0QK50XSABV9B+C7USWZRZ1NQmm20MuFmpUdm/tzU4UFJvMtpjEOh9gmMpcBvXR0UA7WvTd5tZqJuoJTH022rSPjH502EaQRHW1BoaPdbb1bFeEe5nXylOJN81vC7KCZF5FVNZeTK1TnBUiQt46tUaN6OH77Lp245NXwP4WZ9rWxACsgLtqxVZFEJiu1kLISAn23XjNRUZU2+yM4ULPJ6eN2BWsEX7yFxjouZ069OLPEIL9EMWQSr3sJVsDpF2c4Iz0z7PdUaCCpMcb1pC9xaiMruQt4hMXcSenK12Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvm3o+naurPZ5OIpAUyE9izGbqJYvxn5vIE9lIVKf6E=;
 b=opJhW80G8GbiN94omt3ub8Ax9ugt8Mzbcf+lhsT04i2xdfKimZB8w1tdusPe/jrQTVTlmLc99c/+D27e1Q60itm51X+yTS2Jf8kUsBEHkKxg1Cd9GLNI+ANUbzAIGa0V48RdHGQZUGFQZZcAUMSv9tAozUrBRhOm+M+l94zUn0A=
Received: from SJ0PR13CA0106.namprd13.prod.outlook.com (2603:10b6:a03:2c5::21)
 by DM4PR10MB6885.namprd10.prod.outlook.com (2603:10b6:8:103::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 17:19:35 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::6) by SJ0PR13CA0106.outlook.office365.com
 (2603:10b6:a03:2c5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Tue, 25
 Aug 2026 17:19:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 17:19:33 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:18:49 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:18:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 12:18:49 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67PHHf3a1436664;
	Tue, 25 Aug 2026 12:18:44 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v9 11/18] spi: cadence-quadspi: enable PHY for direct reads
Date: Tue, 25 Aug 2026 22:47:30 +0530
Message-ID: <20260825171737.776052-12-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260825171737.776052-1-s-k6@ti.com>
References: <20260825171737.776052-1-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|DM4PR10MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da89e7f-9607-492b-f2e3-08df02cd0829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|23010399003|36860700016|10067099003|6133799003|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	VUNU31eMgOuHpOJoqB9lL1jUA8lm6Ke7EFLKTDkpuLm4M2yBNr0zbmkX5v3cFjOo1+tWHcIDt4gLwAvMgkHCsyHr86RtNyLFSrRucFOgY4rv3GUzw5szCxZL5zz6gVtaFy5TOmSOE/6J57d63qIjvDpo/Jev4Cma3r8DhzC2hEHKKoFjBYm/m353JcFsGiGblwDAh0Gfyw2ltcra7orHZdGyKiHo5GQvlxrnMcaUPRR9bBMUQdmfvfcDvRARToJOs6ks8NRKICO0pTO+ooWNogSNA0MUEHaklx/Khed1uM9BZj8i1KilljFfMjlHt0km2K93XRJhuTdaOv2fvxzy+DHLxuj8p3Nzvv0Uul6/6BBru/3KiYYBqW0x8Q+6sBR8uzzYUKY9b4x7xrhohng0rz9Boc2ylw4Xqo4LTHcgrsSjH9Re3iJlOsm6NWC7VGbKuJG0madHK/dGTJV0fA3SiRH29ab3pwQPJnOLLX82zwBQH7qfHaPNhCKrDuA94REJNnk9qK9oON63ed5AcnzzjTTzXzTcP7/ZbYzl0U29Dpwa4y59lUWifuzQWZKn7SKZWoYs3rZ4q1ak9Cke4BC4Q3PKVlLjovHyTXprqJbiWJFs163uFtTqrnYCWy9LSOo2RWus5p5J02LjP2+uWlpB5VTBHuBz0W4uxH0Ft1DR28Mgvs2CaO4m+jEK6GcFQ/CGKyNZrLN8F2e7C5v8cWS+tLwsnJ1JP4Odhnk68HVPaIQGtpZcG/DQUQYogePknngi
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(23010399003)(36860700016)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fpVmxvn1BDTpqTF7eDy93jJ6npxUa51jT6ZQT/0gYO2DA1CnzmJxQ/rb+pEoVC4QLVcvN+Zxv+Np0alnKMAmvlE/ExUlR+iISKg2qwNimFm42CGr2l3UTc1FN1RlR0Ij+GPhp1tGExelZGVtdqbb2FFq5AOQ4WfmdVvGdisAqgtwr3zI0sadxs6ELt4n31lKsz614mEEMsTkqZBufwD0+lFR2/6u64rKjXPh+7vHMrAUPLsj9j/13LbwSd1/jUQssm4Ejze9Cx75BZQXnrpLaoH1jiC97f2zaYDDfezopJMKiRAH55lDjCn4IcQy/jtgvwbCYKppaQeSHXYSS8Dj2fsNTOGoiv+IYmrT3knwx9DljaoCwUwnApDUTU5wIe6mqBRXywqRr3pPy9qx3zWZAOeUZxeYL3BZo6E3JrqOv+lPw1ybk6UgC6GXvagIT0yX
X-Exchange-RoutingPolicyChecked:
	3wHjZQeAqr+RM0s1HlInNU3lMv2tlvss9YoO0kq808bJcAAgoSlyADfiJlFXJJg6ckzz85BEtiLBfsB9kfjF74YKCqCJcpXgBPOTdiaUWEwQz0URykheHvB7f1exAYI4Pr1SsqqnmWHrbEVL64q6mjF3u+b70lAoLBPxtOFwYiVit4l8U/8q7z28uTMyAudl6dUbFRE6GHJ+PRpaed6vSF7yJUTUmrpPaONg7e4H8jLc9dIj6WzMgc4UsWvG+EJtYuPRpZZe2XeXDBktDi2ENj3xUtK8A6PLrC0ZddE9H8DBUOre+anVcezs+ph5ER1yERaOt91RSP6kc4Zk/zKziA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 17:19:33.7054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da89e7f-9607-492b-f2e3-08df02cd0829
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6885
X-Authority-Analysis: v=2.4 cv=SuygLvO0 c=1 sm=1 tr=0 ts=6a8dceac cx=c_pps
 a=XYxO6LlR7Df2C67LKP0s0A==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=DtXw2DrE-T2x2gJjnU0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfX0aMdIY7fmNfT
 e3XFG2fLvp1d/9rZWz/QeUrH/GF+uZHY8SKUhsENN030eXa+yDc3D1ZIqRKxAq0FbgNjDeTxe+N
 ppsEkGCk+OCszYYVMCpFnbyN7Hr1QZA=
X-Proofpoint-ORIG-GUID: 2O6nBc9bqOMA67rjREYdLrtA0y9FF2ry
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfX4FNkrw9wjL23
 elhAaOUCjFIpVUzfxXOEWm9vJEmmrSmRt/75J9wGdHpazzyUflBr2RrW5Q3rlqHdSZAFS7ecDin
 WiYj8RCVdfgJS3jTtuFYR4lY0Pyt41nBUqudJlQEoH3DULW4AUlRJ+5QXXietqSk1fwMTjmaxiE
 hu5kVUVG7igKVStr1y7s8YmWy7CxfabCiFg8ACaduFN5JrOT+Lk8xIQWPHXefIwLrgJLbMT/dv2
 fb3FuAlq0i4KKg4wthls9yNnm2klVvKtwMRUMHvon47sV14SUm7dn1X50YelOVVKO7sZRkjdhZb
 EyOUK5E+A96XzDRT1e9keeMo7gezNFBBF/FY+iLup54Z+faYVUn811wt1MKxf8FW+PJ5tX00lb+
 fP7MdDmDITGltF2YKRGsiI6fE2md0xeHmecDEMUHHzFN5nKbhk318FC+Xdht8Y3uNAJLM/pgnGK
 M7DjyZdW1zsF+vXR5mQ==
X-Proofpoint-GUID: 2O6nBc9bqOMA67rjREYdLrtA0y9FF2ry
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250147

Add cqspi_tune_phy() to toggle PHY mode around a DMA transfer. On
enable: reprogramme the DLL from the per-CS calibration result when
the hardware values differ (handles alternating PHY reads across two
chip selects with different calibration), configure read-capture for
the tuned delay, assert PHY_EN and PHY_PIPELINE in CONFIG, and
decrement the dummy cycle count by one since the PHY data-capture
pipeline absorbs that latency. The original count is saved in
cqspi->phy_saved_dummy so the disable path restores it exactly,
handling the case where the original count was zero. On disable,
all settings are reversed using the saved count.

Add cqspi_use_tuned_phy() predicate: PHY is activated only when
calibration completed successfully and the op frequency equals the
post-config rate.

For direct reads, PHY is used only when both the start address and
end address are 16-byte aligned. Unaligned transfers fall back to
non-PHY DMA.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 126 +++++++++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 58bca15dbd6e..d38a0253e4bd 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1075,6 +1075,109 @@ static int cqspi_resync_dll(struct cqspi_st *cqspi)
 	return ret;
 }
 
+static int cqspi_tune_phy(struct cqspi_flash_pdata *f_pdata, bool enable)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	void __iomem *reg_base = cqspi->iobase;
+	u32 reg;
+	u8 dummy;
+	int ret;
+
+	if (enable) {
+		ret = cqspi_wait_idle(cqspi);
+		if (ret)
+			return ret;
+
+		/*
+		 * CQSPI_REG_PHY_CONFIG holds the RX/TX delay line tap counts
+		 * and is a single global register with no per-CS equivalent.
+		 * Reprogramme and resync the DLL when the active device's
+		 * calibrated values differ from what is currently in hardware,
+		 * which happens when alternating PHY reads between two chip
+		 * selects with different calibration results.
+		 */
+		reg = readl(reg_base + CQSPI_REG_PHY_CONFIG);
+		if (!f_pdata->dll_locked ||
+		    ((reg >> CQSPI_REG_PHY_CONFIG_RX_DEL_LSB) &
+		     CQSPI_REG_PHY_CONFIG_RX_DEL_MASK) != f_pdata->phy_setting.rx ||
+		    ((reg >> CQSPI_REG_PHY_CONFIG_TX_DEL_LSB) &
+		     CQSPI_REG_PHY_CONFIG_TX_DEL_MASK) != f_pdata->phy_setting.tx) {
+			cqspi_set_dll(reg_base, f_pdata->phy_setting.rx,
+				      f_pdata->phy_setting.tx);
+			ret = cqspi_resync_dll(cqspi);
+			if (ret) {
+				f_pdata->dll_locked = false;
+				return ret;
+			}
+			f_pdata->dll_locked = true;
+		}
+
+		cqspi_readdata_capture(cqspi, !f_pdata->use_dqs, f_pdata->use_dqs,
+				       f_pdata->phy_setting.read_delay);
+
+		reg = readl(reg_base + CQSPI_REG_CONFIG);
+		reg |= CQSPI_REG_CONFIG_PHY_EN | CQSPI_REG_CONFIG_PHY_PIPELINE;
+		writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+		/*
+		 * The PHY data-capture pipeline absorbs one dummy cycle's
+		 * worth of latency; reduce the count to avoid over-compensation.
+		 * Save the original count so the disable path can restore it
+		 * exactly, regardless of whether the original was zero.
+		 */
+		reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+		dummy = FIELD_GET(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  reg);
+		cqspi->phy_saved_dummy = dummy;
+		if (dummy)
+			dummy--;
+		reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK
+			 << CQSPI_REG_RD_INSTR_DUMMY_LSB);
+		reg |= FIELD_PREP(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  dummy);
+		writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+
+		ret = cqspi_wait_idle(cqspi);
+		if (ret) {
+			reg = readl(reg_base + CQSPI_REG_CONFIG);
+			reg &= ~(CQSPI_REG_CONFIG_PHY_EN |
+				 CQSPI_REG_CONFIG_PHY_PIPELINE);
+			writel(reg, reg_base + CQSPI_REG_CONFIG);
+			cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
+					       f_pdata->read_delay);
+			reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+			reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK
+				 << CQSPI_REG_RD_INSTR_DUMMY_LSB);
+			reg |= FIELD_PREP(CQSPI_REG_RD_INSTR_DUMMY_MASK
+						  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+					  cqspi->phy_saved_dummy);
+			writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+		}
+		return ret;
+	}
+
+	/* Disable path: execute unconditionally regardless of idle state. */
+	cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
+			       f_pdata->read_delay);
+
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+	reg &= ~(CQSPI_REG_CONFIG_PHY_EN |
+		 CQSPI_REG_CONFIG_PHY_PIPELINE);
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+	reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+	reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK
+		 << CQSPI_REG_RD_INSTR_DUMMY_LSB);
+	reg |= FIELD_PREP(CQSPI_REG_RD_INSTR_DUMMY_MASK
+				  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+			  cqspi->phy_saved_dummy);
+	writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+
+	return cqspi_wait_idle(cqspi);
+}
+
 static int cqspi_versal_indirect_read_dma(struct cqspi_flash_pdata *f_pdata,
 					  u_char *rxbuf, loff_t from_addr,
 					  size_t n_rx)
@@ -1525,6 +1628,14 @@ static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
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
@@ -1630,6 +1741,7 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 	loff_t from = op->addr.val;
 	size_t len = op->data.nbytes;
 	u_char *buf = op->data.buf.in;
+	int ret;
 
 	if (!cqspi->rx_chan || !virt_addr_valid(buf) ||
 	    len < CQSPI_PHY_MIN_DIRECT_READ_LEN) {
@@ -1637,7 +1749,19 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 		return 0;
 	}
 
-	return cqspi_direct_read_dma(f_pdata, buf, from, len);
+	if (!cqspi_use_tuned_phy(f_pdata, op, post_config_max_speed_hz))
+		return cqspi_direct_read_dma(f_pdata, buf, from, len);
+
+	if (!IS_ALIGNED(from, 16) || !IS_ALIGNED(from + len, 16))
+		return cqspi_direct_read_dma(f_pdata, buf, from, len);
+
+	ret = cqspi_tune_phy(f_pdata, true);
+	if (ret)
+		return ret;
+	ret = cqspi_direct_read_dma(f_pdata, buf, from, len);
+	ret = cqspi_tune_phy(f_pdata, false) ?: ret;
+
+	return ret;
 }
 
 static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
-- 
2.34.1

