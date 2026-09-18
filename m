Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A85522F16;
	Fri, 18 Sep 2026 21:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789768083; cv=none; b=T2GZWeriNHOsTRWA85bVwnWeWBhXikwcnJApqrtWahHJDzWPy9rIjVUTYh7sDGiabEzAYApk071CpMlUn7P9YbfdB3FSAObw7wR/Oq8AQma/erQxIRIuXO21uJjOdOmmIDyOrMycaFTnQ8CAIA9WXDnOvIMldEDrRY+QE4i2g7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789768083; c=relaxed/simple;
	bh=r+rlZbnVTkZtEzkyNXYT5X/0OBwBcCegKmOad6J5sCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u+ylDF5sWBJZTsmD3Kcnr6a3wfZFk3XgZ3/9RBlaSo5wzcI1XHVYyZL/j9eCbsubllP6EPrF5plubKwUJ623ZMXyEv2y/uHUBkVogy3NNz6Ze9thi3AeaTU9Gcad6Qp26aPU95Be7AMo2m01fJ9i+s7YRG7KnwRke8RDsrI8gT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jonasjelonek.de; spf=pass smtp.mailfrom=jonasjelonek.de; dkim=pass (2048-bit key) header.d=jonasjelonek.de header.i=jonas@jonasjelonek.de header.b=uX2BmkmL; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jonasjelonek.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonasjelonek.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jonasjelonek.de header.i=jonas@jonasjelonek.de header.b="uX2BmkmL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jonasjelonek.de;
	s=s1-ionos; t=1789768072; x=1790372872; i=jonas@jonasjelonek.de;
	bh=qPqKG2p+6pEkqJOUHkP78onv3go2yReDnn4Op/IAoLo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uX2BmkmLSjvDVBqhmDPhQ4XOhiYaImHvXX9MsWDDKnVwABR0dCrdmb6xonqjsYP3
	 cAoKgZrF2ggw3r60Dwp+62cP5Sh26D2uVPFGUVJaz1fkZykNBwTWW1XB6twnCunZf
	 ewqvy5Tu5wn3rvcNJbrNlkvj5HCpRIvGKP7EIX/fAtm9tp8/pU03H3B9O8NoZC52w
	 aKpDjMrQIQ4gdYROCX1UI7jQJOc8DyPOmMsMAXutU3fzcCwdfxVhSl+JH8AqHhwr5
	 wX5zpuo7aVzuD1cDEzjiOfiAVnt5qeX5YLfNpfECx8L+SEf6rWON+cgSJ77sr48qd
	 mxfdsRvbNlfXmRGTUg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue009
 [213.165.67.97]) with ESMTPSA (Nemesis) id 1MxUfh-1wrvlp3WUj-00yMi9; Fri, 18
 Sep 2026 23:47:52 +0200
From: Jonas Jelonek <jonas@jonasjelonek.de>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonas Jelonek <jonas@jonasjelonek.de>
Subject: [PATCH] spi: realtek-rtl: add support for second CS
Date: Fri, 18 Sep 2026 21:47:40 +0000
Message-ID: <20260918214740.3963349-1-jonas@jonasjelonek.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jLA9R6xXO+GUMar2t7IqSu/5pQIXY1OWeSmys1EmQ8njn3d0LFC
 pax/ybCS4wr5SGMTgCzb3ibVPMH5hLgM/UC7WcxnTt+0o8FyrI+YlwU0a94sEh3ST/38SdP
 lcIr9LVSEAwpSvzI+EHa0ZeisFDRRCnWP0vjQShV7GjugeZ8T5oP81d09S2H0vOwFuAQ2sn
 kbUZkx7+lJInyNv+hEYxw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5Wu0GhhhYCA=;Ebrg7SYvV7/HpBmEkdeBJn7zj4D
 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

The initial driver assumed that the controller's second chip select was
vestigial because none of the devices examined at the time used it. This
does not hold for all hardware: there are devices with a peripheral
connected to CS1. Since the controller only advertises one chip select
and keeps CS1 permanently deasserted, those peripherals cannot be used.

Advertise both native chip selects, select the appropriate CSBx register
bit in ->set_cs(), and leave both lines deasserted after initialization.

Rename the callback argument from "active" to "level" while touching this
code. ->set_cs() receives the physical line level, not a logical assertion
state: after applying SPI_CS_HIGH, the core passes false to drive the line
low and true to drive it high. The CSBx bits directly encode that level,
and the native outputs are active-low, so clear the selected bit for a
low/asserted line and set it for a high/deasserted line.

Signed-off-by: Jonas Jelonek <jonas@jonasjelonek.de>
=2D--
 drivers/spi/spi-realtek-rtl.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-realtek-rtl.c b/drivers/spi/spi-realtek-rtl.c
index e1c40ff2e49d..f382f3d428df 100644
=2D-- a/drivers/spi/spi-realtek-rtl.c
+++ b/drivers/spi/spi-realtek-rtl.c
@@ -29,17 +29,31 @@ struct rtspi {
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
@@ -138,11 +152,9 @@ static void init_hw(struct rtspi *rtspi)
 	value |=3D RTL_SPI_SFCR_RBO | RTL_SPI_SFCR_WBO;
 	__raw_writel(value, REG(RTL_SPI_SFCR));
=20
+	/* CSB0/CSB1 are active low: deassert both. */
 	value =3D __raw_readl(REG(RTL_SPI_SFCSR));
-	/* Permanently disable CS1, since it's never used */
-	value |=3D RTL_SPI_SFCSR_CSB1;
-	/* Select CS0 for use */
-	value &=3D RTL_SPI_SFCSR_CS;
+	value |=3D RTL_SPI_SFCSR_CSB0 | RTL_SPI_SFCSR_CSB1;
 	__raw_writel(value, REG(RTL_SPI_SFCSR));
 }
=20
@@ -171,6 +183,7 @@ static int realtek_rtl_spi_probe(struct platform_devic=
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

