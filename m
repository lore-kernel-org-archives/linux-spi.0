Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5EA3AFD16
	for <linux-spi@vger.kernel.org>; Fri, 26 Jun 2026 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782497020; cv=none; b=Wn95n395t6GNZTpH+5QgYHo1pdonZzMGz73qgFYsm69Ta5YUxkLay2RLADgtcwFawgXSui1AqrHDuif/namx+aMCQ7MLLcB3njvgjAfeATwgrJd0rtx1wJaD+39Ns9JX/jGjUYaYZoobZJfW+NB2XgY+HMD+3a3XMVwBCjUIT/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782497020; c=relaxed/simple;
	bh=TR4JJkbczPJqnBZozxssK9USknm3EbwtFsD9ETh3ikc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUfUro0ZM9e3LC1hq0T3dJXb6egqlaBTN3RIR+ZRY8vw/0P/kC0Xfq/O0IqKrCrU+HNpluzY3EiYGnjp6CX4oyVYWNrb5KLRAGBBXxidrsixHRNJYseaC+g0OF8uKc98KRSfdQP95JZobU5fW4J11rJSKa2mkR/gRXAxNHq+rgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=k+A9xwBo; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="k+A9xwBo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=TDBxImWcNkeCo7o9U3wHYjvtH9B9qqjr7UbJJy5F/cA=; b=k+A9xw
	Bo36SRUSKx2VhgoCTXkYcHx3XcvPEXUXcPKo/SHCX82C9Kk/W0oNujoBeZ07A9++
	3aq+qCTsPQG/mgp9YLWfbS+Uk87X3hqDZj0hU7e/+Qif8JEWogk9OlZdfKW5mxv+
	RcHJtZh+4QfvZ1/2n/upeP48SNVPKyLvvxjYCfhB6cmIeVeVUfHg3HUlHM/tl2wY
	j5ieQGcMGhMd7iOzMTkpIjAJgGS0GIhIXLeIh6jV1tjvAVG6LfuNwDEUbXDCPW6Z
	AprXQOfmaxNXOicyzCWeTJ2G36F088xMEx/YYlzVwsXuTiael0iHdnvrTnz+kk8k
	PhaBaAtY1/v1mHAA==
Received: (qmail 3649245 invoked from network); 26 Jun 2026 20:03:32 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 26 Jun 2026 20:03:32 +0200
X-UD-Smtp-Session: l3s3148p1@G/s47StVmMMujnsl
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 1/4] spi: dt-bindings: snps,dw-apb-ssi: drop superfluous RZ/N1 entry
Date: Fri, 26 Jun 2026 20:03:22 +0200
Message-ID: <20260626180326.9593-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626180326.9593-1-wsa+renesas@sang-engineering.com>
References: <20260626180326.9593-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 164c05f03ffa ("spi: Convert DW SPI binding to DT schema") added
an RZ/N1 entry which was not in the original txt-file. It doesn't follow
the usual "<soc entry>, <soc family entry>" style for Renesas SoCs which
was properly added later with commit 029d32a892a8 ("spi: dw-apb-ssi:
Integrate Renesas RZ/N1 SPI controller"). In that commit, removing the
bogus entry was overlooked and is finally done now.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Change since v3:
* new patch

 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index 8ebebcebca16..e0f249e82fa1 100644
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
2.47.3

