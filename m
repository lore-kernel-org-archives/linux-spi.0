Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012044.outbound.protection.outlook.com [40.93.195.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7153BB11C;
	Fri, 22 May 2026 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779440980; cv=fail; b=TNQDkTHZy31Jy/y49OjKCi03hWCXnBvBL+sz0G06P/pqOAyQlO/SePH0eq08iY37u1HDvcdtv9BmtDsBdqzKrYGeGrW72dyI+l6zVt9XjC1xP0/0RwOVzsHaSGg4zNDL1KyuYKfCNRfP5IOMNcEY9+qKK9LRnXWki0Tz62ROZvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779440980; c=relaxed/simple;
	bh=SCDf9N7Qwype9bxBdoBcjLxHRbpVoYzaf3mZUor0mWU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S9PuuQ0vOoosQhBaVktFJYyFU/F7ZWeRoAmqxahvQK7x2T34L9z8JLU1+Kbe/xJTR/SNTJ68dPlktLTPQJBRwwEP5fUtl593SFa5qWrP51aFzO2rJGdYFPrsGHbM+Y0MaRM1dmdjRPeEjhC+V5Ejfjdr7ruI80guguyGZJksokI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QxRgaA7i; arc=fail smtp.client-ip=40.93.195.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QxRgaA7i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0WP+B3ADdFgzfYt/0ELSWAl1yvLSc1HcT0SFhJ6waTH4vr2/RfarZ1/hipYOXPN7I7iohBVoavO87Avl92LP6JBJZCibfR9AwVXaSzwookwYKXYfixjtDpkMLz80VXFa6UmBf+TWkr094OECnhSgpPzRM0CWS6+4yzNMzbX05Bc9FuYo+9pxn5aNTxLBDcJKaUTRWoksUdJQTr0WKSRNiBGZ9asGHKi6IDmMKpcRsPxOZnCKWn5ALV6xoLMdDX2HwVmfUHo9TsDi0dMaKnqlZh8iD4I9yYaaz3TN+j2hqsTMj3pHKMFhlSAlt9YjhZ/MvNkFLEFkgNSvzTiQyrFLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCDf9N7Qwype9bxBdoBcjLxHRbpVoYzaf3mZUor0mWU=;
 b=YHDcGam939oKV7mXIZvHKjv+LcDvcpVwcTGsw8Kah1foF7ZxEDfabs3hFHRVoX/eAcan9wrY2/m7/rAvjrZQP+kKmdDgCGlSqVx0oS0DTbUQdo3OkQ9Em74ZsSl2Nps8ylbZdpb8vEi3a50ue0PS6ymj7Hg9yjG9eb9vsHTM4osRnZqCgqtu0QpYuGpNcQwQBbS3b69KWBg+EeLOgP+KbFHPcju6V5IKP9vXDfWkYdNJNaKN7B/HlMqxO8le6V2UtCBZqRetRerT8i5lYaU+wV4fS+u442sLNnbKQt4ksZLLIHtC/QSxNJzyGqYh7kMFoH7t50J8vmmDSbKzTofglQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=debian.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCDf9N7Qwype9bxBdoBcjLxHRbpVoYzaf3mZUor0mWU=;
 b=QxRgaA7iJMqrRz2lr5KE/11bilXfYjZBQGxPRfk+z7FeVCKd459sMc7/kpI2YAjaYCpisucJaOidlVqGq3/NLo3wYD4tUW07j4cTpkCHwRvdaFBw6vwhlev/mpNXLVW2tS0dAoXSZ8HVEgDm68+hhDJSoCvJwIJOYeGqG+rPguaV3Zi3eEl0RamP12DMVWIeA+JA9Ri4SnlXvpmeYkjDubP1R6HXHWkTHoXRkmGF+Zic0EJkMH4zxbK4hGKZ86ldQKFumydoPxBKSKt0MK2bywJDO4vxOr/+cv5/dRgvruBhl7uTCGicbA8u5qf1XNTdHk0qInrZrjPMUAyni0lIig==
Received: from SJ0PR13CA0151.namprd13.prod.outlook.com (2603:10b6:a03:2c7::6)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Fri, 22 May
 2026 09:09:35 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::1d) by SJ0PR13CA0151.outlook.office365.com
 (2603:10b6:a03:2c7::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.8 via Frontend Transport; Fri, 22
 May 2026 09:09:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 09:09:34 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 22 May
 2026 02:09:18 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 22 May 2026 02:09:17 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Fri, 22 May 2026 02:09:17 -0700
From: Vishwaroop A <va@nvidia.com>
To: Breno Leitao <leitao@debian.org>
CC: Vishwaroop A <va@nvidia.com>, Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>, Sowjanya Komatineni
	<skomatineni@nvidia.com>, Suresh Mangipudi <smangipudi@nvidia.com>, "Krishna
 Yarlagadda" <kyarlagadda@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] spi: tegra210-quad: Convert to hard IRQ with high-priority workqueue
Date: Fri, 22 May 2026 09:09:17 +0000
Message-ID: <20260522090917.220650-1-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <ag8dgimI3SfTo1Uy@gmail.com>
References: <20260519155108.4092518-1-va@nvidia.com> <20260519155108.4092518-2-va@nvidia.com> <ag3ReYsoyCh-niZH@gmail.com> <20260520192210.70216-1-va@nvidia.com> <ag8dgimI3SfTo1Uy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|MN2PR12MB4253:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f166e21-bfd5-4761-5d22-08deb7e1d759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|11063799006|4143699003|6133799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	m5huMNOPJTRXO+QrGoC9WYefd4mmBzAD9CBwnJLOQ63vrWso8Gh1AQJGEoYP1X8lIhqzV1HGfwPnqCYn90Ada4cjMK+DMuO5z1la97HB9BKIzMmn47Yfnl9catCaNJ7km1ZOFpNXjF8yNOBDZpdVAIaLhdkz3LvLuymPbFRFOD0qAl0A3HQnR85925/wWxbsFwr1BpYA9bZPeODuna03/jeMuS7RcYGy0DCFxw49R/9AGeGtcobaLlvRyr8EciA97rJ9ct4MO5r5k8Tq44APO/l7LoOsHlJwqhzOMuFDyd14iVnMN4X7mCHREfzgTlzYR1E7BShkBw2pEbcX2YdZtRtgg1qNMCsMjg7eji422vcxoTN/6Nu0r3C13TaFPQmrxPjE1m0JifCNh31CJ5mBoFm0BYkYw+cnMRZRQwK6UT6Sbmfx9xjpmWR8EMDFfn3/dCs2yqq5V+rYdZbUsnX1WKVR7gyu5fEPY0p99YiQf3XtEHoZofN6k6r6UhkQfmJfhAVwTjEMvNoNn4KpULmXqT1TY7DFMuAvG0uS+Z7bm3OoZVXWNgVz/NFMYS9TQvxyDjz6sFOsNrSDwi2zi+rwRhRLpG3bamh80jYEIb0sSrs2hX3MixcPKT4IKzQ5l9yaPDdoLRiGu4lwtiRl8mEj0esusn8bcqkUPXEQSyRIdFZzHVLvks91nEekPShtlNCEEsjsZpsBYwl+UHPL9c5DYLf3zEwXOlhsw6qRzdJc3UI=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(4143699003)(6133799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H13L/DXlWcTspNNt3ee/rrtyens/6TG0RuUc48hD89WD/YjxhQINGoBe8Nd498Q57mpwNoTA2qNZ8C/3NDr+HHF0uYgobbCRiX2PRGf8oycM0KAADSGUf27sKpbAyU1Bf/ClsLlFupNPxVQ4jtlIBFqZAEFuPvHSKk1EoS4NaImEZU60Au8O5eS+lJ7Smf0DSNR3yks9kBxLaQpEeJyElHjACsGGOnrmwP8p+65a46p3rqGnkmQa2bCvBrH4CCpI6kVgib0KtQP+MRBbA0rCHtx7YMt09zlMGHLNeIks7Fa75ZVQ9IFEZB1C1SKdhCwLsIRxj+uN2cOxTfIbPL60fp5goXhULs7OXeH/9eSF02dnFxo7Ziq1f3f7ze7yzTDyL9mmEj+vEZJ6tL8WQ8q3dmus6SffQJ/4aKhSBuWxzX5BNtfcphTtsiemhwpc5xec
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 09:09:34.1067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f166e21-bfd5-4761-5d22-08deb7e1d759
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253

On Thu, May 21, 2026 at 08:04:08AM -0700, Breno Leitao wrote:
> If the lock is really only guarding curr_xfer / status_reg / tx_status
> / rx_status, why hold it across those register accesses at all?

Thanks for pushing on this, it's a fair question and worth spelling
out more carefully.

The lock spans the register accesses because the FIFO_STATUS read and
the tx_status / rx_status / status_reg writes form one update -- the
software fields are populated directly from that read. The bottom-half
(handle_cpu_based_xfer at line 1467) and the timeout handler (which
calls into handle_cpu_based_xfer at line 1098 after releasing its own
acquisition at line 1092) both read tx_status and rx_status under the
same lock. Splitting the lock so the read is outside would let those
callers observe partially updated software state.

The mask_clear_irq call is inside the same critical section because
it is the W1C that retires the interrupt source the ISR just consumed.
Pairing it with the FIFO_STATUS read and the software writes ensures
that any subsequent acquirer of the lock sees either "interrupt is
pending and software fields are stale" or "interrupt is retired and
software fields are current" -- never the middle state.

handle_cpu_based_xfer holds the lock across its FIFO drain and
sub-transfer restart for the same reason: the restart calls
tegra_qspi_unmask_irq, which can re-trigger the ISR before the
handler finishes setting curr_xfer = NULL at line 1497. Releasing
the lock only after that assignment lets the next ISR's critical
section start from a consistent state.

TRANS_STATUS is read outside the lock because that read precedes the
sequence -- it is the IRQF_SHARED ownership check, a single readl
with no associated software state and no RMW. The two CPU-side paths
that clear it are tegra_qspi_mask_clear_irq inside the ISR's locked
section (line 1655) and tegra_qspi_mask_clear_irq from
setup_transfer_one (line 862), which runs before the controller
unmasks its interrupts, so it cannot overlap with an ISR.

Vishwaroop
