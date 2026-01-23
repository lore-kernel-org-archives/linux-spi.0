Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A29309F0B;
	Fri, 23 Jan 2026 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182165; cv=none; b=ahWhrwNWmEhzLDgZvGBtv2PkDKHHAgCiVXqMt4F+QPiaFX5A563cR0z6Qx4ihYSePN4CktJWcK4ZfQ/rzggE3JgCV5Uleno1C3ojDN/uWRpwVjvRaMtL/H5d0mVRKyv8dVaw1R5GhMo4e3QbsEFVGCK9UOcgqUBNmwr6mr44FW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182165; c=relaxed/simple;
	bh=gH02QlJQaLm6XEQw6LVYN6ak2l07+UUuAjPMx6snsUc=;
	h=Message-ID:From:To:Cc:Subject:Date; b=Fx7exDnw56/NTRf1GnE+p6EaA2m0hlEO1UN8d8iLcJrJl0hOeINHQNLEpSI5pq+y1Jhj25wTqzCr+0dsnkKyZ1OYe4zqT03oNMRnA32z7ba4N0tFGhRtNjt7xhEYIfhad8BzHN/TVfgkuEGkWwAnaE4QWxQyju/9LHp1wWCQwOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3voaKGr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3voaKGr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B61C19421;
	Fri, 23 Jan 2026 15:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769182165;
	bh=gH02QlJQaLm6XEQw6LVYN6ak2l07+UUuAjPMx6snsUc=;
	h=From:To:Cc:Subject:Date:From;
	b=a3voaKGrG+iEc+P5ECa9o6ukS1OB+T33ts6amuMJzqfocLnrGhlgoTKSrNopZjBvd
	 PjbcwmC+myUtLnHKf6ZAEgzETbHbBa0mjiYpwDTBmujLi5dVeLHeqsb6c9c7SGJkjD
	 BoOSMJCElzW5ZPTPKEPMA3DUHcqRffdww/dMejk0HZW01dcCNTx3Digj44oUxlP2wC
	 EOTdObziIa4HQ8XbfZo3ySpcBf+qNcLh1VfuCESyrIcV8Rca2T3QvL7x3UY8dfudEg
	 aWPfUBzV495UDry9IWLsd7aObam0C878gTS2N4aSEi4NM3TZwY/xWSXdh3ieHpo0lC
	 J5+fjgAvdz5Tw==
Message-ID: <d83f7fb290c025fcc0f6072c521c8de1@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.19-rc6
Date: Fri, 23 Jan 2026 15:29:14 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb:

  Linux 6.19-rc4 (2026-01-04 14:41:55 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.19-rc6

for you to fetch changes up to caa329649259d0f90c0056c9860ca659d4ba3211:

  spi: intel-pci: Add support for Nova Lake SPI serial flash (2026-01-15 14:21:29 +0000)

----------------------------------------------------------------
spi: Fixes for v6.19

One new device ID, plus a few fixes.  The most substantial of the fixes
is for the Cadence driver which in at least some instantiations requires
transmit data to drive data through the IP.

----------------------------------------------------------------
Alan Borzeszkowski (1):
      spi: intel-pci: Add support for Nova Lake SPI serial flash

Devyn Liu (1):
      spi: hisi-kunpeng: Fixed the wrong debugfs node name in hisi_spi debugfs initialization

Felix Gu (1):
      spi: spi-sprd-adi: Fix double free in probe error path

Jun Guo (1):
      spi: spi-cadence: enable SPI_CONTROLLER_MUST_TX

 drivers/spi/spi-cadence.c      |  1 +
 drivers/spi/spi-hisi-kunpeng.c |  4 +---
 drivers/spi/spi-intel-pci.c    |  1 +
 drivers/spi/spi-sprd-adi.c     | 33 ++++++++++-----------------------
 4 files changed, 13 insertions(+), 26 deletions(-)
