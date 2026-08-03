Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2104.outbound.protection.partner.outlook.cn [139.219.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9136541DDF0;
	Mon,  3 Aug 2026 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760884; cv=fail; b=pI5prp8R1l4SIvijZVA/mhBnwuzndSu7OUSndnGHzUrhWEJeygwy5cP105cmRFSV+m1AuiMsvb3uwEmy1Zqx2/cwtcam9bl6IzyC0zkVYtJPcz7T8/bNlyqvYFxKx2k/Mma/l4acxLYiElNPWgwEZWN2uwr9Bpf6bOnbZdxSWjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760884; c=relaxed/simple;
	bh=QB3lx0xZE2v6ZeTV5ezJfFEOXNU9sS9E8H6xFFHdh/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mS7YEddly9YXfk5Y7k29M2l5zvrlUlSpeO9dZjYEXBdDBBG6b/fhB4fTd/oJ7uagKy3R/XEKjeZB2hNMsyomD0cRPiLPNwDOVgpCHI74oFSqSCAkVyt716iWQ3H3if9NxR07t9eCjdN2Q2T9Q0kb6F7ZBUVg2cUzawpgdMeGZN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epSh1X0xnW1drsYQe3Arn6GOHLAJiFcfl/C86B5lPOmA9Cg1VR/Lwu7SEQ9QxHWhvFySZkbzNGJSRtXACVmyBUg+1G6jzNinT7S7Wz5DnPFANDeq2ZoZHOlZGc/l+BQ0WLFzgBcFL71sM/W1WeTEc4sNN+JATuz5vZC9GaotTHNOyjKtKIBrgR6m5KD1nN4GJ9w6T+8j0pxbQ/Dy2e+ExlsWbQauu7V67lF1TAKiuu6zQowu3OPLKMJDz7b6SWTgn6VsZ9vX9RHsZzmi3CL0WDpvqV96uUDi1nx3aB26MyK7eLK3LglMklqwpYIhaH6HwRhMo0IAGVWK0i+zP8xclQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zihMB7prXYTHOmSQ2Tplpk5UIM2ZlZRLo8jV8q1JwWY=;
 b=QzMPX1fDAEydKUOL5BlWohHIQLYbN5xXiE7DAuN6fMksua4sgdqKbv1/c8jckkdzcv5UKCJJomNpk8BxgmChsZ7N8YKzDVrB0hvEu1LctKmLPhEPeoK37+mcAbWk3jCVTzIZMpGHwp+ATKfypBZrl3odbVZxFOCLZ8I3Dq85JyfItasCxn0Q6yezh/Z15hMd9KdETe5T6iK/gKzzMiO1wg/UelOQCHQAHRdZ4powD1vmwSdyatd3GFciXQflL+363LqPbejeU2lQvh1VZK7Aopc16uGkx84mIRkBga5YfAbxmH7hdIt+ItHUylugDzVuj6mK39SH9w7WlWHm9lXTnQ==
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
Subject: [PATCH v2 10/11] spi: dt-bindings: snps,dw-apb-ssi: Add starfive,jhb100-sfc
Date: Mon,  3 Aug 2026 05:40:43 -0700
Message-Id: <20260803124044.156998-11-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: eada5cdc-5d09-4c83-24e1-08def15c793c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|23010399003|38350700014|6133799003|10067099003|56012099006|20046099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	K2UuiJuISXQk7NretH1+LJUroKkFKh3RQzWbWkYbITu/yaV3xJ7T2sRLj7qyrS8sD/rBX3xPJ8GSs/kf1pmuiT8iVGL3Ss0gw/NlokJUek1kwKD8+mWRDYQbxhOFjYMtx4I1u5IiHEBJ+oCIbsovDi9gSb4op7n9CDK+L5Ke2y6qG2Ap72mwZ7Nltk+OjLZeDCVT9W5o8ABDkrFzEyZF9G5+/q9/EqnjMOAGDfH28kHF8v7LCF89tt3OZmQo0+lkpn2ZvKriZkBJJMk86Tcb8rBrhE7W+cwh11xYSRnvsowIi4O/7KLAUiJW7+5i1lI1yJv5HUhjqpkBkJmoGYiJajY8jrFO1GcQb3SWsy3TgEnGcUBwlyhcLkt/xmb/KcNy60r/jbsixY19FBAHN1Zj8kNL3a/pJBdh6jxqeNWazvz7X6MfdHnUeejQGbEy45i6abhRAMtaxcWnDej711xc2KhfIbhizH+vr58Emr/a7A3OFQq8BY5/x/OJJ4M0KVhhzeELqyXKa0Kx1AcOK/NImDo1XLq9FQJn2X5o72k9LBCGFPYB9Gp4nRJV3hdISsqq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(23010399003)(38350700014)(6133799003)(10067099003)(56012099006)(20046099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K17UGvweAeWssoqSQubBpp34gV8+czfb3rmnay0y/0XSImYBcw59qw/EQqcV?=
 =?us-ascii?Q?niZXfHYzWSXbGhrgMrabP9ki05qiU+WRlm2BoR41jPtXKc8pGhfACDJYCkxq?=
 =?us-ascii?Q?Td01frwxroz9kOgv8/x4iKw0z+3c2+anV+vfgLAtt4KoeBx0gmL1xnRgW2rh?=
 =?us-ascii?Q?u0KoGJ7VfR63c3WUzAqB3SMaWALQjbGBVnMl1zihv5dav/a2C3sILNpptSZ0?=
 =?us-ascii?Q?83ZVeg2Ku1Bh2jm8Xdgyx1GngkDKXVD0npFpFmUrmMFHHATnlBZIGrOHdOJv?=
 =?us-ascii?Q?igVYDtxYcYtzaS6oXHNnn6L3FSrjFjiLGauQIfBlSoKAEsAGJ00NGwXBPsK2?=
 =?us-ascii?Q?a7L23GZIwh7q80cJjVTt9UC8jhTfcyXaIE1Y0unmKNnVcN8lCbfkJkgGhUwF?=
 =?us-ascii?Q?J3wTjo0wr1QWisfnvmvhJAm4iLT93yWLK6DGQbz7GTI026tr341/0ETWWnNZ?=
 =?us-ascii?Q?XjNaDU/osR5q+l/0Uizp4IRTkouIsO52uboYcuKdGWnhv/zzhweMbZ4Nhi0a?=
 =?us-ascii?Q?aIiJZBQ47xBNIQa6s3f9vkZ3JWVgDDOTclNc+cMucKCAi5werGY0eNlXxlkx?=
 =?us-ascii?Q?Qdg7tbEKXycDwEVIxUb4XoVCKQeHhO0vt/ytIsN1pVy/phPo2Be/rerdYOKY?=
 =?us-ascii?Q?wICTCaOkXaudqbwMdDCRQNveGKZM17UVdCIOkt9FUsG90SpHiMR/JXGBSWq1?=
 =?us-ascii?Q?XRzax1++WxKk2WCEXCBQeVk8TQ70tLGpu69nwT+DdHe2YXaD7tQ6ArWKurWp?=
 =?us-ascii?Q?odh6ZTy35gMXQTmofQeEk8VBaswAKkt78IHdQ5xy7C82mLkx6fRZ+nUFh5KJ?=
 =?us-ascii?Q?upG0+pjL5iGdYlaJ17KYOhfhItEFDG1WMFWsWQOJi0QVj0OkzimUdfdqoMkO?=
 =?us-ascii?Q?oeqXkWgT9+a2PsIr4+m5BVcd+/pG5BcXoFyssxiE2al/0HegNApQK3WwTpFb?=
 =?us-ascii?Q?VGihhEOM5DZtJHIr69LG0Lu1lqT0Ugz4AMrlIoNr9mFLOm9aJm2kOKJamxcZ?=
 =?us-ascii?Q?1k5AHpsd/gl0tPnxvL6HXoVmzJN91lbF5dmMFg/YkI841JUpW8Gy+rTDyltG?=
 =?us-ascii?Q?dLVNjW2lPH5MyPXXDcILiKB55R1kNQcdM0jJ17mKLywkqrf8D5hjb3zETrKK?=
 =?us-ascii?Q?Kw02mJ9PXHo+Rr2PwT/WJm6rQLSIXQSSxHPRrAyOTlY2E4lgGl3+hcr829Ah?=
 =?us-ascii?Q?RfWNebILW9gURsSLjxe50yx1tqIl6DYlaxlcInDTzRiZHbMEAFFwuAIITyuJ?=
 =?us-ascii?Q?BOLP2N10z+1as4VvZkdVQHGuuKeeAV5t7qbSSNdQ2qNOfeYm0wH8SmzbgTn1?=
 =?us-ascii?Q?/ra8ybLL4Wo4kvIWI+HcJg79z/piq2mAKXQb2Tsahc3Bt7SW+NCkMmpbNnlH?=
 =?us-ascii?Q?fnTAGRWRHyiE1nl2IScrVtBtBaIJfLP/nuJvCULunqIDAn8H4mEd5MnALJ/E?=
 =?us-ascii?Q?c6f6K8+3OxQfMjZKJfXQhcwbgM5mXqm8K665hvz5eEPd8OeCqWZ/bsUhhljL?=
 =?us-ascii?Q?o/0jQrZgpl3OexSzBado+TR0dtUGx7x7JMOKAlgLcIR3Fu9DcHEQLCECCw4p?=
 =?us-ascii?Q?g83pZTgJNJa3uge80nFPJc6k1pTuSmzqop/pNGqIUK4GPYCfLui7hGvFGTRF?=
 =?us-ascii?Q?+DKTOQFKn2+/BXeb7w2leN33Op3G+oDOmYbU17SF1igXT7nsa/EzIcBNaL3b?=
 =?us-ascii?Q?iJ7Qrn9UEeBeXMoOXCBHQvmr8bGyOhTtvvx2fVbt4orKfo8E1jncEQS53v1V?=
 =?us-ascii?Q?3RwPWephhytAM0SekEAOXwTLjOYfWG2CdzEXIcQDgun+HA2ty+G8?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eada5cdc-5d09-4c83-24e1-08def15c793c
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 12:41:00.7585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErH+jTqgKMrDgSxsX0yEm0k+HWOG/9vVvoGkozD910okQPWsIvmiPqH0LG1omyEcdKUCb24h8zzY7c7W30kvJaCxAFJ3oaWApsLcIxT88aDsc1mxcMki7es1KQvyma5M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1267

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
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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

