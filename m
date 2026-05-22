Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DE838D3EC;
	Fri, 22 May 2026 07:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779434188; cv=none; b=e26BKH1kxYHewuigmHDRGfaN89hTJHE1vPsVN9BhZR1C2lQS9n08MIbOQRJTp93PNlLX21kmZ1piRWiKclHgu16Jp467NzMTPHSgVf5AUSQTa7ydugxqmlqpKtVjLmZ4QjdJDXnZ6PjOtqsxBhssIxAtfT/6dsIxLidjg4Veonk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779434188; c=relaxed/simple;
	bh=hMBcOM1/OqfvNnx5ajZIKg705UJUF+N3Ef6OReB5HBo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PhPNjUFL78ZwoB3QrP3dpquXT9bAZ8WbEPY6kZu8W4vffR6bsjWtgw/D5ctyx3tEaothHtLRyCMXklgnPKdKtGkiBZDFp7LeRi2F/JFD20N6tq2nIsuXAjMnG9M/olGJ1l310CiNqUYFJQ0NI+SqOg6F5LXeWVqg9HI021X8G/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 22 May
 2026 15:16:21 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 22 May 2026 15:16:21 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <clg@kaod.org>, <broonie@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <linux-aspeed@lists.ozlabs.org>,
	<openbmc@lists.ozlabs.org>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<david.laight.linux@gmail.com>, <BMC-SW@aspeedtech.com>
CC: kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/2] spi: aspeed: Fix missing __iomem annotation in output transfer path
Date: Fri, 22 May 2026 15:16:20 +0800
Message-ID: <20260522071621.102507-2-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260522071621.102507-1-chin-ting_kuo@aspeedtech.com>
References: <20260522071621.102507-1-chin-ting_kuo@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

The dst parameter of aspeed_spi_user_transfer_tx() is an MMIO address
obtained from chip->ahb_base, but it was typed as void * instead of
void __iomem *.  This caused a sparse warning report. Fix the
parameter type to void __iomem * and drop the now-unnecessary
cast at the call site.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605180441.uD3toFRJ-lkp@intel.com/
Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 drivers/spi/spi-aspeed-smc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index c21323e07d3c..808659a1f460 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -891,7 +891,7 @@ static int aspeed_spi_user_unprepare_msg(struct spi_controller *ctlr,
 static void aspeed_spi_user_transfer_tx(struct aspeed_spi *aspi,
 					struct spi_device *spi,
 					const u8 *tx_buf, u8 *rx_buf,
-					void *dst, u32 len)
+					void __iomem *dst, u32 len)
 {
 	const struct aspeed_spi_data *data = aspi->data;
 	bool full_duplex_transfer = data->full_duplex && tx_buf == rx_buf;
@@ -936,7 +936,7 @@ static int aspeed_spi_user_transfer(struct spi_controller *ctlr,
 			aspeed_spi_set_io_mode(chip, CTRL_IO_QUAD_DATA);
 
 		aspeed_spi_user_transfer_tx(aspi, spi, tx_buf, rx_buf,
-					    (void *)ahb_base, xfer->len);
+					    ahb_base, xfer->len);
 	}
 
 	if (rx_buf && rx_buf != tx_buf) {
-- 
2.34.1

