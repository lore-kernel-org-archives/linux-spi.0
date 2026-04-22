Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4361833B97F;
	Wed, 22 Apr 2026 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871013; cv=none; b=kbUxI8PRV4plQr7Stelz/20zVKvvsAGhSzVjL0JWNQrHyI4ro+f8uoaWd/rDTEmgBOBjMnY4Pjf1VrZTcZiuzKyB82SUr022PfnooLrj87M7nZvzfMOzk6Px5d/a+FdXb04Z+HYPnWSmH+zgyQioEvbXJa74vZJwbfPXtikR2t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871013; c=relaxed/simple;
	bh=eAMN+EEHmLUF2Ne3S/DRJKeFMCv8/8xTGSnTG+9H6Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cuJWGsWIkQ1zLoNkdYD3Skjpc8bBHp6h9V1RInhGhkst50Vx4MI9oyvMKxmSLzfmG3tW9GjH0p8VbhYlFq+VwmaxOKxCA35wwaruxqKGNo6KuqdKCrKdHXwMnYbEXsAhAnRDVjacIxvveGzqLTKk8WcK+peTiJvOGGhN5+fye8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLoKQAUN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLoKQAUN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC670C2BCB2;
	Wed, 22 Apr 2026 15:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776871012;
	bh=eAMN+EEHmLUF2Ne3S/DRJKeFMCv8/8xTGSnTG+9H6Y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NLoKQAUNEDVOWOLeP3sSex+01SudFGa+UTqIE9rIa7M8TBAG3m+I7q6Cgp44YXJfo
	 BcT/IkDfdjs8vKvjVw/2VXjyyblnyGkuqdjjlZBTB2FUF/vXWV6Krf5BvfsQQr2dtp
	 9yV6hJaMI179tzFC4lD7UlJCpcl1Ik4GlBDlbu5Wk/vJCY1fClGTplNCyeUKQalH7G
	 sZB0slFrZ3RFHc/yJzvF4tGY8S/WPcCjtJItsZPUH7H/NJbVGpyYR7NGUT8Kt6yBIv
	 f0GjYc4dc0/8mObQIySIyUzQYEpOgV62OBOP8ykqqPlU8wDi3f1AFfmqFJjAwXGHjz
	 BJOE/1bOfNuZg==
From: Conor Dooley <conor@kernel.org>
To: broonie@kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Cyril Jean <cyril.jean@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	linux-riscv@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1 2/5] spi: microchip-core-qspi: don't attempt to transmit during emulated read-only dual/quad operations
Date: Wed, 22 Apr 2026 16:15:43 +0100
Message-ID: <20260422-omit-fancy-ad0bac3d843d@spud>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422-foe-strength-a5d8ad650ef4@spud>
References: <20260422-foe-strength-a5d8ad650ef4@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1832; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=xzvGmGWw+PhfUIzGLyaHBy7UzwyYroknqKzAQ1SA4Gk=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJkvnjnkbtgnEVX0Lm6hElPZdbZlGWI3dm4vMVvLV/nQg Xduy+b6jlIWBjEuBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEzkSTMjw/e7M7dd+3v5O3ul VYhq4rsMVwO3c6L2ItP+mRsVHeoUu83wP2naXAO1yU8WGHOu0pJQN+pzvzpvj++k2M7z/S3LDu+ 4zQ0A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The core will deal with reads by creating clock cycles itself, there's
no need to generate clock cycles by transmitting garbage data at the
driver level. Further, transmitting garbage data just bricks the transfer
since QSPI doesn't have a dedicated master-out line like MOSI in regular
SPI. I'm not entirely sure if the transfer is bricked because of the
garbage data being transmitted on the bus or because the core loses
track of whether it is supposed to be sending or receiving data.

Fixes: 8f9cf02c88528 ("spi: microchip-core-qspi: Add regular transfers")
CC: stable@vger.kernel.org
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/spi/spi-microchip-core-qspi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index 0a161727706ef..d39b04f9b6b38 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -693,18 +693,28 @@ static int mchp_coreqspi_transfer_one(struct spi_controller *ctlr, struct spi_de
 				      struct spi_transfer *t)
 {
 	struct mchp_coreqspi *qspi = spi_controller_get_devdata(ctlr);
+	bool dual_quad = false;
 
 	qspi->tx_len = t->len;
 
+	if (t->tx_nbits == SPI_NBITS_QUAD || t->rx_nbits == SPI_NBITS_QUAD ||
+			t->tx_nbits == SPI_NBITS_DUAL ||
+			t->rx_nbits == SPI_NBITS_DUAL)
+		dual_quad = true;
+
 	if (t->tx_buf)
 		qspi->txbuf = (u8 *)t->tx_buf;
 
 	if (!t->rx_buf) {
 		mchp_coreqspi_write_op(qspi);
-	} else {
+	} else if (!dual_quad) {
 		qspi->rxbuf = (u8 *)t->rx_buf;
 		qspi->rx_len = t->len;
 		mchp_coreqspi_write_read_op(qspi);
+	} else {
+		qspi->rxbuf = (u8 *)t->rx_buf;
+		qspi->rx_len = t->len;
+		mchp_coreqspi_read_op(qspi);
 	}
 
 	return 0;
-- 
2.53.0

