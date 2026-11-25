Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629164;
	b=LXHL9LHF9DIeGnoHmw33PaWPMW7a8Wgap0KjwnTrToHzXAj9A3sEDhPOY2+jkOQmqYK6
	 8FGFd/uGt5mNbxbORbxhWebGxDqIeXl3EpbEQmrWm/46I7zh75WeWgjbMnF1P//aEg1Ko
	 u2r5ZI7bEtelcyipO5GooZUklZlilw5uSgzuZf+bokvB1VqCGxhlcsPxZCOrPMuizLrpm
	 qoW3Fki7BRDDfzG3D00bBxjMpA67OsSLVThsYJz+VeSFbkQmX9xTfY1Thnm1ghE6wd3Z1
	 TNQgCCawg1rorpb21fU9ldkCUJ9H8AoTHXY7JYv4FVtJ7jw2s0FLrBp0CviFkM2ebyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629164;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=1pBgsX7SEhiUyvzBszeDzEbYO5y9r9uClK7rqjgYFvg=;
	b=NhBwR5dsqxKyMe93IKkcDNaeV0jBkkrGAhYoz79qJWR8sgR0H7Y5vFGlfd0iJuamWKWX
	 5kOhg0l1Egcp1LXmV6hRzd8ZCI+0FTtHOt6xrNakZ7TWTcLyok3/3thzDkoe/CDdd2NG4
	 hce0ya7zSwfLagnlzTV7NbcoLTDlVZKDTgqjn8la1+pTYmNpzu/zMOs+YJor37BiGuQKr
	 qcr/8hKqfBlzRhLVpQBwL2dFLfUTCGfOOfyd0rwarrJOQSxRTCX32kC7s3VLlXD/VIPsL
	 hDVO2y+rWXyALISirenUV61GqRYSJZ2Mv/Rz0n7hwFNqUQLa/jcthxo7GeQ0GWcO7Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=xS9v9bc9;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BDB60A2623
	for <linux-spi@vger.kernel.org>; Wed, 25 Nov 2026 17:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80BDB60A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=xS9v9bc9
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4772B1A17FB;
	Wed, 25 Nov 2026 17:52:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 19CF860480;
	Wed, 25 Nov 2026 17:52:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CBFD611E6B0C5;
	Wed, 25 Nov 2026 18:52:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795629159; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1pBgsX7SEhiUyvzBszeDzEbYO5y9r9uClK7rqjgYFvg=;
	b=xS9v9bc9yVgyTnhOEc5GrZbH5tv5Lk9cwg3hUTHKMznf3BHRgoTOmPwLVnmwSsKF3jRcQn
	kqhWk6bPV1QHLICPk1tlaURZX5g2/bboIR1oQQzKHg+fyXzMTlcYVoaPqGu6XlsbMjtUF1
	zfECYzuJll7bZdiUI2axOVWVzNOO7Leju5Gy5xEJZfG6WPcaE6hIxir4VNMScpA5fO/RfX
	9HZKyGuliTMohmOvM976vUzeV8aw/8/A/0uDA1YdR4gYQ14kAel1AvlKLsyS4CXl2Ibbf0
	uRzi5JhkNr0JbDcXLvYW6nMGEQXd14XQurizoNBM1hLgqjnvVOMct679vd0S5w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 25 Nov 2026 18:51:25 +0100
Subject: [PATCH RFC 11/16] spi: nxp-xspi: Fix a comment
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
Message-Id: <20261125-macronix-upstreaming-spi-mem-cycles-v1-11-fd036402fd37@bootlin.com>
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

Looking at the i.MX952 TRM which is I believe one of the SoCs with this
controller inside, the maximum number of supported dummy clock cycles is
64 and not 32, so the code seems more accurate than the comment, which
needs fixing.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-nxp-xspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-nxp-xspi.c b/drivers/spi/spi-nxp-xspi.c
index 8b836662a5da..ccd00c744d18 100644
--- a/drivers/spi/spi-nxp-xspi.c
+++ b/drivers/spi/spi-nxp-xspi.c
@@ -407,7 +407,7 @@ static bool nxp_xspi_supports_op(struct spi_mem *mem,
 	if (op->addr.nbytes > 4)
 		return false;
 
-	/* Max 32 dummy clock cycles supported */
+	/* Max 64 dummy clock cycles supported */
 	if (op->dummy.ncycles > 64)
 		return false;
 

-- 
2.56.0

