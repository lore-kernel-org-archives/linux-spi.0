Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC752DB7A9
	for <linux-spi@vger.kernel.org>; Sun, 15 Feb 2026 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771163789; cv=none; b=WhvR20misYVevWWes8GPZjwCisOfZOVDSwUFL+BXlzgo3G0oep1N8LQW9ywyj0NkaqU74kTyTuMX58/MkZIhmJhE11328Hvl33Sw3aVdJIKgrvBUMYNROXuliAUVagLQedwwiGxQs0zDS9wtZX9Jbp1d1RKUFxGul/M18zQGce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771163789; c=relaxed/simple;
	bh=HUfPOigY4ct7TOsZh4k/o24ztrERbzR54bjCePZL4wA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ug4zk7IXQ1gxaWDdDWpLILQLAgBaslozyzkNxzroLGeJ0u5Fi8REpKphkhDugH318+h0+BJ6IzXVyfdr/T8zOrys3YaVZsOrHfUoxH7fJYI5wqDLZNHaV0uQcD7cYwDHWBY6AIXtj16yJC+YXqOQ2x7XCTErfctcq0YSNMGmP50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eS89OoT9; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eS89OoT9"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65a1970b912so7574989a12.1
        for <linux-spi@vger.kernel.org>; Sun, 15 Feb 2026 05:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771163786; x=1771768586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugmt3MCxrIjqV0vioHLUrf7C9aYPhs8EvgX2Agpkc9Y=;
        b=eS89OoT9Vx2kkjLVVTS3hIY4AlDTOj6VCXdYomhTClj3XnQbnXPgi0Uyb3c1+UMpVt
         GovrosLpTcqc/W8/fa09JVrLB717gA3YJctZLqDBS9tRpmDdBVZjMfwornYBkc0J7bAo
         S+/X0ruxLxA4y4fj2BXG9ldUTRTKOhsLJZVd/GOECJISgCIKMNTga3Ici2W407usLDv/
         1FogGo5FQ1d3LQ62Unmq6zeZ0euSrRcL5C8Jxd1DBWClkUq/F2OipOeWbYSA3XSJavkY
         UEnkyOWcHKtcTy5zBa+MAjku3hc38zm1QpthgQCRj+InksMKdXBmD+bY824waj7ZOUd5
         s9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771163786; x=1771768586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ugmt3MCxrIjqV0vioHLUrf7C9aYPhs8EvgX2Agpkc9Y=;
        b=OOxJZpAmetdPbHyS+jJf8SviyjyDCS17unDrf1voh1l5oCB41CPR9zSFvx9VfLnhmk
         eSj50BVQUuJNUe9botnoDU/h9k8Row7A0aYbz/CoISbvPedPlBQf6s0sVTivyt26lq25
         KJv09LYIloIJL+zf1udDoANKcpE+nmhgW6TexiTlT0DCzT6HfCBdqe/a9ooGcvTnXoRE
         Xon9ssSyTpjzn5badyBJ83CQyeuX8TT6aFk7vWA00mapiDLlFo/TctlWTQqRW2voGdJ+
         lOofTP9s+qSaSsLjGoWSL3oXMEFera139Ic/fkNER2mXWvjyBGhrDWsTucCES9oXL8xA
         Ow2g==
X-Forwarded-Encrypted: i=1; AJvYcCWw97gtbGGhyXgqdBzoZv2Z93G1DjKllu0Q0tj9/zDn7xgjWW36UaQg2Y7kSV9RLHOKILsEhZ+qhfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZxsMDFHAPm10S+f3kx+GpMdi46KThdzNQK4DdW8dHp69vrGF1
	imr89cbNpI5HRwJEZGuYC/7Ds1So0QsdQ3d4mS8SnWYBm+b9B2gcYW/1
X-Gm-Gg: AZuq6aIqk5vZFpUVFSS4SmLDjWMZfDbxY74BPd3U7Ucvf1GdettdLomINX1IC1c7vaz
	ERU29jLC+cZbhsTzE2nxswDKGVEgH7kVyesjMBq1rvN9Y0YnI6JOibPiOOrWCi/zeqdUqAkdLSK
	M48CCqxqx2nUDSYsALV7QXsr+AlZo8Fu5zxRSvXMliz8zW4smHc33u++/5rRuYw4248NdS1J/DS
	fKSQ5K/ZFaIi27uq1ybaBkg2znwl09Z6+r+olFVgZ+RxyjSMYOi2eT/bUkMbhhm7ZrYeO9XbIR0
	r7eEm/Lnd4IZvnARWzNwGx5mKknme4daaojU/xrPHF+V85heAVWQ3ynRaY4A0kC2T9RmxafN/O/
	uie5eCH3OT5B5VmzNLcTu11yshEFJCpjXf4P42iYCJ78CIqVLiZ5AA38WgaRuK4OldCs9lddkNh
	HAjWDef9fRobBs9te4NA/GEw==
X-Received: by 2002:a17:907:6e86:b0:b87:6bb4:9eaa with SMTP id a640c23a62f3a-b8fc0539142mr295546766b.8.1771163785884;
        Sun, 15 Feb 2026 05:56:25 -0800 (PST)
Received: from khalil-hp.home ([62.250.67.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc7626bdbsm164179166b.40.2026.02.15.05.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 05:56:24 -0800 (PST)
From: Khalil <khalilst@gmail.com>
X-Google-Original-From: Khalil <khalil@rentman.nl>
To: broonie@kernel.org,
	hdegoede@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: rf@opensource.cirrus.com,
	linux-spi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khalil Laleh <khalilst@gmail.com>
Subject: [RFC PATCH 2/2] spi: pxa2xx: Handle dynamic clock gating for GPIO chip select devices
Date: Sun, 15 Feb 2026 14:55:24 +0100
Message-ID: <20260215135524.1171065-3-khalil@rentman.nl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260215135524.1171065-1-khalil@rentman.nl>
References: <20260215135524.1171065-1-khalil@rentman.nl>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To: broonie@kernel.org, hdegoede@kernel.org, ilpo.jarvinen@linux.intel.com
Cc: rf@opensource.cirrus.com, linux-spi@vger.kernel.org,
    platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org

On Intel LPSS SPI controllers (Cannon Lake and later), the
cs_clk_stays_gated flag is set, meaning the SPI clock is dynamically
gated based on the native chip select state. When using GPIO chip
select (spi_is_csgpiod() returns true), the native CS register is never
asserted through the normal path, so the SPI clock never runs and all
reads return zeros.

Fix this by handling GPIO chip select devices explicitly in cs_assert
and cs_deassert:

- cs_assert: Assert the native CS in the control register (to enable
  the clock domain) and force the clock gate on via
  LPSS_PRIV_CLOCK_GATE.

- cs_deassert: Deassert the native CS and restore the clock gate to
  auto mode.

The SPI framework handles the actual GPIO toggle; this code only
manages the LPSS clock gating. SPI_CONTROLLER_GPIO_SS must be set on
the controller (done by serial-multi-instantiate) so the framework
calls both the GPIO toggle and this set_cs callback.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221064
Link: https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/2131138
Link: https://github.com/thesofproject/linux/issues/5621
Signed-off-by: Khalil Laleh <khalilst@gmail.com>
---
 drivers/spi/spi-pxa2xx.c | 35 +++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -419,20 +419,43 @@
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
@@ -444,8 +467,22 @@
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
