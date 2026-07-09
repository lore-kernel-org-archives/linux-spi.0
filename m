Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2135.outbound.protection.partner.outlook.cn [139.219.146.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DAE27AC31;
	Thu,  9 Jul 2026 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783603621; cv=fail; b=bPSCSt2tV1W4eLaUwobLi6gViKAC9OEmBK1mtcBCWuDdeateKjyVN3hEvuxp+raPQsRJzW49ZZU0s++Ydl8eNVRirNdQB5bfek0iMIxYG5bAlSnR9+oMsCnIUfKTkkLtOGZDlcu5P6zgy5qHGstrAe4fo14GqVsmyAeOf4zWb3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783603621; c=relaxed/simple;
	bh=h6YOQ2c2GJKhXfmZfK38dE0SeUVHRg5YiiJap1KIcO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ll2clLqd+Wt4/B7eU3YLuRoyd9dNPrzfFx/KEm+3C+SfjBLqYm7bmR20OxuZf7TpwDsetOPhLflZVkoIO1HhdC9eR5K5OKnHB3BezEYmVsRMdfdsQ6FJGp++BQ77o8UxugYIvfCWkIWtVJXDhQ6wpu1k2dVlK55W8t/TPVKkvGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CImUjfk5I6FSC9WIORLfqN403g5DBCgGGRbHKoeCZgiS06BeJKODEDmU1REfbaKhxco9v0VApqOH/JuF8Q7EB9bHUKeciG2ItfJn0en/nbw40m+QRotep9V3Hdk3YXu/PGAHebhDxpAPZ8dChM16GQByXVwHK5zx43NcN84/cjRHqNnJWDIir7p1DV52CZ5UHtnaEH3R+smmTozWf2kp2o+D9vAGrD8H24HbqKSmRYH0VNCa/AHUluxg3INYJinRcU8ndFMwZJZfroWc9J9c87Oew/t2YZTqL0X8AlbUCV0uQkLp2v2ACR3rW/k2JDqi4iIAop0FQ693EyhORmWauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fuoNgWGZ9ez6F4MaEDbwrwl4jJwQ9hd+yZ/URzpFMk=;
 b=gCprp0o30l06LpRaZDZGCGRFrLNsyOD1LA1VXBxqaqVd8KlaOE75yiGZTnOPWHy+7+xGOoNE/w4MSlTUkgAV3IaMInH8HKTEkgAYvHWH/0LVXKL9VnI0Ld7P4Gd9NH86HnwbWEz64p5wZbaKoEdsq5okBnXJQx71saQ4d+E42U6Ztv9RYIJ5iWilLvbsFX2TcrLtk/NI/1byc6LVNS4J+zY2Tn/A5C14L+VSnjEJs6jVLWH5zLn1TdO8kGTwMR4HrLMtFA/aaIJafByMkuuCNccayN79wUXA1deaPaGjsMIfzDeIBT55b55xjleqKIovnZftYSawyoy7o8j1rfK5PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1282.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.23; Thu, 9 Jul
 2026 05:52:26 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%2])
 with mapi id 15.21.0139.024; Thu, 9 Jul 2026 05:52:26 +0000
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
Subject: [PATCH v1 10/11] spi: dt-bindings: snps,dw-apb-ssi: Add starfive,jhb100-sfc
Date: Wed,  8 Jul 2026 22:52:03 -0700
Message-Id: <20260709055204.138168-11-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 866da587-f65f-4579-95f8-08dedd7e4128
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|23010399003|376014|366016|20046099003|38350700014|56012099006|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7Wcqm5X/t1p7hlJaMJCIRCuNgEVBPIHVw+MRNf03Zm5DqM7dBaD9KA5oG817RSm/foPMTkiiGF6LWF9RjTBe3UKdam6VshH0naggq2gZn/J3vVTBDnLue7SnDOzN0uRRlYRT6fb8vLSo4UmV7muZyy2za2HjMaTmzyGRPtt3yRCzERtuNzAYbCB4GSY8RD5FEcFwa1oG9emPb041fjjBK5O9wLd5hlPIvs2fpDrp8FppkNEXgwlrOgsxuJV+yr1TyoExBgiQ3Mq2/X0lLPnlXugCOTu2BKil3+vRPfvw0UK4z2d/4HRpfPaDn1DsOlGm9Bpv6Ss1XgU+gUh9ehZZLplSN4R2pOhlqgYR4p/U38nyGVx022mW7HNL8n/xpCyIpoQzFUPS5RweDAHWGOzTkTKx1ptAzvlnIxxpBb5VLlvBNH7EqIBE3Br6TFTpIgw9m8auOAs2g1WoYHKBQ/2sPNm2ktDh30LsBbCtZOsBspJnCyiZAEKGAOaPqwpvlY7czB5ZVMMMFR+VBYmTGWmRe5FaYri8W3NR5wyah/Dhq7XvqoXv++pHLCaICmvwCysL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(23010399003)(376014)(366016)(20046099003)(38350700014)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cup6Dx8vJ2vVnEhaIGXJdH+zEdTqpsz3YsqDb/vEkWu/3dGtSOmNz+FsS8KA?=
 =?us-ascii?Q?f1RVwn5RwSN9asBve+8phaJ4Cajir/6t6xWylTtKUZbMGWzMYpfMFLb/d9y9?=
 =?us-ascii?Q?kFb2MsLMYtaAqHF0nDFqlTeDjy/LDTPwgqV1IpYacgk0Irf8fMkcaA2uD9nY?=
 =?us-ascii?Q?hQ3VxUC4iqWwWEh2czd4y1mO7UOfcaCFH4W/bqNSilj3WEKoJCswoHmieKzr?=
 =?us-ascii?Q?cxQIEpV3gpRwnMF+NIx4HyfqUscsGV4mgebjq42pJDutI5E70Oy54tkR6ObL?=
 =?us-ascii?Q?csIdZn9mOESUVJz0ekYxTNw/wmJGsOUwjuUTyrUif7beNtQOQrc1L77fnhuP?=
 =?us-ascii?Q?auhzR9Z5HaQtRMBLGcZXeiNCL5nINqM4sroSI1Lzo5i+hT6T9e+QCvv8weSl?=
 =?us-ascii?Q?TzMfMMBV1Xa1NzTlPqJo0llyAA3pWovSSNv712h/ja9speveOWX4MgeyXMjs?=
 =?us-ascii?Q?9mTHcKy1HvFTONavjNLtOek5TbzLjd6Ft9dhXt8bKvwVZDOYLCa8pIsA7K7Z?=
 =?us-ascii?Q?25ZxPMTAIUxY0CB2FxB1IlN6vNeokhaKg1/x/Q6fJovjLvhrHFMS/1WUljnf?=
 =?us-ascii?Q?P6h5wU5tgn1lnc0MmmXs3antqnMl3R/HJ35hmWHgpMjr/gMPahbSLMZvpK1g?=
 =?us-ascii?Q?hiYy0VvywS23QAeummwY5Yu2CJj2BZhQJgNfmh/VYdN9DhCdT+fyvLU1F5BX?=
 =?us-ascii?Q?tkK3svG0XimA/4VdqUQNVZ7Lx1HhuIeSuo9/eAb3P1MkE+1P7I+WpirPF5VQ?=
 =?us-ascii?Q?3xmkDW5wFL795sHahAcEoGVv0ijlGI6B2QoVqwfyAKn7yp8MYetudCQ5sx1e?=
 =?us-ascii?Q?pIF7inPVFONA8+x2BsLqPLmDX7Box/e1QYBTIXii3+Zm9NwE7FDnKqz6SnYA?=
 =?us-ascii?Q?ALccfxg/QWoFa7yEo4h+tvteb03ujAAYM3DxL87eJG9iWeohn44Z296rceYY?=
 =?us-ascii?Q?AZED0h6Xo4C6v9QMn24d5UGPcXaEnwpKZC01YNsK8b4kkrFOtu3GsQ5cmgsy?=
 =?us-ascii?Q?I6L5xrfE4CCJaD3c42WjdgyW4F0rWQBswkVV1okpo7u2ZPYEA8RUCK00gcp6?=
 =?us-ascii?Q?hi/vFSo7OUC0LyWDTHVYE3vq+X9naNfnY4H9pu32aA9dKmafAjrMZoDqx7dT?=
 =?us-ascii?Q?qtIcm7WmsR6CejG/RbLKffyklxX0bZ/x0CvBGXzUYz8kHhga9LGSTgKBt7lC?=
 =?us-ascii?Q?AdOjop1aCIbZz15pRHvICXRjbUN/bGlr/49a0gyXmn5gTQXqCfwUFiJIRugG?=
 =?us-ascii?Q?9z73haltSXo8vq19sryScrt8gwYnS/sIn1RrRJnbHcvo9h6N7th7ZK9ShOE7?=
 =?us-ascii?Q?29HX/ptucqE4GLSpdQr+QPiJ1g/ozopeBwBkb2ZlC1/uo7pEyDg1d3dVYpz/?=
 =?us-ascii?Q?DO2WRwsca8GHm47LcqBqlA4zItm4UFxvkQsqUXPalY2AEWobjL20cE5DRQiT?=
 =?us-ascii?Q?Oc72vdm3nyLlgDo8sTdetfFg3knh05ywyGjK0mhp35H6Kh7MwegBy6tkYPj+?=
 =?us-ascii?Q?Q2IXlXK7w4kAzrCKWsxN9S8yFnz3mUS6WiQ99dqJSZP3oshUg2+uACOX6xko?=
 =?us-ascii?Q?+EXo+VCN4QLO+7lgp4hcCsbwoU+UNEx2CvI6dAjrINs84GE6lLl+RiqZl6/J?=
 =?us-ascii?Q?1DgFAi0xHFo1G2KIl8uYZHIG+AJxSmKMvLhFqId09cUOLOX0rcse4QFSMY7p?=
 =?us-ascii?Q?CFP97wHVl6sSRJ1jEzSHpObOyX76ZHkHT+26KNiKF6Ox7DwY/5lXgCOY7aVw?=
 =?us-ascii?Q?VkyVio874R63d7INdk2B3K2JSKBauFOZKu+hCWB0AIZ+Qi/sAPVw?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866da587-f65f-4579-95f8-08dedd7e4128
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:52:26.3014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvbjCwLVkigmw6dVEjnW544QdlHyuEsZ6ek4oI+vP21IqHU9/Yc9ror2C1coM3Me/aCNYr5pu786W6HAiNPoGCTl8ASEd1bTkSkZZ8dpJ5Bv4fzP92+iTuG9QXWIU5oG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1282

