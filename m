Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C37F27A462;
	Mon, 15 Jun 2026 04:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781499595; cv=none; b=fNmzXMqGozL91g8jA2K8Xzi/OjmNEvKTnbLUCXh8y0ewq84blmM2E3xy1duu3dXb4K0H9qkBBlbv3JjdrIyI0u/Nf1MNM4ALFK1vVsan6AT4lx/9mGsyRtkzDgtaQigFYxtBK6tcMyzBl33AwmUyrN9rRq+T9ZC/d6A1M68mgNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781499595; c=relaxed/simple;
	bh=vUzsetj5ZJxwEgPJQnR14rI/k6cSiLE1zaq82W5lGUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rf/hVnJ4P5ImDL9mAar8DdfX5+wybQDsWMGkp9DDnwdrma3PGciqo9s3egEPfNLto771MLjkU39qUAPLDJ9bsZxGZjOF+rzV34YrOxirBV5U/YTyvrLYuH5nv8/6iOIzj0gi0oRBjXsdwQVbdrnIw4LUtQgnG5GHdnNtSNJ0n6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8+bSPWj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8+bSPWj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84C91F000E9;
	Mon, 15 Jun 2026 04:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781499594;
	bh=OfihfLdYT0ior8ItB8rbeUxtzPkvEdmhGfzLAmOy6q8=;
	h=From:To:Cc:Subject:Date;
	b=G8+bSPWjz8kdALAolzE/sA/vZQylvSqlNntijMS14UDZz0lQS7T62b3lyfBiK39Uo
	 FbiDEx8c8cWd1BTan0xlm7ddpKAjlkWCxq2Yd11h6ZYnYS6C88EAl9ru+UrtKf1ouG
	 WFDt/eFxIMB8lZ3SN0UcfXBiLXUVVvI0iXpPo2d9T7KHvTAAKdnRqJ120MkddLiEbO
	 XIePRJ9ApSf6qPp3o7+Ih8Z9yvw0RcGJGb+4Q9xAiMg2OLTR6ZaweUdXL/rZJhDcNK
	 tmPoWCnAkykAVNqWE4XTxauenbQJVYuK9kYzOhly2joc4xYF6jbwF8+URdI2nBO9cX
	 Yu1LBDeZ5JMxA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] spi: dw: use threaded interrupt
Date: Mon, 15 Jun 2026 12:40:34 +0800
Message-ID: <20260615044039.9750-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid blocking for an excessive amount of time, eventually impacting
on system responsiveness, hard interrupt handlers should finish
executing in as little time as possible.

Use threaded interrupt and move the SPI transfer handling to an
interrupt thread.

After that, since the dw_reader() and dw_writer() are called in
threaded ISR now, so we can delay the unmasking interrupts until no
rx and tx action is taken, thus reduce the interrupt numbers further.

patch1 fixes a trival bug which prevents dma usage for the first
transfer.
patch2, patch3 and patch4 are small clean ups
patch5 does the conversion and optimization.

Here are the performance numbers:

Tested with below two cmds
./spidev_test -D /dev/spidev1.3 -s 30000000 -S 327680 -I 1

./spidev_test -D /dev/spidev1.3 -s 30000000 -S 327680 -I 1000
./rtla timerlat top -q -k -P f:95

The first cmd is to check the interrupt numbers optmizaion result, the
2nd cmd group is to check the threaded interrupt improvement.

Before the patch:
each 32KB spi spidev_test transfer triggers 33118 interrupts

spidev_test reports ~22090kbps
and rtla reports:
                                     Timer Latency
  0 00:00:37   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max
  0 #9958      |        1         0        67    103394 |        6         4      2198    105031
  1 #36902     |        1         0         1        18 |        5         4         5        29

After the patch:
each 32KB spi spidev_test transfer only triggers 3 interrupts

spidev_test reports ~23520kbps
and now rtla reports:
                                    Timer Latency
  0 00:00:58   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max
  0 #58362     |        1         0         0        29 |        6         3         4        56
  1 #58363     |        1         0         1        23 |        6         4         5        68

In summary:
before the patch	after the patch
33118 interrutps	3 interrupts	 	reduced by 11038 times!
103394 us max latency	29 us max latency	reduced by 3564 times!
22090 kbps		23520 kbps		improved by 6.5%	


Jisheng Zhang (5):
  spi: dw: fix first spi transfer with dma always fallback to PIO
  spi: dw: use the correct error msg if request_irq() fails
  spi: dw: use DW_SPI_ISR directly
  spi: dw: use DW_SPI_INT_MASK instead of hardcoded 0xff
  spi: dw: use threaded interrupt and optimize the threaded ISR

 drivers/spi/spi-dw-core.c | 108 +++++++++++++++++++++++---------------
 drivers/spi/spi-dw-dma.c  |   3 +-
 2 files changed, 67 insertions(+), 44 deletions(-)

-- 
2.53.0

