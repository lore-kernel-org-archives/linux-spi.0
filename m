Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011025.outbound.protection.outlook.com [40.107.130.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6873D0934;
	Fri, 16 Oct 2026 20:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792184253; cv=fail; b=VulsETEw9cRYPXZ9HQkPPlJPlcUH3bsKETMvRHUC+Cn8ctLXLuW8V99VHM4jFNF/u1JSeBx7vHHssrKEVvE5M6braB80XCmfqZbKCorIW7oCKUlENHFdnTBMncRXSorjKzCN3z7ndkWxWZMk+zr9A6CH6BP7fTMzV54oKlPU4xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792184253; c=relaxed/simple;
	bh=cATRf/qmq8wTPePKrUiLLyxRNFvd1f6obHyE1/lpGVo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FZqXma3G6lVF1fvCkTjPA0Hn+kBNPcKACq8Ixq7cs2eUtg0Ac/XzdCByQRuOIDyxQ8KbuLmVXbLlxY7A1bFaupEB6EBIHRPbWpkN87+usZgN6oWeaYMIra9ri3cDEvylMccw0VpXU1K6SUuydrqwciJ+PAbIcwHy0SZHRTaJcmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JgnPAWOi; arc=fail smtp.client-ip=40.107.130.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JgnPAWOi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7DV5SoU/jJuLHOAweVFgibFEgUiXOw/JZoVSc/YLrhOUVZVxYDz5TdP742Pv0jdQ5HcEr3WbsyXOgzi/XcQf+giJPtWp6eX4mOgtEICbXcv+H/RaLy3tb8e1DcO179sQRKjIBSK5wciX4JVv+cTwpjCUMjFKJQYRB8S/QSKxD/R+HdgJICKxGWQJ6GrHK9eWZUj1X46wo0Mhv37TvMfTGDl/ki9P1OSsb7CKiy0VDUrDJk5WElqBsLxlo7xlkBkCcLk1H+IWNQuOjDrR/26zAtz2cW9OaKC3J9n0e71QgMblMgH1BEFVCP5SEplxmgZTnqtGZ06w59JdXhQ47ocmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgsFc41Vp5j5r9mjFkMH01PTWzYOkTIqjcFxaK6ekAU=;
 b=ppbHejBZpWjS7Umxjc5NCSS0Eu1vQ/ov/EXa2+OOiqu5Eyx9lXS0+t6omsw5Ghy24mGjkN7MtZzAIDmjW5vYyaAnayhDd3PA62vl/TE6dB8DQzsW9ydD6y3A7GE/upx7RWk7xD/OEBNuT4KHBLT0jbsI/ttrOGjsIG+U0ZkAtVeXdzXSWMzP/pzW61oqlZZiv93lbnrJr55zTu/Qcbe/6mXvrAqklqcxvof4OTRpU1EvsY1lwZqvvefsnJ4vwa95He0Stcf3RO8DREOgG4GTrPTCzSF/Gv1prZiFR8KMoqYBmrh/jo/vHC5DjT6xsOQRBC51r4Xbzf38cEc7p4LY2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgsFc41Vp5j5r9mjFkMH01PTWzYOkTIqjcFxaK6ekAU=;
 b=JgnPAWOiEMOwelCD7D8+rDJwzo0ddUHTC0Lq9KnOqWOTk8fgHHiYYf1p7zGcW0FAIloJBdNFUb4mAeL+xzloyspybherezJDAxgHGm6nPMxzGqtCfWIEfDbQQU6A4KjVoukYN85VyiMutOdiHemqTkNHKmK+3+L0IMngEHVIbsLzyQk1BuTgwDMMCVRsLMn4yCB4gaUC/bm4Y9991FKmbwkPo60renP1m9RmV7k39hmVCvUTjkPAiy6JGXZOHxWwDvHI/jo8Hm2IU0A1pUBTeYMoGnLN4H1MJ/hTkjH0i1OkNbfS4ne2IBBTnkMDIcHVbC6tkNKzJRwhvu5ngxPALw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by BESPR04MB035703.eurprd04.prod.outlook.com (2603:10a6:b10:118::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 20:57:26 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 20:57:26 +0000
From: Frank.Li@oss.nxp.com
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christoph Niedermaier <cniedermaier@dh-electronics.com>,
	Marek Vasut <marex@nabladev.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Frank Li <Frank.Li@nxp.com>,
	Ashish Yadav <ashish.yadav@infineon.com>,
	Colin Huang <u8813345@gmail.com>,
	Sanman Pradhan <psanman@juniper.net>,
	Thorsten Blum <blum@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.dev>,
	Eddie James <eajames@linux.ibm.com>,
	Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	kernel@dh-electronics.com (open list:DH ELECTRONICS DHSOM SOM AND BOARD SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: spi: Add separate binding for dh,dhcom-board
Date: Fri, 16 Oct 2026 16:57:14 -0400
Message-ID: <20261016205718.877668-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7P220CA0113.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:25f::15) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|BESPR04MB035703:EE_
X-MS-Office365-Filtering-Correlation-Id: 54bcda35-b754-4628-a355-08df2bc8157f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|19092799006|7416014|376014|366016|921020|56012099006|11063799006|261009223327099003|261009221227099003|261009223027099003|261009221727099003|261009220027099003|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	iyX0yrP1wyT++ln09RoH/tiyC+3vfgtjMC62KS7gWg2VihtAEm77MbgepSsWfrTpyPOhexssrveT418UG9bgCcJaSLcHgAsjoUlnBZX2HLJUuzU+Kc7RtnIQObFHrXXVDTKdSg58RLxFPOl8phqZWsFxLc1Jjfb5Hv4qzWaYi5DHWwz5Zfdj3HzMBDbvuhWkjnrOblmCk75XTvweFY8VJNyqgh0TyrEX5UtxcyEGK3mpNnCvJ/Zb+v8iyPQsKQ4r8RaUza38gxCc6Sbr3k60jEzWkWZ/vHMOrbBY7BY197ub6bGl4feq4oUBdPHU2KfndBPmYQvVavE/lNxAuQ6IrKlo2N/4FmBV2VtwhOgE477f6IQk7mUbjjHFscNkW4eOA0NypBLqFupGlXsd5u11pXxa+MqSdJVurhXC+1tuNwF14PtH3RzMgUvY9y3s7HLjzViqRLwlswbb2kuR9HIqo6AH7fF+Mh3lBrzq49Glu7YzQOkDfropJbVTt4JstTriBACuaIAUHyragwG4qOEUsr7O7z2nvUqBUZbr3sLCiZ2jvhuduSk/+Nz8QStcFmFbFww9zS1K8/foKoFTJ87E0WmWqBE93h/MDcqZmaxpm3/3qzTe91U/G5ogOpcFBDd75QKXqaKE8+xpzfZRwjmaqw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(19092799006)(7416014)(376014)(366016)(921020)(56012099006)(11063799006)(261009223327099003)(261009221227099003)(261009223027099003)(261009221727099003)(261009220027099003)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lWX8J89plyC00rpHYTmA03RtuX8GBNvc/OXM2FWya1hQCx8S3SX4TeSFyGAQ?=
 =?us-ascii?Q?lY6bGRHlCY9S3EI2/8WUsyrWG4YinQw9J1lUdSBneEDomm+Fyuch2rmRj7Fa?=
 =?us-ascii?Q?Y0h15KuYpcuc0B+3UNw7tB/k6IhhOus3Qk9GQMY4NFNMiYsf12pBshtRJ9w6?=
 =?us-ascii?Q?vTx2GHIFCQdz4j5F9lmxl0I4utY6XCDWt7iOSm/BBaz1YvZpdRbYGfEVqV9r?=
 =?us-ascii?Q?ltdlATcyWL4MA7q8pLbMq8eGFMnj3v8LKoxPpSIunKXHtx0WA0ADnshEL4SP?=
 =?us-ascii?Q?6DX2tblv+XSgN+fqu2D+mb8guY2FICDfpyUEm4Ln6lxvSLJHipYxv/MXsxUf?=
 =?us-ascii?Q?EZggnfhEHy0AOSt9BN0hLStUvGa+IuCpsSHhAvUBHlD3iS2U+4BljwsRRtjj?=
 =?us-ascii?Q?Bwi5MTobhNCfYzfRlmYVA9todl1h6dTGvM8t+iwI7j7IkEKlK4nWPS9JOQVX?=
 =?us-ascii?Q?hVN0a0FXFHzn+rHQLxCT6FNHtSCgi/yUQWcSJVEkS4bIGq/yJPQ79+bWv/Ng?=
 =?us-ascii?Q?c+sgINE6hRHRS7SDLudBmpXgFXf8NZ3+9TCuo09MCWeOs/ZIsJW4IUPI46D2?=
 =?us-ascii?Q?/KVdWMAJehQZHF4BYUdP/3kPqAW+OaIcR2wUil/fIJmJK3tXHbPrgbFcqOOT?=
 =?us-ascii?Q?o6PCYhJEmkGls8CILVNojWb0OILvmDwDleiTk4DHN0VoUvGaRv7NsdL6b69V?=
 =?us-ascii?Q?W2yrSCltdJTIf/UKaRozCpLvwAACTxpKlhBVJ7euEK66TM0g3DB7vaD99tp3?=
 =?us-ascii?Q?/MotWMnFdtX1pAX0m+Gdw0RGAWc5J2qb40MAKj/5A2YE5s5mpCrrL2EnkuKK?=
 =?us-ascii?Q?xjCxDTQs/h+ANs8WOtkF+LrMzBeWLWkmNBOQF+19EGgsr6wkOyFaUEaijBV2?=
 =?us-ascii?Q?sA5E8S4waxYLM2ywNUVjgPIre+5Hb1wTK7Poo8vz8bHhVSP5DAY9ZANJfQgT?=
 =?us-ascii?Q?yx0qKM/eN8sZxpWbIZEA0y97dYrPRUPRUlUeWEnUf621KTCtt0GkUyXPrsAl?=
 =?us-ascii?Q?7Hy6gQ2DMEmd60LXCY5Xo/uTMERSd4Iq52kzj8FEle1lwuRgqocFt07zHcVE?=
 =?us-ascii?Q?MauHvTHOvc27d8BTWnwKF30TDlnWzLwrLlmSTAyh0RcZY5vuH+xIXcvlVjXj?=
 =?us-ascii?Q?sIq1/yKJahQraSYR9wcrVnZfub1gCa7KTdhjDwmMYoDFvc2aUwmD/gEs9IHi?=
 =?us-ascii?Q?jyQhnz4xNKVuVeGNLYjsbGd4X4cYhPh+8lgV8ZP8TCMryx5yWpHwjNqyFe40?=
 =?us-ascii?Q?ApcmgidCuYUdesk7oHIPUVzocyMf3PHwi6fmqX6vMKEvrsE2y14+2NrP3YRR?=
 =?us-ascii?Q?mZx/er3ExoO5As7Va9SB8Mz4vdwaB1QxMrc8W2JpeoJtdmHjON8xEreSAPZY?=
 =?us-ascii?Q?BNFGLo5kJopPmkRENQT7ZoWwSY/tLO227p660o13hRjnQQTByyivXi42+JAl?=
 =?us-ascii?Q?rbXtbMk+C7YfBFiRQX0yzmhPT/hYDcZmMccbM3HbdRInN2l1SThBvf5fwEqA?=
 =?us-ascii?Q?R8M14hg4/L2UURcDKfxPhqjH/ubZG+9O26GWJ/0m2RKiX+j8mDFFah2413kA?=
 =?us-ascii?Q?JrS497wNh/OjHbhV8MgIL563LeLUxO4DTP7f7Y3wGi0aa4PLKOZvZwZpgeyE?=
 =?us-ascii?Q?OAjmHtMDgnrhiH7ISv8TPb00V1zgTMnhdtpKGPjgMi/sbjDkqO11FcCRnmUa?=
 =?us-ascii?Q?CRw73hKDZw1jPywAYaDzyqUU/YtkzCW/7Ko+MsZFSkXftXLKIbfOtbDJUlib?=
 =?us-ascii?Q?6gv+Hzivh2UYRAlAWNFiSGAeyG0q+MfduCu7Ku4B1ryWDz8Dj8V7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54bcda35-b754-4628-a355-08df2bc8157f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 20:57:26.5777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uiL+8MsCGHGqJKp/m6rDRHgwqFSrTZqOJYYT0b4SEoS5f8oTIUPsPMVJVKhiv8H5N+lrTo9zkj0owqdRmvA/2OlYAPIpXHlmQLXMWhsnLC+uneGzMN+3LHukbpniu/dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR04MB035703

From: Frank Li <Frank.Li@nxp.com>

The dh,dhcom-board SPI device uses spi-cpha and spi-cpol properties,
which are not permitted by the trivial-devices schema. Move it to a
dedicated binding file that references spi-peripheral-props.yaml and
explicitly allows those SPI mode properties.

Fixes below CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/imx/imx6ull-dhcor-maveo-box.dtb: spidev@0 (dh,dhcom-board): 'spi-cpha', 'spi-cpol' do not match any of the regexes: '^pinctrl-[0-9]+$'
        from schema $id: http://devicetree.org/schemas/trivial-devices.yaml

Assisted-by: LLM
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/spi/dh,dhcom-board.yaml          | 46 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 2 files changed, 46 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/dh,dhcom-board.yaml

diff --git a/Documentation/devicetree/bindings/spi/dh,dhcom-board.yaml b/Documentation/devicetree/bindings/spi/dh,dhcom-board.yaml
new file mode 100644
index 0000000000000..ed213cbe9b04c
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/dh,dhcom-board.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/dh,dhcom-board.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DH electronics GmbH on-board CPLD trivial SPI device
+
+maintainers:
+  - Marek Vasut <marex@denx.de>
+  - Frank Li <Frank.Li@nxp.com>
+
+allOf:
+  - $ref: spi-peripheral-props.yaml
+
+properties:
+  compatible:
+    const: dh,dhcom-board
+
+  reg:
+    maxItems: 1
+
+  spi-cpha: true
+
+  spi-cpol: true
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        cpld@0 {
+            compatible = "dh,dhcom-board";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            spi-cpol;
+            spi-cpha;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index a8b2b9deade4c..f3099e55b6f5a 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -119,8 +119,6 @@ properties:
           - devantech,srf10
             # DFRobot SEN0322 oxygen sensor
           - dfrobot,sen0322
-            # DH electronics GmbH on-board CPLD trivial SPI device
-          - dh,dhcom-board
             # DA9053: flexible system level PMIC with multicore support
           - dlg,da9053
             # DMARD05: 3-axis I2C Accelerometer
-- 
2.43.0

