Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979464D7D21;
	Wed, 16 Sep 2026 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580532; cv=none; b=WBLGbcTwhvopH/JwYXzt1lTJBDdz6kgy89DFRujpTGEZVmhYx5jELcPWHwxlCHnCAzqLBtgw1ZGgE87KxKATEITmG8CWlIWHmOgVkKlITV451tSl3s5kd8a3WZz932Rv+gRwfslvet0NTlRCt3j6yoLfje6kHjAySguPw/rWxJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580532; c=relaxed/simple;
	bh=3ZXTXnZRe/6Fa2sgOEhSAIjFrhRlyL9A0z9yxKKFUpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iQutYUM2MDFxmcEkHCZJWcleMmUv30xy2j3nkfIEUkUtMKYpSbnSstMkg8bpTXz3dGQnQbUZTSKdTSoFNFPkroIGYBM+9UybW+rn9hJhXevAN03hBh8kl0OzqhjdytipvO85ynUJc2NwtIp5HHndMtCydKL0dS15SamyacDABX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-PTX-Original-Recipient: broonie@kernel.org
X-PTX-Original-Recipient: jre@pengutronix.de
X-PTX-Original-Recipient: mkl@pengutronix.de
X-PTX-Original-Recipient: kernel@pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D0D902059F0;
	Wed, 16 Sep 2026 19:41:29 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x6tdR-001Gol-2P;
	Wed, 16 Sep 2026 19:41:29 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 16 Sep 2026 19:41:25 +0200
Subject: [PATCH v2 7/8] spi: spidev_test: print TX on error
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-spi-sun4i-spidev_test-v2-7-e7d25bf96e4e@pengutronix.de>
References: <20260916-spi-sun4i-spidev_test-v2-0-e7d25bf96e4e@pengutronix.de>
In-Reply-To: <20260916-spi-sun4i-spidev_test-v2-0-e7d25bf96e4e@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1048; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=VknB9YyTMiQyXngLqRNCO17XzE00y4Lx4ZePbDwsdLE=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshadeWEWYaI0otdR0un5ce9n7qo2Eqhbv3vtlv7RHJiT
 KPcGDcv6ShlYRDjYpAVU2SJVZNTEDL2v25WaRcLM4eVCWQIAxenAEzkXhzDf+eAc0a3HtstlUub
 +/Pu8/l/dQ+dlm1YkLK9UbLqcNKv47oM/wPW7l8WrJH+oW6Zv88lmR8xrmXPIrYFKHVYzvira8N
 QwwwA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

From: Marc Kleine-Budde <mkl@pengutronix.de>

If sending an spi message fails, dump its first up to 256 bytes to the
console.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 6e5999b621cd..93867ebf39a0 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -175,8 +175,17 @@ static void transfer(int fd, uint8_t const * const tx, uint8_t const * const rx,
 	}
 
 	ret = ioctl(fd, SPI_IOC_MESSAGE(effective_transfers), &tr);
-	if (ret < 1)
+	if (ret < 1) {
+		const size_t dump_len = min_t(size_t, len, 256);
+		int saved_errno = errno;
+		if (tx) {
+			hex_dump(tx, dump_len, 32, "TX");
+			if (len > dump_len)
+				printf("... (%zu more bytes)\n", len - dump_len);
+		}
+		errno = saved_errno;
 		pabort("can't send spi message");
+	}
 
 	if (verbose && tx)
 		hex_dump(tx, len, 32, "TX");

-- 
2.56.0.rc0.108.gf0ef1b96a0

