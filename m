Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012065.outbound.protection.outlook.com [40.93.195.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA0D436353;
	Wed, 27 May 2026 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779904560; cv=fail; b=ekaT0Cmk/73pSOJY4gRzuY52QrYVHxtmkiUDr8un7ygHaP7izhzR3C0YFZzO8em3GPWFiRurd+SeWRAlU8xLrqQyqpxDelJbmxnPbRlzrrPrg2V8rS59+kuHHGBbSnaQgWDYAdLEj/hK55besQBDthocloGovtWh3/VvWyiXUjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779904560; c=relaxed/simple;
	bh=b1YbOYRWZcx+ySt5u5Y/Zxw3OCTphaVHgtvBlPEoeSk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHkiDw8x2cNrYV4usG5EKnJca5rus2YgOGbKfYxeQd3XGObHECtGcKkm+jYJWWnv6s8gvPCTHXU34exkKpUD35/QupAyRxEvN6mSzeKXBtE9iPh/jFXY5raPDyaBTfv4JvM8ctdMGTGgrhOwJPH6jA8pycd+VNaiy3ItinDdX8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cWgAasdy; arc=fail smtp.client-ip=40.93.195.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cWgAasdy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLgjjbZqmOy07u/E5gVJsL1PscUXjlZTaLt7QqnFpL9BfOmlWoZgl5P3XtvhKmKbXmPdGcg9YacAmBm4mZstje9MJ6dcWLO+NQtjH/ZTqE/WRiAMQBMJqgUjj0n0nLjmX3fj8pLga45YHmAz/CQVGvlP8RsWORLdzWGpvJNO+RHWNMa6w9idLM3BdcORg1sEVUE9qeX21bLdkYHWwPAhTWuqxvkwIgcCicqRCkWd0B6n3Qny2/0VgUyHL3O8fR/Qy8OXRyUVie+CQp6buk/DZJlMBrlcLuCIz+du18GfiQopNJuZSjaeeeVuCpH1QlCKRpMGbM7ZlqBDdl3eAAa6Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VPNAFTfr723ACIvG/rZBUHSYFLm4vjlOPz/Bs1eEP0=;
 b=SpVS1M2kzMMziFwkou1ZjZJO6ysfEVRLrUoxnUV2jERZd4xi7Q1H1naD+db47ikfB+L+0FExmyq2y9GSrhh5O55VGHOcb9kQFObKEgqK/FVV86Iu3p1NCI1PQah6ObvtReCZHDBcOCQuik6cy0uq9qI1i5jyQho8/RMcssNEv9wCwKVNwC1nKzkjtnnMuvZyXUKYcx6B/vc637Z6E3ayYddgy5BaR52C+FNFHnfC1SAIebVW7MOKrYbuspEFkAKl7CXoUTjcba7WD7hy0nT29dCKspWb2jnympNyScPUlcrvpsqBwaUZ8/uvocCoUIIgHoZz+2oGwtqSUSx6rDO2Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VPNAFTfr723ACIvG/rZBUHSYFLm4vjlOPz/Bs1eEP0=;
 b=cWgAasdy6fIjPQiriHHMjKHR0ClEDKJDvADd2Ps3OFW0RVWcTQERzdKcqvfN40TFahJ5fqWzEVG5dgGc772wjs3TlIt6jU0T0OjSqFrX7JQzUyQplQklvOASmCOa748hFE587BEujl6QRHpjZS6n/8BqRZm3FnpK5OMv3aGMv4Y=
Received: from DS1P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:455::16) by
 IA3PR10MB8662.namprd10.prod.outlook.com (2603:10b6:208:570::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 17:55:56 +0000
Received: from DM2PEPF00003FC9.namprd04.prod.outlook.com
 (2603:10b6:8:455:cafe::51) by DS1P220CA0010.outlook.office365.com
 (2603:10b6:8:455::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 17:55:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DM2PEPF00003FC9.mail.protection.outlook.com (10.167.23.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 17:55:55 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 12:55:55 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 12:55:54 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 27 May 2026 12:55:54 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64RHtYpf4052476;
	Wed, 27 May 2026 12:55:50 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v3 03/13] spi: parse two-element spi-max-frequency property
Date: Wed, 27 May 2026 23:25:17 +0530
Message-ID: <20260527175527.2247679-4-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC9:EE_|IA3PR10MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c92f709-6edb-4ad4-b7d1-08debc19335a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|921020|22082099003|18002099003|3023799007|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	b5n1T3dkIkhfdCH+lWf05BM1AHkd+g6tabB77ys/W+hxMJOYNwnhH2qeNsAmciiq4FD0OZOrOlhWhzSUeLW8SQ9EF4tfGkjdgjJHdHMD1fPwRZC23qKlDVvdRl17diFJ2Yoeyes9fLeiG33TfyKvNzXFR0fszdu0Fj9a7r/ihobmaZ9r4GGxRvNCvkbvrV2bYgTnQlWoFJpqDpO4YhFegPnO8wZmngF/CdZOmsH6tBv8urxsDNoH5l4tdQ3R7Kjx0HUxenUmmCTc//WBCUEQ4JoJfo9XIG4HaroklYZk3LOi+RwIiePAWfCHW27U1C8wVU5/IQquPkAcp25d+YeAt90JA9IkRAmscOy7feTxJwY1x11+JTSDErvBhTUUKrRQhgvMwvWmzxSdv6boOyXw6tdcKJN8L9kiIg6UNygtPPHB3iFRMLw1jUkWVgkc9/bdpiZNGkRUxfSmdrTCvKfbJ+3PyQzmdXEwJ0SlgmwPt8od2HWWz8js1X37WA3ijVnTSF7153cQF3Mwr53IaHwCkUWkzgkuILbBPkv4qP4RWMaFUqSvJLIxkGyLntOR3TWSRgTQ3Jm02jz9lSH4PfTIiIXjmX9Tv5fu1IDoJaKcXFylLtdct31v+ZhQRB85/RaAZnl/j+ArV2/9ipJ9zGeQqzw1YBp/0JpzOT2CoR0019P8f6d/CAfhzEtvM7RSmVIb5YNhMxgsCPC8U8ynbLxwWu915FJvBJtm94Sfrg9bSB3LXseGVZh2ZBzYP65jvdXB6RUZ5M+HN11BLMHAZ+8bCw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(921020)(22082099003)(18002099003)(3023799007)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NMZqpzAe82YzDrqQ9mjm+5LCFpqyD7Wwc20liDxzvHaDtJKnZgY1xU9qeSOdwugMVwi7aQ3hyHftG7Jldifzd2ulAQfY+h+zWLR9xSIUcwNS4eA+AJzg6ZSY8tVljpsLRAg7RgZTO/T50xqgvDeGpU72SJKmMN5pBYwfIAAY0hBNbL2kGmDG8m1Szhf/eNlZpgvoTSlo0UQlc7rBnM+rNiMpfJ4XWHgPhv0VXc20t+PelVIw8X8AQ6O6ydTjz+omPe3urFioaLHnyIe6Ksj0PDXCsIyr5zQs3VdnPIEKq1R8EaDc/fOHKiGFB1uVnpFW68bVMXtK1Yb6Pw3nWuI2FfIvdaLk1PhDpqlpSj2M9IktlDzebwK4CgIOnOV3hVJaQWT2pQp+gEyrcvir6X3p7kuDPjLuDbKyg4tE+SIrLq3bl4Qgt8sKGCOLQq6YWgmL
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 17:55:55.4018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c92f709-6edb-4ad4-b7d1-08debc19335a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8662

Some SPI controllers support high-speed operating modes that require
controller-side configuration before the device can be driven at its
rated maximum. In such cases the device has two relevant speeds: a
conservative rate for baseline operation and a maximum rate achievable
once the controller is fully configured.

Extend struct spi_device with a base_speed_hz field. Update
of_spi_parse_dt() to populate base_speed_hz from the first element and
max_speed_hz from the second when spi-max-frequency carries two values.
A single-element property continues to populate only max_speed_hz,
preserving existing behaviour. base_speed_hz is zero when not set.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi.c       | 17 ++++++++++++++---
 include/linux/spi/spi.h |  2 ++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 76e3563c523f..a1050b1a1d4c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2364,7 +2364,7 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 			   struct device_node *nc)
 {
 	u32 value, cs[SPI_DEVICE_CS_CNT_MAX], map[SPI_DEVICE_DATA_LANE_CNT_MAX];
-	int rc, idx, max_num_data_lanes;
+	int rc, idx, max_num_data_lanes, nfreq;
 
 	/* Mode (clock phase/polarity/etc.) */
 	if (of_property_read_bool(nc, "spi-cpha"))
@@ -2596,9 +2596,20 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	 */
 	spi->cs_index_mask = BIT(0);
 
-	/* Device speed */
-	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
+	/*
+	 * Device speed: a single value sets max_speed_hz; two values set
+	 * base_speed_hz (conservative) and max_speed_hz (maximum after
+	 * controller-side configuration).
+	 */
+	nfreq = of_property_count_u32_elems(nc, "spi-max-frequency");
+	if (nfreq == 2) {
+		of_property_read_u32_index(nc, "spi-max-frequency", 0,
+					   &spi->base_speed_hz);
+		of_property_read_u32_index(nc, "spi-max-frequency", 1,
+					   &spi->max_speed_hz);
+	} else if (!of_property_read_u32(nc, "spi-max-frequency", &value)) {
 		spi->max_speed_hz = value;
+	}
 
 	/* Device CS delays */
 	of_spi_parse_dt_cs_delay(nc, &spi->cs_setup, "spi-cs-setup-delay-ns");
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index f6ed93eff00b..e4fc8ac1c889 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -139,6 +139,7 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  * @max_speed_hz: Maximum clock rate to be used with this chip
  *	(on this board); may be changed by the device's driver.
  *	The spi_transfer.speed_hz can override this for each transfer.
+ * @base_speed_hz: Conservative clock rate for the device; zero when not set.
  * @bits_per_word: Data transfers involve one or more words; word sizes
  *	like eight or 12 bits are common.  In-memory wordsizes are
  *	powers of two bytes (e.g. 20 bit samples use 32 bits).
@@ -191,6 +192,7 @@ struct spi_device {
 	struct device		dev;
 	struct spi_controller	*controller;
 	u32			max_speed_hz;
+	u32			base_speed_hz;
 	u8			bits_per_word;
 	bool			rt;
 #define SPI_NO_TX		BIT(31)		/* No transmit wire */
-- 
2.34.1

