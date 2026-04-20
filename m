Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641E939935D;
	Mon, 20 Apr 2026 11:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776685560; cv=none; b=VnWZMLs3rXX0h9/OAWV3F7yoNdDOXKW84INjg3reLo4iW4dyJb1tevpirFRZtZefIryOr62oDm3SKB9TYEygO8WdRJchFyTrdI/6vjMpkVzu/h5kWSdZCRZIaVExxYaULrN8WN6FyOcDbObG2CAdb1hAeHELmJWqtKisYq2sF+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776685560; c=relaxed/simple;
	bh=j09E/B/OrMFOBEUyjyz2A0FYcOvcCRDmklRDd7Oay4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdmmsbsANAPPxZAPGupBM/svGYpLqsLjPH0SH3socB3x5u8MpC3luLIJioegecBli50lIXRrDqSGgbtJy6ZXRSYNr+Bn+UfkGYhoQQ8RFE89f6HvFiVmWPoSb4JYpcP7PI8X66aphanVo08ihBBy/+mPMkZwNCSYJAksemN24Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=laE8dpYJ; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="laE8dpYJ"
Received: from francesco-nb.. (xcpe-178-82-120-96.dyn.res.sunrise.net [178.82.120.96])
	by mail11.truemail.it (Postfix) with ESMTPA id 5D8FF1FCBB;
	Mon, 20 Apr 2026 13:45:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1776685549;
	bh=miVCOJ+NF3VL81lqNwmUBCNXEiqZM2BQL9sBEasfujk=; h=From:To:Subject;
	b=laE8dpYJKbnutzsrdaCTcBzhaNLTNKPt215oJ97PKuT6dNc+Js9SCl2Z49ErPLsPr
	 bseJYjqwQZQB1unm8zoTu75HtnodgkxCZo/dXV7bmsYniLBmL9qCWJNgbBZalh+JHr
	 nRE3Te1oBk25ZLiNPbG54MizHo3FNxK7wj6USrmPXpmO2Y9JSBNxMUW0A/orCcvTO7
	 6qgjSeX8PLl/kfHl4xEhmi0fRqV0oq9Gzgl8Pu6UVDw6MibOU5cZkxpmGl24l4le2U
	 68ZsuvJfR9NwONxK9702zbioo3z88pLMpFy2i9fvOm+nHXcZnY8uveNun7R6sE/t8B
	 neDS50l7Lu42A==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v1 2/2] spi: spidev: Add Toradex LAVA HAT OF compatible
Date: Mon, 20 Apr 2026 13:45:36 +0200
Message-ID: <20260420114537.78160-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260420114537.78160-1-francesco@dolcini.it>
References: <20260420114537.78160-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add "toradex,lava-hat-spi" OF compatible, that describes the SPI
interface implemented in the Toradex LAVA HAT. The Toradex
LAVA HAT is a test fixture used in Toradex automated testing lab, it
provides various functionality, including SPI MISO-MOSI loopback on
various SPI interface.

Link: https://lore.kernel.org/all/20260310133254.GA51497@francesco-nb/
Link: https://lore.kernel.org/all/20260316073547.11437-3-francesco@dolcini.it/
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/spi/spidev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 638221178384..2a92dfdc5331 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -701,6 +701,7 @@ static const struct spi_device_id spidev_spi_ids[] = {
 	{ .name = /* semtech */ "sx1301" },
 	{ .name = /* silabs */ "em3581" },
 	{ .name = /* silabs */ "si3210" },
+	{ .name = /* toradex */ "lava-hat-spi" },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, spidev_spi_ids);
@@ -735,6 +736,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "semtech,sx1301", .data = &spidev_of_check },
 	{ .compatible = "silabs,em3581", .data = &spidev_of_check },
 	{ .compatible = "silabs,si3210", .data = &spidev_of_check },
+	{ .compatible = "toradex,lava-hat-spi", .data = &spidev_of_check },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.47.3

