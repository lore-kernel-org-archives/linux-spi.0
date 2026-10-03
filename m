Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2092.outbound.protection.partner.outlook.cn [139.219.146.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016D2479874;
	Sat,  3 Oct 2026 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791045219; cv=fail; b=oEWryAsgrhIgj4kIdA3Ol7PgNGa+5M9ZJbQw4LN0D1yv4aVtZZCIaB10r31agfCObp0lzLDZW/69P8ul/aGt7rlKlXmacgboACynreffZ+t+0gPBqKVjqlM2gOCfPCyOGATUdU5tK4NZA1Z8MY+gY9AuWGLfN5KoptRrRGIsTGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791045219; c=relaxed/simple;
	bh=pK7A5lRISb2GnQj6Hd43GLKtQkiVvdTJRd4ZfaFTmVs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gfJaDu3m8TqvOEV/LjZpYJIBlr9H6iVCS0ct9zlj7N0XWqFcjll0LRPWo//DtvuhtXr2Y8viHrk/8DKYjcPWRmFDedpKJHmjGbW73a5KWoCiyuJvX/syuAY1KCzcOaFdrfTj7qWFcMlCK/577a7smOD+K2FZwihJoZlkPffPmEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlTBxFN3Bt+6+ryDfz7N0FX2cWgsHbUbPsGXeZrfvFGZur/jD2Wne0/p8xiRHOoBPi85ShAxxFI4TuafgreRnXlryxwnhmtUdJXKecBZFPoqjUXCc9L2RprfkkE/FQOttuK13sR9qHDktKCZDkBgHno/m3wqlucKbdLbNXlEmSDziH7oGLixOQhLU+8v77Yvs9W4glndN+5eIrYYcPMyRcB5z6aMK0xTFs72/PI2M02RkyRumD7HP1HZgB0dcHOwRIIVRSBZbRthwWTfncxJ3w9gfJPfo5iYpsEIiOwRoZbw2EIJZ1iE7S/+jltDQn9oM3Sbp9VrmtnIDLR1dSRSKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iu/YaEg6mgs9/DENN1uvSXrdZwk5MNWJ/U8p+0/xP8=;
 b=ZcKVR2fJR3/0TWr8TuYs3ME5jjwpOtwAAQyi2WmrHX7P868AudDhzk9x8IDDOAGsC1M0aU/hXWmpZyOFhntIE8cfwA9HrnxQKw2jrUj9NaLDQfN5xfd5Qb5pMlgfAmZyAfYIg820G249kqkOmnTB1R5mu0ZG4uGQ7+ZS162/0AC2pW4g42cASvnazqzmFql6ZgeCn9bmx1DQiZQomCxpKF/XqSrOhH1wYyflX1XNfk/Y+KQwEtfSHf98m0DLoayQ6libh27vU89X1PjT+x9IaYYQS2wvqG2d/LsU7HwrmK2eNbxjAcdK4mii8mFEb338AnhijpjXnIChbjm8qjW4NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1265.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 16:18:18 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0472.016; Sat, 3 Oct 2026 16:18:18 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mark Brown <broonie@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH] spi: dw: Unconditionally stop DMA on errors
