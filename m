Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911034;
	b=GNuSqWo66SoBJf6bbPuIMf+4zP5hD5zy42DSpafvwNPdkkUNsYJuJd7v6dQaaoUtxAMZ
	 meptdF4QIuS4nB34VT6T+HPanXDiC3YNixomUTxym/wC1bJgNGMEV6ff3ndp2X2XSDOu/
	 CgS8KepgZMkTu3bJIMQu567f135XCHKScAaiL5K7MEW+WaNbHFWtP6KuuNj3DaYRTBRtn
	 gtQD4MKLxOd/ON9UZaGGiKTsVWQCqj3ZMzhNDEjGBb3C6bcCHrb2TYM1tIEa2WWngm3KH
	 U1z1KX8j56yNA/4WoIvBbLF8+TOaVkLitYNoXe02wzm+fCjMY7SmhMd79edr2C9vhnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OsK3MYz9w+yugO7b/K4HKpqaj9q9ojfCF04yLKl5NIw=;
	b=3OlM3hJzFGbrJeUSoUrinM/5z+ooVbQI3W2DrDYkU/PZA2vYiBWgY5XYgMDQFfifzigq
	 q7y7r9UL3IyKwAPhFaNfzMyI6FkUfJLvibm4lCm9HnWSJv3fYIBeJw5iF//AY4GDxpjLv
	 yH4gqZSByMtZvGIG+C46yvBY5BbVJuJCCH513ZuQGrvX93btrJbGJ5eGClPmY3Z6DNPnQ
	 rLHP6SA8DqyF6TbL7h0zbuKmsSUQ7+0S4tEJ6QlE8uwwAZlu0l5DmiAMgER78DGAUZmtf
	 Bk0ob4Apt0TD+paBRrQKIcoccpKx2etVSoql2VHZDy4A47FAAoN81B1eCFSXAldAuBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VLjqKX53;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3055606D83E
	for <linux-spi@vger.kernel.org>; Thu,  5 Nov 2026 20:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3055606D83E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VLjqKX53
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so14977566b.3
        for <linux-spi@vger.kernel.org>; Thu, 05 Nov 2026 12:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911032; x=1794515832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OsK3MYz9w+yugO7b/K4HKpqaj9q9ojfCF04yLKl5NIw=;
        b=VLjqKX53wk2FlolXU992mYaqTGC6wNE6SL1bf8QJbpY98Tjjoj5etV6rIWnkHCHMyK
         DY9jMhCZSs8tIRoXqSTSTwTv0rUc2yc8AcipQ8x0oASHwAoSRKIzGQLyr2+TLrZK2AgJ
         CLEXbvJmPZReR+mKjeljGXlfzQvMxTmtqH/zJ9WnCtBs2NGntp1Asc47G3hqnluqi2Hd
         UIcMf5ucETFTStS87oIltmPeCcqyoeBw/mdnqckIq4nFhZGFEFR9YPVh1QyVtifGKEqz
         io3pyglCWXXduhH2emNal2Kp2pZZLk/XbvxQJ7eLZNogyWXLPPyCAhNIzJ/M307brPyu
         DsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911032; x=1794515832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OsK3MYz9w+yugO7b/K4HKpqaj9q9ojfCF04yLKl5NIw=;
        b=Qh6L9sk2t2n4rZe69+mPn+oknDE9/tYDtDQP+uGELO4/mi/1aPNdES2hdjDkc4o3yc
         4ki6On8fRc/v2OYSthds7dX/YCwTgsOXghr9EsSDrCcq98N7L9W8kJkD68tKKLpdT1yl
         Mfctz1fivuhsDgg4ahStXOk71Wnk6LyDnBWCuPQmkMD1cHfBXNVQ9EF0dQVwqo3Zhe2x
         fC5yvCNGrBch12DagBLpgpXG6bsEcgpRRK2OljzwgrlGaRWzi+qowSaxTo4OybnqcZxS
         Q4QeVnw73i2XooaUcMBhZb2yk9pbl0GLFKAVEYoIdDCo1zcpV/1OCzeHdavydZrtoZ3B
         kLHw==
X-Forwarded-Encrypted: i=1; AKwUvBwxs+rfPKPHnuK7KvP6gsFZbZrKxLcdXtZkzSydau+mpF2Jfdta9ap5Ifc2N++AFoj5tRSGP4FOfE0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+q9FuwFdNLy4BDr3yhPDzsjR612i9m0JNgBh7uIipT/h4nSdlJ
	18BVItIjxWXpeFq+yWTxPc6xNdes3VDhnct64wM9fPkCAcbKgxz6ES7M
