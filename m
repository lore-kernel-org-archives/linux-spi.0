Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C0220C029;
	Mon, 14 Sep 2026 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789400173; cv=none; b=mT64BCGuLdGHR9n9oQFb+nOERbQKrBfEaJhH+EJiOl8t+M44Cknd4fCss3cWlW5hsZU6vhk8X/9m1MzBVAr23Doc7bX9sigEPdGhAWorXCgqWb3KRSqQI3nuGoPl15ES0FJoY6rrBn+j6Gi+mH5My6xjMLnZ1p08Qe1dQuovggY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789400173; c=relaxed/simple;
	bh=NSem7l7JY9Uj9Ny/qM9q10hyQ+v9YrfeRbBWgBgSO4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JGufIVOgAWcy+ehvIA2enF5FFhENJ3yxiOp6Z12Gm2vEQ4qJzni0w6h5QIMW9LW259aPrybQvsR0G5cNdimJSClS3M/vurMlPLMIqRXvzHdEAF4oOTN1x0aD0IfyAVRBoxQ0Xp5DnjXVqyNfUtmOFsz5YjwRegwpJCOuPzCNmS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
X-PTX-Original-Recipient: t.schramm@manjaro.org
X-PTX-Original-Recipient: mkl@pengutronix.de
X-PTX-Original-Recipient: jre@pengutronix.de
X-PTX-Original-Recipient: kernel@pengutronix.de
X-PTX-Original-Recipient: o.schinagl@ultimaker.com
X-PTX-Original-Recipient: wens@kernel.org
X-PTX-Original-Recipient: broonie@kernel.org
X-PTX-Original-Recipient: mripard@kernel.org
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-PTX-Original-Recipient: linux-sunxi@lists.linux.dev
X-PTX-Original-Recipient: jernej.skrabec@gmail.com
X-PTX-Original-Recipient: mr.nuke.me@gmail.com
X-PTX-Original-Recipient: samuel@sholland.org
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4B466202891;
	Mon, 14 Sep 2026 17:36:08 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x68j2-000vXD-0g;
	Mon, 14 Sep 2026 17:36:08 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Mon, 14 Sep 2026 17:35:58 +0200
Subject: [PATCH v3 4/6] spi: spi-sun4i: sun4i_spi_handler(): fix race
 condition between transfer completion and RX FIFO interrupt
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-spi-sun4i-fixes-v3-4-9fe919d5cecf@pengutronix.de>
References: <20260914-spi-sun4i-fixes-v3-0-9fe919d5cecf@pengutronix.de>
In-Reply-To: <20260914-spi-sun4i-fixes-v3-0-9fe919d5cecf@pengutronix.de>
To: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
 Olliver Schinagl <o.schinagl@ultimaker.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>, 
 Jonas Rebmann <jre@pengutronix.de>, Tobias Schramm <t.schramm@manjaro.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4123; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=/K4qAJq8Ud8aVtX6R8lXT6nVztdVNYQ6Ssz6Tu/OkLY=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshaIZKmlZ/9obR7TU3qK4vFn8xzUifbTdj4tPfCndCAb
 2vn/wyZ0lHKwiDGxSArpsgSqyanIGTsf92s0i4WZg4rE8gQBi5OAZjICk2Gf3b1Ar4sGdeFuc6r
 Tzm1ir3jxT9rX71pTm82Lp3hfdBsTzUjw+He0hfsfkqptWItG3dGvA271L3j6pUP28zXr5kad8C
 iihsA
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

With all interrupts disabled once the transfer completed, omit the
clearing of the Transfer Complete bit in sun4i_spi_handler. This is safe
because sun4i_spi_transfer_one() takes care of this before enabling any
interrupts again.

Cc: Tobias Schramm <t.schramm@manjaro.org>
Fixes: 196737912da5 ("spi: sun4i: Allow transfers larger than FIFO size")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 drivers/spi/spi-sun4i.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 8a9dcd3b6b8f..ea8be0170fbf 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -82,6 +82,8 @@ struct sun4i_spi {
 
 	struct completion	done;
 
+	int			irq;
+
 	const u8		*tx_buf;
 	u8			*rx_buf;
 	int			len;
@@ -333,6 +335,7 @@ static int sun4i_spi_transfer_one(struct spi_controller *host,
 	start = jiffies;
 	time_left = wait_for_completion_timeout(&sspi->done,
 						msecs_to_jiffies(tx_time));
+
 	end = jiffies;
 	if (!time_left) {
 		dev_warn(&host->dev,
@@ -340,12 +343,11 @@ static int sun4i_spi_transfer_one(struct spi_controller *host,
 			 dev_name(&spi->dev), tfr->len, tfr->speed_hz,
 			 jiffies_to_msecs(end - start), tx_time);
 		ret = -ETIMEDOUT;
-		goto out;
+		sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, 0);
+		synchronize_irq(sspi->irq);
 	}
 
-
-out:
-	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, 0);
+	sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
 
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
@@ -456,6 +457,7 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	sspi->irq = irq;
 	sspi->host = host;
 	host->max_speed_hz = 100 * 1000 * 1000;
 	host->min_speed_hz = 3 * 1000;

-- 
2.55.0.806.gb8242b093d