Date: Sat,  3 Oct 2026 09:18:07 -0700
Message-Id: <20261003161807.59429-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0063.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::30) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1265:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff51cec-5cb0-4e3d-9127-08df2169ef5d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|52116014|366016|10067099003|56012099006|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	urW+d1Bz6zYnVvxSt3mkbj7a2iIKV5t8C/3XnEEqU/GJLWFOP1/DABBpaoEgLcXH4v8ljoJlk5+4qezIHFVQ98T7L8oTXgPR0nDYP+N4J/hcHNfo9wcC6FGsQlB8zkBEIPExMteV6th3FMPkRJ8L6zkeClogdZ/WByby+Rh6uKWh+5iiT2mcfAp2W0sJOx3n+7XJqnRDTrQR3YBG3cccPKhTC+CQjAJBxvEMrEUcdGh4F6J1KN2E4uGtP8yvOEyPUn3IQ42Eg+tFU3yKTggyBCJ6qB+jyFHuNy+66fmpC5G2cXpaSKLX9lVdJYK2NERFr3C1La2Py/Wk+OgMO4u3QuV7Tt26p/pj+Dy21xaenlg6QDpF1GLLwmMXaDf9f67+G2YajNxchCRnKhuSG/QORHrjDhCHB7ZuwATfwQ+27Vm9vTLNpz1XzODKU8i/9DzbANmN3FlAVwXmJvZAp1BbNkK/dFw2ApCDyvmJto0bayvhQZ5X91j5iu++hS1v3xTX35MzyQGDeHCZ4tX+dar2jUHKqx8yp5GCiwawZIg9c67sXpJmkA2d/MJ4Nd8Fd3ij
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(52116014)(366016)(10067099003)(56012099006)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F3BX49FwUXcMB1k3xQMWmgRXmRAt1SwfQxDRzBxuDaZTmUDU7lMdEGHYZ+Ik?=
 =?us-ascii?Q?V+6YpNthLBZ1TXrm1PtE5DWpqsKNowHSIXYNM3HbOJ+E6nqp1Z4+NSRtFItF?=
 =?us-ascii?Q?YdUTTEl8JPuVKgBeskjE98idyK+PgXRYZ/aZ0ia6qFiXk1uAaQGiHJpgszek?=
 =?us-ascii?Q?89dg6MRfaNrwRjDh7roHfi21vP842vXciE0zS+P5lONciK3kqT+08sNNxqpE?=
 =?us-ascii?Q?mnMGimDx7jVgD/PPEWnW8Lv1NZZUwKRKo3UDJJNco/v3dfZJTEcsC+xkfvz+?=
 =?us-ascii?Q?0Y+jy0I1ivbiwbRa9mayjq2U4tiy0lCpo4nu+Dta+sXyxzJFx5iMIkM9JQv3?=
 =?us-ascii?Q?k3o9ZzBxFIGQsKsGDL/lh0Lk4kE8LXO8O8LYSKbbLlp8GsQyqno76PTMJxdP?=
 =?us-ascii?Q?onh/MwbmSP1VeEuIX0QiAk5DXMYUEsipzGsx8KbQ9wbY+8vaxLK0l3zvS7YA?=
 =?us-ascii?Q?ZINy8d2p48Q0OvNQl1WY3+m//d2wOQCP4647aY5aCBWTewJt5YuGvSLUqbcH?=
 =?us-ascii?Q?gynFHhyO49cnIku2le/eoK5P3ohO/CzIoXR0XzOblC7qF/CCDSlmsGDmdXX6?=
 =?us-ascii?Q?wEX/6AK2BhYBgITZcA6xJ9u8mOp37el3F3yTAN0Q/J6HZiCjnRsoeLOWk51x?=
 =?us-ascii?Q?4QFxT1H7L/gwZGC4CK5ivkryiI2rvX6lRCVlfgQE9dcxFNwmwQiO1JaV7yeN?=
 =?us-ascii?Q?EetxdmQDMxsTh47cTQ9NvP731zCVbp/7RDin2oMnlwO9dWzddFVkqOf0jP8J?=
 =?us-ascii?Q?aDDIOlsHU98zn7XCY9PsxKW5C0ZOEpelqKLEhhhimURtU+CbxqqCOyurye87?=
 =?us-ascii?Q?f5FQ7W+qLf2g+pCvN2u7gw5NJsohuIMLzjOoRJgx8aKPmdsCNUjLM6jq3b3P?=
 =?us-ascii?Q?l4yCuCZ4CoBxMRAsmCtZVtIfTSVWF6kF01eBUDNzKtJJ3GCSrWfqm4asxgwM?=
 =?us-ascii?Q?hMI4/Ahdzz5ip6PHtwMpVzg7lULqmVn+B9x0VpwyecANZlnl0kXhL+2/xQZ5?=
 =?us-ascii?Q?PZ5kojAeb3XghFhSTVFVMi/AE5bAVmysP0spoJiQp5RiscdgKVNi6R+XQ+Ob?=
 =?us-ascii?Q?nKoiKwm84ZeP/ThZ5wZWQh6LHaQJnIDpUsHZZ+BU01IUj/jMFZ7ygxQkHRqW?=
 =?us-ascii?Q?F3aqBqaIwE1PD65LGtkUjP3qHSn+GpZXqTH7AAFt5edSrGTc69S06IghyC7K?=
 =?us-ascii?Q?QgNnogptq0E7KbQpBcXIZRnb+M1r/dcauYacqow6NzUxH4K2Sgp5wMHUsDvX?=
 =?us-ascii?Q?IU++52/MkOP4lmyXHpamtMNu6/rKpnUTT20x4jvcBt0l/MhMmjfTziJbXkH0?=
 =?us-ascii?Q?15zgoCWslRTP72FNp0EI5FD+5xByNDp7KnyZD+qfsvM8Ng3FXg/5wG5ylLhO?=
 =?us-ascii?Q?VlfldJbZ4JVqUsSZy9+EnW0Zze8ky3sFctL+RdeSTYE4Q5gP2Oj29e5gy9nN?=
 =?us-ascii?Q?IG9Wr8zxa2pBv9UXYNfhqEPXYyOslMTtGYfiOJ5HXw5FEeXIgG/8YvBpT99V?=
 =?us-ascii?Q?jcsYoIUgyZ9stJI8ayEKXqyDHBcpAniVJ4eNGhglvn4honwq69VBOPsUXK+e?=
 =?us-ascii?Q?F0muAZYiVl2yd4QzWn238n3Gq/E59nccwIZ7qbgm5c0Z4k85UPvNoc5byjUV?=
 =?us-ascii?Q?gYbSHiDTs9vo3RcErWy1M17UtaJMJdcKXHm+84L7kMz3O4K+1H+b13Wpc1B7?=
 =?us-ascii?Q?KBM13yscbUEvrKZAQazYVILnN5nKM3IR5rdlNCiMFtVN8gc5vCqNsM+VP/ug?=
 =?us-ascii?Q?00bJu7uTuZMScYl+M+nAldpQbVj5+azgTp1UGT7vXRNavtpIMzMe?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff51cec-5cb0-4e3d-9127-08df2169ef5d
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 16:18:18.2506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cg4T96/swSkEsmZRRAjrbohCuIz+49puF8/LZ2My91s/B81VB6tLaw0DsvFOVhrDG7zsEK3i09WW4usC7i2Y9O2oqvrTmSyTePz8HX8GiQUWUxl0H8QpYhhsCNBxobmb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1265

