Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012032.outbound.protection.outlook.com [52.101.66.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CB73A1CF7;
	Tue, 24 Feb 2026 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771945771; cv=fail; b=qk90yyKR2U5lBN5RNEzJatYxvzoXC7R/6tgySLIQT7mvhEur67dnHGKTTKralFkH3XSS2wsV9oSy0ZDZcVlGKmXIGQHh2MwUXeAK48uSiLLLvkmXDjQrjilICGd2khYFHb5Vu0G1UInKUWOSHTDrjWitzk4RtAh40re9Timv/Kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771945771; c=relaxed/simple;
	bh=F4/X0CLUJmcBBqJDl0fhtqg5qRE2q/Tl6vrr2ps9zOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=JnxqPtiDQGh/gVnvk9YCfSp2dC2+cYsXpPipwHrnStIWunzaRHKEDZXxR6nDvhZdXelkbpBYPCnubaPRo0tBYps/ibz5ADPTiY1xbn++xJrcP6neD9gOfNQn/84cwMAPj8+rtCSztcZRTmjCNUZsBW+aez1UdWmxkZkDKjH0TJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Bt2R4phn; arc=fail smtp.client-ip=52.101.66.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Bt2R4phn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMO3HPsRqn0EPr9t94kA4U2hsyQZk8r07z2BlyPBhoNnpzedqTkqPcG6rrON4GAKbaCglHW5EZTskk0LWrPczCW1CLW7aR5J8wy7q6kuzTJEnyyx32uGQOdxwkF/inHAXq53gut4H5AF/Uiw4zLTFd2p0cpABRmXR0ONs2MpeXffrhrvr5UsP8kntjcJbZlV/6+YzAe4VR2NpdSS37tvJOiSrdPdQcE2UJPW9tQnSaAs6GUCSi3uQjWkJkzBhwv5fLnPG2RTlG1YiIoME+HSRf+Vv4+4k/6aNSCJ3raouPMTRtv6K+nGc0MOXhqQyKPP87PMQfFogrQlRBU1rG5/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8L09W996mg2QgCyJW4Mq63ohsHDJs+G1GSUTU+1jgM=;
 b=viJSZkqN8jiNP0VLqxL8UqVgevdf64WzbDoos7ZmwLdRIFW/c1bn9vX1nRIUi2+3dS0hLWZboKjwaxNkY7InVrQcqLro/ynP4voS4WqRLtSF7srFRBIBb2kTTOB4v0n/8kjVhYbRjAVXxJZ8Wh5TQzkUu3T1R5W4MFEFF39jA/01lvhJY/UbmzOwBVKRVlWE3FzUdumQbWIhXj27LAAYrt4716A00AyUP1/UPVIxXJMpvfj5a5UoMzhmR8OOnxvFej8NbJJQMqBNkUQSTUed8PyMdkX8gpBniq6nECWKMBTHEQquv5svpPx2Hdc30xSF9eDKqd2AXy2q/0ZV832k6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8L09W996mg2QgCyJW4Mq63ohsHDJs+G1GSUTU+1jgM=;
 b=Bt2R4phnm2w08jrYgG0r8K+DQ9qGq/7EEhjqHQAhykuhMJiw6OnEBGR+JxsIFPFK8AUvX96Zrv2wT0YY7L7Ro4P+kpDG9SbQaQzWXz1C1FW5DnAqrFaE17tVhGGKEfX7ASZd+os30ij81+AKFpGdcgNXH0f4gvdc8TXuxvPsNqoN1In/pVgqeFFRFu07MtXxurp3jDRQpCz7rbaW2whN80Rzpfg6Dp9207pVp2eKOUSiYv9ya0CbszUdpBJKTg1bASCInZLQfxN+8h7K9Kx6Gu0Uj5MEzcyUgB50WUq/uq5tTszmDV7+sHz93txAKJ3Q+TorlC7ikZgsfQk9duCWqw==
Received: from DU7P191CA0016.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::26)
 by AM7PR10MB3157.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:105::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 15:09:25 +0000
