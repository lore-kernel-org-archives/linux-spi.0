Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F34D4A92F7;
	Wed,  2 Sep 2026 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363375; cv=none; b=QjoQuObZyD8R+yV4BnW+gnrvc/VFG90NfbsrDRImEHlQOrSZDhPXahRrUKGaTtOg7yBfHDkdbNxAfRrjsnN6KbbyTYMP8D4peWhHmfc2dh2eC9m+yXbmS3/WW8xH6nU7rDR/VdMMYT8IN+PEoUM+BzjNciBBk/v2fvaqwi7z1po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363375; c=relaxed/simple;
	bh=YBD8ft/sPdYC6pUXWemIhIZyugU1LIeTSWgQh/jhjSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KFy936rSzoH8Tlqc5qx4wBnQdbP4u99y7TqP9ePCfvqoL/gIAqOxg2krDAxF+EmccvZM7WLNIEQRKlnqUkg3MLJNbnblGIKImpgcx4PX4997ZbYqP6LFWfpcSk31Eq5scF7ewgnxkzLmo5J0Rz6akL9LWnMyGL4/SV95u6MAC1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3A7982058E5;
	Wed, 02 Sep 2026 17:35:54 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x1n0E-004bxm-0N;
	Wed, 02 Sep 2026 17:35:54 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 02 Sep 2026 17:35:46 +0200
Subject: [PATCH 4/5] spi: spi-sun4i: sun4i_spi_handler(): fix race
 condition between transfer completion and RX FIFO interrupt
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-spi-sun4i-fixes-v1-4-19985ef75673@pengutronix.de>
References: <20260902-spi-sun4i-fixes-v1-0-19985ef75673@pengutronix.de>
In-Reply-To: <20260902-spi-sun4i-fixes-v1-0-19985ef75673@pengutronix.de>
To: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
 Olliver Schinagl <o.schinagl@ultimaker.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@linaro.org>, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Jonas Rebmann <jre@pengutronix.de>, 
 Tobias Schramm <t.schramm@manjaro.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3493; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=xez/HqbUFh5c/PkzUu4yoRKWnkmidv1BioLuPqVozpo=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsia4RTB07rN/6zrF6dbj9faXlIX2cof8iWBIyQ2939gz
 fMFjs1nOkpZGMS4GGTFFFli1eQUhIz9r5tV2sXCzGFlAhnCwMUpABNJiWVkOH7lhM6UJb8WfUtM
 ifv6cNGp6ycOXXVbe5ohxfxyusLTxYsZGWb07e3j9HmxwpN//1PdAMEN7R80atyMrlaEP5mw1t5
 mOQMA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

From: Marc Kleine-Budde <mkl@pengutronix.de>

In commit 196737912da5 ("spi: sun4i: Allow transfers larger than FIFO
size"), support for transfers larger than the FIFO size was added.

This commit moves the draining of the RX-FIFO from
sun4i_spi_transfer_one() (after completion of the transfer) to the IRQ
handler when the IRQ "transfer complete" is handled. In addition, the
IRQ "RX-FIFO 3/4 full" is activated for all transfers.

However, this does not take into account that the RX-IRQ for transfers
that exceed 3/4 of the FIFO size is still pending after the IRQ
"transfer complete" has been processed. All interrupt sources are only
deactivated after the wait_for_completion_timeout() in
sun4i_spi_transfer_one().

This opens a race window for "RX-FIFO 3/4 full" interrupts to come.
The sequence is as follows:

| sun4i_spi_transfer_one()
|     sun4i_spi_fill_fifo()       // fill TX-FIFO with 48 bytes
|     // enable RX-FIFO 3/4 full IRQ
|     wait_for_completion_timeout();
|
| // SPI controller transfers 48 bytes
| // SPI controller issues "transfer complete" and "RX-FIFO 3/4 full" IRQ
|
| // IRQ handler start
|     sun4i_spi_handler()
|         // ACK "transfer complete" IRQ
|         sun4i_spi_drain_fifo();
|         complete();                         ----.
|         return IRQ_HANDLED;                      \
| // IRQ handler end                                \__ race
|                                                   /   window
|     // wait_for_completion_timeout() continues   /
|     // disable all IRQ sources              ----'

Avoid the race condition by disabling all interrupts when handling the
"transfer complete" IRQ and before calling complete(). Also move the
draining of the RX-FIFO back into sun4i_spi_transfer_one() where it
was before commit 196737912da5 ("spi: sun4i: Allow transfers larger than
FIFO size").

This has the added benefit of spending a little less time in the IRQ
handler.

Cc: Tobias Schramm <t.schramm@manjaro.org>
Fixes: 196737912da5 ("spi: sun4i: Allow transfers larger than FIFO size")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 drivers/spi/spi-sun4i.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index ae009d598450..18951c1972da 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -333,6 +333,9 @@ static int sun4i_spi_transfer_one(struct spi_controller *host,
 	start = jiffies;
 	time_left = wait_for_completion_timeout(&sspi->done,
 						msecs_to_jiffies(tx_time));
+
+	sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
+
 	end = jiffies;
 	if (!time_left) {
 		dev_warn(&host->dev,
@@ -340,13 +343,12 @@ static int sun4i_spi_transfer_one(struct spi_controller *host,
 			 dev_name(&spi->dev), tfr->len, tfr->speed_hz,
 			 jiffies_to_msecs(end - start), tx_time);
 		ret = -ETIMEDOUT;
+		sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, 0);
 		goto out;
 	}
 
 
 out:
-	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, 0);
-
 	return ret;
 }
 
@@ -357,8 +359,7 @@ static irqreturn_t sun4i_spi_handler(int irq, void *dev_id)
 
 	/* Transfer complete */
 	if (status & SUN4I_INT_CTL_TC) {
-		sun4i_spi_write(sspi, SUN4I_INT_STA_REG, SUN4I_INT_CTL_TC);
-		sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
+		sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, 0);
 		complete(&sspi->done);
 		return IRQ_HANDLED;
 	}

-- 
2.55.0.123.gf60db8d575

