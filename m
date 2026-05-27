Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012000.outbound.protection.outlook.com [52.101.48.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1993D3812EF;
	Wed, 27 May 2026 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779904610; cv=fail; b=jZ/Zg/qo1RC6LhY8+ULSbbBOZjMyq0Yes/NOVHwCANi6+xca/6gdaXfLzSU15OoHHx6WvOjMAgwQpF4RR/bE3RMSG3sVCwoJ+gW25JihYZcxomvkXL0YvYXcU9z3DEiUbqXmBr9r2+WwDN35N1BStRYLXzYBLPA+Jdu7cgHV9D0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779904610; c=relaxed/simple;
	bh=5/V5ukoiwSHKB8So05WQQ46hsjXpQ7uElOLSGrLE9RM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAQ7Sv0B6X7u7CcVswLuw9nayjWq6NIj6Pzf41Nl44AjTen8GBvnu/HVpgRNzmGCr6pFjWIF8YCtA+g/vvHr37rgvj0NNSuSFqkinnoal7OzCsFbhBQXlCSi8gPiZwoNCtvmdyCmnPHFd3DFdSrquKNuCCycsjxywdXUA4E/u/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bMjDHtA+; arc=fail smtp.client-ip=52.101.48.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bMjDHtA+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jd7Wq8aOUhazoeUJUT8BnUxgBwhu1M8QcQoC/yAku6Syh5LMq0cBJyRn6kFqwIPu9TTHB5Ejga46lJTa9IWSVayBvmeY0oaJ5r/g1TJjMNMf7BkYGjFoLYSsqqh5UAdTVmwDb3tcW8NFSOYgCcdO2y3AoOAogmd0FPi3fKUz0sbZdU5J8KjW7h/0dp5wL4zyQapVv8Vr61oJH10/teFI9QEYsDmm+BVQnLp41DADz0W67kNtk04HMVITHRORbw5WOMSABovTsU/JYRqgsf07cHzED0xv3W+WZps56IvF2KLfbuc09YL6fDF2cMGXbYxZknrdBIEAyaF38+CskrDewQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppe0qTwspSHUu7S5lBvqAOYj2cYyzZrEkwbB0LCOMqw=;
 b=F8kHADHxKACezTePBZ3V/Lqd19Ci8N1vaxIOg8gqZtRKxAqeRlE/lNcbj5hrVICzYK9YtOKPTRpOZtIhQ4Z1vEEo7ED/kbu2f5ODBy5swxdMjzmk7uwKlKHdcLHLg4ylvCPxbKnej/4BEOQ851Rm/8V4yoe8NLt7PhciwelEN8dEchdQ7i0lSHNWzncFClI6XHIrQUQsPHfwgKkxU0+r2I+amgsrS6tPVD7qecPtfrSsl63KlB+xsXTyDAkEpZCkhy3Hi/GvmhQ1m5s4e8Y/ZW/gdEPFgFpzVKIWFF6jJmYhNEHiSKCHDwTGDkHhSpDP9hckqvCbWU8h9/Z5zhugfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppe0qTwspSHUu7S5lBvqAOYj2cYyzZrEkwbB0LCOMqw=;
 b=bMjDHtA+gjKXW70zfac1KlpeIf3GdX+pwcuKPJzcR+S+qcUwNpPAqaBWDO6ZSFj/Czw7UZgluGDA+FdEBhGdZoDPY/SIFaJezvNoTz7Y5JcJoYyI9HHOoE9s0/8X/rOvZWUBPkIBqHckYmByPZoaE/ic6iRazzHPC3JNNFAtPR8=
Received: from CYZPR14CA0044.namprd14.prod.outlook.com (2603:10b6:930:a0::28)
 by PH0PR10MB5731.namprd10.prod.outlook.com (2603:10b6:510:149::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 17:56:44 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:930:a0:cafe::20) by CYZPR14CA0044.outlook.office365.com
 (2603:10b6:930:a0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 17:56:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 17:56:43 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 12:56:41 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 12:56:40 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 27 May 2026 12:56:40 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64RHtYpo4052476;
	Wed, 27 May 2026 12:56:36 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v3 12/13] mtd: spi-nor: extract read op template construction into helper
Date: Wed, 27 May 2026 23:25:26 +0530
Message-ID: <20260527175527.2247679-13-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527175527.2247679-1-s-k6@ti.com>
References: <20260527175527.2247679-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|PH0PR10MB5731:EE_
X-MS-Office365-Filtering-Correlation-Id: a8973108-1f87-4f53-500d-08debc195030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|7416014|18002099003|22082099003|921020|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	5sXJy9vLXdzNrdpDu9bCLC5izva2pr3im0Vvm5JsS2FBrLY8wZYAo6UfloMzBaI36gva4wiUkkbKQlpQKjQOnNcpWmzqXOIZeyzyX4/46rA3DnDjBsxRbS/FAfva2JWwMP7C50cOvCRdfaNgst7auMwP9SKjeo23LMrHottMmU0QKRlIUI4SFLq1rz2wGqPvanNN6wFcYIBaHxFE/vFbkleKHIGFIOGyPdkvNt6z/uMR7MvATVGIa5nvYSyKh72LPoWO2ioUZu8Tj2vBmhp+7INe4Ta5+mh+/qsWgBVhw5tt7Yxq3mOkiJS8b8JRF1pfcKADy80PhyshLk9Biwd1mj0m2LIeKK8IjVlQD1hIqd9+PQWPEV/bju2RrchdQDx+7MhjTE4CuQtzYZRnvml8tB7UJMX2m/naKfwaXh6wGyUSrrr6y3WVGITwEVMsd66NX76LF0uVYc9hddrHiYK335smAPLJ6JgsTYwmohxegcMUFIRBMgBpjUm+6UqtCOKhrAM/XjSFA2DKGB5PGY6d4doam40s/Tm6oqhV0u9+btZh5iZQzd8TZuojyS38k+SXrDlZ3uRPi/m2TOE68sFI1VDqmo4GsqpTeAILeZwt2F2xfucgIy2ArAW5nh/mZ+CseEacDiIwBZZ7A+TGT6rd7mNHebcXPqAfED6t/ZjuZ8s/+CM6TjnFE8WptDal9lt8F8RBAMtx/dKUyA4KtGb1iUY8t/n897/R6ofYJii4/e1Y/wI2bV6GujBzdhWD75V2kXFnc7Ppv6HMBjUnS4DRyw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(7416014)(18002099003)(22082099003)(921020)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W0gwlrsKAckqg5XVtRzFnSaW7p5R5zPqZo9+En1TyB6Ru/1hE76oYvKtlLqh5txPVpcZPuHEvw3sbqdrWe6JWsGy16+NHicN4GJrhY+L7OSoPoOCGJNHBHx8oJdCiwCyWg284dexsOcGnH7C/59qka9JvNBIAo2WMMUUcSaUUwUTUkAUB1gMA7oZpVzOAQD54iWtU3LFpcQ2oyAgtTZhNNQE5ihsM8f5+gJhFDjqfXUcb3NCLwRJ6E0G5J+4fu1ZrJEX9HeCmvB5CW6oG6yR0NTEh5BCb8jN6Du+hMlKqKsBNSDWEU4pMx/0+APsextH8/8IFg7gzjQf6heTMqch8f/ePEYtmzLkg3gK/6m+lvGcSr8vNPUnMfucQEeTa+jorPm9zw1Danec1gJArHkuyuw2BflsXM0+OqOhVmk/nDxjrr7JLAhMkADW4HYTwMde
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 17:56:43.7686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8973108-1f87-4f53-500d-08debc195030
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5731

From: Pratyush Yadav <pratyush@kernel.org>

spi_nor_spimem_read_data() and spi_nor_create_read_dirmap() both
open-coded the same sequence: build the read spi_mem_op, call
spi_nor_spimem_setup_op(), convert dummy cycles to bytes, and—in the
dirmap case—explicitly patch data.buswidth because setup_op skips it
when data.nbytes is zero.

Introduce spi_nor_spimem_get_read_op() to centralise this logic.
Initialising the op with data.nbytes set to a non-zero value ensures
spi_nor_spimem_setup_op() populates data.buswidth, removing the need
for the manual override in the dirmap path. The dirmap template is
initialised directly from the helper; direct-read callers overwrite
addr.val, data.nbytes, and data.buf.in before submitting.

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/spi-nor/core.c | 66 +++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index a7bc458edc5c..2c9859fb0794 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -188,6 +188,37 @@ static int spi_nor_controller_ops_erase(struct spi_nor *nor, loff_t offs)
 	return nor->controller_ops->erase(nor, offs);
 }
 
