Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789516;
	b=NWcnbEsqh2hrXV3ipeg0x94OghgdsBdjhxs/71bzIhSUdHmeokHEXc5G04jRv/AzJOoy
	 Wq72u221caCUrQ9i0BbufQcFzneJFFvYCWedckjnBL8FMcpSBuoO9dMAQClkLs+9sa4VG
	 qg024NlHiHN9z1/A8IPZGBLA5tWIkZQTgg7ZH/Gr7ikRY/KRz2/m1ndnPLefrzds26rT0
	 1wsSZYeCXnOq5yg7YCNJAjp1Ic7/GX9drzymFq1JXnG81LSWWOYwcfJpM/FSj/AiUwtf8
	 3qIiHCb6yCVOzXGvOsP8BD8U/wWQmBOFWIPbuMJdqL/g6HTjaBE8YeNxa05hMSnbRuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789516;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=jwWNjtl5ORcZ1deftfr5RsBJJtV3zrm7nwySNJ1wAXA=;
	b=edIIFMRnEJlkrSBEE4hleZzwv4aHPapV+CpteQd7NRkBkettXJRogm2SlPC221TCNzRY
	 Eq+Et9GgBR1rgOPCP5QxG5IhdXoLjG3vS/jF1Li1zeq45XKUeWB438aAFVtLmDT3Ja43y
	 dT7OZS7pdMnCa599vc382fo+JGRzKKM6PEY9x+9BK7rmLtmIbhJonJB7G4MY46PlAvkBk
	 E8Hci7eYEJXbSiNrqVxSTTRQsz11BJZ2TYLVi6yUMZTJkjbW0CEMkTMWfeHp49t7GLCaS
	 QP545yXY18nVSLQESAnXU4l4D5bdOhsx6hLUce+Tcuc/HBStUN9CUGLH9+dlOwtPAbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=UGbmJbOd;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7BA606A6A9;
	Fri, 27 Nov 2026 14:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B7BA606A6A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=UGbmJbOd
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AD089C2AC51;
	Fri, 27 Nov 2026 14:25:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E1F2A6049C;
	Fri, 27 Nov 2026 14:25:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7CE7911E68FF9;
	Fri, 27 Nov 2026 15:25:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795789512; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jwWNjtl5ORcZ1deftfr5RsBJJtV3zrm7nwySNJ1wAXA=;
	b=UGbmJbOdcNVCi3ELelQsVl1jbj/ViXJ795sQ5pB3eqnkHRfW37/lv0w4DTEUZsimBvjKCZ
	bwLNRPX6CT6PCRoWg4O8d0RqL8UAZjsezDbumzXw1CxZHA6jNaFMZm96NIyled1ziyLbto
	EDofliexKT20UNgI/5pJY4LUYzTNFdlI8Y+PHZ1gbd+CdwFHrEYUQSkSfi+aUFjpRu06Tk
	zbPC6kZLAYg0sGkrMBcyaw6bKjWtQzrQOmpW4Ka+gZ/Hgi5+nlbcUbjGZ5pzPxjrE2Wasr
	ysa9IYTRL1ou53CorKfDhH/uN5bAQr9L6imMuj7CJS7cODFKpnbgndqbzELLtA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 27 Nov 2026 15:22:36 +0100
Subject: [PATCH RFC v2 14/35] spi: cadence-qspi: Drop now useless checks
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
Message-Id: <20261127-macronix-upstreaming-spi-mem-cycles-v2-14-5c93f5e5d630@bootlin.com>
References: <20261127-macronix-upstreaming-spi-mem-cycles-v2-0-5c93f5e5d630@bootlin.com>
In-Reply-To: <20261127-macronix-upstreaming-spi-mem-cycles-v2-0-5c93f5e5d630@bootlin.com>
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
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Michal Simek <michal.simek@amd.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alvin Zhou <alvinzhou@mxic.com.tw>, 
 Cheng Ming Lin <chengminglin@mxic.com.tw>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 imx@lists.linux.dev, linux-riscv@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, 
 linux-trace-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 openbmc@lists.ozlabs.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The controller programs the dummy phase in clock cycles, so the dummy
buswidth is no longer used. Drop the check requiring it to match the
address buswidth.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 97725ffeae93..d52e0aa1ea41 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1522,13 +1522,6 @@ static bool cqspi_supports_mem_op(struct spi_mem *mem,
 		return false;
 	}
 
-	/*
-	 * The controller has no separate dummy buswidth: the dummy phase is
-	 * clocked with the address buswidth.
-	 */
-	if (op->dummy.ncycles && op->dummy.buswidth != op->addr.buswidth)
-		return false;
-
 	return spi_mem_default_supports_op(mem, op);
 }
 

-- 
2.56.0

