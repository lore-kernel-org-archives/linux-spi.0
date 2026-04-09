Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825D439183D;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775736326; cv=none; b=LQH0o95r/yg+kHdfI+vkAmFo2e8kk7xi1x9SKW+4MLvfHc6wjCI51LEYrbpx52Mtw1NSlk55JjACZKnqC8vqFweHU6HvSklO7XMJ+bZ9mXLWPR55pr/N6aVzxP7swRhUI0EBXqHQ6gRc4QMfaeXhg4t9BdHXKG82p3xMfLQc3H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775736326; c=relaxed/simple;
	bh=8AvM83QcGzh6gz1SeexDYbo6Y1rTvPVej51nPwjN6UA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iSdCy+NjO7G0MqikDLpMWQCxhyxRRIrBwStkUbAxYyWQtqZWPQZ+Rby7Btj6vLzrvBrXn4CMxr8ypHLQeMef/R8iZ4tOaGrgzhu5rKdFoNEjRL76HzkC6KGvWFJrm1qQDWLxIovqH4RJS5y33XkQoERgoyGf5uh6NcSLOnIztts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJetzo/k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJetzo/k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408E6C4CEF7;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775736326;
	bh=8AvM83QcGzh6gz1SeexDYbo6Y1rTvPVej51nPwjN6UA=;
	h=From:To:Cc:Subject:Date:From;
	b=pJetzo/kFQ+4A6S0Gqbdo2kSbLjCXhD30ylP/ZdDp0K3RU3kDB+BMTAn1HMGfmeAL
	 9IYCyNcqGntAX4fqCleqXb6MNBELODNPntVuuucVRIv/W96WnbTPBE0WgMaHkyBE3K
	 2LJW1NpcEZNyKRIa/OOkwl7uhX+q+qnZ86fsDOK41XbrHi/hrRA20DxmYaIUV9pdM3
	 qlC7/WohOX4ol1q868pODJbOpHpCq46segE7QXcyCVo0eDVcWxWQAAhBq/RepMKiMm
	 OloRcMspOjHwu7KyEMLzu/QdYFeyzZysBVsfir9I6gKf3g7DHWdE7TXDmPdddWdVPV
	 6Yz6I3MlHYVwA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wAo8R-00000001d6f-3xuJ;
	Thu, 09 Apr 2026 14:05:23 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Sunny Luo <sunny.luo@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Radu Pirea <radu_nicolae.pirea@upb.ro>,
	William Zhang <william.zhang@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 00/20] spi: fix controller deregistration (part 1/2)
Date: Thu,  9 Apr 2026 14:03:59 +0200
Message-ID: <20260409120419.388546-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Device managed registration generally only works if all involved
resources are managed as otherwise resources may be disabled or freed
while they are still in use.

This series fixes the SPI controller drivers that get this wrong by
disabling resources such as clocks, DMA and interrupts while the
controller (and its devices) are still registered, which can lead to
issues like system errors due to unclocked accesses, NULL-pointer
dereferences, hangs or just prevent SPI device drivers from doing I/O
during during deregistration (e.g. to power down devices).

I decided to split these fixes in two parts consisting of 20 and 26
patches respectively in order not to spam the lists too much.

I've also prepared a follow-on series to convert the drivers here that
do not yet use device managed controller allocation (which avoids taking
extra references during deregistration).

After that it should be possible to change the SPI API so that it no
longer drops a reference during deregistration without too much effort
(cf. [1]).

Note that this series is based on spi/for-next.

Johan


[1] https://lore.kernel.org/lkml/20260325145319.1132072-1-johan@kernel.org/


Johan Hovold (20):
  spi: amlogic-spisg: fix controller deregistration
  spi: aspeed-smc: fix controller deregistration
  spi: at91-usart: fix controller deregistration
  spi: atmel: fix controller deregistration
  spi: bcm63xx: fix controller deregistration
  spi: bcm63xx-hsspi: fix controller deregistration
  spi: bcmbca-hsspi: fix controller deregistration
  spi: octeon: fix controller deregistration
  spi: cavium-thunderx: fix controller deregistration
  spi: coldfire-qspi: fix controller deregistration
  spi: dln2: fix controller deregistration
  spi: ep93xx: fix controller deregistration
  spi: fsl-espi: fix controller deregistration
  spi: fsl: fix controller deregistration
  spi: img-spfi: fix controller deregistration
  spi: lantiq-ssc: fix controller deregistration
  spi: meson-spicc: fix controller deregistration
  spi: microchip-core-qspi: fix controller deregistration
  spi: microchip-core-spi: fix controller deregistration
  spi: mpfs: fix controller deregistration

 drivers/spi/spi-amlogic-spisg.c       |  4 +++-
 drivers/spi/spi-aspeed-smc.c          |  9 ++++++---
 drivers/spi/spi-at91-usart.c          |  8 +++++++-
 drivers/spi/spi-atmel.c               |  8 +++++++-
 drivers/spi/spi-bcm63xx-hsspi.c       |  8 +++++++-
 drivers/spi/spi-bcm63xx.c             |  8 +++++++-
 drivers/spi/spi-bcmbca-hsspi.c        |  4 +++-
 drivers/spi/spi-cavium-octeon.c       |  8 +++++++-
 drivers/spi/spi-cavium-thunderx.c     |  8 +++++++-
 drivers/spi/spi-coldfire-qspi.c       | 10 ++++++++--
 drivers/spi/spi-dln2.c                |  8 +++++++-
 drivers/spi/spi-ep93xx.c              |  8 +++++++-
 drivers/spi/spi-fsl-espi.c            | 10 +++++++++-
 drivers/spi/spi-fsl-spi.c             |  8 +++++++-
 drivers/spi/spi-img-spfi.c            |  8 +++++++-
 drivers/spi/spi-lantiq-ssc.c          |  8 +++++++-
 drivers/spi/spi-meson-spicc.c         |  8 +++++++-
 drivers/spi/spi-microchip-core-qspi.c | 12 ++++++++----
 drivers/spi/spi-microchip-core-spi.c  |  4 +++-
 drivers/spi/spi-mpfs.c                |  4 +++-
 20 files changed, 127 insertions(+), 26 deletions(-)

-- 
2.52.0

