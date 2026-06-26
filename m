Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35F33F4DFB;
	Fri, 26 Jun 2026 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782483170; cv=none; b=flRqFp2BcN+X8rTNb3Ze/5SJm5gzsuhjgc6EwiRA1Dr2W9TlN32eOJGXDbhSHW9YeQh7GAkTucpKMrLLP+RJpMnwOPsEFs1IkRNDI/GRIyFDUlzWUlByoWZxcUT5RxAcRGjgsdpETx1LXvzVz3f1K4ORUBR/0hDKmJP9d0CkSvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782483170; c=relaxed/simple;
	bh=AaIAmaIcAhzqcMZ+WiAYr6Zx8AV7UJF7vGpcL4tMgrQ=;
	h=Message-ID:From:To:Cc:Subject:Date; b=idjVlJFdMZ++cg/z7strwWydAIfSQh81j9lnEE/61lKT5kYGZBuHr7+eNsQEuIivtmkS8NBPMRbL+j2HhrntMy7zex/RaMAHkldy6AVsGiJoDPc8EzQw4GPvcpkaNW62zGYm0o3fsZhMxuK7hjphEVt2RjHDY8wKBNgrbybV8kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3N2q2GW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3N2q2GW"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 230D21F000E9;
	Fri, 26 Jun 2026 14:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782483169;
	bh=ZaDAOc3lpklYV3HcK23okZfDoOe56dxrIHa8mhIkA00=;
	h=From:To:Cc:Subject:Date;
	b=N3N2q2GWNXajUZMSuu1gOfsVakJPb69WzbVMCQag0Zhm4jrnu40gmmMdOz5aJNkb1
	 a2fhYoSSu1DPPfmBu6aORr1fnYnwZxn8pkZ2pX6yw2iKOw5i2AktkuZhiIQk5Q9BO9
	 l9AsOgf8K7yvqNRXudBzvf+aDArydQMhn8eBXcP44D/nxsULMkJS+4wxu8G8hwjWfm
	 c6RG8x0VSnWMO5KGLFP56cMfAZJp5xkaUT/OVlyXgTxw00iNJu26pWqAXTKRcwpObk
	 uiffc6VQlJyu+uGnhrEuU1Fi9BgeaXpUGRWnYkzxCJ23BIVaxz3ZkqfL2JlaiEA97/
	 +ZOPHdsIVZWIQ==
Message-ID: <482117f043cd16e559de7afa1674f5d3@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.2-merge-window
Date: Fri, 26 Jun 2026 15:12:39 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit f846d68992142034b1d34a83200a10cdc713eeda:

  spi: Fix mismatched DT property access types (2026-06-14 01:18:29 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.2-merge-window

for you to fetch changes up to 245404c26563aafb36aafb01298f148db1851be3:

  spi: imx: reconfigure for PIO when DMA cannot be started (2026-06-24 17:52:44 +0100)

----------------------------------------------------------------
spi: Fixes for v7.2

A fairly unremarkable collection of fixes that came in over the merge
window, plus a new device ID for the DesignWare controller in the
StarFive JHB100 SoC.  There's a couple of core fixes included, one
avoiding freeing an empty resource in error handling cases and another
which fixes a NULL dereference which could be triggered by using an
abnormal device registration flow like driver_override.

----------------------------------------------------------------
Andy Shevchenko (1):
      spi: acpi: Free resource list at appropriate time

Changhuang Liang (2):
      spi: dt-bindings: snps,dw-apb-ssi: Add starfive,jhb100-spi
      spi: dw: Add support for snps,dwc-ssi-2.00a

Javier Fernandez Pastrana (1):
      spi: imx: reconfigure for PIO when DMA cannot be started

Jisheng Zhang (1):
      spi: dw: fix wrong BAUDR setting after resume

Kunihiko Hayashi (1):
      spi: uniphier: Fix completion initialization order before devm_request_irq()

Quang Nguyen (1):
      spi: rpc-if: Use correct device for hardware reinitialization on resume

guoqi0226 (1):
      spi: Add NULL check for spi_get_device_id() in spi_get_device_match_data()

 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml |  6 ++++++
 drivers/spi/spi-dw-mmio.c                                  |  1 +
 drivers/spi/spi-dw.h                                       |  1 +
 drivers/spi/spi-imx.c                                      |  3 ++-
 drivers/spi/spi-rpc-if.c                                   |  6 +++++-
 drivers/spi/spi-uniphier.c                                 |  4 ++--
 drivers/spi/spi.c                                          | 10 +++++++---
 7 files changed, 24 insertions(+), 7 deletions(-)
