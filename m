Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793527;
	b=wNgXzt8PK3lxsWAh7umfFUd3ErIL9rzZiux+af79+R9JD+SP4MxvlMVpqzrV0Rhheahr
	 TzLSLfLcYdcC0ZFvgxH7tBwXzaCb9iv9jB8N+R9swjUH7sQNSN1dmmq8wbu2j/lm4n5b4
	 KvZ56TDVn9Yp1fAc18Zs4ntr3RiVRo5V7/q0dVuzDXvAwCud15eYRYe+dciklWW3y7ixO
	 uek7rbFLEfl2eKHBB6gvlqo0NDSyNjJudIgbWCQMhbU3puy6piF7ktH8SvXyU89JMh6zO
	 gQ/GwNc8/Vm6IWQ1lYxlw8CQa1IUHpKe301KSmDKR5PTx2yTtzrS8dZn38ebulgz4JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793527;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9RDnkosvS/VG9gv5TnH9dYBxLUR1ZIHWYvcSLOH8qdQ=;
	b=aeKRFfRiZ3dNwzQ8CI+8GPgits6CppYQfI7Et7V5udi1+5ma0+zjKTxSX9aDkiNq622r
	 rCVC/TfNQBCdyoMJmgLucodOhMs8IVlXSBX1vLlYE88XWXQo4sfydnLkaovz6BlwpoHJ3
	 bRvA5NQa61+7X78ndoyG4//XbQt6rA7nkif0Byzlo3eI1TsI7zr8w86O3cNPgnu3ol/vV
	 AYQbovlMX8KQTnjoV+jO3CQiBHmNYuh5ZNYOHDPFmMZs137ih1403u1pJPgkLpUcMRgI3
	 W1kg4lNSinAFfOHdc8+cJtGdd3c8DluWT0Xh63yh1FahgJ/sTVeas08UAmJhFCWM1lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jbPn31L4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB7F606A31C;
	Fri, 27 Nov 2026 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jbPn31L4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637C51F00932;
	Fri, 27 Nov 2026 15:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795793527;
	bh=9RDnkosvS/VG9gv5TnH9dYBxLUR1ZIHWYvcSLOH8qdQ=;
	h=From:To:Cc:Subject:Date;
	b=jbPn31L4uj8I28oPIA8sQRMmPiqajwLaP4uxWM9+lluWhNjTJefqsB0RQtnQ9lJAP
	 43shSSbjY4X043opZEKvQr4GVOBCsgSdpfMXUP8RWWovxvPR+Sei3ffXq7WJnOaTBu
	 GwgIBNW/P0KQ7l64X8HfIe9vBl+TeBjk+WM5ac1bMDnA0Mi1lE9awK/KqDmr7/E9uL
	 EoGhfFge4zrCLH7WchAKtG15UJelE5Tgx8LMiwofINFJyfiHo+7K+bketlhm70NuJe
	 yzlw3rtJG8kw65nmL09vHGyI5alA9VzRPq7uF0d9CinRzcS7Dr09lbXKZhLY9ufaGA
	 iZoJ89cEq4ECg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Anton Vorontsov <avorontsov@ru.mvista.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Chris Boot <bootc@bootc.net>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Dhruva Gole <d-gole@ti.com>,
	Felix Gu <ustc.gu@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Foon Tan <lftan@altera.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Gabor Juhos <juhosg@openwrt.org>,
	Giulio Benetti <giulio.benetti@benettiengineering.com>,
	Graham Moore <grmoore@opensource.altera.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Han Xu <han.xu@nxp.com>,
	imx@lists.linux.dev,
	Jayshri Pawar <jpawar@cadence.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Johannes Thumshirn <jth@kernel.org>,
	Konrad Kociolek <konrad@cadence.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Murugan R <vadivel.muruganx.ramuthevar@intel.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Parshuram Thombare <pthombar@cadence.com>,
	Pratyush Yadav <p.yadav@ti.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Suresh Gupta <suresh.gupta@nxp.com>,
	Tomoya MORINAGA <tomoya.rohm@gmail.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Witold Sadowski <wsadowski@marvell.com>,
	Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v2 00/10] spi: Fix DMA, bounds, clock, and chip-select bugs
Date: Fri, 27 Nov 2026 15:31:03 +0000
Message-ID: <20261127153158.2969573-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These issues were reported by Sashiko.

This v2 series addresses Theo Lebrun's review feedback on
cadence-quadspi (patch 06) and rebases onto spi/for-next.

v1 => v2:
 - Rebase onto spi/for-next.
 - Reject num-cs values exceeding CQSPI_MAX_CHIPSELECT in cqspi_of_get_pdata(), store cs as u32, simplify the commit message, and drop the stable tag in patch 06, per Theo Lebrun's review.

Cc: "Théo Lebrun" <theo.lebrun@bootlin.com>
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Chris Boot <bootc@bootc.net>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Dhruva Gole <d-gole@ti.com>
Cc: Felix Gu <ustc.gu@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Foon Tan <lftan@altera.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Gabor Juhos <juhosg@openwrt.org>
Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc: Graham Moore <grmoore@opensource.altera.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Han Xu <han.xu@nxp.com>
Cc: imx@lists.linux.dev
Cc: Jayshri Pawar <jpawar@cadence.com>
Cc: Jisheng Zhang <jszhang@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Johannes Thumshirn <jth@kernel.org>
Cc: Konrad Kociolek <konrad@cadence.com>
Cc: Linus Walleij <linusw@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rpi-kernel@lists.infradead.org
Cc: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
Cc: Murugan R <vadivel.muruganx.ramuthevar@intel.com>
Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Parshuram Thombare <pthombar@cadence.com>
Cc: Pratyush Yadav <p.yadav@ti.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Suresh Gupta <suresh.gupta@nxp.com>
Cc: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Witold Sadowski <wsadowski@marvell.com>
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>

Lee Jones (10):
  spi: fsl-cpm: Map the zero page's address, not its struct page
  spi: bcm2835: Store native chip-select GPIO descriptor per device
  spi: ch341: Limit transfers to the hardware packet size
  spi: sprd-adi: Do not copy uninitialised data to rx_buf on read
    failure
  spi: topcliff-pch: Advance tx_buf between DMA chunks
  spi: cadence-quadspi: Validate num-cs against CQSPI_MAX_CHIPSELECT
  spi: cadence-xspi: Zero the tail word in m_iowriteq()
  spi: fsl-qspi: Propagate clock errors from fsl_qspi_select_mem()
  spi: cadence-xspi: Advance tx pointer between Marvell b0 chunks
  spi: cadence-xspi: Skip tail read for qword-aligned Marvell b0
    receives

 drivers/spi/spi-bcm2835.c         | 18 +++++++++---------
 drivers/spi/spi-cadence-quadspi.c | 12 +++++++++---
 drivers/spi/spi-cadence-xspi.c    |  8 ++++++--
 drivers/spi/spi-ch341.c           |  6 ++++++
 drivers/spi/spi-fsl-cpm.c         |  3 ++-
 drivers/spi/spi-fsl-qspi.c        | 26 +++++++++++++++++---------
 drivers/spi/spi-sprd-adi.c        |  3 ++-
 drivers/spi/spi-topcliff-pch.c    |  5 +++++
 8 files changed, 56 insertions(+), 25 deletions(-)

-- 
2.56.1.839.g22a8290db9-goog

