Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794808527;
	b=GzCGL53XmLeZikMDmJk3i5ZiQXaUK24FP+5yHxQOighK3k5jA/mfGDtjeZJ+KeoG1K0A
	 6MMF2OsE7pJVc4X2jWikxnqMjvUE0XLdtc4iUAwEqswgFTmiKelElew93Ncz3kwOkOzEC
	 4eIC5hB87O6mjNU7CsKMPqtBVibTtoIuac2sJGjk/zcT+jk2h0PqeA/4+UTpFHzJmCObR
	 pvVfUpPazynZR4vFfKkV0VExVQT+x8+hgULACnnZFGtiOhpUjq7lXU8xmYB84lUXxI3x4
	 y3an4EBMPq9IfMoQmX0/1ijgQf8vCt6XGD0t2kUzEk5q/9LCS7QnYsMSvf+pNh+KZ5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808527;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wPBLUs7n7EA3PCBReUyBuI9nf/OddWHzE5Ejpf9ULYU=;
	b=VDOK2lEzhkb//m6dlY1rLowekQgCc1lVXdOL2t7Pjz1w3HOj8wu7p0LHtJXH2yGssJPH
	 /HY3gJA6grIytYorBMTs+bayMe5CgCjBhFHQBeRfbx3/IAj36Kii/8DrgJuDnUHvvQL+Y
	 k2V0KjLMyAa7xmjezpHrKnwp91w51eaH5PofQJmsQZFl1TtCnrqqWTfVgYun4jdiPN897
	 C+y6zulCTOhc1o1b8owCbqT4hmUYqXvEDFIS9m/zYEyWTf0sgy0LXB9/OQ5fkln5u+tM6
	 ug1YAGWZIRCGeOrtH0xUHRyVH85aGYx4tsMufXDImjDA22M1eczOb96yeqekzlH8wJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PM9m+4C0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD49606A32F;
	Mon, 16 Nov 2026 05:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PM9m+4C0
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794808526;
	b=hFxKzhYcOkeRRpvfB7xbOgZ27KMuLCrTQpR6Xi9OEXkGl+wQfuNTzARtV/KIQFijLQrz
	 5iWOMJvp3hbMSUTUlNQ8mUU75DxFY/bQgjYIY1+tLiBR6fBfb/OHHL076uxL9zkjZ8nsP
	 Zec5zeaYw29AP3YUrGEp2ecfMopRj51MEDTToCgS5PTP3OM8XOfyz1nVEV2pTU1vVeg8A
	 ZdfSXdl9yePD2PnoIwqFvD2TO/a+JA5BQw72+UzQDl5+MFYNUQsFo6V+qPIuI3LA0Inn6
	 /lvoPX5NYphOlkA4EVP0vJkIeSfTDTXLr2QR1MPS6xnbWodMtzbvu2hJv6ASm6LEOCA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794808526;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wPBLUs7n7EA3PCBReUyBuI9nf/OddWHzE5Ejpf9ULYU=;
	b=28b8a1KOTlD3ZftvqAGN6Kqb3ViyA9NpeeEPgK2znLdZk3lslB6vsSPsMveKxS/aKqsi
	 S4nV2Mgh38fjAtxGhEHSYbSc1HhEKQ6rbAqggAw5JiykUW+eR/DlT4z6FTUpO4AhooiDs
	 KdEB1d1vv/dioCnMQ+MIrjAC0QQtzkuMf6znv5e+1ysCaZwffki5K3zIsNgaHxzvMevEC
	 rT5Y3znZCpOAjeXBH0IXzXlH/b6wINDDjCep+l/8BHlcGEb9nW6LUyYnxvD0XmtIWoQ/J
	 ZeL1pCpo1Ba+XIjN4wMktO+qs/jL26Dr9cZS1EDaieHdovxcvo14VxkYfpT20Dhc4yw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EFA001F000C6;
	Mon, 16 Nov 2026 05:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794808526;
	bh=wPBLUs7n7EA3PCBReUyBuI9nf/OddWHzE5Ejpf9ULYU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=PM9m+4C0eY9sjlNiT9rhqbWXMFCp3QYk+zaKB9Iynd7ADdAvnc6MzqgilrC5QTXdX
	 jW1oDzLAJbmVTQ8zQr6Kx0UvS2TDb3mmLakvnvtM9HZT7X6EybMcQOyaT+PZgwRc82
	 //scF1N+WSCupzyeXcz33MUuL08kqbyQ07w9L0OOZukGOm4i7Y8fTjAcTdLg/kelk6
	 mFw7vIXG1nSSDZJiglgsMvA2GtH6iqVd3jOzeS78nWJvGEyPvvAXnKlZWtBQb4vRMn
	 ex85SfEjHbApQFih/J6qwIGWJuAbyG27Og7VuSdeOgQIg5zlCwXgGuUgKUq4OvOr2n
	 3zHrkcE3hpTXw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7FF174A33F;
	Mon, 16 Nov 2026 05:55:25 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Mon, 16 Nov 2026 05:55:26 +0000
