Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD923E44E0;
	Mon, 24 Aug 2026 06:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787552111; cv=none; b=DZk4tf8eVWBXbHzLj4/4EYUdv3+glC7p9Gc9gQbseD9k/H4Tpf/DaejY8lOFYTzfdcx8alCpu364a9/dvNNrjqMEf0yanLG1Csbcq6XIEsp6/0JivSokrvpZpYR/PxStdchnlbqgnsRHs4xbOfQ4EUVTMbnEo+rBSh+oZRlKWLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787552111; c=relaxed/simple;
	bh=vzXhbUIp+JOMycGMc4kVLei7V7dGDSYy+8Y0EmXaucA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ojaxtfCzdKEX2jI4a09a6gW5E1shsXuJ+H9ws40pM8R4GlIUtK0RqlbVCCv03ilNVDRudEw/VuPix9FtWSVcCH/D5nYguLeIQuq46Bnh5bDDT0VArSAhMstZy2ZspqJGNvFIOwkcXNOJVqHa3FXp9wFkKtDVS7nnSXo+6H94kQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzgMO42y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzgMO42y"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B301C4AF14;
	Mon, 24 Aug 2026 06:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787552111;
	bh=vzXhbUIp+JOMycGMc4kVLei7V7dGDSYy+8Y0EmXaucA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VzgMO42y/WEARNIYwXLi/mGUjhnNRHe/Ok7ZCRLItOF7chlD+jJW4nV/fEgxTYWCR
	 G6FvG9opLs4YfeY6T0OSRq3fkt/DrVKVeXpCatWtgMyeVFbBqDUx4Au2fjcBMeQA3e
	 6GzQ88bN1SfJrhhMsfnbc15MgaZxjnSDzB1TQbmDANXoCt1S+N4F+jJ8dCjZd7NAAZ
	 Rqh/TMKts3EuFD8LGvj8AKkag/9d4lrXRKGvZmJY5EfLHcTAbzcYF8WX+UShQ/mZHa
	 ux8gGszN47WJbu5MwtEMtrNrOSTjFREBGrPyjahzjgYEOmTsGdBkEJehNULINeL2bN
	 WAOq7jLObhuiA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13331C61CE2;
	Mon, 24 Aug 2026 06:15:11 +0000 (UTC)
From: Jia Wang via B4 Relay <devnull+wangjia.ultrarisc.com@kernel.org>
Date: Mon, 24 Aug 2026 13:54:21 +0800
Subject: [PATCH 08/12] dt-bindings: net: snps,dwmac: Add compatible for
 UltraRISC DP1000 SoC
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-ultrarisc-dts-v1-8-61ab7aebe9e5@ultrarisc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787552108; l=758;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=Q86cegl7t++dgBjUp6+7AoXi25GaD65bic8Z035YVIs=;
 b=THSNUqlenSAS4ni5Ye5ZxATHH6223T6W6rMJuIwRemA6bVK0aCCZw65tmt2JfJ7gqhcxyhPXc
 BoxQ78OqCvfDOw7MaXpXr1bvXQ5EGOge2Uq711Jg8TmOkQq0o+TyzPP
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-Endpoint-Received: by B4 Relay for wangjia@ultrarisc.com/20260515 with
 auth_id=779
X-Original-From: Jia Wang <wangjia@ultrarisc.com>
Reply-To: wangjia@ultrarisc.com

From: Jia Wang <wangjia@ultrarisc.com>

Add the SoC-specific compatible string for the UltraRISC DP1000 GMAC
controller to the DesignWare MAC binding.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 2449311c6d28..2ed4564ae99d 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -119,6 +119,7 @@ properties:
         - starfive,jh7110-dwmac
         - tesla,fsd-ethqos
         - thead,th1520-gmac
+        - ultrarisc,dp1000-gmac
 
   reg:
     minItems: 1

-- 
2.34.1


