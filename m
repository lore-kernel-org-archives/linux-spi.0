Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2138.outbound.protection.partner.outlook.cn [139.219.17.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82A24657D7;
	Wed, 30 Sep 2026 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752562; cv=fail; b=cJ6v40q/eN8A/RzBesvV/DpElX8uf6A53WjuX8dQ/XZL1TSwTW/2nT01cHhzwprS71cc20QEUfQX+3uv+VsdMci+B4CPYYbYzjPqd8BUxYlyvzpfv++gfp1Hy4l3EbLsudamRpGRayB/cJZqlEZIRWBrj5PBF8lhP7FVbocxRY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752562; c=relaxed/simple;
	bh=FlzqjsoL1/HF+E9xlH4JPQ3EOZJsqRSmpLUERqZyw58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j7LVbryxJVPwINpIjSWTb4Gsg9ZU33w81thuf4SNNgg1LFvEkqr4R+V5YMPwZw4k4n1MwKKFtfx5ihbn5ddOh+K9mIw9G9FOAegaoNWMbL9SgrykdSdCqigWxEgicpAhE2U2kEDwmNNag3E/WtXAyF56iJA37dxsBEZpoRARtIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwVK1S4uZnpaBj6G7JF0cUvvk4sErZNAFQiA7aCJTOosX4MdHXO/+8EMM9R4Tn1/RtGvvCqAt4eRHbmmAC5xlMrbENNfZm/nalrnWK103kud5gWCFwLHnCK/CTk6qDYeuUN6ymirCAUERPyq0GdyArG2Of82YOteqZ+Q5djqgxGhnga2PcAtpDCUYey68HqGE24Ffdb9cWB+BfsouUVwYeS0XFwivELWMCmudYOhUaUXDgHJZ/M45QpxPFmeFugF+T00c8f3+BS8z0I6a0bgYARdioNWzo8VFUuBGIXHoAWDaS6YufjDlWsHup0xztmG4A3moHrYBU/nswQnNFzCJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fl7PsDKJTzx3MuYf1l/Gf9oMEh75ChUgX2MYVB5zavU=;
 b=CrEEeNBzMxjgsKNKab1nld5K1bc7WtwrdDWhVbLniNQYyn7EJj6OsNHBNq8u5AFhPSxQ/A/eGHVLZ0z7h1GKWs8/ZhBu5ixo8qLahFIfhPkwZLvMKDMPnRTYGp3r2DdYwY0yyMrcl8BynqC9g41YEEvoZwC14HighFIeeT9daM1MuPmp7BqANF0Spiz6Cj+LvXnWtvzNnbLwtEo7X93OnziC6m7pzVBz5gxvoDSYuQdUgzV6MrDGt+lGW1hHl2WqVm1oHcfW2CoSdWTwZEO9JNWmOXQ2L26em7oOnNoGmLr6oCGxE3ORm8aiNokvDwiPxTai7/hScl064gawKKDzTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1201.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:13::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 07:15:46 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 07:15:46 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mark Brown <broonie@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v2 1/3] spi: dw: Convert the Tx done delay from SCK cycles to time
