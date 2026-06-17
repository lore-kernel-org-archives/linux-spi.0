Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010004.outbound.protection.outlook.com [52.101.84.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063653B9943;
	Wed, 17 Jun 2026 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781733336; cv=fail; b=rf+LrdqSuIc/vw72FQ3UrEYO+b/LQ6moIQMWKlXGsD7G0+oJln6TEH9iZ1+16C2r7ZudazCuvoZwtOs7BpfZfJoAx9Fm7Nm4sDDh0vIcsS2Vzwq+jvR36WgwL5CeJFjX53rlG97yPA9EHtUuDGRmxGIICq2idhF6gcezeIzh3fY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781733336; c=relaxed/simple;
	bh=/oyQ/oNOLkDmjDjh9200U8aocuFAgQkxxREpKGI9wo4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E5wajIYZEvdqZvBFF8WbLj0yeplkyRKiMgIFCj2Z+3cFKXCw452WZrcN5N7mcqx1ycoUDrk8LM5d765EzNRcrBEBUQHMxtZAddL9PKDXjIYvblPJBkiPH8D173dfnmUryX/E57pbLyDGhqW1+C5kqatnl7hn3ttOGy73goTUYrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QkmqBW2F; arc=fail smtp.client-ip=52.101.84.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QkmqBW2F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMtHmf5dIMmOvOre0g0BOBL5V3QwzFEbUu+vwGN5Qx17jboy3aYJ/RGZn52WvagnAsTJR701+a+1eOXOP9hEHkUoh/UxCLynnJkE4wAHnecNSrQUE28ZJEb5ofN/taL/b2OtGR5VEfv6RmEiK7UX01D5hy49icixp8L6skJQ29p2JgJ5bVCfAoSnlMix4o3ghfNcnu6oh0zZQSBRdYjaVqR5NO/k0MgYQyr2LAvtHw/EKY3ADxFvZCP8oQi37oly+AqHRPHLGkdQKwdlp4B108r0XcXZI9XHfYVtHeNEijdR69Ca+7N0epvev3s2NY9a8ae2yEEduyUBkBrpWZJJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42Zgyogcx0E4Z9OVLKVN9rJBKb7WQa2eRZggsJZM3x4=;
 b=q/m+WV1uqv+lJxMXoMuqWokem4B+JC21pppVF48FTiIt8aoZteEmRm8rSXZCiamtVsSoA1N0PpRYfApjotsJYH6acygVjcni7Z2/3M6LRQaZpih/FT1627zKEIwpcHyn54Nf9IG9AAYnxQE3fT26T97v7oHLcfAjjS8iZFYmgNANpvYnj2FNvmVtsh48mVqxlgAEmkjVBiVrNf8cySDMAAlyWwntJ2v+QLT/9JGUnJilvqSyGw0ZhLDssbD8WSbRdlebIWbaG3RChxlKlW9j7SZYIY/OA06pPwDHb2CjWAhpxng1bxzNgkfyxnDo6kJcjJmSkkbZmls/tui8QzocfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42Zgyogcx0E4Z9OVLKVN9rJBKb7WQa2eRZggsJZM3x4=;
 b=QkmqBW2Fj/jXWRu16bZt/ZIgrO7Ff6N/TXtXMfXLrruwGmVuSntP+e+i9EznIhPmmUy/z6b/zraDi2wK6OeFYGYkoRC+Zhir1tlDDA64Qv7hBpjb7z/KdtXlFtnCqDWbl5SD1/v5yCELgc09Djiify7U3e/EILWy96KCnk6e3tyKvehl9IOZ57C/ScCA9uB9LlROsdSRplMRBanS4Ud92sSdBUAwlpD+co7jqf+etx+zVUBxQL3KGmab3myPLsaSCVca0+G0ST17ihevV0ZkwNl4hyLYbqznHvbo4ifqMhW0jT31xCzdp8uq1pAgpriK/DuXpSRGPrRa4iAbSNKzXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB9079.eurprd04.prod.outlook.com (2603:10a6:20b:446::12)
 by PA4PR04MB7549.eurprd04.prod.outlook.com (2603:10a6:102:e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Wed, 17 Jun
 2026 21:55:32 +0000
Received: from AS8PR04MB9079.eurprd04.prod.outlook.com
 ([fe80::9761:3d78:e9db:2308]) by AS8PR04MB9079.eurprd04.prod.outlook.com
 ([fe80::9761:3d78:e9db:2308%3]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 21:55:32 +0000
From: han.xu@oss.nxp.com
To: Han Xu <han.xu@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] spi: nxp-xspi: Improve AHB read performance with DMA
Date: Wed, 17 Jun 2026 16:55:18 -0500
Message-Id: <20260617215520.3327836-2-han.xu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617215520.3327836-1-han.xu@oss.nxp.com>
References: <20260617215520.3327836-1-han.xu@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0188.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::16) To AS8PR04MB9079.eurprd04.prod.outlook.com
 (2603:10a6:20b:446::12)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9079:EE_|PA4PR04MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ee3f225-c7a4-446c-9412-08deccbb275f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|19092799006|376014|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bxLu6Qu4jkUbpPBnAobEuogL8kpdlvSCMbFT8SxIq+UZ0krWNIP5P0fY/pVZVU2el8oBrfqWzTTr0HPixDKG9uEw1EGtJN7/OkWsAXGfJbWKuEGvlbHhk/6LnbPpCkBZ5MKUsUDQicM0JGwfM1i3WAX+BTJrR4jvS9anccBWrbR2I+cckZpYn5xnQXGKzww7Prd3MXthX+uQgjNyGnhCq94ZAEaWp9blNg/NOx/M8J/3f5qUS/eqdyaO8WRAs5lHuUOoHI/NJm/YiMpxVXUWw+DyIVCqUFZOdcZBnyXmMCg4dUBkBLc759wY4VzYwz9/4ga+COPLdjq3nhmOfEVVOgicl8DQ9xDrVKY/X3RmO+LGy9QB++gBS/qjTBG06wUPVMyKDZ6tBTs4KzP9fjix+eQoblibs1NtDds47O6b7rkW8bj7B1e++KVcQW3+B8G/nz8TWRUquaEtEHcx7qepdjrurVWPS3lUJIP5hyRE3E2kdx2q+8df6P62rGzDs2DDW+egxDP9c2Fbfr9qXqrulwusvxLlRCfzsJksL0CTstBjiCLVlP3DEoemNiDKAAPI9v73+5MOoFV81+xko9RtDHcXgsdDvwztHNSYc/L3QnQz31WqRPsF77BV7PrJLFgFNrWQEQxTcmhp8/3fghHO+M/PCliL9AXvk4xv5F8GjKr37HxAHAtimHvw0OWw3AXu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9079.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(376014)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aQuBCpErhlyGFMGB1Heeu6eYwVeR8zgMR6UxEsz6uYkpbaTsn65VNQcWeUKK?=
 =?us-ascii?Q?DpmYP63pbbE3pbJtHsvf4ZpuAD+scSZO9RzmpQnBM/cNgMN+CCnDICD9affC?=
 =?us-ascii?Q?a/kpPmd9HwMOt2wwO971fOu2ReFZvrE43m3w/Ii0c7G+F7xHhlp3LTX3PJFi?=
 =?us-ascii?Q?uVUBwJLZUrTgmxb6IwhJvF4qrnK5pE1kmibwjnuDCl9wlJy1GTxXrXv2CNrj?=
 =?us-ascii?Q?MeLGEAQAW/qvRGYFRH7dMmHJjXISXoBoKt1fQu4vu6Erfzc0JVY4V4g+8PL7?=
 =?us-ascii?Q?G/jxJDb7wJm1JsMq1jl0A5MRXLBX5J98Fy4xQSkYuQ/S/mKRk03/ljc6U0Dh?=
 =?us-ascii?Q?z6KxqrVCxEXEgOhJhrnaLMR3Gb3ZJQdtxj8Xy4FulT7U9/WWgfRHTq4ha6OA?=
 =?us-ascii?Q?rSTvuVYtQJn4+4EFpkNieqJ0rMAEtI0Pq31a4ifrbT/qBlGsFgdbyCoZXruj?=
 =?us-ascii?Q?y433JMcMUL0pPJduESNJHs7f+FKXb6u+G3KSgp37FnRdhudPApnXoHJziRF1?=
 =?us-ascii?Q?ofvOEhPfEULITObSXwDvwyfGHDUD4wVkbjC0/rV/I9qXh1qktBV6Jgq618oP?=
 =?us-ascii?Q?aRp6A9RGADPu9aYvSfTLUtYziPdIPvBRzW6rKZ6kOGfgOI8grl/iuhXIvfaE?=
 =?us-ascii?Q?42gA6fAwJRe20tzueUpbWumta/Rfaq6vdv5yIbsMdFSd48c0XJk7BdWQltUr?=
 =?us-ascii?Q?+b1oLmCIKAU1QfFmIv4vogyAQAYI62t7JSv5p75zqP410Tbof98ShaMKOBIX?=
 =?us-ascii?Q?o8eA4M7JVARNFJby6CpoKUdhpC4AcjkJbgGRm2kUNvVWOc7fLN1bF7UwvtF3?=
 =?us-ascii?Q?AHwIMSB6sYnpJMXbSayD69pk6c7TayQEqu7XOKNnoQ9arM/M9gMJlTM3j1lf?=
 =?us-ascii?Q?gGXxSJu+vzM8GCgOicsvg7oaXDjyMOpYSguyYgiY0+44/8jIJaAM8cg4SZCQ?=
 =?us-ascii?Q?faYMybe83UuoNQ+jlzvpmLQZjXTkB9LZfPb7Uqow6cYbCRPslMb9T7bi4nhP?=
 =?us-ascii?Q?AX45ocqeXzrHcNh9p54VLH00uzlgkzxVfGEHfXDXhZ8RzekbjHuQ7sA6kL92?=
 =?us-ascii?Q?SagKgJ4Mp0p/Plbz2jV9ink+1SGILGAqFx4vkUsseOXZR9K2q68dtuJVgMXS?=
 =?us-ascii?Q?CYOFhQBZYwCeTRQxBvFFJnC3pI2iPsw9DsPl1NBXje4HjyNYVfdK7zTWCUuB?=
 =?us-ascii?Q?QLzttouFdzV9E9J4Y5Yw1gBFayCAsgXIRTyYp9rHRG7p07XnjdjJFq2YfjWr?=
 =?us-ascii?Q?hPF9Fjuj61gJdgNF1QHt17v+yT8m2ZwgVdCX4k7wY7kOrugD8xU2PYzo+YxL?=
 =?us-ascii?Q?a+80vRB+Tp1z3nZPEU2VgzeHXH+Jmxh/9EzN4G/IK5zIhucWv7urapndKBrf?=
 =?us-ascii?Q?r2IA2vYNdNJd/VTUFV7+zk9J5qzW70P5H4lsvAbqAOuhGgtirFrOxct4D06p?=
 =?us-ascii?Q?a326x5P7dC2lBvEenYXKqzIBc8IgPbLjC7B1ecVgVQMAgo3N98iYuCLQhoIr?=
 =?us-ascii?Q?NwjnoF7UFB24PFMcNbLpJd8mG1FVLXRs67MkkuqJPJ5nLBhqF9qhYvaQ2eUb?=
 =?us-ascii?Q?lNum4YC2pzmjn4/foW0BMaS2EuMdkhs6dsuY94Er+YnqLHHspO0F6af1oAq4?=
 =?us-ascii?Q?Dk+epPPoRS8B/nX2c0sVWJZZ0if4So8VP8Fv95qsnv/S/3o/YfV+d7SXsBWO?=
 =?us-ascii?Q?ugPFOr4ju6PIyV3Ccw6w4tkuVZNRadpORwJT2gjAVsEZlC07zRUGYYvpS/F+?=
 =?us-ascii?Q?9odgD7XO0vijDCs6PMjgoDbtodTPVwc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee3f225-c7a4-446c-9412-08deccbb275f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9079.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 21:55:32.6526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sp77hzimrvKQXawN63Z8hj/8mbA/D4MdhFiEutk76wNIezO3UkOACZTbzlATeE0gkx9t382LuReH4COqK5+4k6EeMvcf3Ng0TtHzhQZ7w1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7549

From: Han Xu <han.xu@nxp.com>

Use eDMA for XSPI AHB read to improve the performance.

Read with CPU
root@imx943evk:~# dd if=/dev/mtd0 of=/dev/null bs=32M count=1
1+0 records in
1+0 records out
33554432 bytes (34 MB, 32 MiB) copied, 0.479719 s, 69.9 MB/s

Read with DMA
root@imx943evk:~# dd if=/dev/mtd0 of=/dev/null bs=32M count=1
1+0 records in
1+0 records out
33554432 bytes (34 MB, 32 MiB) copied, 0.115788 s, 290 MB/s

Signed-off-by: Han Xu <han.xu@nxp.com>
---
 drivers/spi/spi-nxp-xspi.c | 118 +++++++++++++++++++++++++++++++++++--
 1 file changed, 114 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-nxp-xspi.c b/drivers/spi/spi-nxp-xspi.c
index 037eac24e6fd2..0f614dc20799f 100644
--- a/drivers/spi/spi-nxp-xspi.c
+++ b/drivers/spi/spi-nxp-xspi.c
@@ -35,6 +35,8 @@
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
@@ -303,6 +305,8 @@
 	(opr)) << (((idx) % 2) * OPRND_SHIFT))
 
 #define NXP_XSPI_MIN_IOMAP	SZ_4M
