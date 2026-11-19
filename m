Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096706;
	b=pX/AC4FDdVFM4yEawUZGSxxv9YVZWffR7fgzCtlFLN1kGcEzbqt4KQJCb/0LprLg88rO
	 RWbkqxjqyF48KKqBCFujWIYWPxW2pOQaccPjQZIJkMLSlPdlGe80oOjufqUUan1nfRo/8
	 Q3KZHcDB3hnsUn2oNIZTk8un8gRN6v/SznieyQRssRUpQ8AP3igdPUeFybTWcnXxuJOP9
	 etE2Mq6byv43I9fw6A7kVaekgtHPBnBl4/JcfMnDsMlD21Bmeeio+cIyZMFlQ+GwPVygB
	 EZ0h56NUj7JkcNFh70yoOWPIPGKNQbzHfREqGpiCtFLaZ5yyH0LDE8Q5Y0aD2oVFd7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096706;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FIDR+CbcYrPMhx79jeVnPIavdIqoZl1OxXu1LX4HYhM=;
	b=FwXee/hQfvSgiuebpqldvParKwrZGIlFAqvcHJWxufUdWkNsqWD4gDgk8a808x+mDpto
	 Hy/VEFw+75jdBurHWqOFqa/obVRqP0MHRp3nuaLMf3am06FtchZosqZa12dFLL5w31bs7
	 IsyJwLuDvx566ROTlr84S4JhCH/1esF4jXbOLqBzicUVzvheWK4k7y+C39zRSUxUTEJpS
	 7Tl9zl9qPJv7PS50Na8Zyf/YK0z7nnYRs7PAuqJLBwNhSzq2m17RfZdDoxCyUCWsozKXv
	 54yQWPJRYrqO74zimlvgf2NsrObmwJKrFuQFaS/Gj9j24E+M6Fo8ZwORKYM1ClAcVew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=nHtZdBaW;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BE2606A324
	for <linux-spi@vger.kernel.org>; Thu, 19 Nov 2026 13:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44BE2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=nHtZdBaW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=FIDR+CbcYrPMhx79jeVnPIavdIqoZl1OxXu1LX4HYhM=; b=nHtZdBaWcb8+298HxUi6d5LuLU
	jktbOepkE2mvyOVHnjW8neUeGKueqGdipUVVkjyccH+wQ5wtZFEEZihUVJslujdpBsDeYYvKBftzH
	J6NHGgD+oBmCuxYEL/1xiDJg8CYLYvv36Td5TYf1fxfet1pFPEsrcqMPDC47HW8Cub4Bw6tS582WK
	ftiQ1/XSi7l7ul8wV2QBXXiZpsHymooBIqg+VEnmbmhLEdKJiOKp71DkDt72bUuBcx+EwPBSK1PPg
	LEUYJ7muC2a9aoAeM8kmgpxhxsrM80ytQuz4C539ZSgq+vEOUP7EmN7/ssn5jy93Pgf3jKlud/UiT
	/BlvHUGA==;
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
Subject: [PATCH v4 3/6] spi: Export spi_set_cs() function
Date: Thu, 19 Nov 2026 14:58:05 +0100
Message-ID: <20261119135808.2377849-4-heiko@sntech.de>
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

While spi_set_cs is currently only used when the SPI framework manages
the core transfer function, it contains a lot of functionality that
can be used for the upcoming atomic transfers, where a driver implementing
that atomic transfer could profit from not having to duplicate the
chip-select functionality.

The only sleeping part was the spi_delay_exec function doing the
chip-select delays, which can now also run in atomic contexts.

So export the function.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/spi/spi.c       | 3 ++-
 include/linux/spi/spi.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ec2074126910..0b0bc093e01f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1278,7 +1278,7 @@ static void spi_toggle_csgpiod(struct spi_device *spi, u8 idx, bool enable, bool
 		spi_delay_exec(&spi->cs_inactive, NULL);
 }
 
-static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
+void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 {
 	bool activate = enable;
 	u8 idx;
@@ -1335,6 +1335,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 			spi_delay_exec(&spi->cs_inactive, NULL);
 	}
 }
+EXPORT_SYMBOL_GPL(spi_set_cs);
 
 #ifdef CONFIG_HAS_DMA
 static int spi_map_buf_attrs(struct spi_controller *ctlr, struct device *dev,
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index fb4baa0d3398..0bf31776c54c 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -349,6 +349,8 @@ static inline bool spi_is_csgpiod(struct spi_device *spi)
 	return false;
 }
 
+extern void spi_set_cs(struct spi_device *spi, bool enable, bool force);
+
 /**
  * struct spi_driver - Host side "protocol" driver
  * @id_table: List of SPI devices supported by this driver
-- 
2.53.0

