Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11BE481657;
	Thu, 24 Sep 2026 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257459; cv=pass; b=jL18LNfBhV/6HrNv3hKmPWqh6j48k5c5ch5Hm6KQWs1m37riSs6ba43IUs7ptnINY6F9N5ADyAZ/cNgjbCh/dMFvOwNdBxg0WYpfmmKintK2j5kgDr8cz5sN6lDOJb3ecFQtwwF7ZGXrh301Q14fPDn6Hd1hYlgJwl9L1L7iCP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257459; c=relaxed/simple;
	bh=e1lyzIN2yK38kMVVEnZr4CyFEuSoy1/+Xx5TAndcZZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GfEJHxWUsrcZePSknyc0WxqhdXB/Jhu1p8ZGH0i/Tqngpwgl7VXBJ8tFVX5yaTckubGQjjLRMx+4lWOjhIYRvlsPD6NNVGUYJp6U1Vh05YXkR3PD4ZFJPKokdgVlxHvleJGGpPRj+jaDIPgSmkKRNq2wTzUj8cX2srVzV62l4L0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=YcJNw/ib; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="YcJNw/ib"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C872A202139;
	Thu, 24 Sep 2026 15:44:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790257447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5VKvwYgTV+3klTNx4TKLlBFDJQwc6zphT2d4plwh8xg=;
	b=YcJNw/ib/qJWFsPWYn8ISHj6gx47mbRJOs3LuGkPfjmY8YKMmTAJNkYpwDEZzOZxQUtYtK
	0yEaae2ixVuSbK2636Ixl0jMghKuEuokoNgrlGv4bInQ/clXiXFDeSCtyYHUhM40MeKo0W
	JA9bt71Qf3gnn4Qk79Fe8jv1KUTuqE/Rc8O8hud2u0DMEreY2z+x0lW+2fUmFf3YY5vmu/
	sbV7FI0t7ChJN0wl+zb2eNi0KWjvT4mj0bNrezln/yHqJ5qCuLPBpjlMX8DwQgOCXx+Dlx
	HQi9doIjXZ+INwOVrj+MMrHKS1OK43vzEtYAstm+I/nu2bV7ir5NOBcGYdHvIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790257447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5VKvwYgTV+3klTNx4TKLlBFDJQwc6zphT2d4plwh8xg=;
	b=Qs26ka44TG3udFP5MGuo/LJ24TCnN5Vt0VCPVRLm7SMRCEyjCERmDBqLxEbOEpMGKL0pw6
	qTpMACDufVZuZ5v9tDKQZo4zsSmjU+veKWogVSnsCh/K+Fy/LESCu8t0JkRHUkpFKe6Bsy
	zkTcCQURvrV/XjMbEJT8xkc/5ChDeSmcPyP8VNWofUAy4ALivhhhKpWvZ8bAKxzP2hYkNn
	ml3jwRCPPC9bvodQ8oXwoT0Z0rn1WMYmN8+/2xUL4jCVC0XkOvujOp4mmua5PDJFtJecKz
	QgXvpA2zR2aAilSx0rmdrn34ncjRV8xJ874rc9xuroS3ZnH0mzOaiaWEIq8b6Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790257447; a=rsa-sha256;
	cv=none;
	b=FTpslgkUua0eYiUAlZqrJVhIbRhfIDJ6857j5iUCN/o3XHX9T4SVZEsfSMLnvoYsA6gxGn
	0+sESXD5++f0WbvCtuO2qHdeO2fbW6vVMsKj+OqAh9p3yqokWQvWKIa6D/+xTt/YHx0YMb
	ImU81VZky5rNcZAYbEnbYnsbKn8knj63EdiZ3t7lzgIfMpt2rNMIVE7+7eZwTeWY8fCeZu
	DbDAMTQ7vW8RkBHG96B4H3E40ggLgnPzkXutJOqbuuaTBdp4OWX2cB97CX4uXXsUwsvRg2
	fRsZgNMml5ejyK5/sO5XpN/QMrs0AiZWRBZqAiqeqCvKXUHG3etK521oR6tTpw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de (localhost [IPv6:::1])
	by dude04.red.stw.pengutronix.de (Postfix) with ESMTP id 94E83380A10;
	Thu, 24 Sep 2026 15:44:07 +0200 (CEST)
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 24 Sep 2026 15:43:54 +0200
Subject: [PATCH v7 04/13] spi: spidev_test: allow zero-length transfers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-spi-sun4i-spidev_test-v7-4-126e31a07fdc@pengutronix.de>
References: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
In-Reply-To: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1433; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=e1lyzIN2yK38kMVVEnZr4CyFEuSoy1/+Xx5TAndcZZA=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaqqn07KxttFn6Z8cJJ1Q+KJ+eInnq6cLrbal7I1c4S
 Gx9debsmY5SFgYxLgZZMUWWWDU5BSFj/+tmlXaxMHNYmUCGMHBxCsBEDM0ZGVakTamTXd1d0hy6
 PrjhLodWyxZdgZT9ywt6k4++errk9hpGho/5qqZOZgdFS979PP+86bDI68nnYq1YXp95cMPi87R
 X+WwA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

SPI drivers may in fact handle zero-length transfers. The behavior so
far was that such transfers would be executed but then result in the
"can't send spi message" error message because the spi_sync() call
returning 0 would be treated as an error while really it simply
indicates that zero bytes were successfully transferred in a message.

Don't treat a return value of zero as indication of an error.

Update hex_dump() to work with empty buffers now printing e.g.

  TX | __ ||

Now including a trailing newline.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 36292d868d69..908ed038889b 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -68,6 +68,10 @@ static void hex_dump(const void *src, size_t length, size_t line_size,
 	unsigned char c;
 
 	printf("%s | ", prefix);
+
+	if (length == 0)
+		printf("__ ||\n");
+
 	while (length-- > 0) {
 		printf("%02X ", *address++);
 		if (!(++i % line_size) || (length == 0 && i % line_size)) {
@@ -149,7 +153,7 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 	}
 
 	ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
-	if (ret < 1)
+	if (ret < 0)
 		pabort("can't send spi message");
 
 	if (verbose)

-- 
2.56.0.rc0.108.gf0ef1b96a0

