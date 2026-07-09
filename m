Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2113.outbound.protection.partner.outlook.cn [139.219.146.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741AC3FC5BE;
	Thu,  9 Jul 2026 11:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596425; cv=fail; b=VsRr0Jk4Osxnqjp5aUvbthimcFpHzDxrgD+foqExcHsnWipARPAJHTqi4CpLQu5jNrX9IcNxi6hElPjKK7qABKZNlQDDSkvzMlZBDbNIX7yEgdh1gUItff+EKVPaWUASLbJljxY8Kkxt63E8DVEFrsgNDXVpu5HBywMDFb+XgqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596425; c=relaxed/simple;
	bh=gUKNQoxi+6z5Sn2iDz/+ekmjp2X1OtAh4tCJihzqk2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TZPj5BJteKhW2kBY0OmRHa1QyJefSpDAXABe5i47tQbQXjvYEgpnGkH8SZLj6OLtjO/8eYVG2MORhwh5U/2fF6lLoDCo+qkG4R+eris8o/2CGmmxGPi637Djc6nzL184xgze04GNOu8NdQGHvqfYiNoYkvmDwojenCV8hjJZnRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwnkrkAhF9Yo0VMu/ZcynBsVgToFesEl+nvgXu+Rd9wL0KVhEHAkLgAy/ygVeGdawjK6D8PW7Pt06VEnErMemLm9p6FjyZwzwKtpya9woPvn6TvYellkNJl36Olw4K4Kah5+2cvIe4W48Kcrk5h7SCdMYX5pEu0O2SmApPk70WvHPAcd/1akN3s9lpfn2cTnmkSrOBZdUlklkAVRhKZFlTPbNvT3nCWqYBm7PzoAOdt2xMcUQZ2FAceiZBQeFk6o58CNMc/h4TukXDzzQuNwqgsNPWf72VC5Wgi0funtFu8S6YlexngmvmxXDIrWGgubcI5Zz2klUv7euZ6jHoAIxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLbgryrP4ns/5I/80bs2drSQAXT6CYPTRqozkPJHHPA=;
 b=JFIThbEmWqElhSWepMPgeQlRVRENYJqUZw0Z919hQ3wBskUSBgtrbxdgba//uBOftucPauua7s7BySOmN/b4GTfKFExztI7ZfHUMEkTGqIVHp9axM/1tKjPZzbzpT53h0SDCo/VASmofpmyxxFyWAgutQ+VBUUo0cSj+v8bGT6nAQ/fYhfGJU8v1oTTaJAay0S4EKnyTjxluU1ZPyLstaq7H+lA7Fw5eMHPHLgf1TeDGxFMykkMH7d1bwQwBcCN7tyX6ca+HUweXkgxDCWcszbMC+XPmCUxhcP+gjAeiV3FZLBTx+yqL4i2VhLuk3Gczya7/cUznUtrWG59OGEPuHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1282.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.23; Thu, 9 Jul
 2026 05:52:27 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%2])
 with mapi id 15.21.0139.024; Thu, 9 Jul 2026 05:52:27 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Sudip Mukherjee <sudip.mukherjee@sifive.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v1 11/11] spi: dw: Add support for StarFive JHB100 SoC SFC