+#define NXP_XSPI_DMA_TOUT	5000 /* ms */
+#define NXP_XSPI_DMA_ALIGN	32
 #define NXP_XSPI_MAX_CHIPSELECT		2
 #define POLL_TOUT_US		5000
 
@@ -336,6 +340,8 @@ struct nxp_xspi {
 	/* mutex lock for each operation */
 	struct mutex lock;
 	int selected;
+	struct dma_chan *dma_rx;
+	struct completion dma_rx_c;
 #define XSPI_DTR_PROTO		BIT(0)
 	int flags;
 	/* Save the previous operation clock rate */
@@ -796,6 +802,78 @@ static int nxp_xspi_ahb_read(struct nxp_xspi *xspi, const struct spi_mem_op *op)
 	return 0;
 }
 
+static int nxp_xspi_dma_init(struct device *dev, struct nxp_xspi *xspi)
+{
+	xspi->dma_rx = dma_request_chan(dev, "rx");
+	if (IS_ERR(xspi->dma_rx)) {
+		int ret = PTR_ERR(xspi->dma_rx);
+
+		xspi->dma_rx = NULL;
+		if (ret == -EPROBE_DEFER)
+			return ret;
+		dev_dbg(dev, "NO DMA RX channel, falling back to CPU read\n");
+		return 0;
+	}
+	init_completion(&xspi->dma_rx_c);
+
+	return 0;
+}
+
+static void nxp_xspi_dma_rx_callback(void *data)
+{
+	struct nxp_xspi *xspi = data;
+
+	complete(&xspi->dma_rx_c);
+}
+
+static int nxp_xspi_ahb_dma_read(struct nxp_xspi *xspi,
+				 const struct spi_mem_op *op)
+{
+	struct dma_async_tx_descriptor *desc;
+	struct dma_chan *chan = xspi->dma_rx;
+	unsigned long timeout;
+	dma_addr_t dma_addr;
+	int ret = 0;
+
+	dma_addr = dma_map_single(chan->device->dev,
+				  op->data.buf.in, op->data.nbytes,
+				  DMA_FROM_DEVICE);
+
+	if (dma_mapping_error(chan->device->dev, dma_addr)) {
+		dev_err(xspi->dev, "failed to map DMA buffer for AHB read\n");
+		return -ENOMEM;
+	}
+
+	desc = dmaengine_prep_dma_memcpy(chan, dma_addr,
+					 xspi->memmap_phy + op->addr.val,
+					 op->data.nbytes,
+					 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc) {
+		dev_err(xspi->dev, "failed to prepare AHB RX DMA descriptor\n");
+		ret = -EIO;
+		goto err_unmap;
+	}
+	desc->callback = nxp_xspi_dma_rx_callback;
+	desc->callback_param = xspi;
+	reinit_completion(&xspi->dma_rx_c);
+	dmaengine_submit(desc);
+	dma_async_issue_pending(chan);
+
+	timeout = wait_for_completion_timeout(&xspi->dma_rx_c,
+					      msecs_to_jiffies(NXP_XSPI_DMA_TOUT));
+	if (!timeout) {
+		dev_err(xspi->dev, "AHB RX DMA timeout\n");
+		dmaengine_terminate_sync(chan);
+		ret = -ETIMEDOUT;
+	}
+
+err_unmap:
+	dma_unmap_single(chan->device->dev, dma_addr,
+			 op->data.nbytes, DMA_FROM_DEVICE);
+
+	return ret;
+}
+
 static int nxp_xspi_fill_txfifo(struct nxp_xspi *xspi,
 				 const struct spi_mem_op *op)
 {
@@ -1016,10 +1094,15 @@ static int nxp_xspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	 *     all use IP write.
 	 */
 	if ((op->data.dir == SPI_MEM_DATA_IN) && !needs_ip_only(xspi)
-		&& ((op->addr.val + op->data.nbytes) <= xspi->memmap_phy_size))
-		err = nxp_xspi_ahb_read(xspi, op);
-	else
+		&& ((op->addr.val + op->data.nbytes) <= xspi->memmap_phy_size)) {
+	/* use DMA for transfers no less than ahb_buf_size, when DMA is available */
+		if (xspi->dma_rx && op->data.nbytes >= xspi->devtype_data->ahb_buf_size)
+			err = nxp_xspi_ahb_dma_read(xspi, op);
+		else
+			err = nxp_xspi_ahb_read(xspi, op);
+	} else {
 		err = nxp_xspi_do_op(xspi, op);
+	}
 
 	nxp_xspi_sw_reset(xspi);
 
