Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E2B43C7D6
	for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564495; cv=none; b=bsjNYT+yB6tGQwgP9BCoObuxEyQ30aJgEhWTcKFcHEBMpUWdj5rjLkNBxLxjfAiY8hfGXwBWNbWhAGzkRqnARL6hWNY+12z6dZby9d+RdeD/vHnSXlbW/3mXB/cIRCIg5gBWdUnITdw9/fFpn6wIZLJHM1EpoQvUbbFJrjihPW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564495; c=relaxed/simple;
	bh=UVo5c4lR5R7fmIYod3yy0OHjJHPgUxAKWu1/O3B+npo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kzg4Lsex0zgvwV3k1sdWdflZplcS+Nuz2XnawcP07X4i0vRfKerq70ttqVR0drbcvIXKJuhtdd2+EY15KsbC7wjKcRPG1aQhoitUA/XWaQxATwXt1AH6inqYQRcHEu0awwRCsQGBlwpVZ1mE7VahZjr7UWTRzX+M4jtc8uoNPps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cee9b74ee1so63493705ad.3
        for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 09:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784564493; x=1785169293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aLETP574W//JLh+FTkzjcKwtbtDnoO3wAXCceho0s4c=;
        b=ljrbLgZRqE7pQgccLNllO5zHZodSpNTlJU9c+8Eot+rD1aIN8wczmcETUtLErnuPys
         /iyzYBGaa/868DfHbIsenAd03ozGA1tZe4e6XBqAToz/prUXNisuXr2MuLY6vO5ZozLe
         X9jWQFhPEamhtpdsef1UwgFY4RZe4OLvDJFO9x1VGzM9STUGpVWpQ3fC8MYkC9crVzqQ
         gLM8h3VTvyQgYTWGFTYtKwmkhMJgEZsAf7fPe8OK5OWfFs+TsWjh66/uWRWt2kH1d3wl
         snjkEabgd7DNZWGMgPotu74+4EV3VF2funi/xGaeJaTMKXj2EgXrAIrqjINaXsZzwT3d
         xCYQ==
X-Forwarded-Encrypted: i=1; AHgh+RqJZFTv7OuAlgLIA/Eyv7iQNWWLs6m7ORW5sk4oykch+Ma7Fe7qvR7YLj78zbqO3V7SUKvkj/A0c+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0B05RHIQ9iev9rY3cl5rvp7LrKUizzRVnK0Q8vs/toZC+uIIy
	4PfVcPacf9nERSRy/B5y59i8LaN8bIE7GEWBl9N5sb38uig2XLUiFFw=
X-Gm-Gg: AR+sD13rHTEPWwf1ePGqfulwf49NFCG9H+fi9JOzpLb7lENWJGgMsa9FEX8dK1mO4Mo
	3AQrRnKF9riXhiSyNcqM07AeD1nx+p8O0NWC3eyzaPxutq0HdjnNOZH6hLIYnkqMUNs0Z0m9rI+
	rrlXqalk7S7y8LilRKYyXBlq6x0ud3ON9rghKFGI4sJALU8e2HeqkdzHpQjUYK9oZDXcQE/ZAuB
	Smu4s8TdMB3sdqOgS57x+2niU+ChIbBuWLd5MTBSwuytr186JJgeB5uWf/x0DFtRKIVgvPWzqe0
	Ab/JtwGVBcZsNppNjhzDEcvI7kBw/w3z9ZlGwEiUKJECf9ISyh92TmGHh/6tubVJEQLjNkdIixP
	8vflDRTUuzXm5T5kiguR7+abWINaXOxoX4KFpVfaRV8Hwl4yrRXs+Xd0v/unD1sKYZ0OES1mkJH
	JcxlXgg7tyUZ5ytKLoIdu/Rbm9JUXK81rys9lNSbS+8SOZdfHLRbQR2+MIdivPP8fm11AOAhqX3
	kYpVOYmPohB0T7Oa2tnsCG8c7YS
X-Received: by 2002:a17:902:fdae:b0:2ca:ecf6:910e with SMTP id d9443c01a7336-2cf3466a93fmr166932475ad.0.1784564493132;
        Mon, 20 Jul 2026 09:21:33 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-16-100.dynamic-ip.hinet.net. [61.228.16.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3479463bsm58467385ad.80.2026.07.20.09.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:21:32 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v16 4/7] spi: pxa2xx: lock out runtime autosuspend for Intel LPSS SPI in PIO mode
Date: Tue, 21 Jul 2026 00:21:13 +0800
Message-Id: <20260720162117.32304-5-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260720162117.32304-1-fourdollars@debian.org>
References: <20260720162117.32304-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When operating in PIO mode on Intel LPSS SPI controllers, runtime PM
autosuspend clock-gates the hardware block when idle. On subsequent
transfers, MMIO accesses to trigger resume are performed before the runtime
PM state machine can wake the controller, causing PCIe Completion Timeouts.
This issue does not affect DMA mode, where the DMA engine holds the required
resources, nor does it affect non-LPSS controllers.

Lock out runtime PM autosuspend for LPSS SPI controllers specifically
when operating in PIO mode.

Acquire a runtime PM reference via pm_runtime_get_noresume() in
pxa2xx_spi_probe() after registration, and release it via
pm_runtime_put_noidle() in pxa2xx_spi_remove() before hardware teardown to
ensure the runtime PM reference held in probe is released without invoking
runtime_suspend on already-unclocked hardware.

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 6bfd3382acc3..34241a6742eb 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1473,6 +1473,9 @@ int pxa2xx_spi_probe(struct device *dev, struct ssp_device *ssp,
 		goto out_error_irq_alloc;
 	}
 
+	if (is_lpss_ssp(drv_data) && !platform_info->enable_dma)
+		pm_runtime_get_noresume(dev);
+
 	return status;
 
 out_error_irq_alloc:
@@ -1495,6 +1498,13 @@ void pxa2xx_spi_remove(struct device *dev)
 
 	spi_unregister_controller(drv_data->controller);
 
+	/* Release the PM reference held in probe for LPSS PIO mode before
+	 * hardware teardown so the PM core does not invoke runtime_suspend
+	 * on already-unclocked hardware.
+	 */
+	if (is_lpss_ssp(drv_data) && !drv_data->controller_info->enable_dma)
+		pm_runtime_put_noidle(dev);
+
 	/* Disable SSP interrupt generation on hardware level while clock is active */
 	pxa2xx_spi_off(drv_data);
 
-- 
2.39.5