Date: Wed,  8 Jul 2026 22:52:04 -0700
Message-Id: <20260709055204.138168-12-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260709055204.138168-1-changhuang.liang@starfivetech.com>
References: <20260709055204.138168-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0024.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::8) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1282:EE_
X-MS-Office365-Filtering-Correlation-Id: 407b2f66-e18d-4852-7dd1-08dedd7e41b9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|23010399003|376014|366016|38350700014|56012099006|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NU2hPoTVN+81sLbcY50mCSimbTtK5lueO/vlGVU5rSAM73o889TODIYDmfLiczK0aJ/ufQ4OPgaXHpLhWqV0Um22Oo3N/KLHvLQU0oHlqdKkeB7RDaz+eNSwjJXMts+kmtsy3DmreJS2qFxXrubtPxgVA3dpyMZ4Qp/koQeQ5fprFYa/fKcNs1KXdT3H1UgJEEIaNjzx7A4cV6EKOWcjFp5G0Yeqg8ia7zCK+Gis1o5J4+icaALBhu/ZJ9pYEWbILNRshMw3YT5QsQi2y4c3+kWwMLIc+crZMFDfcLTZyg38VLZkwlvMyXaLRzcNo/+B5UrDMl5NyEiyAHHjH28Y4Ds+X/KiEb5afXKq/IKK8isndhOgSavCXPwWzKOAW9YFuINP7Lptyu2YTMP2QA4zpYV2IFzKfjPqL+FlEXAftcdRckGtn4sgDOTwdvj0kwqpwN6D0Xzin8rcCKBu1QI4IEf5q4vAl21mjBDv3tmmx8t8Imbc6LtKIziHgWOwhyGjx8NosrD8IZgC47G4+QstpVITdRlv/OqZsynKrVVtWwFpS1V0H6w55QpbGwnPLwbW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(23010399003)(376014)(366016)(38350700014)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tPcYVemsXtgiOnE+JNeQa9+kBf0UiYBqsg3k+jw+1iweDp+/oPyiUZWQXYtW?=
 =?us-ascii?Q?tp2Oaoolay1R1F900nZIwmk3gei4OsoHd8aoUoyITcP4puqYk3+eyHJdGog4?=
 =?us-ascii?Q?ehWXY+OTJ/35O685m5AXGQipDF2EGl6Pe9O5b76pqOwF/m+rmt/Sfm/MBhAr?=
 =?us-ascii?Q?pquU4kh900Y4lVqwjxaLxW6eCMZf0ZlTWSlVpnd4zvHS43a9i+xfxSOWX1kS?=
 =?us-ascii?Q?HCOrBEso4EMOuLFQgnsebi1ZWCyyG2QgzHoS+W4ZZykSNnu8BgnG5lhqaxqz?=
 =?us-ascii?Q?9K7Az23gGA2E68KtpixQI5JqBHMf0LPdQl93CaLhbLC9z5qJrlamOU7/g3CQ?=
 =?us-ascii?Q?EZSGgVYsfBwXkFfQ5XB7gB8bUdRcbwyHS0/IdUIXeUH5KoiDGQxRQzjy2X5l?=
 =?us-ascii?Q?Gyp4EecYbL5xHki6hgQPTdR7jpnQ6Z7CQV96prroDiBCTUg5My06zzV4erit?=
 =?us-ascii?Q?0CpxiB50Fpgm9N+kT/ew+jSsjrX2A+aJpK1qpKdpV+DfTMNPadpgMRdRvEwM?=
 =?us-ascii?Q?fGEf8QAJ8pZjX7GRoVGLBppKRAM8yjniAIPcKWBDGyeZtCGUnu+6+KT5fH5M?=
 =?us-ascii?Q?x5uqVrsZB2joERm0fMNcNoo9TEpxsR3EAcbehOZ/Tin7gWZaCzrjiwCEKBnS?=
 =?us-ascii?Q?quTKRFGRfPOhEnWRN+/3UY+2cJlBbHfAk0PBr3/hCneZ8VOlkC2cPalONFgU?=
 =?us-ascii?Q?Y2tTyDGGlC2jviDEfU3VtxYkg+XEHjB5XiRO1oziOyLMTxsjTFvyK7kxifoI?=
 =?us-ascii?Q?OYt5SDGqRbDqTOhO3KNSz+iatueF+w2iF+p3/9nT3MWmxZFaFiKbeu5LSIyZ?=
 =?us-ascii?Q?yGXILhNoD+tOBeF2j/MLy/8V+LwurmuXXDTEbgUmNUizI3+i1o3w3YL+GpkK?=
 =?us-ascii?Q?mpYM+vNIMgK5oNtbNSJ0d8Cb/nnEj2BpT6RwQ0jChZfl76vqJxvgk9u+oTK/?=
 =?us-ascii?Q?BZq4b8mTueimcjNpkL202k3SxzuQEAy0PUNZZa+0xO7sQiKhvGeF8cNn7rcv?=
 =?us-ascii?Q?AKt6ZaJb0OWaqUitXIJWokQ5hjJo7s7BW8betmeIGHNeYLNgJ9nj5bLSS01I?=
 =?us-ascii?Q?YrXxCRvAdRrxRxjNykj5JmNy5hxf4iN9mA/9+7aV8Hmy6cBk4AMqOfVfLGyB?=
 =?us-ascii?Q?9/Io/jd4WLa/quUj/yDPr9AxUxUwb/i9z/jwfsr/uK8rcN1L/uY3CNVf5PMG?=
 =?us-ascii?Q?0MTv15ZnE6NxDCdM4bpIGuH16eAADNJhCVapNfw604+KRtiQP0ela7h6o7Jk?=
 =?us-ascii?Q?mBXYuo41ivj5d+YILAlFzLsU+z5WCWqbE3KykDU8a45mo/wiF41b4vHooCbY?=
 =?us-ascii?Q?8k/CMKNBux5ul6extmiFUcA2nsMIZxnau4jT8jpx20I6lgfUD4Lqau+ye1XM?=
 =?us-ascii?Q?YlOkH/O1FCXb/PR70pRuj4I3iHYj3QQbCYzJa7aG7uXJsFsMMDOmqWnJ6RDH?=
 =?us-ascii?Q?vuGcw/FJKuYiKkiMPMQdafRriGXigSAwg9OgaNK+XHV8sLK0PGOBpCNOZiDo?=
 =?us-ascii?Q?JGyOQ1KdPFj55vWaLvT+GJMOXoyAVkLYTsq48pycoWp3fVareSZKbTZVWg7Q?=
 =?us-ascii?Q?bN4Bnnh9k8z/O3fVgkg1riIgjZ+XaBLB+g/eh2X4LEidUwbtc2w2i63eZzTn?=
 =?us-ascii?Q?bpLfKt+AQCc1tdfKhNcOVX67+y2tC3VQ7qWnGvVw+67DNpmDNTIT7nXVat8j?=
 =?us-ascii?Q?TPs1jyLNdKhKNrqdc6rxOaUXYs+t85Li06qJMIevPttNmHlxS9t3iaIXovnM?=
 =?us-ascii?Q?UkUvw8v4Qe9VWYx12+TIFukjf9qn47Ga8Z+Cw6UqTVBkWMcV0Bhf?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 407b2f66-e18d-4852-7dd1-08dedd7e41b9
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:52:27.2597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFJ8yEYiQIVHsnDzLEkqcXy8twgBLRHLLY1FMF370kA11RtiUwEnWqKea9MtXi9BBdjwNeIqoEJa42CSqmms/dt9ioaF7IRRha9IHhLCOXZVq9wYOXI0/xPHmVngoZqP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1282

