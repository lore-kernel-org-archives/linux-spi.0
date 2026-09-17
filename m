Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3D94848A3;
	Thu, 17 Sep 2026 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659526; cv=none; b=bLqqs2Wd51K2kYNNTTdfmaLHqPUVdRJUlVc4SbvWgJL1RQqliuuSzKrlLg13HCGZrMSbBaHRbRAjyuL17WHzpvX0je7VMPlOB6Ctw7x3U1B4iisOlYjg8AZylK9T5XnBdCgOm814RoP2/uRcgh6iSE4vUIWbFGnJh7ADMaWOFU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659526; c=relaxed/simple;
	bh=JqILw5+znBbGw5CVGtBPKKBSQx9ykwRrOqYgKUsFV2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PptJ8gER6uNi/a1RhA4nRoaM4WwZf692y9G8Fo9g2QES+A00hGdk72uCOdr4TeDIhZnFymmrD3ZBXMNYRDTZX/iIuqT+49Me1GLyJUCp+fpNIPEx+4AmeHt2/e2p+siMe+7u58t+FEMH5Zz76Uq6boenJ7/0qzk7cZgAZhY0RG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=yTWxLlYw; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="yTWxLlYw"
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
	t=1789659510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZwHurz3qFcCVqb+Po4Y9Ihna8FWaKNv9CmUUvvsfgU=;
	b=yTWxLlYw1KqUHOP5FcIkQPRUYyLClpMooyMYFjHeTr9ZApu9jZrr2J4LkSH2rIWiGugFZc
	s58U4d/dTKkB0uANlthpON4LpCTf65fAdV3oLnZ68EQpGJCbzB35zXjK/lYwnVivhJztns
	FiQemcCx89E9Z7u9y8L5bI2L+PWyaNMM3vzX8ZXhD5+nKmfrIZFVf5OiREhYfyi0VoG8V5
	KMlLkGczxO5ldu2OPhgG6AynJ6ucozkcPIkpwRMqZ9c8whqwPDy5JdHYPfRoUcL00iuTL0
	2jUZdB497MXZwjqjy3YzLxNj0HQxY2oswi+QvxAcIOybihZHGE1T+ztutmx0lQ==
Date: Thu, 17 Sep 2026 17:37:37 +0200
Subject: [PATCH 3/3] spi: dw: Use the rx-sample-delay-ns value parsed by
 the core
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-spi-sample-delay-cleanup-v1-3-0e4eddbfb1ce@kontron.de>
References: <20260917-spi-sample-delay-cleanup-v1-0-0e4eddbfb1ce@kontron.de>
In-Reply-To: <20260917-spi-sample-delay-cleanup-v1-0-0e4eddbfb1ce@kontron.de>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1983;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=dNE9qYNVl7I4xsD6/HfPBsDDqC3FezGj/mUMdwpPGY0=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIWsNZ2n38cNpBqmnf871Cvpyc+LkRdM0tEI1V/7dt/Nrz
 YTo2jv6HaUsDGJcDLJiiixS/Bavbc1ifeSPVUfBzGFlAhnCwMUpABMJNWH4n/jzkvLpB5Zqr6w/
 K7fE702Rle0XZ5pnmP0n4+mfQ07zZRgZjocbPvq0dSF/julNJZdDFblbuK06knonCSzdmrOwwVG
 LFQA=
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
non-zero controller default with no delay at all. There are two users of
the property in the whole tree and neither does this, and zero means the
same as unset for every other user of the new field.

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

