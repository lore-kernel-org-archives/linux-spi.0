Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794226912;
	b=ugRP8DOCQKwHaqCVavBwKCzQNwIXE8v9gC+63lW7Cnu2+Jav9MLrXrmbq2156bofTNW0
	 pkOmWozYY1dlNLL1jjrlvy76Ry5nnxat5AUBx95mOm8FTCm/9hDtMxVuQ4QnrVjcyh0KB
	 aGtBwpT2r/Q1LExUnueYGaKDcWwfitiSX7bchIlFXn+6ORUmR7M7QOYRnX/kDewkUgAC8
	 ge2zMUdAsLZBgqwb4xOpxlwniyyDtkZr3O75u4Uzz6+8nFrXJK8tf3+sMXq2s4qQSuBbe
	 YriBCoHWg6c42V616jCh/+/npVeGrqx/wyzBkML1vYe4miiY458mCwOpGeyKQnIh8EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794226912;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=QZWyCYHr/HsyFjRq29nPhG5ATMBkJbGsYYo5IXpluKQ=;
	b=4vuHCNhjTH2ElUyNdYTOfaVCLu5VmluPM7+boZKFnCZsUJPQtO+lIpvZL2Cw+IbjteLM
	 y6zNruU0KrdBNB/ltdzj6OUpRtR3sQ4Npl7mP4KRGpy2fh8g0GZzOTZOBxfrC1iDpBEH+
	 Lq2+LS5fbXeOkFrhIPDS4hUU1d+I8rDBwGpi+uIqamGGIisgZX8c8r1SJSvfLaDvTAYZG
	 z2xe0fVcXelmeB85f3czn1tZntzaQEgZnhP6vOghRohnH8QgO4da6tOBe8PFRHQJBnnhO
	 ZYdiK6mYl23qyiwVhW8Xz3l4zUNpbwOaB0CLgpaGCDXH5MZS0H42VszaUUgmQ281Ivg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h7Qfqioa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D35606A33B
	for <linux-spi@vger.kernel.org>; Mon,  9 Nov 2026 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h7Qfqioa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B8B1F008A5;
	Mon,  9 Nov 2026 12:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794226912;
	bh=QZWyCYHr/HsyFjRq29nPhG5ATMBkJbGsYYo5IXpluKQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=h7Qfqioam/D/5w2PzgamsM03NMay4HWN1Rvz1UXHNQcbvlhS27kdj5TsYt1FKNEza
	 ARMuqO+YvW/qrAkPyaV4Db1O/vULDs2T3EXnj49bDR1JDR2it6iw1r7xauxIeVbZbM
	 dbBI+fWmR1DUNuxNpkRLNa1M2d+C0VcnbXcx5k69Bl9IiZLJeaLzn2neHzKbl3m0fn
	 OSwFw5U8k8Wk2fIWPekaFDSsFXz51bMa0KWDovQMIOmR6VNhybFoKXSYCedsrPaLPJ
	 1JuJ8/eNo7JeOLPkJ+68DNLCkiiq/d867c5qJYrlwyX9Q4l4NdDgPcK85UOcsrwisx
	 /kP1auC9IaR9g==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id D83C92DBCB3B;
	Mon, 09 Nov 2026 12:21:49 +0000 (GMT)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/2] spi: add KUnit tests for message optimize state
 on queue errors
From: Mark Brown <broonie@kernel.org>
To: Joseph CT Chan <jctchan@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, Bart Van Assche <bvanassche@acm.org>, 
 Joseph CT Chan <josephctchan@google.com>
In-Reply-To: <20261103224753.3610049-3-jctchan@gmail.com>
References: <20261103224753.3610049-1-jctchan@gmail.com>
 <20261103224753.3610049-3-jctchan@gmail.com>
Date: Mon, 09 Nov 2026 12:21:48 +0000
Message-Id: <179422690845.3711751.1326863430764451372.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206; i=broonie@kernel.org;
 h=from:subject:message-id; bh=uc/pDuqXqW++692NFBi9eZV9wdFu/QR57Q5vO5aB8I8=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI+7rr7wsvkiV/rI73Z629/z3a0fqjE0x21RppH958Am
 50+9xG2jlIWBjEuBlkxRZa4LO6X9SWv1/AdXNgGM4eVCWQIAxenAEzkpCQjwweO1NiXNd932ubf
 cqv77vnuRc00Vz3zpe3+39fNfb9fgpHhn/IeG58lXdlM/5QDssOlBTewFmfHLD4379vp7z5m74I
 deAA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> spi_async() and spi_sync() optimize a message before they queue it. If
> queuing fails, for example because another device holds spi_bus_lock()
> on the controller, because the controller's transfer() callback returns
> an error, or because the controller is suspended, the message is never
> finalized, and finalizing is where the core normally unoptimizes it.

> +++ b/drivers/spi/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_SPI_OFFLOAD)		+= spi-offload.o
>  obj-$(CONFIG_SPI_SPIDEV)		+= spidev.o
>  obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
>  obj-$(CONFIG_SPI_DMA_KUNIT_TEST)	+= tests/
> +obj-$(CONFIG_SPI_CORE_KUNIT_TEST)	+= tests/

This ends up working since kbuild will deduplicate when sorting but it's
not how things normally work and might break in future - normally the
tests directory would be unconditionally included and it's Makefile
would have the config checks (which it already does).

> --- /dev/null
> +++ b/drivers/spi/tests/.kunitconfig
> @@ -0,0 +1,4 @@
> +CONFIG_KUNIT=y
> +CONFIG_SPI=y
> +CONFIG_SPI_MASTER=y
> +CONFIG_SPI_CORE_KUNIT_TEST=y

You should also add the DMA tests that are already there.

-- 
Mark Brown <broonie@kernel.org>
