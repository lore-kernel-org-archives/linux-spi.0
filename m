Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010050.outbound.protection.outlook.com [52.101.85.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA52136BCF0;
	Tue, 24 Feb 2026 09:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925114; cv=fail; b=aub4UFeEBIBjcjTPl8372bmSksTSlNPDq08ZEnBaRDT1QmCWapRq3WRmwTEVzG5YPcPCBCQTo2bkHgGsjZx0IO4UNAZOl+H27pot3e7dQ1QGFKXepNVPJApD1+clAa6ILYDcz51uCDTiLCoTkoO68NEq4egViNNt78iy/XA0SMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925114; c=relaxed/simple;
	bh=3QQCCM1UipEVTgiLyvQHbuhxGVSUNaesVtLszLPrRtI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BpwHSydKHtsBPkGp36Y3BEFWU2/4O687/iKeQLPiLLlVuRAZv87xElUXQD7TrjuueiWmiOK5S9VP1nENamFQtzDDNrkL4dRiW/iWzaIMyAsUpDADNisPyNmDNg7ueWGgA4Sw/o/Ac+GY/puq5mdGT8wPiFptVTD0T7ocmiJv15M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VRCYetFX; arc=fail smtp.client-ip=52.101.85.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VRCYetFX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHofVGV3KImmG/C8rsj6zJ9wRCXIsIPWWjB5cZE/zxI53kH2+riPDh79ZXWQm5ElOIYSpp8Inim8cmrUzafiNc6Kg8S9/LDaXuu2SK8DxJMuOyK408czo3aandzthy90vu6PSCJo58Nq2ovXibQ9EC4Y8joQpWjj47Uu7on6AMWSLIY0JEoLqILIWn0eMQhtV9Wp+8NVx8vGmezDKCNnF3fr0wz+dPLAdPWiQFQtndjZDHqgul82/Q577kyBVx/IDEHQpFOdFmiezFZbTTi0+mQHhJdpm8aFP+SZ6sVb987fQ4ZBUiZpi/qVIG28g84UKPEf9gF43DxAvzBwg3aPNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jy80q0mBqaB/iS2mI3iDq4DUPT+Yt5krfQjLm625UAU=;
 b=VCFH15aq0K9JJrMkvfEVCNWiRJeji/IfFXJHdiK/j0uW0yWCeC0TLary/eBBCyZNKpfPlMgmSOZJVzRrLQW5y0a7sKcLFQjF4Zm8IvZ6OhCscEI1yW2P7uKz0wRd5+kJb0JQ6QHMUoDNc/BLZNS3MQsaaLyRLEk0cWGyYs8zQg2yvgatoEOSGbPiryT3B2LjT4vCyxRAob1wwyIRm1vxHo6icqiNp7fpHwq+HyzwWkA2NIFy8PjmMsmr3cWlMcCkT20CPwaP+R10KWwjEDasLmkvNWuAmwGj66DxlZocv0xv3qMMjyz8vKr200zjfDYK7iYqMTjldUAXVAktIX03bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jy80q0mBqaB/iS2mI3iDq4DUPT+Yt5krfQjLm625UAU=;
 b=VRCYetFXUehQjPz8F4nqAdxmHvkpxSLEm26mqtjtCWi+NpybEkfc02Mm3nHHbtO6TReeEmQYpEjCbFqf/Ip3fSX79eUBf0f+C6F5iPqAjRaFacePOj4eqyRJ8sqLlmXEIX8yGLSos2xO6tcFSIs6zy4jrdqc+dLJD/aX8dKnJSzOpxPxzPgmwnR6zuq+ezEAzo5FBPguy3pbHOHyCIrnNzJQK5U4gp1GW/StETlCSUZNybNCnuMGu13ZAfQ+lu4Owkz67iNrISzp40GGB8KDw9w/Cc2syXQUcVIYSY706F99MEvQsN8sz3VY7YFKsazD3sRYVBAU6AQeVeLXwDM2zg==
Received: from BY5PR13CA0030.namprd13.prod.outlook.com (2603:10b6:a03:180::43)
 by LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 09:25:07 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:180:cafe::df) by BY5PR13CA0030.outlook.office365.com
 (2603:10b6:a03:180::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 09:25:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 09:25:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 01:24:55 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 01:24:55 -0800
Received: from build-va-bionic-20251122.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 24 Feb 2026 01:24:54 -0800
From: Vishwaroop A <va@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<skomatineni@nvidia.com>
CC: <broonie@kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <va@nvidia.com>
Subject: [PATCH] spi: tegra210-quad: Add runtime autosuspend support
Date: Tue, 24 Feb 2026 09:24:52 +0000
Message-ID: <20260224092452.1482800-1-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|LV3PR12MB9411:EE_
X-MS-Office365-Filtering-Correlation-Id: 63886b6e-be46-4626-3d10-08de738699b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1ZzTWp1TkQrSXFCME5kZVhwTU4wdlFsSm1uNlphMjJKbXdMaU8rMzdrbjBm?=
 =?utf-8?B?b0MzekR4Ni9PZ004cVlnT3JSUWdiR0N3QkpyRG82VCtBenlsSVpkZkwrWHRJ?=
 =?utf-8?B?UDIzQmVCL1E1QUtuVitrdTRHc1FuVVdDZHk2eFdKOEIyUzFZdlc0d2g4bjFL?=
 =?utf-8?B?b2xJbnVuOWhBYWp5bUdvbjFuK0NQRlh5bkZMOXlNR3RJaUdvWWhlQ05GZTd1?=
 =?utf-8?B?Z2U2VExtUGV6MlVrcjBnSytUa2UyVG5lbVFGd1RUdzFBSG02R1lhM09YZlAx?=
 =?utf-8?B?UDhQaEZkbFVSb1lPR0lKb21DM0tvSGRocGdNMnpveWoxQTdMV3VKMVN6dEJJ?=
 =?utf-8?B?QTNXT1JXK002RmNFaWMwcVUxSytJMVpjc01KZk16b2FaaTNlUkowLzJpYXhW?=
 =?utf-8?B?NmtaS0h5OEhoN0U4Y0ZxeTFlQlZ0OXBLakNTU2VtNVpiemlHdW9YMnZGdEFZ?=
 =?utf-8?B?QUVtcDZMZnJQTGJPMVZNcDhmYThNb3hFaUZmMXdLWGd4SUU2eGpHYURSY2Ur?=
 =?utf-8?B?Q0QwNkd0YnZsOWhpOUlhTFVxYVBqVVVuUDlkeVVVR1RyT1NpOHhGV2xFTjRq?=
 =?utf-8?B?bVh0NEtuUERNS2owWXhhNHNLalBLMjlvSXgrY09Xb0FPcHFLb25va2YxK2xI?=
 =?utf-8?B?ZCtZdmRVZ0Jna3NETlNPdEFPOG4veG5Sa3FzNytncXlOWnFLRUpqZEJ4dDJU?=
 =?utf-8?B?enBSZDVSS00rY1JKVGN2UjRpNTJUY0wxcm56ZmRJR2ZLSWxGazJkWkdMRGN6?=
 =?utf-8?B?YlV6ektCYzFKZkoyYW9yaTRVenJmL0F4NHdiRDJlMHdmcTkwUDJ6dnhRemhw?=
 =?utf-8?B?Q09lbHBTQTd5TGcvckhOb1UzNHowR3lJY3BrRGxTNmdwcUxzamZySXM2dGhz?=
 =?utf-8?B?Vzk1d2gxdW8zelBOUGpUU3d3b1pCN2w1WFp0Qk9pQlZOZHMvaFNWcTB5bVlu?=
 =?utf-8?B?ay9IOFY5SDlFUkNkc3Q0NnhPckZWbFQzYm4wcmVrWVpMdVRNb3hYY3U0YkpN?=
 =?utf-8?B?ZGxiNUNWK3YvWUtkOWxKdDlub0FOeUg4RC9veDVBcTZtejFlM1Y5OWkwRmVO?=
 =?utf-8?B?VlYxalZmK1NZMVZ3UTRWTStHbTloK0F3NnkzcnRkdmZGRE1RSk9PS3ErcWZv?=
 =?utf-8?B?NlZZd2FIdnh0Ky9TcDR6UkJjbnU1eS9tdGgvOVI5MFhFT1B3VE4yLzM2dlFY?=
 =?utf-8?B?Q1BLc3lWTU92OU5lTmFibC93aTlldk9aK3ByLzNQaU14N1JoaHFMTFR1SWNN?=
 =?utf-8?B?Rlh2TU9iNytiNWZidzEydlFyWTRCWE1PbTIyaEoxaVlPbVkwQjhNNEVVRGw3?=
 =?utf-8?B?Q0N2a09QSEpqaVpORkh0cmpCWDVKem04T3lPSWFZcWpET0pvRmdPV2p4ZG9Q?=
 =?utf-8?B?bE1IQ3B3WDRLMUViNldyRm1vbXZIKzQzb3JNZ09CNWVPaHhyb0twTTdNYVNV?=
 =?utf-8?B?MkJzM29PK1ZYOWIxSFhRZW94anpiVkFVZDZHbTRRT0ozZm05T0RaejRuaS8z?=
 =?utf-8?B?Q2xybE9PQmJnNXdkWkRnMjk3WVlNbXp1dWdmYWp3U2hldk84MzhzT05oZzl1?=
 =?utf-8?B?d29HM09YZ3E5VHUvUVZkaHZtY0x1VlpkMEplem9PV3k1eWFyS0hLVmRHblc0?=
 =?utf-8?B?NHJaS3hqMEkxcDZzNENRYjkrREJCU0pUN0pjdlRGdjhVaTJxZVlNSWIwdGJt?=
 =?utf-8?B?L0VSMGplKzZlVjd0UEtyWERUQlBJQ0FRQ1c0SmE4S1VZcDUyckdGN3pDOUxR?=
 =?utf-8?B?VTJKWDRaQlc2VUI3aXdwZ1hUcUN5cFYzYWtteWtaYkN1b3g5SUpvaitKaUZD?=
 =?utf-8?B?VTlqeFhWQTNkRWVwTVlFUE4reEp2Vk1PMU9DUFhDWHVRWkQ4alM1djhlU0xP?=
 =?utf-8?B?U2U3dE9SMG9uYkJPd0tKcFgzeFBBNkwwM1k2Q05Ybi92Rk9SNFhJbmljWnZY?=
 =?utf-8?B?eE9zcjIzZHExTVcrYnFFSFFuTTVybVBob3RuSXA1cDV3ejRSdkFMUzBSUDZP?=
 =?utf-8?B?eXNNanc0WDBjODJSZG5RaCtFNWw1L0MrZENFSnpxUno3STdBUDRwZ0JoZExV?=
 =?utf-8?B?bExMZFZMRTY2M1Z2K3pHT3hucUlDM1B0dlZMV0pOSlBiSjVNR2I0RnlZeUkx?=
 =?utf-8?B?My8yQTFpcnpHZFlFdk0ybndFUHhHVUo5KzVmVThPb3VNNWpjRmhUNmJ1UUdi?=
 =?utf-8?B?R0dHVEpLWDdab29qSHNaWmFFTUJ5bWk5WWpPcjM4bll4dUo4V3daLzF3eHVh?=
 =?utf-8?B?Z0pTdFA0bC9wZ1c0M0wvOXlNazFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Mxb9/0QoVrq9aNA3hJpXQLhuL/AT/+TBrQTaqMdB8DWhexQEf1ZnIHE448KjsaVvbTQaWyzRVDO+F97vbK3D/hbWNUnUEXtUHSFcEs5Qgm/MXUB0zAQM3zyXhdZg8M7LmYX7vO5H4apHPcVi07H88Fl2KPj3UcB/SQSFFPEXbBAUn42RPmhJ6iFTtPRCtKnZL0hSgXuTJ9yy50aN+miAizVZ3mZ6jm0AURu0EPzLo0wVyqvHwxEoVWZdU0yQC5rfand4jiAh/Zw+xlc1HXPDcAFWBBKnEfaZ9Hmf1WLdD9ufmuWIQ2G4gGuZVgWsviRGkNg60hR9nfK5D8UZpuXl1LVWGN956S+3WaCtLIxjV7fw7kwQzJJihc3VObdj4AHOvPjNNSNd5V6ezE7vQiuo5jtiYaFtufPdY6qLP4ycTsqbXktwyrJKJ2ryNUlzMskZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 09:25:07.4053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63886b6e-be46-4626-3d10-08de738699b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9411

Using Tegra234, it was found that it takes about 10us to disable clocks
and 20us to enable clocks, adding about 30us overhead per operation.
For a 4MB firmware update with 16,384 page programs, this results in
~491ms total overhead (12% impact).

With Tegra234, flash operations were observed to occur in bursts with
50-200μs gaps between page programs. Testing on Tegra234 with various
operation patterns shows 500ms delay provides optimal balance, and for
longer operations (>500ms), the overhead is negligible. Therefore,
update the driver to use pm-runtime autosuspend with the default timeout
of 500ms to reduce the clock gating overhead during consecutive QSPI
transfers.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 7ea5aa993596..7fac695b5142 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1000,7 +1000,8 @@ static int tegra_qspi_setup(struct spi_device *spi)
 
 	spin_unlock_irqrestore(&tqspi->lock, flags);
 
-	pm_runtime_put(tqspi->dev);
+	pm_runtime_mark_last_busy(tqspi->dev);
+	pm_runtime_put_autosuspend(tqspi->dev);
 
 	return 0;
 }
