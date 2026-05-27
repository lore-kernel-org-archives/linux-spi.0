Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BB34266BA;
	Wed, 27 May 2026 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779904555; cv=fail; b=S/8/pKuk3VRRH6tMClla51koDQPFc/9JDOmBR1GCH/LMHot+VHXmiQO5guDI04bIQf8d7UWkol0C7ndu7tEsvKOYFjZWyS5Futwtv+/J6NCsJFSgyNh2wulrbe/HwiYgd+NTRp+c33X8TAOnPUqYuxdCyS1f3NdloABNkc3Drgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779904555; c=relaxed/simple;
	bh=DPx2geiC+e6vKCIASN3DloUYdzJWZ1kgBrBghQxSqT0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sxv+Qw5XA9OH2atMWZue2IqIXnnOArx5Sxir3k8oK4SiudhLTSpWVD8OOOCbCsI2KFGV7YjDFL9MfdiZeU+92LyfdVoHITWzrqWZ5oTbU/NmMuMx754msrWTQ66YGT62S8cGMOOEucIFdn1h4kILz1mewbTmcFc+GXsWghdsjbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KLb4yZbM; arc=fail smtp.client-ip=52.101.61.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KLb4yZbM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAExmHRN+vB469Yra93xe2ryHXR0+V2na422NS7DVThi0Iwf0AmFnSwuF3BFbVo9JymLdHV0a7Y+jGmCyyp36/hZQVFzaFU42tCmH7fvdQePu33P9f6M5Guotpn6cIQ9Qz9CxkrZ/VyHtPpd8LeAIAZMQ0z0qGqMEma2MNFYpPwkApGKgzyataIkZMhRj9di6UTYiRdyIxQ43UdQehnPpj1om36Zk0WaLs5X+WCp71lNV0qx0Dl3IAP3MGlAM/dVP94XpbEQ6An5IffFHcDi5435vjX47Wp097DgZU3d83RL1LmX+vw6NwxM0OH9rm08WkregLF/gs0SrDtwN6xtVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lufe1WLqLVvDMCaLJGFT6z969LKNNBZnGosNUej+SZg=;
 b=R2wtQIP2igbf6yKtkm8CHY0QFitOQzktsSO93chuRiux4Mi1oQ8+9n6ZQqHNesmZJ2fT80fMD3WJ41mugJCdDe4i6NaUytYN8DtwSYpFis7rBvuXsyEs9vUJSM0/vDHoF6nahMtWUbWIYElckBJr3Ab6EW6Ol6xZPJmSZfz7PAvNDsWdqluoqQKKjhw3YEuvsfkoa94Qf+kBOO2MSf7Zlr6cX1Quj68J48eiudczwQ8RdjM2sx3aTmCUlfkaBDeybxAdmSeQfuPV93m7a1r9RmRUBiC6nDtTN71r3G7ni33Svmrv1FMtLL5DOC6ZjIRFFJ71rGd2U1IWfkD6+YKZPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lufe1WLqLVvDMCaLJGFT6z969LKNNBZnGosNUej+SZg=;
 b=KLb4yZbMJ3FUZ8jOSNDkC0YVvFy9O1cP+VdVFmSmFXtJEoUAJQH/DF5tIel6Li4clapM9kW9mtlaUaTHxta/aZUEKiToo89KNaFpuPKpk7eeG0Jg8ZdJpz0xWH6wlQQz8/0v3oQtOMYbi/ONzzuOEWNba//0ZBsznGAhXasZlV8=
Received: from MW4PR03CA0202.namprd03.prod.outlook.com (2603:10b6:303:b8::27)
 by CH3PR10MB7234.namprd10.prod.outlook.com (2603:10b6:610:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 17:55:50 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::44) by MW4PR03CA0202.outlook.office365.com
 (2603:10b6:303:b8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 17:55:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 17:55:48 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 12:55:44 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 12:55:44 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 27 May 2026 12:55:44 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64RHtYpd4052476;
	Wed, 27 May 2026 12:55:39 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH v3 01/13] spi: dt-bindings: allow spi-max-frequency to specify a frequency pair
