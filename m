Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959454;
	b=QzeOIed478Zr0f6NzU2cPc9QMFgFv+CTz2mdwPV2Mf5KgiRRfutXqlFbLNf4/2e0hMqN
	 qRFrzxULL6z8tZ7MHMy9n3CAD/sGSe53hI2OamaxwMvEtahMDEcVU8RrV+sOBtqRI/hcw
	 WmWrHeCttXGUjlOYTLae/ZrxaaFAyBy7gsyOQxk/2wJSxou17ZOnNE3I3Fz+qMWAFwOOL
	 1ejG4uqvaobD4PBMapFrHQSDpHbSLJxIYk2uS6GklG4/UvSk2mGLHiZNfES4uPdmDP9QF
	 FJcFnY3DcooWgLd6eFcPk3jmxRFfE7OiN12E26a0K3vRrXJG6S5syuLspAhZ9tyP0Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959454;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Zyn/wsIyYQl6Eky8acJOO+NdFIpJN2qVmm8YCLh3DuM=;
	b=d4SeoSiICWqxHewlCfiurB7GaJtkFqN4XCLpAt7S8+ddbZYmDL2aB+DszwmS60tfzYni
	 VrKBLHMcGTUbnHUOadqqwJKRW8UbACfpda+uxJPY7LhPiItS3cAQb1dHjp3GgO5H7TdYF
	 /RW0BJsaLEOqauVomHefZAFOf8pibZf3e9yvj0jU/EG3rSbFn7JvcrUp8jp73MPVHxssF
	 G8b0YPpQ1l7gPShGNEufmIntLE/PK9F7YIcn4P75863xKZwqEe9gpKwJ19HaAP89T5RhL
	 leA8ikbDau2oggvUIrH1ukzUi4+i6qaAHGV8duYl65ZagWtBnMunX4aC2z0SPD+KkrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=dSziFeNg;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB9F606A330
	for <linux-spi@vger.kernel.org>; Tue, 17 Nov 2026 23:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DB9F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=dSziFeNg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=Zyn/wsIyYQl6Eky8acJOO+NdFIpJN2qVmm8YCLh3DuM=; b=dSziFeNg76MA4AKj//A3RRR61i
	6/wuPkqr/DSUjCTHVtSQPpGk+Ecjc1MUu2XLRePkRE5obgPVnHD5Ve75egqQK5lp76vu6eJaCpL9Q
	JI2hsXyAUYlbwbs7C7iRZUrcgOssgedHRe7RxZcqHbsCEvSxNPCZxkJpsuFW8nZlnOUPASk8BO+9F
	uW1rpn32jsYXamLJdwjbzZUNOX1M8RtPIix96IlI7+58jT/j987rnqKcLonJ1y/gRyri2fAMv30Vp
	Kw5D/AfctkxbUdnyQbsg+jBxH/YVB/UOc1UvFRCWWh5Ksk813ZlgxBl0jTi5X8ipgsLymjj/bHgbz
	nWzvh/yw==;
From: Heiko Stuebner <heiko@sntech.de>
To: broonie@kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	quentin.schulz@cherry.de,
	Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v3 1/7] spi: Allow spi_toggle_csgpiod() to get called from atomic contexts
Date: Wed, 18 Nov 2026 00:50:15 +0100
Message-ID: <20261117235021.2013719-2-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117235021.2013719-1-heiko@sntech.de>
References: <20261117235021.2013719-1-heiko@sntech.de>
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

From: Heiko Stuebner <heiko.stuebner@cherry.de>

spi_toggle_csgpiod() by default allows for sleeping gpio controllers.
In the upcoming atomic mode for late stage systems,

So determine which stage the system is at and select an appropriate
gpio_set_value function to use.

If for whatever reason a sleeping gpio controller is combined with
an atomic operation using a gpio-chipselect, this will cause a warning.

This also introduces a helper spi_in_atomic() to determine when that is
the case. While the upcoming atomic transfer should really only be used
during late system states, this helper just makes sure to distinguish
between sleeping / non-sleeping.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/spi/spi.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 40cda0037ea5..3aeee3b11c0c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1244,8 +1244,18 @@ static inline bool spi_is_last_cs(struct spi_device *spi)
 	return last;
 }
 
+/* Check if sleeping is allowed */
+static inline bool spi_in_atomic(void)
+{
+	return IS_ENABLED(CONFIG_PREEMPT_COUNT) ? !preemptible() : irqs_disabled();
+}
+
 static void spi_toggle_csgpiod(struct spi_device *spi, u8 idx, bool enable, bool activate)
 {
+	/* Will complain if atomic transfer is combined with sleeping gpio */
+	int (*gpio_func)(struct gpio_desc *desc, int value) =
+		spi_in_atomic() ? gpiod_set_value : gpiod_set_value_cansleep;
+
 	/*
 	 * Historically ACPI has no means of the GPIO polarity and
 	 * thus the SPISerialBus() resource defines it on the per-chip
@@ -1257,10 +1267,10 @@ static void spi_toggle_csgpiod(struct spi_device *spi, u8 idx, bool enable, bool
 	 * into account.
 	 */
 	if (is_acpi_device_node(dev_fwnode(&spi->dev)))
-		gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx), !enable);
+		gpio_func(spi_get_csgpiod(spi, idx), !enable);
 	else
 		/* Polarity handled by GPIO library */
-		gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx), activate);
+		gpio_func(spi_get_csgpiod(spi, idx), activate);
 
 	if (activate)
 		spi_delay_exec(&spi->cs_setup, NULL);
-- 
2.53.0

