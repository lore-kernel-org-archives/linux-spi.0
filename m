Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1993F3F2109;
	Fri,  4 Sep 2026 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538526; cv=none; b=tSyixKzpdQ7L9jBMNq8c5+mNjhKC0gw9gL0gUKbmaFx+Rkxp3xoHTVWXlSLJJbUKDKY39KXuyMcqmNmbsTcvwTQuoABOGSADjFfIfcRkoqlTpQ3K4BzU5ftVS8DPwKV2667QQmyhOlzRQq2emHDFJ2/OakrxBkCwdYw4dQ/1E+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538526; c=relaxed/simple;
	bh=aPO5PTopi8dkb3Njb67czZy3wTkMAf3rqsgcWgtJxxE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oLRd8lyObAbiWxkpiLBla2zL69ZrR5GL6xkxIub3OxP1/MpOnqPAebXp/r6NesyYrObIQRcJXUvHqOS//FOftwmGUz5270Gf1YzMywBcxsaiM1ZbET3vVXjqeClfoitB6lxVo8H2P/wWSjfq0a0NO17KDKNB5KJg4YfllKRYSuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rOFY51G5; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rOFY51G5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 32D094E41511;
	Fri,  4 Sep 2026 16:15:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 01A406057F;
	Fri,  4 Sep 2026 16:15:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AF42E11C79BE0;
	Fri,  4 Sep 2026 18:15:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788538516; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=/Mo7t51/Gnqz3M93hIR4TBNBzPb6bGUI6Tlc2drcsBM=;
	b=rOFY51G5YcfxBZg3OXPPlKDHAoDrxo+rKpfbiRqss0F/zqgaCGTUtztZazwqVB0vnlN1NI
	TrSleFCr7JmUMEGBYn8kaY5YwgAHPQPD4CzWbWMhBC1YUdg4kPtqh2jOn6VG8/sT6rkL5I
	D3D9MoaYwLYmCM+eElg0H1I3XsFQqGrHRjv+ODj6eP8kDkU544kuhKNzgTSOte91Bbq57E
	EsDh0qrWDV/nm7QJzoFcO1ebphuT8wwNLdXO0UP+78mHKxM9JOu25v5Vih09MeMH2qM18R
	DBVRf8igqslW35Um+D8rFE0VgHBaXBTwUaQ8kkLHPZk+UYl1mSVhO/YwJp95/w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/2] spi: ma35d1-qspi: Flag the DTR capability correctly
Date: Fri, 04 Sep 2026 18:15:09 +0200
Message-Id: <20260904-perso-ma35d1-master-v1-0-b6936e8c6fa1@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MMQqAMAwAvyKZLdS0CvoVcSg2agZbSUQE8e8Wp
 +OGuweUhElhqB4Qulg5pyJNXcG8hbSS4Vgc0GJne+vNQaLZ7MG1sSnQk8TgjB6d9S5QhFIeQgv
 f/3Wc3vcDn6VrwWUAAAA=
X-Change-ID: 20260904-perso-ma35d1-master-2c2423043aed
To: Mark Brown <broonie@kernel.org>, Jacky Huang <ychuang3@nuvoton.com>, 
 Shan-Chun Hung <schung@nuvoton.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Mark pointed out that the DTR capability was not correctly enabled since
I had to set the extra ctlr->dtr_caps flag. For testing, I commented out
the spi-mem ops/caps and figured out DTR variants were still not picked
up. This was due to the spi-mem fallback implementation of ->exec_op()
not forwarding the DTR flag.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Miquel Raynal (2):
      spi: spi-mem: Enable DTR transfers using the standard API
      spi: ma35d1-qspi: Allow DTR operations with the regular SPI API

 drivers/spi/spi-ma35d1-qspi.c | 1 +
 drivers/spi/spi-mem.c         | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)
---
base-commit: 278cfc33d25f58105681196cecd9222c423d0c1c
change-id: 20260904-perso-ma35d1-master-2c2423043aed

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