Add support for the StarFive JHB100 SoC SPI Flash Controller (SFC),
which is based on the Synopsys DesignWare SSI version 2.00a but with
some customizations.

The JHB100 SFC controller has the following special features:
1. Separate registers for instruction and address (DW_SPI_JHB100_INST
   and DW_SPI_JHB100_ADDR) instead of using the common data register.
2. A filter interrupt mask register (DW_SPI_JHB100_FILTER_IMR),
   which is default masked to disable filter interrupts as they
   are not used.
3. Requires a system controller phandle "starfive,sfc-filter-syscon"
   to configure 3-byte/4-byte address mode switching per chip select.
4. Different Set CS and Enable Controller Timing.

A new quirk flag DW_SPI_QUIRK_JHB100 is introduced to handle these
differences in the enhanced SPI memory operation path. The controller
uses the HSSI initialization path (DW_HSSI_ID) and shares the same
interrupt masking logic.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-core.c | 37 ++++++++++++++++++++++++----------
 drivers/spi/spi-dw-mmio.c | 42 +++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-dw.h      | 18 +++++++++++++++++
 3 files changed, 86 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 0abdee82eaab..d7698802019a 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -906,16 +906,30 @@ static void dw_spi_init_enh_mem_buf(struct dw_spi *dws, const struct spi_mem_op
 	}
 }
 
