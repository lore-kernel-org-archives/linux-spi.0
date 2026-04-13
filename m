Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD16392815
	for <linux-spi@vger.kernel.org>; Mon, 13 Apr 2026 10:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776074751; cv=none; b=BktB6D1jN4vbWZqcIlgpb9Mx318CFz64gszZx+FEVk+3N//mOd7TCLpyn2vJwBsWvfRO4AexxeUI0DGB03tZGQEEQ4N5heynfCOZ3dPIk5iEWvaeKxLq5eYQ2+n11Bfo2K72Wop5lX1yCBPVePeoj5SpnxBUsWUzpRqs7Gn5lKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776074751; c=relaxed/simple;
	bh=A9NrOmrGg9D5qQPIJd3OHlgLpJRhg3BN4oaCn3ZDTsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrrqe4Lhtraoib0JAkH/Na/8jwoIFeWyFP1N9gLl7GWyiCx4hHJhZw8i905lMDx7As35OMSdM8I7YSizEnv6GSlJDA2EJQ3X8rVVlgV6+PhjK2AIokdhWeSbN3TYjzGCmdF2pDQpSyCMHj7pxsovnXnfFrvPWDRUK3UGcm6bXyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNh29423; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNh29423"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-671a2f2837bso625398a12.1
        for <linux-spi@vger.kernel.org>; Mon, 13 Apr 2026 03:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776074747; x=1776679547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bb0Cl07VkZM2TjR90yXu/+DWSboJw3nu1/V+vc9DpAw=;
        b=VNh29423KAHbg0ypOR08WTv9rzYkBujc3flFysVRtoeTw3YYfDCeLxB4mEavbNtiHZ
         TlqLgmymV2xdPF8QfFWRuYug74hiXpeN5E/fBchZ1D75m0LxNjRb8u3/igitWTHkl9wm
         j8lymdPoync0FxoNPzZV64Fy3ZnQ+qNOLFkJOlEvHV2+vngFO33KVoG+DHYvV+wtFuDo
         eifekn9aTqO4VWoe+XosmDXStXwIK0rstJSs+wwGkYwzySeBCwnbYmYN+x6Uu/sQmrzn
         NRhMMqod1M9U2vzZuKA6NcIN+dMLD9ezxN1YMBF0juYrQ2/b2cWjHnuVzZrJB7mh+VOi
         7xlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776074747; x=1776679547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bb0Cl07VkZM2TjR90yXu/+DWSboJw3nu1/V+vc9DpAw=;
        b=FuvtQaQOeGh39ef3Pgq8m4EI1obzFSblsc/S5M13go3FJBJZAEtYSgfTpwrr70NIon
         vZ8CmcM6+Yzcls8CBK9crwAChxVc8iHR5Pg7+xRiM7307Cj12ncf/3HYOmTYwBW0Sh4h
         em1p9JXSnNASNCqnPKFsxDtZHU7iuYQLnp9g70YRRtddd6O40LzAyIPqQdKZJOJeBWiQ
         fRR/Tm2T29worKlfvBjCA4YpyH5Am21HSR3usiuLaDkPX3pg2wJST7UsTlVMUTj7WheO
         LsXEdc6mjUzOt4ho6HNCm1UhR5OSpoIxk6vWjSVk6vXyYVBhLX4amyB64ZCAtoSGgWOA
         UN3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV16GS4MZoqNndqW/CMH++vxPYpVBPZgUAhZMA+ZTKQNp7GmiYn3pes8lA8MVFlatQyT8upBZlULlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZYMWqWAiwY9An+HWB2AEJnF2alsgAkEEHIXR0r+CNFuZgBrH3
	Ob4crD97x1OCkOTXmk7m5zmgMCwlo8fU6Qk/wjNhQRKk1vwSuSRj6hGRsgBzBm6h
X-Gm-Gg: AeBDiev5Mv38gkMEqAH6FEjMPCPtYmL+uJ9MI1acvH45+cG1QpJOJqB5i89xrGF5l25
	o5lhzHc9DMOCNixdgCGjaldTjhW+28B9MH7zCw41jQQdMvJwDBf7TTl9trFLEzEN/1lD63HI9ZZ
	8effvHtt9BkO3LhAcu+jd7vVTaMMEk2vXhTYJTvs+SWxP+5CIkiSIhQRAcixLOGIoR5Dk5SqJQj
	zIZ5DrAOj/lP674fCkf3xEA7WIgDNcoCX05QxHyEvpLFXMXIG+QYnODTRrUA3RMMYtfVzXoB+Ru
	xtI7jSfTJIW8t1pgQQAlUZlm5lDDjZCJrdvgqX7XaOFVK5eFvsWCpKVUDD/zXUtf0XS08YV6CtG
	QzppzMfc+aIKGQpxSm1hn0dUg3KAXG4Y+eo4PZKRO6bFlNUNo4bdm2JcmwZ6cCK5jp0txBR46o/
	BvJ2C1RFwf5SJ+v9Es0JqpzQ==