@@ -1042,6 +1125,24 @@ static int nxp_xspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 		if (!needs_ip_only(xspi) && (op->addr.val < xspi->memmap_phy_size)
 			&& ((op->addr.val + op->data.nbytes) > xspi->memmap_phy_size))
 			op->data.nbytes = xspi->memmap_phy_size - op->addr.val;
+
+		/*
+		 * For AHB DMA read, align the transfer to NXP_XSPI_DMA_ALIGN
+		 * boundaries. If the start address is unaligned, shorten this
+		 * transfer so the next one starts on an aligned boundary.
+		 * Otherwise, if the length is unaligned, round it down.
+		 */
+		if (xspi->dma_rx && !needs_ip_only(xspi) &&
+		    (op->data.nbytes >= xspi->devtype_data->ahb_buf_size)) {
+			if (op->addr.val % NXP_XSPI_DMA_ALIGN)
+				op->data.nbytes =
+					ALIGN(op->addr.val, NXP_XSPI_DMA_ALIGN) -
+					op->addr.val;
+			else if (op->data.nbytes % NXP_XSPI_DMA_ALIGN)
+				op->data.nbytes =
+					ALIGN_DOWN(op->data.nbytes,
+					NXP_XSPI_DMA_ALIGN);
+		}
 	}
 
 	return 0;
@@ -1203,6 +1304,10 @@ static void nxp_xspi_cleanup(void *data)
 
 	if (xspi->ahb_addr)
 		iounmap(xspi->ahb_addr);
+	if (xspi->dma_rx) {
+		dmaengine_terminate_sync(xspi->dma_rx);
+		dma_release_channel(xspi->dma_rx);
+	}
 }
 
 static int nxp_xspi_probe(struct platform_device *pdev)
@@ -1250,7 +1355,12 @@ static int nxp_xspi_probe(struct platform_device *pdev)
 	/* Find the irq */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		return dev_err_probe(dev, irq,  "Failed to get irq source");
+		return dev_err_probe(dev, irq, "Failed to get irq source");
+
+	/* DMA is optional, failure(other than -EPROBE_DEFER) falls back to CPU */
+	ret = nxp_xspi_dma_init(dev, xspi);
+	if (ret == -EPROBE_DEFER)
+		return ret;
 
 	pm_runtime_set_autosuspend_delay(dev, XSPI_RPM_TIMEOUT_MS);
 	pm_runtime_use_autosuspend(dev);
-- 
2.34.1