dw_spi_dma_stop() and dw_spi_enh_mem_dma_stop() only terminate a DMA
channel when the corresponding busy flag is set. They are only called
on error paths, where the flags are not guaranteed to match the state
of the DMA engine, so a channel may be left running.

Terminate the channels and clear the busy flags unconditionally in
dw_spi_dma_stop(). A channel may be missing when only one DMA channel
is available, so check for that.

With that the enhanced memory operation variant is no longer needed,
use dw_spi_dma_stop() there as well.

Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-dma.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index a86039057988..b706770334a6 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -718,14 +718,18 @@ static int dw_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
 
 static void dw_spi_dma_stop(struct dw_spi *dws)
 {
-	if (test_bit(DW_SPI_TX_BUSY, &dws->dma_chan_busy)) {
+	/*
+	 * This is only called on errors, so don't rely on the busy flags
+	 * being in sync with the DMA engine state. A channel may be missing
+	 * when only one DMA channel is available.
+	 */
+	if (dws->txchan)
 		dmaengine_terminate_sync(dws->txchan);
-		clear_bit(DW_SPI_TX_BUSY, &dws->dma_chan_busy);
-	}
-	if (test_bit(DW_SPI_RX_BUSY, &dws->dma_chan_busy)) {
+	if (dws->rxchan)
 		dmaengine_terminate_sync(dws->rxchan);
-		clear_bit(DW_SPI_RX_BUSY, &dws->dma_chan_busy);
-	}
+
+	clear_bit(DW_SPI_TX_BUSY, &dws->dma_chan_busy);
+	clear_bit(DW_SPI_RX_BUSY, &dws->dma_chan_busy);
 }
 
 /*
@@ -844,21 +848,6 @@ static bool dw_spi_enh_mem_can_dma(struct spi_controller *ctlr)
 	return dws->dma_addr_widths & BIT(dma_bus_width);
 }
 
-static void dw_spi_enh_mem_dma_stop(struct dw_spi *dws)
-{
-	if (dws->tx_dir) {
-		if (test_bit(DW_SPI_TX_BUSY, &dws->dma_chan_busy)) {
-			dmaengine_terminate_sync(dws->txchan);
-			clear_bit(DW_SPI_TX_BUSY, &dws->dma_chan_busy);
-		}
-	} else {
-		if (test_bit(DW_SPI_RX_BUSY, &dws->dma_chan_busy)) {
-			dmaengine_terminate_sync(dws->rxchan);
-			clear_bit(DW_SPI_RX_BUSY, &dws->dma_chan_busy);
-		}
-	}
-}
-
 static int dw_spi_enh_mem_dma_transfer(struct spi_mem *mem, const struct spi_mem_op *op)
 {
 	struct spi_controller *ctlr = mem->spi->controller;
@@ -893,7 +882,7 @@ static int dw_spi_enh_mem_dma_transfer(struct spi_mem *mem, const struct spi_mem
 	}
 
 	if (ret)
-		dw_spi_enh_mem_dma_stop(dws);
+		dw_spi_dma_stop(dws);
 	else
 		ret = dw_spi_check_status(dws, true);
 
-- 
2.25.1

