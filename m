Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83EF31960D;
	Fri, 13 Feb 2026 08:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770970763; cv=fail; b=WfGLGq8Q6kP1y4aMy2EaQs3Ud4366pFcDbIGWvYgm/YNchjibJrhHOHWAcHzFDHAPTkvEkegN4hCYpPBbf6S15nc/O5Dsn4rar4yhsk/yER8JiULB5li7M3tor8wonVDyNRxsK9S+NY9gXhnifcFstTg23kdU5JLfx82B2m0FXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770970763; c=relaxed/simple;
	bh=uv5avNN76cfyJHgLbqHuRGxwmoa9fxbR7tMSJjslD2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=MtYKppe8iQh2RXbIUTuUAfxgQaGh1TFGQ/tDDAgUP1z2xpHgG0qQUFMevAIYlNkYDV1qWLMpZCy96yBvt3FwHFpk46isvpqkwzta04NvvyhuR1pOZUPHsffXsx0tXPNePMzf2htNXSkuI+KDiCu35ukTLwENH7xlhSj/Fix6is0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=gbtifrbz; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="gbtifrbz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpy5IrWw2GdmYdB3jBkHj+mSaLuteqjEucUb962q78swuQxR8Cq76OKHp/jsJkYNiv2U0ODiFAiR0h2dFKr4Csrg9KgK7ip+bTEZonJGtzyKRFv0wtGN0rwNDYScZKaaPVlKWw06DNKKt6c1du7Gn2o+BBFoOiXxR0h6kawKdYLU4oI8kzFatElLHPZ4W7EEnx7R1sZkkH6pMc5jLI/oRaFtnn2lIJNa/o9QVVqeu4cb2J96UOFDWuq7q1bdLzcVQalE0zgVBFo0r0ZM9ZrgdM+N0N/yFeFXM6vK75jDTTkYm082ReomLpJD3QqAlBhDX7JbgWpbLQCxOiUlU1S5Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpTJSgKeCuoRL65TI9rkK4MMIbNdKby0sbU6AiamByw=;
 b=IuuyMSeVi7RBiJo2mzQerdGQJeAoMq39Ai9enN8sZhVfkqafyUrWydK/9jNHGQmc5Syooe75qcoayq0aSg1CSJbZ4v/LLc/g8iuJbksGLeMaLB4nkKcJMXDMc7w+IXHHLDfA9zM7FpsgEENfqIUkOWPCEExaI0dESU1JHPfeebEAblg+f475rJZ8v1eYTBmrGjYMwfAc86Gwq0rLLMpPD7RPNO/jKUaXw7yRVe6JE0NfvugwCH5ECcfPivQ9DL2X7VgWb2r21gL6HlfpBnNDav1lQM7h9XsLnyru+1jcbWZ0LozPnr6e43esfXDuiXewnVyqoVcmWe7ALPwMXpnXBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpTJSgKeCuoRL65TI9rkK4MMIbNdKby0sbU6AiamByw=;
 b=gbtifrbzmjwVI/+Q2aBlYH6jUnCIFrgfW4/AG7kr9qT8L6mzFlQmTjfqHK9B/T6ZZKUp0XZWksVE0G9kSWU2qaWIiZIyWmaIgTLBHdDfgxodpfkWmRNLU8MHd22B0BgiY8sKC9TBres6NmsgfzVOC84mMsMhqLfZitinJxOEt6ZhsKxcUO0ro1cYRSkHMlyp3u1GHS5QWZqjX575MzNeSUIRLqXB19j8Nmc7OmHM7LY0E9G7cRKbCTDVabGwgLfZsHdLfN+Q+b2LE8JRLan3htZR1yFmc8MgKH+Dq9n6GAlNtXLoQeR5qglIxTP+qXUWfvYwCDMqJN+qTXa9WPefTw==
Received: from DU2P251CA0029.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::31)
 by DB9PR10MB6644.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Fri, 13 Feb
 2026 08:19:15 +0000