Date: Wed, 30 Sep 2026 00:15:33 -0700
Message-Id: <20260930071535.7947-2-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260930071535.7947-1-changhuang.liang@starfivetech.com>
References: <20260930071535.7947-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0025.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::7) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1201:EE_
X-MS-Office365-Filtering-Correlation-Id: 306b1137-a321-40a8-be7e-08df1ec2a5cf
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|23010399003|1800799024|10067099003|56012099006|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	dUpk3VmKOEBesN9U4LLxymO6WZLoXB/zLpBZ/d25lQ2SjlgFQSj3Bqub7neFJKeZpMQag4lcz0DQMKOHsiMSDPxChU0x6HFd6sWyP67gPy5bDAyoODYevQjlYqWz0dkO3LT8FYq3ZbTfw2gCXaum5pLJAzHuYH7Qs9zccEK8Zwu1+XGZRBLSkMAf7tTMUz8vJrmxLRNil8Zb/HP7x9ZU4BeoDJSL1GxJDgkJUfk+21zO0ki7rZzAhZMHc2fE5kSBXwpJF5jPbNI9Ptb48+YY5ld++G6l+DRuzIX8ZcmQA3/HOs/xrDsw/WE1iMiQUNYp3maN7r/3KOSv/4vX/cZlvFKr+Qa+dI6KcvqIYI/ceEVUtVyUY8aJ3wV1tpII7AF4ayQTG1MTuKerMO6Yq4iTnMfSKSOTqkBmHANCCpmYom3EJwv7Ui/lL3eYaeg2Mv64LNPAzN/UyibhzbRlgL++iK5hmrEs6XRN6Gp6sgtFdQcNkT+K1HqOSpBz7bpitEzDd7zUUqcRM7Ah5noyAmnyJo9qpsXAEE1/vzLwPPV6Ngw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DFyDf8B/F3mgc2dMz1l9fLXXj4AiGd5olrn39XpfOR6VeRCUtV4Y2lA126nP?=
 =?us-ascii?Q?ojSnvZ0V1hrw+FaLwblGwDqc4srMe6kWuTqBQCnjn+11uiAt8fZlp1PRXNP5?=
 =?us-ascii?Q?XZoFeMBYdtHXC0f0f4R6AxSsh6VGiXn1p1+/Gmomkx+F1teAi1gEHdnKMKiZ?=
 =?us-ascii?Q?+qr5SR1THOgJHD17AjGPVhxuz93l3wxb5vEYrCbI0Ll4bhuCpJz4jQ96ULSl?=
 =?us-ascii?Q?jcoLZY6pIVh5JYMtBoxM2cmNE92N1paAO5a8ywbv4gC94JwSpTS2tK7F4Imp?=
 =?us-ascii?Q?e+qUvixDRLNN9MX+i5gO6dmMvM1rG+lw+43LE1F6j71f1FnRlOLhxfkXYPtn?=
 =?us-ascii?Q?Ep/eeoFBHeTlXy205oyX0Kd5Rtzj4OuN2w6bnR83G3Ly8Qp0OivKs8p64dCf?=
 =?us-ascii?Q?bddEVQb3qASvvah7BCkWq6Cbq/p8CRRu9C+qUZQwXI7TPRj32C1cepoZ9jyY?=
 =?us-ascii?Q?YMrx67l3wk2DmXiCsRomqeIsN3Em8D4IoK9wGody2yFLM4f6YHZjPho3Kj/k?=
 =?us-ascii?Q?phzGmDx7hx1ulW07eoxGm+S73AdSjTZiwwlafwASrsWBvYk4U/i0C6gbBUe1?=
 =?us-ascii?Q?Q0a0Dq9VizE6zr3voH0mNPlqc7Zr7MuM2DJoctRlQWc3Ydc8VtErDYk3yOXz?=
 =?us-ascii?Q?DvnJMet+c5SF3uvrbpvLvVZQlR00ZLJ/Jy7cHtkEcdUXx7zfUnjE0t9T7W9U?=
 =?us-ascii?Q?BR0BD2iJd8GDYhCrGaWE/Sv+Yeg7xMfUbxBHeew6Ie2Q/3OKvP0ymO9/MH/6?=
 =?us-ascii?Q?cYFgx5EvycXXVwwYZWlmBlU5Edl15WY3A9h+u4LkIprQkuxqXqFlCoCW2JY8?=
 =?us-ascii?Q?R8tXosQJD6zfT7QlCRM73kFI7DATcyj/AUyu7YEJ7QUHQnGaVgPKMKXzEwO6?=
 =?us-ascii?Q?63n7MMHoZUM32KRQK1e2tjuMx/V9so2IF1gSOFc/93/xEaxF3978Ac7Rr1W0?=
 =?us-ascii?Q?vEhorfWLdKksVBbyH8iR8kidBq+3Ed6fMQnZ0WCbmT5bWMyeobY5QaxP+Voj?=
 =?us-ascii?Q?Hq43cVMfZVAHEXc5urchU51uTVJaeFdvbC40/qz8rGqek6nakfQHvKlWYUyr?=
 =?us-ascii?Q?1QE4fBrlVhk+w77GgeNSqPONmKOpachanRqmxwrdFo9RG6OSXg/1wyAc1dca?=
 =?us-ascii?Q?qZOXsJlwZBkXeDbFp27YTtt+CSF3MyLnPO3r6ciZs+pLKb8+2+ase1xS9H/x?=
 =?us-ascii?Q?AYUChmqUbMgWahuml0ckzPbrWgbXrpoVP5BlwBpjNQWIz5tO0fB8sQCadh1m?=
 =?us-ascii?Q?8pBuOfK7vRdLTjgAuOyxBbceZxJ/21TCyf3UTHlCV99JjKBisgi/TZF75v12?=
 =?us-ascii?Q?eS/PtGo1DMQvzcnH1ifEB92L0dPzD6xMyoLVm8u1XM/D75yvE199IBB8hKbf?=
 =?us-ascii?Q?vKR6haccWYt/GhhtcbaPhHhK5XgA54Qjpjm+rMXGY+oCwgCnU6XcuzdBNK9v?=
 =?us-ascii?Q?YAM3OlG2QGr+b+Eosb4fW5NZyPRzNJGMsMNjNBLpnNPmbfdQ3nzwpAm7kXve?=
 =?us-ascii?Q?HVLvNo2rAQuifX/hwFlGCnvpGWqJziqSeo2sByd6RVIz2hpb8eVu/v+9IF8/?=
 =?us-ascii?Q?i2INFCbTVbD6tSQ9aYJjQAO7/lR+EHgd4NffxI20+f+s2/poX7GNaceFv2M1?=
 =?us-ascii?Q?8BJZvslanGnFCrKg+oSWSYJR+q0pTJ92s5r3IQdWGPiqitKH4L3rGjbXOEhS?=
 =?us-ascii?Q?+oYsHLHVQja9WXOQxblPtyJENg/UhhUR3PnanVKuo2+FB5XxdFsKk2cegg2G?=
 =?us-ascii?Q?dn4uUIE6mtJN5DnlNzQi8SbM8zI2iRMtMBz5e3TrXa9K4r0lxM3s?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 306b1137-a321-40a8-be7e-08df1ec2a5cf
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 07:15:46.5273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZ+P0JS6EbAZy0od3ZYZTuKYzyJu7pKDGxsfBtLyfR1hSQvbNsAhuPq1rGs/lNrtaOf2jtWrltSOSYT4rf8cfd2OzMGnuN7HOx+kGiaW8E7MgpjT2Y2ko1kNautSJCxi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1201

