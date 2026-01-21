Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012022.outbound.protection.outlook.com [40.107.200.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9957736BCE1;
	Wed, 21 Jan 2026 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769018208; cv=fail; b=dU6D79no3kwTIvkNT6gKZnrAOrAxCwytbjsThJsL+B5d9VycpL9DIKZ+Qmo/rrTM+YONJb2PyWxZbazTR3y8dDz5B7XS+xkjLwBU83Pr1S6Y5rv3YpWvyjwrAPr/JIZ7GhzQN7u0MbTbtwDBHpTTkMbKkGebLlRx2gjPShybO/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769018208; c=relaxed/simple;
	bh=/PHL9rVqMu5bkZJKnZGxa2SsihSkmTbR8eVqQ7OJmpQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UI5axSj9h4pJmNBFSXTuTW9dNNltr9b3JucfEBRw/H2/g2CPQQ4TTNbKHMESR1dEypvebBDrRZtsPlZ3GkQM87hg1F2ntIJHdUf7DAwAVolZIBy0z1WYUzZejkKphf12x0u0u00puac1WqleqaNUbsOiXmmWZhTSDgs/ceqO2zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HA2buLeq; arc=fail smtp.client-ip=40.107.200.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HA2buLeq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMaSY/5+FfFX7VMcJWmugk5xSbKyjP7qQa0zZhrpvp38rUk6iOJoIDDnWwPKe1ZT4lHwh3c5Og5Uc2t6nDUoLj7CG1MuGNMQbXjsCbxefD6V3SX1mcXmlale7k6Lomp2cxkbZi6oZmDcn29rFp8lBzDXgHrAC2fqed392+gUC2wcnU9iiQqRNa0QcFctRFcAfCEGcL19n8B6muTYlMIy/EREUxdE7Zvkfm3zAPYDfcPwIbt3yM/AWscpk5OdMtzgP/EwcRQjVx+pwTiIVqX3PLT1b1IbGYTmiTji11n7k6+9I4tyA36SnxWf+TJ00saDELPibHx6uWOxkAej/UFCCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ssZvjVYvuGr9iDrL5cNapoYmo5S95evuQ1rU35pO9A=;
 b=Bj0KlK8it6yQwqxMIPWNalV/1VuCovSEhXPugJVN0Biu1kse6NOuoXYAHpU7SJ4pwRwOl6gGTDYxLnfT/InU5TV+++kEGZ2JaB5+DHQOGJJKsQrvgFaRr6ETC5sj1Is2ikCT753OI+v2yN0DCb59Rz1MXj5/LoSahjdetuGLhViFt0dILeJrcxwjTWrkbZ5X28PZAsLpAc7Mss/4sAdAlE8WoxAkrr5mH7ccVWB2CVH4VtZUpaTjzPNARe0lpYsTLYbNLsRhqK1BZ9PXfDkCwXSTO8CAxWiNei4QitjAxfGA3Xj/uPIZazfyYSFx2m8phLqwzECp80xVFvmA1ikP9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=debian.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ssZvjVYvuGr9iDrL5cNapoYmo5S95evuQ1rU35pO9A=;
 b=HA2buLeqHcSPMDctUqTCm+T4a9FSpqnO+fa2kY3nmNS0Vgsd94UYvoGthVE5mNbluhK9VXbPVHVSB509s0qw3WamWkugRi9un7QQxsa5WS9zJVDHF7+mylc9vdYISjqtM0IyE/ehzr7PblW8OboAGtdnOK3r72PrxRYdNC3pYbT83g6lLvklSqZW8T0Lun25wPY+VkfTHMxYRb1AgkPmpYPE/y2/RlLO/knL2G/4tHNg23coJy3wT25uo69xSNzsihaQrR6UgwOqjEF7OvI2liApTyUMvp59Qtb8ete+CApadovUAvaX6arIEtqknnjm62Dv5uWmIjDttanXvv8Daw==
Received: from BN9PR03CA0259.namprd03.prod.outlook.com (2603:10b6:408:ff::24)
 by LV3PR12MB9355.namprd12.prod.outlook.com (2603:10b6:408:216::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:56:37 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:ff:cafe::44) by BN9PR03CA0259.outlook.office365.com
 (2603:10b6:408:ff::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 17:56:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:56:37 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:56:18 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 21 Jan 2026 09:56:18 -0800
Received: from build-va-bionic-20251122.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Wed, 21 Jan 2026 09:56:17 -0800
From: Vishwaroop A <va@nvidia.com>
To: <leitao@debian.org>
CC: <thierry.reding@gmail.com>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
	<skomatineni@nvidia.com>, <ldewangan@nvidia.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	<puranjay@kernel.org>, <usamaarif642@gmail.com>, Vishwaroop A <va@nvidia.com>
Subject: Re: [PATCH 0/6] spi: tegra-qspi: Fix race condition causing NULL pointer dereference and spurious IRQ
Date: Wed, 21 Jan 2026 17:56:17 +0000
Message-ID: <20260121000000.0000000-1-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <aW-seUXIJv4Lz7bK@gmail.com>
References: <20260116-tegra_xfer-v1-0-02d96c790619@debian.org> <20260120112242.3766700-1-va@nvidia.com> <aW-seUXIJv4Lz7bK@gmail.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|LV3PR12MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: c79d3230-b1f9-40f1-e68e-08de59166c82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUF3NEd3VVEvWGhmRTJ4M05UVzlucUh4ZmJnYjAwUTdURTQvNkhEeHk5ZlBI?=
 =?utf-8?B?eXJXdi8ySVkyVFVPQzAyN1cwOStBekF4QXFiNmpBdmhnU01Lc0d4OUxCSHZ5?=
 =?utf-8?B?WUhwWUZ6NVU0ZStXeGRncWJ0STVCaGM4MWhmMklFR3h1dFU3QkV2QXk4SUVW?=
 =?utf-8?B?bmxXdEJld01SK0FqNWd3WlA1Z3hsOFFxNGp1bFY4UGxZRFErNjVLUUVQd3NX?=
 =?utf-8?B?QW8yUmo1RDBjeEpZWHpuQVBRV0hwSnVWSjg1YlErd3hvRUUyQ2NVR0hJUmZx?=
 =?utf-8?B?cDdMZmwwZWw4Sk1jZkwxNVRBZVRpbXhiNTFGSnZvbU5qaXlEamd3bExUOVZ1?=
 =?utf-8?B?VGZrNXBaTFBJRUx1VDFpbEg2cEIxNm8zYU9zNkkrVWZiTGtVUHIwQ0RZTDNM?=
 =?utf-8?B?Mk5PZkVtdlFRZ3V6V2gzOGQ5bUp2NGRrZ1BsQi9Kdm02Y1d1MUJQZG41aHdV?=
 =?utf-8?B?MVMwQk1scERVUGptanJPLzJ5dXI3bVp0azhnZksranhhcHNWUjNmY0ttZ2Qr?=
 =?utf-8?B?L055Qm9CSkVCVEtIeGtZTm55am5CWmhaRTJaYlJqcUJxMnBRVWx1cEc5dUpQ?=
 =?utf-8?B?M2NmZnBEMnhiV0tGdnVLQ1lkTVQ2ZDZ2Vmk3NDNNZzRBRWFlQUswVVVJcXR6?=
 =?utf-8?B?akNhTGIzdVh3WG9XSU91RU5wMGxYUnk5N25uYVFhOTYrZzh2UWd0aU51c0Ez?=
 =?utf-8?B?NnBka1c1NEJ3cGxYSytoNkpUTTR1OXhGYW1OL0hwTThOWHBZYVBYUDVldEht?=
 =?utf-8?B?SjVrbUlabVY0TnphMTRDZjUzVy83VXQzSDBqb3pCV0VkaGZBcDNISHFoNSta?=
 =?utf-8?B?QWxjazFhSVZtK1g1b3dJU1B5Ym4vRkhYM2lZTExSTXlFSmFNbFZWQ3VDaGl4?=
 =?utf-8?B?OWFUekhPZXk4SnNIWlJuT002eVBnejg3bkwyT0U3SklXNlVtR0pkVUh1djN2?=
 =?utf-8?B?YW1TcWd2NFNOV25Rc2ErUkk4QUVTWlg0aWJMdjUvM3A1ckd4aFF1enFnRERy?=
 =?utf-8?B?RElsd3BCSVZWOVZtM04zcHoxdXVPaExudTA3a3FWMXROaTdEcnRjb3FYTkdP?=
 =?utf-8?B?bjZWQ0NRWHJnbVArTURGZnVDeFcxMjhaRU9vcmozYThERThpMHhuY09IbjVL?=
 =?utf-8?B?MEQxNG9SZS9kZGJRcU1GNXQ1aE1BSkFCTUVzcnR1QTZXKytSN0dNSXFtbHo0?=
 =?utf-8?B?bkY5MGR5Z0NmT3FwdnR2R1hxWjBTZWJWQVZZOU9pL3liK2xJV0IyNFlnZGZG?=
 =?utf-8?B?Vko0d1IrVWw3WEduU3JKWDkwWndNSEpObmFMaWc4VDBhWG5IMjBnck8zMFVo?=
 =?utf-8?B?bmlWN2ZPT2RXRzkwb05MNXd3N094aEdvTTk1MXh3a3gvRXhkcVZHZTR2blZL?=
 =?utf-8?B?N3pBc1pLV3FDRXovcnczTENKLzNVenFmT1llQ1gwWDF0c0ZGU3NRU2R6Z0x1?=
 =?utf-8?B?UDdnblF5RHpnSEVIb050aUFxbFFhaitiaEhJR3BSR29sQ29ieElvUHhmemZV?=
 =?utf-8?B?anAwRW1VUG1NdGcyY2FpM3hBNGs0M1R1NzlWdUVKR2FCK0t2bE9DUEZPdFRu?=
 =?utf-8?B?K0xmcmM1ZDk4anl5QldwaGpWemJaNE16SmhFUVdOQTl4aDJrZWRPcTRvMEhE?=
 =?utf-8?B?OVBKaUtFUkV0Nlp1aVNtTUpkSWdYa25zQzRIY0lSelJmdWZhZk9ZTXZ6aUdy?=
 =?utf-8?B?SEE2V0lEbEJhWVo1dnZRY0d6dmYrMENmSnc5alROSTdualdrMXlhVG5qY1BU?=
 =?utf-8?B?OERNeWZlYlJ1Z0w5MGhpUkxRa041S3BQcldIMVl5eVF3ZUlxeUV2RFNEOHhE?=
 =?utf-8?B?RU40MGlUUXpwVUcwbXJQL21EMkNNbi8rNmdsalZPTVJlaEd3bWdIOGxTU0Vi?=
 =?utf-8?B?RmdRQUNpQW00aWVjbk9Fb2xnLzB5Tyt2ODIvMFBxUzdxTVFXZk4xR0Q5VUQ1?=
 =?utf-8?B?Ui9mNG1ISVgwZWxJMG81UUQzQmFNZFJabGZhbjUycDAweGlKS2JqL1Fsdlhj?=
 =?utf-8?B?ekJnZDB2bERyS3BWcGVDVlVqZ0l5TjlmZWR2cVV3VkZIUVEzZWFOQ0w0VHZW?=
 =?utf-8?B?WmdBWVA0R2F0NCtlZTVYbmtBS1BUQTZGTmduUWNxQzZHeXo3b3p3OEpsd1A0?=
 =?utf-8?B?STJ2TXZBVDhlYU5OMjZwdWlIQnYzUWt6MWo4dGthOWhjRDRDRTIxQ3BXSW9h?=
 =?utf-8?B?eVppWG5HdUk4S2FiZk9TR1UxWmpkMGEvVDIza0RDZzUvem1HWVdJcXg3THIy?=
 =?utf-8?B?eWlBWEdzYTBJVjFsckg2RHNLZ29nPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:56:37.6151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c79d3230-b1f9-40f1-e68e-08de59166c82
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9355

Hi Breno,

After reviewing Mark Brown's feedback and the code carefully, let me clarify the 
correct logic. This is important to get right.

**IRQ Handler Semantics (per Mark Brown):**
- IRQ_NONE = interrupt was NOT from this device
- IRQ_HANDLED = interrupt WAS from this device (regardless of whether we fully processed it)

**The QSPI_RDY Bit:**
This bit in QSPI_TRANS_STATUS is set by hardware when a transfer completes and triggers 
the interrupt. Software clears it by writing 1.

**Why Your Original v1 Logic is Correct:**

Your "[PATCH 1/6] spi: tegra210-quad: Return IRQ_HANDLED when timeout already processed 
transfer" reads QSPI_TRANS_STATUS at the start of tegra_qspi_isr_thread():

    if (!tqspi->curr_xfer) {
        if (!(status & QSPI_RDY))
            return IRQ_NONE;        // HW never set RDY → spurious interrupt
        return IRQ_HANDLED;         // HW did set RDY → real interrupt, timeout processed it
    }

**Scenario 1 - Delayed ISR (the race you're fixing):**
1. HW completes transfer, sets QSPI_RDY, interrupt fires
2. ISR thread delayed (CPU busy)
3. Timeout handler runs, processes transfer, clears curr_xfer
4. Delayed ISR finally wakes up
5. Reads QSPI_RDY (may still be set)
6. curr_xfer is NULL
7. Return IRQ_HANDLED → this WAS our interrupt, just processed by timeout

**Scenario 2 - Truly Spurious:**
1. Spurious interrupt fires
2. QSPI_RDY = 0 (no transfer completed)
3. curr_xfer is NULL
4. Return IRQ_NONE → not our interrupt

**Your Latest Proposal Has It Backwards:**

The version in your last email returns IRQ_HANDLED when QSPI_RDY is NOT set, which is 
incorrect per Mark's feedback.

**For v2:**

Patches 1-5: Keep as-is from v1 (all correct)

Patch 6 ("[PATCH 6/6] spi: tegra210-quad: Protect curr_xfer check in IRQ handler"): 
The TODO comment you added asks about keeping the lock held across the handler call. I'd 
suggest removing the TODO and replacing it with a comment explaining why the current 
approach is safe:

    spin_unlock_irqrestore(&tqspi->lock, flags);

    /*
     * Lock is released here but handlers safely re-check curr_xfer under lock
     * before dereferencing. DMA handler also needs to sleep in 
     * wait_for_completion_*(), which cannot be done while holding spinlock.
     */
    if (!tqspi->is_curr_dma_xfer)
        return handle_cpu_based_xfer(tqspi);

This documents the design decision and closes the TODO.

The device_reset_optional() was from your March 2025 series - keep that separate.

**Testing:**

Carol Soto will validate v2 with your test methodology and provide feedback.

**Follow-on:**

I'll implement hard IRQ handler support separately after your fix merges.

Best,
Vishwaroop

