Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840574;
	b=c0z1A+RX2bHV9pOKq9ZRbIAzV97mFLBSeTaiBoU5hyZ90eSHyaAoCtYUaoz6RRbMNnB/
	 Q95ywQ0VdrMZHdKe0QBnKz728pDkH/B0EF+Wxs8KdAppR6Px2lDQNWBJgT4WtmGPO2kYQ
	 DtoD/PmV+MLavSHCirMswQ7FWYPUgIxSivymgmYHlwQZ53ZgHKksKfTk7xyVP58Gjst/G
	 C1wZAqG4VsE0qkDZZgjuUZwXBuFo/iqmArr9SriHnFGkz0G083EeVsBj3awEsdq7zXJQl
	 6+BASdogN0D+L789HhqEXLQYL+58reFtixuOSLORVbvjHT3UU1uQbMD8pw28UOAVB5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840574;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=ncm72yd/1ff8hZWDsyUJD8en8SL6r05vISEsCF8jzrQ=;
	b=Vnq9mWQQhviI8G/2MSy09SHLmwE+BVnb1DezEmcX/YSvwbyctGOdQ/npzcrgO66B+ZSO
	 BLQK1oFTvul+FBEXI38v8witfLfwrsXDQrxvPnU0CjTxvoBgF9PtY3qKCVy0CsoFVofSz
	 LW9gmWWzut0yBOH1MomLwzv1wynZ/ROutrJNc8AbWeaFlrSTBy+Cpa8s2IJpU3x7G7pA9
	 tE8a9MalQj0jPopQJgGBtoJiSz5eA5j7TsqqsdHRILymFKLEcDBgxz2PIXmRJvNA+h9Is
	 1VSxfpoxPvDWchNQpwzIJx7huedyaol+1dS4VWtZ3ePRoP3+lSJzbZujxR1KzUCrkow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=nASjvAas;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8808A606A31C;
	Mon, 16 Nov 2026 14:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8808A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=nASjvAas
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8B01D4E41604;
	Mon, 16 Nov 2026 14:49:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5E9596023F;
	Mon, 16 Nov 2026 14:49:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B17C911BC1483;
	Mon, 16 Nov 2026 15:49:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794840566; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=ncm72yd/1ff8hZWDsyUJD8en8SL6r05vISEsCF8jzrQ=;
	b=nASjvAas/CPOIg8Gxikd6wAmO1wV5rcgSdZW1KbUfuTZaYeIUopxpDc2yVeDG4k6S/YGYK
	E6rA3SYpYeyM70p4RnsYgJLf9gwctBp4SDehpW+wf5OUkIGQkF9WjIFHV+VD7hWCp4G7mT
	nE2B96qboY1aUl4wA8C9PKFTQkjgfVh5BfjAObsQp3pWXgQ0w0/1PcONabwhRIXP+hO49B
	XQ3/Z/r9Dvfpu1KbhMtizUyb5onB9BGztKtFpC5YI3LDCmQf5tSip9EtBP6aJQPogV5fsb
	N2I1anp67dyhzprLI/5DbOtQdz0gSF7jO98rsIOMCNeLhRtaOSkylFib8MDWBg==
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
Subject: [PATCH v4 0/7] spi: cadence-xspi: Fixes and ACPI changes
Date: Mon, 16 Nov 2026 15:49:03 +0100
Message-ID: <20261116144910.44151-1-paul.cercueil@bootlin.com>
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

The v4 is a minimal update from v3, with the first patch being
different, addressing a small issue reported by Sashiko.

I also imported the "Clear SDMA ready IRQ flag after polling" fix that I
originally sent as part of my 'spi-mem write-on-panic' patchset, a month
ago. It makes sense to have it here, and to group the fixes together,
if only to make it easier for linux-stable to cherry-pick the fixes
later. This patch wasn't modified since the v1 of that other patchset so
there was no history to carry along.

Note that Sashiko will most likely complain about this new patch, as it
thinks that the cdns_xspi_is_sdma_ready() may race against the IRQ
handler, but I think that's a false positive - the function is never
called in a code path where IRQs are enabled at the device level.

Changelog in v4:

- [1/7]: Also reset cdns_xspi->xfer_in_progress on error.

- [4/7]: New patch, imported from the 'spi-mem write-on-panic' patchset

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
 1 file changed, 124 insertions(+), 59 deletions(-)

-- 
2.47.3

