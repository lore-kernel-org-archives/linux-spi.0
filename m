Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B4F455176;
	Mon,  7 Sep 2026 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775106; cv=none; b=GC2XLcvKM+KIAaah38+JQUBnmjiNOdO8VdGUuojDP45lImmWM1q/Mlrp+VCQmKLRQVe390e29e5qTajp5Yyw8i7O6AI2gQDU/mLB+9zhe0DNYbPLtc2ny3a4aMqITewu0jnj5H6eevHQjuc5A+sO1uFTVlbbRP9237VUplgjgUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775106; c=relaxed/simple;
	bh=osJ1peGPbLMwCs9cQfspS5sCiI02TKIU/UTXsG1stLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GmlQ8JQY964Jz0oyOBfwtRi/Hdf3iJiFcuvne4lJV43JBVqU8CyV2D6GpmkL74IRM6Zl82EwPR43MEFsQThI1ttbJzU9Dp95CvwNVWj0guF87y7GWFs3ObhZHQcSiAYxnBddqf4aQ/djDWbQQIE8CUwxLfGNVXY3rP/OiV19Hgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBv5EzfR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBv5EzfR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B371C2BD05;
	Mon,  7 Sep 2026 09:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788775106;
	bh=osJ1peGPbLMwCs9cQfspS5sCiI02TKIU/UTXsG1stLI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IBv5EzfRtJ2tPJE+q6J/2aqN18z3MvgJJonLv09RekmAYzXwLVsMrQ44QWKwWfyE7
	 fJNmBFwGG9fdasbThw0Bwlj+Y7Hl0uY9M047IGR5mozh02SqyqFwz+4o44s09ljgdq
	 U3PUszsV6ltO65Z4Pt/N2fmp9FsBBjMGaeIYvvRpvkboSzv83rZi6MJFBbJI5Tt4NR
	 nLMXZsVAJPGULlAO2UUcYZYZUggRoKQiBlsBSJAIxhKyGBIb/3VfN50zUZxoCeunCf
	 cqAhSLTNzTBv30xKtNORW3i/pJ+C6eCvsNIeToOzV6oMmoH0YHKZnXKaswziUH8GEh
	 Snwt0FNII1x4Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03ECDC79FA7;
	Mon,  7 Sep 2026 09:58:26 +0000 (UTC)
From: Jia Wang via B4 Relay <devnull+wangjia.ultrarisc.com@kernel.org>
Date: Mon, 07 Sep 2026 17:54:43 +0800
Subject: [PATCH v2 04/10] dt-bindings: timer: Add UltraRISC DP1000 CLINT
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-ultrarisc-dts-v2-4-5eb4c97477c5@ultrarisc.com>
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
 linux-i2c@vger.kernel.org, dmaengine@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788775103; l=964;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=H5nCeqGhgsZIHGD5OQKUEdhmWR2MLVPLwQY1q4JBFrk=;
 b=qZtQO6xJbyoxFeLqeiG+vgTPNhUyPEuYbIwJnEzAzbJcXnokLi+XQS2BFd26iySduD/N/wyv/
 yYBn2YXqHC6Br7I/x7XTpSZr6fcB0ViDdeu7/ewOh278fFgD6mTrBWB
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-Endpoint-Received: by B4 Relay for wangjia@ultrarisc.com/20260515 with
 auth_id=779
X-Original-From: Jia Wang <wangjia@ultrarisc.com>
Reply-To: wangjia@ultrarisc.com

From: Jia Wang <wangjia@ultrarisc.com>

Add compatible string for UltraRISC DP1000 CLINT.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index 3673836e14de..878f267d089b 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -40,6 +40,7 @@ properties:
               - starfive,jh8100-clint   # StarFive JH8100
               - starfive,jhb100-clint   # StarFive JHB100
               - tenstorrent,blackhole-clint # Tenstorrent Blackhole
+              - ultrarisc,dp1000-clint  # UltraRISC DP1000
           - const: sifive,clint0        # SiFive CLINT v0 IP block
       - items:
           - {}

-- 
2.34.1


