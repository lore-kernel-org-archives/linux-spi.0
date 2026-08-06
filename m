Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACA847A874
	for <linux-spi@vger.kernel.org>; Thu,  6 Aug 2026 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786043950; cv=none; b=b72tAh522MaPX2Iz9fXTAciKQ8XJGhRQlspXkMd7ZZVneM/nDUf7a2GWfON+9cVZE4Bgj058VbShrJjZ+ftSOxCxIzOYTf2eGdejNFsc3+2iQrtocwaBTSDp0hzI9jZMy6dzttyIjO5wbXFuTcxJVM6h9PJ0OpCpBQjenM3DPag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786043950; c=relaxed/simple;
	bh=51nhUZ36HVPR/vZg+M/rCeJtONDFxUX0gazcIser9OE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g67ISdpoAv1bbuor5L+Q6kCvIno2o41XI8v4Mgcvpewx8TE6kKSU5CILRR5ZqvQWe98sYLlwXcz6IIAaUocxpfrbz71/NXRZZEAYJnW4TWPs0Olk3cX8/50RzLDeNwxbMSoKO/LOVtLcw5P+NNMWPsnV6oLhVvz95J2+WaTM4LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AebnzJL0; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AebnzJL0"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aeb98460c6so2465557e87.2
        for <linux-spi@vger.kernel.org>; Thu, 06 Aug 2026 12:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786043947; x=1786648747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Rntni/+iFL5zOCPoEwUROZX0FJSnIqGs1w4smqyZiM=;
        b=AebnzJL0f4yQbSa5RGDhRFRVo25In6qh51SBPcqsGZ/XEwQhSI4iitwYPifotgQ1XD
         8QOYzULggP6FpSLX+SJLKj5wEUsogrfMzgsucNIWrsBqKLZyY/eaxkEumYHy7hC0iViL
         8VQigax9VWQlVOBQXAaINABkRbjnsoTMsNbkg1mathxpQkXqhgAbIDLTwtpKnnlCJ2Rv
         +ROAJYvhWJrHOYzG6pO/YPRVhkhJSo+Sp9i1HpHSPeIFQc2EdGUVlTw50VwyVkX8ZtQT
         3dVavwuOMvGaQFEnFDVXxV9MM1Ywt4/ayzeNcN9gRnZRQ/tsJCa/2AjeqQKnCUvF8u2K
         p9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786043947; x=1786648747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Rntni/+iFL5zOCPoEwUROZX0FJSnIqGs1w4smqyZiM=;
        b=T8SF1GZBQBZw9YgRJBGj/Gs/AgEDh6uyqbaKoODPDbM90LVimGYrD+qyxKV+JogZFQ
         OOJ8PpCBRFFt83dOIpZ1d3yO07e9jlWC4/y0gny7KiuCRUZQQ7Kj1M0E18TUqXplbalh
         fFMz3L18eoXzZoTe+RZr/iI1ZE4QUr+qzZyrMPl3sgzh9W6g8MOUp+wZCBxjaahgKLYS
         MeFNS7lhRrAzRZ2X7rTKz2Hk0+ALsNALw809iLC1rhRNHb1Ewt1akGdcTB/Drpul5JoB
         6m1u/3U/k90jLTX0BbWzv23Fwznuu2uzdXvOiFoNvjtoJ2RPvMTsQscVPQxipvChDOvS
         zOsQ==
X-Gm-Message-State: AOJu0YyraWYeHJiU0Vzny2/f7tb93HfK6CbN+34DLUrKMEQDEH0n63mh
	Sey9grfT58cynQBAS0WzRo+cR7OQeQk/7RXmeNg7VzQ3sWY8r8XqKSEhLD9pvA==
X-Gm-Gg: AR+sD13EsSUBzVd8qWxEApaN2NimeiZfKLvgM9fd/YiOQC60MrTTyb2iIfpV0vitY3w
	nKAZF7m5NYYmejXPYGDuqB+ncVQ3lvJmg5GIUOSqi+1QFts2THSoQGh9sWngfmFWXn8gqNzuLu6
	4E0L7+W804zHN68TAuuI4w+Des4mb1mf+upl0d74iWcsIt5cEpKdwwOdqAE7YOv5V3x8uKKc6me
	whrum7QdI1tJiw0o1Ss4hGrFMa2i0JutZZpj7sjUNNvk40a2LMcTCs2J+FwfA2zUxNVOaT+zhPy
	MuCAfV3nlRPZ6xx34AMlelUYv1Fg6QgiCgMFxVlbI3RSseoPI41mNekscKEDB81pI8hyx7Fum5P
	Vl5Lt8tEqtjz5LBzbUgECMpUaLWKWl8Q5ENLRrHrPH3YHs8Rdcw3VzswpxqBozwEamjbXQtJITH
	IYfI6eXJXJtWXCMHImtVU9CiyrwX6H9eaF/Hm/ackEIzr5o7d+hKXey0Sd0O+TVP0EcjxoOyXnY
	jpclxvhhsMg3Ac=
X-Received: by 2002:ac2:4bc4:0:b0:5ad:5c4a:8221 with SMTP id 2adb3069b0e04-5b303aeeab0mr626768e87.0.1786043946449;
        Thu, 06 Aug 2026 12:19:06 -0700 (PDT)
