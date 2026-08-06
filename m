Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021080.outbound.protection.outlook.com [40.93.194.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5B33750AC;
	Thu,  6 Aug 2026 05:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785992789; cv=fail; b=iYuJPrGGjcH19exxxRf3nBqi8w2srItzr0Mr7ytgot2UY09tltbtQLOgkHHIkdkc4qZfaAS3uVAKmcJji+eSWTxarH/5NbEGb576HpYzuXPj3iDChlorQKvuD9ieE7KSUBZk3IMMRMzM4+6JBAiD6iSChOmS0/JI5yNHXS1nGL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785992789; c=relaxed/simple;
	bh=lebJA325MH9Kn3bOkceK9FYiWw17VCgml11W4LbL1io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CyPbdbnbmHY/MrFkgrdZeziYJWsLQizQIBsoCDJmt5rmrOu2wQDkL5VBwCKnr3fj2fh3kogMHpbQjmIyycYifc88XLyYLlyKUQeU3NqNEHzW42w/NGZ05Ots9iKUboP8pACiutR7DhybfCX3EyJoatOtNXX3EpEc0UfOmTpoWhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=t9p5G85n; arc=fail smtp.client-ip=40.93.194.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="t9p5G85n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFuoQPThRA3kMZJXOJQuzTIWafsOmPv0+SzaEYWvzn0HLhf2C2ZGfyOh7i+z9BwKWkkFjTE9GHUSMoTaGO+pnYtqOyPREVXivkeVn38LzydQlouSFIXaYCjlKgSpgJ5QjDCDe+4nP4NmHKELC3karWhqtl9cz9vzk7IhRbRNpbpay1Q9u03EK2D0sJ2Au+gv2iRN6jMSAz192MNpGycT7SyWOHbnF3n+iZZuWk026J4TMwBA6aeH8MZ0ozjn8JY/IbVsGy1yH66ogZ6BTLrLc1Ys70U7JkgjKGbIxHja2AkyS7876o9zua0vlpxA2HZY/5746fHukdgKivb1xPrwPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3VgsfNI++oDeasCzDtlg7fTs6MLXQIseA8c5swZo2g=;
 b=TouXlW4eGD1u7XTt4zOjeieQBI6RZBBr5ZYrFJcB5zs7iucwLeRm3dcZon8kzpKFeIh4rsPJA+dLhBXHvSdWeZGleaQJYL9pUdp1cLiVDntQeosIerFuWWpjnpWIfV9YfbcOBWZYtmURoX4EX1g0kF6gXFDT1SiHVUEPqikhHyVPLH2laaA6y4ucUW/fCEEjP0aCYk4vbxn9pzPNe3rUNeQCjIUIJefUPA/TKPD9yp/I+427CbZHVpf3Nbsn7sfzo09H18b0uTYM0USfo2XUlyx8FAk5ZiwFdzNR2lzlgQzxz+ytQ8dkEThpAcR+ivd5sZAyQqCMIichr3x3iYQPqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3VgsfNI++oDeasCzDtlg7fTs6MLXQIseA8c5swZo2g=;
 b=t9p5G85nwEZD2Qf4GahBG59WJSTkxpF/cFJaXs8/9w6Yx5mXBuVYe1hiRBgX64yygglzxuAIp7Zr7nAcVAPyIU4/LOv35FSt/KhciSd1ut/L1qtN/Uip3UHonHptK9uOmSTm9yVRrRhiimkmaG9J9R6eg/Grl7vIWTIWdFlkYTZApzt8iO7WIfdPmyGRrzyvVh0G1tPfVd1L1hRrvJmraKud0d7vr7Av8FaCghrVkS7l53cXvEfZO96IAt4pH2zpoxIpbnZtIBk5k0Q65/FVi52F12170teTEZbgjrmM8WDZSDrSwwq1LzkgV/E6K7E2kgmC/96cr0QOSU+vn7qlIw==
Received: from PH8PR07CA0002.namprd07.prod.outlook.com (2603:10b6:510:2cd::9)
 by BY1PR18MB5949.namprd18.prod.outlook.com (2603:10b6:a03:4b8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 05:06:23 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:510:2cd:cafe::3d) by PH8PR07CA0002.outlook.office365.com
 (2603:10b6:510:2cd::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.19 via Frontend Transport; Thu, 6
 Aug 2026 05:06:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.6
 via Frontend Transport; Thu, 6 Aug 2026 05:06:23 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTPS id D7D074157BE1;
	Wed,  5 Aug 2026 22:06:22 -0700 (PDT)
From: Swark Yang <syang@axiado.com>
Date: Wed, 05 Aug 2026 22:06:22 -0700
Subject: [PATCH v4] spi: dt-bindings: snps,dw-apb-ssi: Document Axiado
 AX3005
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-upstrea-ax3005-spi-v4-v4-1-5b8bc11cb841@axiado.com>
X-B4-Tracking: v=1; b=H4sIAE0WdGoC/x3MTQ5AQAxA4atI15qU+QmuIhYTim6YTBGJuLuJ5
 bd47wHlJKzQFQ8kvkRl3zJsWcC4hm1hlCkbaqo9NeTwjHokDhhuQ5kaBS+LZq4CGR69bR3kNia
 e5f6//fC+H5GAa9dnAAAA
X-Change-ID: 20260805-upstrea-ax3005-spi-v4-3f1a03ec6495
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Swark Yang <syang@axiado.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2683; i=syang@axiado.com;
 h=from:subject:message-id; bh=lebJA325MH9Kn3bOkceK9FYiWw17VCgml11W4LbL1io=;
 b=owGbwMvMwCHWlWK8+EozbyzjabUkhqwSMT/THKcpX8MzdsYVa2yceW1NdcD0+O4XlxfZ2bA8L
 Qn5t8igo5SFQYyDQVZMkeWrzrf8k7na9zr3riyFmcPKBDKEgYtTACby3JyRYVqGpACvpVyCznvp
 mOTEDs5ahx3Tcur7srkmia5isZ37huF/RI7sE+4Pk33O7eGVan4wydb+utMTG51mC9HJu2ZYa0o
 yAAA=
X-Developer-Key: i=syang@axiado.com; a=openpgp;
 fpr=F52CF66FC96D2BDE89BDA9758A6433A3D4830D5D
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|BY1PR18MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b439451-3bf1-4c86-871d-08def378760a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|18002099003|56012099006|3023799007|13003099007|10067099003;
X-Microsoft-Antispam-Message-Info:
	78G9NOY6RY7Esu8U3LKVmU19xjfmBeh5i9vT9OazqKm4FAhPy9AnZ/KKs2kbMj5tQ7ikP1K6fWK+j+xsFnmO2IIYGQgRLFczody9+J4Zsono/o/+IG2PhoGjbftgQW61fqNzgpfQVIxrnTfDJio5dHEdnCqwJTNdNPLT5IAp7QVR2OGkCk5ffuRLMGCYdf3MZMkP8l91JsEp7QPUSzc55clPa6jaC4/B52WR5hmeGdnkV9YdaYBV1OBQVsQ4+2L0h58QJKDBVMiZhtGeFdbqobJCPsx+Pl+DJ8fkoWtj+7wYSjNyHXcpLgFySPQTmkO9WEmoTwOeEpuCNnGeRdgCCsrdHUhv6igZckU/xLno3Tz51ZNGyBUogDZG0BrlKHhXXXdFUEUBD+QKLhQO3QF7O4BjawJVPjhiUk8j7v2Zs/CJCxBo+Wb3RxHiEHod+KMpYImghEJ84RP8k18yiMFcA2KNJn3GxHQgmGPsri3IKE1lSa7hkbdPq2wa+eDKdWOT9WV6jOEBPbFQMJ/OYVmM+rAjL3cuy0qu+MhoVUVb3KaZ8GAvWxv7TZRZhFjovFp9g1uHg+KXqeJFqHEA0PmLUpVkMGi8Q9oQeNeXu5teBnqHAcknKXWTJ+MHt54FPj4YtOAq75kAtnfh9VEAi5L4nBB7m+/fzzdNDQZN39lDT/IsrnY50ZZwX8Mgyr9OD3CEYW3AZdJObSH1z3yjALEkQg==
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(18002099003)(56012099006)(3023799007)(13003099007)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zgpZBzkIa5HF8ytlJzAw3e2CmSvU5MRUCEgd6jTaRl91KOVIqSPANbQRL/KkboCOOu7BYClaU9QiXkz9X/A6rTII/Q1mpEi4PY/9y5QzfTOM/NRyaR+kPbKPtNCW9MVCFngpmLmHkbK0MMLD3Pk8fJmooywq+8Xw6JnCoCQOQZLA3MrrSa5wb44Vki5Ga9egmr4u5MgvQaik0fVI3fB018gLBZnOJ84AERhtlu6Ajn+Y8iCdiYuws+i2W2fVpy0stRHCiQqgZrVhe3Wrn63fnZsfR12cr9W2olJaF4u8dPWzKFncu5heGLc+GvCLK8gL++NnvqKH8nL+0/akLmZIJWwGj7Hyocf1qMAAq0JtvGb6RhkyUUP02ygvUhbNZMKt3UriwggJoViDpcm2Dqq3JLPjrpq+g22QrsnIWqyMYyGT3OXSwEH7Yuoq8ZMw+hrZ
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 05:06:23.3951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b439451-3bf1-4c86-871d-08def378760a
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB5949

The Axiado AX3005 SPI controller is software-compatible with the
Synopsys DesignWare APB SSI 1.01a programming interface.

Document the "axiado,ax3005-spi" SoC-specific compatible with
"snps,dwc-ssi-1.01a" as its fallback. This preserves identification of
the AX3005 integration while allowing the controller to use the
existing DesignWare APB SSI support.

Signed-off-by: Swark Yang <syang@axiado.com>
---
This SPI binding was previously submitted as patch 6/8 of the AX3005
v3 multi-subsystem series.

Following maintainer feedback, the binding updates are now submitted
separately to their respective subsystem maintainers, as there are no
cross-subsystem dependencies requiring them to be submitted together.

This submission contains only the AX3005 SPI binding. The corresponding
SPI controller nodes remain in the separate AX3005 arm64 Devicetree
series.

Changes in v4:

- Submit the SPI binding separately from the previous multi-subsystem
  AX3005 series.
- Expand the commit message to explain compatibility with the Synopsys
  DesignWare APB SSI 1.01a programming interface.
- Replace the AX3005-specific schema entry with a generic group for
  vendor controllers compatible with v1.01a.
- Place the new group after the vendor-controller group using
  "snps,dw-apb-ssi" as its fallback.
- Use an enum for the vendor-specific compatible so that the group can
  be extended with additional controllers.

Previously submitted as:

[PATCH v3 6/8] dt-bindings: spi: dw-apb-ssi:
add Axiado AX3005 SPI variant

https://lore.kernel.org/all/20260716-upstream-axiado-ax3005-upstream-v3-6-c429095143ec@axiado.com/
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index 95a5bd894e93..7f698195cc43 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -53,6 +53,11 @@ properties:
               - sophgo,sg2042-spi
               - thead,th1520-spi
           - const: snps,dw-apb-ssi
+      - description: Vendor controllers compatible with v1.01a
+        items:
+          - enum:
+              - axiado,ax3005-spi
+          - const: snps,dwc-ssi-1.01a
       - description: Vendor controllers which use snps,dwc-ssi-2.00a as fallback
         items:
           - enum:

---
base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
change-id: 20260805-upstrea-ax3005-spi-v4-3f1a03ec6495

Best regards,
-- 
Swark Yang <syang@axiado.com>

