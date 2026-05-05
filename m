Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750323DE425;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966182; cv=none; b=jG5AX9c5+FLPrEP9JpnB/FuyZFge4HsOPgNtKpU4fFIqCa5C6SF+8Mi5g2sscOCm1CRhJPjf03LKin6QeuFGPrIxbv1F67I4v87i+u/0OK55rwQ3Jp54OVesA0zlkk78x8yrzWh8XvZCsh/w5aSybQWlUfr8mUB/EjIAognsb6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966182; c=relaxed/simple;
	bh=n9+F3nG2+IjDMrwKYAkYO2fYnlj8Uv7SKxkaJ9o388w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I2s2xAIS2xGKaO2o9LNE2AGwIITO2uMdWi0fK18+x8HnZeWhO1TwS7SbIXqepar+WaN1ao4I41ioJnpJSfGlOCBmSUxLe2pG6ascfPE+TCS+fslMvClJu0vEZp7F4nLCF05nPTo5JWgrDWw65JbcXJfleyUUMZNdnUbM7CaoCYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QclIuVvr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QclIuVvr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198E7C2BD01;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966182;
	bh=n9+F3nG2+IjDMrwKYAkYO2fYnlj8Uv7SKxkaJ9o388w=;
	h=From:To:Cc:Subject:Date:From;
	b=QclIuVvrxpQKg1G3r1CuMGljVMTQzu0rxJSi7JwnDohlpgGyRSCO2XQFE9W9kZdHn
	 GxY44CShJ4DvFdwc1349mMMHM0ZoIVBV1Q9U3MdzpEq33pLMO2vchhQlTiKPQ5+qTT
	 zg6H5DdQa5gR9gy8c35izX7qNgcSmFiRe3P/aAIxawiMZop3MRD1Lfj8BKfa770DPA
	 nZIhkmUNCNkQdMF75yGjUl/B3KLvQ/7smGED+244zVJ1A3RwadK0kr3oEabVEaGj2t
	 saUZAHqwlptSwSAvapJ9MgMZxDjLvmwBMAIWCtzNDWESPkGHT6lgS3z67X6XYQOFXw
	 zGEenaeEy2u/A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKADr-00000002asn-2Vm8;
	Tue, 05 May 2026 09:29:39 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 00/20] spi: switch to managed controller allocation (part 2/3)
Date: Tue,  5 May 2026 09:28:49 +0200
Message-ID: <20260505072909.618363-1-johan@kernel.org>
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

Included is also a related cleanup of a ti-qspi error path.

This second set will be followed by a third set of 12 patches for
drivers using managed registration.

That leaves us with 18 drivers using non-managed allocation, which is
few enough to be able to fix the API in tree-wide change.

Johan


[1] https://lore.kernel.org/lkml/20260325145319.1132072-1-johan@kernel.org/


Johan Hovold (20):
  spi: pic32: switch to managed controller allocation
  spi: pic32-sqi: switch to managed controller allocation
  spi: pl022: switch to managed controller allocation
  spi: qup: switch to managed controller allocation
  spi: rspi: switch to managed controller allocation
  spi: sh-hspi: switch to managed controller allocation
  spi: sh-msiof: switch to managed controller allocation
  spi: sifive: switch to managed controller allocation
  spi: slave-mt27xx: switch to managed controller allocation
  spi: sprd: switch to managed controller allocation
  spi: st-ssc4: switch to managed controller allocation
  spi: sun4i: switch to managed controller allocation
  spi: sun6i: switch to managed controller allocation
  spi: syncuacer: switch to managed controller allocation
  spi: tegra114: switch to managed controller allocation
  spi: tegra20-sflash: switch to managed controller allocation
  spi: ti-qspi: switch to managed controller allocation
  spi: ti-qspi: cleanup registration error path
  spi: uniphier: switch to managed controller allocation
  spi: zync-qspi: switch to managed controller allocation

 drivers/spi/spi-pic32-sqi.c      | 28 +++++++---------------
 drivers/spi/spi-pic32.c          | 11 +++------
 drivers/spi/spi-pl022.c          | 11 +++------
 drivers/spi/spi-qup.c            | 15 ++++--------
 drivers/spi/spi-rspi.c           | 19 ++++-----------
 drivers/spi/spi-sh-hspi.c        | 11 ++-------
 drivers/spi/spi-sh-msiof.c       | 28 +++++++---------------
 drivers/spi/spi-sifive.c         | 39 +++++++++----------------------
 drivers/spi/spi-slave-mt27xx.c   | 33 ++++++++------------------
 drivers/spi/spi-sprd.c           | 20 +++++-----------
 drivers/spi/spi-st-ssc4.c        | 14 ++++-------
 drivers/spi/spi-sun4i.c          | 35 +++++++++-------------------
 drivers/spi/spi-sun6i.c          | 38 ++++++++++--------------------
 drivers/spi/spi-synquacer.c      | 24 ++++++-------------
 drivers/spi/spi-tegra114.c       | 34 ++++++++++-----------------
 drivers/spi/spi-tegra20-sflash.c | 24 +++++++------------
 drivers/spi/spi-ti-qspi.c        | 37 +++++++++++------------------
 drivers/spi/spi-uniphier.c       | 33 +++++++++-----------------
 drivers/spi/spi-zynq-qspi.c      | 40 ++++++++++----------------------
 19 files changed, 152 insertions(+), 342 deletions(-)

-- 
2.53.0

