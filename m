Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013002.outbound.protection.outlook.com [40.93.196.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0F44C10DD;
	Mon, 12 Oct 2026 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826609; cv=fail; b=K90Szhiob2nvJWyktzrkMQiySqPBBj+QPfvncFUDBn+2VgcCUOa3YvTzXu3CIIlS3ThYE8Ges7nf5AMCovFKFxF/XvwRKPKr8zHo9aZUzdASew4Bq9OnoOZbrzCC+f5m/I9fJGqjlddYrEJkiWap7DtKdRaZlTK9j3gXm/cPUk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826609; c=relaxed/simple;
	bh=QM/r2zck8gykOsNdKOLWR1HFKAIvh+BSmoUMn0RUaEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=soSvVGHTDcHL0pEkWlcZaRHZSNSim1S0XFOmR1KXmh7W1j9QO1MUjRM3lSGgJaPJk3U/OrM2jkrON/RveZ7LlonSksMAGQUdqBWY4GJr5EDcQd3/n3DorjIdmZQTKU5rsK0ayIgTMo/HtvlgECi0MNRrGpqdJtKTkkgh/HWR4Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tCSMtzmt; arc=fail smtp.client-ip=40.93.196.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tCSMtzmt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uj/GA0+Qqw1A0VIhUGdFyOg2rmYUIroVew+SUH067RL6uZd8wgwzYdW4BPwMRJK0TF/J8CBJaNzTFWmFjsqZHMpGSH5tfbuE/gX4EiVO3LVJUlgZsWiSlKf6EVHOVaFKr1iJKgKCODU6zx0/C3fS19DH612bHlXNI5m8yRdk54WjBAEWsmhIltirLASZVauUPUPxOiyEE4wGG9TluWkKSWUw3hwB/Cq6p71wkXsYnswSh1uoAIOyVB52njpoeCaDzkGB9vaPvlVLx24/AhcnZvVmRLHc8KC3L2ML2Q9VwphXTUZdLWNG4T86yMVjh9WQOB0lfCTZ+G+bPPwYuoTeHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYfrbqrGzT31475lQYJWuzbrBsKjs1TwL+Y0vC81r8I=;
 b=P5xbpkm4Mj9hV0jPF7i+8DM6wlUQHR6A/zQwkI0fGg2PUA1HdHv9QjDcv4H/iWeJ9ygAuvqTizCMZQE7HE1oQgJWx0PlfOfkyCpOyqVdVEnT2nTmvu3Sz5cjLXgSg2TGJS2C7ChAt7jKSjiYUiEre7yN9EVxfUIHger6JE+cFwa3uI+Ar5Yfnya5HBbjs5iPAqHXUxoZpKD09DA87ehG1tXnOl6gDKFn4sUsE3wuQfn0ly21BW5x2ykAJfcqxNCuf5OHT0zc8ytHN27vntPsNSMBtHjRNuJ4pYWfbZK1x8U7I6+tzxJMnsjsdK1wWY56RANWUi8RqLMZUK7+GQ7Lqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYfrbqrGzT31475lQYJWuzbrBsKjs1TwL+Y0vC81r8I=;
 b=tCSMtzmt6WuyoFFqPp/YmOJf4nAPxOfndU+JMwTcUaQC5kyi2BMHclrMErJpav3/4zNAQijKk+JBUUMYusEZDHVjEQU5ypummJGGjS+4RPgTgms7apqKntdPmoiefpCVjrQ4FpmgV94M5yPSNnq/PbEVgtcCaIHYJlkTd9LhJNCzIWYzQXKmwLvbitelbbh5HRWMldhv16mgcdah+mHkEVrar92mckqwvzwlbJoHcsYjmujsRhh5158sCOAdwB1IupmyWmolztRZvvucpaN/rCRVY6XkHJB5RcTb/GsrNKSRoAQM34Hjtv60mzMQBRINXlJa8QNFaeNL3aaq6ghhZg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by PH0PR12MB7012.namprd12.prod.outlook.com (2603:10b6:510:21c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 17:36:44 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0496.010; Mon, 12 Oct 2026
 17:36:44 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Donald Shannon <donalds@nvidia.com>,
	linux-usb@vger.kernel.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 03/11] dt-bindings: spi: Add NVIDIA LSTP SPI
Date: Mon, 12 Oct 2026 20:36:01 +0300
Message-ID: <20261012-lstp-usb-adapter-v1-3-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012-lstp-usb-adapter-v1-0-aambrozewicz@nvidia.com>
References: <20261012-lstp-usb-adapter-v1-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::8) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|PH0PR12MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e96166-acd8-4548-30a3-08df2887626c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|11063799006|56012099006|22082099003|18002099003|261009223027099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	D9G4ulppmTrRSHBxQt9/cp/vLiKRAhjE+VYMvdlVvl69XPep4XGhdM3PTgxGBoE5B7LGFkO7T7vlxWMONI/ajXvXlW8jUnqa+exwoD3hD/e84sB/XaopdwY+GhI7LotE45K3NBX3o6idyA/anztWRm17NBqLmG1GW7wYuv7tem0yeMsouDUH+Sd6WuJco+GyfIxml18K053QBkuE736TwVkMd6Yhu9tCY+KfPTNoSkQUeqYQR0R6z6tPTe9sDS+0Yy0iv01P1cRKlwJ9WZNj75wbg4OOFcw3vsvNDAZAiN64S6x7dWGCteyVUB7Xv9qh5R6CQ0Qr5qh6Zh2IIm82dbHZscX3ea8fR+shxEywVLhqvk/KEUbq8088g30aYOlkF+7wZW56tmK2/79JxqMmH+L9O3+eY57jHD3Y3746YpKpZ4tJI8h4ufqY9EuC427NO95ZZOk0U9Pq7bq5MHdRQap9RCoC/2jLJpvlEb/q2T1ug4fxioXROS8i/WQcyD5TlMv//xtqZrRNjOWaagFMOgNXZbLqZL2cc2ATN3hMjwx09U2niNbKZKd+pwL5lcQ9rtkihyVbCjrH1pY45Im1wYEOH9EtyryJzhVBGxhemXB1hm5uVQTLQf7GMsgKaJTtxG+BJAolPpn2P0zd8RaSNTHH/Hmg3fVmNZA+HKwlKNE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003)(261009223027099003)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6LDRByZ6VO5f/xOEOMlXS+kDyb7lgMdWZkbSDdvl8HYbXlfLNOh8SuXtkMTo?=
 =?us-ascii?Q?luvMgrcJ2UPDHqIYqUjvM/5WrZyKn3qQJo9/BRcW50VQTE4PpWFj7yJJxmRR?=
 =?us-ascii?Q?yNQwkJ0h0W4Hrw45pL73cZLKAPEu3UJIzGPd6d770TXMjHMM5tqBuKv2f897?=
 =?us-ascii?Q?WcXo5+j3TUG0BTtTewOmzJsUUKSYtIKZywtOkXqla4NSjmXLrk7f8HOuoEdX?=
 =?us-ascii?Q?NZLLMVFNkALMlLyIJ0V46J/VZEwUj83r0GCmboqjVb2vUbOdVbLScK2O9U6C?=
 =?us-ascii?Q?yAI5Bs6Vt+m+E32s3krOWVpPyCU9ZuUvl/Pg5FCYQmG07qjhvQecHGNaoWox?=
 =?us-ascii?Q?vITA6ktCD5wWyJmPXt1W9gZdzRfbd2qPu1EfiznmZ7nmjoSgTO4wnKEkJfBR?=
 =?us-ascii?Q?ZRxAKNN+kjrU/DHSaaW6o8HeUCy/zRGVltZM38zm/HpyUfZcpOVOelSnOjkb?=
 =?us-ascii?Q?tYPzVCuzplPgGWrGHgxVl9D0cd79WRcIxKrAvmHMyooTXnCYBOh22Hgjnq+4?=
 =?us-ascii?Q?aoznqot2g/7K926Mu89atZpIWEeT305b0KQzMhECdzAy/FsTkDxK9KREh2J8?=
 =?us-ascii?Q?j67+Ulir3UA5M+iRj/Ys+ookIkEyTMs5in2yVIovx5PZTycPBreBc2mj9bnA?=
 =?us-ascii?Q?QUE9vioRPeDkhk2Ie3MpQIQ7xNg/POU8FOtTSwFeMBFvKpVYQp+WZoqGY5eU?=
 =?us-ascii?Q?BUsmpO9a/vLzxx824FPJ7WiZoL4gKOsynX2cAL/Bc716tLl2AbPKMsZ+8tjn?=
 =?us-ascii?Q?0EW/opf5likUqawyxvzwvXvI4bedsd8VBzSssbuwXwFt/3hPEe36aSCjXppU?=
 =?us-ascii?Q?Gp+ujFKZg8a73PFqRnFT4uTHp2K5G557Q3CrUG4CeVLBuxPq+vhV0h4bdPwr?=
 =?us-ascii?Q?e0k0/EBi5KZAtWN9tHOEs3KnIertaYdgp9gsj8mU54ESimFZxGxeCuoNNM+3?=
 =?us-ascii?Q?VSuICQLld21diBCi8zlhU5lvP8ifyYw4yu/OfGviJJrFrNm/U9GDRag+n2PB?=
 =?us-ascii?Q?EGG9f9bGh63Ox8ZMxjvpNPzg3+YXeZpm+h73i1oAGB90/qVVjOwpNZjpZTJN?=
 =?us-ascii?Q?6FX3CbxMyBtTmcDbKdZS9UbEem69HwyLGXR4NUP4t9qCZBYcn6FT98rcOGta?=
 =?us-ascii?Q?uzz6wiNi3EDzckZvOeavygleQkTakDHvDbywdljXkHsgN+OWizrYcJUb72rH?=
 =?us-ascii?Q?JofEEJ8Prm1MaB+c9YtxI8Hsbr8I4LSQ70viBaWvG+EhKdnwCYshF/mkx7Bk?=
 =?us-ascii?Q?xE9HP00hz4bRUwMH4fW8wFgpZPIwxD0zpP7E1kR2CSQv/tk9QdURRMiayV06?=
 =?us-ascii?Q?rAUbC+awni3IC+Wd7W2sy8mRzM80nCwbJllgdzA/r2Ft1Ub2td+ajlzPHlE6?=
 =?us-ascii?Q?5gzD97YJCcXnmGMYHdLq1PvSp0RfIyIJZHfZBFBz9sTkrB6MoQ+UgJQ2LNC/?=
 =?us-ascii?Q?1UvatMrEHDEbJdpzKl/3cMhNJ7b07sPLSWkXihb4YQfO8IFUb0hp/JxwsVpV?=
 =?us-ascii?Q?8No2jlVZSoFGsUnMQlWQdkXRUTmRG4Uzw/NrpKscjPVv/Lpo1IxryPiraLSW?=
 =?us-ascii?Q?XPGYWkvoam8+eb7XqB67nMMqsLOSJblrowPnoanOwkvhK6ICkccV9CPWeR2y?=
 =?us-ascii?Q?RmYy7C49WUP5Z8oFfAPVpWeUfGNfKfqN2P/fZ1MJ0Uae/d31lYi3iDx7SS3O?=
 =?us-ascii?Q?H4cNuw4s1hzmHZ+xXY9xUhNx/YY0sA1NI9SERZ7XXJ9EZrMpqNxELyv7X/qj?=
 =?us-ascii?Q?hTcXNsVf0w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e96166-acd8-4548-30a3-08df2887626c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 17:36:44.8404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLLQQcEjng4qnswvOmWD5N1mbiJ1z85bZT6QMZLUTy3mYvj1Nh+R5kCC3UKkyAudHofnVefjJXlt2tdAhf3u1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7012

