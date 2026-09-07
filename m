Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5646455634;
	Mon,  7 Sep 2026 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775106; cv=none; b=EUiD5fCpy1sU4IUiwvGXZ2XG7iXLbs1mBtBKf8Ymc5480vrEScpw9VViQO+bC4bFfSQ+SWUyCovRJzGD4uVz5/RxPP/JJJmZmf0ZV7i+8ghA9fFDyQNWoSBLK+aePPWqgf2uRU0QBGCSavH7JPM7TvJzjVjxnRjpkbNBjHqaYQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775106; c=relaxed/simple;
	bh=AkxTZASk2YMZM60To9GH5xBpg+U1tdOQBOOVag6AfDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ke68RMADbaAvvo8JQuxekbUr8v55AThcrBYHBytOKE4H8BkhuYiE0+kf4HF8tHccodTnZYTWL0y1W1kPP6REmVcqdL7hxX4a6Gvi1YBZ/B8fJF406wuFu4a3J44O/dzw5xvSEDXF8yqhfS7vsWrOo0dDqvHwSjK8qtHUlZqIEMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e21NceUN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e21NceUN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C2C8C4AF60;
	Mon,  7 Sep 2026 09:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788775106;
	bh=AkxTZASk2YMZM60To9GH5xBpg+U1tdOQBOOVag6AfDE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=e21NceUNmwRLetw3dh/flq+cEmnxcyk6lJBYKsudHJ635mDUkgBVnHPxCpFSpmvas
	 IHATzzsXV8pWLVjd/2iBQAsJMZPPwXjIeija63NlFGMhVsumdx3BQHR//Cwn3SCAOU
	 NRBDkNXsa4buCK204fpKJs3x32WspePnUIRT66p77t+YWVutxTpS8hVMGGRZM3RNDi
	 XC1bHFrzXvQ0AMHXuGfIb1KSLyKzC2iSI5dP9a01d7nqOaRg/6eLBd5SjsFkc7u3uI
	 MyV4ePj3+SqLuG9L64P0+va/ye1R4vRqzywO4/2C8Ip29fIn2vUZNQChbquNWVhaVq
	 Js1kTkQm7OIFw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279D8C79F9E;
	Mon,  7 Sep 2026 09:58:26 +0000 (UTC)
From: Jia Wang via B4 Relay <devnull+wangjia.ultrarisc.com@kernel.org>
Date: Mon, 07 Sep 2026 17:54:45 +0800
Subject: [PATCH v2 06/10] dt-bindings: i2c: dw: Add compatible for
 UltraRISC DP1000 SoC
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-ultrarisc-dts-v2-6-5eb4c97477c5@ultrarisc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788775103; l=1475;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=qmmOpiZIekiFaSTyRs9mX7I+f5uExLbikMi5zvQgBR0=;
 b=MwErmEoUN1yX+JIVBc+ba5Q2dXErRpQto0sss5j0hElQVOqMJXvvTtPalWZh+m4BTBf8Jq3Wl
 ENt8lFxCQsdB9c679906QjzeLeprXsiAtbyMOtMiuyYTnY914Vc6KyM
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-Endpoint-Received: by B4 Relay for wangjia@ultrarisc.com/20260515 with
 auth_id=779
X-Original-From: Jia Wang <wangjia@ultrarisc.com>
Reply-To: wangjia@ultrarisc.com

From: Jia Wang <wangjia@ultrarisc.com>

The DP1000 integrates four DesignWare APB I2C controllers. I2C1 supports
SMBus, while I2C0, I2C2, and I2C3 support standard I2C transfers. Each
controller has one register range and uses separate reference and APB
interface clocks.

Add the DP1000-specific compatible string with the generic one as a
fallback.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
 .../devicetree/bindings/i2c/snps,designware-i2c.yaml      | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
index 467bdcbb8538..8a7c0a44601b 100644
--- a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
@@ -21,6 +21,20 @@ allOf:
       properties:
         reg:
           maxItems: 1
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ultrarisc,dp1000-i2c
+    then:
+      properties:
+        clocks:
+          minItems: 2
+        clock-names:
+          minItems: 2
+      required:
+        - clocks
+        - clock-names
 
 properties:
   compatible:
@@ -44,6 +58,7 @@ properties:
               - mscc,ocelot-i2c
               - sophgo,sg2044-i2c
               - thead,th1520-i2c
+              - ultrarisc,dp1000-i2c
           - const: snps,designware-i2c
 
   reg:

-- 
2.34.1


