Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9D9502D6D;
	Fri, 18 Sep 2026 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744994; cv=none; b=RmYQWESTiGCuqTs7e/DYec2mUMljWv1cDL5XJCwsePknyDZ4wmVEgxO52AISwLle8amrmfviHc+ayPFEX2trv/8SHNvRyK3KGrxOXQVDkzNX2XfYQwPMQj44GdIV/23v+jvMVcxZ2O2O1s0gKSDJGvI56hIuRFxMF/rcV8GeXwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744994; c=relaxed/simple;
	bh=mJaZs4FVyMEvTLT3VRG2o4F8L2qwm8a64IN9N+d+tyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Je4K6vglSzVNGKbLxrbXHym9Fv8LrwelqhPbYXJZnZZABMaZoMj04e8Yh4zuXCFBuxBDu75vnAgwot/4pN3rEylYd8stUOHKi9ka6rr+qyL/zUoFEmIl41G2q3mZhBGMxhnfH1LO55FOFsgHocB+EsJjp7DjwPaADF273nRAOPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 80437201DFF;
	Fri, 18 Sep 2026 17:23:01 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x7aQX-001awp-1J;
	Fri, 18 Sep 2026 17:23:01 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Fri, 18 Sep 2026 17:22:54 +0200
Subject: [PATCH v4 8/9] spi: spidev_test: print TX on error
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-spi-sun4i-spidev_test-v4-8-5ffacb1a4ebd@pengutronix.de>
References: <20260918-spi-sun4i-spidev_test-v4-0-5ffacb1a4ebd@pengutronix.de>
In-Reply-To: <20260918-spi-sun4i-spidev_test-v4-0-5ffacb1a4ebd@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1059; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=hHETDu9uonW3JsowDVUX9ZM5NSWu+HwgSoTAX14MMNs=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYshaGx6ypvxu0JKKowqND9uXFC5JtHwnmnLm/Dyd6e3Si
 lW7+HiCO0pZGMS4GGTFFFli1eQUhIz9r5tV2sXCzGFlAhnCwMUpABM5cZSR4bFqkq/bGk5bnSd3
 eDKuVEm1qfxk3dX+YevWcxKKKx3/9TAyrH6sdOyEj5i0x8SoHVFGh1+6TVhyz/t/1OmlzcWGJ6e
 94AEA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

From: Marc Kleine-Budde <mkl@pengutronix.de>

If sending an spi message fails, dump its first up to 256 bytes to the
console.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 9aa1e0849a88..1910facdd3da 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -177,8 +177,18 @@ static void transfer(int fd, uint8_t const * const tx, uint8_t const * const rx,
 
 	ret = ioctl(fd, SPI_IOC_MESSAGE(effective_transfers), tr);
 	free(tr);
-	if (ret < 1)
+	if (ret < 1) {
+		const size_t dump_len = min_t(size_t, len, 256);
+		int saved_errno = errno;
+
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