Subject: [PATCH v2 2/2] spi: sun6i: Add dual read support for the H616
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
Message-Id: <20261116-spi-sun6i-h616-dual-read-v2-2-e0c66eb71e20@gmail.com>
References: <20261116-spi-sun6i-h616-dual-read-v2-0-e0c66eb71e20@gmail.com>
In-Reply-To: <20261116-spi-sun6i-h616-dual-read-v2-0-e0c66eb71e20@gmail.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794808525; l=1884;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=/aYd9VQyOFWGonPeySJDcD8WiJeGpg8qKpxGGrt1DFM=;
 b=VnJoB2BxeoaDrHHyJpU9gow+SGuG52MelLJnvbcmmd25ti+CsGbKWlTGYpu6cp6l2+nOOGvqc
 bd8DYfK6z6RAiTrzstYMoO1rzEKA/P65tCY1CIYDy4BfP7ceYhHH1qZ
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The H616 SPI controllers bind through the "allwinner,sun8i-h3-spi"
fallback, which advertises no dual or quad modes, although the H616
manual documents the dual read (DRM, SPI_BCC bit 28) and quad (Quad_EN,
bit 29) controls that the driver already programs for the R329.

Match "allwinner,sun50i-h616-spi" with the H3 clock control and dual
reads. Dual writes and quad mode are left out: untested on the H616.

Tested on an Orange Pi Zero2 (2 MiB Macronix SPI NOR, flash node with
spi-rx-bus-width = <2>): 1-1-2 reads (opcode 0x3b), the whole flash in
0.30 s instead of 0.52 s, repeated reads identical.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/spi/spi-sun6i.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 6b7a05dd0de8..3a77ade87fbe 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -778,6 +778,12 @@ static const struct sun6i_spi_cfg sun8i_h3_spi_cfg = {
 	.has_clk_ctl	= true,
 };
 
+static const struct sun6i_spi_cfg sun50i_h616_spi_cfg = {
+	.fifo_depth	= SUN8I_FIFO_DEPTH,
+	.has_clk_ctl	= true,
+	.mode_bits	= SPI_RX_DUAL,
+};
+
 static const struct sun6i_spi_cfg sun50i_r329_spi_cfg = {
 	.fifo_depth	= SUN8I_FIFO_DEPTH,
 	.mode_bits	= SPI_RX_DUAL | SPI_TX_DUAL | SPI_RX_QUAD | SPI_TX_QUAD,
@@ -786,6 +792,7 @@ static const struct sun6i_spi_cfg sun50i_r329_spi_cfg = {
 static const struct of_device_id sun6i_spi_match[] = {
 	{ .compatible = "allwinner,sun6i-a31-spi", .data = &sun6i_a31_spi_cfg },
 	{ .compatible = "allwinner,sun8i-h3-spi",  .data = &sun8i_h3_spi_cfg },
+	{ .compatible = "allwinner,sun50i-h616-spi", .data = &sun50i_h616_spi_cfg },
 	{ .compatible = "allwinner,sun50i-r329-spi", .data = &sun50i_r329_spi_cfg },
 	/*
 	 * A523's SPI controller has a combined RX buffer + FIFO counter

-- 
2.55.0


