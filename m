Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411631;
	b=wxFrqlOOQx3bf5wmp5u8RJ7iKiQWvKpgoCC7cv7OvGPbMmflh1YouwX49lYIXDuBEXVD
	 Fi3SOZCunVJ9odMZzK9m//RKaMS7utI7EZoJ8OyB0H+xT34V08Rlr8eTpcXr1pTOb7OyC
	 6rtLCMY0n2ugkx2S1CFwj6NKPg1Zqftnr9LdJcTHbCNY4pqR9O7A0iFYZmmpYhvSCa2Up
	 ghCXML1nnTKP0z7zexructYak5GfH8FCpLJrSPWa86B9v56GCWNp4xWXvoXBP6/82kEwH
	 gc+/rorJJAJL4cHNJ20T7cJtUdMASyf51Xj/lL/NSCByzfrhesFQeIzgrzLk9gVZvQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411631;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IuhdT8NCapF16BrqdC9jiSbtcdLEYI2e/fdM4g1nxYs=;
	b=c1+l41ezqiXLL3CQGzrTJ3kpLhVDH/Y6m3R8NxgToc2bTXyd+pM3/+2AXhn1xPWOVwL6
	 CHutdRBKc3fUFH5S3oQ51dOU/oXGt3896dEWMOHNjA6s++Z9X4xv5vgSX+abb2WXr12QB
	 COh+biYZ87mBtWKUTIb8xnwgKSxWIxY2c0QVZuxKD4slrBmHv6jxmJMFYtWGqqup/Dm61
	 5UyZca7Luy9Y8e02oOOgxn62Rh+6WDhtzKb79T9DtqZsr1Yb5YVjjU/02H29eBp4XR04S
	 zcC3pA6Cws+V1X0ryLlRwoAVTgUFFQDxQk24cJyIJ6jbgsS0SnoVhbZulHOZfo2RDMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LqvAAroa;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8813606A893
	for <linux-spi@vger.kernel.org>; Wed, 11 Nov 2026 15:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8813606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LqvAAroa
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so21260125e9.3
        for <linux-spi@vger.kernel.org>; Wed, 11 Nov 2026 07:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794411629; x=1795016429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IuhdT8NCapF16BrqdC9jiSbtcdLEYI2e/fdM4g1nxYs=;
        b=LqvAAroaAjuSjZCmj+eQNjPfmn9E5Vsa3t/Z5s3c9YnW/OEGBq9M+IEN/DcBv59Nyq
         x8Vg2AGeyRWnbSOz5PhDQmhd/v6PtbCbJitSzDOLUCM5LrH/VSPgXaFNhM/6eG7iFZZY
         hcFX+uXUdCRabDuoESJsAt/6UZaJxMXhTI5TBMdfSx0bnV8Y4GPhO/NFqs3w0xI1dHMK
         fuqVZaJKouR8syN3HHWmLTFCsJj7ggHCTomfTfuZiwNxAZquJJR87aEXW+7fKzm+TG5W
         ndiFUJX5OjvYX+y3lyYO5OZAHe3zRJOFX84XqIcIeExd3Jujh74mX5cjwcWhwyCGNLf2
         2jnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794411629; x=1795016429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IuhdT8NCapF16BrqdC9jiSbtcdLEYI2e/fdM4g1nxYs=;
        b=dQBVYdIF9UDrvZVCDzDM4hYn2Z3JZq6ewz3oPArPl9oJdLx3HwLl5olyxDtI+MiGHz
         Q2MBgOZTKrE/Ssz0GtVhaCurEsIH97Rg1z8X1tJdsU/eL26o8Sx3UUYFSLrDg/wyODwU
         nsuJ0hyPNth2Q9uZCmlxO4JHonE5k1U707DMtiWKbiv8JTwqROLSDWhGvL9Z9fb1pKdz
         0x+TI9PzKmpHC4btnJL211mp+c6GQEu87JfA69YYWeVQfNNk/so7aYk4BK/lzdaBV/oE
         4ubZTBBRpIyZ350EI62fOqbmfLVXEtqI4RMDfk5NoIcouXaWk/c3hQq2QSKzq6ysjMLU
         iFBw==
X-Forwarded-Encrypted: i=1; AL+hErFEPiv6zFqZs57YR2Zc7kepsVAhAsTbbDpuARLjpQGqURCwwx5P2N6gxH5ukHCPXteyBjwKmvkv3Qk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+pgLU7DeuSoIxZ2/WtDJArJDQ7G3/1WrzSjajKmD+PU3ehrzHG
	MdpizfgDVgTlqVmfsworkT93B4UhbWR6aLAimBX3lZ0GRojhl6neg0bf
