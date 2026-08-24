Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CA53E51E8;
	Mon, 24 Aug 2026 06:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787552111; cv=none; b=ezOxUTpynmi8rkS2A18aRZxwZw4DiPDw39476REUsVlU4b8dEMrLBdCbnrOyF0KtSBBBD1M9laW6njAUZQ3aKsGgAkwitODsvgWiwl08wdVBgMnNYwQTqPa0T9rwQmm+sLmUv9jNji6880HDD0UesAn3Tlss8rUtzpIgTKGxrbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787552111; c=relaxed/simple;
	bh=glx3nAmbQsN4q0EfNDaMpBD7eq+Eks/X4dswA2kjFcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gMJuDgIWiSFoc1ApdIIxy6New3FMjoUTlFex1hgxVwccdezWdKhdu7Odat3J9L1DVDVnEUdOYrVvfwSJ8/eKCWDrs15MrytQt6voGFAzhX9a7TPbyYUW/lYOy1eUFZOxmE4HxKBOILpgkL27NPNzAt6e89Qj246G5NdkO7Lif+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smJDFDlk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smJDFDlk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EF83C2BD01;
	Mon, 24 Aug 2026 06:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787552111;
	bh=glx3nAmbQsN4q0EfNDaMpBD7eq+Eks/X4dswA2kjFcI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=smJDFDlkT5CwXJaB8aNbBCFmQF+KwsGC0uuRp1x9fCO0kBwPOQxUuWwBVbs04DnVL
	 4jB0IwZtJeJXuVi5UlveQaeJEWdrdJSzzpyLBeUv64f/Gnh/CayMUHzn4IUOORRBZ1
	 iEa/c/VopCtQifrvE9MkVVD1cAUmSd+PlWeJDSq927FxgtISj2KZP4qfzV+iiyx7+X
	 cf4ycSrr6lkLCXDiEjrL5POItKy+WY9utVAHaZ76I46zDWlio12BzS4ZN5DniA2Sp/
	 I7xLyjnx6C5GQmHhJ+q3MKfjnYRfPlNItfHMs4ixjISK1kbs+WRK/8qAttjWoX55WQ
	 zUvb0vI4LvROg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F70C61CE3;
	Mon, 24 Aug 2026 06:15:11 +0000 (UTC)
From: Jia Wang via B4 Relay <devnull+wangjia.ultrarisc.com@kernel.org>
Date: Mon, 24 Aug 2026 13:54:22 +0800
Subject: [PATCH 09/12] dt-bindings: dma: snps,dw-axi-dmac: Add UltraRISC
 DP1000 compatible
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-ultrarisc-dts-v1-9-61ab7aebe9e5@ultrarisc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787552108; l=814;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=4oeosRybkf+LUPam0Zh10Y726VZVVrxIb0o2ktnXvVs=;
 b=iwmXkiAPofSWAQ8A6OfDyPPy4yH7CvSvnz8uh+yNSBkdjiYoWnColYiK4XDpdjwCiOLNCQE0A
 EMJAq0q34gzBA9J+575SzH6hk+Wav9pzky7BoH0xmlsDziH62BJAo4U
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
 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index 0a30a455b0ee..f7b5891f41ae 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -27,6 +27,7 @@ properties:
           - enum:
               - altr,agilex5-axi-dma
               - sophgo,cv1800b-axi-dma
+              - ultrarisc,dp1000-axi-dma
           - const: snps,axi-dma-1.01a
 
   reg:

-- 
2.34.1


