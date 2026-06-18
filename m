Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B631283C93;
	Thu, 18 Jun 2026 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781801148; cv=none; b=Tz0Gtr94McRYRmDcrKqmjCBzVbKGQOP9N0Y3HhkseuCKFJ1s8Z+ntiwFEbzV2lgDeK0hJuZNRJmS2yOobXBCYJF+zCwq+0K0AiCNTI0nxwTXeRReMW3lBFIFdxEPL066Uxp10p8DcjYiRcZVrmsEh4IK59E1fL45Ao2axLYwXYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781801148; c=relaxed/simple;
	bh=xdtdWDHuS7+ijHi9evRJtWbwwBHAyZnZYQfHMBQVIno=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=tWJzTaMtJhXIxjh2grsnOxSvqQFPPsjSgQIngwmKM9UTVqVddU4bfnKYHXQrABuQXPZ3tfH4CusrDBfIdV9AUjaCHLAas8BAkCbyUzCUC9ZZLC9PpJe17RDOW+SA1yLNt9m7ecC4A4qpgfz2dPgzh4TalkCzR2doUj4n3BjyYcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=XUJx08cK; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="XUJx08cK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781801143; bh=KEeRFBmI0V8ihhn0Kb97Vwrgj5UI1MabY/4NbB2uDgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XUJx08cK+ZwHJRKl5AJCS0SF1N+HrhwAVr+Uvnk0zpbseG8vgT27l9d1f5jw/n8hr
	 6jD0AFEkK6dzcvt3qjjqnqDk2tDP09UjNqNWcsFOGnW1LqYd/7mSP//eeXKBfuNsxt
	 fY3fLHQpY8jQUMK2akUL01Vvx0ozBds7KeQeH7kw=
Received: from ws006419.mbzu.ae ([5.195.0.150])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id B558E2E3; Fri, 19 Jun 2026 00:45:21 +0800
X-QQ-mid: xmsmtpt1781801138tjzclgrbm
Message-ID: <tencent_21BF5F9512F56D45FD9018BAF14ED2805808@qq.com>
X-QQ-XMAILINFO: NyoSPuOlHoqzP/GN29kQKHe6X0se7Rn5lGhCiadvGSu5s5bjRgunnO/FJLoLTY
	 Nk1zzYuW6+6qI01PSN84ZPEzPR34tQF7EVIF1A0UVMIEEJoGW5ThZTRT2nStO4CY4gNCoXsz2KVF
	 IcrVgH0WreX1hX9GF9IZr7rMIz6vg5z/YzOoAsBI107vo3FI+OgfV8GF49pKmwYjy13JrswC4ADS
	 87zXA1HWSQ/O8Szp9Cx4LWRdu0dZAVLyPLCr6sSieTLDJ6bsTSANdd8UpKPjN9x7IV4zkfur//xQ
	 gm75URWd0Spdh8w7iqsCyp8lxQdSTRlAG11ZcxvdQSfSauj1MlmqJTiycL94qFmSJZJj67oo1Xft
	 B59BQ5am3uUV317eqCD9cEmR57WkQb5JGmdl/5Kl9TujuKDpknkulc+vq2D/2TeThcZVuM4X+DHk
	 /kX0OUCT8LP/6nc6qXCte8E3upmmpLnVSUA70+xroYXfbnR7THJXCFlh2CIWxFpPjvIHDEtpNV7P
	 Umte3V2nGF2TFnbw0X41Rh+pD9XotYmJDGYm+48zvHwE1s+UdRxqQAXL9jjmomODLjLfqRzhSZZT
	 jeqrD3OjMZSQgZTkZUUz8UPiHJ0+jBKBAeKxqmNQfzGHADRuXcLjVhV94xkHCENWkiGHEOfj62gQ
	 dsbte7Jm0ItZ21iYPkN7qhgwLoArOKVNsabCZK/RxRDRcM5EsclkadMee8NnP1o5okhUbnLQMFMP
	 V3Jr19wYQcK93ptTNB+w/Yy64WtrPzoxGLDB7aXYDt5SToIHoWsFb49dLdn2QFPVjNnbgqoTTnpq
	 DmqqIjB4KCR5ErCCAyhhKym7op/qq6lrXGs+Ubly+eXDHHiGdBCwetE8igNT3IY9UnGebs/hL+V+
	 23IJm+gw1g6R9T9ULxPIoKRv/tAEd+xR5ubVrKFoQVWDoolb6OdkA9zPJZWYWYCYdvd7GKG/E+dJ
	 BMXiMHF3PhqC9zJl/aEKbeIX5QfVcmsI724NJV8DDXhPm3/ZTkUvqbOzUa75DA0tMXurtk2CDpMv
	 /amnHMM/7JefuNwJU3QxLySKI9ZInocK1iTmA25QgXeXpan+qVA6paaaSAYkxcczptRV4adQ==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Jiawen Liu <1298662399@qq.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kamal.dasu@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	jonas.gorski@gmail.com,
	kursad.oney@broadcom.com,
	william.zhang@broadcom.com,
	Jiawen Liu <1298662399@qq.com>
Subject: [PATCH 3/3] spi: bcm-qspi: return error from failed controller suspend
Date: Thu, 18 Jun 2026 20:45:18 +0400
X-OQ-MSGID: <20260618164518.3885130-3-1298662399@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618164518.3885130-1-1298662399@qq.com>
References: <20260618164518.3885130-1-1298662399@qq.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

spi_controller_suspend() can fail if the SPI core cannot stop the
controller. bcm_qspi_suspend() ignored that error, disabled the
controller clock, uninitialized the hardware, and returned success.

Return the suspend error before tearing down the clock and hardware
state.

Signed-off-by: Jiawen Liu <1298662399@qq.com>
---
 drivers/spi/spi-bcm-qspi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index dcade7b99cef..ae1ffe13fa46 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1692,13 +1692,17 @@ EXPORT_SYMBOL_GPL(bcm_qspi_remove);
 static int __maybe_unused bcm_qspi_suspend(struct device *dev)
 {
 	struct bcm_qspi *qspi = dev_get_drvdata(dev);
+	int ret;
 
 	/* store the override strap value */
 	if (!bcm_qspi_bspi_ver_three(qspi))
 		qspi->s3_strap_override_ctrl =
 			bcm_qspi_read(qspi, BSPI, BSPI_STRAP_OVERRIDE_CTRL);
 
-	spi_controller_suspend(qspi->host);
+	ret = spi_controller_suspend(qspi->host);
+	if (ret)
+		return ret;
+
 	clk_disable_unprepare(qspi->clk);
 	bcm_qspi_hw_uninit(qspi);
 
-- 
2.34.1

