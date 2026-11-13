Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577831;
	b=Vt+qjk8GIgwm7iqMBnnR0JUoKA9ngBs9Kyn0XqiiBpqaT71nix3w7QnVoYhcboS38MXR
	 jOANiN3QkY+Rf2lS1hYK4biEfmirAKNeE1uY9ogLvVjarqxuo5r5nXZN4jgpTNUMiEj3x
	 IOJehJY5+u6J84yYgX9xgNbVQ2tyUxXOoi0TzESXVJOYuFVy0tU0Xx06DRO3uxyyfxUtA
	 o90VJruasG6ftAQxFIDvJGF6nDQB4PQ2uNVSgN/B8s2Uz0ajbZ9Fh5NDbzk/YHyxc6xx+
	 K7/06rKtWNF5kfT9UIdxASJxOaxzMDDgr2WoKczq/0bTOKzCiAoRyoo/LvJ7G5qv+wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577831;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ajfkqwM/Rgd/hmTjFJVgmLiAvDSBq9sv3hvrZF5U8+A=;
	b=bQ+BIK1H8p2icRJ67McKgldlFG3IY0Y80+bsdtNoiaHgeTZs5QEf0E2TwpUoQd/ORNr/
	 t7ePAAeZtyXSzkdxlu3cR8eLoWXR5T38oQYclZp2cvoahi0VFbUAP7GAp8AedPCGdyF05
	 ap06PqLxnvwmsPBXVBnc3vRyGJosMHpS6lqTuc/8AAR9Evr31+CcQfQIJUtt+6G4UZOGw
	 aZtGP7AyfJSgCdJuarw72llYSLuoUc/693eq+fRX9dmznMxgqPahmb7MQR38+lsjZ/Nme
	 Nsc+bgZM4XQ4P0/C6Mp1AKfLDG1G6VsIfzzJ87dAYjMw0vq/375Fu6sRvv6a5Jzsahw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=gCRVbUCl;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A5960A3817
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 13:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4A5960A3817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=gCRVbUCl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=ajfkqwM/Rgd/hmTjFJVgmLiAvDSBq9sv3hvrZF5U8+A=; b=gCRVbUClz1vii5qByspiO5SU5p
	d2rkzTYkogGYm5xmDBms6rjXaDrHmbMz8JPxbQa3ibbjn7HhkSFbipmP1wseO0aDg/auwJ+vy3zVT
	U/yDf8SSBaasUM+baNbIS1eMhM+B2AxsrXtcOsrqSUdK1i9JOPid95qIvex0BJA40ZVlN8jOy08wI
	ThfVYgK3Wgj989vjtlItq+vqI74GPGObiVpDmhSEPjIm55vkSb81rW8ZOpeBe8dGDz/uIHUb5J1rD
	aXbBtyV8McsFU7H5gJIjjuw1oI7nDX0mMojyrnpJ+krSqHQNQyWxIaEOMRHb+/JMKVrIh06HEdtbL
	AzexC66w==;
From: Heiko Stuebner <heiko@sntech.de>
To: broonie@kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	quentin.schulz@cherry.de,
	Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2 0/6] spi: Implement a atomic transfer as a last resort
Date: Fri, 13 Nov 2026 14:50:11 +0100
Message-ID: <20261113135017.1047959-1-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
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

SPI devices at times are used as PMICs including a power-controller
functionality that should turn off a system.

This happens in an atomic context very late during the shutdown, where
no interrupts are available anymore and conflicts with the asynchronous
nature of the SPI subsystem.


====== History ======
For the RK806 spi-connected PMIC this has already caused interesting
artifacts.

A first change, tried to "fix" the issue by using the
SYS_OFF_MODE_POWER_OFF_PREPARE step of poweroff. While this hides the
issue, on some devices this now turns the pmic off too early before
other important steps are done.

To mitigate that issue for "some" devices, a change [0] tried to use
different poweroff phases for i2c and spi devices, where Lee rightfully
said, that with this no proper solution would be done - and Lee was right,
as that issue now is open since 2024.

The newest change is a simple revert back the old way [1] because of
those issues caused on other devices, but that now breaks the SPI side
again and also did not take into account that long history.


====== Now =======
The I2C framework has an atomic transfer callback for exactly this late
stage transfers since
commit 63b96983a5dd ("i2c: core: introduce callbacks for atomic transfers")
and during the discussion it was suggested implementing something like
this for SPI too.


As this did not seem to have happened yet, I thought I'd try my luck.

Similar to I2C this is meant only for that latest stage so I stole the
gating from there too.

I assume I did not take some SPI specifics into account, but I guess
having some code to discuss is a starting point at least :-)


===== Testing =====
Adding the below diff allows the atomic transfer to also work as main
transfer function for testing purposes. As SPI's ->transfer() call
already lives inside a spinlock_irqsafe context, this allows to find
any sleeping elements easily.

@@ -953,6 +953,9 @@
 
        /* Only register atomic transfer in host-mode */
        if (!target_mode) {
+               pm_runtime_resume_and_get(rs->dev);
+               ctlr->transfer = rockchip_spi_transfer_atomic;
+
                ctlr->transfer_atomic = rockchip_spi_transfer_atomic;
 
                ret = devm_register_sys_off_handler(&pdev->dev,


===== New =====
changes in v2:
address review comments from Mark Brown
- core: preserve old behaviour for drivers not declaring an atomic
  transfer function
- core: don't use message optimization - safer, but still validate the
  message to get bits_per_word defaults etc
- core: make spi_delay_exec usable from atomic contexts
- rockchip: only register atomic transfer in host-mode
- rockchip: provide a wait_for_idle_atomic function, to
  not require (non-working) jiffies for timeout
- rockchip: register additional restart handler to enable runtime pm
  before reboots too
- rockchip: drop runtime-pm from atomic transfer - would sleep anyway
- rockchip: don't prevent power_off, if runtime-resume fails
- rockchip: use core spi's spi_set_cs to also handle gpio-cs


[0] https://lore.kernel.org/lkml/20240730180903.81688-1-sebastian.reichel@collabora.com/
[1] https://lore.kernel.org/all/20260908-veyron-shutdown-v1-1-066ecb80f5f2@gmail.com/


Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-spi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: quentin.schulz@cherry.de
Cc: Lee Jones <lee@kernel.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>


Heiko Stuebner (6):
  spi: Allow spi_delay_exec() to be used from atomic contexts
  spi: Export spi_set_cs() function
  spi: Add infrastructure for atomic sync transfers
  spi: rockchip: Fix runtime resume error handling
  spi: rockchip: Move to pm_runtime_resume_and_get
  spi: rockchip: Add an atomic transfer function

 drivers/spi/spi-rockchip.c | 126 +++++++++++++++++++++++++++++++++++--
 drivers/spi/spi.c          |  77 ++++++++++++++++++++---
 include/linux/spi/spi.h    |  13 ++++
 3 files changed, 204 insertions(+), 12 deletions(-)

-- 
2.53.0

