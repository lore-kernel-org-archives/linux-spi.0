Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795371373;
	b=ujvD/lVt6xOxzCk2LBk2Yal0wORTqtLipqmXvjHnVMgElWXaXYakEzSFo+AkOJirBkZ8
	 vy+6D9yVGMEyeg/t+jjGdu9fEsxQRdVgF1PKoK9s3s0oKB5GQyoU7jGaqF27Pndzfhtx9
	 FhqQoUuiqdpDUzqOuiQvuQOy8OK2/qEOERc3d0gd4QOdzr4Tmrzt0r2XT/zgQZuVxonM4
	 2qxYQnQ9RINR7TF3Kz7jyXsglG/R5FT5qP0B1NKANP6PJ3yBLlxESp+T4K8U4EklY4fdL
	 2mr1xidAa5ikbEaTCGUllCZIuRPZ8J3pC6u6tH8f1VJlSFGifpCCraxqt0P1XfjGjSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795371373;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id;
	bh=DvXsH8NCyEWyEME9bF/JUROsC+55vAO6SFEcywf5RI0=;
	b=J1okxUdRJhXNDmT/mWmPkLzQNRe+d1ZYn6NDsLR5J3+QtQHCIVDtPXkL+SDTf3lrmhbX
	 zhQaozvRlMKXKHWDToTOS39mmgyCH+y2hxVpTK1Dc3TT9SqPMFqYvmxdF09FOlnyWpMI1
	 FF8SGEj4bzzuJH3SwNzDVl+uxYHuv4A9Rk6cnya2LJ1bpYXO3H5yUrg17GQsyQ11OV1xw
	 IUQtdn4oCHT+j81v0Y5tQd46/NmXrKxIQCcsqeFjThpiHRIrLE5e7WsINFfVENEzTpydy
	 SNZNhndqLVbjwBBrwx0qcXliBeJAt5/HvlpWLvp7ppuSSY3r6SitZQHo6UmF1ILod7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IurZyZ5c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6417606A32C;
	Sun, 22 Nov 2026 18:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IurZyZ5c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3420B1F000C6;
	Sun, 22 Nov 2026 18:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795371372;
	bh=DvXsH8NCyEWyEME9bF/JUROsC+55vAO6SFEcywf5RI0=;
	h=From:To:Cc:Subject:Date;
	b=IurZyZ5c//W36qInL+tZAOh0d/FlEvjQ8kSi/Q+2VtaVBU6IHrVfXg9Aptxte+Cr7
	 9BLQfmPuKy0iDWSEoSeMDGl4Vu1zF4KgjRbwlXAIICSvL0TciiViQ+j/AvlXSiAhgh
	 4z+eGyk5u9WlDCboZODhGT61AK1bLAi8GWMNN/Uf+JILFcFsCcU1u4fsN8UogfO2Re
	 YfIDB2m4mPNLYcRGWaF2pryEv9qd2Lzs+91MyNQJsTpdsyLN/jNkmWp6YPfI/m8O6z
	 Hi/q6/U28uGzXM9/YI/iWmcUV1CrJtyV7RijJs7DGK/AwKPMoc6M80Vh8ttOt143L6
	 bAh3uBAP6ibhw==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 535713464378; Sat, 21 Nov 2026 12:30:38 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.4-rc3
Date: Sat, 21 Nov 2026 12:29:44 +0000
Message-Id: <20261121123038.535713464378@traversing.sirena.org.uk>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list

The following changes since commit aebb7274476403040d582c61478df8f4a7bf9cd3:

  Linux 7.4-rc3 (2026-11-15 14:30:11 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.4-rc3

for you to fetch changes up to 6008a6e34ca0446739abfff189902af2214cfff1:

  spi: fsl-lpspi: expand FCR TWATER and RXWATER bit fields to 4 bits (2026-11-19 17:32:16 +0000)

----------------------------------------------------------------
spi: Fixes for v7.4

One core fix here, for error handling with runtime PM when a transfer
fails.  That was seen by a couple of people on actual systems and the
fix verified.  There's also a fix for a quirk in the fsl-lpspi driver
which needs a bitfield widening on newer chips to work properly.

----------------------------------------------------------------
Carlos Song (1):
      spi: fsl-lpspi: expand FCR TWATER and RXWATER bit fields to 4 bits

Sebastian Reichel (1):
      spi: Fix runtime PM imbalance on pump transfer message error

 drivers/spi/spi-fsl-lpspi.c | 4 ++--
 drivers/spi/spi.c           | 4 ----
 2 files changed, 2 insertions(+), 6 deletions(-)
