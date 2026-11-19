Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079899;
	b=xiZLk/X/EsgzGA8TtMoH8HfKcaal93kyWyWBMBflGvPRE9r7pb2YM+1CmMfrELnC03GQ
	 8wf7Ghx1aj72QkHDfIye+6SoDhjqvMtQb2BmJc+9cqKHF2mLB8GDNdY5m45V219jUuqh5
	 N8DajZtomoCda+HMgvA9oCFM2Y1dsi3/fiZokeLmwiVhDK5z8lPu1HCKZ8Lx/jF5F7UR2
	 IuSoNICzJ5FvtV8mmHGhF9WBuaV67884+gS4jA88clGaiMNtLwKrxloMUKgAMGorZPfIb
	 PG3ngijNRew8JW2OUCH4/FFdbkl92ucguyTxQHmAD1WDDkZ28xKWBNwVEDgdb4Dq2Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079899;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=v3bo8ZcbgAObjcXddzvPQDs3qKip3UcYyi2IBIcsxXE=;
	b=xF2XvQqVFfE6byW+SscXthuvFFM+plcyweVYJJ2UuMT/3QZCbprOFArFkRwVjYkzXkbd
	 QvY1w6VSh3HjqjWPKTg49sdHOO40S5CTUYwWAR5Iai3fn1fRwZ+8TAdqGlJAKUaMPfvg/
	 q35zNKx3Y5rWaskk5/5849DnE0iBqNzJYyyBYSfpZzRtJc49DRQW7rgnHVhYzDahCY4rS
	 FTiEXxkMecHuWtJurgM02l75ybJc/654hNyfVROEKFn2fj8ev6Q89sIVWH/YklrbCHA0q
	 8kalOUCVoHB1eCaMadPTWmZN0HtTezHUazhjl5VMPSuF2XDaKktWs+XtZeVGclLEPSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cUlTbof7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DB9606A324;
	Thu, 19 Nov 2026 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cUlTbof7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19B51F000C5;
	Thu, 19 Nov 2026 09:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795079899;
	bh=v3bo8ZcbgAObjcXddzvPQDs3qKip3UcYyi2IBIcsxXE=;
	h=From:To:Cc:Subject:Date;
	b=cUlTbof7TRhkdIj9zM4tAOPe0BxnlUOXyAgKKafiWTNT7F37OrMgblULvjHOKHi7B
	 7kJ68GQ0aMp8WMQbw4aC8lMNrvwUI6lA1C6kJcpAGHDKysiBnB5+FNjwJgiPrnjngT
	 cYH32bJQ6VPHjApvcg3HgSlzaIRhgMMEeHCf49Zvb0v3zOqVL6NSn2USYZo/llzCNe
	 uPV6dDgTc8I12wAuxTfy5qWgbfoaFD15SdhpYdz49kFnYyR6s/dTsaIp51i6PrqDSb
	 2oZ5uY6GET3M+5w2+rb74fN+2RO5sL5kV7Q5hSeu+5/2Gsawym3Srgm4tubLNwcwKF
	 u1CnU5Mu0dqKg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
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
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Tomoya MORINAGA <tomoya.rohm@gmail.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Weibin Liu <liuwb@xiaopeng.com>,
	Witold Sadowski <wsadowski@marvell.com>,
	Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH 00/10] spi: Fix data corruption, uninitialised data leaks and bounds checks
Date: Thu, 19 Nov 2026 09:17:12 +0000
Message-ID: <20261119091810.3440619-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
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

The series is based on spi/for-7.5, since patch 5 relies on the
following commit, which is not yet in Linus's tree:

  3515e312e096 ("spi: topcliff-pch: clamp DMA bpw_len by bytes not words")

Witold, patch 10 is derived from the TX-only accounting in the Marvell
b0 path, so confirmation that it matches the hardware's READ_DATA
behaviour would be appreciated.

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
Cc: "Théo Lebrun" <theo.lebrun@bootlin.com>
Cc: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Weibin Liu <liuwb@xiaopeng.com>
Cc: Witold Sadowski <wsadowski@marvell.com>
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>

Lee Jones (10):
  spi: fsl-cpm: Map the zero page's address, not its struct page
  spi: bcm2835: Store native chip-select GPIO descriptor per device
  spi: ch341: Limit transfers to the hardware packet size
  spi: sprd-adi: Do not copy uninitialised data to rx_buf on read
    failure
  spi: topcliff-pch: Advance tx_buf between DMA chunks
  spi: cadence-quadspi: Bound chip select against f_pdata array size
  spi: cadence-xspi: Zero the tail word in m_iowriteq()
  spi: fsl-qspi: Propagate clock errors from fsl_qspi_select_mem()
  spi: cadence-xspi: Advance tx pointer between Marvell b0 chunks
  spi: cadence-xspi: Skip tail read for qword-aligned Marvell b0
    receives

 drivers/spi/spi-bcm2835.c         | 18 +++++++++---------
 drivers/spi/spi-cadence-quadspi.c |  8 +++++---
 drivers/spi/spi-cadence-xspi.c    |  8 ++++++--
 drivers/spi/spi-ch341.c           |  6 ++++++
 drivers/spi/spi-fsl-cpm.c         |  3 ++-
 drivers/spi/spi-fsl-qspi.c        | 26 +++++++++++++++++---------
 drivers/spi/spi-sprd-adi.c        |  3 ++-
 drivers/spi/spi-topcliff-pch.c    |  5 +++++
 8 files changed, 52 insertions(+), 25 deletions(-)


base-commit: 9b2d7c8736a6fd27ceda93bd67529758c139e24f
-- 
2.56.1.708.g77570a6a1d-goog

