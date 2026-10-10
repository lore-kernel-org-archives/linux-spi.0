Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAC83515F8;
	Sat, 10 Oct 2026 23:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791676146; cv=none; b=kOILhq9twz5fXPq3dEfmyRV6r3d7co7zAObAH/qcfPlBqNRpET9ZnbUxWrZJivcvLWoNsPR49DXK8NHEjUGuCjgMNIzDhYYXrjUcVRE1/023DyqXpISQYly20r6NszZ/JuLt5610R1Z/h5xDwJrOWQDlLMUM60+BHhaRhKBpOOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791676146; c=relaxed/simple;
	bh=ooKKyB0KMmCNKUQqmZjL81mRjZXOhIio7iD0gVATbfc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=K62HYBcPkf+hSjVTaTrz89sHF8gbI7CFX1TYK09XfUSty8dtAtV6zXEacjypQ6mGQVeYIulNyJ4gacFcSvj2Aby1Kvzg5Kc8FsOJ3ZyaMcs2e07Wq/Pj7yarU6ZRdAEIUDwpw4oP9lmJftwfzRq60U/HFpFT/AnHkQt8+Vobi1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5EbhWs6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5EbhWs6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993C11F000FF;
	Sat, 10 Oct 2026 23:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791676145;
	bh=Vooiol8LU+tE2xufAlGshDUNPhgzUs2Jv23oVx7VuIo=;
	h=From:To:Cc:Subject:Date;
	b=Q5EbhWs601Z8SARBSxxR72Vc7vbWpgQ7UigBJcfjE3GIvIDj82cDM1YCGi5BzIxhx
	 EgHGdw6B3YxLYT2vIErVuFaF7BHVWESTzP5nfWh9Zns5dvv4mkVamwdIYCBTLI9JuW
	 z6bsQssqXMvk5BoaSINHr8MF3+/oSYqOy/ucuoGjQKmpeiR+ixJ5VzlWB2ERXUhYbL
	 4xti09MM44V4ECmyX/65f9AXXI1+/2dS5ukZ2DOn1dlZ3gDLGfmu25ohdiALlTIqsC
	 LRtLe1nyRkstwjsUdIdTcHSok9q3GWkYCOJ+asmDGE9JtWQwiRgZ0LoM7o0HBJwToF
	 zz5QqsRhWjNtw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 606031AC57D0; Sun, 11 Oct 2026 00:49:03 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.3-rc6
Date: Sun, 11 Oct 2026 00:48:39 +0100
Message-Id: <20261010234903.606031AC57D0@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 3d743adf090cd4c9a2120c1e02b0482e88aa0d2d:

  spi: fsl-qspi: Reprogram the clock rate when the operation frequency changes (2026-09-17 19:46:29 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.3-rc6

for you to fetch changes up to 00765a3467b992d0eb56704a28887256317eb4bd:

  spi: dt-bindings: snps,dw-apb-ssi: Add Synaptics sl2610 spi (2026-10-08 09:51:12 +0200)

----------------------------------------------------------------
spi: Fixes for v7.3

A small collection of driver specific fixes, plus a new device ID in the
DesignWare device tree binding.  One of the sg2044 fixes which enforces
clock limits properly is more critical than average since getting them
wrong might lead to data corruption.

----------------------------------------------------------------
Haibo Chen (1):
      spi: spi-nxp-fspi: exit stop mode before waiting for DLL lock

Han Gao (2):
      spi: sg2044-nor: Return transfer errors
      spi: sg2044-nor: Honor SPI clock limits

Jisheng Zhang (1):
      spi: dt-bindings: snps,dw-apb-ssi: Add Synaptics sl2610 spi

Miquel Raynal (1):
      spi: cadence-qspi: Fix status polling with octal DTR chips

 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   |  1 +
 drivers/spi/spi-cadence-quadspi.c                  |  3 +-
 drivers/spi/spi-nxp-fspi.c                         | 22 +++++----
 drivers/spi/spi-sg2044-nor.c                       | 56 ++++++++++++++++++----
 4 files changed, 64 insertions(+), 18 deletions(-)
