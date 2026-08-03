Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2115.outbound.protection.partner.outlook.cn [139.219.146.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87E541DE00;
	Mon,  3 Aug 2026 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760884; cv=fail; b=ivJwypZx+lLJglMWa/+9PYvnu0r+Ywxon9dpDn5LxmnsfEHrH1tuesgLBZZyoGCRYud0t/kKzBlP489cJR+C3/LbZax++TQxnjhE7M8bGn8dwpfkPIrzhsbhiwAOPOTSAr8lt8qL2DyF6u4h/soXe5uKtyfN1LLcxE5X+RF1hhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760884; c=relaxed/simple;
	bh=nxgDUI+b1ce1j1QVWJC7/fkuSDS5P7vq8ghdU75FIDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ff0JSm25FYdv2oqGY0D+Cu7Ms0BCDchZIy6jaeO+/ElLulxFWrJFOIpUgbKEMuel9B/ShhWh2seNFhbJpa5VsadVLJPUQxvY+LQe/Xn5WJFR/cSJKi+lOf1/mpa5CLzgUmb+/baL84v49l0MoAsSHXY+6mSqaYQYiPwzxaUrMRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oq+ULwqsmlGl4qs4IFKtFsVjAKidL3ausiRSB7Qr1oZWqDkDrBUvAuu68nKUavTPt1xdNP2+iZmdbjaISuD35jc8/N2H0Njve+M+7YCMgVo29BWA8MIvSe0XX+6NUIEMVmddR2dyqmvYrWKNPULgdbgbVy7T0ESHHUJi7Xy0yCrBETlj/SM2mKlL+E8vpFXxMdYrNz5riizAhrnBXQ9MQ2uV5Z9EnT2AGNubtGHjeqnn6UqpxxsUohdQptFZ503ybec51DXQkSuEVce1SVq5J4Hycax9BuL+srbZOxpWdsk4sYYsnn0GFNSQ5NIZf5X1ZT3YoVLqmkpeYPSQRii9zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3t+PcLw8AaOiZfxHPj+CQBSEWwpHlIeRxoZZ0CNBVi8=;
 b=eu7HBHlK2bU3CbLWnKuCkoYUOQbFC06jTckXlS7/UA+2cf0iLItv+06vQ8lU8iBqLoAr7Ij1uvUrtkkaaQNIlCnnVn/R7xHHAnSa8a5ME4Ikh+zdZO57W7ifiiOEZHfZ/89z3cOO4mVWR4JstcmSxlaf8FcAvy7UDTUIBlCt8+KU+uG+/vwVPFNPaw61Gz9l6fvEIRimUYdUMXyCV7LloWfBT+xVjt4YQa/gD9z/NFZLOLyGAUe/SQ+deBDgndgezzdDWrU5Wqpo3JcBc8T57XspXQFAnsmTW25Bdpb+i7eMDP+5abvouIL9EeFdJAKqMVA3mu0boJBdW5Z2lbyCMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1267.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 12:41:12 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0270.016; Mon, 3 Aug 2026 12:41:12 +0000
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
Subject: [PATCH v2 11/11] spi: dw: Add support for StarFive JHB100 SoC SFC
Date: Mon,  3 Aug 2026 05:40:44 -0700
Message-Id: <20260803124044.156998-12-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260803124044.156998-1-changhuang.liang@starfivetech.com>
References: <20260803124044.156998-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0023.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::32) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1267:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b3da4d-c6c0-49a1-7a29-08def15c79c3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|23010399003|38350700014|6133799003|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	tp5ozginm8f06LobW8GlBQTKrjcZueTIXcuuwBD3x21E7mv+rvVqSzkaWB5eP1yEqk4YiHFTPTSC1iqPLAf7pmvFXUVzqKgVfV7m+X0eq4GYAPdrLucI97kgN+4ZDG5m8Skqb5znT0h1WqZgVcuymKqMikB9KC0NMEHTYjMrzMIcn6qpXE8uSI/jGl6HWbL8NtxhXsT2lKO1Lgo9/TaPOulu3KK9CodRYEmTaMY5Dr2LNSOn2qZvBeTqH/+5KkwMY1REfRUPxE1fvqUTyvjqmSiw/WO1S/+umkUHKNqKkfmiNGCCN/EaoBZjUeAGoTs17YkmX1BqKBeQQ2ddgbrVn9sqhz3r5NIfOq1EU7X2j5L8e1bmWj292yFYmBsEc+XYdOAF/tgTMusxaem7sr8VZkBxx48+qpGndjxrNxV84t8pDOkNNwJO4F8w/kzTMHbEPNiIXRCLnVYLPtXjOzKWuedMaFdMyDA+BCbBp9Am3yfbmtEUumHEFC4j2yfEd2SZSFwefdSfVyR/OYdbK4xEXx6jLxwURTyLWKyos3rAwFRbrHn70Xm1juBP/RPbBv/e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(23010399003)(38350700014)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H/hU395ZFtAMro10+/ibClmUou8T4ofSJ0Dl+J1kSeiGAjj0vKPfDDFQ6vLk?=
 =?us-ascii?Q?fMkZvTaneS7ShUyJ3MngRzoaVtH0uOmxuEw/SDiEbimcMDPVst6wOcrd8qHq?=
 =?us-ascii?Q?h2zJ0NJsvwsGFZOtrRcxMR7zCYK2X3OP9/fjDKwQxlfxvSlVBKlVUg3zUOQJ?=
 =?us-ascii?Q?nzmqefQdsn3P0hA0X5Cz0OxwmoCmhzrauQabMj0KbWUxZhmVu8zRQm4b68/N?=
 =?us-ascii?Q?UCVweidxBlYg5l0VWjuA+uojTX7lDld4uDtK05/cKigDukZBegAJw2oBO9b1?=
 =?us-ascii?Q?tU6vZH6i5W7ltS2bpqxIXCaR4xB3hmhT+c4mAO1RpROfl+Ts5NrYONSTPKEg?=
 =?us-ascii?Q?zpwViVGzvXxSdPReCQV/D9YhXR+Z8e4PT2IDucBBX/zOlGysqCHBowBp/Wbw?=
 =?us-ascii?Q?vsm4ozdckKWHKRbJLkFEBuzE5OIl7dbZS184+JyrF8hsCfc02r16ipBPG0t9?=
 =?us-ascii?Q?SuB/e3Hmbbskoy1Ec/SOT0Gh/eXE690j3Vz1NOmB0VHtYrjpMPXuJmc5AuhH?=
 =?us-ascii?Q?V6d2kztAnz4iuSBKpXZRjikX2FWseXmhYFY3Nlh9hR6HDzPmAe08/ee/FHRB?=
 =?us-ascii?Q?tHPEwhvKIVkeVPDeCiE+XxJTkBN6io/iN0KAflf0luUBHM6TNUsQ6FjYlFoW?=
 =?us-ascii?Q?5G3HUoD5HtZjYl/o02btWAWfxZ8Fr5f3PESylnIfHcpQM5og+jdd8RyPdkxp?=
 =?us-ascii?Q?kCaTIxe2LPYBZu8bbcyxOLWa9IEM1c268BuPe1ttVkq3xQrhZVbLPRWYvFW1?=
 =?us-ascii?Q?FstqUh0O4yg65lp0nsCRmqVfYYzuUVk8aWarLFXaJmPwrYm3rCKU7pwV1/5+?=
 =?us-ascii?Q?3Ji1ufG0WFLBpDe7T69OUj8ewhqu47hkZDORxEcAGBVK4AUuuK5/nbYw3H24?=
 =?us-ascii?Q?P0erwFS9iFsJL8wKx/qytHAduzDBb1B6tuSR0+8NVHGAC1IsewK/hZxpsuZQ?=
 =?us-ascii?Q?b7LChU8LSPpa3FaQoByxVYhVKdNo5yLDBExRbE+/yNRqbGy4sDwKeilkktu0?=
 =?us-ascii?Q?HufcUgVH6DFx3aheSPTtXfcAgAOBaNmGeac2HaSJNYfyjxtgQpLHYTC+9Sg9?=
 =?us-ascii?Q?6YYv2o6V/l6iV+yXuYOVRChs1qsRSIalxNHWiwiBxnpT1YZmqkAezQ6ta6zO?=
 =?us-ascii?Q?EMDD1NPf+FTx/LeV+ZyIuPydjl6D/cH9n1ATkWXca64i/qCWM3lgDoT/hhKX?=
 =?us-ascii?Q?pf1U4HwG9OX3BF/8rVuSbLVZQZ3ubExdcwapc2fs8FiA0hX2WolkgkbiBStr?=
 =?us-ascii?Q?EGB5AWQqNIJXXO46/YNL99ddouas9pDF2NatIKtzbVq4iDgGEzHUs3jNL16m?=
 =?us-ascii?Q?uEEjNjxYmLfQ3D+QN9SjamFIQ/JgZIWDxTLc/rSdK7BUFsMZPKy6FFwwd2GF?=
 =?us-ascii?Q?qpbJcHJb08NWLvkVHILhsodUiqcAYwm/GGrIpFURrl+3l09GRAJiDZ76sJ/7?=
 =?us-ascii?Q?rQzC11/psRUg77N6ZezXipBSoXX5twMI4wUpCGpisXjPsHjr+vSB+5bfhTM7?=
 =?us-ascii?Q?0mu7c267YDYB9tV+n4frjFnNfkMWZdPNUZJhlPzaKw+mgJY2dkwLaLO4FYnA?=
 =?us-ascii?Q?EP9Y0DRLmyLgKt7ejLuKOKq9CK5APQQhxxVRLy/zGP+kHwTJMqzSJmS/+gr7?=
 =?us-ascii?Q?aU980FDvFa8x67+5xBuDEpLS4fW4Dyly34hdmrzdnS7bTT7QYGwPJPhsxC1V?=
 =?us-ascii?Q?lWiKh7Lumb05o6gqYHvnTIe4OhLnekNhUcq0Txx0SklUlMlHMlg4Qm/DKrYj?=
 =?us-ascii?Q?xx1Xr7+s7nopKrnJbXDJnFYtx2eLkIO4ixXCHgMH0l9RK8V4PJKH?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b3da4d-c6c0-49a1-7a29-08def15c79c3
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 12:41:01.6703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gjbxxPEezRdEkUXYwf1MKeXbsRgRxZb7S4FUPj4bICZiCWkNOIXlBHpurSI7iPML9QDYyjI0i+9jTv3FyI+JDZo60aNlncCw7dgox5tSa4GwZcGiJHt2spwyqeC80vJP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267

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
interrupt masking logic. Limit the JHB100 SFC address to 3-byte or
4-byte length.

