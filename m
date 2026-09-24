Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BAF480941;
	Thu, 24 Sep 2026 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257452; cv=pass; b=ExzoMnw/wwHLxDH0pGRFohC3lNJ4zVdLDfX7y2xpPUQF3wE0d+0Qd9KHgHm1Hx5L0iciLidZLGQRBTJaVVIfn3HpddKhcDeT+iyAc+tY+clkF3d8+K3s4id4DoZnOotyFDgrPr/YSoswLiXLT28PNMCCwevqxi81ZF0os71FSgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257452; c=relaxed/simple;
	bh=YL6bGPb7MprYfUaFW/tPvVJKl6Y/8aB1aa+Lk/BBNUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T2wXQhWJhSdT3kb02b7E/UrGcn6WHXUfJ9YMB2hfJTkzBeP4DUIh/jS4ZziXSibBD+1e4g+xbGsk9t7ZWmKrEC6+iHNQDmgWGNCOEjXzEfAyndTuS64R6qRgtxkNFuVR5pwW1ma8++FKFXjKzxisbB5NIr7UCmvUEnuumIlCaWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=O2yRnT6T; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="O2yRnT6T"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C09B7202122;
	Thu, 24 Sep 2026 15:44:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790257447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5CDoSXUgWZ0smyrwuvUxoUgbXYI8V3xlaN9/Q451+sg=;
	b=O2yRnT6TlCyHFj2uATaSnMwc+3yjfeTcGoyl95UWJ0cHCHw+p4sZSsEXe8QxUDa8+km4XP
	yPa3o2S/kyKLhcqEaLwzDlARNvw4tQ0DqREN9soUbciALNoJX+wR2TQO5J6GklwSy5qxLM
	cXtPX+GpclijCQZK9IkRAJ5P6n/qBgjVdzruDKuaMf/fmvdM+ar3H9A0o4odDRxIHMOZzt
	cC82GotQ9UCb1CfpTYeB0kQrRtBWjVmx6jsUlZkNyfSbJ2XLpKgtA5C03d3uiJ1ysFN3zh
	XwjbW9BGAqGp4dtTNNRUbpMi4EnBvYFckrZdWw5iemUQY/yIATyeAOJn9sNSGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790257447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5CDoSXUgWZ0smyrwuvUxoUgbXYI8V3xlaN9/Q451+sg=;
	b=ZKGMOSaXvUjUsQreK2sl/+KKzO6RI5w53nytV6k90cixqpTFox3C8wndnvDAbYdn34Aoj3
	uNzoGg6N0oP3dmFiVIlim7HjmJFrz8naufFdcNKLhaLbZHXV/GGK5Je0ZqOtPKOUxIP7G4
	afVQ5vn7sXQJpZt6GrOLACav+3kHpUajEBFGjZ2hqf2zaqICrW5o21xLLpZD/vWJzvfYpr
	MDMGWRRFZcEzXs0hXC8hLzFiZkME2DyHId3/rdW+Pk6VN7DZSFJ0WLLmSM8YTDVkzBCOXy
	ajbuJUTm68vvnXYO/5FpsfxG+JVBPaCloh8VXu0eZVKgB/v/Dw3in8jCsz5lQQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790257447; a=rsa-sha256;
	cv=none;
	b=S4cdx/4Is7W28V/EtPtCgm25SX5MOsaTEfqNcvBjUq/WzeUOM198m90euflrd4XqV/n3Gx
	ofxM/eRnq3C2qE6yR5Sjl6fYvDMHh2F7ZBYvoeo/9s2p9NySIh4uGJHXvtW3q98GJDvm/F
	jjBQVG0hT5xki/khZvLCgwfSFJ8MMJRa2BGGkB5teI7NnuCN5YC+kR9XZZih8OE/BXLaS+
	aQK8eErsUbCV6FHfNKePndPr3gOkd/Y5ON8YUtpFpa+X7H3l/QzNJQ5rhYUw8pWe0/H2+y
	c1fLq742Z/+TcnXVrnGKVsvr+TdtDi9k4p2Wh8I4t9Jif/ufYOVduxYELCeFfA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de (localhost [IPv6:::1])
	by dude04.red.stw.pengutronix.de (Postfix) with ESMTP id 951B1380E3F;
	Thu, 24 Sep 2026 15:44:07 +0200 (CEST)
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 24 Sep 2026 15:43:55 +0200
Subject: [PATCH v7 05/13] spi: spidev_test: abort when -I is selected
 without -S
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-spi-sun4i-spidev_test-v7-5-126e31a07fdc@pengutronix.de>
References: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
In-Reply-To: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=880; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=YL6bGPb7MprYfUaFW/tPvVJKl6Y/8aB1aa+Lk/BBNUA=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaqql89n/N/8XsWj1pKkeWlExlc9pxO+zvkprJXUccC
 1X931ju7yhlYRDjYpAVU2SJVZNTEDL2v25WaRcLM4eVCWQIAxenAEzE+DzD/9gXcQHL2XXtPz/T
 3rs+Pjg5JaVugkLiYoHwDX3t93b+b2T4w595f8chyf7VufcPaO/0ePt8TsmpNZGCql6yiU8MOeL
 fcQIA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

-I (--iter) for transferring multiple iterations of the selected input
currently only has an effect when transferring random data using -S
(--size). Error out if -I is used without -S to avoid confusion.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 908ed038889b..97d09bf4dafb 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -463,6 +463,9 @@ int main(int argc, char *argv[])
 	if (random_input && transfer_size < 0)
 		pabort("a size argument is mandatory for -S (--size)");
 
+	if (iterations && transfer_size < 0)
+		pabort("-I (--iter) is only implemented for -S (--size)");
+
 	fd = open(device, O_RDWR);
 	if (fd < 0)
 		pabort("can't open device");

-- 
2.56.0.rc0.108.gf0ef1b96a0