Received: from gentoo.sknt.ru ([95.161.221.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3050cfa83sm57071e87.22.2026.08.06.12.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 12:19:04 -0700 (PDT)
From: Alexander Shiyan <eagle.alexander923@gmail.com>
To: linux-spi@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	Mark Brown <broonie@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Alexander Shiyan <eagle.alexander923@gmail.com>
Subject: [PATCH] spi: rockchip: Fix runtime PM underflow on CS error paths
Date: Thu,  6 Aug 2026 22:18:54 +0300
Message-ID: <20260806191854.922530-1-eagle.alexander923@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Rockchip SPI driver manages runtime PM reference counting around
chip select (CS) assertion: pm_runtime_get_sync() is called when CS is
asserted, and pm_runtime_put() when deasserted. This balanced pair is
expected.

However, when a transfer is aborted due to an error (e.g., power domain
timeout, DMA failure, or suspend/resume), the CS may remain in asserted
state while the transfer is terminated early. In such cases the
corresponding pm_runtime_put() is never called, leaving the usage count
artificially high. A later attempt to deassert CS (either explicitly or
during a new transfer) will call pm_runtime_put() without a prior get(),
triggering a "Runtime PM usage count underflow" warning and breaking
subsequent SPI operations.

Furthermore, the error handler may already have released the PM
reference and cleared the CS, but the SPI core may still call
rockchip_spi_set_cs() to deassert CS at message completion. Without
additional state tracking, this results in an extra pm_runtime_put()
and another underflow.

Add a cs_claimed flag to struct rockchip_spi to track whether the
runtime PM reference is currently held. Set it in the CS assertion path
after pm_runtime_get_sync(), clear it in deassertion path after
pm_runtime_put(). In error paths (rockchip_spi_handle_err() and
rockchip_spi_target_abort()), check this flag and release the reference
if still held. In rockchip_spi_set_cs() deassertion branch, only call
pm_runtime_put() if cs_claimed is true, preventing double decrement.
---
[root@diasom-evb ~]# rtcwake -s 15 -v -m freeze
rtcwake: assuming RTC uses UTC ...
Using UTC time.
        delta   = 37
        tzone   = 0
        tzname  = UTC
        systime = 1773421731, (UTC) Fri Mar 13 17:08:51 2026
        rtctime = 1773421694, (UTC) Fri Mar 13 17:08:14 2026
alarm 0, sys_time 1773421731, rtc_time 1773421694, seconds 15
rtcwake: wakeup from "freeze" using /dev/rtc0 at Fri Mar 13 17:08:30 2026
suspend mode: freeze; suspending system
[   28.951039] PM: suspend entry (s2idle)
[   28.957997] Filesystems sync: 0.006 seconds
[   28.963184] Freezing user space processes
[   28.966553] Freezing user space processes completed (elapsed 0.003 seconds)
[   28.967162] OOM killer disabled.
[   28.967464] Freezing remaining freezable tasks
[   28.968457] Freezing remaining freezable tasks completed (elapsed 0.000 seconds)
...
[   33.249429] spi_master spi2: Failed to power device: -13
[   33.249893] spi_master spi2: noqueue transfer failed
[   33.250331] spi_master spi2: Failed to power device: -13
[   33.250797] spi_master spi2: noqueue transfer failed
[   33.251230] rockchip-spi feb20000.spi: Runtime PM usage count underflow!
---

Signed-off-by: Alexander Shiyan <eagle.alexander923@gmail.com>
---
 drivers/spi/spi-rockchip.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 231fbcf0e7aa..fb5795bc734d 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -191,6 +191,7 @@ struct rockchip_spi {
 	bool target_abort;
 	bool cs_inactive; /* spi target transmission stop when cs inactive */
 	bool cs_high_supported; /* native CS supports active-high polarity */
+	bool cs_claimed; /* runtime PM reference taken for CS */
 
 	struct spi_transfer *xfer; /* Store xfer temporarily */
 };
@@ -256,6 +257,7 @@ static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
 	if (cs_asserted) {
 		/* Keep things powered as long as CS is asserted */
 		pm_runtime_get_sync(rs->dev);
+		rs->cs_claimed = true;
 
 		if (spi_get_csgpiod(spi, 0))
 			ROCKCHIP_SPI_SET_BITS(rs->regs + ROCKCHIP_SPI_SER, 1);
@@ -263,14 +265,18 @@ static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
 			ROCKCHIP_SPI_SET_BITS(rs->regs + ROCKCHIP_SPI_SER,
 					      BIT(spi_get_chipselect(spi, 0)));
 	} else {
+		/* Clear CS first, then release PM */
 		if (spi_get_csgpiod(spi, 0))
 			ROCKCHIP_SPI_CLR_BITS(rs->regs + ROCKCHIP_SPI_SER, 1);
 		else
 			ROCKCHIP_SPI_CLR_BITS(rs->regs + ROCKCHIP_SPI_SER,
 					      BIT(spi_get_chipselect(spi, 0)));
 
-		/* Drop reference from when we first asserted CS */
-		pm_runtime_put(rs->dev);
+		/* Only release PM if we still hold the reference */
+		if (rs->cs_claimed) {
+			pm_runtime_put(rs->dev);
+			rs->cs_claimed = false;
+		}
 	}
 }
 
@@ -279,6 +285,12 @@ static void rockchip_spi_handle_err(struct spi_controller *ctlr,
 {
 	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
 
+	/* If CS was claimed, release it to avoid PM underflow */
+	if (rs->cs_claimed) {
+		pm_runtime_put(rs->dev);
+		rs->cs_claimed = false;
+	}
+
 	/* stop running spi transfer
 	 * this also flushes both rx and tx fifos
 	 */
@@ -624,6 +636,12 @@ static int rockchip_spi_target_abort(struct spi_controller *ctlr)
 	struct dma_tx_state state;
 	enum dma_status status;
 
+	/* If CS was claimed, release it */
+	if (rs->cs_claimed) {
+		pm_runtime_put(rs->dev);
+		rs->cs_claimed = false;
+	}
+
 	/* Get current dma rx point */
 	if (atomic_read(&rs->state) & RXDMA) {
 		dmaengine_pause(ctlr->dma_rx);
-- 
2.52.0

