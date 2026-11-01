Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793563318;
	b=OsaJwdP3QaczlECYndKpIam8qQot0S1AnNTXl1CFVCW61dEOtWKHBkaIKm+YoNwf8GVc
	 cCYNENHahIJUKVsDCynTNoP5aS4PhZRqg2oGUKTNF/eUkBed37WCwgzXH3r1LJSwytauC
	 rbtwPJFZ+z/8mmGLAazjc2CvLSwNx+fNZ59fvzCHb2lTGG/rZKThrG1kQFgpf6/SbaikM
	 8PiGw8myyuTXW/Pzx5MgGuUI1qOy5NY/vuJTgN8SzzwbT4BNACZYUfYeiEek8ks/KTySY
	 xlLYbnN0SCKi+dMao7QGIEGpYP4d97Q+vgfHJ0I8FQ2PCeOa6GnE1N3FX3NMqRzNvhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793563318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=z/VKI7RpLJNOxCKazePUIRScOgx02AgC8jGvZ4BHeOw=;
	b=Qyd2stP860VH3iz0nZe0ZZElQ/DtFSVY4V2l++dH/GspPa63ceTF+sK8x8hWvGDf/YkM
	 VFIlk8rF8HtTz/K4Ea8ddFkT9QiJ1mXMN+covzZv4+cwQfau1ELd/x7Byjqtj4A8RxIwM
	 /lNQAKP+budtng7pd6sCFjwIPh0hBdEa2ObG6Nwl3grrBoqmYvQf1JddiDUn9pFHkNy0u
	 TxYAbyDhT3y8qU1e1q9oIzBYXPIRZVwL31MmqCeDjjkDy7hs8xDv2ZBx0pptJ1O4WTSVY
	 X/+iXC6O99wfhC/GjvbmFMLbRkLpSoS5DNwkzD2lq/lxEm+YsDPwuiH82GoMeJpa7VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zvbi1YUQ;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD04606A325
	for <linux-spi@vger.kernel.org>; Sun,  1 Nov 2026 20:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DD04606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zvbi1YUQ
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-18cdcfc05ffso2641880c88.1
        for <linux-spi@vger.kernel.org>; Sun, 01 Nov 2026 12:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793563318; x=1794168118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z/VKI7RpLJNOxCKazePUIRScOgx02AgC8jGvZ4BHeOw=;
        b=zvbi1YUQQ7aVWRUMLEDhhyHBLdyqiN4nI5hVMkMqE1W5UV/BN7B/1lPeV0+RClu5pe
         sTNdCZk2+jO4OLZqsjXB4W/Dezxb5/tsjn5PBf2I2inKfFzcs9M8KTS+i18C+1Ej2wjY
         kubKMurAl9Y1XFIAXcNIfE1mgEgh3Qk1v+D2lvd2bKBNHkYjwHExxdhTD+C7skmlUwwS
         g+hW7vQG1QCdCjItKVr7YU521PgeKVZTBAfAIjG8ApoHn7DTXBDld/+vKrTzv3qauUym
         uNHUvJh9an8WWMcfC4nm+gQ2DUsmzUIZh/eUsM2rt/mQtlypk+7dWKo1pFxZjdxiCUVC
         rG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793563318; x=1794168118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z/VKI7RpLJNOxCKazePUIRScOgx02AgC8jGvZ4BHeOw=;
        b=C+hibjl9zNwnJJsEmJZP5/6NfDD7cjbLTDuxgmqiXloZNhqnWQGHmUQ4nLfG6sPt3+
         fvTbWXqb+BoRtXLId0ONShP+qabNXVjVTmFE5xUbN9uAet3MveJu+VqK4FnFqCjLPzXJ
         YbmxjMr21BNgK9PEDwGRYlOnTQ7Fsq73weTSR0Zj4f6Neox5TvK1/iLQMMtLvPCWXADM
         cHnWuU+TPlB7dgfJG6BFwQSxDdWuPGrXDQQmSJGnwZozvem2J2JU9JWyxR1gJdRdbGyu
         XlmJvYJZwOVRnTWLKsyZlGp0wMK9XIvzPgXQFtctAcC4h/usKLxFgPwNn3wZwcOumIz6
         gDXg==
X-Gm-Message-State: AFq9FYKBg2GFS6EVgEIzcjhaqOytHExQ7LeSXLqdLulFbZRKfq2iVRHN
	Zcm3Dxy5W20LSQDr7IVm4uzpUiF062ZosoKDRgMhjk30VaHd7tda2AksCiXGUA==
X-Gm-Gg: AYBFou1A++s1GeDgcdKS/7b0SLoou25C58FUp8sBf+1DZDu7gGL34omWfI/RHxQZn3O
	inizaSUkyn4fLZoiM+CSxUqxlTKTjttOBRX0o5TDAQUpaqPjZ8LOr7KTHK4c2b3Jv73JXoC8L54
	xwiOa/gIeypRkF3En4cCAdKsyMmKhcdrMKu1NPUPW1WgddhCGtgN7mL5TMtN2Gpb86Zen5lQu2O
	lMW6Lpb7cFtaF9cSpmt2tP2u+N84o+f9NLFCUp64662ZDAoEzCg3hMImpKH/iQbWl5IKSPLVULX
	6b3CqPcbwxxMgOWSsNdGNrcois39Ovyeu32UUfyI+urTZ4knSIeN3KJy1fkORcOisFl+b74MRCW
	bhoZIJVaqsQXw4L5W7Ua8R5mhiy13Re7nu4lzcKoL7mYDEWB2t2Q2nrl77UuGH00RMNlFs2J8jW
	sm3FLhXT7ET3AM2oezxKj7euM+/rWTgrbPr8uaHRBEPU+ccFHEyql5JaJjXtA6MJwizGb1mDs5P
	8KkkFEc5bu1yG7Haxeu9eb/0mmaGfgQKb60yt/6c2cssLyWEhEOLuxr4/LQRYlMKC4jItCYR8Ip
	GmZ22k4KwPcfFixkMiKoO+KaV1Ku4WIRBERWIY7PEog2xDOxCHIUDmxe1YLLZtvYnKFafWY3Eec
	1p4nIAK+GpsV9vsP1ah/O5Kzht6sV1zOdu+xCfKUm5OY8maEq8tJsfqSvlnTm6OOtbzgRltvMJj
	Nz3A==
