Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794075266;
	b=honO5Gol6SXBEuO7+4Dj8QcgiPKsIiObExou14eyZ/Xu3yhkAVD04yR3FC4YtUSnV4HC
	 NIIINPtGdtdRlwkNbO1o012g47Iq41PSn43lUZWnQMObLndOYmZI0M4/dQg/ji2R6oFNc
	 6wDG0NbvT5MAyqW1UyAIrs1pjoDg2hAVQE8/JQEXc5A5i/MaXqa4YAdX0u+2LprtqPamu
	 WaBKWQG2UPAp78ly/yRzxfC3uYLSvf/6wCDpMxNvHm6VPCC7ljzyo/qO8mX3Y6fh0L4R0
	 GrlejEi57okpY/L3Hey/YSpZG5KpyyR99rxaRQfDBoS9iuKh+IyebJVSAxfV8HSU8fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794075266;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer;
	bh=BL+cmBoNPnGP1lSDwh9ujeU5GZ/Z/Eb6yaGi8Botz1Q=;
	b=VM1RvkxVdJ34qDcLFvl4h1AILrCKiOc3PXE99i7ASyyy2CoHb57k66g8q74DtbCl9hLd
	 X9itFg5NQg61WvDpqVVnl3k8iBHvTjX2+niAa8RgLf4+KRRGKpchG7Oe5DL9lWuFEvLUT
	 iueKm0rmO40qCLsOH+opACzNf7hYDwlrrwnnOgPnbM4s2IWbSJ4SnW/8vrh8LH8SWjRF7
	 UBS+hg9M42XlTWtJ63Bc+lfUWLsgLU4RzUjrVeOIRPzXYqC6ujnWy0imQpBK9kMYEIeA8
	 O6OWSULnbSYY/RrItgLA0vBZht0tCygmkfloAZo8rxF5KZ7Ky7dwjf4ELa9LrKXuDmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UrBRAnuK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB6A606A326;
	Sat,  7 Nov 2026 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UrBRAnuK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FAC1F0089F;
	Sat,  7 Nov 2026 18:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794075265;
	bh=BL+cmBoNPnGP1lSDwh9ujeU5GZ/Z/Eb6yaGi8Botz1Q=;
	h=From:Date:Subject:To:Cc;
	b=UrBRAnuKIGo7CiTkJ0Ax9lhqPR3tsDQWoDt5Ry5rBeZDhdw8sCxVlAS66ytd0pGfl
	 TBD8Y1sjXAfPx47q9yeKuNBJfudEK8i+xH13c8+WE+77cI5TQdHaCfoQv/8VvON42q
	 MQ5DXo4lXU29EmO3nXEGkzI7J16fsvr2IAo3ScQPhUsIZKVxrocMGSABCc6Iz8uw12
	 lLjW+6v+7KeaTi47GrFWJGqBesxbAViXX2UH1jbQIpBmU/uu2zy92rRQdDKSByI1Ql
	 TlpEwixFaF17J9O/SH4w6RzIngt4afCJ6EiN6fifhrg5Qle3uThlcQ7ISuBhAPMeCk
	 GOS9ANndYDX+A==
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 07 Nov 2026 19:14:22 +0100
Subject: [PATCH] dt-bindings: spi: pl022: Allow a power domain
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261107-ux500-pl022-power-domain-v1-1-d51913109afa@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MUQqDMAwA0KuEfBtIA1PWqww/6ho1sLWlxU0Q7
 y74DvAObFpNG3o4sOrPmuWEHlwH+F5DWpQsogcUlt45HmjbH8xUPixCJf+1UszfYIlE+znK8Az
 TpNgBlqqz7Xf9Gs/zAgUE7hBqAAAA
X-Change-ID: 20261107-ux500-pl022-power-domain-2e6fd279abbe
To: devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org
X-Mailer: b4 0.16.0

Ux500 PL022 instances sit in switchable EPODs. (Electric
Power Domains.) Allow the single power domain used by these
controllers. Found with CHECK_DTBS=1.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Allow a single power domain for PL022 controllers on Ux500.
---
 Documentation/devicetree/bindings/spi/spi-pl022.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-pl022.yaml b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
index 680fdfa184d0..9a61cb16e683 100644
--- a/Documentation/devicetree/bindings/spi/spi-pl022.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
@@ -71,6 +71,9 @@ properties:
       - const: rx
       - const: tx
 
+  power-domains:
+    maxItems: 1
+
   resets:
     maxItems: 1
 

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261107-ux500-pl022-power-domain-2e6fd279abbe

Best regards,
--  
Linus Walleij <linusw@kernel.org>

