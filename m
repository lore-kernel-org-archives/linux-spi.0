Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096706;
	b=hVRPhUHjMIgmeDAbEsII2wrzerFcw4KiqqB2/HXTdy0eP88d7hJFqKUUCyGfC5e/br30
	 Ys2d24ANupJ1ezdGNsX6FpTnb6SbQA1U8/2IpqbyjmVvu3mJBxJ+kT1BRoOpWgexwr0tX
	 5qltCdN+z1D3Jj6GyuVQoBhydNF8YKKUzs7ae00A7nrdQKusq4+qGqjlWpgVfkejTTLql
	 rUG2QQhVCM86egvnQ6XHt/SVc6nYah6dN5sacnRY1fNJ/n0vygRwvneL6UXLSYdW7O7y7
	 vfRkScLX5RsYXLp4iA2/ClInPoxnubXw3dQ8Y8ItwrPYJeuXQoTC9ibCuBbw5HhXLHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096706;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7d2Kk7WcyF8PRkP72zbhRGMkbN0Tb+b+QibWkFY2CgE=;
	b=toewL8fxdJQGu4QOW/f9lQ1RurbvbjnrRR3IIXMfh1opAXOaH6rUuZarodaEJByCcRjj
	 Wjjo8qPrjMGcpjul3hixDWmWkGy6SoUfGI5lLw+GKNk3Igqonc1atBxct3c8Nhw2xcr3K
	 7DdWltYrCz4Xcj7F510SU1oQvACWVe6dMQprGY1gTjqBuGRO6lTrJQHY261PaxlG8M9us
	 L5KVaCHdW0BUrD7odWKPUTxgEkcU6CEpyRGObXIOsm6QgV7x+pBU0WJIz1VRhGSD96vtZ
	 6VnodeViIaFPFbWuav95kY6UoAK3MvRZ+DnK5+WHJqC5SXUkvKpQO0oHd0h2jSpl4fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=N3cJTdKy;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D95606A32A
	for <linux-spi@vger.kernel.org>; Thu, 19 Nov 2026 13:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44D95606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=N3cJTdKy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=7d2Kk7WcyF8PRkP72zbhRGMkbN0Tb+b+QibWkFY2CgE=; b=N3cJTdKy6IMcl2NcMZXMfS08Ul
	mfH1xM/q6PPSgZ9I6LIGHpYjuZQkFWRz02xZq/KJyqivipYk4W+aUC8MSO5d9DVCvjZ0zS7euxgp5
	UNUw26+sVBrTkNCUU9lD8GISFqdaXtpg4zvFk2n2UADIaC9HbYM5Cy0wEx6AaurkY4PUlFP9Ur2fI
	aI2p0JvNP9NM2TvV34cjaf8XSeTcK9axhywJ67pFsRFwk/6amjHhMEE1aZsydgE9dksF30Cp9/KXd
	t9/6I7RI88//kefaq7jnBD8kVaNtZrfzL5z2PqetlAdJYdvC29Y5F/N90v+BwV926Dn5Kt5yQysx8
	5X0Ik+Pg==;
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
Subject: [PATCH v4 1/6] spi: Allow spi_toggle_csgpiod() to get called from atomic contexts
Date: Thu, 19 Nov 2026 14:58:03 +0100
Message-ID: <20261119135808.2377849-2-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119135808.2377849-1-heiko@sntech.de>
References: <20261119135808.2377849-1-heiko@sntech.de>
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
index a6a9aaa47fde..5e05f2fef12e 100644
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

