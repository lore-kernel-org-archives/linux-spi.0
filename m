Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011030.outbound.protection.outlook.com [52.101.57.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF363812EF;
	Wed, 27 May 2026 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779904569; cv=fail; b=PRHx1S3oefRGWIVbFR5awqdDWh7B23C4J5MQJ1QlxUKIle2G5qzVDoWP7olLhk5iJAFBodr8nw6oZFVUg/7kpj7S+dsTVdW5l50J7WrWqA+cLSOHvBOcO1DaqE4udfT6o29V6/MbZTdkmiWY2mGn5pnQ9xBipyDDnDsuulA7HeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779904569; c=relaxed/simple;
	bh=/xZZ5CprYTEb19MTJJpuLMyqZlQqZiBreMR2jUs/qZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbsFNoUHy5EkAe9xsa4/jqPZD+8TfeXl1r17vFJgv1wKLeRyqzPOCq7x9Oj9NjFVBrBJ+iFEnCMk5cojddcf+ElWj6dghb7NBZTitgZGVxivHFo16eaI3R48YXzwWo28T/ZitYdJmbd33hyMqB8g+97o+77/Kpc8a0dFoFNzqQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dfJk32hj; arc=fail smtp.client-ip=52.101.57.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dfJk32hj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xtur9GXwYeSHsCB6UyGrmK67xuL7rr7nXZEgcfp8+BPCTuB/5yk4QmSpR2V2C/VamALDNb0/GVBZKssrD3u/1q+pddvvcZxtK/2j61pnqP/tMZ2t/+rbTnf5QwlUG9qAcVQeJTfswqUmqc0ywUHM78VyVAtryVK3Tcwju4WojtVU17HaMxy2DjIRaBsH1SJZ7dmSpnLHIDxUVPM/hl7kYf21iqCMiFxoK4M89r1CcbzBTPXYhnTbgP42WJrOpStgB8n1rnHN1N4hQz3g7LzK0vxNFt75egftfPJchBAHhZ+cp1NeMBdUdbeFB5W4XN0IMFvEAmEi76yF/rTDR/2Hig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwqWvqj2lbEvHWX0JYLWZfMEbZuBSKzUibQivi4Zjw0=;
 b=UQ552KnbxsXomtpj3W/G0ebAIyehh1CPeWr1/EXpAvw/jpkT8hXiQSgIalUMpuoOAJUqs1lT7HOBgKGJEOKf3gVH8UND/gMs26QAHVGJ5vN1FTtFoJ2nPpLApUzkheC8rIx1TGNU0SnGMic52wpoAnoM53BmuMot1lYEnCsBNgSkZ9Mvo8T3vPfwhwypIhACJW9ddLEovan3bT8W+rKJLy/5EySBFud3e2umbnv0OpEWtWqhBq3d0JacbH7hE9vnS6/P8B0DXl/Tg2aHqAAJwM/T/EiPAoGPorbH6OEis0ggand7KYDhVAMfcmwp0EV4h+yBS0iCWj3SRHdfXmbJtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwqWvqj2lbEvHWX0JYLWZfMEbZuBSKzUibQivi4Zjw0=;
 b=dfJk32hjxZ+a5+8pf1WPj+KslWO7/pWyU1DqDSti6ZTSpzcYasSLX6px1jK4UIYiWG45l6i3OasLBo5whvCUhJCBKjGeR4oLedM9Tg0TVXxQkxVdyFpaRitqfw6if4zzeZ+oPj5P2/uZds/Qqb//51E9SJaoZdFFI74V/PD7X7s=
Received: from CY5PR20CA0009.namprd20.prod.outlook.com (2603:10b6:930:3::22)
 by DS7PR10MB5997.namprd10.prod.outlook.com (2603:10b6:8:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Wed, 27 May
 2026 17:56:04 +0000
Received: from DM2PEPF00003FC5.namprd04.prod.outlook.com
 (2603:10b6:930:3:cafe::7b) by CY5PR20CA0009.outlook.office365.com
 (2603:10b6:930:3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 17:56:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DM2PEPF00003FC5.mail.protection.outlook.com (10.167.23.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 17:56:03 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 12:56:00 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 12:55:59 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 27 May 2026 12:55:59 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64RHtYpg4052476;
	Wed, 27 May 2026 12:55:55 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v3 04/13] spi: spi-mem: add spi_mem_apply_base_freq_cap()
Date: Wed, 27 May 2026 23:25:18 +0530
Message-ID: <20260527175527.2247679-5-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC5:EE_|DS7PR10MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: 19fcc56c-0e21-472f-a468-08debc193854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|7416014|1800799024|921020|22082099003|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	/Nz9HidO1B73WXqHC7X+cSIY3/NdvbgH9fT0CnY7A7n0qMXj5gnEoOE3lufx9wJkwjjQZ6gS8eCI+di70RRQicSpek9gKwX9Gh/IIpC73ZXIQ2Nmj/+EEKM4JBgAtrnQxqDuhVGyQC8QIERknIeqKpy9n8aXKo/JL72Rxj9TDC/lBbmnnW+K/seR20IIABHUFZiaJgdjluyqyf5vHPYz0tqVDyeU30RozYaUx9GaD4Dq/4Eh9H370eRGs/EY5Ki6zRPRTUW+VkyFZJG71CofoW2JjL5dkrJBpBVpDz64wTaPR18ulLI+hfjA1KwKUXXsbTiSbqcODs832D5s+vVgIve8jnmvpF93JfYFFiPayAtPyCmmMb7uMFustSN9aBswc94T2e32pINp+xnmX46ae0hrwnBcqjIaivI6xPYpUR5+Lyvlz1TAu+Ahctd5iFpmDaY+dtjBSsdcAGGeUm3utJ0oPoQlnaZT58fGGd6fhUSVJVvfhvSru4Pb0qvZdC06keiQZxEkqJw3ToEmc6RI8d5eaOEYTYpZQfCcwswZHmkKgko5CVdnck+3+LtnvjLNMcgo6dx4WFWFRmFneydXxqkJ1zjW2ZMakEypkMHpoWA6I3hJ2M8WrW7sMkRzYn+/AwYEaKAPfiYi8TBSgMk7iGf173TH27XmDAEZNZTJUWA9HpV3kGAif4yNYJpPIZyYIc9+CKwXkKT2uO2Z7JmGsQQywz415vtvaYPNk5R6OjYyKcq8EUkYpdhe7FTqcfp/hr9ifvWyFLfuDBXZrpqCVQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(7416014)(1800799024)(921020)(22082099003)(6133799003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dVXDk4oyOYk2XFl+wKj/3URVaCGBRK8quiu04hbLoY+8FocCANHguV2d30gP0XrUZNHpVabdEWuQmB97KWaAHNLWsBwFn/PDLuxXpvRZ0msR6GqrQc5eKXNV7voOin9CFg9NOXVC4yset67AxrmCfCG86O7s0WYgSDjlhRe5hnlNAJp/8Cy6fWDSnApFzcdkVEURRjX5jx8/ohtFKZUTwTbUl7RmklKHy/l2FUelPrlaX5iFCYdNG4C6aytambfArvF21Prd1DogcuU0THwd9oij8hkBGoxxIMh9W+7k6zsAA3V1DlkPy5ZS2BtX3MuOiZf9dFt6S2NSv1HchDcFb2+L1d0Nl7gKDrw6nRBhRSAr8UzPAa8y+OjSUgFKtBr+rB+MwsCW4HmrN2tBo7qZVr1Yv+iT/LhLeVanJxX9kZF+TJbntu5Np+QvSUBnpWMp
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 17:56:03.7462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fcc56c-0e21-472f-a468-08debc193854
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5997

When a device exposes both a conservative speed and a maximum speed,
operations that have not been configured for max-speed use must be
prevented from running at the device maximum. Without this, any op with
max_freq == 0 would be silently raised to max_speed_hz by
spi_mem_adjust_op_freq(), bypassing the intended conservative limit.

Add spi_mem_apply_base_freq_cap(). When base_speed_hz is set it caps
op->max_freq to that value, unless the op already has max_freq set to
max_speed_hz, which signals it has been configured for max-speed use.
Call it in spi_mem_exec_op() before spi_mem_adjust_op_freq() so the
final frequency is within both the base-speed constraint and the device
maximum.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-mem.c       | 26 +++++++++++++++++++++++++-
 include/linux/spi/spi-mem.h |  1 +
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index a88b9f038356..d16986274cbc 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -398,7 +398,11 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	u8 *tmpbuf;
 	int ret;
 
-	/* Make sure the operation frequency is correct before going futher */
+	/*
+	 * Ops not configured for maximum speed are limited to the conservative
+	 * base speed; spi_mem_adjust_op_freq() then caps to the device maximum.
+	 */
+	spi_mem_apply_base_freq_cap(mem, (struct spi_mem_op *)op);
 	spi_mem_adjust_op_freq(mem, (struct spi_mem_op *)op);
 
 	dev_vdbg(&mem->spi->dev, "[cmd: 0x%02x][%dB addr: %#8llx][%2dB dummy][%4dB data %s] %d%c-%d%c-%d%c-%d%c @ %uHz\n",
@@ -599,6 +603,26 @@ void spi_mem_adjust_op_freq(struct spi_mem *mem, struct spi_mem_op *op)
 }
 EXPORT_SYMBOL_GPL(spi_mem_adjust_op_freq);
 
+/**
+ * spi_mem_apply_base_freq_cap() - Enforce the conservative base speed for
+ *				   operations that are not explicitly validated
+ * @mem: the SPI memory
+ * @op: the operation to adjust
+ *
+ * When @mem->spi->base_speed_hz is non-zero, caps @op->max_freq to that
+ * value unless @op->max_freq is already set to @mem->spi->max_speed_hz,
+ * which signals the operation has been configured for max-speed use.
+ */
+void spi_mem_apply_base_freq_cap(struct spi_mem *mem, struct spi_mem_op *op)
+{
+	if (!mem->spi->base_speed_hz || op->max_freq == mem->spi->max_speed_hz)
+		return;
+
+	if (!op->max_freq || op->max_freq > mem->spi->base_speed_hz)
+		op->max_freq = mem->spi->base_speed_hz;
+}
+EXPORT_SYMBOL_GPL(spi_mem_apply_base_freq_cap);
+
 /**
  * spi_mem_calc_op_duration() - Derives the theoretical length (in ns) of an
  *			        operation. This helps finding the best variant
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 722abd9aee3c..98125cb4cc6b 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -462,6 +462,7 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 
 int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
 void spi_mem_adjust_op_freq(struct spi_mem *mem, struct spi_mem_op *op);
+void spi_mem_apply_base_freq_cap(struct spi_mem *mem, struct spi_mem_op *op);
 u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op *op);
 
 bool spi_mem_supports_op(struct spi_mem *mem,
-- 
2.34.1

