Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959454;
	b=4uH1etky315o8Xz5+rBergWaxNHbiJkL8mTOwvmuHJsSjooiYA74l14A6u66kSfecnAg
	 hRXWP2hWaTbsiihK5ezCK9XD6/vaIb/MvspRyvtwLv6uIfrLUdxPKzZQ92e0V0Sd7Ivcu
	 FPKV0OrEFvB1HmDyzf6mxj9Dpv/nTzKzRRHXi3CHAJUVK0a3+cW97TdLZLEJe81tmWF55
	 +RYGV89cvU/PWA5xpHdy5z87ggbqpzHi4DVNwJG25iMFW2+yZDxZbCyYxesBffH3v6TaF
	 bEoosCxbBoxgOBdVPx+N+d+lqLXbf4mpRk9Mp4w3gFQ6vLygvYh7s/oavjCrF2lN7UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959454;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=E+uOyneVmVFOmGSZe+TfjwVrm4UGuXqktpAbFT4fB/s=;
	b=VV4IYX9Dtg50aiqe76L31pHOLWIvhW1GMqgwxU2MmoLk663yFhqFNAIuoTUGQ3eNpkyD
	 rxjVIa+MzVDC3HsjUqFP7PZnwQiakMLmpneWiUJlLlw6ZFbZVN+b4ri5lKE3pbSdgRbqv
	 ybEaUUD81h2RHrwKkO2XkoIR++SIgb3inDcriBdbp5aHERwMb4CU6e2K8EsjVDPslZUOC
	 GCbKLFDmZGhgax7WYJrJ3zOkHOKsFhAkndkxA4Aus8s3XoXqAI9qY5GNKBj8xsP/xa2fJ
	 t+K9lp/y3SjtqQaB1AicHyJt3eht3x43HaPhlpqMNpCYUjUIv9rZ08zCADUXgcsM69w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b="Mms/Revh";
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC11606A332
	for <linux-spi@vger.kernel.org>; Tue, 17 Nov 2026 23:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EC11606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=Mms/Revh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=E+uOyneVmVFOmGSZe+TfjwVrm4UGuXqktpAbFT4fB/s=; b=Mms/RevhfEzZ6SqVv+4s8Pm05f
	pNj96haiAjK79hLRROvVlFLM7VOp0mCwB88itTGcKcjkBwllRgTv6GI3LBZ8N/jWygqugduI5tK3a
	gl+9xo9sZGHeiMdlmeCmQCW8sJtI2L3uU76mmSlRIYSPX5WwjTZroeNrdiliQOmDpBtDyRhyvWxDD
	cDBG0v7RO17k/l3C3/JM3rny+YJHHwSUzxB93oz001ewZy1bexKTfJpTk7HCfEeG52sKQN7WCAJTx
	o6vdMtF/4oE0r75jvYXj2asXQbg+heMeGW9mv0cNl81755nLOZhPRJb7sckEPwVBnKxgEC79bM95M
	wyQGc3Zg==;
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
Subject: [PATCH v3 3/7] spi: Export spi_set_cs() function
Date: Wed, 18 Nov 2026 00:50:17 +0100
Message-ID: <20261117235021.2013719-4-heiko@sntech.de>
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
index 8a82d7f5b9fa..f04adf069ec1 100644
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