X-Gm-Gg: AYBFou0n4xO+JIgaqybrAtRR2E+fHLJ7U+DE1kum1A9aW9h1up12gM9yMamd39TdhX2
	8+lpkeHieIgoU4+vO8MVQO4EC3zpehL8NznCAh4WAWjGulpu+jH25dQ5QQnDywgdT3zWVJKdPRW
	6fBrJM1iKg6XsrLyPXKREbcxetDLZ+fpAvuq50NpaJ3bZp8gWjolIkQOir7x+zfGjKkOUO7beB2
	1QHXsFlwVWi+QDNK87EDh6j85Wu7UXC8vlBDR62FHC1bNTemOOk9LyXC2zRHqw6Bqow/dhOgYp9
	Kelx4wXHDk1uHQoa8tQoKVcz7X2tbbx2yeH54MvLxJ1+P9STOU/9yT/eq7das4/kd2DPxnSLBwT
	W9WoiA8yXIqZTK/zvIg5H3cvTzoYN9bYA2WZ3T8cKD5+6OJmYyVO1mA0k4wKUyNRud/0YnBFU7G
	KsySntadHyENBmlC8mXYxV88N+/rcCn1vrLUCv+LRgmrEz1fXbqn1BjbQFEzzxUjtjv+0MBw68n
	dPZ79dGQkKUdFE4+8s7BSQ9HdSY/WKHqMBQm9bCD//f4oJTYhn0R4Xu+tL2hfCCNg/mrXdOAUp0
	oAA4csZ+Y3ijsLuHbMMCKczr2X8wAD/IYzI8cilGk6ac9Uomjwkh
X-Received: by 2002:a05:600c:8b24:b0:4a2:1364:252b with SMTP id 5b1f17b1804b1-4ba09383fd2mr46107035e9.35.1794411628946;
        Wed, 11 Nov 2026 07:40:28 -0800 (PST)
Received: from angelo-Precision-7550 ([94.154.175.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4c5d831esm3899675e9.9.2026.11.11.07.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:40:28 -0800 (PST)
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Cc: Ryan Wanner <ryan.wanner@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] spi: atmel: limit transfers to the bounce buffer size
Date: Wed, 11 Nov 2026 16:40:23 +0100
Message-ID: <20261111154024.543546-1-angelo.compagnucci@gmail.com>
X-Mailer: git-send-email 2.53.0
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

On SAM9 SoCs (CONFIG_SOC_SAM_V4_V5) a DMA transfer from or to a vmalloc
buffer goes through bounce buffers of SPI_MAX_DMA_XFER bytes. The whole
transfer is copied in them though, whatever its length, and nothing
limits the length of a transfer: a longer one is copied past the end of
the buffer.

The MIPI DBI panel drivers send a whole frame from the framebuffer, a
vmalloc buffer, in one transfer: 153600 bytes for a 320x240 ILI9341
panel. On an Arietta G25 (SAM9G25), once the driver accepts their 16 bit
transfers, the first frame oopses:

  Unable to handle kernel paging request at virtual address c8915000 when write
  PC is at mmiocpy+0x34/0x2a0
   mmiocpy from atmel_spi_one_transfer+0x4f0/0x77c

When the bounce buffers are in use, report SPI_MAX_DMA_XFER as the
maximum transfer size, so that SPI device drivers split longer
transfers.

Fixes: a9889ed62d06 ("spi: atmel: Implements transfers with bounce buffer")
Cc: stable@vger.kernel.org
Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
 drivers/spi/spi-atmel.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index ffc1292b0..fb8d4c7c9 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -591,6 +591,12 @@ static void atmel_spi_release_dma(void *data)
 	}
 }
 
+/* Transfers from vmalloc buffers are copied in the bounce buffers */
+static size_t atmel_spi_max_transfer_size(struct spi_device *spi)
+{
+	return SPI_MAX_DMA_XFER;
+}
+
 static int atmel_spi_configure_dma(struct spi_controller *host,
 				   struct atmel_spi *as)
 {
@@ -637,6 +643,8 @@ static int atmel_spi_configure_dma(struct spi_controller *host,
 			err = -ENOMEM;
 			goto err_release_dma;
 		}
+
+		host->max_transfer_size = atmel_spi_max_transfer_size;
 	}
 
 	err = devm_add_action_or_reset(dev, atmel_spi_release_dma, host);
-- 
2.53.0

