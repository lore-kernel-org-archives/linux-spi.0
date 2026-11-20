Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795175989;
	b=QFzh1qT1VIBk60lYLmlZbXznjhSRgiBDyTZR7bBhHmrCYAk4E/FJwwl2yRiWUiZHO6oD
	 3AZkmLZYuC6OZd3lKYZNgZYHAZWUZq0TGXSiUjM1y7GyBgK/G7dwfKrOjvU5OlhFb5MdZ
	 m/hnGmPs+l0/GIyhenPPJ3QYvqtATGEJk2kLNbdzLF2sMQOOtFbXOo/alskpjf5+IA5ZM
	 ChGioHqa8Ifj8L8HeRwZY0kELmKWFm+ZMOQGHUV6Ij6+bxIi28pGKjo3zWmLvGe3D2rLZ
	 auXyqHvqUcBj+z5jQ3P/imKkaNcUg/e4tqki0XE5MFR+a9MyLhwZdeg9+a21T4rOHlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795175989;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=Pnfbrqsz261Ao8LkfJr3kvpI+oVHki879oH/ScAaXHk=;
	b=gg+GsGN6JNu8dBzj3tIa7lI57Fk/AOBwlt2ZdUSFVc/hlyN0P9zR3XPnJ4iwZRMDjsOh
	 PmBZXh/9lgoT7Hx3Q8TxW+rfPodT76XEABC1wtVGQJyW3DuFOM85QaoKk2pVA1+RZdXxN
	 pGtGWRKIZi8wt0P5cPU6w49R5YGM1XV0ZnNDlk1qFGuH/UPa/zoYBvtHl6uqwUwKsNvod
	 nqC0UES5szAwBHFe/AxWuuJHe1dqWLpJ1uNYt6F+BV9Zz/uNgfc8GtK/5u7ho8KN5lOuD
	 X3Tq6DMOQ0tc1Nc9BKpQ5qmhB4gEER5eUkHHuVabEeWWHblu0pjpBng/cXsufNgRjHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=clhVjqzF;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6FC606A320
	for <linux-spi@vger.kernel.org>; Fri, 20 Nov 2026 11:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B6FC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=clhVjqzF
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 05D9F1A1749;
	Fri, 20 Nov 2026 11:59:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C6FF56017D;
	Fri, 20 Nov 2026 11:59:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BE43C11BC003C;
	Fri, 20 Nov 2026 12:59:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795175981; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=Pnfbrqsz261Ao8LkfJr3kvpI+oVHki879oH/ScAaXHk=;
	b=clhVjqzFK2XxDnK+PQU5QHV0S6u31OvANTAUl6pM8p4JF/VvWJrzYdUlyuKXbKHXfPJf31
	buDrJLr8TzFfXFvH3uAcWGitPqshp8wxFguHJYDR5Gv93txr58VamHjk+gXSD24RnTuou0
	bzKl2Ir11OicBYWqGZNu0LydU0Q67Ckz+Xk53RGsmSJSsfpSlM+/VYFhr1vSQllg8AL0pd
	Bw9/lnZvx4cshm1MTfVq+sSJaeDKrqIEVfZqOJlO7dXdkAnvdQhqnUyPCtb3e+0OcWCsJU
	pqG2BGID3TOjpRLvihPhpkMqDnrxmqbevmGrQNHNpus8PIAB2FPNZXSAs5bVVg==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	George Cherian <gcherian@marvell.com>,
	Witold Sadowski <wsadowski@marvell.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v5 0/7] spi: cadence-xspi: Fixes and ACPI changes
Date: Fri, 20 Nov 2026 12:59:18 +0100
Message-ID: <20261120115925.173568-1-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Mark,

This is the v4 of my patchset that adds a few fixes to the cadence-xspi
driver, some cleanups, as well as a workaround for probing the Marvell
IP on firmwares that use the base string.

If that last one is a deal breaker then it can be skipped. Jisheng Zhang
queried the DT maintainers about a clarification on whether or not bugs
in out-of-tree DTs should be cared for, but they haven't responded yet.

The v5 is a minimal update from v4, only the first patch is different.
The error path of .transfer_one_message() will now disable the hardware
FIFO.

Changelog in v5:

- [1/7]:
    - Reset hardware FIFO on error

Cheers,
-Paul

Tanmay Jagdale (7):
  spi: cadence-xspi: Properly handle errors in .transfer_one_message
  spi: cadence-xspi: Reconfigure to STIG mode before SPI message
  spi: cadence-xspi: Inform SPI core about size transferred
  spi: cadence-xspi: Clear "SDMA ready" IRQ flag after polling
  spi: cadence-xspi: Drop useless cdns_xspi->cur_cs
  spi: cadence-xspi: Rework resource discovery
  spi: cadence-xspi: Add workaround for old Marvell firmwares

 drivers/spi/spi-cadence-xspi.c | 183 ++++++++++++++++++++++-----------
 1 file changed, 123 insertions(+), 60 deletions(-)

-- 
2.47.3

