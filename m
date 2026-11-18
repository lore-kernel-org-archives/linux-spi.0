Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010123;
	b=3ZKUQxTd4l24IQL7uq8aXpkamgvQryOwmYpElp3MPhx6XfZCLnACddqwxgQgYgiNTyWS
	 EecTQkC//LVEbw0sDN8Vw++Hm+znSsoTL7CDNACub18xknPy/u0d8HB0hsyFT5sBM+J+3
	 vwOdqSkcBfDYOv7rlZSqkx4Mu+wGC0SBPklJYBY7Ea1ra8Ww2p8wUKTLMbvb6w7S9br+S
	 MxqwlVCaxXokeCmU6dJ+Hrk1mIoQOj9WfhSQ1QyoVVdL78cvotwfuTx+q2U5tuRYbwUJH
	 9Qa1zGOtNgNX2V3adk0mQPJT2JILL1LMhSr88pAKCqCjomCVR1e++TVkoNRz6AMih6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010123;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=p8W7nF+8/0GpmdrafluDmhLN8w1Ilw7JEncFQW6UsL4=;
	b=SqO4LMbdslumfAT6AOYyMmLAcwBqIpgU+uJ4RgMlt+lym9d2/50MBi7dppBYx/AUHzQn
	 ZN+tA8AAVIdXiV6pKq1RrKnHTuOAMwo5LaQ+bmTf3kgUGnoEaKO2/Xzyh3w9gdH9+x8HZ
	 Nfo3gOQzvEWXLkc0Bugb5u21Q0RelPgY6ljilk74tYmMD6vJHhGK5A1r4cGEWN4J/kyqu
	 uZYYfvVNBN/axo9lbuSQRUbFMhXbc5BhTZ9/oY1hknvm4bK3Qzvn+DHj/FR4GmSijL3VK
	 IcKIqC4P1e1lQhOSd9J0aOB0x0XSc9AigRFE2U1o/yHXO5JcKsbQ0LA4IBXNqSe/+sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=w2yA106F;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DC4606A325;
	Wed, 18 Nov 2026 13:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41DC4606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=w2yA106F
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D0DAC1A16D0;
	Wed, 18 Nov 2026 13:55:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9F71F5FE9B;
	Wed, 18 Nov 2026 13:55:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AD13D11BC212E;
	Wed, 18 Nov 2026 14:55:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795010116; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=p8W7nF+8/0GpmdrafluDmhLN8w1Ilw7JEncFQW6UsL4=;
	b=w2yA106F/QARJtffg2Mqi/520RwGck5KpeQQ4jvq8fQoIoV0grdRDBCrbv6sRkAKc5tzHi
	o/HWK/FAYVhWG3AMY+CasirtlljF00E78NOvfi6lqpoJcYRDAshlobSaGTQUXrn6P6S8Ji
	rG9XdFtiH131BFkbwnGtk8HYbd8sMlMDjjPq0P5aVEnWiIzAcV7J7Q5oBQ2ENGbBCq8hqb
	O2/X/dMnsabSjnlaKuPKMOk+sQ/fig3Ocgmbfy26JMdDxcwMICCOa5vZYMugY8v0hDzwHk
	2qE8Jmzt0aaIdmTLvhqW9lq30AvuTXTzqaxHSpy23lMae30lbL7CWKyhgaWNxw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 18 Nov 2026 14:54:57 +0100
Subject: [PATCH 3/3] MAINTAINERS: Add myself as Nuvoton MA35D1 SPI
 controller driver maintainer
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
Message-Id: <20261118-winbond-upstreaming-ma35d1-qspi-cont-read-fix-v1-3-e5066ad2efe3@bootlin.com>
References: <20261118-winbond-upstreaming-ma35d1-qspi-cont-read-fix-v1-0-e5066ad2efe3@bootlin.com>
In-Reply-To: <20261118-winbond-upstreaming-ma35d1-qspi-cont-read-fix-v1-0-e5066ad2efe3@bootlin.com>
To: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <stlin2@winbond.com>, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

I have the platform, I currently use it for my developpements and
therefore I care about the clock controller driver and the SPI
controller driver not being constantly broken. I would like to step up
to help the Nuvoton team (not visible in the diff since they created
an MA35D1 catch-all entry) in the maintaince of this driver.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..cfceb0a635dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19982,6 +19982,13 @@ F:	drivers/nubus/
 F:	include/linux/nubus.h
 F:	include/uapi/linux/nubus.h
 
+NUVOTON MA35D1 SPI CONTROLLER DRIVER
+M:	Miquel Raynal <miquel.raynal@bootlin.com>
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
+F:	drivers/spi/spi-ma35d1-qspi.c
+
 NUVOTON NCT6694 MFD DRIVER
 M:	Ming Yu <tmyu0@nuvoton.com>
 S:	Supported

-- 
2.56.0