X-Gm-Gg: AYBFou0xh6Qkm+i85TExTltMv6ZPXKJsXFYnU1g9AczHSRMfxN0psP7erJZLdeTNOgH
	Jgo8SuRIW77pCiA1W5f7HYdmJemIIpheyLkp/m2319yRVkKrgHUH1dGELScWut06H0tDqI5KBt/
	30Lte1fUMcOBg10jhgeaSuUIeT+LYmoRADp+itBd1gN49bTWapfZjFkEjzmva2o01dIOrD3agFs
	FxwA0oTvLVaLrq5gntCyxGR2XAtuZ3XpIbucBmoKaKhjXZ4fqlZReMRlD+Cl6Fo6R3yWKlPZPiB
	5IDidVQzH0E15abxYJPqoq7fFe3+/0i6MIrqkGieRkIMW0FxmGnyIt/EpAybYecAltcdCwrH/Ae
	UK/Xh/4H/jPv1JD12Qe/xgNeBRpAzaZoR3sOiq3hr6tw3UKdMc1FbAbO/iK2hU4T5NkUQzGVpB0
	QwS0pEkNqzAPegzwNzZzT3FK5+6bFncT/BK0/w8RKLBapGW+fFgTtpzD6dIGjn+z0LjPkbBLcH7
	/SqfPd1RXbHnrXIZ3mLZ1pmjIzQcbb44+Xp7izScjrIj5QjWAda1SyIJe3RmtDzYOggE74tYCRv
	rtm3ohT/07i1ViYLC/Zb69GVNgY9RQaRcafzrNBptQtE8tZh9yTMMJEzWVjXMuDWweKcW3FmBKT
	c8f+/nJC6+G1tFPWK45Ebg/TqxiOPqza6VRixg6Kt9uKDIIOTQUE7b4lLdrzfXKRoPrC6zwVQCQ
	gKriYbV1C145fqjNMdyLpDF+Dp/ou8ZS4WH8kGZaf7colWMx5Kgss7mYoVIF4Zk6N9vg==
X-Received: by 2002:a17:907:d30a:b0:c3e:cb50:b7c8 with SMTP id a640c23a62f3a-c4d353f3dbcmr54320266b.12.1793911031659;
        Thu, 05 Nov 2026 12:37:11 -0800 (PST)
Received: from mb-HP-ZBook-Power-16-inch-G11-Mobile-Workstation-PC.dynamic.ziggo.nl (2001-1c00-1106-0900-938c-4ed8-a3bb-093f.cable.dynamic.v6.ziggo.nl. [2001:1c00:1106:900:938c:4ed8:a3bb:93f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d3569f518sm15429966b.56.2026.11.05.12.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:37:11 -0800 (PST)
From: Mario Behn <mario.behn@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Mario Behn <mario.behn@gmail.com>
Subject: [PATCH] spi: cadence: recover the controller after a failed transfer
Date: Thu,  5 Nov 2026 21:37:03 +0100
Message-ID: <20261105203703.979067-1-mario.behn@gmail.com>
X-Mailer: git-send-email 2.53.0
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

When a transfer times out, the bytes it clocked in are still in the RX
FIFO: the interrupt that would have read them did not run in time, and
the host path never drains the FIFO between transfers (only the target
path does, in cdns_unprepare_transfer_hardware).  Every later transfer
then reads the stale bytes first and returns shifted data, and the
device behind the controller looks dead until the system is rebooted.

Seen on a Zynq-7010 with an AD9361 on spi0 under PREEMPT_RT: after one
"SPI transfer timed out" every register read returned 0xFF, the status
register showed RX FIFO not empty while the bus was idle, and a later
sample rate change failed with a calibration timeout.

Add a handle_err callback that masks the interrupts, drops the stale
bytes and brings the controller back to its initial state.  The next
message sets the clock mode, the clock rate and the chip select again
through the usual prepare_message, transfer_one and set_cs path.

Signed-off-by: Mario Behn <mario.behn@gmail.com>
---
 drivers/spi/spi-cadence.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 50ef3a7871c2..474ce14a59b3 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -542,6 +542,30 @@ static int cdns_transfer_one(struct spi_controller *ctlr,
 	return transfer->len;
 }
 
+/**
+ * cdns_spi_handle_err - Recover the controller after a failed transfer
+ * @ctlr:	Pointer to the spi_controller structure
+ * @msg:	Pointer to the spi_message that failed
+ *
+ * A transfer that timed out leaves the bytes it clocked in sitting in the
+ * RX FIFO, because the interrupt that reads them did not run in time and
+ * the host path never drains the FIFO between transfers.  Every later
+ * transfer would then read those stale bytes first and return shifted
+ * data.  Mask the interrupts, drop the stale bytes and bring the
+ * controller back to its initial state; the next message sets the clock
+ * and the chip select again on its way through transfer_one.
+ */
+static void cdns_spi_handle_err(struct spi_controller *ctlr,
+				struct spi_message *msg)
+{
+	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
+
+	cdns_spi_write(xspi, CDNS_SPI_IDR, CDNS_SPI_IXR_ALL);
+	xspi->tx_bytes = 0;
+	xspi->rx_bytes = 0;
+	cdns_spi_init_hw(xspi, spi_controller_is_target(ctlr));
+}
+
 /**
  * cdns_prepare_transfer_hardware - Prepares hardware for transfer.
  * @ctlr:	Pointer to the spi_controller structure which provides
@@ -727,6 +751,7 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	ctlr->prepare_message = cdns_prepare_message;
 	ctlr->transfer_one = cdns_transfer_one;
 	ctlr->unprepare_transfer_hardware = cdns_unprepare_transfer_hardware;
+	ctlr->handle_err = cdns_spi_handle_err;
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctlr->flags = SPI_CONTROLLER_MUST_TX;
-- 
2.53.0

