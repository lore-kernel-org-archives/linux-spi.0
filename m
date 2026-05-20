Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013051.outbound.protection.outlook.com [40.93.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EA031F98E;
	Wed, 20 May 2026 19:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779304962; cv=fail; b=PnZcHvyOfZnEry0vjV5YMDIg9BtlrOo7V/xhXtZZxD9G0Y5N/7qv85iD5+ywM/LOEOqEK00lXMp4SyiEzxu4AhhRtPxREhQtyo4VoqkdqEP+xZJAYjfU1YQlykobZ5zcO5hl+DxjF5QAiz8CP5t4XPr3ba3vMIkSUIs3OeQcqSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779304962; c=relaxed/simple;
	bh=DTQf8uF6/3fN2dlkuQNhMv6bmaapxkXSDGGprScROpU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JsVqh/zWKRs1fIbZNeVN1fY1w+nw+lqRhKN8yqfyLblTHqdtFNq6wCN2Oc9xS5cZbSiNdZwyhLMq4gdS73Z+1en+DCYdp4TVmTELi+3V2w+HlTi65Q53aYYxz7ECVYGC3eti+rGR1CRGFGJIjFk6hf/USL0YGERP76TMmVYHef8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eDg8TG9v; arc=fail smtp.client-ip=40.93.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eDg8TG9v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ImHubwkqXpfiaemvr/8ORPzEbcdcQlxQztc6huIkL/xgJWE2uEVklfqMMp+kAcWVcCGJT65npEGR4SiI3DKiukFSxa3Jd/TaOYc30gPiJitPy3YLjXEmiOpl1SNIWq9936uNczBfAGJNuKo2ZWztXjxmbNCpRtTzNr0BMzl5F8LUlghmknIVDnqgGMUWcm4oHmCz7t8GW8sTjU4ZAlZnsJELlKL3yYnqpof5sk71+j+egCfGRMiDIg2L6Xr4aHECvh5NnJ9CRscTSkf6r5P87sYxgcW5cTkjAaQj0yJifPEJlFHCj+R1IibJLYrWyvzc5JC3dwD3kLqVtn6sFLChSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Le5w/1lACj27sVw+b2UFKEAbfDYiNFG3xgN3sjRhuz0=;
 b=lIP1yeXSzR4n3homYJAyl4JTT2huKzX7n6G3vKsVZvP/Q+l856/11t2SEOb55SeK/pCIrbuUlyM6Ymkwq0k0UPgBgoOh85MrScimfz7OjOwwrTJ4TIrZK0OE4g5kWsmWLt6vTKJTUEetkKDDGt0ygJAFrYOVX6z5GzmPKIrXTddEugi09o0Ub2OAyXK2ZPbLhAuLM2snTdLWSUQMRVTD7U66BJBQnLLH3ZfM/lE2DBWgmR5CIgGhv7EnKSF6chXnmOQok+4c2K5q/LujfLsu3r7gaT6a6XcPTJiiahD6F78I1VgvZ+c/Wk9SyQ0U9JNgwt0TUgkPLnGI1D0HHD8MFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=debian.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Le5w/1lACj27sVw+b2UFKEAbfDYiNFG3xgN3sjRhuz0=;
 b=eDg8TG9vp2JHLfWsb79Ydi3Guga35bNhyjD/NVkmFKa2mVGVsCKeIOUz+CNAvOVUkM6pnk4QPsU9d45/fJX7WbKqUv4oH1o/n1LxO1qJNPGon4b3V/tgICcS+1zw26foN997bWLqlfaP9pwXvlXSFS3jh355D1XubcuJm54zWACpxUzGcZGso3Q7IOi7eVgx+MsJzcGuzn4KF0RQeMxP3iQLB5E217XdbFATTesseLay/Sl0/dHPVglwP6hUY2V89uE7w3dWvKROYr+oIK348T/1naaT0VmRIglNSGosaxc3cqBIKpBBOar5m2/s3bYIHH+3Fqop4Iup3y/3SJ9oug==
Received: from MN2PR07CA0012.namprd07.prod.outlook.com (2603:10b6:208:1a0::22)
 by DS0PR12MB7803.namprd12.prod.outlook.com (2603:10b6:8:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 20 May
 2026 19:22:35 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:1a0:cafe::e) by MN2PR07CA0012.outlook.office365.com
 (2603:10b6:208:1a0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 19:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.0 via Frontend Transport; Wed, 20 May 2026 19:22:33 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 12:22:11 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 12:22:11 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Wed, 20 May 2026 12:22:10 -0700
From: Vishwaroop A <va@nvidia.com>
To: Breno Leitao <leitao@debian.org>
CC: Vishwaroop A <va@nvidia.com>, Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>, Sowjanya Komatineni
	<skomatineni@nvidia.com>, Suresh Mangipudi <smangipudi@nvidia.com>, "Krishna
 Yarlagadda" <kyarlagadda@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] spi: tegra210-quad: Convert to hard IRQ with high-priority workqueue
Date: Wed, 20 May 2026 19:22:10 +0000
Message-ID: <20260520192210.70216-1-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <ag3ReYsoyCh-niZH@gmail.com>
References: <20260519155108.4092518-1-va@nvidia.com> <20260519155108.4092518-2-va@nvidia.com> <ag3ReYsoyCh-niZH@gmail.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|DS0PR12MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: 278ac4aa-1e17-4c8a-7e39-08deb6a52490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|4143699003|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+gvYnluQ4smujHZ8V4RyB9BQBn+gyQIJdlDK227pAfMVk0HgIkDsyZA7G619g7zDRZ2TcFYSRoydnXbzEdWe80m20TE0DXjbMImPp2HQ0T6gcJ24nBXyoU6Iozuy37BbVWaMbReWPqvSZhgm/wTLY/x8v0kn33MQery5bmXkZrfcJMLyHaw0uC0CjfWWOJHtCLZyhECUa7F3IxDAO0pW6A7BqPIsAiXJt/IKd12Us7Z4fJ0PjIlZIEWuqWAaYmkYOHx/DyuK3xAUETwRfprY4Cri4oWZs3h24mCIBXTe236KftjaIBlq5JpJd/+AVIYC+gTpP1CBDdTvMaR2n1RtHVPZaizA6ZIkZZP41UDY2NwygGvWpv9mcgKs4MTihuVfbLpYM5wC/qO/+K92lMcfiil/FxKDy4tmIt4HINrkBvm713lDJp5fujo+1+FGPdqhkkb1lHVyCMDMLOdmaJqXShY27dSvdCETQFT8JOIQLU2OmLmI7h6yNTQgPh/8WdrguN+kjOnrxOSkBdki2Bn6zSUzVrVvR1Qmupt3kqXdUyS2+ixAbdNk0+kD/7buOE9Cy2wF2uCKAZIvgzcdtbDFr3NUw5tksxcJVUWutYJ8S0eBF/Ht1Qh1emjMldXart60ajg05StpmzDZgbXvZUFtxHumfXoAtcEkyy1PG6kpOKqeBcG45bG8G/uSQQtk4aAM8hbkWXSGrlFb42e27SE4OTY70X58Xr9Id5Z9MoUhud8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(4143699003)(11063799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7fx8trRwOLXo+zgv57InRY+7M4P6ZlQTDwxSNzJwgZLHyYdhZ6La3KdUt7WoDQZvmaHWKRrn65CxLffNHZAAk9OWTabc65Uea+ayoOWUIfEJzTk4MVRCBZo+fqbq73cuMUT/hczEobETtugoXY7mHMR9cudb1xp7WJtmdcKkhFkG4SrtvhAaSIZTdTkHIm4bTTbGU4BzFgC+tw3dgpnKJ9iVmeh7YB1QGcwWamIFKwXV8tnPgNhIJCODk2pMGPNbw1vEm5mVf2wHJBDUrF2esoCcusymrcGa+6VaJCfb52YbzrcSfw8PxM85ZahNSHo8x+VSJQIOpl6Z3lVHmYfDC1dvCgWfL+uC4oC/wygQQ8ovPqOxGuhM3L5t9QI1oY5+5tx6Kiwa7RyhsE3dx/PmCDJPclp9uBIqe+DnHRRy+sCrZP8BMkZUi6dtZo8yc2Lh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 19:22:33.0595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 278ac4aa-1e17-4c8a-7e39-08deb6a52490
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7803

On Wed, May 20, 2026 at 08:25:23AM -0700, Breno Leitao wrote:
> > +     status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
> > +     if (!(status & QSPI_RDY))
> > +             return IRQ_NONE;
> > +
> > +     spin_lock(&tqspi->lock);
>
> Can you help me to understand what the tqspi->lock protects? I am still
> a bit confused by this lock, but at the first glance, I am wondering if
> you don't need to have the lock while reading the status.

Good question. The QSPI_TRANS_STATUS read before the lock is a hardware
register read (MMIO) used as the IRQF_SHARED ownership check -- we read
QSPI_RDY to determine if this interrupt belongs to us. If not, we
return IRQ_NONE immediately. Taking the lock before this check would
serialize against every unrelated interrupt on the shared line for no
benefit, since we're reading hardware state that no software path can
modify concurrently.

The only CPU-side write to QSPI_TRANS_STATUS is the write-1-to-clear
inside tegra_qspi_mask_clear_irq(), which happens under the lock at
line 1655, after we've already confirmed the interrupt is ours. The
register is also cleared at the start of each new message in
tegra_qspi_setup_transfer_one() -> tegra_qspi_mask_clear_irq(), but
that runs before the transfer is started and interrupts are unmasked,
so there's no overlap with the ISR.

The lock itself protects the software state that is shared between
the ISR, the workqueue bottom-half, and the timeout handler running
in the transfer thread. Specifically, curr_xfer is read and NULLed
by handle_cpu_based_xfer/handle_dma_based_xfer under the lock, and
checked by the timeout handler under the lock, so concurrent access
is serialized. The ISR writes status_reg, tx_status, and rx_status
under the lock before scheduling the workqueue; the workqueue and
transfer thread read them after the scheduling barrier or completion
respectively, so the lock provides the write-side ordering.

The trans_status caching (tqspi->trans_status = status) before the
lock is safe because the ISR is the sole writer in interrupt context.
The only reader is handle_timeout, which reads it under
spin_lock_irqsave after wait_for_completion_timeout expires. The
setup path resets it to zero under the lock before starting each
transfer, well before the ISR can fire.

Vishwaroop