-static void dw_spi_enh_write_cmd_addr(struct dw_spi *dws, const struct spi_mem_op *op)
+static void dw_spi_enh_write_cmd_addr(struct dw_spi *dws, const struct spi_mem_op *op,
+				      struct spi_mem *mem)
 {
-	/* Send cmd as 32 bit value */
-	dw_write_io_reg(dws, DW_SPI_DR, op->cmd.opcode);
-	if (op->addr.nbytes) {
-		dw_write_io_reg(dws, DW_SPI_DR, lower_32_bits(op->addr.val));
-		if (op->addr.nbytes > 4) {
-			/* address more than 32bit */
-			dw_write_io_reg(dws, DW_SPI_DR, upper_32_bits(op->addr.val));
+	if (dws->quirk_flags & DW_SPI_QUIRK_JHB100) {
+		dw_write_io_reg(dws, DW_SPI_JHB100_INST, op->cmd.opcode);
+		if (op->addr.nbytes)
+			dw_write_io_reg(dws, DW_SPI_JHB100_ADDR, op->addr.val);
+
+		dw_spi_set_cs(mem->spi, false);
+		dw_spi_enable_chip(dws, 1);
+	} else {
+		dw_spi_enable_chip(dws, 1);
+
+		/* Send cmd as 32 bit value */
+		dw_write_io_reg(dws, DW_SPI_DR, op->cmd.opcode);
+		if (op->addr.nbytes) {
+			dw_write_io_reg(dws, DW_SPI_DR, lower_32_bits(op->addr.val));
+			if (op->addr.nbytes > 4) {
+				/* address more than 32bit */
+				dw_write_io_reg(dws, DW_SPI_DR, upper_32_bits(op->addr.val));
+			}
 		}
+
+		dw_spi_set_cs(mem->spi, false);
 	}
 }
 
@@ -979,10 +993,11 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
 
 	dw_spi_mask_intr(dws, 0xff);
 	reinit_completion(&ctlr->xfer_completion);
-	dw_spi_enable_chip(dws, 1);
 
-	dw_spi_enh_write_cmd_addr(dws, op);
-	dw_spi_set_cs(mem->spi, false);
+	if (dws->set_addr_nbyte)
+		dws->set_addr_nbyte(mem->spi, op->addr.nbytes);
+
+	dw_spi_enh_write_cmd_addr(dws, op, mem);
 
 	udelay(5);
 
diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 603e81a92c57..236ac5fa9cd0 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -48,6 +48,8 @@ struct dw_spi_mmio {
 #define SPARX5_FORCE_ENA			0xa4
 #define SPARX5_FORCE_VAL			0xa8
 
+#define JHB100_ADDRMODE_CS			0x00
+
 struct dw_spi_mscc {
 	struct regmap       *syscon;
 	void __iomem        *spi_mst; /* Not sparx5 */
@@ -310,6 +312,45 @@ static int dw_spi_elba_init(struct platform_device *pdev,
 	return 0;
 }
 
+static void dw_spi_jhb100_set_addr_nbyte(struct spi_device *spi, u8 nbyte)
+{
+	struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
+	struct dw_spi_mmio *dwsmmio = container_of(dws, struct dw_spi_mmio, dws);
+	struct regmap *syscon = dwsmmio->priv;
+
+	if (nbyte == 3) {
+		regmap_update_bits(syscon, JHB100_ADDRMODE_CS,
+				   BIT(spi_get_chipselect(spi, 0)),
+				   0);
+	} else if (nbyte == 4) {
+		regmap_update_bits(syscon, JHB100_ADDRMODE_CS,
+				   BIT(spi_get_chipselect(spi, 0)),
+				   BIT(spi_get_chipselect(spi, 0)));
+	}
+}
+
+static int dw_spi_jhb100_init(struct platform_device *pdev,
+			      struct dw_spi_mmio *dwsmmio)
+{
+	struct regmap *syscon;
+
+	syscon = syscon_regmap_lookup_by_phandle(dev_of_node(&pdev->dev),
+						 "starfive,sfc-filter-syscon");
+	if (IS_ERR(syscon))
+		return dev_err_probe(&pdev->dev, PTR_ERR(syscon),
+				     "syscon regmap lookup failed\n");
+
+	dwsmmio->priv = syscon;
+
+	dwsmmio->dws.set_addr_nbyte = dw_spi_jhb100_set_addr_nbyte;
+	dwsmmio->dws.ip = DW_HSSI_ID;
+	dwsmmio->dws.quirk_flags = DW_SPI_QUIRK_JHB100;
+
+	dw_spi_jhb100_mask_intr(&dwsmmio->dws, 0xff);
+
+	return 0;
+}
+
 static int dw_spi_mmio_probe(struct platform_device *pdev)
 {
 	int (*init_func)(struct platform_device *pdev,
@@ -447,6 +488,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
 	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
 	{ .compatible = "amd,pensando-elba-spi", .data = dw_spi_elba_init},
+	{ .compatible = "starfive,jhb100-sfc", .data = dw_spi_jhb100_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 2dae81c15423..a913c850ba1a 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -67,6 +67,11 @@
 #define DW_SPI_SPI_CTRLR0		0xf4
 #define DW_SPI_CS_OVERRIDE		0xf4
 
+/* Register offsets (StarFive JHB100 DWC SSI IP-cores) */
+#define DW_SPI_JHB100_INST		0x1000
+#define DW_SPI_JHB100_ADDR		0x1004
+#define DW_SPI_JHB100_FILTER_IMR	0x1008
+
 /* Bit fields in CTRLR0 (DWC APB SSI) */
 #define DW_PSSI_CTRLR0_DFS_MASK			GENMASK(3, 0)
 #define DW_PSSI_CTRLR0_DFS32_MASK		GENMASK(20, 16)
@@ -199,6 +204,7 @@ struct dw_spi {
 	u32			num_cs;		/* chip select lines */
 	u16			bus_num;
 	void (*set_cs)(struct spi_device *spi, bool enable);
+	void (*set_addr_nbyte)(struct spi_device *spi, u8 nbyte);
 
 	/* Current message transfer state info */
 	void			*tx;
@@ -228,6 +234,9 @@ struct dw_spi {
 	const struct dw_spi_dma_ops *dma_ops;
 	struct completion	dma_completion;
 
+#define DW_SPI_QUIRK_JHB100		BIT(0)
+	u32			quirk_flags;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs;
 	struct debugfs_regset32 regset;
@@ -296,6 +305,15 @@ static inline void dw_spi_umask_intr(struct dw_spi *dws, u32 mask)
 	dw_writel(dws, DW_SPI_IMR, new_mask);
 }
 
+/* Disable JHB100 SPI filter IRQ bits */
+static inline void dw_spi_jhb100_mask_intr(struct dw_spi *dws, u32 mask)
+{
+	u32 new_mask;
+
+	new_mask = dw_readl(dws, DW_SPI_JHB100_FILTER_IMR) & ~mask;
+	dw_writel(dws, DW_SPI_JHB100_FILTER_IMR, new_mask);
+}
+
 /*
  * This disables the SPI controller, interrupts, clears the interrupts status
  * and CS, then re-enables the controller back. Transmit and receive FIFO
-- 
2.25.1

