Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793568;
	b=0eOs4zWBIH3XY4xmRJQJVj2BejZA/H3787mbyZe6Yv3Mk/pkR327pYdiLuLWzzHmfKwJ
	 cUMTiH2D2Q+s6ZcDzDvMnEQbf68iTZLq6hhzd9R8NmGHMZWrAKhef6jV9wG8V9HWMiBS3
	 70ZNTzha1NJvJYBeiQrMn1n2J+pmoOW7XXXS7C6Pb4T3kqdKcNACIdAQyr/UC9caZFNRy
	 vSIEjG1lg1Nc9CUF8RlOp5AsAqY9uX5iY0o7VkaMs4EyyZuOnRQIJ103HoPHA643NsLDz
	 bsWPAh8hZSLgNGPK05hHZGk/VmhpcogcOFb8+r8bu1Dr471oGjUKs4i2En/VdyV89CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793568;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xBRn49p7x5P2JnsS/AwLAkeJTmgdq0ZToxo/maqobQo=;
	b=taiW2XWcJiThHgf4GKLwlDaWMKCemEWLSM7BLYc16AHUjutX4zzpOcd93TpRWR1K3qqh
	 NVy8jLxlEm5zy9eL7tW7E1TLkMr37BSOJf+1AQJZ+r0V0XCIJePxjVQqxwsVbzTrjv4HQ
	 ES3d++T89Qq/JKSadmuGZADh6YGIxu0xwoqQ03wK/3ugqmKMKzaD4ZP8v8O2gILDX/M98
	 alizqSOQZrEnsODovXAJRt5KN4PPKvcYwI8T4WzRTPZZWHRdkG2gjneKllM6p1zUwVLj8
	 LqpKWVUUp/f1jtgfyK7G/3JBOliVI624f7ha1MCH+f0Rm3LBbovo4ryGSQB90w3thkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRxvAwbT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD05F606A32A;
	Fri, 27 Nov 2026 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRxvAwbT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523231F00898;
	Fri, 27 Nov 2026 15:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795793568;
	bh=xBRn49p7x5P2JnsS/AwLAkeJTmgdq0ZToxo/maqobQo=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=JRxvAwbTBrXanJgeTCDSzmeoZKc54ZekNd9XVrRJa40uqNCiAHRpumLZWOdqZ+xW/
	 o9Ns3DiHx/N+em/r+5+83Dqzo8oPmcsac9MXTO2juy+ZCW+lULy3bU6q+yU2JVxmms
	 +4EnJvAyFl8lqOGb1gQfXNDOxOzDjdRXio/w2UbZwPA8PCg6toZ3jjUFnUm41mstuz
	 gJH8rPcnlgcHlYrcDm8ReDLxODe+DY1xtG5102Mty93RvkC5iWFlfTouwCwSnT/BSG
	 z5VEflxTXjk8Ip7t2q5yfRPyZ4XxHs+jFs+rx3jO6fAGvn8snuLBnQ+D+Lt+khCVEh
	 7XwR3ZxPXMpLQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Mark Brown <broonie@kernel.org>,
	Foon Tan <lftan@altera.com>,
	Graham Moore <grmoore@opensource.altera.com>,
	Murugan R <vadivel.muruganx.ramuthevar@intel.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Pratyush Yadav <p.yadav@ti.com>,
	Dhruva Gole <d-gole@ti.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/10] spi: cadence-quadspi: Validate num-cs against CQSPI_MAX_CHIPSELECT
Date: Fri, 27 Nov 2026 15:31:09 +0000
Message-ID: <20261127153158.2969573-7-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127153158.2969573-1-lee@kernel.org>
References: <20261127153158.2969573-1-lee@kernel.org>
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

cqspi_of_get_pdata() reads cqspi->num_chipselect from the "num-cs"
Device Tree property without checking that it fits within
CQSPI_MAX_CHIPSELECT.  cqspi_setup_flash() then validates each child
node's chip select only against cqspi->num_chipselect before indexing
cqspi->f_pdata[CQSPI_MAX_CHIPSELECT], allowing an out-of-bounds write
if a DT specifies more than CQSPI_MAX_CHIPSELECT chip selects.

Reject "num-cs" values exceeding CQSPI_MAX_CHIPSELECT in
cqspi_of_get_pdata(), and store cs as u32 in cqspi_setup_flash() to
match of_property_read_u32().

Fixes: 0d62c64a8e48 ("spi: cadence-qspi: assert each subnode flash CS is valid")
Closes: https://sashiko.dev/#/bug/linux-cd463fc8-1b94-4bcf-8d06-fae21b88894c
Signed-off-by: Lee Jones <lee@kernel.org>
---
v1 => v2:
 - Reject num-cs values exceeding CQSPI_MAX_CHIPSELECT in cqspi_of_get_pdata() and store cs as u32 in cqspi_setup_flash(), per Theo Lebrun's review.
 - Simplify the commit message and drop the stable tag, per Theo Lebrun's review.

 drivers/spi/spi-cadence-quadspi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 912470bdd10c..0f15250c51db 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1613,8 +1613,13 @@ static int cqspi_of_get_pdata(struct cqspi_st *cqspi)
 		}
 	}
 
-	if (of_property_read_u32(np, "num-cs", &cqspi->num_chipselect))
+	if (of_property_read_u32(np, "num-cs", &cqspi->num_chipselect)) {
 		cqspi->num_chipselect = CQSPI_MAX_CHIPSELECT;
+	} else if (cqspi->num_chipselect > CQSPI_MAX_CHIPSELECT) {
+		dev_err(dev, "num-cs (%u) exceeds maximum (%u)\n",
+			cqspi->num_chipselect, CQSPI_MAX_CHIPSELECT);
+		return -EINVAL;
+	}
 
 	cqspi->rclk_en = of_property_read_bool(np, "cdns,rclk-en");
 
@@ -1753,7 +1758,8 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi)
 	struct platform_device *pdev = cqspi->pdev;
 	struct device *dev = &pdev->dev;
 	struct cqspi_flash_pdata *f_pdata;
-	int ret, cs, max_cs = -1;
+	int ret, max_cs = -1;
+	u32 cs;
 
 	/* Get flash device data */
 	for_each_available_child_of_node_scoped(dev->of_node, np) {
@@ -1764,7 +1770,7 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi)
 		}
 
 		if (cs >= cqspi->num_chipselect) {
-			dev_err(dev, "Chip select %d out of range.\n", cs);
+			dev_err(dev, "Chip select %u out of range.\n", cs);
 			return -EINVAL;
 		}
 
-- 
2.56.1.839.g22a8290db9-goog