X-Received: by 2002:a05:7022:3f04:b0:19f:527d:96da with SMTP id a92af1059eb24-1ac5da7b145mr11824196c88.33.1793563317369;
        Sun, 01 Nov 2026 12:01:57 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1b38ac58sm26633510c88.23.2026.11.01.12.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 12:01:56 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] spi: acpi: only look up the IRQ of confirmed SPI devices
Date: Sun,  1 Nov 2026 12:01:55 -0800
Message-ID: <20261101200155.15740-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
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

When an SPI controller is registered, acpi_register_spi_device() is
called for every present ACPI device in the namespace and
acpi_spi_device_alloc() walks each device's _CRS. While doing so,
acpi_spi_add_resource() converts the first interrupt resource it finds,
even for devices that have no SpiSerialBus resource at all and are
discarded right afterwards. Converting an interrupt resource registers
its GSI, so this maps IRQs for arbitrary unrelated ACPI devices.

On a Dell Precision M4800 (Lynx Point, 24-pin IOAPIC) the DSDT reports
Haswell-ULT LPSS child devices (\_SB.PCI0.I2C0.ACD0 and
\_SB.PCI0.SDHC.WI01) as present with interrupts on GSI 37 and 38.
Registering the intel-spi controller then results in:

  ERROR: Unable to locate IOAPIC for GSI 37
  ERROR: Unable to locate IOAPIC for GSI 38

Do what the I2C core does and only parse the interrupt resource once the
device has been identified as an SPI device on this controller.

Fixes: 4c3c59544f33 ("spi/acpi: enumerate all SPI slaves in the namespace")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/spi/spi.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 40cda0037ea5..5a2cbebfabc5 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2995,7 +2995,6 @@ struct acpi_spi_lookup {
 	acpi_handle		device_handle;
 	u32			max_speed_hz;
 	u32			mode;
-	int			irq;
 	u8			bits_per_word;
 	u8			chip_select;
 	int			n;
@@ -3138,17 +3137,25 @@ static int acpi_spi_add_resource(struct acpi_resource *ares, void *data)
 			if (sb->device_polarity == ACPI_SPI_ACTIVE_HIGH)
 				lookup->mode |= SPI_CS_HIGH;
 		}
-	} else if (lookup->irq < 0) {
-		struct resource r;
-
-		if (acpi_dev_resource_interrupt(ares, 0, &r))
-			lookup->irq = r.start;
 	}
 
 	/* Always tell the ACPI core to skip this resource */
 	return 1;
 }
 
+static int acpi_spi_add_irq_resource(struct acpi_resource *ares, void *data)
+{
+	int *irq = data;
+	struct resource r;
+
+	if (*irq < 0 && ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS &&
+	    acpi_dev_resource_interrupt(ares, 0, &r))
+		*irq = r.start;
+
+	/* Always tell the ACPI core to skip this resource */
+	return 1;
+}
+
 /**
  * acpi_spi_device_alloc - Allocate a spi device, and fill it in with ACPI information
  * @ctlr: controller to which the spi device belongs
@@ -3173,6 +3180,7 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 	struct list_head resource_list;
 	struct acpi_spi_lookup lookup = {};
 	struct spi_device *spi;
+	int irq = -1;
 	int ret;
 
 	if (!ctlr && index == -1)
@@ -3180,7 +3188,6 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 
 	lookup.ctlr		= ctlr;
 	lookup.device_handle	= acpi_device_handle(adev);
-	lookup.irq		= -1;
 	lookup.index		= index;
 	lookup.n		= 0;
 
@@ -3203,6 +3210,19 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 	if (!lookup.max_speed_hz)
 		return ERR_PTR(-ENODEV);
 
+	/*
+	 * Only look up the IRQ once we know this is an SPI device for us.
+	 * Parsing an interrupt resource maps its GSI, which must not be done
+	 * for every unrelated ACPI device walked during enumeration.
+	 */
+	INIT_LIST_HEAD(&resource_list);
+	ret = acpi_dev_get_resources(adev, &resource_list,
+				     acpi_spi_add_irq_resource, &irq);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	acpi_dev_free_resource_list(&resource_list);
+
 	spi = spi_alloc_device(lookup.ctlr);
 	if (!spi) {
 		dev_err(&lookup.ctlr->dev, "failed to allocate SPI device for %s\n",
@@ -3215,7 +3235,7 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 	ACPI_COMPANION_SET(&spi->dev, adev);
 	spi->max_speed_hz	= lookup.max_speed_hz;
 	spi->mode		|= lookup.mode;
-	spi->irq		= lookup.irq;
+	spi->irq		= irq;
 	spi->bits_per_word	= lookup.bits_per_word;
 	/*
 	 * By default spi->chip_select[0] will hold the physical CS number,
-- 
2.56.0

