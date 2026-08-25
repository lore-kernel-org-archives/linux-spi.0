Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DA71E7C2E;
	Tue, 25 Aug 2026 17:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678308; cv=fail; b=m9T8+pC+X7vSFpmJNx6m3WN6c5wEmhEpTRI8ZLh0P19pPDVI8jpxKGaLt7V3yPrfe/sdGaxVbt2uZUBFEPgajVYx8VtXy38sVuWk4+OlWyPI3hs+X6ZtRIDHFZgw2PI0Y15iD9liejjpOIxbV2a4UVj+PkJPfnOegCdbdOe2zEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678308; c=relaxed/simple;
	bh=Giwx2rrKgzNyerkKhGTq3O+MTCPxEYB1i6Ue4uASltM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTD2Mp7KhQP6tWeVukC1KEbG1KVSZPHMyEs4KzctbDLid+Jx0tb9C0aB6fn9JdNOCam6jbCAg/QrSuIZhi7JjWUDzlfZ+ffKi7WjFvEEMJNeJ5bxRR/thrcA5Ctxbehtepb3Id3moozXZ8RdBb8tIojTIuqqoa9v9JLLFVnOHVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=kcfXD/VZ; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OHAipiiI; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="kcfXD/VZ";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OHAipiiI"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67PEVaa31165296;
	Tue, 25 Aug 2026 12:18:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=7PUSFr1CMLSKJQSYJa7YNC3gotH2wPORpfsTeMcMs
	DA=; b=kcfXD/VZbJd7jxa8OIoQ3oBsH6ubGXXPxkbnLNProErsJN/5rvFJmKYvL
	vK6Uz0fGEWZlYPqLDSxAddOa/AKJs3hH3fnTL/GFn7mfzh+tMOOmNPF1RJs7URac
	eRdXStH98TbjkIOUjtamIidBowuaK+/O+eqfWh5PlSgDhgKPdP9MSO8IBDplxy6g
	yzZOeZ7JTDI45oNZrm0gGz5Wtv16+Blei/y8WPwwaHIf9vGVBvjz4+oDohe4UHDv
	hFeQNGjsw/mGMUIrbV1HT+E1PJus4aAEXC+ihU5NEiErVbBScUecPVL5Ihry+rQb
	b0WNuKk2pQ9yVKtlukFmxhcmFOP8w==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	by m0384305.ppops.net (PPS) with ESMTPS id 4g91sxmjeh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 12:18:14 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phi4/NxKm8xRq5b6wltlL2AomQ9sLzslCm7g7u7Njn+/D52SiMfvKgfu/+V6jj1NjJA0+YSuh/wlk3PKtm1egqxqUrv327EG7THl1Gji+U+XY5doDBLm2h10Xy7SztxRk912SANhHW91FuCE+QPNSb7a7NqaO+7vKEKSsw0NSt5d61NCmFRlMEj/ExppM6bOCzGi6n5n3raxBerVG0JVBN04Db0IDO5gapCRLw/PK7GX624ZRGyHi6liZrBDlkCt6/hmSRpkHhlNNhG+UKTPjy9adfOXnQzj/vqiba4J+GedeEfzkHtfdAjMchjQ3z4jIxM0Wo2WM3RXopb/fD+2xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PUSFr1CMLSKJQSYJa7YNC3gotH2wPORpfsTeMcMsDA=;
 b=LJZPC83bp2c809nWNBNgGHRgh1J3H9vpwXyE218LTTtRdTmy+A1UcW9at2ee9PieGOFEi1ti7C/kIXY5wadCNlZESmJs3RQzT13XHTpf0sUcUBBIm12/ueVGZ30FnYzxoMvL1q9/47mQ+4/CYL5f+epnKOjo2hbNDCN74L9LLzaL0Shh56k3CHzzEfEhV5xAbpdFUClNtu8Ak2W6cBCunp/kl3CNm+cnhw2uONBGRr363FmCrd/IIBLpuepv1yRanVGfuSQCN8QEacygLM6ycKCTohTZWl//ADGw6KT9LXM8OJhwBjNqslv5zmIynibN2CqqBBvJTk/wUjtDPcZDZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PUSFr1CMLSKJQSYJa7YNC3gotH2wPORpfsTeMcMsDA=;
 b=OHAipiiIV4b3vIvBxdH8EpWxA3N+xx42BYpuVyGoc3rSUNztnINXhiPAYzapGWZs9pRXp208Ya1RWkFXRhffgAgjYaIXaY5gdh59HYKgasnL8tjjL8VQxXGj2yHj5PkdZ2CaBInzaB1iIxzwOqaGRnBWutCwBH4cN+khP7PMNuM=
