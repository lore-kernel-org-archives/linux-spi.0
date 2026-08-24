Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6927D3E44F0;
	Mon, 24 Aug 2026 06:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787552111; cv=none; b=qX12SwYsgd5JIHA/4KFNYdruNCghN3zHP1VkqJvoUMnMdboqLFtDZt8DdD2qnhorpjDoJy1iTwxfau+CtXj2CZ3RTCc1Y5DXQeoPRnf1cbIugiXd9n9KvgrS39ZQh9ZZdSoRYqHLOofEWDba0RV3l7zs7qNLa73kFVcFvZtwuI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787552111; c=relaxed/simple;
	bh=5o3UdQ7NCWjfB/6BDLBC4HF2grF/7kX8adeAbxwnDkc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lTmLERG9FJoclzNtiMxgqWsnDQRQ9D9zy1WBcwDC9+XGC4xUU8CQXbH5iOB9m0U3EUE7Lv+JpOwk9SH/6yZo5MQcI9+c/xZWi571lQ+X+WLCXQZ7WyTVWE7nggY9KOWYZEN9w4uvAe2ZwfZo/HoIX5WXPQppUnwA/9tbx8FOL6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZ7pWI8m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZ7pWI8m"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01488C2BCFD;
	Mon, 24 Aug 2026 06:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787552111;
	bh=5o3UdQ7NCWjfB/6BDLBC4HF2grF/7kX8adeAbxwnDkc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uZ7pWI8mLyk1JaJKanZk/INrlBvWP5BP4K0bLjq8VlbbezoLNX4UaCPGQv+5BRsjl
	 Ze8dCT2/ftnpDqGMsvmiLKFYC8kbFIsPORQAB0xItlYIYJoqLfJ9PKsu7L3vNDqEzX
	 92Yen/64FrzhFwn4nQoTi6mRsOpsNfnf/6IzJWpyPHuX6WLQp2Pn+VNpAIWtaFVwZ9
	 LKq6MRMFExZWlTwxQv6GAl8pDX3lHfWRMq6whsVdpfCy6HYX1ohDvQHVF8gutxnOzJ
	 rH9mvxr0lMn+SD728oWVEU8HiE8X3pc75MkP13lA/Q9Coi2eRt3gt0qqiKjFsafYPH
	 MSHHIkvRlRS0A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE768C5DF81;
	Mon, 24 Aug 2026 06:15:10 +0000 (UTC)
From: Jia Wang via B4 Relay <devnull+wangjia.ultrarisc.com@kernel.org>
Date: Mon, 24 Aug 2026 13:54:19 +0800
Subject: [PATCH 06/12] spi: dt-bindings: snps,dw-apb-ssi: Add compatible
 for UltraRISC DP1000 SoC
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-ultrarisc-dts-v1-6-61ab7aebe9e5@ultrarisc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787552108; l=893;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=GOAvwSU+bClZtaYEoEYBIUWP7wk56GD6+csu9urD+2Q=;
 b=KOhSwVprVsR8XwUee2hGHuJ8P2eGS+xmvgFGjizmPpdfUWjvSB0byKgVtUM4XmMAaS+/De/RC
 sH207vJ1wA5DiQzv7OOIexIT25aDwh0wp7thQjFVDbySqHWWN9WSrTI
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-Endpoint-Received: by B4 Relay for wangjia@ultrarisc.com/20260515 with
 auth_id=779
X-Original-From: Jia Wang <wangjia@ultrarisc.com>
Reply-To: wangjia@ultrarisc.com

From: Jia Wang <wangjia@ultrarisc.com>

Add the SoC-specific compatible string and use the generic one as fallback
for the UltraRISC DP1000 SPI controller.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index 1e70c6804d5d..896205329d7e 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -63,6 +63,7 @@ properties:
               - mscc,jaguar2-spi
               - sophgo,sg2042-spi
               - thead,th1520-spi
+              - ultrarisc,dp1000-spi
           - const: snps,dw-apb-ssi
       - description: Vendor controllers compatible with v1.01a
         items:

-- 
2.34.1


