Received: from mail.zlab.su (mail.zlab.su [109.73.193.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF683D902E;
	Mon, 10 Aug 2026 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.193.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786364182; cv=none; b=CIXbevNI/nrGllyPA9HsZV9tkQK1zb1f8YocZBhTRVFrtHhE1NqF863GHFrue7gQYpY/H8ZxmmzaXVqqNCjQ6FED8CuwrprUERFXbzLHBKkIRnTl5lnCInJUg9HMjPyQWQTC7i9wl5FGIh8bjB6dzUxiWIn3uyPMp+TUfrOI/eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786364182; c=relaxed/simple;
	bh=JjxwpskZzfY+fNYf5+RTD7bFPDdPRRtJ9X84JgCx9KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqa7GjHfE0vhqr42pBe0iolYfA4nBCtB7pEi50Przr+ULteC9MWMFUKY8rVPGSxaKSzsulmqf9ixR5dvF9YyeaD81T1uQp9n6PiFwttkjdM7OIzlCimkS4bIoo09vPpXfHLOWvs363VoEVcwrJGR1K/VstdmgVa5bQHVdjISE+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zlab.su; spf=pass smtp.mailfrom=zlab.su; dkim=pass (2048-bit key) header.d=zlab.su header.i=@zlab.su header.b=LB68WSLB; arc=none smtp.client-ip=109.73.193.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zlab.su
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zlab.su
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zlab.su header.i=@zlab.su header.b="LB68WSLB"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 58964C0518;
	Mon, 10 Aug 2026 15:16:17 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zlab.su; s=dkim;
	t=1786364178; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=jyXAV2W+9WeUgVtJKmGxJKoFTEPe3bQ/W+GJ1vmEbr0=;
	b=LB68WSLB067autQFFTfw9lgzVXbCwzWc761plBR1sHe3XnwXuVCep6nY8u/9Pm5IoK6sX8
	oyL3K1K6ywdU9lA/8a/vzaLnwnAVLV9jUFmiMLS+8HNAOb3BBxnkFh4Do/GJAXkkGcjjOf
	x/z6BhRy82c2vnLmm1ALIcg1z7DIRizpU5XD1eD9W+z0wrJMvTz7ov6OtW2QB3fd4GG67Z
	rcVzXGK2U+UyuGbXLuC6cpiEpeNDDXVBEgevjhuc/UrjIKIjtLvcYV7am+BE8LNlNK7/Aq
	1N8lwb0qM3Vy+qgDAz5hysEHHSAUUMAcFPaTlgWQ6kRwO46cbzqXX5M/es0S3A==
From: Vladislav Leonov <vlad@zlab.su>
To: linux-rockchip@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org,
	Simon Glass <sjg@chromium.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladislav Leonov <vlad@zlab.su>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH 17/25] dt-bindings: spi: rockchip: Add RV1106 compatible
Date: Mon, 10 Aug 2026 15:11:08 +0300
Message-ID: <20260810121121.210040-18-vlad@zlab.su>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260810121121.210040-1-vlad@zlab.su>
References: <20260810121121.210040-1-vlad@zlab.su>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The RV1106 SPI controller is compatible with the one found on RK3066,
so add the "rockchip,rv1106-spi" compatible to the list of variants
that fall back to "rockchip,rk3066-spi".

The RV1106 SPI controller also has an additional external slave clock
input (sclk_in), so extend clocks/clock-names with a third,
description/const entry for it.

Signed-off-by: Vladislav Leonov <vlad@zlab.su>
---

 Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
index ce6762c92fda..159111d143f2 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
@@ -40,6 +40,7 @@ properties:
               - rockchip,rk3568-spi
               - rockchip,rk3576-spi
               - rockchip,rk3588-spi
+              - rockchip,rv1106-spi
               - rockchip,rv1126-spi
           - const: rockchip,rk3066-spi
 
@@ -50,14 +51,18 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 2
     items:
       - description: transfer-clock
       - description: peripheral clock
+      - description: slave clock
 
   clock-names:
+    minItems: 2
     items:
       - const: spiclk
       - const: apb_pclk
+      - const: sclk_in
 
   dmas:
     items:
-- 
2.47.3