Add a new compatible string "starfive,jhb100-sfc" for the StarFive
JHB100 SPI Flash Controller, it based on the Synopsys DesignWare
SSI version 2.00a but with minor modifications.

Due to these minor modifications, it only supports access for flash
memory and requires a system controller register to configure the
address mode filter for SPI NOR flash devices.

The starfive,sfc-filter-syscon property is required to provide a phandle
to the system controller that manages switching between 3-byte and
4-byte addressing modes, essential for supporting SPI NOR flash devices
with different address width requirements.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../bindings/spi/snps,dw-apb-ssi.yaml         | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index 4458316326fc..f13cb963db88 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -33,6 +33,17 @@ allOf:
     else:
       properties:
         amd,pensando-elba-syscon: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: starfive,jhb100-sfc
+    then:
+      required:
+        - starfive,sfc-filter-syscon
+    else:
+      properties:
+        starfive,sfc-filter-syscon: false
 
 properties:
   compatible:
@@ -68,6 +79,8 @@ properties:
         const: amd,pensando-elba-spi
       - description: Canaan Kendryte K210 SoS SPI Controller
         const: canaan,k210-spi
+      - description: StarFive JHB100 SoC SPI Flash Controller
+        const: starfive,jhb100-sfc
       - description: Renesas RZ/N1 SPI Controller
         items:
           - const: renesas,r9a06g032-spi # RZ/N1D
@@ -139,6 +152,15 @@ properties:
       Block address to control SPI chip-selects. The Elba SoC system controller
       provides an interface to override the native DWC SSI CS control.
 
+  starfive,sfc-filter-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Phandle to the system controller register that controls the SPI NOR flash
+      address mode filter. This system controller interface provides additional
+      configuration to switch between 3-byte and 4-byte addressing modes, which
+      is required when accessing SPI NOR flash devices with different address
+      width requirements.
+
 patternProperties:
   "@[0-9a-f]$":
     type: object
-- 
2.25.1