Received: from CH2PR11CA0005.namprd11.prod.outlook.com (2603:10b6:610:54::15)
 by SN7PR10MB7073.namprd10.prod.outlook.com (2603:10b6:806:34e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 17:18:10 +0000
Received: from BN2PEPF0000A801.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::7f) by CH2PR11CA0005.outlook.office365.com
 (2603:10b6:610:54::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Tue, 25
 Aug 2026 17:18:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF0000A801.mail.protection.outlook.com (10.167.245.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 17:18:09 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:18:04 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 12:18:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 12:18:04 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [10.24.52.55])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67PHHf3S1436664;
	Tue, 25 Aug 2026 12:17:59 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
        <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v9 03/18] spi: parse spi-max-post-config-frequency-hz into post_config_max_speed_hz
Date: Tue, 25 Aug 2026 22:47:22 +0530
Message-ID: <20260825171737.776052-4-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A801:EE_|SN7PR10MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: 1002f0db-8f89-4afb-2005-08df02ccd5ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|23010399003|376014|1800799024|82310400026|921020|6133799003|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ZLnAuwuwmEHQ0qpH3O8zOhHAKWDsULT2u7Ws6XYKgmFeukrHEO3Nety6nH0/7oGtzUynbm38kMO68WG5GWx+T5DqTrHpPREG0yvTcGHqXmmSo+C9SiWSTy3jOK6Ijx+lOoQa8NaGeYpCka+V5IXjxUYiLSv9ahALGJayKlSAaGuAYHKCN1NqhoBjJKgdtxSSgP9GnDpGuByPW6nIxTlW7CrvXC0Swow1pTuNcWe/URgav0P7DiieHrIyIsDBfsYeaFa5LYtxkAD1Q1k7CDUjo5QwsJuOEfQCa9/Vw/FccpagIiaL+bt8JHs7GHnVeeW4pSpWL4li9NAsaX+YfW7tqMIoFPjThTTtjfGGppiXTO7Ufn1QGC8F0KSx03y5wFkdiDLbO8Tc4I9oReo6YeE5zTgnaMn5HWNW0+V8Cvs35E8L8ZswZp0C2px5PP2/i41ZoOYVLEqM6dnbHAEW3/GjYQnBceq+OTmt1EK+9VsVxjGFGtWeFcsJmdku/qebpFh0yq69S2MTjbMXb1e3adRuqdpdvvmUf8L9gZk5yTMrE+EXWE56BhjUc0ntLbuhobkIR4BDC/QAf4iOMFqFSIdz5JcjG4NKic5r7MANky8FcbRRzPWmDSvy5089K2QXAJ27Kukl69souGHqkr4koPnahfDI1pT7rUQ78hZa6GvSWq44yPjWr3foQ8djDF578UYfgwmY19pIFYAZEN7zF0nh8sbqn64iVAaXw8+IB2Skqz9teyCyfgPMD6olmvET523/
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(23010399003)(376014)(1800799024)(82310400026)(921020)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0FkYCIx76gfqKBsusitQKvRsjLBmh7SgNyjcBkBHEIKcZYNuHRAE3VOPi9cwRYeOKaqT4RCn0/sCC+s0FCZZsDYl7uTNEDIEmuoaIrnlr6NkdAzmBfn8XAr1yWudUBPzim3tOx47uXZ9uoktky6+Rg5MfcK2yk+4JhtlejqiVd1c/BFVFHqIRjIW1ngczlMBkGjJlxcWEJIhA8ov9fx1kWh1Gqa69iFD8ErzDK36/biWjravo1BWrtz9tv8ayBl5TsYO+cAwMXrv1N4IOHQUVCYXPhEqXfp8vfvljekYSxc+Prw5YYt1zq8xmJbU3UHnhnzC9541Zma8+E2QtYDoEqVyB/6TPlwwLve2vhE8ZeMEIhAB27vCsr6YA6HxLZ5D2lnfQUjqkfREFg3GIWCxGOXTh70NMSBVOGnwQDwcx4Mkpu1r7B/ASZY2rOmM6riL
X-Exchange-RoutingPolicyChecked:
	A1c9CRaeWKIn3NtH7IpT8EcUEA8NBaCPh6VVUZnB4n4Eyd3dgpqQKeGVbM+zerUIFDnA8HKGk80EEGRvTvAVQiRkheRZXVYlYDUVD3/0bk+DJfeG/LTffv5AhlzGm1L9xLztVSEw8KlE9oYAo3rtjVkIxg4CcyKqCFP16KGs0a166pWFUGoO/CFix75HZwqmDKQsozRrNN9t7FoANGD6iOT3w/YGquCU5coqyna7JeTQyaZoWpCCtBkRlsEDiT0l3ldAj0ZfpXTrRuCqQICTGhQKpgq1lcUhhs/Qqv1du1iLvinf+1ODJHmVEXFNC7KNDuagHDpkzEd6J4mN/2Ou8g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 17:18:09.0212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1002f0db-8f89-4afb-2005-08df02ccd5ad
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A801.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7073
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfXwW7V3dZDqHo1
 f/zso12aikOWIKlBB05EHYUNAcQZVJLenjYP6n+EnyO/eXoAWf3UMGmiw6JL8jHqtCRDNUFTerN
 3iTQwEdZitce+ByD/TVvL8Sj/N0Dz5o=
