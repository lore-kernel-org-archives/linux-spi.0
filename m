Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437DA3BE155;
	Wed, 29 Apr 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454043; cv=none; b=FNHP3mVHNFS4NmGi7GRq55MCPsHwyHhuZ54PZbFzRhw5ciQsUx+h/U/aKVFpT0fHfmv5kZmEEYfdXp6ZonztDap+5hpkvTkJofQZQo/NFfLO6CyO6280E6T4eVJ5R/KLHYzSev1ZJLq1g4ksRhQj7QnkxnRcjv3/qekrufXfGAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454043; c=relaxed/simple;
	bh=fXqyZZq9vchFKkYkGar2+vyFwOZ83OfUUFquw+SBt8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WHgpiV6/A//YmpU0X4legoCR1tzh5CWzAyLAgkA6Yfq/n6Lwokqv82g21DPSM7A6O8jmosOryq62HsAMb6Pt/iGiR5ZBT5HW5zF5zyceThJMEsyfymYmcHhddLy+dYQVpt2k9Ku+JtkHHp9GPJugkLJY5ViFvxV8whbBCnN3mys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZVH5Rti; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZVH5Rti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE07AC4AF09;
	Wed, 29 Apr 2026 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777454043;
	bh=fXqyZZq9vchFKkYkGar2+vyFwOZ83OfUUFquw+SBt8k=;
	h=From:To:Cc:Subject:Date:From;
	b=PZVH5RtiEaF/ilGgmTb+4p7HThO+Ft2w6Ss8XFAqbTl4JkdLdGoBUY0Ok1VFm64C/
	 uJh+mFXBSGr4nDTvtHpHY688C3X5a+RfGaLxduXq+u71yPPEx85XMeHvTCAbFk9xZz
	 4VjKwy/F83fnbtp8Ftn+46dmuX62v5B+z2vUH4xRq178tGAD8RACs/AFyil8T6FyKc
	 0S0FKyFYQfNuadivy+6LByGymCMLqkQDGMBNpQzloxOie7knlaRKDEE5qmYw1Wo6ht
	 k9ZPgo/hURqTIDzfJs3HdstTfLF6SQoSY3Fjd6NQ510+DhLuiVD1RxcevRZ7GJrf20
	 k52uJ2eCPcNWA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wI0zY-00000000h2H-1pgH;
	Wed, 29 Apr 2026 11:14:00 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Radu Pirea <radu_nicolae.pirea@upb.ro>,
	Ryan Wanner <ryan.wanner@microchip.com>,
	William Zhang <william.zhang@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 00/19] spi: switch to managed controller allocation (part 1/3)
Date: Wed, 29 Apr 2026 11:13:14 +0200
Message-ID: <20260429091333.165363-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for fixing the SPI controller API so that it no longer
drops a reference when deregistering (non-managed) controllers (cf.
[1]), this series converts drivers using non-managed registration to use
managed allocation.

This will be followed by a second set of 20 patches, and then a third
set of 12 patches for drivers using managed registration.

That leaves us with 18 drivers using non-managed allocation, which is
few enough to be able to fix the API in tree-wide change.

Johan


[1] https://lore.kernel.org/lkml/20260325145319.1132072-1-johan@kernel.org/


Johan Hovold (19):
  spi: at91-usart: switch to managed controller allocation
  spi: atmel: switch to managed controller allocation
  spi: bcm63xx: switch to managed controller allocation
  spi: bcm63xx-hsspi: switch to managed controller allocation
  spi: cadence: switch to managed controller allocation
  spi: octeon: switch to managed controller allocation
  spi: cavium-thunderx: switch to managed controller allocation
  spi: coldfire-qspi: switch to managed controller allocation
  spi: dln2: switch to managed controller allocation
  spi: ep93xx: switch to managed controller allocation
  spi: fsl: switch to managed controller allocation
  spi: fsl-espi: switch to managed controller allocation
  spi: img-spfi: switch to managed controller allocation
  spi: lantiq-ssc: switch to managed controller allocation
  spi: meson-spicc: switch to managed controller allocation
  spi: mxs: switch to managed controller allocation
  spi: npcm-pspi: switch to managed controller allocation
  spi: omap2-mcspi: switch to managed controller allocation
  spi: orion: switch to managed controller allocation

 drivers/spi/spi-at91-usart.c      | 24 ++++++-----------
 drivers/spi/spi-atmel.c           | 34 +++++++++---------------
 drivers/spi/spi-bcm63xx-hsspi.c   | 17 ++++--------
 drivers/spi/spi-bcm63xx.c         | 23 +++++------------
 drivers/spi/spi-cadence.c         | 28 +++++++-------------
 drivers/spi/spi-cavium-octeon.c   | 17 +++---------
 drivers/spi/spi-cavium-thunderx.c | 32 ++++++-----------------
 drivers/spi/spi-coldfire-qspi.c   | 28 ++++++--------------
 drivers/spi/spi-dln2.c            | 26 +++++++------------
 drivers/spi/spi-ep93xx.c          | 22 +++++-----------
 drivers/spi/spi-fsl-espi.c        | 20 +++++---------
 drivers/spi/spi-fsl-spi.c         | 14 ++--------
 drivers/spi/spi-img-spfi.c        | 40 +++++++++++-----------------
 drivers/spi/spi-lantiq-ssc.c      | 28 ++++++--------------
 drivers/spi/spi-meson-spicc.c     | 43 ++++++++++---------------------
 drivers/spi/spi-mxs.c             | 14 +++-------
 drivers/spi/spi-npcm-pspi.c       | 19 ++++----------
 drivers/spi/spi-omap2-mcspi.c     | 25 +++++++-----------
 drivers/spi/spi-orion.c           | 26 ++++++-------------
 19 files changed, 147 insertions(+), 333 deletions(-)

-- 
2.53.0

