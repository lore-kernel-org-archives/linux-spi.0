Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B7D49502B;
	Fri, 14 Aug 2026 17:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786730134; cv=none; b=FJYzfWRTsoBTnjN8bo+powZR7mvAZn90Ln1jmgLh0rtr/u14j6CtpYjEC5RhOt6jrX6BVOuhklB8qkDRnUozPu2H0tjLzCMDlCtz+Fkf5/1eF6NmtT+H73wf+qIDHHjMEDgsO0xS9JejVlb3hJd4TwyTKauVCDg/u8V4kRxbgVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786730134; c=relaxed/simple;
	bh=ZCI0nioGzrIRiazrtSfxql80pwLfQkvWbK9WgVNYzN4=;
	h=Message-ID:From:To:Cc:Subject:Date; b=hx025RXtGLpJRLtSnssSxUzcuEl9CYVvVWwp56GMYY69RVp4XQQPUvDvZcwn7e4j3jaIRhlWgVPqRj5RHfkLK6MaC/6mkh1fg8k3dAs+oTWAEq8fpFfcdhFYz4x8ZER5UMP0tRMJsnbxY+73qyn2rylOAeEmpxpKaoPKkZcqgKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArWC8zgu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArWC8zgu"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9114B1F000E9;
	Fri, 14 Aug 2026 17:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786730128;
	bh=1UKAHXA7fUJFQD1FC/GvY/Tr/zmPtl2ROWc3wrHyWh8=;
	h=From:To:Cc:Subject:Date;
	b=ArWC8zgu1DOrmAXFK7DWF48glvjTENDBUUQVhSDx1zNOca1owCMCPHADDZNsKvtMH
	 flHzS6JHyHwrQlaQfsD7/AWJwkbPicOHNpcQXAvMkD41L21JuVuOIdYFImFBJNeRFS
	 KcqUd2I7hp2YbyemfvBuCGfcV+ipep/lJHGtJvdJlukxtJnzDd8RhyVQYAWqLzNr+y
	 BFeCT04YlvWT/nAppJ1Gc1zaH4YpuhFlqgVk+P5p3r1pV8hFUNHK/GBq+inaSgsHkG
	 bEzpvrNoI9sg40YtjLI5ca3mIQla3QEEV1ZC3+B5ent3ap9HseTJKnV/BosoRg2J9H
	 YfwaE+JsnkBxQ==
Message-ID: <917f2746ec579064ac9e7603c3e3ee73@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.2-rc7
Date: Fri, 14 Aug 2026 18:55:20 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 075b74841bd0065a3bda3440873c747938e69b68:

  Linux 7.2-rc6 (2026-08-02 16:24:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.2-rc7

for you to fetch changes up to 11058bd3d47d57eb3473935feae53868d6d168b7:

  spi: virtio: mark device ready before registering the controller (2026-08-13 17:34:01 +0100)

----------------------------------------------------------------
spi: Final fixes for v7.2

A couple of relatively minor (but as ever important if you're hitting
them) and straightforward driver specific fixes, plus one new device ID
documented in the DT bindings for the DesignWare controller.

----------------------------------------------------------------
Jasper Wise (1):
      spi: virtio: mark device ready before registering the controller

Jisheng Zhang (1):
      spi: dw: fix wrong RX_SAMPLE_DLY setting after resume

Swark Yang (1):
      spi: dt-bindings: snps,dw-apb-ssi: Document Axiado AX3005

 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 5 +++++
 drivers/spi/spi-dw.h                                       | 1 +
 drivers/spi/spi-virtio.c                                   | 2 ++
 3 files changed, 8 insertions(+)