Date: Wed, 27 May 2026 23:25:15 +0530
Message-ID: <20260527175527.2247679-2-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|CH3PR10MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: 430e7a21-134b-4f83-2caf-08debc192f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|82310400026|18002099003|22082099003|921020|3023799007|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	GyqfRfr0YGb5D4QsCEVjsQVoRRrqvJqY9xw/utFRn5PQMtJW2iE+Gd8sEEpk9JX3H5AjayRdWEuVDqm6KO4Sqiisv0RRkSxLypfl4r6llGh/l8xlzYwgXMRGJ+/Gl2W3CaTSFkVpLmEEmrXJhhclwbK5PgXWtT1S3VerBwDh4+EP3+/JUKYpRy+ahzI5bPetElhtn2DD9IPSaJ6g83nZtclV1NYXB754X/bME9rRlTGaLcBtZAbU6GKVtCjoNxB/+auuutAVk0BAL22xhwh0FzOTcytMH6uICjivqAAeycfp5y3p0VF0hQyMo9/r9sDUtxfngbLNACWn7NteRt4QR1IldCYorqQXj/uPN6lVVflWzXnSnXZW+v9ahlcGzs8jSxppsA768bgojE0TrTLcLRh4i1HpHVK4h0wz1DuKYl1Zb1wJI96QCXaxu0i6FcNb3GINJksm65/FH0dHLXW9VDy1YSOHYD5D3QtEV/42fXBwhVeIEHdZA72tmPffSAvSfVKMi0kexfeneCBtoQQ31mJMtSoTmHe8VL1uueds3WKdfdsEEMsRftCwN+NtQTXR2hoQvu8OwgkWuJR602bWMuWWLxt1RQaVGoIxgyQvTfENpww/xiJ7DrvT4PgFsNC9osK2AY2RGUoHFMeeXBDjEPlmZFaYoBGielwahHMDi3pPYBstGQL4wA44EqY7Uqg/OiYW9PO8R8EvhZR7AKClDT/a7gyO6t7POIne5HzYgIQJjy+ZIijFeyZPxi2Rczt3+3KMAGRve/nfuJ5Ya9v61Q==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(82310400026)(18002099003)(22082099003)(921020)(3023799007)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	S/wKHs1CPWJdo2TIDizPqL36hdyVENCUwH6gfcESY4eOOxG7Q9EYo52VBpOPJS8Qn400Hdu27OCRh52RX5F+96vykvSaXYk6IGiZtmJl0zMc3ewXRalh7mpv/qPEM1KUsRax9Yfzl1pv8/iPA2C+IqNfGJhXOqzJCiw95Ktg+EHLbhh/rbSk8Aa5X/NcLaJx8IUuChCeNrcTNZMNMo65JL2ZcUHK/TLFc7iYT6G2QA87qTNTTZDzFBj4HaaSTmEJBQU62mYJHi5DBfBvxtv6pHm2Gz+BdeWa6Akierj1oC2W+kvpJr3P2g5rRpYe2uXe78tcqtS7jKY36RMmCADBFH4r4B/MyFEqlnplcwGZfSngI7mY9OL/Q9kKSL5D7WX/GLqnBMHZ9EYiZNH0tLQxwjtg+rwzCEoc/poqFiFXUOcpLPYkCn+rgnzR5jH4Io4Q
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 17:55:48.4338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 430e7a21-134b-4f83-2caf-08debc192f38
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7234

Some SPI controllers support high-speed operating modes that require
controller-side configuration before the device can be driven at its
rated maximum frequency. In these cases two frequencies are relevant:
a conservative speed usable without any such configuration, and the
maximum speed achievable once the controller is set up accordingly.

The existing spi-max-frequency property accepts only a single u32,
which cannot express this distinction. Extend it to accept either a
single value (retaining full backward compatibility) or a two-element
array [base-frequency, max-frequency], where base-frequency is the
conservative operating speed and max-frequency is the highest speed
the device supports after controller-side configuration.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 .../devicetree/bindings/spi/spi-peripheral-props.yaml  | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 880a9f624566..c88f6f3a1801 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -41,9 +41,15 @@ properties:
       The device requires the LSB first mode.
 
   spi-max-frequency:
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 2
     description:
-      Maximum SPI clocking speed of the device in Hz.
+      SPI clocking speed of the device in Hz. Either a single maximum
+      frequency, or two values [base-frequency, max-frequency] where
+      base-frequency is the conservative speed and max-frequency is the
+      highest speed the device supports after controller-side configurations
+      such as data training.
 
   spi-cs-setup-delay-ns:
     description:
-- 
2.34.1