Additionally, the platform_suspend() and platform_resume() callbacks
are introduced to handle platform-private suspend/resume procedures.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/spi/spi-dw-core.c | 48 ++++++++++++++++++++------
 drivers/spi/spi-dw-mmio.c | 72 +++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-dw.h      | 18 ++++++++++
 3 files changed, 127 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 0d900afa015d..ce6144a34785 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -591,6 +591,8 @@ static int dw_spi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 static bool dw_spi_supports_enh_mem_op(struct spi_mem *mem,
 				       const struct spi_mem_op *op)
 {
+	struct dw_spi *dws = spi_controller_get_devdata(mem->spi->controller);
+
 	if (op->addr.nbytes != 0 && op->addr.buswidth != 1 &&
 	    op->addr.buswidth != op->data.buswidth)
 		return false;
@@ -614,6 +616,10 @@ static bool dw_spi_supports_enh_mem_op(struct spi_mem *mem,
 	    FIELD_MAX(DW_SPI_ENH_CTRLR0_WAIT_CYCLE_MASK))
 		return false;
 
+	if ((dws->quirk_flags & DW_SPI_QUIRK_JHB100) && op->addr.nbytes &&
+	    op->addr.nbytes != 3 && op->addr.nbytes != 4)
+		return false;
+
 	return spi_mem_default_supports_op(mem, op);
 }
 
