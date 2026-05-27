Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E11430F55F;
	Wed, 27 May 2026 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779904573; cv=fail; b=tofZ8adw0QMO1PUfgtrHlibn2lxv+OkRtrFLXQDRT90kxDYdU1NmYfmkTU9IdIaxTOimG8J1uyIHBVzM4vsU9jn4BwE4gMB9JjGOASQoK0kaRYHZu8T67UIHvpTgq7e8BDzo/NWnaBAGM7KuqrlTZBvD2/da1iguyzy5DMBob3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779904573; c=relaxed/simple;
	bh=hIP1IHD41O7eTZCBBTWs02p28a/K/AxUz3PUEjPfIQ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dD/KCU8nf7CD7yvLYuu0T0/INfiohZwILxaUQ9cJgGks+6vSEgLhg/FxlEFBR4ws94kwtIj/fXqAYP3jp4mB3nayxKWwmtbfpOqjxFp/PNDbm2C5SPuyzn4/sc5KNK9ARqOJTfol+pTzJIhaG4JYdz7BsRNJu6b+snkcyJsrqsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iMYTQle1; arc=fail smtp.client-ip=52.101.53.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iMYTQle1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UuvbxiH8uBSxnqmVpvzXkFaOyia0Quh9NKcQFpEaSuL+r/9sE1DG+55VbUhXdGg5SOs+3ts1vIy59Hb07eWNFn55Dk76tiXXXCbwzM9Oxb/i6llEnSP66+DVqu5Dt8/yYMxj2J2drOYQVQEeFCaSPC6MCulVNh85einp00Fw1JwolDrlY/FDB8xFjs9EoSGeabNWPH6tEI8bd8sbmY5E1GH05XOBfv3B7sIH91RLc4xYLIiIo38+g7yTnlnqlGUgd39lGBAMbaeeHlK5rk3t+V2yvihAlO6eG0D1Lp2+gu5/eqk5EQhQMS4Uv0RKHiz16y2RkipdshjWea0Xg/puxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UxLwKEG9Sxpr4uyCaHjB7mQbecROYwET5VRDSWCabU=;
 b=vHezUULT5k62DpTzD8/N9Oi+JFjPCLOsmX9uq038pAuO2FIaktKRCuCqseVRGvNm86EjUmxpMp3TUojcMK/7I19YiKl4VFDzuOH5hmxXs2I4nUlc4ES6XAbPBZ1xR4XOJR8/7qjXY+Kk7TDI55lyDBwjez0IgB7TJkIycwKWJeyaY91qL8GnbgjHQcEq8OcKhqheDOyi38iMurdDmuRIS3a0bZwgPqE86FKnRpIaDBKVRUob7zKhC4MCuWEzSVRg4E1S/rit4KnwCx4NdHItEstedpvjVe6jugXzLNsimuSnM1EDa2BHl28/m9oAPPNamVSNp+I+CuFZDqAZZoNo7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UxLwKEG9Sxpr4uyCaHjB7mQbecROYwET5VRDSWCabU=;
 b=iMYTQle1hw2nyP67nyUxv5YnqIPoTGo6108kxgiiY//5SzX05OS1h9EpgCIkDhOeXS2Htr9qu+IXc07xTPxC6KTnRH8ynrRFSJLoRMbdg0emvYEn6pw2qKRpzVtT+I4mr7TD4TLdhhqfx7fiPXAFH+ExeMczIC+o0hogOJn6XKU=
