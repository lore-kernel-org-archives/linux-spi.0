Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2AB37AA97;
	Sat, 11 Jul 2026 08:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783758882; cv=none; b=X80GpPQ/jg+Wc+gRF52zVxhL31Rf1KJBM5lkzTSVqUsIPd3dIae5jET8R+ytS2VagJnf33vtjzbmGxj58zdKCq6uDIi/s9seeNJn804l5tlW9qqf3To9DCqKlMW67p5fzh0RXTTJchyDc85RHcK6HsIb84jscBMppDeFldYNRp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783758882; c=relaxed/simple;
	bh=IMJzjkof2e8ygneGqhXT/Gc/ysLxmZ8a0AYeOwOs0Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fkztSvseM+HZaMhQ/JJ1ovzA8eL6s2LgGTvERk2UO6z9+9IxucxqFpd77dC4DOwCXBfWrebZREJNJQdlyh5nnPs8iW/f0785t+Wrbe2GfA5+Lv+E+C4KAKtn5vzM8j5UXEh7reaJJM1QicqYl9nPLyX5oCEOv1uVTNwMPwjgIRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=L9ohiO4w; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="L9ohiO4w"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 302F485071;
	Sat, 11 Jul 2026 10:34:37 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id srvdNvaAtXXv; Sat, 11 Jul 2026 10:34:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1783758876; bh=IMJzjkof2e8ygneGqhXT/Gc/ysLxmZ8a0AYeOwOs0Oo=;
	h=From:To:Cc:Subject:Date;
	b=L9ohiO4w23oQwQFYfi56BA7435odjs2ypKh/43WOTuz6SU+WW4r35+l9jK3kSkyAJ
	 UT1/9QsRhxc0rsBeOM9TUYg0XTpC4UUtrucg7Wlv6cuN9/JpC3iD9Zvq8+hKACeuVi
	 vpRx3bhTihc56YaH72yri/efHGXk0k65SKiQvVzoBNNcVp0c+/nHNmDtFdpTl7E5Qw
	 6WGWgIC6CRfo12HXRPo9B2TSsxjZ+6o9NXR79NY/r0zya32kSH5pGBl8wufL8WhJPy
	 w74ESUoYtHCmwrVlb6qWEX1pymZvqg3D7yB5t24IkxO81d2vfjYj3+DdNW6cnY6xVe
	 v9gyp+z80pNCQ==
From: Rustam Adilov <adilov@disroot.org>
To: Mark Brown <broonie@kernel.org>,
	Bert Vermeulen <bert@biot.com>,
	Birger Koblitz <mail@birger-koblitz.de>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rustam Adilov <adilov@disroot.org>,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH] spi: realtek-rtl: change to __raw reads and writes
Date: Sat, 11 Jul 2026 13:34:11 +0500
Message-ID: <20260711083411.45836-1-adilov@disroot.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To make the spi driver operable with SWAP_IO_SPACE config
enabled, replace all instances of readl/writel with their
__raw variants. Otherwise readl/writel will do a byte swap
which this driver does not intend to do.

Tested-by: Carlo Szelinsky <github@szelinsky.de>
Signed-off-by: Rustam Adilov <adilov@disroot.org>
---
 drivers/spi/spi-realtek-rtl.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-realtek-rtl.c b/drivers/spi/spi-realtek-rtl.c
index 73065c8934dc..e1c40ff2e49d 100644
--- a/drivers/spi/spi-realtek-rtl.c
+++ b/drivers/spi/spi-realtek-rtl.c
@@ -35,58 +35,58 @@ static void rt_set_cs(struct spi_device *spi, bool active)
 	u32 value;
 
 	/* CS0 bit is active low */
-	value = readl(REG(RTL_SPI_SFCSR));
+	value = __raw_readl(REG(RTL_SPI_SFCSR));
 	if (active)
 		value |= RTL_SPI_SFCSR_CSB0;
 	else
 		value &= ~RTL_SPI_SFCSR_CSB0;
-	writel(value, REG(RTL_SPI_SFCSR));
+	__raw_writel(value, REG(RTL_SPI_SFCSR));
 }
 
 static void set_size(struct rtspi *rtspi, int size)
 {
 	u32 value;
 
-	value = readl(REG(RTL_SPI_SFCSR));
+	value = __raw_readl(REG(RTL_SPI_SFCSR));
 	value &= RTL_SPI_SFCSR_LEN_MASK;
 	if (size == 4)
 		value |= RTL_SPI_SFCSR_LEN4;
 	else if (size == 1)
 		value |= RTL_SPI_SFCSR_LEN1;
-	writel(value, REG(RTL_SPI_SFCSR));
+	__raw_writel(value, REG(RTL_SPI_SFCSR));
 }
 
 static inline void wait_ready(struct rtspi *rtspi)
 {
-	while (!(readl(REG(RTL_SPI_SFCSR)) & RTL_SPI_SFCSR_RDY))
+	while (!(__raw_readl(REG(RTL_SPI_SFCSR)) & RTL_SPI_SFCSR_RDY))
 		cpu_relax();
 }
 static void send4(struct rtspi *rtspi, const u32 *buf)
 {
 	wait_ready(rtspi);
 	set_size(rtspi, 4);
-	writel(*buf, REG(RTL_SPI_SFDR));
+	__raw_writel(*buf, REG(RTL_SPI_SFDR));
 }
 
 static void send1(struct rtspi *rtspi, const u8 *buf)
 {
 	wait_ready(rtspi);
 	set_size(rtspi, 1);
-	writel(buf[0] << 24, REG(RTL_SPI_SFDR));
+	__raw_writel(buf[0] << 24, REG(RTL_SPI_SFDR));
 }
 
 static void rcv4(struct rtspi *rtspi, u32 *buf)
 {
 	wait_ready(rtspi);
 	set_size(rtspi, 4);
-	*buf = readl(REG(RTL_SPI_SFDR));
+	*buf = __raw_readl(REG(RTL_SPI_SFDR));
 }
 
 static void rcv1(struct rtspi *rtspi, u8 *buf)
 {
 	wait_ready(rtspi);
 	set_size(rtspi, 1);
-	*buf = readl(REG(RTL_SPI_SFDR)) >> 24;
+	*buf = __raw_readl(REG(RTL_SPI_SFDR)) >> 24;
 }
 
 static int transfer_one(struct spi_controller *ctrl, struct spi_device *spi,
@@ -134,16 +134,16 @@ static void init_hw(struct rtspi *rtspi)
 	u32 value;
 
 	/* Turn on big-endian byte ordering */
-	value = readl(REG(RTL_SPI_SFCR));
+	value = __raw_readl(REG(RTL_SPI_SFCR));
 	value |= RTL_SPI_SFCR_RBO | RTL_SPI_SFCR_WBO;
-	writel(value, REG(RTL_SPI_SFCR));
+	__raw_writel(value, REG(RTL_SPI_SFCR));
 
-	value = readl(REG(RTL_SPI_SFCSR));
+	value = __raw_readl(REG(RTL_SPI_SFCSR));
 	/* Permanently disable CS1, since it's never used */
 	value |= RTL_SPI_SFCSR_CSB1;
 	/* Select CS0 for use */
 	value &= RTL_SPI_SFCSR_CS;
-	writel(value, REG(RTL_SPI_SFCSR));
+	__raw_writel(value, REG(RTL_SPI_SFCSR));
 }
 
 static int realtek_rtl_spi_probe(struct platform_device *pdev)
-- 
2.55.0

