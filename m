Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957510;
	b=ODp52sHxPFmKIBLa0U6PfYor6Ci1mTAUyXKnb7oh1IQCZwd7zC6qtKupX3PlkVqotF9e
	 LrEtRrpt7kuzmJMN6MfblEmsg9mRhqIsV/g30GSWqLpbSz1zeEst4yeFp6jzX6VvlScfu
	 O9J0gozP1NtM+G17GmRvucm7t0s4hHcA5JEDREMapbn73OZ+lVxtyJ+rSVfs7Fi0hVzuN
	 zTwWG259yliEYrSOdMK+XRSxLS6HlQwybk1M739dfwHTGvjrUOuOin7wWBVQIPb59CI+G
	 JUsOrx5WcG5xtIIjAMjzPIwF5EN64c6/nsIqkO3RWIb+SyBR6ACkjfXHmN7r0qqq7Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957510;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=/f+A9Mb+Dr9AA8h+IGk0mm9hM1KIlwRpJwCcjc3IH3E=;
	b=E/jU0QU+lmJLzdDrfLbGwLpqW0H7CbsqHtLeAkgsH9Q2FLeHl3rhXiuVdPnDTWCPwpO9
	 0EMH8RoeXlmKWlJGp0nGWSvpFuMxvB2hUp1CRC/6zdjYyDbTQejob8xd9ux9tI8VzBe0N
	 5iJDpO6UoG2Uufr1SNTYUDMGSBFdCwdYa9J6tNuSczePtozm7uSeU5YBI2xuJYu9E+wBo
	 X5kelCe1syCGiDc+bZGruAdDMyyJwSqLHcX6VYhcW/zASYVj0/YInt1DVMwpR/gEfe880
	 Whfjcq5IcZ0h+e4iE7FxvSpvPDs+gvnP+f4i76WzbU7Grp3H6vlp6uFrgQAIHtQO80Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=X6vvRrWD;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72B3606D82D
	for <linux-spi@vger.kernel.org>; Fri,  6 Nov 2026 09:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E72B3606D82D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=X6vvRrWD
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9322A1A1350;
	Fri,  6 Nov 2026 09:31:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5A1B75FFBC;
	Fri,  6 Nov 2026 09:31:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF23910329258;
	Fri,  6 Nov 2026 10:31:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957505; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/f+A9Mb+Dr9AA8h+IGk0mm9hM1KIlwRpJwCcjc3IH3E=;
	b=X6vvRrWDCBaEUkbIvoytSa35YPFuDIC8UF+uAHCLPrAdeiYysSLWa9DpcOc1UbsOI3f6xE
	nAIdK7YzElV0hpqezo21aqyGgqH9RIy3DuWBwILOnYdjnpoke1PZ1wfSukm657h2Y7irik
	A3EGcqQgODDTbQGvejpsfVNeIFuV9wkUEvZiCKa+Lf5r8LCfuDPM/nmdtyRsmTID9HAg8l
	JJipIhMiUR1xrSgQvdIrn36NfvOk9/5OG9WXS1+WUwDyoT0prQegBOe3htG9kenjvf80RD
	5gxrGzgN6wQM6Z0hm9Fab/I7GRxv7ybOWpN0JO0K2LCa/nabBakNbECFRAfong==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 06 Nov 2026 10:30:07 +0100
Subject: [PATCH 10/25] dt-bindings: mmc: snps,dwcmshc-sdhci: add Metanoia
 MT2824
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261106-mt2824-v1-10-86087eaf5af4@bootlin.com>
References: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
In-Reply-To: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jun Chang <jun.chang@metanoia-comm.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Sebastian Reichel <sre@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Ben Zong-You Xie <ben717@andestech.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Jisheng Zhang <jszhang@kernel.org>, CL Wang <cl634@andestech.com>, 
 Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Adrian Hunter <adrian.hunter@intel.com>, 
 Minas Harutyunyan <hminas@synopsys.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Randolph_Sheng-Kai_Lin=28=E6=9E=97=E8=81=96=E5=87=B1=29?= <randolph@andestech.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-phy@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

The Metanoia MT2824 integrates the Synopsys DesignWare Mobile Storage
Host Controller for eMMC/SD. Add its compatible string.

Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index cd823a3ef213..0ebd0f9c1d62 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -26,6 +26,7 @@ properties:
           - canaan,k230-emmc
           - canaan,k230-sdio
           - hpe,gsc-dwcmshc
+          - metanoia,mt2824-dwcmshc
           - rockchip,rk3568-dwcmshc
           - rockchip,rk3588-dwcmshc
           - snps,dwcmshc-sdhci

-- 
2.56.0

