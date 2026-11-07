Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794051240;
	b=2xDmmt02S5PCclTEVgCv4rfAp0W1YAgrCWE/S2uzCKnVG48uyR7J+OPMs1j6xRwajrSj
	 xmsHnISn9Ji3fVXL3mEXcQy0MaQj/01WB719L7PuV4iPPbQdRgILc0cA5JIVSZ0DRr+Wz
	 JevnUHnurEjpfFmAiCfyLBX1GWi5ssAHAAM8QhSts3K/cODiMEUmvFRbaMt4VpusZ+wlU
	 8IhMo9sY3mmePihZ4sWhPBlwwADP+zA8ysNHp+cHE3jQtJXMNinhL2H2zDJF3CdytC7mx
	 7KY53MUY0EQGVjeo3M8MNzCta17Igujad36WczvR7WuA2n+My09BgC8DRUh7Ze6fppQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794051240;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id;
	bh=h/zw5ns+k65npU9PUVLHDycr15odEsRHc1ruYXyJeOg=;
	b=NR8mE8RH6cUJR/oC2RUMJQvkrUqUP86pnfXUgXSOYEhQ1DpQ3o8/DW/zsKQGipGe7ign
	 U3pciYuxY1bFg3A9Ba0CHp/czt9FOKQMQ4t4HbaQwQhovYdax90Y7LwRfgbDj7inGU2Ve
	 7kqhvaxt+PmMpy8jJKsazp3ODnLW+MwIJN3vF5tmc8IYKz5ObtYotjjRCz5IQAh56IJD5
	 22OFNzfeixLCTcuxqdvZ/TSfTGSzFLBnC6b30T0Pw2YZFm/W89h/RHl/dio1MFI4I5pPA
	 qXbGzAQZyYuq9VNBi4mAqU8+BMyen4Fdd8gdQ3olfSACXPF2YD/7S1fQ0BbG8rrIMTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LDuHqhX8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAB7606A326;
	Sat,  7 Nov 2026 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LDuHqhX8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4C71F0089F;
	Sat,  7 Nov 2026 11:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794051239;
	bh=h/zw5ns+k65npU9PUVLHDycr15odEsRHc1ruYXyJeOg=;
	h=From:To:Cc:Subject:Date;
	b=LDuHqhX8lji0Hd9PlO+Ismr9tKqM4ipYv5VHnax34EHSRoKZ9FF2ICrNantDc1Gf/
	 EQe+Ngpb79sd0LLyNXGCPBR/KpRma//tDXKRxr5HQ/ENxYLy+35v1xtFd7h1ACADXq
	 3ZebpM5F5qf16gEvinEn7wAcf6W9HxseELg3hO8OQ9eB02SC8nFrj0fwZyW3rw2e6P
	 A0W6jifmdvz0bCG3rt7n6/VRJj5ojVBtZL+WRbI3IafHiP65kqmmi1SzzNRPpSnp2S
	 VdHS6oPHxyvFloETTdaU0BgPQote4DdK6AWL3f17eMgvlK7NG1U3xo/6iXTV44GE7b
	 c+R+gb0uQNktg==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 5BCDD28F332C; Sat, 07 Nov 2026 11:33:57 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.4-rc1
Date: Sat, 07 Nov 2026 11:33:18 +0000
Message-Id: <20261107113357.5BCDD28F332C@traversing.sirena.org.uk>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list

The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.4-rc1

for you to fetch changes up to 059518f775baecc9803fc97787bd0b17558f8047:

  spi: cadence-quadspi: Fix race between DMA completion and transfer start (2026-11-04 23:00:32 +0000)

----------------------------------------------------------------
spi: Fixes for v7.4-rc1

As well as a few driver specific fixes we have a couple of core fixes
here.  One avoids requesting interrupts until we have validated that we
have a SPI device, avoiding triggering warnings on boot.  The other
avoids a request for a zero length scatterlist triggering a BUG_ON() in
swiotlb on 64k page systems, this was due to using both DIV_ROUND_UP()
and min() to compute lengths.

----------------------------------------------------------------
Arpith Alexander (1):
      spi: ljca: Don't require data in write replies

Chunfa Zhang (1):
      spi: fix zero-length scatterlist entries for vmalloc buffers

David Carlier (1):
      spi: rtk-nor: Limit exec_op writes to one byte per operation

Frederic Konrad (1):
      spi: cadence-quadspi: Fix race between DMA completion and transfer start

Hongjian Dai (1):
      spi: pic32-sqi: fail transfer when the BD ring is exhausted

Rosen Penev (1):
      spi: acpi: only look up the IRQ of confirmed SPI devices

Weibin Liu (1):
      spi: amd: validate FIFO usage before executing message

 drivers/spi/spi-amd.c             | 24 +++++++----------
 drivers/spi/spi-cadence-quadspi.c |  4 +--
 drivers/spi/spi-ljca.c            |  5 ++--
 drivers/spi/spi-pic32-sqi.c       |  3 ++-
 drivers/spi/spi-rtk-nor.c         | 13 +++++++++
 drivers/spi/spi.c                 | 56 ++++++++++++++++++++++++++++++++-------
 6 files changed, 76 insertions(+), 29 deletions(-)
