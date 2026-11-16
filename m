Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840576;
	b=CmqWzgvjS88BJSwLI16Sl7D/X03o4hUwdlu4k3Khb0x97C9+I8GPdH05F289/p8L2zrD
	 Vk6+wjm6gm1z2c+3TuYNqrkfr8cxYkiT+iHZt/8tfh8adDsWcF6iOwKXi1V9pAutKRP05
	 Ilt1fHjV4fk/+iQ2f+1Zbs0v9F954NuLLp5gcRZA+/lMBVeJqIfZbarMu0T+mJwDghkZO
	 GiqbEpEtfCEu9cPBAk540M7qeGeRbAIhXuRg7HSud/y2izuVJxx7RsvKAk9QBn4zNzB1B
	 Lk4zReBqV+C1g78P6bz8iLz1dADu7nhC3ux9O60fvQSk5RskKyDJPo51a7uFgPXpujw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840576;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=npfZK7W8Bp9paacaxLF0kqkWMJTXuX5iG3UN6ApFE/8=;
	b=EQVzUT6WrXD/vcug65orhQN5USsmVy7Pu+fllSbVKHIQY73ItdQ6ftsqPqUgSZ1h3h7f
	 DiEJ+VK3vGrHMhhkjzqa6+wjGWkX8+HT79c9G5+MZcYHFg4BX4l7Ask80Z4jO/uddd9ue
	 nheRuaABVXKNncPKFYl0+it/kls32hYbK4WpYXl4Z+ydMm8q4RHOMa6uayTgE8jgHObLQ
	 P/l9K1aEJ8Y1WutPJo8Sw4HGkbZepgjvLOs1ASTYalEy0I5m3VkcCnzWHsD43uwiavUdm
	 QaIwpZVNW+Bm6t6WyC8HkUzZsklCI4GZ0B2E4gyaSRYAMzGanAj+qmM4oFo3usBB2+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TCkMsXsw;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A67606A32C;
	Mon, 16 Nov 2026 14:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83A67606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TCkMsXsw
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 203EE4E41607;
	Mon, 16 Nov 2026 14:49:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E2E026023F;
	Mon, 16 Nov 2026 14:49:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0531A11BC05D6;
	Mon, 16 Nov 2026 15:49:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794840572; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=npfZK7W8Bp9paacaxLF0kqkWMJTXuX5iG3UN6ApFE/8=;
	b=TCkMsXsw0vPqbYSF117iBfd1nPrPAXb7HjQFdYTu02WXw6zIu6rxu0WAW23tXJCXC+TiJw
	xjWbT3OrHFcuqVRhDhP0Q+7Q5ZRELMRrF+UNazUTCI8QsbZGwIQtnMiEst6GLOyVDY50CK
	A0HbnyoyY2HIVlRFvrCqlAsU0kWbCdJIUFRK6/Sg8wvCE3vtfeAclYvascIJniL5Owb9bj
	HN64+Ylw2/m+iKPPuwjmi+LC2Bfw6ZA63e77un5UUMv8N/whiZ5vwVBeF8zkIKx+tuD94D
	Strqu1TR/vOQNwiu7ZCATjvW62JOIrK29//4YPAm2fYIK9SE0hje9YLRhC0w4g==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	George Cherian <gcherian@marvell.com>,
	Witold Sadowski <wsadowski@marvell.com>,
	stable@vger.kernel.org,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v4 1/7] spi: cadence-xspi: Properly handle errors in .transfer_one_message
Date: Mon, 16 Nov 2026 15:49:04 +0100
Message-ID: <20261116144910.44151-2-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116144910.44151-1-paul.cercueil@bootlin.com>
References: <20261116144910.44151-1-paul.cercueil@bootlin.com>
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
X-Last-TLS-Session-Version: TLSv1.3

From: Tanmay Jagdale <tanmay@marvell.com>

The cdns_xspi_transfer_one_message_b0() function was not setting
m->status on error, causing it to be stuck at -EINPROGRESS, confusing
the SPI core.

Additionally, reset cdns_xspi->xfer_in_progress on error.

Fixes: 931e389ded0f ("spi: cadence: Add Marvell xfer operation support")
Cc: stable@vger.kernel.org
Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>

---

v2: New patch

v3: No change

v4: Also reset cdns_xspi->xfer_in_progress on error.
---
 drivers/spi/spi-cadence-xspi.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 3687853e4ce4..442595daf7b5 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -1112,6 +1112,7 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 	int current_transfer_len;
 	int cs = spi_get_chipselect(spi, 0);
 	int cs_change = 0;
+	int ret = -EIO;
 
 	/* Enable xfer state machine */
 	if (!cdns_xspi->xfer_in_progress) {
@@ -1152,7 +1153,7 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 							  false, cmd_regs);
 				cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
 				if (!cdns_xspi_is_stig_ready(cdns_xspi, true))
-					return -EIO;
+					goto out;
 			} else {
 				cdns_xspi_prepare_generic(cs, txd, 1, true, cmd_regs);
 				cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
@@ -1161,11 +1162,11 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 				cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
 				cdns_xspi->sdma_xfer_len = current_transfer_len - 1;
 				if (!cdns_xspi_is_sdma_ready(cdns_xspi, true))
-					return -EIO;
+					goto out;
 				if (cdns_xspi->sdma_handler(cdns_xspi))
-					return -EIO;
+					goto out;
 				if (!cdns_xspi_is_stig_ready(cdns_xspi, true))
-					return -EIO;
+					goto out;
 
 				if (rxd)
 					cdns_xspi->in_buffer += current_transfer_len;
@@ -1202,10 +1203,17 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 		cdns_xspi->xfer_in_progress = false;
 	}
 
-	m->status = 0;
+	ret = 0;
+
+out:
+	if (m->status == -EINPROGRESS)
+		m->status = ret;
+	if (ret)
+		cdns_xspi->xfer_in_progress = false;
+
 	spi_finalize_current_message(controller);
 
-	return 0;
+	return ret;
 }
 #endif
 
-- 
2.47.3