Received: from DU6PEPF0000A7E0.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::65) by DU2P251CA0029.outlook.office365.com
 (2603:10a6:10:230::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.11 via Frontend Transport; Fri,
 13 Feb 2026 08:19:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU6PEPF0000A7E0.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Fri, 13 Feb 2026 08:19:15 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 13 Feb
 2026 09:20:57 +0100
Received: from localhost (10.252.21.192) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 13 Feb
 2026 09:19:13 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 13 Feb 2026 09:19:11 +0100
Subject: [PATCH] spi: stm32-ospi: Remove exec_op() callback debug log
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260213-upstream_ospi_remove_exec_op_debug_log-v1-1-164f17515fd0@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAH7ejmkC/x3NQQqDMBBG4avIrBvQKQrtVUoZbPyTDlQTJlUE8
 e4NXX6b9w4qMEWhe3OQYdOiaanoLg3597hEOJ2qiVseWu6ubs3laxhnSSWrGOa0QbDDS8oy4bV
 G+aTo0Ps+BM/DjZlqLBuC7v/R43meP7+Ggi94AAAA
X-Change-ID: 20260213-upstream_ospi_remove_exec_op_debug_log-e5c5ffc26922
To: Mark Brown <broonie@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <linux-spi@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E0:EE_|DB9PR10MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 380fa9d7-ac2f-4bf0-fc81-08de6ad8935e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2R0V3FOaHhFVk5UcitWcEJUUzBkZVhBV3JSTGtJM0FjVHhueHRQMTFHclho?=
 =?utf-8?B?UHVmVzRmbXFsSjNhR2NobDZOSXNMeVZvTkUrSVdWTTYxbHlOaXZMYzB3dzVS?=
 =?utf-8?B?MDVydDB2cG13RjZrNTZCYm5IQnZ1YVdwd2FCZGhHdkFWVHlzZFNSV2loZEFJ?=
 =?utf-8?B?NGJpejFMUUM1ZXl4QkMvMlZ5YkgzUkpyQ2ZaVisrcHBQS0FER0svbTh0cEdV?=
 =?utf-8?B?RzRUek9YU01BWHdQb21WYmx2bWNPMDJ5WnZkbVV3MmNCK3NjYlh1TG5qOHRV?=
 =?utf-8?B?STNZb01nNzdVL214bFBYa3FZNHBwcDRPaVNtaGpBMlMxOTlUK3VHaVd4Ui9K?=
 =?utf-8?B?ZnRER2R1WXIzdW9iQVVjQmt6MHRlQ2NuaStBMDJ5dzdFWXdFdjB2OTFmUlh2?=
 =?utf-8?B?WllGcmFzNmdTZE8rYk01dzJKQTlOanFPUnJXR3YvUGNQMXJWSUJGTWxvaUdI?=
 =?utf-8?B?d2RZVUxkUVlTVGgrVHlyMk9UYzkwU2FOdzVtZmtoN1ZtaHB4WVV5L2d5Yldt?=
 =?utf-8?B?TTBqTDlWUmNuS1ZqNmU2dTkyMlZPa05vb0NMYWRqZ0tiYzNCSkZUcDljdVFH?=
 =?utf-8?B?WlFBT1lKQzF3QUMxUDVSOWpSMHBGWC93RllmbXRrcHI2WDR4czg0OWE1N3Bh?=
 =?utf-8?B?cTZkU3BGN1V0cWJVcVVCaGZaejAwWGNCdGd4Wkd4Y2xPeEt4bUhXUWRrZUZr?=
 =?utf-8?B?K1RPTkFCVVFwMGdkU2lwVHZLcmFZRFV0SEFicmdXQ2JpTjNmeFJiSXVYYzB5?=
 =?utf-8?B?LzFUdTk2Y01OWGJ0UlFvK3B4N3Z6alZ0Wm9VOXlzVDI4KzlqZW9jODV0ZStD?=
 =?utf-8?B?UnJ5dzNnMERraDdhZnBnam5qaHh5a0NSZFVETHc2amNEMG14Y2tWNjIrNWRK?=
 =?utf-8?B?azZhK2hXcExJRHplMmdNb0RlbUU4ZkpncVVjbTc4Sy9mREt5MVBPaHd5dTFp?=
 =?utf-8?B?WmJwQk4ycnR0clRwZUhpdjVPSjd2ZTVURFZVV2lCTWVINS9CMjMwK2dNZTBx?=
 =?utf-8?B?anR4aGpDcjQxSnI1WDF6RzhuMExLMlhoSnJzODBjL2FSS3Y4bUpmZzEzOGJX?=
 =?utf-8?B?Wk9mYldqZ3lubzMwV09rN2RmVDV1b3dxR3RSeEZaZFRlTjhHYkpsa3dQQStp?=
 =?utf-8?B?Qk1MRnJKa2hPV21TaytBMnRURFptMGdHY3J0TjNvdUxJMEJFWmwwL1RlczRH?=
 =?utf-8?B?QU1lYUpyYUk0WmYyYmxXV2lrczRTOFZLbHVoQThpaEhJLy9tZTA2MXV3Y25P?=
 =?utf-8?B?aUhLaldPU0pVSEZVMm4vQ2RIY3dCWFM4eUdiUGFHbWtnVGcwYzJ1SjMra0cz?=
 =?utf-8?B?TU5tMHFBWWJJLytOVWxOYmgwVEhQand2eEYwOHpTMk1US1dIWTVJVklCNUVq?=
 =?utf-8?B?clBYelhUOWo3dkRodmV6M3BKdWJmcUwwQ0FGSHArUURqcFM1NTgvQnN2empZ?=
 =?utf-8?B?bUNOdW1BblpmejFNcytxTWZSbGtFRjBxME82UHRPZDl6OU56bDY1aTNwcHJ2?=
 =?utf-8?B?aGNxYnB5UExJYzlxSFZWazJNVms3TGk0M3U4SHZ2bUlSaFFiZEVRdU1aeGZk?=
 =?utf-8?B?dVFiUzAwc3A3K1dnSUJDcldHT2NJMkNmVXA4KzdVSndFQVlrbUtDUGZjdjVk?=
 =?utf-8?B?Sk44aVFtNzVtcmhoTEZtbWxLN0t0YlEzbHZWcVBQdEF4dTdnMGJnMkxjMXpv?=
 =?utf-8?B?Yzh3UGFNTVZtMVFNY2NKWHMvaWtURGtNMWtIQ1N6a0dsSzJKTnBqY0MvZGhI?=
 =?utf-8?B?SnovTFJnUlQyYlUzVFpnbDlYSzk2NG1OM0tuRFhkWC9sSVdBZldJSlhLREpV?=
 =?utf-8?B?dzE1clBWRUxIcCtTMXFyS1V5YWRreW9IZ1JZK1Y1L0Y5eW9QUER0WVdXS3JY?=
 =?utf-8?B?andrSHY3NkxkWWxmVzRlNnZwaXFXVUJ4VUNNdUZ1VmJXL0kxRFZtcGJrSjNE?=
 =?utf-8?B?ZFVMNmVBckpyR0sxbEZ2T2FiOWt0aW1GaFB2R0JJZE0xcUpMcEQ4UW4vaGlJ?=
 =?utf-8?B?eGRza25LMnROMzhMV2RlNmNxN0N1bGVpYS9HWlJSYjdoQUhYQmVSalRYSTk2?=
 =?utf-8?B?dWI1Y0ZrcjRQNVV6cUt0T3RBSlQyd2IxSDJCTVVuV08zbmMya2MyWnZlOGdz?=
 =?utf-8?B?SVpUeFZDd0ZkU3c3RktaV1RzYUVqZXlrNDRyRXNFc3BPR0pFZGFUOW1rVDZR?=
 =?utf-8?B?VCtKK213NE9EcUxONlFUU1FwN05LYlh0OEpxeDhOYkVXSGJwZWppTCt2VzZI?=
 =?utf-8?B?WCs5Rno2S1R5dlp6eW92bVpOQXBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L8xvdGYBIAMCDfhxcrLyuMwkJFMe/NdoUeEe1O/uoovOu4jtdsfNDGiU71ZoOnaAtGAmiJN5VEsNzTEeSXejMEUYzl9Hq1VYQs0B/KTCe9VrJ3FDaLSRbn5SJQqgENVzRSXBR8ErLc1ErDVz5QkeILH1+XOI7AqT4Il/fgZ09RJP9q/Gg47y02pVACYiUQipuoqhQmNwfAYjI8E2T64mBCworl8XeLmOB3p0GkTzKedfJNEZRw0OpgM+oNu4wcX+UGjaWQq1lhuSh45tLTW0fOWOusECCs8+2LiVmCLWQd0PYlao1fRUOju5yNtPok6WONKNXPx+n49ar10ERssT7Ia5p/Y1Fvw622d8SHdp184ufjdAdaW+tBHlJo+FbFXpehaPHybgQ3v2B8rhyaTjQI34VCvB0Ggz5ncjr//PmWvIF/vQUbH+gapRRfmedB/T
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 08:19:15.0079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 380fa9d7-ac2f-4bf0-fc81-08de6ad8935e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E0.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6644

Since commit ad4488845193 ("spi: spi-mem: Introduce a default ->exec_op()
debug log") a common debug log is available in spi-mem, so remove the one
from spi-stm32-ospi driver.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-ospi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index f36fd36da269..f44a42301ea4 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -441,11 +441,6 @@ static int stm32_ospi_send(struct spi_device *spi, const struct spi_mem_op *op)
 	int timeout, err = 0, err_poll_status = 0;
 	u8 cs = spi->chip_select[ffs(spi->cs_index_mask) - 1];
 
-	dev_dbg(ospi->dev, "cmd:%#x mode:%d.%d.%d.%d addr:%#llx len:%#x\n",
-		op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
-		op->dummy.buswidth, op->data.buswidth,
-		op->addr.val, op->data.nbytes);
-
 	cr = readl_relaxed(ospi->regs_base + OSPI_CR);
 	cr &= ~CR_CSSEL;
 	cr |= FIELD_PREP(CR_CSSEL, cs);

---
base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
change-id: 20260213-upstream_ospi_remove_exec_op_debug_log-e5c5ffc26922

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>

