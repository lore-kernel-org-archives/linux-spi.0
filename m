Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822863;
	b=fH5ql6iVeGjZ2uWBKc7ralrwhU3oFRwqcOWA+XmqI+K//YE29HWaS3vLIQq90Ai5UtN7
	 +leF3krRjx8OQLUbR7X27TcL6kIKTjQxIUktlcGFor+cL20MqXgOxUH90QFOW59tzJry+
	 t0rrL6+y1PsgHjn3lgoLcMB+FdfcpVHANnh9t6Nn5UxsULLmKY8O/YLTz2xGY1+y/G0qB
	 I4ITfZ9CwMcbu4NO6tnBVXmAmhsrXfmiKeIy4Ut9Z+0jBMi/XLcPCfWmuq0hSOt/RPNe1
	 tPhRX7ITerUq4txtkxX0RTpu+hlUIXiPOqWiYV6RzjcO1kvTjmvwhPjIzUhw/L3xrNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822863;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZcwaTZETTIsbZwMzSlJmJ3zFX+bLxEcm3yQDMGPf2so=;
	b=e/Ihy4Lmu1vrCo0hYkLjinDF2qevOy7m5j59ZjoF2uM1PUSoRW9HxJfZ84rMWOgPDWhI
	 Z5UY7x51mQMIaav7i4rB+K4UMtLI/COXuawEBUUwiCGGihTc67sYbIK+IXlFcIrJlwaRN
	 EXQ0wdv4Z+MGgf6EIkhITVejHpAeWlXdYx0J6Z43GvZSs9PQRxBlcUvjD11ZYU1P+XuCy
	 abuRhvP/4K6VBnVjkh8nZ/eVu8qNHHZVS8bG8Scuh0r33pNZcjkfIo90QVfya26T0ikT7
	 TJHO8C1Gblvsvuhqrkil4iZIC5zj716GpmvUUx8nYSiV7OH80/qfyk9owO57BLxS+mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yinhe.ht;
	spf=pass smtp.mailfrom=yinhe.ht;
	dkim=pass header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=jRZLOIXS;
	arc=none smtp.remote-ip=115.124.28.145
Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com [115.124.28.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C244B606A337;
	Mon, 16 Nov 2026 09:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C244B606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=jRZLOIXS
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1794822854; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZcwaTZETTIsbZwMzSlJmJ3zFX+bLxEcm3yQDMGPf2so=;
	b=jRZLOIXSuyJfF/28cIomcz/ZxugIgDydWV6HZG/Y0eV9+xV7EpMMyx972JwRGTbLGsHj4HO4laKQvwcTdkQP12+Fn0bbe2rhnPAZGVkH2t2aCHfNam3aHmTE6jXtx4ZKjMemB94iIkSeNMG42VKYDPyVP1DIb06rMj4ZM9smhef4SE+b/SwQG52PTuIcjzQynNz5rB2fzzP6lcj9h4kiZ8SfvAdfsss749zgWEXdlcs0UhDqWjEbzc6bRrMQpxD2YIM6vJCDcUCgR4CYgXaKBMhudehAeia6RK30b3XEX51pgYD8S8ZcRVJHcgRZoWVTu+YznveUCPCjXDd9+tkEXg==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08097517|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.20129-0.0268292-0.771881;FP=2808465616424981911|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033025068124;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.k33mMNX_1794822853;
Received: from galx..(mailfrom:chunyuzhiqiang@yinhe.ht fp:SMTPD_---.k33mMNX_1794822853 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 16 Nov 2026 17:54:14 +0800
From: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
To: Mark Brown <broonie@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Subject: [RFC PATCH 0/2] spi: panic atomic transfers and fsl_lpspi support
Date: Mon, 16 Nov 2026 17:49:13 +0800
Message-ID: <20261116094916.4039108-1-chunyuzhiqiang@yinhe.ht>
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

This is a follow-up to Heiko Stuebner's "spi: Implement a atomic transfer
as a last resort" series.  These patches are based on that series; they
are not standalone.

Patch 1 relies on the atomic GPIO chip-select handling that Heiko
announced for v3 of his series.  With v2, spi_set_cs() still calls
gpiod_set_value_cansleep(), so GPIO chip selects would sleep in the
atomic path.  I will rebase on v3 once it is available.

Patch 1 implements transfer_atomic() for the i.MX LPSPI controller.  It is
a second controller implementation for the new API, next to the Rockchip
one.  The callback uses PIO polling with DMA and interrupts disabled, uses
the core spi_set_cs() and delay helpers, and caches the per-clock rate
because clk_get_rate() takes the clock prepare lock.  Poweroff and restart
prepare handlers runtime-resume the controller before shutdown, matching
the Rockchip implementation.

Patch 2 adds an explicit spi_sync_atomic() entry point for panic and oops.
The shutdown path added by Heiko is gated on system_state being past
SYSTEM_RUNNING; panic and oops run while system_state is still
SYSTEM_RUNNING, so they cannot use it.  The new entry point reuses the
controller's transfer_atomic() callback, takes the bus locks with
trylock so a normal transfer in progress on another CPU returns -EBUSY
instead of deadlocking, and validates the message without allocating or
optimizing it.

The expected user is pstore over an SPI FRAM.  Such a system has no
retained RAM and must persist the crash log before the next reset.  The
pstore/nvmem side is still a work in progress; I would like to get the
SPI direction agreed before building on it.

Testing:

  - a mock controller test in qemu exercises the panic entry point and
    the error paths; all tests pass;
  - spi.c and spi-fsl-lpspi.c compile on x86 with COMPILE_TEST and on
    arm64 with the i.MX defconfig;
  - hardware validation on i.MX8QXP is still pending.

Questions:

  1. Is an explicit spi_sync_atomic() acceptable, or would you prefer to
     extend spi_in_atomic_mode() to cover panic and oops so that
     spi_sync() keeps switching transparently?
  2. Is trylock on both bus_lock_mutex and bus_lock_spinlock the right
     behaviour for panic context?  The spi-mem panic write code already
     checks mutex_is_locked() before entering the controller.
  3. Should the fsl_lpspi implementation be a separate patch, as here, or
     folded into the core series?

This cover letter and the patches were prepared with AI assistance; the
submitter must review them before submission.

Thanks,
ChunYuZhiQiang

Signed-off-by: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>

ChunYuZhiQiang (2):
  spi: fsl-lpspi: add atomic transfer support
  spi: add spi_sync_atomic() for panic and oops

 drivers/spi/spi-fsl-lpspi.c | 171 ++++++++++++++++++++++++++++++++++--
 drivers/spi/spi.c           |  72 +++++++++++++--
 include/linux/spi/spi.h     |   1 +
 3 files changed, 231 insertions(+), 13 deletions(-)

-- 
2.47.3

