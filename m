Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE7C498927;
	Mon, 21 Sep 2026 21:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790026320; cv=none; b=KS833S29mLXN2YGwInGq5/JsOzSBcmOx/R2GEu3cXabjkYsWdyiYbPo4X+ekcY7qIUFen2d9PiOlt8G3cMYlsOnDAgTGm3w3alkU+Djgg+CoQxrs678yJBcUGvuWYgbcxVJ0x3NhQNaJvHnKOjGwufz+DKonppG0+Yzbayx+i2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790026320; c=relaxed/simple;
	bh=4/7ifftO7BtFre91KUtvd6K52EbnXHCwS+kv1JN4BWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gVFbsRRH6l1jAYtmATimBbUpv0hAcv5iNzxu7Nepvl296uzD4hdewSWu2m76q5eVenzeBjnApaNmgFMxkPtRfeV5032ol2fd87P6rwW3fYRBpzaM7W/Zr11zPBUynWD7HMfeerKAJw6TPIG86I87vX777bf/S0LhTMHmQ2vg97k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jonasjelonek.de; spf=pass smtp.mailfrom=jonasjelonek.de; dkim=pass (2048-bit key) header.d=jonasjelonek.de header.i=jonas@jonasjelonek.de header.b=JhAeewR1; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jonasjelonek.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonasjelonek.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jonasjelonek.de header.i=jonas@jonasjelonek.de header.b="JhAeewR1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jonasjelonek.de;
	s=s1-ionos; t=1790026309; x=1790631109; i=jonas@jonasjelonek.de;
	bh=4GMPeFnbewgPf6tJvZkZFc6PNc1xlPW1ttSPBRO8m4o=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JhAeewR1L1MqFD7VMo+g2yYzsJo0zEeO2E5f5h6yMk84PYuuK0CE3VtuGZSQRfBq
	 3WwC2ows5/iN7oMb2VjNljg5wSQYYHDmgMoTwXJSBMHyuOCef/BSwR4BxQdv+Tq9H
	 91THS55/MlZvcfP5zo+mB51pzDKVlt6CWs4o/cnQVmDgTTruykgk/StQhhzf04cam
	 8CaVlawsu5RMwWycaOEGmU8ndKghivZfYGJrf6d07o4NAtJ1uXCp8b8inEr2CcwFA
	 MR9uZa+nrSHwOxEqArESBqEGfOSU3bZdjrUWZmRINy4gjKY5xOGxYcNHFF1Giwm6k
	 pK3M1YQs8nenYWlW6g==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue109
 [213.165.67.113]) with ESMTPSA (Nemesis) id 1MwQKp-1wrviS2MMf-017mFr; Mon, 21
 Sep 2026 23:31:49 +0200
From: Jonas Jelonek <jonas@jonasjelonek.de>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonas Jelonek <jonas@jonasjelonek.de>
Subject: [PATCH v2] spi: realtek-rtl: add support for second CS
Date: Mon, 21 Sep 2026 21:31:45 +0000
Message-ID: <20260921213145.671282-1-jonas@jonasjelonek.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m5sBGLQVZKWrtbJouOAIGYDd1adOEiXSPimKYni4hKF+yRxoN9E
 V8/GdUr/owE6Ih0mmxrrs9gmubbR/hlFYwuGk2XfKCk2ZQPFcPBEr0oK79a36PL0e5cAv1G
 o/I8o1pzuCnJqw6h40xBr8UaKwF5J0GjFN2OqhmdB+X4PhxDMIchqp48cAD6yC14q3saTiy
 /4ogKHKvLWHd8xwVNr4bA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dMdk5XjD+As=;dMhPeYyV7wy3sw+BlBAmRSZcODn
 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

The initial driver assumed that the controller's second chip select was
vestigial because none of the devices examined at the time used it. This
does not hold for all hardware: there are devices with a peripheral
connected to CS1. Since the controller only advertises one chip select
and keeps CS1 permanently deasserted, those peripherals cannot be used.

Advertise both native chip selects and select the appropriate CSBx bit in
->set_cs(). Build the initial SFCSR control value from zero. The
datasheet specifies CHIP_SEL for MMIO mode only, so keep it clear for
this PIO driver and set only the two active-low CSB bits to leave both
lines deasserted.

