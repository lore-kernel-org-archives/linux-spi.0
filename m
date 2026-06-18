Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013007.outbound.protection.outlook.com [40.107.159.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60262BDC28;
	Thu, 18 Jun 2026 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781788957; cv=fail; b=RQu3kZA/FTaIhhZ8/TKowb5QGNXciqGMAbq4Y8fZ7PJ2CcHrWCmQR2R4gNvkxyrY0kY9KKGqjzyIppmZHSLOOzETcNYP9qlL6R8DDYuEKnG/0e0ovtuKnJws9hCmF4xcb52jYlhLCbC11BGVNBeQiTAvqgb0EurtFECG9+mltRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781788957; c=relaxed/simple;
	bh=SqL7b4X8Nas1xZvHVYZfQxkXWjqGfltZy9CUCx8rVq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ebmqF7PEwEUgDsCHvtWIOXGNCfwg+IZAOF+SM11b3/lMpF0yFMx7NKAFbD0cDtMZ1u7eFTmOdiWjN1S1Z5iUk6VY0by8M8OShO0YNUB8/pSXVLMn6nERmM77/B5uth5rVShBDD4VoYOX5YT6IXFEXAvpuqaOBEecxcLnaHF3FnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Hfz3OhoS; arc=fail smtp.client-ip=40.107.159.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Hfz3OhoS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwjW2BtMPD3zMIs1X0iJD6rC8w0JqCukAd6Z6OxAsfzcWeeeeIVL4F7Ywud5VpetxJqYVs5yQfSDgdrvQzs9wSSon69vnQkhBvsNQ00oJ2u8DXPNWgqB7Xx4JUjaS04htbfViIhnFjCg3n+AA5CBnUJpS4/U0SeQeMBI1dHQ2kYrDvi6Wacsg1xIfwJx/DsztTIvlTvWPfubBFhTQUEZosKGAYEWdytyVus+oooZ5hU0vQbYxBPauN+v7E7lQNoOAzw+1IV1fZnhDWDbo6E6X/Tv3rlQKjIJP0vB32LkIOL26VhIGMYoL1mw0mlkPxaIqtqklOO7Cd/8C+Ss96zpDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzzum1Hs0VO1PLhaylidLeJTBnHRQqR5WgTm8pQWjGQ=;
 b=eLmbX8V5UTbY1MkbAyPygaNibPr7Hx8yWVI7PH2HZq4WmVFUfIk6LNyr+nA4+LRZCsu1jA5HdWIyZk0p/Tk8LYpRDM0Bs2v2YwAjNbboMk0wcYtiIfj/RU32g6inmSaF/q7znehrXMzfe3NCZXWeReH6mu6X3PGCz9I1y+eY3J+KsDCkm/ZBDxAhVUJG5TdiSDEEDy5fJOS7HisAHVEGgwQUoSQ6+4De98TxgbAQzqbIyuKUQA2XYVwCj2Jp+RS2XVgdrvDbNMyMxJIzuJAjvJkf4yLmeBFbUGivk7ElHw6eTEgAX4BTPrKpkzHD0tYzLvhzpK8thynaP0dBIXNKrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzzum1Hs0VO1PLhaylidLeJTBnHRQqR5WgTm8pQWjGQ=;
 b=Hfz3OhoSCfbAhlKyLlSo1nUaXmB4ZjPln+8v+sfqBjuRaoBbo76Lu8EEEFnwUE39AfsWwdLUHt4CyWOcj5ekGfmrScfhlq+ycfOh0hBF7TrUXQqFIT2eV/g744y4rjl5s7BIg0V2KFj/+gu3RsT1pJoQnU4IERjfGDv0Hor+B0IPyA+XGN/nNwiAM5ePPa7YQF87FxSnaCdBZjeZzmDEIxdsVmzE+Ea5owsN10tQEqXNaziMW2lIsLp7m000D07dJEMgi2pG2rcT0tDCoxTFN0ZwBmsSleoEAgu6Hf1RMjEp79FyNxl59IES8+/49bxVFBg/b0IbzZS61GqAL0lcgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB10502.eurprd04.prod.outlook.com (2603:10a6:102:44f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Thu, 18 Jun
 2026 13:22:32 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 13:22:32 +0000
Date: Thu, 18 Jun 2026 08:22:24 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: han.xu@oss.nxp.com
Cc: Han Xu <han.xu@nxp.com>, Haibo Chen <haibo.chen@nxp.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] spi: nxp-xspi: Improve AHB read performance with DMA
Message-ID: <ajPxECFsTfI64jVq@SMW015318>
References: <20260617215520.3327836-1-han.xu@oss.nxp.com>
 <20260617215520.3327836-2-han.xu@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617215520.3327836-2-han.xu@oss.nxp.com>
X-ClientProxiedBy: SA9PR11CA0024.namprd11.prod.outlook.com
 (2603:10b6:806:6e::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB10502:EE_
X-MS-Office365-Filtering-Correlation-Id: a941152f-ed05-4687-a47a-08decd3ca724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|19092799006|56012099006|11063799006|6133799003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	re4DxUXcnXk4v5/odElrjCDM+VVJupgqcX5VglpAob1CIQH/heJ0GKRZvuwOuAZIVsZ+Ohk8xzdwydd081jBiQNGqNcjBiwJVrE2jd51+25h0hKAWzckgjJzuRG53D3do1QodElze27FlArnWtA/siIVbz9PbQhBY5DAs3CA4vfTnodccp0nebR3mJ485O6dWOedSg/D/DBhNc30+3yfjOCndcv/PfgeQwNlai5NHUgjpKEkM665wXaMirAGnhoywLXWA888qpTSEYIIXqZzb6dJe2Ut2JzXsfSdnjva/9QyGiPmz6sJZRpGFOig8dFioOcaX6ZB9NP5v2HUwrv3Ae2RggHvT1TqaROQ4Vq3CyHm3iOCTDzlLNT88tWnKSJrxEaFVSCUEPks9vtz7bpKUUVX1xx3bg1uEqIAe8t8kYe+XoU0ZtJcALHAsWQMmva5Ox3DpFGv5V2oc+jy/NX/0gD6DFYUWXqAkEqUjyfQf33938dqFsLnRn2JagpljkHwiB8lfJl2taLe0LDLQO+YKSKQEExb3M365nnplvVwsm9Qx5gOAPWoilwxxso+rZmInGkkOio6EXJIL76LINBE1zNAZFWXbN+K0yhxMxSyihTnc6CKCHOZnFAvYkA10byUkJ3afDGwTLqZbbwXX+OrUGz5nGRcz/bk+TilM1vUS8uI7ZsKrwkykgPQNxtbBU/i
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(19092799006)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UPJ0SS3/dQlATiaY8DM+Lsl/cQ+nxgMbLzgr0+VPt20nDWf4p6ahxn2nohb/?=
 =?us-ascii?Q?uwXu38o9pS0pWMCjjWUv5dV28EZrfJObRHnZ0bPUUcLjCVhzktEh0YxVDVPc?=
 =?us-ascii?Q?UGrw6Ho2OyeY4CvXQEQez1ahlk6weKhFqwjJk4Oaw/9TiQXS0AtqRFJGGxUM?=
 =?us-ascii?Q?fn/8yUhYYkw0Oa+lK8G8yMCSgB7bTonXgmUz/lZqiuMimh1DBhZkGs8Y18dM?=
 =?us-ascii?Q?iqESgpx2Zq+CB6XIspTFsNlo94YuI+TcEbRuU3HuIQt5UTGd7N22gx6BDaJ/?=
 =?us-ascii?Q?2wDve/910wyqczbmspm7WbIYOqMhs3Miku861ONyt8KO4TSQQxmFp+czn6Jk?=
 =?us-ascii?Q?pu/0nTnbxwfkGdI30TSSxIzujfas+aoiRgpvUSf6jKE4qe5DYzkx61jso7rF?=
 =?us-ascii?Q?hFtT2jmeARyaNM0wANUI2lW4eMUiQXFv0iBYn3FOITOElXzmGL/4IlVAiFfG?=
 =?us-ascii?Q?udinkbaPERMEo8hC6sp+yp29kD8izavIFaCN9mcwWpQM/StUJwgmW68FR5bG?=
 =?us-ascii?Q?yYAvzXB5AlBY1beFqkFWHSnM++DSVh/n4PHFNPvRg+hMJDMrT4yRn3ku7t/q?=
 =?us-ascii?Q?6ICCEGFrhbcCZackVr/Oh7mRaiiGUv1wUIDf4tn1B+Uejd5g69/4C1hENI3b?=
 =?us-ascii?Q?azrkLoFu2yKr4RTqIJVVGHS6UHgkm1mQmLz+NK31JjhH0nKZGN7GYQ8qy2lS?=
 =?us-ascii?Q?SavwbMAtf1by85fluhM2S3+Aq8E7grXPhQzFzDuT4ksB3JLdyaEsxnGFWLOt?=
 =?us-ascii?Q?yDBkjAzSJxyWXJdQEymkJLB8nFYOE0vWdJs3TeVymUhXamrq3dJWrZQGIbMV?=
 =?us-ascii?Q?a0iPmNHveO34HtCCgDnXRHH58xw3w/+TyQd5fh7P1vDQpqKSR3K9WudmPTkl?=
 =?us-ascii?Q?jOHc1RPb1h8Vd+Uhl+g7HqTNQQ7ibYdTj/wnZw379pAl9aKk4q//paf4tyVx?=
 =?us-ascii?Q?e636wLq++Q74twinif1guBL2eyrLI01vtzETwR7T6d1X+fmfiLUjNQJavyVK?=
 =?us-ascii?Q?C5HYf6EdsrHHCJuhN82LgS6jVA9/ZATKQDICyAnkpfZGuH2dhk9KMaXAX+j5?=
 =?us-ascii?Q?H0j/HBFiHDDegkqc/zNtuWzqm6xw9e3F7oR9J4g9xKLxwJ4IwSTsFkCjdWBr?=
 =?us-ascii?Q?jpJ5VmKuGnhmgVT0t562L4aq+Eu4R9e/kV6EquR6ypfLexBJwKaJN7Dxw4ew?=
 =?us-ascii?Q?Yd2xuzM7mA1/nEEuHcmxXP9RCiljCnRgH1jRbWXKa2cslWBm1MIQn/lchQhh?=
 =?us-ascii?Q?/2J7qAhuvIaLokIm+bbUR6f+8WqQiXiuafhMtXUvaJDEj5PnqZl5S5ASBq1V?=
 =?us-ascii?Q?Ct6Bga33MxdUYdULGxTKADytPTKEqSk632imWbg60LZte7VgMFhHBV08EcID?=
 =?us-ascii?Q?DDjDmjya3/hJgleH8NC4OexsVjkCvTZ/LQe7DrGpeBewiASUnmklcNh76pZe?=
 =?us-ascii?Q?RCioU2neXo31/w3YVuCcjA0RCVGXfojCOAYDiL8kvse6/ywSeDut9NR9YId1?=
 =?us-ascii?Q?p+hVtQFy5denDVRZhjIU8PfNFh4DYX3TBjbUcJrbzCuvexDCOYbItjUGtlVE?=
 =?us-ascii?Q?7YdnyRZzQYLrfHC4RbWR7TqUV6A5VhiJrZ3kI343Or3MdgrEloAOOFNeyw7t?=
 =?us-ascii?Q?357kYBtPWO/Q/7cZZtsfjo8QjmprC1jNUsivjezftNyqK+ADo0+jvwt0FvKd?=
 =?us-ascii?Q?WX9OqLxxS6ByZJnA8VNWh4Z9BrVfW3EfCH8pknJo/mTpwCUzJI5VAZvDsDFb?=
 =?us-ascii?Q?A1gVdB57Rwf4YHt2YbvHUJum3YYyA5XuW59hfzBCip1E7v6IMkz0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a941152f-ed05-4687-a47a-08decd3ca724
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 13:22:32.2438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMrVu9Afo/ym75nw4JXO6Kw+J9DXs4HNlNWVRlAs79dQ95cUFAXRM1i/5cGD1hVIrE0Y0S1GEgTf1jsLonT5R2KTarQHfixtZEurdp7bct1HzniAmJJ1HsyKY17jmjhk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10502

On Wed, Jun 17, 2026 at 04:55:18PM -0500, han.xu@oss.nxp.com wrote:
> Use eDMA for XSPI AHB read to improve the performance.

It'd better mention 4x performance improve here.

>
> Read with CPU
> root@imx943evk:~# dd if=/dev/mtd0 of=/dev/null bs=32M count=1
> 1+0 records in
> 1+0 records out
> 33554432 bytes (34 MB, 32 MiB) copied, 0.479719 s, 69.9 MB/s
>
> Read with DMA
> root@imx943evk:~# dd if=/dev/mtd0 of=/dev/null bs=32M count=1
> 1+0 records in
> 1+0 records out
> 33554432 bytes (34 MB, 32 MiB) copied, 0.115788 s, 290 MB/s
>
> Signed-off-by: Han Xu <han.xu@nxp.com>
> ---
>  drivers/spi/spi-nxp-xspi.c | 118 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 114 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-nxp-xspi.c b/drivers/spi/spi-nxp-xspi.c
> index 037eac24e6fd2..0f614dc20799f 100644
> --- a/drivers/spi/spi-nxp-xspi.c
> +++ b/drivers/spi/spi-nxp-xspi.c
> @@ -35,6 +35,8 @@
>  #include <linux/clk.h>
>  #include <linux/completion.h>
>  #include <linux/delay.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/interrupt.h>
> @@ -303,6 +305,8 @@
>         (opr)) << (((idx) % 2) * OPRND_SHIFT))
>
>  #define NXP_XSPI_MIN_IOMAP     SZ_4M
> +#define NXP_XSPI_DMA_TOUT      5000 /* ms */

