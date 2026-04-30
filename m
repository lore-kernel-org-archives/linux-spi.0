Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7353ACA65;
	Thu, 30 Apr 2026 10:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777543843; cv=none; b=M3/RCAIa2xMgVxg8rBO00UaTvO6PJIv6FsvQnr+1kODawMVsK9U+UmnCEb2M117LdtOr/Q5ZOJJKwObiXpF4nwHfaKccxcL383LUw/9aOjksFYhL8M5f8vdbpJdhuYjGZiuCKaHzoXC9o4Uvbplx9dTtuqPwDPQ569OK5dgX8Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777543843; c=relaxed/simple;
	bh=tyiLkTgwXliiyK1du6P+88X6L+VQhuFkJIR0zkN8O70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyYccm1dp/qstBHRFa6amvgWq0Ap/JiyP3K/nNXA7YUIJ1v9W3fHgR2EI4yHfhmFu4KYuJb7Dw8cPzBES03t8hmcZcUcVDlwiJEOAsyN8+sCzA9R7HZUhAfRlQk/NjbxT6RJyi4Fvmw+U+lJaGmuV2meX7FOEN3H3E3m3BZW42Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/Xx0K9F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/Xx0K9F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3B0C2BCB3;
	Thu, 30 Apr 2026 10:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777543843;
	bh=tyiLkTgwXliiyK1du6P+88X6L+VQhuFkJIR0zkN8O70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V/Xx0K9FWdV5p9KjsM/JcTZ+DudzsXHycvmJrQkYmUqMjjCs4Vy/0xvzI3HnAHBPi
	 smwqAACmlKwQzrpPEUNihM87p1+RGOdsqi7Q2pjNvOMc1xqmx7PYYGuzIOKf9qLfhX
	 nn9riF6SlVcEQxLF70nUVT/7NxYxhbin/Tv67+2LwVfpWbuwSpvfFvCprM+ehsfjRx
	 R2h/CTCZdEdiHUnJgMlWkxGtmOdWVuBf2MDWdWDRSnRPERc8OCiFNnzpl+mcvc19S/
	 fP6dYR7b9hwtay5cjELXVUr0ld9OvijV4AcViIE8oVRgRhUvy7IrvFabN7qz1HXCZI
	 dtjSjCub8y2vw==
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
Subject: [PATCH v3 2/3] spi: microchip-core-qspi: don't attempt to transmit during emulated read-only dual/quad operations
Date: Thu, 30 Apr 2026 11:10:19 +0100
Message-ID: <20260430-freezing-saloon-95b1f3d9dad0@spud>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430-levers-defiling-00406e391c5a@spud>
References: <20260430-levers-defiling-00406e391c5a@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1832; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=vCnHD2gB9c1t2oXBPiwMs4RyXB/Zb/Hdlg3mIo6+93A=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJmftTp3B7po3lmxiWsmc43EFI0jSepOTd4Sv4zX3nu39 8LWDav/dJSyMIhxMciKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAi388y/E9XaorRYu/WXVx6 78uPfXdPFkTUq2iGS3Fc/ujjtuFniiDD/5LlerPmcIUdXTK1Vk5pts6VmxdnnOaPNfp8tYvDc9b V+ywA
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
index ffa0f33a0ae09..70215a407b5a3 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -690,18 +690,28 @@ static int mchp_coreqspi_transfer_one(struct spi_controller *ctlr, struct spi_de
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

