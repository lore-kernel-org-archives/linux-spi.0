Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577831;
	b=dMItlAz0uO9XThA0Z+t7TskPQwDa1xBNwBU5B8vuBckawoOoVbeYxcQlkQLZ5cNTG3ph
	 nXMPgdERpLXmNjuX2i4O/FVxHBv6kXbHw+pthW6hH/HavbCLD8Z3AtY4XJcgZsUqSH240
	 u78FLXjQ0hzVT7Jrwp1IxxHxNh4ynOAP/3RNSEHfAJiq0Ms1Kz0qsotyrb4O2+KArtFbQ
	 OjAXKGY0D1ldWy/xAIBhD0Jt7H8Y0d7lYDwM8jx7qBGe9awzr7Qybr84iYQ8aV1IdYUtA
	 T9kxlPluewjWB7chEwlHRnmN6paDfCQvctM+H/iZhR1doff+SWQfmEHRgxLmYANElSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577831;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xcF/qRmyMdOcWsOsmn4LsTlUoZBs0bxa1cPGLKlSvKA=;
	b=Po/9bOVr36wB8byNeRWvdzS+hlHQCHCNfcw9c9pd/tv0UsP8hLoPTYJ6n9ULgPNuk23v
	 0IpUn+/w5Ze3Ls3YNPmTvY285+DS/vIw9jvOlEBcuhsVoPzlp5CEW3fJKG2KyxjUZWbmc
	 otrL5RPb+V57CYja9zCgbCUZEZtYNmNBHEn/0NvFKrh66z1ysvuIuCrOoICjYA/ddeQDF
	 05bjaEmTf5+IBMqezRaeTqRjTD0igHCCleht7IArSdv2RIbAcTLzX6sUFw7olkbobvUdf
	 BzkYyx7hEMoDN1RkYpFV0Ot8fR5M79PEUQJI+9lq878dAfstYuQWudqFmO5+o2X5p9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=0p7OeW18;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B8060A381B
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 13:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4B8060A381B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=0p7OeW18
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=xcF/qRmyMdOcWsOsmn4LsTlUoZBs0bxa1cPGLKlSvKA=; b=0p7OeW18XEgf5yUUxxL+rm36R7
	W4i/tSfFKSJ2JkbeVi90tL/9hiD3OvJnb5AXmcB8NAHOkN2hOGN5p4KTwJWz+H2JP0JGjznhRM5il
	aJI6r/IMW9Hi+mCNCwcqJqaij6bB0OpPVRnhiu3LPl1JWw5eAuGjG8Cv55fMHQgZlM+B1KQcwjP3C
	Ty/gSUT7jkzyhMxtpYXmFQrlV/4hAC/Nn0sXIO0o29rPd2liPwW76BGpprAx0xxV2UkL076zJ4GRt
	KcSyjuznFnVpYNPlM0OZZNj3ROMJYwjAOci7W+2gWOVg+a9Ov0jWaVLlIQiaD5mIy6jLB+PHfdB/p
	PVU+w5Iw==;
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
Subject: [PATCH v2 2/6] spi: Export spi_set_cs() function
Date: Fri, 13 Nov 2026 14:50:13 +0100
Message-ID: <20261113135017.1047959-3-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113135017.1047959-1-heiko@sntech.de>
References: <20261113135017.1047959-1-heiko@sntech.de>
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
index e79f16aca1a3..b268357e933c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1268,7 +1268,7 @@ static void spi_toggle_csgpiod(struct spi_device *spi, u8 idx, bool enable, bool
 		spi_delay_exec(&spi->cs_inactive, NULL);
 }
 
-static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
+void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 {
 	bool activate = enable;
 	u8 idx;
@@ -1325,6 +1325,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
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

