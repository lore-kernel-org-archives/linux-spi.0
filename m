Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE724342C80;
	Mon, 24 Aug 2026 06:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787552111; cv=none; b=hBfaTIDis1I2p6hxAUR5J/Gl+sUTdEhz0hFdlZJZInq0A7crWbjnKrtN6VvSy8rgtr7hLtr0oHImrqC9kPzUn1t6GXwgBAFBVU/0/F9Me2b6gC81q+tJ/jDK9Q5Y3dkVZOyLm/ujmhx3GwpLWlMBEuoJshZvp7k9R7GQvQqVwgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787552111; c=relaxed/simple;
	bh=xoVFtZfwFUn8ctUKrgx5JLL2pQj2N3ofLqH+aau927U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b0D/F1Xrp23gdgK6KE14lL5JZbRhF4aEjsjkYskmuTAfhkhu7aR2YZ88MSSxZBhZ7eZf2jxM8OAe10GsC5N5Soh8b9+73f4MnFgwnShg8Z5Rgp4JL/mEDOO1BJA1/p/M5GmaIXbHBiTXUjvNaBfe2bigc0d7bZAQIJSHjG3EH9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USbvkkCB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USbvkkCB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 825D3C19425;
	Mon, 24 Aug 2026 06:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787552110;
	bh=xoVFtZfwFUn8ctUKrgx5JLL2pQj2N3ofLqH+aau927U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=USbvkkCBJQiP6h9hCXLE24Hm0lzbj/M90JFx4RYxJ+oRhBsAinbYtALBuLtytfCqR
	 6pDIVJd3ETdyND+bOdgNsLfWPEd4nMErxBFTrFKZpRqSCIsOUUxbyJ4ONiKk/Go5qw
	 9bRlADfd+Mi9eGTyng7aHvRUwJaT1rcYXXYv2I0iUzbQzcI75X76+yP+yrfX0kuFNp
	 ElFvZNIxksDjxWsUERNR5AjRMggUNIQFZ5BFFXmJdDfDhddUzFvMVZcyptxMgz0eut
	 wUxITfLuE2SsaQbezaRWwSofYaHihEWmmmPuw+hBba++UKzCbB8HKVO/OPpDIi3686
	 2QPkX/KR1vMig==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDF2C5DF8C;
	Mon, 24 Aug 2026 06:15:10 +0000 (UTC)
From: Jia Wang via B4 Relay <devnull+wangjia.ultrarisc.com@kernel.org>
Date: Mon, 24 Aug 2026 13:54:14 +0800
Subject: [PATCH 01/12] dt-bindings: riscv: cpus: Fix yamllint style issues
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-ultrarisc-dts-v1-1-61ab7aebe9e5@ultrarisc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787552108; l=1425;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=Q697DFC7ysJh9zCppPk9O+0gvj0yAIUmzUczo/IHMyc=;
 b=or1xxNfTcnovPzCMzApsOwWbacOhxI/q+gccq7qhyvzRWq2X2lx0MS3b8g6Wxi5KIU0117ZLQ
 IUn00ulNlwjCPLJm5EosC9d3iWABnhGYcGZ3B6wMnXld66Os6azzRvh
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-Endpoint-Received: by B4 Relay for wangjia@ultrarisc.com/20260515 with
 auth_id=779
X-Original-From: Jia Wang <wangjia@ultrarisc.com>
Reply-To: wangjia@ultrarisc.com

From: Jia Wang <wangjia@ultrarisc.com>

Wrap an overlong description line and normalize the inline dependency
lists to satisfy yamllint.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 5feeb2203050..0da219ae6769 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -117,8 +117,8 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       VLEN/8, the vector register length in bytes. This property is required on
-      thead systems where the vector register length is not identical on all harts, or
-      the vlenb CSR is not available.
+      thead systems where the vector register length is not identical on all
+      harts, or the vlenb CSR is not available.
 
   # RISC-V has multiple properties for cache op block sizes as the sizes
   # differ between individual CBO extensions
@@ -151,8 +151,8 @@ anyOf:
       - riscv,isa-base
 
 dependencies:
-  riscv,isa-base: [ "riscv,isa-extensions" ]
-  riscv,isa-extensions: [ "riscv,isa-base" ]
+  riscv,isa-base: ["riscv,isa-extensions"]
+  riscv,isa-extensions: ["riscv,isa-base"]
 
 required:
   - interrupt-controller

-- 
2.34.1


