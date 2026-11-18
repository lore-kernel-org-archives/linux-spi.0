Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010107;
	b=oqBfEcD8bnO2mJxMk0knd4PUg61ZLWB7H6hZIlt2ZYWqOGHKPhAt7XcjXi0JOqfTjyTw
	 D+fNdSTQINP15QF/IdXFCjZI5FJy96M95+poyJxu/NrjoYaG4QMJ6jmAzUP/LeLXPMyEp
	 eVtP9vKzBze5JrutuaJB6X5i5dRwIKX5yU/UEcSd5IJUjNf/FE/NypsmfYrSA19WlRMY1
	 4yhBNXFoUsDTos9ISbTp8xymPsY24MO95yho1gSV/mZOnqci8/iKAXrhG/LSLllC7IvHa
	 hBSa8UtTwbEkiWlVbOLbfPJ7rH5Zysy3iiAZZUjPzAks5I4UcWpLTtiin1aNXlezM5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010107;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=YF3rO8Ic6p5GJpGsgevV8sf20D+3CyakkHcPRmAnado=;
	b=K35R8ouDoKERe1CeV18eVraRV/SOgCWw928gNqeYNltGqEriw7+RWGVJRJC1Xx0SnlHV
	 RkCvUtXKXG5qa5Judue90+CwN2wu4pRR56XGAK+d2M+9JyKU2HJ+bH+BD8cZSUg7J41WJ
	 2CaEa266FclcGDo02eLiB6OHqgCpS8hz1+c01OE6vpXZJG8xge6kgMV/7YONNBKK1jLur
	 GrF2hxOK2rgymv2Q0R4icHiACQsf46CsCZ8CHpHJ1jNb2qIvB0GLSaLXIyjPu0kpy83B+
	 /aNb2KLpFYr7Xs1xriFHoqa7635JXZ4gr76K28lMbmnLjyHM9Y7AfkGYs4B7DqHZvVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qMOUxDEU;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898C1606A31C;
	Wed, 18 Nov 2026 13:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 898C1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qMOUxDEU
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 385441A16D0;
	Wed, 18 Nov 2026 13:55:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F1BB95FE9B;
	Wed, 18 Nov 2026 13:55:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 345E111BC0D19;
	Wed, 18 Nov 2026 14:54:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795010100; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=YF3rO8Ic6p5GJpGsgevV8sf20D+3CyakkHcPRmAnado=;
	b=qMOUxDEUnq3J4RmzyKFaA1qhwDGw0B/Z0ERt7BUovrptTMIC9ccmikfxpjmmLytK5alGnk
	1pgXzAgfFwQxiEsnfTpKJBWjCT5h9knDegr7EQXpIT4Zv8ipAED2U36+iyYZYcLNTV1caS
	aQz7SgOQdeiC9zVpt80a1wtrk7a8OhpOXFjX3KNRQ233+LxPUWEaf0ABFARF0zXK4kpGAv
	0IX3bAhdR94ZZ54i8OKv2ZjJlffvqjkDN76nR6LutiP6IqD7q0EbZH1KDG/8rtbFxQz1i1
	syACs5IjfS3ZVPpRENrBAsR5wUAgK37ZO+bO7itWXaFlerGeXa63QwXL66VfLQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/3] spi: ma35d1-qspi: Fix continuous reads
Date: Wed, 18 Nov 2026 14:54:54 +0100
Message-Id: <20261118-winbond-upstreaming-ma35d1-qspi-cont-read-fix-v1-0-e5066ad2efe3@bootlin.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NSw7CMAwFr1J5jSWcirbiKohFSEzxok6Iy0eqe
 ncslvNGerOBcRM2OHcbNH6LSVEHOnSQHlFnRsnOEI5hIKIJP6K3ohlf1dbGcRGdcYn9KRM+rQq
 moiu6yHiXLwaOUz9yijwO4J+1sc//3uW67z/ywMNlfwAAAA==
X-Change-ID: 20261118-winbond-upstreaming-ma35d1-qspi-cont-read-fix-2ea837ecae76
To: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <stlin2@winbond.com>, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The controller is arbitrarily limiting the size of the SPI
accesses. Patch 1 drops that limitation, which makes it suitable for
flash continuous reads.

Patch 2 is a general improvement follow-up.

Patch 3 is a proposal to step up as co-maintainer of the MA35D1 SPI
controller driver, because I do care about it at the moment and
constantly seeing it break is a bit annoying.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Miquel Raynal (3):
      spi: ma35d1-qspi: Drop a pure software limitation
      spi: ma35d1-qspi: reschedule during long PIO transfers
      MAINTAINERS: Add myself as Nuvoton MA35D1 SPI controller driver maintainer

 MAINTAINERS                   |  7 +++++++
 drivers/spi/spi-ma35d1-qspi.c | 16 +++-------------
 2 files changed, 10 insertions(+), 13 deletions(-)
---
base-commit: 69dbffe2d549f5dc52058d8182623ba9721dc06a
change-id: 20261118-winbond-upstreaming-ma35d1-qspi-cont-read-fix-2ea837ecae76

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

