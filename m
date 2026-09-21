Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E3B3CB57C;
	Mon, 21 Sep 2026 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985848; cv=none; b=ZeGu8QhQrXG2q4p+lgtKx7pVVziiI7rVzyYaKd5hngnhLUIBRp42XVs34+aa5tE2SI8OsKzCF6JudzNQZQ0q37zJuJzh3P8bB+adtTewh2Rz8BiqOpxOmlBqma2zPgeDJkURs9vI8Ra9G6axu+zUL1/XcVZ75YCK22ieOPON1FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985848; c=relaxed/simple;
	bh=f5k0pDKryWDsRKFbP8pNaZKdzeqx950Nhd1MszmVogU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PSNLDRv12/ll635Rg8Kbko4Ez/UY64R6DKIq1MxyGv12WplCBgmQLn3TO0wwjK+zbxg+t9jiEk7jyQ7ILl4fMOjbVVxzuYJNBpGrv3AF8CPbz0swqH0xt7YIR+tYNfSG/hJUcqzuUywpurIzDZP712mcKM+xuJXC8EsN7giFYdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=cmOrwUCT; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="cmOrwUCT"
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
	t=1789985836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wr2AnAyGpEYLu/a4pBAtgSY2fg4oeIUJzy4LCp//70Y=;
	b=cmOrwUCTWdilfAHxEtzSuHM6KjEy4V3It1tIQkfIDrJ3/t46crfCBjguJonZ0BXwSAf+9t
	BsPY3ODPdm7uX7WC7Swp/CP6OICUd3WK5MGxfdib7w/KjyPm0HPsPjEbrivbuAIS8GaU19
	z01z9Q9CaxFEyta/iVXRmyw+V6LqtW3GmAKhxKt6f8EHeIcnybVD5JYEIvY/inDcr5akMB
	ZDXIL5YrwNi8er9I7TRFIQlyp34VHphzY028hcp7Q06nKqumLzbdHLqcI0PGFBO/cc+OkS
	l+JipBP8JrLtHH/Fe6nOp0veXuU4BlMDINglyuHMZtGhy0hrsrPhpmlpBBCDUw==
Date: Mon, 21 Sep 2026 12:16:46 +0200
Subject: [PATCH v2 3/3] spi: dw: Use the rx-sample-delay-ns value parsed by
 the core
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-spi-sample-delay-cleanup-v2-3-b460d572fd32@kontron.de>
References: <20260921-spi-sample-delay-cleanup-v2-0-b460d572fd32@kontron.de>
In-Reply-To: <20260921-spi-sample-delay-cleanup-v2-0-b460d572fd32@kontron.de>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2128;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=mgQgwES2Pc1SSRbRExhFGQn56WBZxKlQB6CyUrwMRTo=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIWsji5bV0uernm5YpecuwZu75OHT1blX9jo+FAs20D5xa
 GLXlrzejlIWBjEuBlkxRRYpfovXtmaxPvLHqqNg5rAygQxh4OIUgIn01TIyHOzS+Dgr4odU+LpW
 g4W9HDIG82Z/CeQ55pgsn6M87X+IJMMffr6OgqdeO1dVFbmcfHbuXmv+lEk+U5trPNeGdi6tWPu
 fBQA=
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The core now parses the "rx-sample-delay-ns" peripheral property into
spi_device.rx_sample_delay_ns, so drop the private copy of that parsing.

The controller-wide default is deliberately left alone. It is read from
the *controller* node into dws->def_rx_sample_dly_ns, which is a
different node and none of the core's business when it parses properties
of a peripheral.

One corner case changes: the peripheral value is now treated as unset
when it is zero, whereas before an absent property could be told apart
from an explicit "rx-sample-delay-ns = <0>", the latter overriding a
non-zero controller default with no delay at all. There are no in-tree
users affected by this and it is very unlikely for out-of-tree users
to set rx-sample-delay-ns on the controller level and then revert it
to 0 at the chip level. We should abandon this configuration that was
probably never meant to work like this and doesn't make sense.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/spi/spi-dw-core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 206d3f9dd83d..b86b607cc817 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -1104,12 +1104,13 @@ static int dw_spi_setup(struct spi_device *spi)
 		if (!chip)
 			return -ENOMEM;
 		spi_set_ctldata(spi, chip);
-		/* Get specific / default rx-sample-delay */
-		if (device_property_read_u32(&spi->dev,
-					     "rx-sample-delay-ns",
-					     &rx_sample_dly_ns) != 0)
-			/* Use default controller value */
-			rx_sample_dly_ns = dws->def_rx_sample_dly_ns;
+		/*
+		 * Use the per-device value the core parsed from the peripheral
+		 * node, and fall back to the controller-wide default when the
+		 * device does not ask for a delay of its own.
+		 */
+		rx_sample_dly_ns = spi->rx_sample_delay_ns ?:
+				   dws->def_rx_sample_dly_ns;
 		chip->rx_sample_dly = DIV_ROUND_CLOSEST(rx_sample_dly_ns,
 							NSEC_PER_SEC /
 							dws->max_freq);

-- 
2.55.0

