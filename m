Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22863CF662
	for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 07:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791961688; cv=none; b=HpRPAsH07FYa5rngvCm9gWyf+b2qlRliRrPQc5OQq4aZSS+Iqxq6gmPzIu3h5vuD3e0TGg7hjFs8EQnEfbRuOT+n2mYKLiyLkF9VeU0jIT2KCVe6Sq7i7NAF5k9bkPjsrxYo7bHKpqxifoHUjs8oTxlw1baqVXfVnujv07gy5/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791961688; c=relaxed/simple;
	bh=0DQIOWpBcJtA5XoB95+ZWAojB/jNSyIDZj3pgpSrtag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeR7CAdQxjuCeoC1uG1Q6e/8zwbNE6zSit9aTKY4e7aNTN5QszWV1UERWN6g+r8wOVQJKcj1XLLiAy0TVgqFtJxH8mgS4oObrUUMxSYoDZ6xkrMLbmt143v+z/ZxJ6g3QEY6Fe5SxHlKyLAlZvVIHBV/AjFx1BQMoM3fCxeWxaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gV12Y+xV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gV12Y+xV"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a021c809e3so36514555e9.0
        for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 00:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791961685; x=1792566485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C6z1isC/eee5gYCmJDxquHWAba+jHPDsxCgrS5G8o0g=;
        b=gV12Y+xVoeTIImOxwCQy3MPSOKsZpTITLqBGiwwbyQwIyseWnao/8g2Skw76tcHydU
         HCZyT+J/Y3E7jm9TkDxAWF5skBhwoK6FHa5DPQPIpvmELkyEaoTpviNHm9IO8sA/IiGK
         JjuSKmdJgsBH1DhypAannB8wM0Ywt4J/JotoE/nzziOnpv+MmOTPkfb6hAOLAWSlQAls
         sjdm9wu9gf3wB0RW61FCY+BQeqFWHYeX5fXt22itXaO0/621eHW0UhjFkvtPKmbrVAD7
         +wqDldLMG2M/OEwFzU+qXvsgGFmQiW2D8/34sOCiJUl5p2l8sko8WiHM0GJjM4AuAwZc
         Y6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791961685; x=1792566485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C6z1isC/eee5gYCmJDxquHWAba+jHPDsxCgrS5G8o0g=;
        b=h2QxKy33BXilwRDBJryGNPswnOBRTi+BRoPhMDFLGXH9513SSXvlmN3YoS/KfH4lv1
         IAH+FhcBkqLyC7X6FhRH1HX2O5VN6IUQ6laU/jEE6w0N/CN8FoSGzNcDp+2JGoQPRVsA
         Cg2Egj4x4Vqbqcu4errebgQATefIAfjTEqWoH+Yn5knXJtusm+5UkCO/SrGh7YbHymwH
         i8AoWfP2oysl4oG4fRsMWx+HeH6gTOcHfIMgzBUhZgp1sQh4PkkeAiQZaKbxbzu+4EVU
         0OnTpwwWKslvTTRpZAqFLjIEfgmgaGQmJRoOppamSB4/CqxKCQR0LTMDFgaCyzepww3E
         65Eg==
X-Forwarded-Encrypted: i=1; AKwUvBzng5aIYVnFlKHcExz2ijlARrLIJivPDdW3sb+80gO6doap0/+lHsT5Nu8kiRzkv8TQk3WlNfXjOHE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIuGBB0SkPz3ZKEgC7j0gaGTmUEpV+sTJ0pm19cjjj/MruxeSUq
	S6hnR9wBplW68cVWVw0LPqSW9gruRqnrhniGH5L1G7askongB1P/Lqx1
