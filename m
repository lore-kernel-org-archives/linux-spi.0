Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F64415F3B;
	Wed, 23 Sep 2026 20:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194228; cv=pass; b=WvpL+XQPlK2E4+MeTjvG3eeFOe/oGK2bbOpim+O8GiWKDnnQSX4/Hbnpxs845zmtbn4DK+dT/YGR80p3/7rCR3WVcC8JgmUpBUu1VC2dVywcKBsKOIrvy6kT+yaVidA7jWQVvaPQVppEWIMn3TSBLIdxs+7PQRw4n3RfCZ4NxTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194228; c=relaxed/simple;
	bh=Om3bne6e5wLDmiBtvRZ5prAOCxGQza0J/Q/HPL3m49E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JmtnTxg8yQcVjbio5X23UbONNBd8F+BOCtqlxOGgMkg4YT3yJsWmUw/9kdSTBE+QENW8j1sLGhLj2gfN99Eq1XmH6mYgulXR1rUbpoEsiyPAGssjKnRnoYZZfqd88/Hnjwcys4cZSS+/GT70lVqKibckwpVotwdUEj1n2KzZdPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=b+MLpwB0; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="b+MLpwB0"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9526020202F;
	Wed, 23 Sep 2026 22:10:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790194207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UWbbwR3wFmwejUcEgLdpxLeBPLMU+iq8bwpmFV36kf0=;
	b=b+MLpwB0UutuoML2iRV7D4qX2QDo3XvSjdb0UMmVtc5qNKW67CdFy9Abiwj4u3tfNLu1f7
	egd9Rp9fsIckcOVndFju4pebF3/nXkvbMnKLy9KID0N3upAFd9E49ASmMq68j0EUd3a9lo
	zmEclQoP6BoV8uF2qzlGvNWaVX8tCIripyRFiBLL8s+gVJdGH2VSoLHUHBWUKM3VEarSPD
	1lUBqsJuyi0t4DB+6GLp8OlsSUgkXsA5Pt29ytuIuEicVhmfIwWyyyaiSTfvgZkJm/C1au
	8gDGTkUN8dbPirugJ+HJsZRM5V8ktudsObipd0zhN5+QKqsW4ncNw5MdxdlCwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790194207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UWbbwR3wFmwejUcEgLdpxLeBPLMU+iq8bwpmFV36kf0=;
	b=by2//VZvD5Bjul9TIn+prXYWY9+oCBScQYx0RxuPOkQ0+NLvqKe5OJUQheOLlbksMAiTPM
	sHH5tgjbTIvR9rckQVSujWnfN+X/O13kOv0m+/Ev6ahGkfbvZ+mU1VaBRfxvHEEsoGk0GH
	O0Y/AoNPUM21RGqIMVnz+U3+e2hs3RxZE+JbuWQCWB+juf+n28n8r3E7XTf/rj6PiNA7ww
	a+N1D0crAI3e/m8p46xIHQKsFz96tIiKUfMWyFvhwd8jEi/oh2VhwPGIKoJ2J+l6XVYARN
	H8xsgF1jqD8UfuKYw4kJi4oynsdMLHiIpjI1PXlCHDkz2cJjHVfR2RBNU5cwxg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790194207; a=rsa-sha256;
	cv=none;
	b=ddOkLz2wEPhUpOyRGeyVeZrL095VuguUk2LUATHJbOtfo4n80ydZbLX80rXeTD2ujXkqzx
	Mp2AMuLfvsuR3Yrk1MnPx90xjTxIHqRTwY0Ea49Qp8SoDN72OEJYHFu0EBOdruijRLtzio
	UIQ3H+VB9pMZ69sLnIekP6oPKZ2KWnnonu+afdaZ3uqSYWqsLwmX8yj2qgzpQEV4YZydWn
	HWQHeu2gMjGWBANWOV9fUbu56cSP4RCS47ej4/NHGFeHYdkvFaGBQnh9UKFKU9PW9kHdoU
	fDkOD2e+vNk7sTNXXk5ixSWCA5/a0YJy3HCL0mDlb0o8EGV0fOJBexfRUairrw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <jre@pengutronix.de>)
	id 1x9TI7-002SC3-1h;
	Wed, 23 Sep 2026 22:10:07 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 23 Sep 2026 22:09:59 +0200
Subject: [PATCH v5 04/13] spi: spidev_test: reject zero-length transfers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-spi-sun4i-spidev_test-v5-4-25861c17426d@pengutronix.de>
References: <20260923-spi-sun4i-spidev_test-v5-0-25861c17426d@pengutronix.de>
In-Reply-To: <20260923-spi-sun4i-spidev_test-v5-0-25861c17426d@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=806; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=Om3bne6e5wLDmiBtvRZ5prAOCxGQza0J/Q/HPL3m49E=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaYiQVeUpTXpv7w0J3f86vWXMEnmtWfBLSOzFRO3SbQ
 N5T2wN2HaUsDGJcDLJiiiyxanIKQsb+180q7WJh5rAygQxh4OIUgIno5TL8s9jJ16jcfGS1Xsvh
 xn9t+po8xxdPjG2U9yyO9f15hWP9AYZ/Nr/n/38gpXFmLuvvP2/yA42+z5n8/2zwn7KX1ySyo5x
 CuQA=
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

Providing an empty file or empty string to spidev_test is bound to fail
because spidev_test expects the write to return greater than zero.

Reject requests to transfer an empty buffer earlier.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index b2940a25b7a8..49d40aa6d0ec 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -129,6 +129,9 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 		.bits_per_word = bits,
 	};
 
+	if (!len)
+		pabort("can't transfer an empty buffer");
+
 	if (mode & SPI_TX_OCTAL)
 		tr.tx_nbits = 8;
 	else if (mode & SPI_TX_QUAD)

-- 
2.56.0.rc0.108.gf0ef1b96a0