Received: from BY5PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:1e0::11)
 by SJ2PR10MB7809.namprd10.prod.outlook.com (2603:10b6:a03:56f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 17:56:07 +0000
Received: from CO1PEPF00012E5F.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::33) by BY5PR03CA0001.outlook.office365.com
 (2603:10b6:a03:1e0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.19 via Frontend Transport; Wed, 27
 May 2026 17:56:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF00012E5F.mail.protection.outlook.com (10.167.249.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 17:56:05 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 12:56:05 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 12:56:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 27 May 2026 12:56:04 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64RHtYph4052476;
	Wed, 27 May 2026 12:56:00 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v3 05/13] spi: spi-mem: add execute_tuning callback and spi_mem_execute_tuning()
Date: Wed, 27 May 2026 23:25:19 +0530
Message-ID: <20260527175527.2247679-6-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527175527.2247679-1-s-k6@ti.com>
References: <20260527175527.2247679-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E5F:EE_|SJ2PR10MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: da9864c7-ae47-4818-1a5d-08debc193997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|56012099006|6133799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	NTGY4UzjzSmRC+PzfdbQIq8RFuST4SbIOK6bhmDM3bEUqxdKZOz7dJn4fTsQqJkjWda2NIGaUsvAsyc3cOC6chI3zpi2iTT3ipP3x8FUY063RrEUGuZhM+GHTMMMdaqvN6NRQQgdVBO0bjeklOPVWMdRS2ee1BuefZYEynwDEjgWJcuwgIleFWN+1QSS1zQT/yyadh+MhRCSYSzfcUehrY6Yf3EQot6AKTpSbndQm/S7QJ7bJ3hOPuCoSYLSfAUmz/Gpm+swfXdEXIavS1W0+QzsG8rgeK+thAq7QDHNjAsh3HtSRghx8jzFCztd9OFm6yGo0+zsmcJ7pV1w2go07jr02wh8UC8Wz6cXi8FB1S40kCaNI9m4cAgprlRFRiJYpBagy5Mh4VMx9y2N6agnxhJ6ZJg7DN5k8jS9r2mVptnCxiR+mBZSXTNvWObcD64R61Q74pnpAxcZibJL9ZZkXkEcScP/cjVNHYH/HJKb96866N8Kf3ETrQNiv22/JWR/DOHxRGaQkZebaQU8RbIqFiBNGJav21iK8p+XykvZV6sTD04nmDTqN6XBY8f5uKIiyoj4eeKvlgbfFP1edrguyq1rY29nozm9+8V2w+OAzjM4vXZDS51I+7HIR5XAjSVXMKfBk4D39lhzBZjz6wIfWFLHTd1mDzlZ4qmgmWADOVTbFHrRkc24rYNj5wYy4HxpZ8AXGmLn8gzNVKmZxT8fGG2D/IRy0nyBTHzb26Sw50aL5TgoUdk2tBgpTyT8KTIeR7vjHluSWEQCQGrJIixzQQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(56012099006)(6133799003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	de6JEIZR5I5f0A8Hx9fRcV1WFipzC8nUU1d/BW+DKfOEQLNnUDslPU8SghRtAxpWZUsIrFDaAdSORxi7yAiw6d5LDqqPZTKSxkFV+ZGiUg+L6uf5EE7RL38tdBSPPSKJm9kbH93x4CrByQ1qFxNjo6Gqz/bISQsUrjdmoXnknG/uYymjkRL1y/IIdRDogNznPRXHp644He3qi2UQzB7OBGkAOZOo01dZnALH+TyzbTY+1Bg/AlMqB+DKMCe7+WbwbKLxm0esRGSpdMPhDGn1jCGgYLyBzNfkS2QwQ22HCI0rbSYjiHgmyuRmtzM6G7VPcqS3lABmI/FzWDwqJtdRpQRiUNuzCvKWF1ZZF19dVgW5Vd2hSt4LSGZOeOOhXiDob2G5czbd5QaghJdGJP05Xddci6GJDlYS6CQdT4QBhhWqOs3BbW1KhTQuVlJS0Mjp
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 17:56:05.8279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da9864c7-ae47-4818-1a5d-08debc193997
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7809

SPI memory controllers that support high-speed operating modes often
require a tuning procedure to calibrate internal timing before operating
at maximum frequency. There is currently no standard spi-mem interface
for drivers to trigger this procedure.

Add an execute_tuning callback to struct spi_controller_mem_ops. The
callback receives a mandatory read op template and an optional write op
template. On success the controller sets op->max_freq in each provided
template to the validated clock rate.

Add the corresponding spi_mem_execute_tuning() wrapper that validates
inputs and returns -EOPNOTSUPP when the controller has not implemented
the callback, allowing callers to handle controllers that do not support
tuning gracefully.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-mem.c       | 31 +++++++++++++++++++++++++++++++
 include/linux/spi/spi-mem.h |  9 +++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index d16986274cbc..5a4bf4b17fc1 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -675,6 +675,37 @@ u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op *op)
 }
 EXPORT_SYMBOL_GPL(spi_mem_calc_op_duration);
 
+/**
+ * spi_mem_execute_tuning() - Execute controller tuning procedure
+ * @mem: the SPI memory device
+ * @read_op: read operation template (mandatory)
+ * @write_op: write operation template (optional, may be NULL)
+ *
+ * Requests the controller to perform tuning for high-speed operation
+ * using the provided op templates. On success the controller callback
+ * sets @read_op->max_freq (and @write_op->max_freq when non-NULL) to
+ * the validated clock rate.
+ *
+ * Return: 0 on success, -EINVAL if @mem or @read_op is NULL,
+ *         -EOPNOTSUPP if controller doesn't support tuning,
+ *         or a controller-specific error code on failure.
+ */
+int spi_mem_execute_tuning(struct spi_mem *mem, struct spi_mem_op *read_op,
+			   struct spi_mem_op *write_op)
+{
+	struct spi_controller *ctlr;
+
+	if (!mem || !read_op)
+		return -EINVAL;
+
+	ctlr = mem->spi->controller;
+	if (!ctlr->mem_ops || !ctlr->mem_ops->execute_tuning)
+		return -EOPNOTSUPP;
+
+	return ctlr->mem_ops->execute_tuning(mem, read_op, write_op);
+}
+EXPORT_SYMBOL_GPL(spi_mem_execute_tuning);
+
 static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				      u64 offs, size_t len, void *buf)
 {
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 98125cb4cc6b..2457ec6f63d6 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -346,6 +346,10 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
  * @poll_status: poll memory device status until (status & mask) == match or
  *               when the timeout has expired. It fills the data buffer with
  *               the last status value.
+ * @execute_tuning: run the controller tuning procedure using the provided
+ *		    read and optional write op templates. On success, set
+ *		    @read_op->max_freq (and @write_op->max_freq when non-NULL)
+ *		    to the validated clock rate.
  *
  * This interface should be implemented by SPI controllers providing an
  * high-level interface to execute SPI memory operation, which is usually the
@@ -376,6 +380,8 @@ struct spi_controller_mem_ops {
 			   unsigned long initial_delay_us,
 			   unsigned long polling_rate_us,
 			   unsigned long timeout_ms);
+	int (*execute_tuning)(struct spi_mem *mem, struct spi_mem_op *read_op,
+			      struct spi_mem_op *write_op);
 };
 
 /**
@@ -465,6 +471,9 @@ void spi_mem_adjust_op_freq(struct spi_mem *mem, struct spi_mem_op *op);
 void spi_mem_apply_base_freq_cap(struct spi_mem *mem, struct spi_mem_op *op);
 u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op *op);
 
+int spi_mem_execute_tuning(struct spi_mem *mem, struct spi_mem_op *read_op,
+			   struct spi_mem_op *write_op);
+
 bool spi_mem_supports_op(struct spi_mem *mem,
 			 const struct spi_mem_op *op);
 
-- 
2.34.1

