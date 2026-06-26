Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3323AFD09
	for <linux-spi@vger.kernel.org>; Fri, 26 Jun 2026 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782497018; cv=none; b=Psf+0ddRFrqxlFCEeBo1DI4oE+X1bn9DV4AIrQm/iXyLsQjVHvRy2FpYZdj3XV2SbsRc+stAaXgJ47VNvT8ZDoqOzizQnTU/CdncWoOLhNjIBkcFeaZimNGo3aoxaMIOE6CNCECoyNtZugs5KJzGMnbpUNdZajBAmVC70URquXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782497018; c=relaxed/simple;
	bh=s7xBp1H0wGdo8I1sp3eY768OcZzzCKwmFYCT6Bydp9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o4P6E0eiJhYrnDd3fW7HZpSXv7jY/Xz0HxbZxT/AXwuzbz4cjVLN5vxvk2/UoRjYpptnpTTQTyNjBRTlcO9ad9UDjpMCQm7i45OYvyeE+DlBei42khoFQDrJMyR0wqUOOP6tQNzTujTf5Ylvu0CSbBVYFS6Kmj4v8zgo+LCLD8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=IQDxmxSv; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="IQDxmxSv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=1Ed4nzYVqoNXEL
	H6/tZCB843BS+oVV4Ld3xC9fFGB7I=; b=IQDxmxSvH+sAAdgtqyNtXtBS7MvszB
	SgZyeUicrL2u4t02aA43QcbWS+jRTpA9wdwCezo4mXq9oRynMPGwg4xRold0Gv2x
	beEoC2f/w17G8OWruVlAEqlBY/ee2V+6NqappZUafZ2lmJzoqlVZBfICgxv5cLA/
	z0lkKkRcX0tGi+kDYvfiSVDJdiPZhG77J9kZspXCm4atafsIHUVIqiBtKsjjCrho
	yx6I1BV1BY8QpEpY+m9dw9n5K1HgK+s1rjH55g6tB/pOdClCUN4PiYZpafhHtkRG
	uptheSAV4TzISkJCAj/HuIS93RhIHqRTHVT0kIvBddzmMmjkPOj6W0uw==
Received: (qmail 3649196 invoked from network); 26 Jun 2026 20:03:31 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 26 Jun 2026 20:03:31 +0200
X-UD-Smtp-Session: l3s3148p1@+Swu7StVjMMujnsl
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
Subject: [PATCH v4 0/4] ARM: dts: renesas: r9a06g032-rzn1d400-eb: Enable SPI and FRAM
Date: Fri, 26 Jun 2026 20:03:21 +0200
Message-ID: <20260626180326.9593-1-wsa+renesas@sang-engineering.com>
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

Changes since v3 in the individual patches.

A branch is here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/n1d/enablement


Wolfram Sang (4):
  spi: dt-bindings: snps,dw-apb-ssi: drop superfluous RZ/N1 entry
  spi: dt-bindings: snps,dw-apb-ssi: add 'power-domains' property
  ARM: dts: renesas: r9a06g032: Describe SPI controllers
  ARM: dts: renesas: r9a06g032-rzn1d400-eb: Enable SPI-FRAM

 .../bindings/spi/snps,dw-apb-ssi.yaml         |  4 +-
 .../dts/renesas/r9a06g032-rzn1d400-eb.dts     | 25 ++++++
 arch/arm/boot/dts/renesas/r9a06g032.dtsi      | 84 +++++++++++++++++++
 3 files changed, 112 insertions(+), 1 deletion(-)

-- 
2.47.3