Currently the delay in dw_spi_dma_wait_tx_done() is expressed in SCK
cycles, which requires passing a valid struct spi_transfer pointer.
This does not work for enhanced SPI memory operations, which are not
described by a spi_transfer. Compute the delay in ns or us based on an
explicit bus speed instead, so that the helper can also be used for
those transfers.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-dma.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index f7d848fec9ab..d0b1a03682e6 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -286,19 +286,27 @@ static inline bool dw_spi_dma_tx_busy(struct dw_spi *dws)
 		(DW_SPI_SR_BUSY | DW_SPI_SR_TF_EMPT)) != DW_SPI_SR_TF_EMPT;
 }
 
-static int dw_spi_dma_wait_tx_done(struct dw_spi *dws,
-				   struct spi_transfer *xfer)
+static int dw_spi_dma_wait_tx_done(struct dw_spi *dws, u32 speed_hz)
 {
 	int retry = DW_SPI_WAIT_RETRIES;
 	struct spi_delay delay;
+	unsigned long ns, us;
 	u32 nents;
 
 	nents = dw_readl(dws, DW_SPI_TXFLR);
-	delay.unit = SPI_DELAY_UNIT_SCK;
-	delay.value = nents * dws->n_bytes * BITS_PER_BYTE;
+	ns = DIV_ROUND_UP(NSEC_PER_SEC, speed_hz) * nents *
+	     dws->n_bytes * BITS_PER_BYTE;
+	if (ns <= NSEC_PER_USEC) {
+		delay.unit = SPI_DELAY_UNIT_NSECS;
+		delay.value = ns;
+	} else {
+		us = DIV_ROUND_UP(ns, NSEC_PER_USEC);
+		delay.unit = SPI_DELAY_UNIT_USECS;
+		delay.value = clamp_val(us, 0, USHRT_MAX);
+	}
 
 	while (dw_spi_dma_tx_busy(dws) && retry--)
-		spi_delay_exec(&delay, xfer);
+		spi_delay_exec(&delay, NULL);
 
 	if (retry < 0) {
 		dev_err(&dws->ctlr->dev, "Tx hanged up\n");
@@ -659,7 +667,7 @@ static int dw_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
 		return ret;
 
 	if (dws->ctlr->cur_msg->status == -EINPROGRESS) {
-		ret = dw_spi_dma_wait_tx_done(dws, xfer);
+		ret = dw_spi_dma_wait_tx_done(dws, xfer->effective_speed_hz);
 		if (ret)
 			return ret;
 	}
-- 
2.25.1