Rename the callback argument from "active" to "level" while touching this
code. ->set_cs() receives the physical line level, not a logical assertion
state: after applying SPI_CS_HIGH, the core passes false to drive the line
low and true to drive it high. The CSBx bits directly encode that level,
and the native outputs are active-low, so clear the selected bit for a
low/asserted line and set it for a high/deasserted line.

Signed-off-by: Jonas Jelonek <jonas@jonasjelonek.de>
=2D--
 drivers/spi/spi-realtek-rtl.c | 36 +++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-realtek-rtl.c b/drivers/spi/spi-realtek-rtl.c
index e1c40ff2e49d..7b250b447abf 100644
=2D-- a/drivers/spi/spi-realtek-rtl.c
+++ b/drivers/spi/spi-realtek-rtl.c
@@ -18,7 +18,6 @@ struct rtspi {
 #define RTL_SPI_SFCSR_CSB0		BIT(31)
 #define RTL_SPI_SFCSR_CSB1		BIT(30)
 #define RTL_SPI_SFCSR_RDY		BIT(27)
-#define RTL_SPI_SFCSR_CS		BIT(24)
 #define RTL_SPI_SFCSR_LEN_MASK		~(0x03 << 28)
 #define RTL_SPI_SFCSR_LEN1		(0x00 << 28)
 #define RTL_SPI_SFCSR_LEN4		(0x03 << 28)
@@ -29,17 +28,31 @@ struct rtspi {
 #define REG(x)		(rtspi->base + x)
=20
=20
-static void rt_set_cs(struct spi_device *spi, bool active)
+static void rt_set_cs(struct spi_device *spi, bool level)
 {
 	struct rtspi *rtspi =3D spi_controller_get_devdata(spi->controller);
-	u32 value;
+	unsigned int cs =3D spi_get_chipselect(spi, 0);
+	u32 cs_mask, value;
+
+	switch (cs) {
+	case 0:
+		cs_mask =3D RTL_SPI_SFCSR_CSB0;
+		break;
+	case 1:
+		cs_mask =3D RTL_SPI_SFCSR_CSB1;
+		break;
+	default:
+		return;
+	}
=20
-	/* CS0 bit is active low */
 	value =3D __raw_readl(REG(RTL_SPI_SFCSR));
-	if (active)
-		value |=3D RTL_SPI_SFCSR_CSB0;
+
+	/* CSBx is active low */
+	if (level)
+		value |=3D cs_mask;
 	else
-		value &=3D ~RTL_SPI_SFCSR_CSB0;
+		value &=3D ~cs_mask;
+
 	__raw_writel(value, REG(RTL_SPI_SFCSR));
 }
=20
@@ -138,11 +151,9 @@ static void init_hw(struct rtspi *rtspi)
 	value |=3D RTL_SPI_SFCR_RBO | RTL_SPI_SFCR_WBO;
 	__raw_writel(value, REG(RTL_SPI_SFCR));
=20
-	value =3D __raw_readl(REG(RTL_SPI_SFCSR));
-	/* Permanently disable CS1, since it's never used */
-	value |=3D RTL_SPI_SFCSR_CSB1;
-	/* Select CS0 for use */
-	value &=3D RTL_SPI_SFCSR_CS;
+	/* CHIP_SEL is only used in MMIO mode; CSB0/CSB1 are active low. */
+	value =3D 0;
+	value |=3D RTL_SPI_SFCSR_CSB0 | RTL_SPI_SFCSR_CSB1;
 	__raw_writel(value, REG(RTL_SPI_SFCSR));
 }
=20
@@ -171,6 +182,7 @@ static int realtek_rtl_spi_probe(struct platform_devic=
e *pdev)
 	ctrl->flags =3D SPI_CONTROLLER_HALF_DUPLEX;
 	ctrl->set_cs =3D rt_set_cs;
 	ctrl->transfer_one =3D transfer_one;
+	ctrl->num_chipselect =3D 2;
=20
 	err =3D devm_spi_register_controller(&pdev->dev, ctrl);
 	if (err) {

base-commit: 531c719eaeff3ee12af85ccd259f60846214074c
=2D-=20
2.53.0

