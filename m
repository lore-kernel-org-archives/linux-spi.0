Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83BC456E10;
	Mon,  7 Sep 2026 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775106; cv=none; b=bO10kda96vxwn2PyWKnRzt11p67bbKpzLTcmZhASotFRMlENKRCQ+TVvmWC2Re0Jy/Z0YMfUB/DIwlF1y91A0GzatUDtaQFloHBPKydhbHsofiRHVxQ5gmxuIlNpFZQ31NCBrCZqg76VMFQfSS9sw79LhaC+gGTXRinRh8weekg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775106; c=relaxed/simple;
	bh=jbMzoob+yfp28o1fkQLtsSQu9lgIRg09JA0lafc+WTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PICy1ak3RCCijUyqcKKB3RqCUdJY/jovKgPww+cElgjWzP59jcEdU9MREo5NaZOLsnOtn34W3uANoB/RD0Pgr/erqR7HJWf7HnAZb1gzR8hdYRsbJBGpYyF7JVMfHSkCRN8OwHc/phwoiKyRFFyD9TVvMfBj2loGqYSogxFk/Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyiovwlB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyiovwlB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D60AC4AF11;
	Mon,  7 Sep 2026 09:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788775106;
	bh=jbMzoob+yfp28o1fkQLtsSQu9lgIRg09JA0lafc+WTI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iyiovwlBBuEOAq4Xon/s5M71gn3gz/X0/Q0muVMM7NDmpzqsDt+MEASEgykjuXV16
	 jkoUUZ4WC07E1GAF+5UDLZQEiX0OOTqu8TyOYXnsgO4sxaYeGqrTZ7ioOe7sPbB5ul
	 fPxpBgJwGRw1YwrB6fdQB7ZgBISYWLnrwawdAlXDHLuCkV6bDWmYScWPs24qDqtf3V
	 OTidh+RJnBG5uTKxiJLF3Gkv1rZe7V7sdluVeJbgaRAwMF62cxu1Kkk9yu97QPr+hC
	 O1mHb8hg+fskHqBWz7BGzBror3FPaSTiGUNB2WypiiR9HgaSlZGhww95IgTQ+Itpdo
	 NdymIhLtWNgOg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3DAC79FA0;
	Mon,  7 Sep 2026 09:58:26 +0000 (UTC)
From: Jia Wang via B4 Relay <devnull+wangjia.ultrarisc.com@kernel.org>
Date: Mon, 07 Sep 2026 17:54:46 +0800
Subject: [PATCH v2 07/10] dt-bindings: dma: snps,dw-axi-dmac: Add UltraRISC
 DP1000 compatible
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-ultrarisc-dts-v2-7-5eb4c97477c5@ultrarisc.com>
References: <20260907-ultrarisc-dts-v2-0-5eb4c97477c5@ultrarisc.com>
In-Reply-To: <20260907-ultrarisc-dts-v2-0-5eb4c97477c5@ultrarisc.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Jia Wang <wangjia@ultrarisc.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, Mark Brown <broonie@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-i2c@vger.kernel.org, dmaengine@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788775103; l=1419;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=ENFwCaDg2Es24T1JPD8nJSb6K6VohaYxMboKPZolvgI=;
 b=MyRA9jGZrwxWJ4/f/ssvZI6lzGtLrFdRbrj04uuCN0+jhnwxhnZs36ZCQyo03NHkrgeKwTgY7
 meq5UYXIU1ZARPkIWze/XzKIuDOOQniuZ47xHauQ0/IYsaJTuP473O7
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-Endpoint-Received: by B4 Relay for wangjia@ultrarisc.com/20260515 with
 auth_id=779
X-Original-From: Jia Wang <wangjia@ultrarisc.com>
Reply-To: wangjia@ultrarisc.com

From: Jia Wang <wangjia@ultrarisc.com>

The DP1000 integrates a DMA controller.

Add its SoC-specific compatible with the generic fallback.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
 .../devicetree/bindings/dma/snps,dw-axi-dmac.yaml  | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index 0a30a455b0ee..bfd6d67a98e6 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -14,6 +14,27 @@ description:
 
 allOf:
   - $ref: dma-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ultrarisc,dp1000-axi-dma
+    then:
+      properties:
+        reg:
+          maxItems: 1
+        interrupts:
+          minItems: 8
+        dma-channels:
+          const: 8
+        snps,dma-masters:
+          const: 1
+        snps,data-width:
+          const: 4
+        snps,priority:
+          minItems: 8
+        snps,block-size:
+          minItems: 8
 
 properties:
   compatible:
@@ -27,6 +48,7 @@ properties:
           - enum:
               - altr,agilex5-axi-dma
               - sophgo,cv1800b-axi-dma
+              - ultrarisc,dp1000-axi-dma
           - const: snps,axi-dma-1.01a
 
   reg:

-- 
2.34.1


