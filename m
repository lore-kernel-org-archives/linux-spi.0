Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE453DCDAB
	for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544046; cv=none; b=ZR/aszD2PcCxjtAwGqSh1nbKv9N6fbJeU1VdDfC2vnYFBVkuZj4jCqcVmcvFSI9ypsZMIKBecBy8RpG6IelXm20X9dCA+5/FKDRSG17QsR9u0LrDoWmo8f7bxfNJPw/4n2Y05PI2hzSAKqF4RGWJVX9HOpo+xn/52BdXccukcmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544046; c=relaxed/simple;
	bh=KOg2s0aWMbLiGwvJ+2qMJwffalK7t3oBpcm6XVotiHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GUI04ClQKLKwcQF5wQQHT3/AMk5bWfs2TenTwd22nMYvUKmuoJo6CDr2RVOREPT2H+Hyouhj2VKFNLB6atB6oFQ4sXUj2ESdNCT4sPyQdMVytmg2IatNzh3SpgJ0aAWWzdnYqmdrRIOBl92AlA7VOJNI5fRfDDNavs35rRxHjI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cacb8416a1so64189805ad.1
        for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 03:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784544044; x=1785148844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pc9Q17L9G9Tp/hTZeKzZ+mFFZkDIc4OrDplBBsBLoik=;
        b=YgP9asZql5CAU2OUgnWE54z8UcZgAoKhl2LppuIG3r7bet8ArCohidFcfsRSE8SYRF
         vdq4BolY+gufzRlQFMpu1B8OCZXRZ/bjbJwpHlh4j1mOoflQFQKEJVOqk8gfILc5x1+p
         M0VaMQF1wiNlcuOghgJnSv/jChcmibUElcjNbM+eDuDWMjBQHDDWs3kLlvGQ6ofc6A9Y
         bujTUvyx3LQEEGrLgC55hV5kb7IQWBgi6sVMRsW3ab3yRg3JkUFV3d61dOL7y4Ux1vIC
         468t6eyxSqtVDHH5ia0nQ2fzfPYmY3WMIoM/pR5r1uENrV1gCVS14/CgWwSpcV2eMz1E
         QhIw==
X-Forwarded-Encrypted: i=1; AHgh+RpYS2kDYCFIY5umfSkgYFAYjyPeeJnmgSMmM24dWpPwp+fY8DjOUQ5mNj3csVj6mpPRHrXe1qtOg8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHzCdQHxETWXf0Oc5uA/fFrVSQ21s55NLpHgOXrQ/6wWaxuSwp
	69XsCCZX3bRaHOq/j1xkn97+GxMcy0TFXDolvcnXue8VFqGkGy839+Y=
X-Gm-Gg: AfdE7ckXuaXJEwo1/9r8ju6KA8X6f2FWRoAHqneX0IjsiJ6zah5Qi+1yWWJxOAeM3AT
	hXccW+MyrBHnmkAHwcISgB8xe2PIurHS8+vCeNi9jZjA9uFIShpx98c1gt1QzWYpm0USMKjyHrW
	FnVUNSusrJIp6YJyyd94Fohwjrp7fxALmZlmR4w5Ph4Pf9nZ4B6FD0iQo6A4AnDM0IkVeEyv/6o
	XwkLpFzp/I4RjyrY0K+xH1VxmeFp9an6/Yvt40psi14zxCoZ48zN4VL8wD8f+lMf1KRaUfMrEH0
	sfTt2W7AIztQHLjrujCLMy6B3RFNlDGsRHBsSbd8s4tt6PJ4++UyFNR0CYUuCPF1GiSzp65N3Td
	VxuBj4hC8u85eqjqkGyXxywSHAQ583O1OHq88HX3N/5WmsVOERKPrTrnYwTcdGPy/qlW3A3PPyh
	C+IedJsE8KNpqes6AsrSDyc5o0OqzEWm1PyB+xljFmLNHCvuwPDzvuvS8L1IvJyYa7Px3sc08qA
	dhUB6JvT4Iv6N5u8Het77Unr5F+
X-Received: by 2002:a17:903:3c46:b0:2c9:97a8:afef with SMTP id d9443c01a7336-2cf349f4a51mr134654595ad.40.1784544043870;
        Mon, 20 Jul 2026 03:40:43 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-16-100.dynamic-ip.hinet.net. [61.228.16.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344f61ffsm54900325ad.33.2026.07.20.03.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:40:43 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v15 4/7] spi: pxa2xx: lock out runtime autosuspend for Intel LPSS SPI in PIO mode
Date: Mon, 20 Jul 2026 18:40:26 +0800
Message-Id: <20260720104029.13740-5-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260720104029.13740-1-fourdollars@debian.org>
References: <20260720104029.13740-1-fourdollars@debian.org>
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
pm_runtime_put_sync() in pxa2xx_spi_remove() to ensure the runtime PM state
machine transitions to RPM_SUSPENDED upon driver unbind, preventing active
child count leaks on the parent LPSS power domain.

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 64b5ec744756..88ed28096b07 100644
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
@@ -1513,6 +1516,8 @@ void pxa2xx_spi_remove(struct device *dev)
 	/* Release DMA */
 	if (drv_data->controller_info->enable_dma)
 		pxa2xx_spi_dma_release(drv_data);
+	else if (is_lpss_ssp(drv_data))
+		pm_runtime_put_sync(dev);
 }
 EXPORT_SYMBOL_NS_GPL(pxa2xx_spi_remove, "SPI_PXA2xx");
 
-- 
2.39.5