+/**
+ * spi_nor_spimem_get_read_op() - build a configured read op template
+ * @nor:	the spi-nor device
+ *
+ * Returns a spi_mem_op with the command, address format, dummy cycles,
+ * and data buswidth configured for @nor. For direct reads, the caller
+ * must fill in addr.val, data.nbytes, and data.buf.in before use.
+ */
+static struct spi_mem_op spi_nor_spimem_get_read_op(struct spi_nor *nor)
+{
+	/*
+	 * data.nbytes must be non-zero so spi_nor_spimem_setup_op()
+	 * configures the data buswidth; callers replace it with the
+	 * actual transfer length.
+	 */
+	struct spi_mem_op op =
+		SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
+			   SPI_MEM_OP_ADDR(nor->addr_nbytes, 0, 0),
+			   SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
+			   SPI_MEM_OP_DATA_IN(2, NULL, 0));
+
+	spi_nor_spimem_setup_op(nor, &op, nor->read_proto);
+
+	/* convert the dummy cycles to the number of bytes */
+	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
+	if (spi_nor_protocol_is_dtr(nor->read_proto))
+		op.dummy.nbytes *= 2;
+
+	return op;
+}
+
 /**
  * spi_nor_spimem_read_data() - read data from flash's memory region via
  *                              spi-mem
@@ -201,21 +232,14 @@ static int spi_nor_controller_ops_erase(struct spi_nor *nor, loff_t offs)
 static ssize_t spi_nor_spimem_read_data(struct spi_nor *nor, loff_t from,
 					size_t len, u8 *buf)
 {
-	struct spi_mem_op op =
-		SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
-			   SPI_MEM_OP_ADDR(nor->addr_nbytes, from, 0),
-			   SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
-			   SPI_MEM_OP_DATA_IN(len, buf, 0));
+	struct spi_mem_op op = spi_nor_spimem_get_read_op(nor);
 	bool usebouncebuf;
 	ssize_t nbytes;
 	int error;
 
-	spi_nor_spimem_setup_op(nor, &op, nor->read_proto);
-
-	/* convert the dummy cycles to the number of bytes */
-	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
-	if (spi_nor_protocol_is_dtr(nor->read_proto))
-		op.dummy.nbytes *= 2;
+	op.addr.val = from;
+	op.data.nbytes = len;
+	op.data.buf.in = buf;
 
 	usebouncebuf = spi_nor_spimem_bounce(nor, &op);
 
