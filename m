Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794037259;
	b=cPPZ7cytgp8Xk7SCYq0h0Grh8xNS4H1EhLIUkIBWkEUHuy6A3kNTB35btb3vFzTc5ae3
	 qDWZIY6GKwJYh0A4A8rYEEou7WtlWcSgvVCyZj5wPehDHS4VKqLiU3FijHXkfpgFipM/5
	 0Vpl7B0LoJ5cE432dozesEKqYWrByf7khovWcqARs3wPVzQtg9+/CwPHnXO4YLDug2M5R
	 GBI8DKifzm2J7nUtZgr3V/xDgixMQPlC+uvStKxWvugY7DZfze4XGt3B9yosmWhUr8QXu
	 B1jykW7ToG1t4bicAjxzvZ94CE7IF2yj2HX1h0nt41A735hBzFxqqwwDYM44vLXB78Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794037259;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5Wdd/xZoK898UHdLfTB0jlcIsLEdzE4G/ZQ6twbViFs=;
	b=LWet5v3+ApycPNV+TUBalqS0y/wXm7puQOMYoqyo4I1O3DoxoU/KZjWJVSrsgpSe1K/B
	 I7pRmKzoT1F/XDR7EzpknaxzK7vb0LJjOLInLudpOkx11rRFMYLKMwQftEvKfvDOHtNzI
	 Yp01K06at2fmNN/Y/XjGhj8z1tootT892a6bFot8FPL/lupM3k8fTecAGE/UTMIUnNNQj
	 j+1fe79vLCtWCIdU1BmdUyhl7kQoi+Lgfpfo8PBIEmAsp7/vkj0Km6jCGITJQ5ViepG8E
	 eowpGl1190H9lrGzzfY07DOw+q1m6XTmploTOZR9JX7gGBlOT15Y+AAZTGfRkkCDGWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nXc2J/Y7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6F3606A326;
	Sat,  7 Nov 2026 07:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nXc2J/Y7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A34A1F008A1;
	Sat,  7 Nov 2026 07:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794037259;
	bh=5Wdd/xZoK898UHdLfTB0jlcIsLEdzE4G/ZQ6twbViFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nXc2J/Y7kPkLHvw0hEXBKbMy9oDlKFhfK4Y83OPM+qMX9gb4Bw2I53avYrRZfKEiJ
	 tZN8MfSQ66EbFYEdrU+RXdH468LCGRPQXz99aR+6aALX8K69izOQ91vrKc2zUR8DB+
	 OsVTnFRoZNCpmgU1PrEHEWnTeNQGlU8UJvThb6lkWYrtmJhqc/x1c9w1hPRqYsicli
	 Pqa+PPfGQXDDbfXo2LEzkCyv4lWsDcDiPbDEnj1IqBhgTG3gqO6XU9LuH8phOypo0t
	 OVXkgRWPt9o3ckw1TR2MLGjpODUn9f/tflUXk+Awi2l0Kc2rsWlJI0lggUgH6i7LpM
	 gubByHyoQkzoA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Fei Xie <fei.xie@horizon.auto>
Subject: [PATCH 1/3] spi: dt-bindings: cdns,xspi: Add DMA properties
Date: Sat,  7 Nov 2026 15:20:42 +0800
Message-ID: <20261107072044.17574-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107072044.17574-1-jszhang@kernel.org>
References: <20261107072044.17574-1-jszhang@kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dmas and dma-names to describe DMA memcpy channel for the candence
XSPI controller.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../devicetree/bindings/spi/cdns,xspi.yaml          | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
index 38a5795589de..b19c2e051e18 100644
--- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
@@ -40,6 +40,19 @@ properties:
   interrupts:
     maxItems: 1
 
+  dmas:
+    maxItems: 1
+    description: |
+      Optional DMA memcpy channel for transfers between memory and the Slave
+      DMA data port. The channel is shared by reads and writes.
+
+  dma-names:
+    const: memcpy
+
+dependencies:
+  dmas: [dma-names]
+  dma-names: [dmas]
+
 required:
   - compatible
   - reg
-- 
2.55.0

