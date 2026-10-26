Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793013274;
	b=3JYlkeBHwVV1Ktx1ZmBTMp5OEOCILePn8z6F130WdKLGolhvguNwx7wYePz3eifJqsu1
	 sPIB7XNrjpcb1FkBeO6Yxk5TWVI4DEh1UE/EHEQLO4zV61DFt4Y0asorsuwU++kiDFL+C
	 fBobU1lxG5oiHICbhLnl7XUVq1y/Gxkdu41M94jspYYAK7WmbE7PtCNjW3fg+Hsm2T3Im
	 Ql/7W1PkDTxSYu4+Qik9YAT2xXxxn9X1rXHJFZ+HWDlDxbbqLGJbtmfe/E54IUCWxQU//
	 LjR2HbDay/HNFUNY3ChwUfugbOO470l0b7yzDUWmkKSHaGofeg+A+uBuOoUE7mxRn1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013274;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=wJGijo6Al++al8iGH/Ej/Mi73ahc52O/w97pbUTwb9o=;
	b=VpDLdxmWq4bkzxe0LRgv84wIyC4RiUXD+gQmdsblzXs1W9mlYadzjrVN8jZnYD79o4dR
	 4xY6gOUNgjECj36V0DyT5RQEzTjT+D+KHHSmwtYnB55sTfBJs1YOGoTD8pZ2NTe8F1aRI
	 YeeM3X/BidiRlDBcPdh7Jg813miOy1NbLXvtKUH7SbF1pWin5esHgM6SjIzGulF5RW2XO
	 TSbxD/z5WV3cPw71mXPR9wya9oPcXgOqkXrw3gi4BXNComm21opvWIc6LVGMI7ZOBPf4D
	 Pn9AwItz3SdfthOBjZkLAsmgUf/l1zhDSYHzb8cpe+0GoXBe9TDCPle26dstOdjN3dQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=neJAxjmq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.16
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010016.outbound.protection.outlook.com [40.93.198.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19591606A90B;
	Mon, 26 Oct 2026 11:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19591606A90B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=neJAxjmq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3GBBdornhKhl517EfaDXRjwv3LIVrwssbt0K2IE8eiPjXtJK7yfTIOTVGye/J+o5LCW7xU/LH1HIX7lq7SCtMQEomYLjL89h5sedE3e/CZ0ML6tmJWIDgZTKaTlUEBHkG0N7N0SHHg0Am1Nia1H4qtrKQxYV8+T9aCH7TWkQcrLgtaAonD0Qh2M05j/1n5iIpkkUnuh/k6pe41l4N8VTM8aUoC279dYn7jQYPNUQAjs304r/cpQfYFzDGuKYEo4Gw6Di1ksdFwDse890n/BVJ3QdXpzCT8SEDT77WJ0Ggca8YBSJ/mndKtweUzb/uRUwZhwAY9gr7I6y6xY0PpLIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJGijo6Al++al8iGH/Ej/Mi73ahc52O/w97pbUTwb9o=;
 b=OSJbfrzHyGevgdhrcCOyBfTvdoH49jwOLYv05onA/EvZVnNZnXu3fjKgBI7ZbeKw1sPl+OPeMaCLRe1MxKHSOTKvt1wu62ykUYHWPA34FIXwYRJiToXDUOAdslvTu5bKVzKGM9BQnckOtR0lFsB6yPKrJfCMSJRUq2zb8GgU/ZSv1HpRGE87VDgP1x3/1pjW6dvrCPpMMBt18Vg0mPhFRq2HyatK4fCuI0tpAcPArjVF4nb3huN0wnEGLtwiMw9ER7V5IMD9j4MC5sfRMP0ozCCf+TXIw9U7P1BSoYcwFp1KnA6olu1XBkmZXtcQ6U8Hz15hTyLW9izkaEdCeQF2VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJGijo6Al++al8iGH/Ej/Mi73ahc52O/w97pbUTwb9o=;
 b=neJAxjmqSqVTxsfjj4TVaFNeSYStgxIE6eVq9DxTnGfvcSj4BBuijvhRdU99ZlktE4Fg29rHdDUMj2qW3x+3Y62S9BtjCmLJ7OWSN9W3dhbtJVL+bI386MkRWKaJSKTV/pJUCV51w5cGLs0PvbngtKIWJF+Be8+fymMyYUqwbDlkXlVEjet4BM5IMVIGptlaufDqJFMAuSGo9NopOdYFKotGUuE5ZIQcNTnF6z/AEYbXwM5hBD77xMZpxIx98j1Q5f6uhnUevhZ7vA/ITXr9dyhaDvcnpCCE0wNhNje+AK6E3vB5ftGXujDEgKGk8ltGWoybNg7DHGpxOaM/cawTng==
Received: from BN0PR04CA0071.namprd04.prod.outlook.com (2603:10b6:408:ea::16)
 by SJ0PR12MB6736.namprd12.prod.outlook.com (2603:10b6:a03:47a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 11:14:29 +0000
Received: from BN2PEPF0000A890.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::41) by BN0PR04CA0071.outlook.office365.com
 (2603:10b6:408:ea::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 11:14:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF0000A890.mail.protection.outlook.com (10.167.248.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 11:14:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 04:14:13 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 26 Oct 2026 04:14:12 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56
 via Frontend Transport; Mon, 26 Oct 2026 04:14:12 -0700
From: Vishwaroop A <va@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter
	<jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>
CC: Sowjanya Komatineni <skomatineni@nvidia.com>, Laxman Dewangan
	<ldewangan@nvidia.com>, Breno Leitao <leitao@debian.org>, Aaron Kling
	<webgeek1234@gmail.com>, Carol Soto <csoto@nvidia.com>, Suresh Mangipudi
	<smangipudi@nvidia.com>, Vishwaroop A <va@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] spi: tegra210-quad: Fix timeout path status handling and DMA leak
Date: Mon, 26 Oct 2026 11:14:09 +0000
Message-ID: <20261026111412.3843954-1-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A890:EE_|SJ0PR12MB6736:EE_
X-MS-Office365-Filtering-Correlation-Id: 738bf7c3-e099-4857-cc55-08df33524d65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|10067099003|18002099003|13003099007|56012099006|11063799006|5023799004|261021121427099003|261009223027099003|261022105027099003|261022075727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	13hAKw6RzRHpf0YI10vUYcM7SrZIMtCYsmVt/Ty+khkeLlZVpJzy4U3x/TIxs/G0c+MaOCigziJhlkYd8Tda9KdJvvKCmyxDApKmDhDJ9bvFeyYcfKCH5nFnE4mmpodDR6YVx/7OrWjV1STFGxyWJPAcjHSfxVr4it6II2QWpF9oENnHKpto0lQ8EQsy52AtPbA1LtLPdh0eXX678KVs3lUtjPn14pPDItaQ5ex+30A1qUSQLoNQ+2z63Z1DOJV+6SHTmtn3Fzq9M+wSlA0w4t6Ca0l6/xunkL8J4HIKMTmQ9V2AbrJmp0Yhop1TZL5O4nt3bPdzyMSVKfD4LfTF8ZSlZL84KO/udk9WEJggCnYDnvVkjS2nl1QE6IGYOvD62f5nzuklFIyjGnrNaU8cOTi7Mt9Hu5wKFel5qEU7hCYwG6Mp8/ZjAv1xAXx7kDTBk63mytcCnAxRKMyG3ZNjSbYUkmm8EdUJMYCzwqomAjRYn2QqsFq/FVyQ+foOHBKlDkjJrS3AhrH63CtdlgHSAk5perhxdhtqMV/BIbN1H5zpM7vhIilEfnhkK8STdm+KmamI73D7W9In7RQFgtvS5lIKCLeAjduIdzXOo7dOgu5za86pYTgATY71L67B9fdUHIBHaypMyE4kBLi9nasnWQH++iJlM2T4BMHvxcjaIkJ9iSlXbi8h0OW+DgLcB2krCTgWhxCMo3IpUKU7wXBqyQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(10067099003)(18002099003)(13003099007)(56012099006)(11063799006)(5023799004)(261021121427099003)(261009223027099003)(261022105027099003)(261022075727099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QXqxou0ByT+38NiA2PhP/cYqNDhW+Hs2gK3VrXb/eTzWnnCOABwOyDuKZgdbXuYg7v+Cx7V/jJnOJsjKSluf8piz6FE/fIUyrIp2yxr3u8ZgS3rZbk5numIMXdO0Y1JZHD5fOsxCw5oSi8/EJ8OKxTmYb75DcqFOM5w4Kvc5oxrkYy6xCxaOl8g+CviHL6nPLjW+OZ+nclgvrOKwA7pCzR41om3o8noANaghdKlk5/oLqvFlhlmQHkTR1I9CpIaelGI/3AcOV46TttWP549Dj8xdbaBCJqZsvYoDJdwunLp6tNsBqCS/qi6MlgWqouBiesVK6lxbxlzcPYHzIWjsO7Hikgv756A4JKwbDMzt/LXSlYdyY+Gs+tqR/MmpeJi2uS/gsqg9ptSrSmGcrr7Tp/Ll5vpv7PF5p48GDOHbaKb5HKu9aNiIrILq2eNPMx+6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 11:14:28.6883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 738bf7c3-e099-4857-cc55-08df33524d65
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A890.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6736

Three fixes in the Tegra QSPI transfer timeout path: the two from v1, plus
one new patch out of Mark's review.

Patch 1 fixes a regression from commit 1ff82c13ea94 ("spi: tegra210-quad:
Cache TRANS_STATUS in ISR for timeout handler"), currently in linux-next
only. When tegra_qspi_handle_timeout() observes a real ISR completion
after draining the workqueue, it still publishes the pre-drain lost-IRQ
FIFO snapshot. That snapshot can hold zeroed error bits if the ISR W1C-ed
the hardware between the two reads, which makes the manual completion
handler downstream accept a transfer that actually reported a FIFO
underflow or overflow. No stable backport is needed because the offending
commit has not been released.

Patch 2 is new in v2. Mark observed that the unmap added by patch 3 can
run for a transfer flagged as DMA that has nothing mapped, which happens
when one chunk of a multi-chunk transfer completes and the next fails in
tegra_qspi_dma_map_xfer(). The same hazard is already reachable through
handle_dma_based_xfer()'s own cleanup, so rather than special-case the new
site this records the mapping state and makes tegra_qspi_dma_unmap_xfer()
a no-op when nothing is outstanding. Failing the transfer on a start
error, the other option Mark offered, is left for a follow-up along with
the mappings leaked by tegra_qspi_start_dma_based_transfer()'s own error
returns. Tagged for stable.

Patch 3 fixes a DMA mapping leak present since the driver was added. The
only unmap lives in handle_dma_based_xfer(), which runs from the interrupt
bottom half, so on a genuine timeout the bottom half never runs and both
transfer paths abort without unmapping. Every real timeout therefore leaks
the streaming mappings for that chunk, gradually exhausting the IOVA space
on systems with an IOMMU in front of QSPI. Tagged for stable, and it has
to be applied after patch 2, which its stable tag records.

Neither patch 2 nor patch 3 applies to a released tree as posted, although
both bugs are older than the code they are written against: patch 2 needs
tqspi->tx_dma_dev and tqspi->rx_dma_dev from commit f469138a77ac, itself
still linux-next only, and patch 3 collides with the WARN_ON() calls added
to the timeout paths after v6.19. I will send adapted backports once this
series lands.

Changes in v2:
 - New patch 2 recording DMA mapping state, so patch 3's unmap cannot run
   against a stale or never-created mapping (Mark Brown).
 - Picked up Breno's Reviewed-by on patch 1.
 - Recorded patch 2 as a stable prerequisite on patch 3's tag.
 - Rebased onto next-20261023; patch 1 and patch 3 code is unchanged.

v1: https://lore.kernel.org/r/20261016132520.3723412-1-va@nvidia.com

Vishwaroop A (3):
  spi: tegra210-quad: don't overwrite refreshed status with lost-IRQ
    snapshot
  spi: tegra210-quad: Track DMA mapping state
  spi: tegra210-quad: Unmap DMA buffers on transfer timeout

 drivers/spi/spi-tegra210-quad.c | 52 ++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 10 deletions(-)


base-commit: 20a33c6b6cbe7e4805dfb6cd68816937443aa148
-- 
2.17.1

