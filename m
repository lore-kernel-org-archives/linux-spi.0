Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0872C4C10C3;
	Thu, 17 Sep 2026 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659525; cv=none; b=oVdUyIaCSkHUEmRwk9+bCepgrXxbsgtMLsQHtXk3M5Ot5wNSP4e+LkXrcpgyhVVROSnYilbGW/tDF+XMMXfNPioey8KAAFekHICJijuh3z/Emd0zXQVb6HdW3myIMpgqEfBUMb+Vw85axpBHyQ3kMCqfKsJev/jwpfiqDQ8tuvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659525; c=relaxed/simple;
	bh=1oYRZuFvI7S5Ss30nbv/q/igQt3wf8fSuSjrcbba7rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jhB3zXsXxEuRWamrKilu2Yq4QFsOne0uEG0n034XIZhHStOtEJTIOPNCow7WisNJaVWbsWMxQKPfFYnM2JG/C0uF4aXgJL4Kch8OT05E2troTPAyD3iK1ShiRfTYCBMoLKWFM9V9pMjV77UR2tz5Y8JOfsRLSYgIQVHpWs3MXq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=UDmSO912; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="UDmSO912"
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
	t=1789659510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=90vRHS/V2op7RmcBd44fFmnN4zQU+VelDx0s5M+vwFw=;
	b=UDmSO912lz9HQIXGCfg1yANuGdAl9lisdAlTwjkdN52BTL27JaASmhbir4+lN8FzD+7t6F
	UFliOcP0E7lWYww8TLKU6t1JZ9F0WzwbFDHrUWmLt+pi5g6IBNG++hpOLjc9775sBH2E+2
	tJ5I6csVmDJ5Nuzr5m8n26m/IQ26cv8fkJE6yifECQrwg2+4Gfu+hTR9PPj1C0TvhPSoz8
	tA3C/8ePY3bigrOFQXS3tPwJBBR29WazqK/65Zmconhor/0ClgkRm5hQ32hzrcihK01sC4
	inEIEAJrWsYeVDsyaXbX72Nk7NERHhfwxg+SqQR8ausCS+kkzx6+ehDwJlTEQw==
Date: Thu, 17 Sep 2026 17:37:36 +0200
Subject: [PATCH 2/3] spi: Parse the rx-sample-delay-ns peripheral property
 in the core
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-spi-sample-delay-cleanup-v1-2-0e4eddbfb1ce@kontron.de>
References: <20260917-spi-sample-delay-cleanup-v1-0-0e4eddbfb1ce@kontron.de>
In-Reply-To: <20260917-spi-sample-delay-cleanup-v1-0-0e4eddbfb1ce@kontron.de>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3132;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=YuOQ2sqjfzq8/kx5BwZr8fKOIcuHnw/CDnFbgOkUBAA=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIWsNZ+nkJ7MO8nvOX/1zqUXqnznvJu3/ztG453VwFsOzG
 vl1GR6XO0pZGMS4GGTFFFmk+C1e25rF+sgfq46CmcPKBDKEgYtTACbinsnI8FHI621ifKffP4+s
 Ko9XVzzU4tY4XZhYmGc0xbX/hafJPIa/8uH+R0W3Sm3O+9Oj1ygh6Nll+HMS24qphVwOCxYX/9v
 NAwA=
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216

From: Frieder Schrempf <frieder.schrempf@kontron.de>

"rx-sample-delay-ns" is documented in spi-peripheral-props.yaml as a
generic SPI peripheral property, but the core never looks at it. Only
spi-dw reads it from the peripheral node as the binding describes, and
any other driver wanting to act on it would have to duplicate that.

Add spi_device.rx_sample_delay_ns and parse the property once, in
__spi_add_device(), which covers every way a device can be instantiated
and runs before ->setup().

Use device_property_read_u32() rather than adding this to
of_spi_parse_dt(). spi-dw already uses the fwnode accessor, so the
property works today on ACPI and software node platforms such as the
ones served by spi-dw-pci, and parsing it only in the device tree path
would quietly drop it there.

No functional change, since nothing reads the new field yet.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/spi/spi.c       | 9 +++++++++
 include/linux/spi/spi.h | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5b5b3bc5f0d8..9e3c24ed8f9f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -929,6 +929,15 @@ static int __spi_add_device(struct spi_device *spi, struct spi_device *parent)
 		}
 	}
 
+	/*
+	 * Peripheral properties the core handles on behalf of controller
+	 * drivers are parsed here, rather than in the firmware specific
+	 * instantiation paths, so that device tree, ACPI and software nodes
+	 * are covered alike, and early enough for ->setup() to act on them.
+	 */
+	device_property_read_u32(&spi->dev, "rx-sample-delay-ns",
+				 &spi->rx_sample_delay_ns);
+
 	/*
 	 * Drivers may modify this initial i/o setup, but will
 	 * normally rely on the device being setup.  Devices
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 88d17fce02dc..fb4baa0d3398 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -169,6 +169,12 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  * @cs_inactive: delay to be introduced by the controller after CS is
  *	deasserted. If @cs_change_delay is used from @spi_transfer, then the
  *	two delays will be added up.
+ * @rx_sample_delay_ns: Delay in nanoseconds by which the controller should
+ *	postpone sampling the incoming data, relative to the sampling point it
+ *	uses by default. Describes the board rather than the device, namely the
+ *	flight time of the clock and data signals between controller and
+ *	device, and comes from the "rx-sample-delay-ns" property. Zero when the
+ *	property is absent.
  * @chip_select: Array of physical chipselect, spi->chipselect[i] gives
  *	the corresponding physical CS for logical CS i.
  * @num_chipselect: Number of physical chipselects used.
@@ -235,6 +241,9 @@ struct spi_device {
 	struct spi_delay	cs_hold;
 	struct spi_delay	cs_inactive;
 
+	/* Additional delay before the incoming data is sampled, in ns */
+	u32			rx_sample_delay_ns;
+
 	u8			chip_select[SPI_DEVICE_CS_CNT_MAX];
 	u8			num_chipselect;
 

-- 
2.55.0

