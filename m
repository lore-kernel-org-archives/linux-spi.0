Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01B5426697;
	Tue, 22 Sep 2026 08:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065631; cv=none; b=JHoPRWQnmEiKncUBlDH1WSlOgwzRxFigkMR3JRDShA+TD+uxKquIXU3P1vEU9GHOozGCqaTiads5xiysXPHNCXfFA5OhRFvqSugBqr7CMd8HNVDvI/1dYTRtAiLeR+zxQo0Sci0cG1R1ioNi15x/CpNaoTqUXlyg70tUuy0sE2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065631; c=relaxed/simple;
	bh=Iz2TTiHQPHVNzkvJbhBCIbcy5JEvNsIjgpAyYcSkqXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhCPzpnRyU0K9Sz63uxgJyKlJpGuj/vmxUbWMOf+ExCjRBYeRz9lQi34XCkIl/vOKKZpbRJOyRcI6YRD9rZ9Xa1l+BCMS8sITyogDFnjCLjpVS1s/rYW4kCZRkPRHc6nK4xpwrxgJYzoOJhd/sDK0uc2orwozo72SC3Os1vSFwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CAA1F000FF;
	Tue, 22 Sep 2026 08:27:08 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Thanh Quan <thanh.quan.xn@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] dt-bindings: spi: renesas,sh-msiof: Add support for R-Car X5H
Date: Tue, 22 Sep 2026 10:27:00 +0200
Message-ID: <b8f4648eb1151b75d41e561c6b2adbd9bc4c0782.1790065451.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790065451.git.geert+renesas@glider.be>
References: <cover.1790065451.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thanh Quan <thanh.quan.xn@renesas.com>

Document support for Clock-Synchronized Serial Interfaces with FIFO
(MSIOF) in the Renesas R-Car X5H (R8A78000) SoC, which is the first
member of the R-Car Gen5 family.

On R-Car X5H, MSIOF modules are wired to three DMACs, hence increase the
maximum number of DMA channels to six.

Signed-off-by: Thanh Quan <thanh.quan.xn@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Changes compared to the BSP:
  - Increase maximum number of DMA channels.
---
 .../devicetree/bindings/spi/renesas,sh-msiof.yaml        | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
index e0c7047ae8adb6c3..41e423a42654d05e 100644
--- a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
@@ -54,6 +54,11 @@ properties:
               - renesas,msiof-r8a779h0      # R-Car V4M
           - const: renesas,rcar-gen4-msiof  # generic R-Car Gen4
                                             # compatible device
+      - items:
+          - enum:
+              - renesas,msiof-r8a78000      # R-Car X5H
+          - const: renesas,rcar-gen5-msiof  # generic R-Car Gen5
+                                            # compatible device
       - items:
           - const: renesas,sh-msiof  # deprecated
 
@@ -100,11 +105,11 @@ properties:
 
   dmas:
     minItems: 2
-    maxItems: 4
+    maxItems: 6
 
   dma-names:
     minItems: 2
-    maxItems: 4
+    maxItems: 6
     items:
       enum: [ tx, rx ]
 
-- 
2.43.0

