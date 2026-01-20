Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012039.outbound.protection.outlook.com [40.93.195.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF5D421F0E;
	Tue, 20 Jan 2026 11:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768908192; cv=fail; b=uGUYSo/q91rRDECXFiCAvzwJtfNJUkGN/dDGHapr82cp7tCTL1rWigeQtYZcc1VfZqAtWLkqLQTAa2McCVPd79lD8RkwGXw5wtnvtIYNhSnGIrIa7JVXmzli/rgB+XWqHJ1KG62bF59y0zi2Ae/qKM5LdUdiQhaSH2+wDZEMVww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768908192; c=relaxed/simple;
	bh=/18JCCVvB8/mgOYUW3R75YvT4rnl348YW6ApqXke5+s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:In-Reply-To:
	 References:Content-Type; b=Tg2+KahRIP9latVue8Iue5nwrvpjB8MPkYPEXBuOaBNGQ4P2ccSwyzC2L7n9JRw7zlEJvfuaeVtxKUn6/VPhuCycGfAWGqL7mvLQTqPmGFxEnM438Sg3BNcB8tv+gmsHQ0iBzyS7aK15gW6RC+BdcGvY7LYy96QlPNUZ/MYH6AE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PCXeIi49; arc=fail smtp.client-ip=40.93.195.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PCXeIi49"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAGFPMMQNrwrPsw2yXnHp2KuCW0kojDoWlXEy0iNi8OhVFUaSKCmqFUPldApEJ88KAHnK7KeTPLt38AlV1S58K/bXq/IMGR8rhdA14Qs9vGVIv/33qkQxFe8g3WjNf66XZLG5tp5e8Qw15XNBpxLTbVJIcQ380lgpe2u433VIGgGwwRqPfKSTl+gJQH9bRKx4IOqVRRzNZ6RfF2c7uNBul2sRN65m1wJgdXGcTsXj7J/1wuHunU8cUZ5wqk2VbND8LvOmVPtZXfm3RRBV130nG3TpUA5PNbMzB29q2QEOyVBVY3/bC9UG+QONlstW+ernn9F6lT97sxi/uznqYhLPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jn1Qbmfj9rA587v3JGCxvuqnDxgEVj9usPN6TWgY8Ws=;
 b=Xg42nR/JvMRYQj9bjGYZXr6knOkjNiNayZCBDY75dN2BSQksGKbc5JHdIvrnxLaaB/hgnse3UxIF01wwTcRH5toqtOgdJ1v095IVTzCX7hcOHNA22k4ehPJrGGDzJgD8sQQZNzbOnzNVW/MMQS3puw3l/rpzGSoJ2foVU9syhxxer5f3aZREIL78XIEVz/0aVcprW7ffj+KR+eQ0jrVIDlMypFhcCTpkTafvM1P2+fyBE1XkFsA9u3JfXB0iI1yPA6pdWWes4agLRHXy5xWrVulOcgmwAMkd5BGTSYVjNU9ZOi6YRsuF8bV3pbWvC1syTN3RlYTa/pMVN/q855APig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=debian.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jn1Qbmfj9rA587v3JGCxvuqnDxgEVj9usPN6TWgY8Ws=;
 b=PCXeIi49WqJYAypzHT8P+u+Pu62+XWjwo/qAar+wXdqBF5zA5RbuD9kD7UaT9hPdRcIDusmNcPESil+UhYrEmiI1qElaWFB/50ts+uEAPtiMuHGCwOT9N5ZuRd4vle+jx7Zsnln35llmXTIm0egc9eiHNn8hMXr5z2B8HMaf2fY2bRqRbToEcF54yhOyQMEGc72EUaE7rGisv2MifyMRfKo6ZtuQqq39MkPV6L3LPENrtcZKi7+YITfYncDVA9t2odI7ZRRnsQ7vtoVFyzcSzXQMAsstneZsecz16sX9zU5bGRQ8gzY3YpxLjsFhpeZxXL9qTzXYKfvlXTogqmh3eg==
Received: from BL0PR02CA0091.namprd02.prod.outlook.com (2603:10b6:208:51::32)
 by BN7PPF28614436A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 11:23:05 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::76) by BL0PR02CA0091.outlook.office365.com
 (2603:10b6:208:51::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 11:23:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 11:23:05 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 03:22:43 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 03:22:43 -0800
Received: from build-va-bionic-20251122.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 20 Jan 2026 03:22:42 -0800
From: Vishwaroop A <va@nvidia.com>
To: <leitao@debian.org>
CC: <thierry.reding@gmail.com>, <treding@nvidia.com>, <jonathanh@nvidia.com>,
	<skomatineni@nvidia.com>, <ldewangan@nvidia.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	<puranjay@kernel.org>, <usamaarif642@gmail.com>, Vishwaroop A <va@nvidia.com>
Subject: Re: [PATCH 0/6] spi: tegra-qspi: Fix race condition causing NULL pointer dereference and spurious IRQ
Date: Tue, 20 Jan 2026 11:22:42 +0000
Message-ID: <20260120112242.3766700-1-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260116-tegra_xfer-v1-0-02d96c790619@debian.org>
References: <20260116-tegra_xfer-v1-0-02d96c790619@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|BN7PPF28614436A:EE_
X-MS-Office365-Filtering-Correlation-Id: c57044fc-5011-416f-eb48-08de581647eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zm5WWTFiRk0zc1BnREtWOHByUDN4bzA2SHlwS0ZJbEpQZy9aMENKSC80bWsr?=
 =?utf-8?B?YjliSWlibE5QZ2kwd0xJd1V4VXF0cHhCNHRScEVyREh6S3hsWnRhcjBWdFpo?=
 =?utf-8?B?UkI3UjhFaUNRUjFjc3FpYVFrVGY2NGFvdndZM0V6ck1rVklCUHpOTTA4UmZO?=
 =?utf-8?B?Q2t6Qnd0eDg3bUNHdmZUWGVzTTg0RTR4Z2JzOC9lZ1l1Vlp2WEx2aTM4bWsz?=
 =?utf-8?B?TlpUcWh5VVV6ZnI5ZXFaNTdqUHk3eTA0VzRkTkR5anlNWkFqRXF5dFlGdi95?=
 =?utf-8?B?MjFyTnBpZnV6R3l1YXJOR0o2b3c1bUtTWVJ4bDlJQWo2bm1RaXJjQTEwT1Zr?=
 =?utf-8?B?SStXNGFwM1NpOHppRnVaVVd1bVN2cHZDb0wyTE1RN3pxTHNRYUloUVRvTnV1?=
 =?utf-8?B?dGlzcU5GWWpMUlQxRFhGb1VyY1VwTExRZVNZY1BiOHZRdGQ3L1N6V1I4ajNP?=
 =?utf-8?B?WFd3c3dlM3cwdGIwZjVYdHIwdDlzSWY0MGpseTZhUklKaUlPVDNsNktZNkdJ?=
 =?utf-8?B?RVp0RGI2bWlTalRyc3FUc1pBQi9wOTFwZ1cva2VyN0hRanBlaXRYUVVPTVJD?=
 =?utf-8?B?d1JmT1BPdkx3YitaV2FaS1pTNGUrWWJFbzVwd1BlZHJyYUtmR2FZSi9ITDRn?=
 =?utf-8?B?RCtzdWFsUCtURG5ZOHhuV3AvMGxESEdvZWc5ZEFWOTQxU1A1Nkd0aVVYeDVE?=
 =?utf-8?B?c0RCWk9UQmJpalNwWTEzM1lkUXJOT0VCTkVBbzkwZml3bmp2UjM0ZnRUVDlU?=
 =?utf-8?B?U1lGM09FT2lhdlI3WHY0R2ZuaEFEeWpjWUJramhKZGdoaCtZcmt0V2E3WXgw?=
 =?utf-8?B?RlRzU1c2M1RxZm5WUGFLVlVwOHpRdXg2MXdDK1RCT2w0em9jMDl4dTFZWnRh?=
 =?utf-8?B?eUpYME91NmU4aWhUeEJaUW1mSDN0UnZBNk0ySmc4dDZNSDd6YUpJUWVjYUlw?=
 =?utf-8?B?a1ZHT1hIUnZUUFBHMElMRW4vM2twcjNRT2tJUGIxZ3ZCaEtnTVowbWx2dmxY?=
 =?utf-8?B?bTEwOXJGekpqclI0OGYvRU11RDB1TmpHci8wNkdtNlpscHZSbnRKeG9KRW1L?=
 =?utf-8?B?YWl4MXdLdTBSZ21SWHdxSVFaaFg1bjdsWkExck42eHQ0UzV6Z053WEpRcnlp?=
 =?utf-8?B?bythd2ZzMTZZbXVkc3BqU0JscjJWdmVLLzdZU0oxSVg3L0RDUngvRG9kVDdW?=
 =?utf-8?B?aDFYU3hSRGpOOVBWdmxCdkkvVWxTbDBlTmN0TFVleGJ1bnIwYldGVU9MWHJJ?=
 =?utf-8?B?TERLTmtPa29XWHg3ajg5aFBJY21Ta2NDbVVSSlFiam93NHZ4U3RieU9QNGRJ?=
 =?utf-8?B?UlhtbWRoeXNoSkpEQXlQQ0VvWVQ0OXFZellHeEhiRGR3UEJmQ3FBY0ppbElp?=
 =?utf-8?B?TGJ3OTZpZHplUWc0YW9qaEJLa2p6WENiR0dyd3hnVDNCcm5hRUFDMmozSVh3?=
 =?utf-8?B?cEJPYkRRY2h0U0lqamFzY1FwYnQ5cVpPZEhRc25GeE0wSXBlU1Fpa1N6M3hB?=
 =?utf-8?B?bWpRU3NZL01RWHNzWE5lRXNHbDhIMWt1K05LdVYvcnRLbHdYSStaRTZkRmk3?=
 =?utf-8?B?N2Y1Z2s4MnVXR0IrRzU1UjBaR2dSb1doMXpYRGVqeVlKTXViOW5xTHpvZWtH?=
 =?utf-8?B?VHF1VjFCZ0Mwa1RsbGtvTlFGc0E0b0dVenhyZ3lKeXdORlNQODhrd1dsRlo4?=
 =?utf-8?B?N2NJNXBWQktDcFp2MEhLOURUTEo2SFQ5cThtZ2NHaEtVbFJUaERzSVg3RTdt?=
 =?utf-8?B?anlidW14T2Z0aXAxZGxBUmxtSTBuNlg4T3o1SnA0U0xQRkFCSDkrc253Q0cz?=
 =?utf-8?B?cHhvcksrVEtuT01CVEpBbXFRbXg4TWF6dkhRd0tFNE1lR2ZZK0RUUFVYNEJn?=
 =?utf-8?B?Mm9rUHlrbHNxckk5aVhza3B0aDBsY1VlMGZGcFRxVW1rb0ZRT1h3c1RlS21N?=
 =?utf-8?B?OGpQSVZRckhHU1FTRFc1ZzZ0VkhGNXVRWFRnYXZkT2I4ZzRMN2R0YW1xbUNn?=
 =?utf-8?B?SEpRc2x0b2NYcjd4RFV3Z1BHdWl6dlBRYnVjMFBIaldOMEw3Zy9jZGxtRkRC?=
 =?utf-8?B?b1lQZHlqcUg3eXVCUFFwZi84VHpnTW1laU9FQVAyNEV6cjVXWW12ZXIvWWlX?=
 =?utf-8?B?cUw1MzNEU1lvOWlCWU1rWnpDUkJiQTNOS0xwWTMrWWVIOTJMN2dEWTRsdzJY?=
 =?utf-8?B?RTBhYysvQzhSeFg4cEpyQ292R25sMUZsbFA2L1RLcnVYTDB6NThmMmtaRUR4?=
 =?utf-8?B?VXNxbmU2VzlTZUxOY3dBdGg4RVhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 11:23:05.0386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c57044fc-5011-416f-eb48-08de581647eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF28614436A

Hi Breno,

Thanks for posting this series. I've been working closely with our team at 
NVIDIA on this exact issue after the reports from Meta's fleet.

Your analysis is correct, I have some technical feedback on the series:

**Patches 1-2 (IRQ_HANDLED + spinlock for curr_xfer):

These directly address the race we identified. The spinlock-protected read of 
curr_xfer in Patch 2 mirrors the fix we developed internally and resolves the 
TOCTOU race between the timeout handler and the delayed ISR thread.

**Patch 3 (Spinlock in tegra_qspi_setup_transfer_one): Improves formal correctness**

While our original position was that this lock isn't strictly required due to 
call ordering (setup completes before HW start, so no IRQ can fire yet), I 
agree that explicit locking here improves maintainability. It makes the 
synchronization model clearer for future readers and removes any dependency on 
implicit ordering guarantees.

**Patch 4 (device_reset_optional):

Your observation about ACPI platforms lacking _RST is accurate. On server 
platforms, device_reset() fails and logs unnecessary errors. 
device_reset_optional() is the right semantic here. I'd suggest coordinating 
with the device core maintainers (Greg KH, Rafael Wysocki) to ensure this API 
addition gets proper review—it's useful beyond just QSPI.

**Patch 5 (synchronize_irq):

This ensures any in-flight ISR thread completes before we proceed with 
recovery. It closes a potential gap where a delayed ISR could access state 
after a reset. Combined with the spinlock in Patch 2, this provides robust 
protection.

**Patch 6 (Timeout error path): Logic issue—needs rework**

I see a problem here. If QSPI_RDY is not set (hardware actually timed out), 
you return success (0) from tegra_qspi_handle_timeout(). This causes 
__spi_transfer_message_noqueue() to call spi_finalize_current_message() with 
status = 0, signaling success to the client when the transfer actually failed.

The correct behavior should be:
- If QSPI_RDY is set: Hardware completed, recover the data, return success (0)
- If QSPI_RDY is NOT set: True timeout, reset hardware, return error (-ETIMEDOUT)

The current logic inverts this. I'd suggest:

  if (fifo_status & QSPI_RDY) {
      /* HW completed, recover */
      handle_cpu/dma_based_xfer();
      return 0;
  }
  /* True timeout */
  dev_err(..., "Transfer timeout");
  tegra_qspi_handle_error(tqspi);
  return -ETIMEDOUT;

---

I saw your tpm_torture_test.sh in the cover letter. We haven't been able to 
reproduce the issue locally yet—it seems to require the specific TPM device 
configuration and CPU load patterns present in Meta's fleet. If you have 
additional details on the reproduction environment (TPM vendor/model, specific 
workload characteristics, CPU affinity settings), that would help us validate 
the fix on our end.

---

I'm happy to:
- Test this series on our hardware platforms
- Collaborate on v2 with the fixes above
- I will work on hard IRQ handler follow-up that Thierry suggested for 
  long-term robustness

Let me know how you'd like to coordinate. Thanks again for tackling this—it's 
been a high-priority issue for our server customers.

Best regards,
Vishwaroop

