Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A405E37F313
	for <linux-spi@vger.kernel.org>; Mon,  5 Oct 2026 08:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187944; cv=none; b=iupRMoJjAVbrGMfP/HcvPR8I/llSa3YYaRP8cPBW+OSpWC2SXzSii9zhmaZlJR2gZRFy4iaEIv7S51CJ+wthbg+vdN1gO9x8tBIxVpRpL3mdMJGblVNzSC4nzeNczXIAyS5OIQZX744zYe4kfN76Z4LEAqyMAJKaNjOcahfDfpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187944; c=relaxed/simple;
	bh=E6SeSGfqzi1VbAb5vIyQvy9vOXvoDVWtdvN6iHAwMs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eVZTr8ZDue/BcSAWOT1XvyVIRIcCJz2jUztrJF8T248XG3l6sX6iHdjoESUrhFHAwEmWaLzt8i2FC5DmR8QvRn0YjNq6orIAVknIFEd1yJoMkNHZX6CbA54y+vGdtUGlrtIihCfFUCHrVvvRvDFUjKeQ/6f8YOQXq0jmOs5Kylg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HzkTM+8a; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HzkTM+8a"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B25674E4118F;
	Mon,  5 Oct 2026 08:12:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7DC5E604FE;
	Mon,  5 Oct 2026 08:12:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CE85210330694;
	Mon,  5 Oct 2026 10:12:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791187938; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=1lIl1CV2ZHTfM8gjcxGCKMyj3T7DeZY+lFU2qxT7D70=;
	b=HzkTM+8a/ejutDPI5atGyTAjs9xLxfcv7W7uYHD9LQ7/EfelyTJVefvYJRa8tVKxSvP46Y
	e26SRYMuo1FIVJNc8JV0lEAKRsPn79tyBRqweBj0xQbA7PJJiGNOL37GHcEYWwhrl0m9pc
	EAVSH8tEimWsYgVmk5B2xC0d0/uXFZ565w8UGKxPZKi1FXMY0tXo5lbeL8If6QT6VpSMP7
	8OONZUjjAJrhZCpFhKPB8d34ssjQYb2C0BRwCmgerm+rn0o8Qwj2FBz1DdLfbukejguHuU
	63UZFbZxt930aKQkp2BCIb7sra6rJet8JnsEWa0kjhr6U5OfG0KRAVx+KReNMw==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH 0/5] spi: Add support for panic mem writes
Date: Mon,  5 Oct 2026 10:11:35 +0200
Message-ID: <20261005081141.33688-1-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

This patchset updates the MTD spi-nor code as well as the spi-mem code
to add support for panic mem writes to a memory partition configured as
pstore.

In the context of a kernel panic, preemption, SMP and IRQs are disabled.
Therefore the SPI driver must make sure that its code paths don't sleep,
or rely on interrupts.

A driver that will respect these conditions can say so by setting the
'panic_write' flag in its spi_controller_mem_caps. The MTD core won't
attempt a panic mem write without this flag set.

Only the .exec_op() path will be used for panic writes, given that the
fallback code relies on the generic SPI API, which explicitly states
that it mustn't be called from code that can't sleep.

In case of a kernel panic with a compatible SPI driver, and a mem write
is attempted, the 'spi_mem_op' struct will have its 'panic_write' flag
set, and the SPI driver can then handle it accordingly.

The spi-cadence-xspi driver gets updated in the process, adding support
for a irq-less mode where register polling is used, so that it can
support panic mem writes.

Cheers,
-Paul

Tanmay Jagdale (5):
  spi: spi-mem: Add support for panic mem writes
  mtd: spi-nor: Add support for panic writes
  spi: cadence-xspi: Add irq-less support
  spi: cadence-xspi: Don't use infinite timeout in register poll
  spi: cadence-xspi: Add support for panic writes

 drivers/mtd/spi-nor/core.c     |  67 ++++++++++++++++++++-
 drivers/spi/spi-cadence-xspi.c | 103 ++++++++++++++++++++-------------
 drivers/spi/spi-mem.c          |  25 ++++++++
 include/linux/spi/spi-mem.h    |   5 ++
 4 files changed, 156 insertions(+), 44 deletions(-)

-- 
2.47.3

