Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EF0340407
	for <linux-spi@vger.kernel.org>; Mon, 22 Jun 2026 17:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782150506; cv=none; b=aVqV525W7bBvM3bG2ohPHhTssVCBM6kzfMowgCoBBvWZqCFqX7w5Tzm5BSjbWMeWUObKPHggyD+qRFfhMTHG81r2rtAayvBujaUKtjchPXL9HVORtRe9W0w6oNK/lODjkZjCyGMutAHKrPMBeAyZi6xWKgwKpbzvB/0ytbH3hJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782150506; c=relaxed/simple;
	bh=jXVsZuyj61Xum1pl6F+8ziCMpi8CAqVuvIzMazUAvgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Le8coM9/cAOw0figNdPcbxRepn7WH1Cq1X+72W/RRw9z2kH1BJ/G8vrL80oeOvAc9dpQbsyN1lXA+bNRNvz0rzw03kq3S4IR9aD1GpzXkogJ7B0GtgHMVCT3C26akvQdqLKP+5LtY3XvrJd2aOq1IDGarfTHlceTXx2CWSeMp7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=RUFTBQhK; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="RUFTBQhK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=98fOnd/8/9eYZd
	Fwvzqrt9LM1h6d4a2PxT5360o7h74=; b=RUFTBQhKSp2E3XtpClNF4krNIrY4HT
	ha1Va9iKAlr3r/RMXZErY/9UuPzvVTzYhsq9CJEIPhjzS4fqA9RNk5HIonlhKGHL
	DnmGA2eYSQKEOwMdXHuKdlgHuw8l85mRujspUsPABjaOt8gywwtRk/XWkkH7l7lG
	ww3DfMOhQGs8Kec+z2bp8zleVE4HX4ullE7xG0yXyJeqH97x4dTi8nyGM73mWk8O
	NsKLRMGYDpztPVM2QjlGIhJiOWqZ0sifxc4BNF4EivyBFDrLXU4WePgeQ0Lay/uT
	YbEhYSPltifHPoX2/O1W5JNNXbSJA3cBf9rxbBgd1tSJPe2xF6KDVJ1g==
Received: (qmail 2061352 invoked from network); 22 Jun 2026 19:48:20 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Jun 2026 19:48:20 +0200
X-UD-Smtp-Session: l3s3148p1@jnp9P9tUeKQujnum
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-spi@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v3 0/3] ARM: dts: renesas: r9a06g032-rzn1d400-eb: Enable SPI and FRAM
Date: Mon, 22 Jun 2026 19:48:06 +0200
Message-ID: <20260622174806.74450-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are the patches to enable the SPI-FRAM with FIFO (no DMA yet, needs
more work) on the RZ/N1D Extension board.

Changes since v2 in the individual patches.

A branch is here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/n1d/enablement


Wolfram Sang (3):
  spi: dt-bindings: snps,dw-apb-ssi: add 'power-domains' property
  ARM: dts: renesas: r9a06g032: Describe SPI controllers
  ARM: dts: renesas: r9a06g032-rzn1d400-eb: Enable SPI-FRAM

 .../bindings/spi/snps,dw-apb-ssi.yaml         |  3 +
 .../dts/renesas/r9a06g032-rzn1d400-eb.dts     | 25 ++++++
 arch/arm/boot/dts/renesas/r9a06g032.dtsi      | 84 +++++++++++++++++++
 3 files changed, 112 insertions(+)

-- 
2.47.3

