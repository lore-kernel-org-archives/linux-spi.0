Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C1139185E;
	Mon, 23 Mar 2026 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263001; cv=none; b=ODv04PPHwgD1EY/1GJaDpK+XhGPLw4khhJMMUf55nLq/1it8usm76M2aH9T/g1eBuFEImRlsLc2FkX21aryKgt4dCjMTa/6VftW1CXZvyLtKRwV7f6+cI3es2A4+Pd5Iicmragt8Oj53CZ74iLv/OyAlfG48EmHYDSRos7sQ+Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263001; c=relaxed/simple;
	bh=8k+h+I6VpOsCXdVZnp21iYo5KkS9WWHZO8jAEhuEzVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rs7qhJ00Vc9k1cV4Pz5ELhb7SvR/cC4TKmAmQ8gUvYdlvedjAWwhU45dzMghxN7AvNNYyRLV7zuO92FujZQ3eKMQ8nTvlVY/mnUA31wi887xyM8PLPCJr10XbQ5RFjyyCvJakAtQloRzfUK93vGZd23+acAf1c47OyJ9TWdSwe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbJopB/j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbJopB/j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B201DC4CEF7;
	Mon, 23 Mar 2026 10:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774263000;
	bh=8k+h+I6VpOsCXdVZnp21iYo5KkS9WWHZO8jAEhuEzVo=;
	h=From:To:Cc:Subject:Date:From;
	b=qbJopB/jVg5FMc6n796CpXCM72Wvx6V4/s688vl5oe/wFIDz57WeU0VLO3dkZ2rno
	 oiefov7dHLmKfrjqxEbGs6yAhDV5m824yznpOLpXFnuTsg7k0V2WJTEmHFDk0e7o68
	 +yYkSyPfphgXayfyANniah4ram/mu5S1l9vWsPW7Q0/ACbtgmnkoo4k8S7nfQfGi1g
	 hXL1GJnarvMiiOEMgKiK41wW7SMo60GUCfdPqkk3wUqKgy6sigB8zjgQJlqI+KDD0O
	 jL1XeJ/qoBJyihLEzER9h8EfGy9DdazzAqQOUXUe+kaJuccIMWaJ1bcZSxmK9rt4wh
	 Gr+nY+KWV9jQw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w4cr8-00000003Xik-1RT1;
	Mon, 23 Mar 2026 11:49:58 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/5] spi: imx: fix use-after-free on unbind
Date: Mon, 23 Mar 2026 11:49:43 +0100
Message-ID: <20260323104948.844583-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SPI subsystem frees the controller and any subsystem allocated
driver data as part of deregistration (unless the allocation is device
managed).

This series fixes the IMX driver that got this wrong and then converts
it to use device managed allocation.

Included are also related cleanups for tegre20-slink and the rockchip
driver.

Johan


Johan Hovold (5):
  spi: imx: fix use-after-free on unbind
  spi: imx: switch to managed controller allocation
  spi: tegra20-slink: switch to managed controller allocation
  spi: rockchip: fix controller deregistration
  spi: rockchip: switch to managed controller allocation

 drivers/spi/spi-imx.c           | 41 +++++++++++----------------------
 drivers/spi/spi-rockchip.c      | 40 +++++++++++++-------------------
 drivers/spi/spi-tegra20-slink.c | 26 ++++++++-------------
 3 files changed, 40 insertions(+), 67 deletions(-)

-- 
2.52.0

