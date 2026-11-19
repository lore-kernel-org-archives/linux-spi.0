Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096707;
	b=FsmjD5uppXMKt2yYCFznKYy11QPPTi7QzmjTOGJiI1T545Cja07XanGF0DCxJ1IaOe+r
	 iBaqUom9tSiEcnFcc8ng6NjyictqsvWNvzW8veqk8nzadLZ6/6a7O9ULyV/FLVv+HdMjj
	 c2lwVnHV1tMUN5EnWvq9Dtu+zeV37i4cc6xj8OPReP/8EtJ4qEp6FIHI9a9XML7tjk1U/
	 wPEfKKD2ER15wuE/Dj3dzajAgrpU8TLYHNOGcQCNl7CawiFIxvj4V1TWBvAbcB5Eemqw4
	 J2VObtm+p+RVIQz2LTJvcbDqNzP2RWUmGnwy3ABclEkKGNDmc+YtICG+5Tb2u8p4iyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096707;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Y9v/n1TtDJMFIn4AbhJlfP99z558ytNnhpNIpO3m6Y8=;
	b=luLCAwNV7TMarcpnek8EJSnDsbwFmJvmO68DlXIWqiuaQmMjb7ZBgvuglAFwafDinGom
	 qFczKooUuMukbg3nuKucKZ+ORiL5fCWmTc1+ie9bfHUfu+gFqsl6vj/dxnt41Y7nYdENa
	 lJHvxrQmqUCyRPfMt3AmtkH7deQgQcmkudTI/Ymk/rkL+Mf/qgb4E7E8tlJKM2AEFba2w
	 rjLXuUqoMDKDbbDl9Wgx9Wsv6EPztHDOz30+sBO9yJjY1+ce/fjgdvTQHH/LO9f75LUIl
	 y84u7z/tYzENeFOHw56O7W/MBXh9YHUzHKaYgYy28XPvio29gO+8EJKPntCJWdhOI3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=Gx0lEc2l;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BF1606A325
	for <linux-spi@vger.kernel.org>; Thu, 19 Nov 2026 13:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44BF1606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=Gx0lEc2l
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=Y9v/n1TtDJMFIn4AbhJlfP99z558ytNnhpNIpO3m6Y8=; b=Gx0lEc2lz0wacWK7TpmKVJaegg
	zH4VH0zShbufg7rk6wCQgDrxfYfo2vWe2UjrHWd6/G7Pbmc0nX5WMNKNLL2ywpRtpMgSQWc/OX3oH
	LyFOlT4QOtbEKQvIOhtP1MwIQbJmRRXvOy6S/UvhlpcTEFDEl8qgghsO/P+t8xCFzo6yuGiUaQ0rv
	Z9z7G1eFFsQfST4/gbA9J0hVmA1idLtca3JFFa0JeTiy8jbmpvm1s0vno8RE8SNB/ci92FjljIM69
	NQCc2kWXhfrE7QlE0hHOr8/d+2jzE0h/K4DymRigf4o7t+6OW3W+ZS+0eTckqtdXAda3PJoRj6SbX
	1E0Ez+vA==;
From: Heiko Stuebner <heiko@sntech.de>
To: broonie@kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	quentin.schulz@cherry.de,
	Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v4 0/6] spi: Implement a atomic transfer as a last resort
Date: Thu, 19 Nov 2026 14:58:02 +0100
Message-ID: <20261119135808.2377849-1-heiko@sntech.de>
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

I've also changed the chip-select of my board to use the gpio path, and
no sleeping parts were reported anymore after allowing both the
spi_exec_delay and gpio chipselect to handle both variants.


===== New =====
changes in v4:
- drop the pm-runtime-get patch, before I dig myself deeper
  into an unrelated thing :-)

changes in v3:
- core: allow gpio chipselects to be used in atomic contexts
- core: split in-atomic check, a generic one for gpio-cs and delay
  handling, and specific one for limiting sync calls to power-off events
- rockchip: fail gracefully when not runtime resume (Sebastian Reichel)

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
  spi: Allow spi_toggle_csgpiod() to get called from atomic contexts
  spi: Allow spi_delay_exec() to be used from atomic contexts
  spi: Export spi_set_cs() function
  spi: Add infrastructure for atomic sync transfers
  spi: rockchip: Fix runtime resume error handling
  spi: rockchip: Add an atomic transfer function

 drivers/spi/spi-rockchip.c | 125 ++++++++++++++++++++++++++++++++++++-
 drivers/spi/spi.c          |  90 +++++++++++++++++++++++---
 include/linux/spi/spi.h    |  13 ++++
 3 files changed, 217 insertions(+), 11 deletions(-)

-- 
2.53.0