X-Gm-Gg: AYBFou2rl2GZ3dnRHeGlo3BWhkvn1+s/bjo5adpwMaTSiJwZzmF3sXhOCs09qfayTaF
	EZm8MOTU25snFIZ9v5QZVodENvrouF/BPZgm8aovhZGSAC/qSpkSRno0lpIVsklVnt/QGdi0f3E
	RejHD9SUPzfVbvwS+GCQbd62ori+NOm6gURMastim4eLrfDQdxPxkpd/cB34PMJO/AD68jlGKWB
	3d9CxLBNeI3s9AMylT9ZUwsZNfUgmXVY6a/VzqLH7SLwR8IbHyALeJSiZs3rAQRniighKJj5rJ6
	5arjZHQpeBouLntdDbU3jyq6evOmeV04nm79gvo/fVoEjg9bQa97iP/SnOSC9tj1bfAn7uLnkxJ
	4TExz3Imr8wTC04LpInwYVpAs6vfmnEyqnkjeHK3ZqVEdVuuoJFaHtoV9KnEArcxc/e+D1QYO2O
	9dsg/n8oVQC8CzFdxcWTZVdBm/fwB9dG3QMcQsOOPoUbLSd8c0h6env3Eq/GCq4kkvLBbsuGvYp
	Jw6UXegzNcJP5XLsjiJ88bnnlwR4eUSJ5t9CfBX2cFqc654d39Yv+NQz7Vrn/BU/epcNIbe/Yjn
	3QSS6neuK3aDPlyvuxwA5v3FE6htDKCVWP7iXrA3ECcZskRfEN3tFy/CoUeGag==
X-Received: by 2002:a05:600c:3e0a:b0:4a0:1c10:1372 with SMTP id 5b1f17b1804b1-4a18e4aa206mr312597135e9.27.1791961684668;
        Wed, 14 Oct 2026 00:08:04 -0700 (PDT)
Received: from navid-pc ([2a01:4b00:a856:6220::a11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b3615f2esm32217945e9.1.2026.10.14.00.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 00:08:03 -0700 (PDT)
From: Navid Ghahremani <ghahramani.navid@gmail.com>
To: =?UTF-8?q?Stefan=20D=C3=B6singer?= <stefandoesinger@gmail.com>
Cc: Navid Ghahremani <ghahramani.navid@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 20/24] spi: Add ZTE ZX279128S SPI flash controller
Date: Wed, 14 Oct 2026 08:07:58 +0100
Message-ID: <20261014070758.1717896-1-ghahramani.navid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <QRsVQG8CQny06omTkaluXQ@gmail.com>
References: <20261010130024.177503-21-ghahramani.navid@gmail.com> <QRsVQG8CQny06omTkaluXQ@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Stefan,

Thank you for pointing me to your spi-zx.c driver and for the detailed
explanation of the PIO vs IRQ vs DMA trade-offs!

I tested your driver directly on the ZTE ZXHN H3600 (ZX279128S) hardware
running Linux 6.18.55, and it works flawlessly in PIO mode:

  zx-qspi 94406000.spi: ZX QSPI Controller driver initializing
  zx-qspi 94406000.spi: Cannot get RX DMA, using PIO
  zx-qspi 94406000.spi: Cannot get TX DMA, using PIO
  spi-nand spi0.0: HeYangTek SPI NAND was found.
  spi-nand spi0.0: 128 MiB, block size: 128 KiB, page size: 2048, OOB size: 64
  10 fixed-partitions partitions found on MTD device spi0.0
  UBIFS (ubi0:1): UBIFS: mounted UBI device 0, volume 1, name "rootfs_data"

MTD partitioning, UBI attachment, and UBIFS read/write operations all
completed cleanly with zero transfer errors or ECC faults.

To ensure the driver works seamlessly across both the ZX29 (100 MHz bus)
and ZX279128S (125 MHz bus), I updated the clock divider calculation to
dynamically query the controller clock rate via clk_get_rate(spifc->clk)
rather than assuming a fixed input frequency.

In v2, I have replaced my separate SPI driver with your unified spi-zx.c
under drivers/spi/spi-zx.c, and updated the DT binding schema to describe
both "zte,zx297520-spifc" and "zte,zx279128s-spifc".

All other items you raised (splitting CRM DT schemas, simple-mfd reboot
child, logical reset enum IDs, synchronizing clock/reset locking, and
isolating the PCIe SerDes into a Generic PHY driver) are also
implemented and verified in v2.

Thank you again for your collaboration and support.

Best regards,
Navid
