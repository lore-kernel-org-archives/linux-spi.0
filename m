Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3624D48C3E7
	for <linux-spi@vger.kernel.org>; Wed,  1 Jul 2026 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782911584; cv=none; b=L1MesD/2HGgOkZrfi8z7LO9adGHUGQiZepWQVAl4ke9MJNbpJBsWJLzN/WXchX21n3jLOkh4aThjUVLo6fjmX7LjgKsHLIldsZ8rv1y0xnRDcqSDf4NOiFajuXqB0jPkQJO4T3jccyI6rsS2d2YSDhPv95HABRfcuKjgQIsIRyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782911584; c=relaxed/simple;
	bh=F9gWWpxdSDcNRPe+XQpbs0aOTlnBvasMoYOq1x8/6zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEU1CwgnWLfdYf4mSn5kQuSjmL3OmsM/8jFzpbAmpM9nNaZtM5y+n0rkW61IrMijaSK+amPdiUW7QGfxpdXxkN/qTOliKYmNTIxC8FLmynXnOEhjSjbrGM3UYoZbWKyChqKfzM4ngOhG3w79c5BL5SWS5uiUWnBLyyDfNg8tQyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=J+NGXv9d; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="J+NGXv9d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=KmO63xgx7KFW2kYR+qtnu3annPDisLEXrTj5KUOG+4A=; b=J+NGXv
	9dfy7itCiK0jSQ6d91pI/tGLnMO6iYYiaqK5+kYMyWJwU5k1uQTzlyNb7/W7iRoP
	yxiqpGEgO9S2ABaAfSXb2WTAnCoMbgcl+xIg27jcRSfwtoQS9Xe+mJfA32nlF9oK
	N2Ul43kCRwnqr6Idk7qy8zqGn3S3ou5THRgWX2Zk4nchrnTJfV++yUGQuucJKz/9
	H1jeGDy0ygmQ10PHJ0LDHy//9dOc0PwtiMQuvUBmLc9wQay2TqNiAFyooswRlHJU
	ziV9FFUIsSTBP6Ks7L9LdY5OI3rvDi0B+EAR9HKqpj0ufA/8Hy+AjH69BEgVKwY/
	UV7TAsBO9bb4eoPw==
Received: (qmail 713056 invoked from network); 1 Jul 2026 15:12:58 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Jul 2026 15:12:58 +0200
X-UD-Smtp-Session: l3s3148p1@wQREc4xVCYxUhsc0
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v5 1/2] spi: dt-bindings: snps,dw-apb-ssi: drop duplicated RZ/N1 entry
Date: Wed,  1 Jul 2026 15:12:49 +0200
Message-ID: <20260701131248.4545-5-wsa+renesas@sang-engineering.com>
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

Commit 164c05f03ffa ("spi: Convert DW SPI binding to DT schema") added
an RZ/N1 SoC family entry which was not in the original txt-file. It
doesn't follow the usual "<soc entry>, <soc family entry>" style for
Renesas SoCs. That was properly added later with commit 029d32a892a8
("spi: dw-apb-ssi: Integrate Renesas RZ/N1 SPI controller"). In that
commit, removing the old and bogus SoC family entry was overlooked, so
two SoC family entries were present. Remove the variant which should be
used as fallback while leaving the ABI documented.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

Change since v4:
* reworded commit message to explain there is no ABI breakage because
  only a duplicated entry gets removed
* rebased to -next as of today
* added Geert's tag (Thanks!)

 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index 4458316326fc..447be88caf34 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -50,7 +50,6 @@ properties:
           - enum:
               - mscc,ocelot-spi
               - mscc,jaguar2-spi
-              - renesas,rzn1-spi
               - sophgo,sg2042-spi
               - thead,th1520-spi
           - const: snps,dw-apb-ssi
-- 
2.51.0