X-Received: by 2002:a17:907:9801:b0:b9c:634:816b with SMTP id a640c23a62f3a-b9d724f0183mr594735166b.11.1776074746828;
        Mon, 13 Apr 2026 03:05:46 -0700 (PDT)
Received: from khalil-hp.home ([62.250.67.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e5c5824sm297805066b.38.2026.04.13.03.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 03:05:46 -0700 (PDT)
From: Khalil <khalilst@gmail.com>
X-Google-Original-From: Khalil <khalil@rentman.nl>
To: broonie@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: rf@opensource.cirrus.com,
	linux-spi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khalil <khalil@rentman.nl>,
	Khalil <khalilst@gmail.com>
Subject: [PATCH v2 3/3] spi: pxa2xx: Handle clock gating for GPIO chip select devices
Date: Mon, 13 Apr 2026 12:05:30 +0200
Message-ID: <20260413100530.580649-4-khalil@rentman.nl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413100530.580649-1-khalil@rentman.nl>
References: <20260413100530.580649-1-khalil@rentman.nl>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Intel LPSS SPI controllers (Cannon Lake and later) with dynamic
clock gating (cs_clk_stays_gated=true), the SPI clock is gated when
no native chip select is asserted. When using a GPIO chip select
(via SPI_CONTROLLER_GPIO_SS), the SPI framework toggles the GPIO
and also calls the controller's set_cs callback.

Handle this in the pxa2xx cs_assert/cs_deassert functions: when the
device uses a GPIO chip select on an LPSS controller, assert native
CS in the control register to enable the clock, and force the clock
gate on. On deassert, restore both.

This is needed on platforms where serial-multi-instantiate installs
a GPIO chip select from the peripheral's ACPI GpioIo resource to
work around an incomplete cs-gpios property on the SPI controller.

Signed-off-by: Khalil <khalilst@gmail.com>
---
 drivers/spi/spi-pxa2xx.c | 45 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 6291d7c2e..fe5762063 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -419,20 +419,43 @@ static void cs_assert(struct spi_device *spi)
 {
 	struct driver_data *drv_data =
 		spi_controller_get_devdata(spi->controller);
+	const struct lpss_config *config;
 
 	if (drv_data->ssp_type == CE4100_SSP) {
 		pxa2xx_spi_write(drv_data, SSSR, spi_get_chipselect(spi, 0));
 		return;
 	}
 
-	if (is_lpss_ssp(drv_data))
-		lpss_ssp_cs_control(spi, true);
+	if (is_lpss_ssp(drv_data)) {
+		config = lpss_get_config(drv_data);
+
+		if (spi_is_csgpiod(spi)) {
+			/*
+			 * GPIO handles the actual chip select to the device.
+			 * On LPSS controllers with dynamic clock gating, the
+			 * SPI clock won't run unless the native CS state says
+			 * "asserted" in the CS control register. Assert native
+			 * CS in the register to enable the clock, and force
+			 * the clock gate on.
+			 */
+			lpss_ssp_cs_control(spi, true);
+			if (config->cs_clk_stays_gated) {
+				__lpss_ssp_update_priv(drv_data,
+					LPSS_PRIV_CLOCK_GATE,
+					LPSS_PRIV_CLOCK_GATE_CLK_CTL_MASK,
+					LPSS_PRIV_CLOCK_GATE_CLK_CTL_FORCE_ON);
+			}
+		} else {
+			lpss_ssp_cs_control(spi, true);
+		}
+	}
 }
 
 static void cs_deassert(struct spi_device *spi)
 {
 	struct driver_data *drv_data =
 		spi_controller_get_devdata(spi->controller);
+	const struct lpss_config *config;
 	unsigned long timeout;
 
 	if (drv_data->ssp_type == CE4100_SSP)
@@ -444,8 +467,22 @@ static void cs_deassert(struct spi_device *spi)
 	       !time_after(jiffies, timeout))
 		cpu_relax();
 
-	if (is_lpss_ssp(drv_data))
-		lpss_ssp_cs_control(spi, false);
+	if (is_lpss_ssp(drv_data)) {
+		config = lpss_get_config(drv_data);
+
+		if (spi_is_csgpiod(spi)) {
+			/* Deassert native CS and restore clock gating */
+			lpss_ssp_cs_control(spi, false);
+			if (config->cs_clk_stays_gated) {
+				__lpss_ssp_update_priv(drv_data,
+					LPSS_PRIV_CLOCK_GATE,
+					LPSS_PRIV_CLOCK_GATE_CLK_CTL_MASK,
+					LPSS_PRIV_CLOCK_GATE_CLK_CTL_FORCE_OFF);
+			}
+		} else {
+			lpss_ssp_cs_control(spi, false);
+		}
+	}
 }
 
 static void pxa2xx_spi_set_cs(struct spi_device *spi, bool level)
-- 
2.43.0