Add the binding for an SPI controller channel of an NVIDIA LSTP USB
adapter. Peripherals on the bus are child nodes, as for any SPI
controller. The firmware reports the number of chip selects and the bus
speed; only chip selects 0 and 1 can be addressed.

Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 .../bindings/spi/nvidia,lstp-spi.yaml         | 68 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/nvidia,lstp-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/nvidia,lstp-spi.yaml b/Documentation/devicetree/bindings/spi/nvidia,lstp-spi.yaml
new file mode 100644
index 000000000000..5a96faab9106
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nvidia,lstp-spi.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/nvidia,lstp-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA LSTP SPI Channel
+
+maintainers:
+  - Adrian Ambrozewicz <aambrozewicz@nvidia.com>
+  - Donald Shannon <donalds@nvidia.com>
+
+description: |
+  SPI controller channel on an NVIDIA LSTP USB device.
+
+  Peripherals on the bus are described as child nodes.  The number of
+  chip selects and the bus speed are reported by the device firmware;
+  only chip selects 0 and 1 can be addressed.
+
+allOf:
+  - $ref: /schemas/spi/spi-controller.yaml#
+
+properties:
+  compatible:
+    const: nvidia,lstp-spi
+
+  reg:
+    description: Channel ID reported by the device firmware.
+    maxItems: 1
+
+patternProperties:
+  "@[0-9a-f]+$":
+    type: object
+
+    properties:
+      reg:
+        description: Chip select.
+        maximum: 1
+
+      spi-max-frequency:
+        description: Must not exceed the speed reported by the device firmware.
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    interface {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        spi@1 {
+            compatible = "nvidia,lstp-spi";
+            reg = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            flash@0 {
+                compatible = "jedec,spi-nor";
+                reg = <0>;
+                spi-max-frequency = <18750000>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index d8092f6d91b2..a45adf95d36d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19572,6 +19572,7 @@ L:	linux-usb@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/gpio/nvidia,lstp-gpio.yaml
 F:	Documentation/devicetree/bindings/i2c/nvidia,lstp-i2c.yaml
+F:	Documentation/devicetree/bindings/spi/nvidia,lstp-spi.yaml
 
 NVIDIA VRS RTC DRIVER
 M:	Shubhi Garg <shgarg@nvidia.com>
-- 
2.43.0