@@ -3642,28 +3666,10 @@ static int spi_nor_create_read_dirmap(struct spi_nor *nor)
 {
 	struct spi_mem_dirmap_info info = {
 		.op_tmpl = &info.primary_op_tmpl,
-		.primary_op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
-					      SPI_MEM_OP_ADDR(nor->addr_nbytes, 0, 0),
-					      SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
-					      SPI_MEM_OP_DATA_IN(0, NULL, 0)),
+		.primary_op_tmpl = spi_nor_spimem_get_read_op(nor),
 		.offset = 0,
 		.length = nor->params->size,
 	};
-	struct spi_mem_op *op = info.op_tmpl;
-
-	spi_nor_spimem_setup_op(nor, op, nor->read_proto);
-
-	/* convert the dummy cycles to the number of bytes */
-	op->dummy.nbytes = (nor->read_dummy * op->dummy.buswidth) / 8;
-	if (spi_nor_protocol_is_dtr(nor->read_proto))
-		op->dummy.nbytes *= 2;
-
-	/*
-	 * Since spi_nor_spimem_setup_op() only sets buswidth when the number
-	 * of data bytes is non-zero, the data buswidth won't be set here. So,
-	 * do it explicitly.
-	 */
-	op->data.buswidth = spi_nor_get_protocol_data_nbits(nor->read_proto);
 
 	nor->dirmap.rdesc = devm_spi_mem_dirmap_create(nor->dev, nor->spimem,
 						       &info);
-- 
2.34.1

