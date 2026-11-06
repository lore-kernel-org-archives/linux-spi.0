Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957569;
	b=XjxcFtdmmagOF2SpNzSpbs/gU3OxZTjw5JxV8WWzfXVMY+3UdbFreCWSMF6/Ie54tMDD
	 pnVKZV/C4bjA8jlZqyjwitAI3FnpaHhgp0yuLA5diLaK2eUOH0/D06PMDCtMXn6PQ9BVj
	 DTTBH4Gku1WiLREej3zOfE1z1FE5KLEA2sJN6AwCYKcVmwvJXdaO2+In0B3MrxJKT4Jyy
	 juBWmKOcgUZ3zkL4xKR774W3LQSROlTm0SmykXflpsT5fDfhngNxsD7Nnbxxv2pxuUd01
	 fY1g6DqCcAvQstu5E+z3kgAMTpFNu8PMWD3pKXh5v040xHJfQlzcH5MRYm8hGWxq6cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957569;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=Ol6OqvAnjB6xNfgKd5K3xVXQwuxfqgePZ/x70MPMbZ0=;
	b=VSBJZ3JweW/sTM3SGPyVsDpEpaQq0xI0RjRrFBFZDxAkGJ5FSgrzdJK2LvJV4sJ+AITX
	 9jqA0vD3U8Lp31xsEEtZPD+kixUjAO+WfF6+GRxRiY/1ngzVnjxnO3+UM8BFsg3XQysXL
	 GN6ucDWQwcgJkaD9KI6y97MVM2KmoCjPgL73ZMOOxDQnYiATCIl9cVfR5ZHSUIiw4PXp9
	 IQEg9KNdn3xqT/7kvZHcH3ZVZE9S0UQFUHEBboBc9NaFmQnQhailaJvfnSWjPnMNhSVlo
	 d/W+q849pIf+L5kxiLW1rTvPEjsUdfmT7HiqOMtMR7UY9Q5MzIjQC1zaxBdu2YMencw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=sAClafF5;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9AD606D807
	for <linux-spi@vger.kernel.org>; Fri,  6 Nov 2026 09:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D9AD606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=sAClafF5
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D933B1A0C32;
	Fri,  6 Nov 2026 09:32:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AD7745FFBC;
	Fri,  6 Nov 2026 09:32:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 47C34103292D4;
	Fri,  6 Nov 2026 10:32:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957562; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ol6OqvAnjB6xNfgKd5K3xVXQwuxfqgePZ/x70MPMbZ0=;
	b=sAClafF5dOAezz7dC47i/OrkTOw5xuRmEWg/B2Tb0Xvd159zH95MYBixLzaDBC5N5mNhQT
	jstSxmvOV2z04dn6vh4WiExtwmuhvBHzQ4X3FtduoPQrh1M00nwCBYh28Nw6mp1gYQDMBN
	VyxHbCINp7inn+84os5RZPoj2oPnsGTwdKWn3bAgci6/H2GBKZr7UCRr9/k7CyudIHU6BS
	wNiR2yp+fnOPHqXd7QQyQLcgr6s5uggxpexyKbwbTV3GV5NjIqigpjI4+IQlZ/rVpb0pbY
	EaUPEDnchwYltFiX1832wqGLFlmUEg3U47Oa6N6ydbP3PuvZAvZsLFSZnNuhgA==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 06 Nov 2026 10:30:15 +0100
Subject: [PATCH 18/25] spi: atcspi200: allow building for Metanoia SoCs
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
Message-Id: <20261106-mt2824-v1-18-86087eaf5af4@bootlin.com>
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

The Metanoia MT2824 integrates the Andes ATCSPI200 SPI controller. Allow
the driver to be built for ARCH_METANOIA.

Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 49088e5886d3..f8188de1b802 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -152,7 +152,7 @@ config SPI_ARMADA_3700
 
 config SPI_ATCSPI200
 	tristate "Andes ATCSPI200 SPI controller"
-	depends on ARCH_ANDES || COMPILE_TEST
+	depends on ARCH_ANDES || ARCH_METANOIA || COMPILE_TEST
 	help
 	  SPI driver for Andes ATCSPI200 SPI controller.
 	  ATCSPI200 controller supports DMA and PIO modes. When DMA

-- 
2.56.0