X-Authority-Analysis: v=2.4 cv=HackiCE8 c=1 sm=1 tr=0 ts=6a8dce56 cx=c_pps
 a=5LsHMtEjVXEroYtotTqlkA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8
 a=2Gi1gDZmOG9PIfG5304A:9 a=O8hF6Hzn-FEA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: 3yV3uprh8V4n7l0xZapfrH5wS3nk4_gf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE0NyBTYWx0ZWRfX2dePzxexqpZO
 RY2wcMYbj9XvWXsV79iWGanuKSui9HgnZWgj0jijkBlLgkn8+EzNqEMK834vgyGHkCdYdx4Sc8u
 +xcQcxnLF3ONXbA7ErrlousYpLfpERZyWE7drUQMuVZQkddPwVDXu2SqJ1zKHarH+43eSxOiliG
 6IN89OfZXkg/fd8dKOqojLtmNLPp3ENalr30kBB5WtDsISzDpTKG3SQBiKLhGq5ok9P12DAuBSG
 db5rvYE+qKiNNJJQBG7qR8vURhc3w+2/Ie7a6YZLXUI+x2qhHv/zHbkqjKu3MkFmXHmF12CWao8
 W/H9cT79+DLhdCF8h1iqdPxePK2P5U7G3i3roLCIY11ji1i9Wf7XL4DjHXrYC3oMXWaT811Arza
 0eiSpHXKOysYaGk3BXQHxFIA72FHYUIczXYZyonhgPqfzVff5Zg4wDMTYoFor9Cq//VI3rBC9JG
 0db70puZ4kFqyUySYHA==
X-Proofpoint-ORIG-GUID: 3yV3uprh8V4n7l0xZapfrH5wS3nk4_gf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250147

Add post_config_max_speed_hz to struct spi_device and parse it from
the spi-max-post-config-frequency-hz DT property in of_spi_parse_dt().

This supports SPI devices that operate at two distinct clock rates: a
conservative rate always reachable without controller configuration,
and a higher rate achievable only after controller-side configuration
such as PHY tuning. With both properties set, spi-max-frequency gives
the conservative pre-configuration rate and post_config_max_speed_hz
carries the post-configuration target for the SPI-MEM layer.

Zero when not set, preserving existing behaviour.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi.c       | 2 ++
 include/linux/spi/spi.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5b5b3bc5f0d8..6b01ddb7cc32 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2800,6 +2800,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	/* Device speed */
 	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
 		spi->max_speed_hz = value;
+	if (!of_property_read_u32(nc, "spi-max-post-config-frequency-hz", &value))
+		spi->post_config_max_speed_hz = value;
 
 	/* Device CS delays */
 	of_spi_parse_dt_cs_delay(nc, &spi->cs_setup, "spi-cs-setup-delay-ns");
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 88d17fce02dc..02fd602f29e8 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -141,6 +141,8 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  * @max_speed_hz: Maximum clock rate to be used with this chip
  *	(on this board); may be changed by the device's driver.
  *	The spi_transfer.speed_hz can override this for each transfer.
+ * @post_config_max_speed_hz: Maximum clock rate achievable after controller
+ *	configuration (e.g. PHY tuning); zero when not assigned.
  * @bits_per_word: Data transfers involve one or more words; word sizes
  *	like eight or 12 bits are common.  In-memory wordsizes are
  *	powers of two bytes (e.g. 20 bit samples use 32 bits).
@@ -195,6 +197,7 @@ struct spi_device {
 	struct device		dev;
 	struct spi_controller	*controller;
 	u32			max_speed_hz;
+	u32			post_config_max_speed_hz;
 	u8			bits_per_word;
 	bool			rt;
 #define SPI_NO_TX		BIT(31)		/* No transmit wire */
-- 
2.34.1