@@ -906,16 +912,30 @@ static void dw_spi_init_enh_mem_buf(struct dw_spi *dws, const struct spi_mem_op
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
 
@@ -981,10 +1001,16 @@ static int dw_spi_exec_enh_mem_op(struct spi_mem *mem, const struct spi_mem_op *
 
 	dw_spi_mask_intr(dws, 0xff);
 	reinit_completion(&ctlr->xfer_completion);
-	dw_spi_enable_chip(dws, 1);
 
-	dw_spi_enh_write_cmd_addr(dws, op);
-	dw_spi_set_cs(mem->spi, false);
+	if (op->addr.nbytes && dws->set_addr_nbyte) {
+		ret = dws->set_addr_nbyte(mem->spi, op->addr.nbytes);
+		if (ret) {
+			dw_spi_enable_chip(dws, 1);
+			return ret;
+		}
+	}
+
+	dw_spi_enh_write_cmd_addr(dws, op, mem);
 
 	/*
 	 * FIXME: The exact reason for this delay is not fully understood,
diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 603e81a92c57..8cdb0351605b 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -31,6 +31,8 @@ struct dw_spi_mmio {
 	struct clk     *pclk;
 	void           *priv;
 	struct reset_control *rstc;
+	void (*platform_suspend)(struct dw_spi_mmio *dwsmmio);
+	int (*platform_resume)(struct dw_spi_mmio *dwsmmio);
 };
 
 #define MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL	0x24
@@ -48,6 +50,8 @@ struct dw_spi_mmio {
 #define SPARX5_FORCE_ENA			0xa4
 #define SPARX5_FORCE_VAL			0xa8
 
+#define JHB100_ADDRMODE_CS			0x00
+
 struct dw_spi_mscc {
 	struct regmap       *syscon;
 	void __iomem        *spi_mst; /* Not sparx5 */
@@ -310,6 +314,58 @@ static int dw_spi_elba_init(struct platform_device *pdev,
 	return 0;
 }
 
+static int dw_spi_jhb100_set_addr_nbyte(struct spi_device *spi, u8 nbyte)
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
+	} else {
+		dev_err(&spi->dev, "Unsupported address nbyte %d\n", nbyte);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int dw_spi_jhb100_resume(struct dw_spi_mmio *dwsmmio)
+{
+	dw_spi_jhb100_mask_intr(&dwsmmio->dws, 0xff);
+
+	return 0;
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
+	dwsmmio->platform_resume = dw_spi_jhb100_resume;
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
@@ -399,6 +455,9 @@ static int dw_spi_mmio_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	if (dwsmmio->platform_suspend)
+		dwsmmio->platform_suspend(dwsmmio);
+
 	reset_control_assert(dwsmmio->rstc);
 
 	clk_disable_unprepare(dwsmmio->pclk);
@@ -410,12 +469,24 @@ static int dw_spi_mmio_suspend(struct device *dev)
 static int dw_spi_mmio_resume(struct device *dev)
 {
 	struct dw_spi_mmio *dwsmmio = dev_get_drvdata(dev);
+	int ret;
 
 	clk_prepare_enable(dwsmmio->clk);
 	clk_prepare_enable(dwsmmio->pclk);
 
 	reset_control_deassert(dwsmmio->rstc);
 
+	if (dwsmmio->platform_resume) {
+		ret = dwsmmio->platform_resume(dwsmmio);
+		if (ret) {
+			reset_control_assert(dwsmmio->rstc);
+
+			clk_disable_unprepare(dwsmmio->pclk);
+			clk_disable_unprepare(dwsmmio->clk);
+			return ret;
+		}
+	}
+
 	return dw_spi_resume_controller(&dwsmmio->dws);
 }
 
@@ -447,6 +518,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
 	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
 	{ .compatible = "amd,pensando-elba-spi", .data = dw_spi_elba_init},
+	{ .compatible = "starfive,jhb100-sfc", .data = dw_spi_jhb100_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 2dae81c15423..2fce5bde75f0 100644
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
+	int (*set_addr_nbyte)(struct spi_device *spi, u8 nbyte);
 
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

