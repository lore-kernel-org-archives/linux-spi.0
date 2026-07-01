Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A491848C412
	for <linux-spi@vger.kernel.org>; Wed,  1 Jul 2026 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782911586; cv=none; b=IulIv8dUtLVqQa8t5oEZ1yluRPyJi/4N0+L5Za3jAvbqdopDYMlL9kPTmHXYtd522VcFzEy/cQmpGBxF2XZ88V4d/YB5YrsZ1ohAY1gdfJV7SfPWANZzGBTLneslFpZuRKw2M+mNlR4OwMy5Zt9FDSHjRbVFe13mS0XjTrI1g+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782911586; c=relaxed/simple;
	bh=e+zh3j/wykjMlC3CQS6q56Obs4SCdT1AUtHglJSriS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JP+VAYWuhPEHQ6J0UNxddtvglOtQ6vRuCDoQSttBy2IqoxoWGVRXknDPQilthbk51hbAwQOOoTSBUD3JlZsvWYUi663WLEpEpdTS+lORHZNHowH7iBYh0xcEsJ6QA/1NWU7TI+alxcuDLr9sw4dxIEM1rhgUFm3HzCCWvrBauW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=H7QUtUUj; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="H7QUtUUj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=OXn9V7e86bi/5vj+IElGStXrZ9tOEkkQid7B89BoAeM=; b=H7QUtU
	UjNwOBlkwXMCReCE5CUhzRYfcfX6sJfkK3WyCHXnCY3EeQORBnUgJrzTXy/woiDl
	GdGZCrTEa7WqQwPbuUhwjIAmB1QGR57USzuqLnQ3sj0L3iiuCNdTmtRQhMI9jvCJ
	weT9zRhCiLoUdiaLoswV49AYFy+ZbjRIgdS9e9o5IfwbQBnNdbc5xMRZKPL+E/4W
	FTrTfBgXtxb/b77Ros8G5OGql9lonMrLxrLxoLk591l4ef5u/GB08QfrU/FTXkTA
	boexaZOi3mx0wIThcMHV6pLPXHrg8SQJCdUDYHk+iP2RQzAEk3W3Q+0tiI11QBG4
	W5sSRMkwKLPlXCHg==
Received: (qmail 713126 invoked from network); 1 Jul 2026 15:12:59 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Jul 2026 15:12:59 +0200
X-UD-Smtp-Session: l3s3148p1@IatWc4xVlMNUhsc0
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v5 2/2] spi: dt-bindings: snps,dw-apb-ssi: add 'power-domains' property
Date: Wed,  1 Jul 2026 15:12:50 +0200
Message-ID: <20260701131248.4545-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260701131248.4545-4-wsa+renesas@sang-engineering.com>
References: <20260701131248.4545-4-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This SPI controller likely belongs to a power domain for all the SoCs
listed. For sure, it belongs to one on the Renesas RZ/N1 SoC, so
enable the property to be able to describe its power domain in DTs.

Suggested-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

Change since v4:
* rebased to -next as of today
* added Geert's nad Krzysztof's tags (Thanks!)

 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index 447be88caf34..95a5bd894e93 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -93,6 +93,9 @@ properties:
       - const: ssi_clk
       - const: pclk
 
+  power-domains:
+    maxItems: 1
+
   resets:
     maxItems: 1
 
-- 
2.51.0