Need unit, NXP_XPI_DMA_TOUT_MS,

Add comments why choose 5ms here, in case someone need change it in future.

> +#define NXP_XSPI_DMA_ALIGN     32
>  #define NXP_XSPI_MAX_CHIPSELECT                2
>  #define POLL_TOUT_US           5000
>
> @@ -336,6 +340,8 @@ struct nxp_xspi {
>         /* mutex lock for each operation */
>         struct mutex lock;
>         int selected;
> +       struct dma_chan *dma_rx;
> +       struct completion dma_rx_c;
>  #define XSPI_DTR_PROTO         BIT(0)
>         int flags;
>         /* Save the previous operation clock rate */
> @@ -796,6 +802,78 @@ static int nxp_xspi_ahb_read(struct nxp_xspi *xspi, const struct spi_mem_op *op)
>         return 0;
>  }
>
> +static int nxp_xspi_dma_init(struct device *dev, struct nxp_xspi *xspi)
> +{
> +       xspi->dma_rx = dma_request_chan(dev, "rx");
> +       if (IS_ERR(xspi->dma_rx)) {
> +               int ret = PTR_ERR(xspi->dma_rx);
> +
> +               xspi->dma_rx = NULL;
> +               if (ret == -EPROBE_DEFER)
> +                       return ret;
> +               dev_dbg(dev, "NO DMA RX channel, falling back to CPU read\n");
> +               return 0;
> +       }

use local variable will a little bit simpile

	dma_chan *rx = dma_request_chan()
	if (IS_ERR(rx) ){
		if (PTR_ERR(rx) == -EPROBE_DEFER)
			return ret;

		return 0;
	}

	xspi->dma_rx = rx;

> +       init_completion(&xspi->dma_rx_c);
> +
> +       return 0;
> +}
> +
> +static void nxp_xspi_dma_rx_callback(void *data)
> +{
> +       struct nxp_xspi *xspi = data;
> +
> +       complete(&xspi->dma_rx_c);
> +}
> +
> +static int nxp_xspi_ahb_dma_read(struct nxp_xspi *xspi,
> +                                const struct spi_mem_op *op)
> +{
> +       struct dma_async_tx_descriptor *desc;
> +       struct dma_chan *chan = xspi->dma_rx;
> +       unsigned long timeout;
> +       dma_addr_t dma_addr;
> +       int ret = 0;
> +
> +       dma_addr = dma_map_single(chan->device->dev,
> +                                 op->data.buf.in, op->data.nbytes,
> +                                 DMA_FROM_DEVICE);
> +
> +       if (dma_mapping_error(chan->device->dev, dma_addr)) {
> +               dev_err(xspi->dev, "failed to map DMA buffer for AHB read\n");
> +               return -ENOMEM;
> +       }
> +
> +       desc = dmaengine_prep_dma_memcpy(chan, dma_addr,
> +                                        xspi->memmap_phy + op->addr.val,
> +                                        op->data.nbytes,
> +                                        DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +       if (!desc) {
> +               dev_err(xspi->dev, "failed to prepare AHB RX DMA descriptor\n");
> +               ret = -EIO;
> +               goto err_unmap;
> +       }
> +       desc->callback = nxp_xspi_dma_rx_callback;
> +       desc->callback_param = xspi;
> +       reinit_completion(&xspi->dma_rx_c);
> +       dmaengine_submit(desc);
> +       dma_async_issue_pending(chan);
> +
> +       timeout = wait_for_completion_timeout(&xspi->dma_rx_c,
> +                                             msecs_to_jiffies(NXP_XSPI_DMA_TOUT));
> +       if (!timeout) {
> +               dev_err(xspi->dev, "AHB RX DMA timeout\n");
> +               dmaengine_terminate_sync(chan);
> +               ret = -ETIMEDOUT;
> +       }
> +
> +err_unmap:
> +       dma_unmap_single(chan->device->dev, dma_addr,
> +                        op->data.nbytes, DMA_FROM_DEVICE);
> +
> +       return ret;
> +}
> +
>  static int nxp_xspi_fill_txfifo(struct nxp_xspi *xspi,
>                                  const struct spi_mem_op *op)
>  {
> @@ -1016,10 +1094,15 @@ static int nxp_xspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>          *     all use IP write.
>          */
>         if ((op->data.dir == SPI_MEM_DATA_IN) && !needs_ip_only(xspi)
> -               && ((op->addr.val + op->data.nbytes) <= xspi->memmap_phy_size))
> -               err = nxp_xspi_ahb_read(xspi, op);
> -       else
> +               && ((op->addr.val + op->data.nbytes) <= xspi->memmap_phy_size)) {
> +       /* use DMA for transfers no less than ahb_buf_size, when DMA is available */
> +               if (xspi->dma_rx && op->data.nbytes >= xspi->devtype_data->ahb_buf_size)
> +                       err = nxp_xspi_ahb_dma_read(xspi, op);

If err happen, do we need failback to use CPU to read()?

> +               else
> +                       err = nxp_xspi_ahb_read(xspi, op);
> +       } else {
>                 err = nxp_xspi_do_op(xspi, op);
> +       }
>
>         nxp_xspi_sw_reset(xspi);
>
> @@ -1042,6 +1125,24 @@ static int nxp_xspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
>                 if (!needs_ip_only(xspi) && (op->addr.val < xspi->memmap_phy_size)
>                         && ((op->addr.val + op->data.nbytes) > xspi->memmap_phy_size))
>                         op->data.nbytes = xspi->memmap_phy_size - op->addr.val;
> +
> +               /*
> +                * For AHB DMA read, align the transfer to NXP_XSPI_DMA_ALIGN
> +                * boundaries. If the start address is unaligned, shorten this
> +                * transfer so the next one starts on an aligned boundary.
> +                * Otherwise, if the length is unaligned, round it down.
> +                */

DMA_ALGIN restriction come from DMA or XSPI? If come from DMA, need use
DMA API to get such align requirement.

> +               if (xspi->dma_rx && !needs_ip_only(xspi) &&
> +                   (op->data.nbytes >= xspi->devtype_data->ahb_buf_size)) {
> +                       if (op->addr.val % NXP_XSPI_DMA_ALIGN)
> +                               op->data.nbytes =
> +                                       ALIGN(op->addr.val, NXP_XSPI_DMA_ALIGN) -
> +                                       op->addr.val;
> +                       else if (op->data.nbytes % NXP_XSPI_DMA_ALIGN)
> +                               op->data.nbytes =
> +                                       ALIGN_DOWN(op->data.nbytes,
> +                                       NXP_XSPI_DMA_ALIGN);
> +               }
>         }
>
>         return 0;
> @@ -1203,6 +1304,10 @@ static void nxp_xspi_cleanup(void *data)
>
>         if (xspi->ahb_addr)
>                 iounmap(xspi->ahb_addr);
> +       if (xspi->dma_rx) {
> +               dmaengine_terminate_sync(xspi->dma_rx);
> +               dma_release_channel(xspi->dma_rx);
> +       }
>  }
>
>  static int nxp_xspi_probe(struct platform_device *pdev)
> @@ -1250,7 +1355,12 @@ static int nxp_xspi_probe(struct platform_device *pdev)
>         /* Find the irq */
>         irq = platform_get_irq(pdev, 0);
>         if (irq < 0)
> -               return dev_err_probe(dev, irq,  "Failed to get irq source");
> +               return dev_err_probe(dev, irq, "Failed to get irq source");

This change is not related this patch.

Frank
> +
> +       /* DMA is optional, failure(other than -EPROBE_DEFER) falls back to CPU */
> +       ret = nxp_xspi_dma_init(dev, xspi);
> +       if (ret == -EPROBE_DEFER)
> +               return ret;
>
>         pm_runtime_set_autosuspend_delay(dev, XSPI_RPM_TIMEOUT_MS);
>         pm_runtime_use_autosuspend(dev);
> --
> 2.34.1
>
>