Received: from DB5PEPF00014B98.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::e2) by DU7P191CA0016.outlook.office365.com
 (2603:10a6:10:54e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 15:09:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB5PEPF00014B98.mail.protection.outlook.com (10.167.8.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 15:09:23 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 16:11:39 +0100
Received: from localhost (10.130.74.193) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 16:09:22 +0100
From: Alain Volmat <alain.volmat@foss.st.com>
Date: Tue, 24 Feb 2026 16:09:22 +0100
Subject: [PATCH] spi: stm32: fix missing pointer assignment in case of dma
 chaining
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260224-spi-stm32-chaining-fix-v1-1-5da7a4851b66@foss.st.com>
X-B4-Tracking: v=1; b=H4sIACG/nWkC/x2MQQ5AQAxFryJda0KHEa4iFhOKLgyZikjE3TWW7
 7/894ByElbosgcSX6KyR4Myz2BcQ1wYZTIGKsgXRBXqIajn5gjNS5S44Cw31s67tvLczC6AnY/
 ENv/hfnjfD568AihoAAAA
X-Change-ID: 20260224-spi-stm32-chaining-fix-5363946e7f3a
To: Mark Brown <broonie@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Clement LE GOFFIC <clement.legoffic@foss.st.com>, Antonio Quartulli
	<antonio@mandelbit.com>
CC: <linux-spi@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Alain Volmat" <alain.volmat@foss.st.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B98:EE_|AM7PR10MB3157:EE_
X-MS-Office365-Filtering-Correlation-Id: 646f38e3-19e8-463b-0fc6-08de73b6b1c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGVkY1hLYVlqYWYyRENIVGdXM3pWYUVDUUpvZ2ZVSjhmVjFIOFYwSWgzaTUy?=
 =?utf-8?B?WUNJbkdKa2JiazRFZXBPL1FqWk5sMnJWc05vQWNGUnVsOHdYMm11SXU2VVRj?=
 =?utf-8?B?R20vUXltSno1bS9waFBsc004dUpja0FuMkFSOUN0OGgrcHRQbmFIQzBqLzBR?=
 =?utf-8?B?b2NhZnNsZWlPOGQ5U2NBZDhuM1FvejdQQnNNOWhBajVCV2JiUVFKQzhTbGdF?=
 =?utf-8?B?b3V0TGlONkdvbWovcnRXeXJBQ0FRUnU2dllndTg4a2R6b0d1TlRiR2h6SG9V?=
 =?utf-8?B?WkJTSjJqWTVRdkdSRVNTcGdrM0wvUUI5WjVQMTZxVU5IelljbldtakV5a1d6?=
 =?utf-8?B?U29qdHN4MDcvbkRHVlFwQXJqTnZPU3hLUjArUXViVW9kVk9LSkVtNkZEQkMv?=
 =?utf-8?B?NDlRZUlMcDBLd3ljVjl6SHp0TnpMNENBWUwyOWNmVHNNcFY5d1RMdk55WjRu?=
 =?utf-8?B?Q3dEMGs4NmdaUXJJV2JmdU5UTjBRaEdqdVdtcWNzNDBPNFNuamR0S0hPeUdk?=
 =?utf-8?B?L2VVNCt4UlZxcGFwVVArVjA1Y3dhOWNIb0N3MUlTZnVsL3ZxSXI5a1dFYkxx?=
 =?utf-8?B?T1ZBa0p3Sm0xZWlZSWhEUzRldDlPMlZ3QklXUGhERFNYWllwa3lid3FJajRE?=
 =?utf-8?B?dlhDc0NPSWVMKy95YndkUnh4Z2EyUmswTlc4bS93NTlmckJweFdYWWt0UlV6?=
 =?utf-8?B?NE45WCtYdUtKNzhWYklXR21PM3FLUjcrZDdydTlzcjNhZjUzRjRRaGdUUHBO?=
 =?utf-8?B?NnZtYllDS25QRGxsazBSSkJvVTVwR1IwUGJMbHdnTUJzdzg1SUlTMWh1dS9D?=
 =?utf-8?B?Z0RVMlhudzNhVFNOZWY3dFUzUys0R1l2djd2VFd6UnU0elF3ejVxcDg5V3c5?=
 =?utf-8?B?RytXbXNaTHNSajVUOXJjTWdlOGViM2ZWMDRhNDFCcXRIdUszcUx5YTk2OEU3?=
 =?utf-8?B?d3hQSzRJRmM2OGdJYkxidlFXNXh0dUNaTWE1MXhJTFpRYmxNL29mSExUMjVz?=
 =?utf-8?B?SFEzMENPUEZ2MWNzelF6OUF3R1BKNXJJdFJXSTFzV0x6ckFOQ3FtakFSdS9z?=
 =?utf-8?B?eXZzeVhkdnkrb2tKMzUwanM4VWhCV2h2U2QwSTJ5VWo0N000OGtYaC9YT1Fp?=
 =?utf-8?B?bFdRa2hzV2tNWWN1Vk1pamhjbEpjR2F1bElIM0lMN3ZMcDM5MEMzdGRkbEpu?=
 =?utf-8?B?SzQxTXJSU2dieUlqNnBHWitHTHdPaW93N3dGSjd2bjgyeVBnZmIySVlvUVZO?=
 =?utf-8?B?SWs0WUtzajVudEhuYnZEWTBaMG4vRmx6dTZwb01ES3dDbG1GTTZmY2dZZU50?=
 =?utf-8?B?U1RZRWpCUmJIOGdkSlZjeFdVamtSeG5NaThSc1hLR2ZaRVdkdG9ydnpJSXov?=
 =?utf-8?B?UEphQ0U2M3hsSGFaTk1sejV3YzJtQW1reDNrSEFxaGVITGFMZHJlSFdkZkEv?=
 =?utf-8?B?RFRLYys0eGxBSzBLMnB2eUxjUEhQZEtMMXRKNkxEUVovMkVNbHBjbWdvdnFi?=
 =?utf-8?B?TWFBV0c3dnVmZno4eFdsTFJSZTE5RW5EUE41ZUQ2UkxudUhmOGowa2JqRXJ2?=
 =?utf-8?B?MVhPd3Bib0FwYmowUTFLM1Jqa3JPK1lBdEVFbTlSTFphUDdmaUh1VVhSWnNG?=
 =?utf-8?B?QUIvaUdScWxMN1Y2TlUzNHRwdlNLSExybXJrKzhiR3dLbDdqZWZvWlllb2Nw?=
 =?utf-8?B?eFRISm5SVHFLUkkvR1VWcGtZNi9Dam1rVGVjMHA2U3B1cGQ3TWR5b2pvU1Fa?=
 =?utf-8?B?T0VsNE1CM1k1OUhwOGNGYkloTXhmcmIxYndwK0xRaHp3MEZNKzdIMXVhYngr?=
 =?utf-8?B?dUgyVGZYbmhvemwyQXllODJZODJQQWNaKzVkdURZbkx0eDVrb0szVGZveUk1?=
 =?utf-8?B?QzRTSmc4eGw5ZlRvbGswZmNLa1U5TFlkSXB3Y045UTBUOUs4a1d6RHpGWVBF?=
 =?utf-8?B?NndvczU3KzcyNjAwMWVFZnZvM3hySFYvQlVwNVltUDR1R2tRS2tOTTMxYnZB?=
 =?utf-8?B?dTI3VlVCYnBLS1VMTy9VMkpFR0YyNmRTVjJvOEc3c0N3Mk41Q0Jjdzc4MTJ0?=
 =?utf-8?B?a3l5MldoRlU5MGkyWlV0WlVrT0dnUmd0SkllU0RoVWxEUkhHb2IyKzh5bkV1?=
 =?utf-8?B?TnphTUVrRzdpYjBLWEJiUTJOa0RmQmJGZUVtOVBLNTRpTUoxYXNzUGhETHk2?=
 =?utf-8?B?czRLNDdUUkUvbExZVDlHM0lNWmF6S29rV1dvQWU3MlUvSC9QanNjVHZ5N25S?=
 =?utf-8?B?a3ZnbXltN3hqS0dhc2V3aGhhZG1RPT0=?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iHE2B0CV5PzihKjkvNPiouLRJcjeRjozk4bXDMYoPkLykfplDm8fXm7LbnAqDCtll1Vz1121qvylHg0PpJjG2ONlrRX5IEXkzS7WBi2KofDa55I0/jEubeCgNz8rNHDXbRe7gS8BqKiSQZU4REIkmO+u9/JjEoH1PQ24xnyuaYcSQJoA63bClm29cxL1Z/YbGQrkZcT9Hjfb/HcZJ/eYogruRoEMOeHTY+LGbD0pwNquVtig1wu66Fbalsc7zEvF/v/RqIRJckcEu+rrUxnBpCNiBIwWpwYDw1g+BnPQiefbV54ztBGBLB59tjzvlskKAJMzlckWiXSzakUbFluleyO9emoJyirizk1p/nfsTfkL7l6CSaFxwYGnvnSTYe2gjNyLIMQahgqEeFU08ogCqsbvqa//IRhLQtQu6oCx1YyEqoj2vQiUXW328NaQXKjV
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 15:09:23.5387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 646f38e3-19e8-463b-0fc6-08de73b6b1c0
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B98.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3157

Commit c4f2c05ab029 ("spi: stm32: fix pointer-to-pointer variables usage")
introduced a regression since dma descriptors generated as part of the
stm32_spi_prepare_rx_dma_mdma_chaining function are not well propagated
to the caller function, leading to mdma-dma chaining being no more
functional.

Fixes: c4f2c05ab029 ("spi: stm32: fix pointer-to-pointer variables usage")
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/spi/spi-stm32.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index b99de8c4cc99..33f211e159ef 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1625,6 +1625,9 @@ static int stm32_spi_prepare_rx_dma_mdma_chaining(struct stm32_spi *spi,
 		return -EINVAL;
 	}
 
+	*rx_mdma_desc = _mdma_desc;
+	*rx_dma_desc = _dma_desc;
+
 	return 0;
 }
 

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260224-spi-stm32-chaining-fix-5363946e7f3a

Best regards,
-- 
Alain Volmat <alain.volmat@foss.st.com>

