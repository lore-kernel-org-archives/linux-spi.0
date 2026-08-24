Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACE33E2ADD;
	Mon, 24 Aug 2026 06:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787552111; cv=none; b=JNBLLIHmWs4yhpLZ+SHOpP66hyTk8N5r1Y0bk4JOZqu7C4zSK8m0KBg7lIiWAuHg36i7efZsQOvIjlH+iaPM1vra3c47uscGQ/5DsXucnB4AAzpn4epjVvmaKaUxaA3t0Urn0RMy/mC0yjC2ZxXqwqVl904CNlXEb1NhYqJANFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787552111; c=relaxed/simple;
	bh=FLy/qTiAhZfI9GhBeq9b7ybYoYqfoqJ7jxv71DLMssA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fXqzx68fuwhargp8vBjriHrls4ZXnBsDNEsTesRlAC6vU4nIlPXhRAQSNDIQCbZ53PyGkDnYKl9SrpAoTxJNFdx6829ss/yHLLGBMqdXiQuItVlbBkgxJ+Jm6Bny8UXMn9qxDEmchztvHzFq6lNsBcbATfOfvmUKaT54MG8yRpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ha8qadys; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ha8qadys"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3ABBC2BCFC;
	Mon, 24 Aug 2026 06:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787552110;
	bh=FLy/qTiAhZfI9GhBeq9b7ybYoYqfoqJ7jxv71DLMssA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ha8qadyspFFt1+vg60wdpR2RzJRfnGtLgnVzRSi4nVzTeIDjo2CmzDuMPcu7ySuPU
	 C4e8yUpjRaW1Z21EP/yz5UjXdl6r7SSieOLY3k4rPDMNhdy7Y7nDpNFu4z+mO8IrQd
	 f6Eo5UvIcpA/j7KRdpULAL3MsFYjPREpk2z66xPrluSmqzgntChhGDTcO+A3Gk3lmi
	 Dr473nab85w3GkgAAZXv+93R0MBu6QIXLNVCVcYz3+Z4+4+ZcFpvTFrZVGJ2JDWsFw
	 dYKZ+cMMF2/kx1DAgKJUOW0nvI2VK7sCfdg1JpYyh23QNKcmoaTglZX/bI+dUe1Wgy
	 ft2UAY+4BCLJA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BAAC5DF9D;
	Mon, 24 Aug 2026 06:15:10 +0000 (UTC)
From: Jia Wang via B4 Relay <devnull+wangjia.ultrarisc.com@kernel.org>
Date: Mon, 24 Aug 2026 13:54:16 +0800
Subject: [PATCH 03/12] dt-bindings: riscv: cpus: Add UltraRISC CP100
 compatible
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-ultrarisc-dts-v1-3-61ab7aebe9e5@ultrarisc.com>
References: <20260824-ultrarisc-dts-v1-0-61ab7aebe9e5@ultrarisc.com>
In-Reply-To: <20260824-ultrarisc-dts-v1-0-61ab7aebe9e5@ultrarisc.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, Mark Brown <broonie@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-i2c@vger.kernel.org, netdev@vger.kernel.org, 
 dmaengine@vger.kernel.org, Jia Wang <wangjia@ultrarisc.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787552108; l=751;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=PLH98AWMWhEDDtI7P4MBr8Ej9OKDTOxH4/kye1KfXcs=;
 b=uI8E83sWqzeJyxFJjF1Pxn9pu9ZOR1cxxf/juShwZi19Ep8HUOnUHoh4zL5GQxA//IsERyKUI
 5ouqlO5rBXJBs9s/7mvkSQQFDH828iwCjF1SObjLasgHWv9mbMWyAhT
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-Endpoint-Received: by B4 Relay for wangjia@ultrarisc.com/20260515 with
 auth_id=779
X-Original-From: Jia Wang <wangjia@ultrarisc.com>
Reply-To: wangjia@ultrarisc.com

From: Jia Wang <wangjia@ultrarisc.com>

Document the UltraRISC CP100 CPU compatible.

The CP100 CPU is used in the UltraRISC DP1000 SoC.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 0da219ae6769..85adf72899c9 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -67,6 +67,7 @@ properties:
               - thead,c908
               - thead,c910
               - thead,c920
+              - ultrarisc,cp100
           - const: riscv
       - items:
           - enum:

-- 
2.34.1