@@ -1765,6 +1766,14 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 	init_completion(&tqspi->rx_dma_complete);
 	init_completion(&tqspi->xfer_completion);
 
+	/*
+	 * Set autosuspend delay to 500ms. Testing shows this value eliminates
+	 * suspend/resume overhead during burst operations while allowing quick
+	 * suspension during idle. For longer operations, the overhead is negligible.
+	 */
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
+	pm_runtime_use_autosuspend(&pdev->dev);
+
 	pm_runtime_enable(&pdev->dev);
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
@@ -1781,7 +1790,8 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 	tqspi->spi_cs_timing2 = tegra_qspi_readl(tqspi, QSPI_CS_TIMING2);
 	tqspi->def_command2_reg = tegra_qspi_readl(tqspi, QSPI_COMMAND2);
 
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
 
 	ret = request_threaded_irq(tqspi->irq, NULL,
 				   tegra_qspi_isr_thread, IRQF_ONESHOT,
@@ -1802,6 +1812,7 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 exit_free_irq:
 	free_irq(qspi_irq, tqspi);
 exit_pm_disable:
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_force_suspend(&pdev->dev);
 	tegra_qspi_deinit_dma(tqspi);
 	return ret;
@@ -1814,6 +1825,7 @@ static void tegra_qspi_remove(struct platform_device *pdev)
 
 	spi_unregister_controller(host);
 	free_irq(tqspi->irq, tqspi);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_force_suspend(&pdev->dev);
 	tegra_qspi_deinit_dma(tqspi);
 }
@@ -1839,7 +1851,8 @@ static int __maybe_unused tegra_qspi_resume(struct device *dev)
 
 	tegra_qspi_writel(tqspi, tqspi->command1_reg, QSPI_COMMAND1);
 	tegra_qspi_writel(tqspi, tqspi->def_command2_reg, QSPI_COMMAND2);
-	pm_runtime_put(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 
 	return spi_controller_resume(host);
 }
-- 
2.17.1

