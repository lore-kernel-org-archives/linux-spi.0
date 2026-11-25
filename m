Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629107;
	b=aIFGUmUshuaUrv3QW0kqsu5jaxlLi0b+JkldVrSJHIn7BfphKcNUYOjl3pqJz6m7ymm5
	 6Kmilwrqj0NDLgJBwb5HRGqaoq6mRF0jir0QS/g/sPT+zbykWqWMmiQR31I7FF/A/mI0K
	 K7P1atcSQLmHFni+xia50qvT+dPyrw9niJihYoX8+SB+Gl+Ez3pXnmxxR1ZgsfJNJDzzh
	 M8m2gZOoNpiCYmXeUmGolcndHwnS0ZL7VDYOOYtogwYcnQJN/uBlTtJOrHMqdNkZ3QOX9
	 zw+e26XI7bMLTKkt8Y5nyq+RlYyl+Pdn3ZnsRu8hYJp3RrhffKP+DQMRPIh4XaixzQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629107;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=fhMRTzkLSH5MxpIkUJMv2XmW944j+sfZQtVHooeXfNc=;
	b=MifNbQZOkbHL9q2EfbKzqGuG4mWok6yYAwroxEk2DxtJmfQq/7sjxghv9Ugr6h31zJXX
	 wkkxIA0PJhVGZOMiGQZ0AZUWA9Lu6l2hWABN2BBSqKN2TAQONu4p8DD7F8mcoU1FQY5M9
	 hefeNnHDH63Kgz+MpuVnqAX/WDgDXpsCEMUcDEkr4fUHW038ynT/41jtsEbPYx8mzLLkC
	 b5botyYNye4KsDKjKxW+N8vI1M7FVb9xbXWvlhov3xxyFOIA7l84vFE84+vKxOUBJLGrr
	 jkDaJOnD0u4sd4nD1iO+bwE7EWwwVlGTuqVIP/qR9IB+SiVsbUzlr4i3awjqi0J2sLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=rjIba73h;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BF3606A33A
	for <linux-spi@vger.kernel.org>; Wed, 25 Nov 2026 17:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97BF3606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=rjIba73h
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4F9544E41786;
	Wed, 25 Nov 2026 17:51:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 203C260480;
	Wed, 25 Nov 2026 17:51:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C6C4E11E6B0CB;
	Wed, 25 Nov 2026 18:51:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795629099; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fhMRTzkLSH5MxpIkUJMv2XmW944j+sfZQtVHooeXfNc=;
	b=rjIba73hZY4git7Vg/XhATFE76hCuXmQOIhpokw7phcPJkpu77IDcANyPWfhmWmpm/wwkw
	7zbQD+YFwagsL7TNez3rOk+tOFWqoaCfJAx1uuqP216t7R8+f4CsYaufNaWbd4w2ksU6ls
	o09e1p0lj1XUqz7LHURSpJFtq+Htd9sNCARv4WJwIT/kU4e9pb0KPG4o3J5r6pNSJh8k44
	2smGQ9sg7zZrrVxSReD/fxJB3988w6XyQ0OTBaxpRuQWXI9S5DchsjnJOE9ylpGWH584fK
	UT5SFyzDHqH0XSUkJ1oQK2DgBG1Vi5MEfWCZMTtyf4OYFjw9GBbwtUwG2zVYGg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 25 Nov 2026 18:51:15 +0100
Subject: [PATCH RFC 01/16] spi: spi-mem: Handle a corner case while
 sanitizing ops
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
Message-Id: <20261125-macronix-upstreaming-spi-mem-cycles-v1-1-fd036402fd37@bootlin.com>
References: <20261125-macronix-upstreaming-spi-mem-cycles-v1-0-fd036402fd37@bootlin.com>
In-Reply-To: <20261125-macronix-upstreaming-spi-mem-cycles-v1-0-fd036402fd37@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Liang Yang <liang.yang@amlogic.com>, 
 Feng Chen <feng.chen@amlogic.com>, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Han Xu <han.xu@nxp.com>, Conor Dooley <conor.dooley@microchip.com>, 
 Valentina Fernandez <valentina.fernandezalanis@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Jyan Chou <jyanchou@realtek.com>, 
 Yu-Chun Lin <eleanor.lin@realtek.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alvin Zhou <alvinzhou@mxic.com.tw>, 
 Cheng Ming Lin <chengminglin@mxic.com.tw>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 imx@lists.linux.dev, linux-riscv@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Some mixed mode operations (such as 1S-xD-yD) will be flagged with
op_is_dtr but will not enter the ODTR checks. As a result, the number of
command bytes will never be checked.

Reorganize a little bit this helper:
- If the operation contains a DTR phase, sanitize it.
- Then sanitize the op, should it be:
  - ODTR (8D-8D-8D)
  - anything else

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mem.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 8047b7508c8d..c64e906ba919 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -170,6 +170,7 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 	struct spi_controller *ctlr = mem->spi->controller;
 	bool op_is_dtr =
 		op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr;
+	bool op_is_odtr = op->cmd.dtr && op->cmd.buswidth == 8;
 
 	if (op_is_dtr) {
 		if (!spi_mem_controller_is_capable(ctlr, dtr) && !ctlr->dtr_caps)
@@ -177,23 +178,22 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 
 		if (op->data.swap16 && !spi_mem_controller_is_capable(ctlr, swap16))
 			return false;
+	}
 
-		/* Extra 8D-8D-8D limitations */
-		if (op->cmd.dtr && op->cmd.buswidth == 8) {
-			if (op->cmd.nbytes != 2)
-				return false;
-
-			if ((op->addr.nbytes % 2) ||
-			    (op->dummy.nbytes % 2) ||
-			    (op->data.nbytes % 2)) {
-				dev_err(&ctlr->dev,
-					"Even byte numbers not allowed in octal DTR operations\n");
-				return false;
-			}
-		}
-	} else {
+	if (!op_is_odtr) {
 		if (op->cmd.nbytes != 1)
 			return false;
+	} else {
+		if (op->cmd.nbytes != 2)
+			return false;
+
+		if ((op->addr.nbytes % 2) ||
+		    (op->dummy.nbytes % 2) ||
+		    (op->data.nbytes % 2)) {
+			dev_err(&ctlr->dev,
+				"Even byte numbers not allowed in octal DTR operations\n");
+			return false;
+		}
 	}
 
 	if (op->data.ecc) {

-- 
2.56.0

