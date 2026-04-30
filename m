Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22CF450911;
	Thu, 30 Apr 2026 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564601; cv=none; b=reh2nmtCRWYnUvycHteRFWZGZsnbpFolLgWDomSOfTdJVWSrbnRK1FvN3kog65tRojuzZNBvk3M9vAKpN987IsIvc73bqF8tkk1V9dJ4/Wew3nCLJkQEchfceACUoGm2W4PuGjagm75smASfb4U4DccTF0dX0WMeX7VQMjIDEd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564601; c=relaxed/simple;
	bh=x4px131zQjXjk02OcBhjKDikCZDt3dgwSRZbN5Xjyqo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C7weQvHWCwDr16GQnoq+FJHm/489RsmlkKC4zUmZhKM3Dl06DnGGjaau3uticigNNCUOcxEhLgUUnWTc7Cb7I7c300nXWmvWlIK7AvuYE0LDPXo4tAzm8sgGbzk/SBTi6miV/3aBHz4mMGnw0/u7Wrd7q6dHq34E/HKzcj1Lmw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fnEcgzN2; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fnEcgzN2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=o8
	u8w2UWcyZeZiwf05Vd1PKU6i5IHTCnVEoz7yLvk1c=; b=fnEcgzN2VFnVE3cMIH
	9ZUq5Q4C0+a+IlpYW+iGSTDe56JVGkJLGxSXC3uPO2+P+5p5N6L6UibBwGRUG3v1
	PV843Fz76Y+g8t8cRBuYMH6XK7KNltgmjSRbGADxjZrcUIcAM/DFDizXvFLFpxdP
	YGE/Q2KsUhdvyJLJ3YRE0mxfU=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAXyu5Se_NpHedTCg--.49548S2;
	Thu, 30 Apr 2026 23:54:59 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: broonie@kernel.org,
	sunny.luo@amlogic.com,
	xianwei.zhao@amlogic.com,
	neil.armstrong@linaro.org,
	khilman@baylibre.com,
	han.xu@nxp.com,
	haibo.chen@nxp.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	lhjeff911@gmail.com,
	hayashi.kunihiko@socionext.com,
	mhiramat@kernel.org,
	jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 00/10] spi: Use FIELD_MODIFY() for bitfield operations
Date: Thu, 30 Apr 2026 23:54:46 +0800
Message-Id: <20260430155456.36998-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXyu5Se_NpHedTCg--.49548S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw43GF18GryUWryrGryrXrb_yoW8Jw1DpF
	4fGFyxZw4xJ3yYyF43CrWYkFyaga93WFWqg3W7twn3ZanYyFyUXrWDK3WrJrW7JF97GFWx
	KFWjkrZ8CFs2vrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi1SodUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BRL7mnze1RXzAAA3z

Replace open-coded bitfield modifications with the standard FIELD_MODIFY()
macro across multiple SPI controller drivers. This improves readability and
adds compile-time checking without functional changes.

Each patch modifies a single driver, allowing independent review and
application.

Hans Zhang (10):
  spi: amlogic-spifc-a1: Use FIELD_MODIFY()
  spi: amlogic-spisg: Use FIELD_MODIFY()
  spi: cadence-xspi: Use FIELD_MODIFY()
  spi: meson-spicc: Use FIELD_MODIFY()
  spi: nxp-xspi: Use FIELD_MODIFY()
  spi: sn-f-ospi: Use FIELD_MODIFY()
  spi: stm32-ospi: Use FIELD_MODIFY()
  spi: stm32-qspi: Use FIELD_MODIFY()
  spi: sunplus-sp7021: Use FIELD_MODIFY()
  spi: uniphier: Use FIELD_MODIFY()

 drivers/spi/spi-amlogic-spifc-a1.c |  5 ++---
 drivers/spi/spi-amlogic-spisg.c    | 13 +++++--------
 drivers/spi/spi-cadence-xspi.c     |  3 +--
 drivers/spi/spi-meson-spicc.c      |  5 ++---
 drivers/spi/spi-nxp-xspi.c         | 12 ++++--------
 drivers/spi/spi-sn-f-ospi.c        |  5 ++---
 drivers/spi/spi-stm32-ospi.c       |  7 +++----
 drivers/spi/spi-stm32-qspi.c       |  5 ++---
 drivers/spi/spi-sunplus-sp7021.c   |  3 +--
 drivers/spi/spi-uniphier.c         | 13 +++++--------
 10 files changed, 27 insertions(+), 44 deletions(-)


base-commit: 3b3bea6d4b9c162f9e555905d96b8c1da67ecd5b
-- 
2.34.1

