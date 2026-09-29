Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB9F524AF5;
	Tue, 29 Sep 2026 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685493; cv=none; b=Etn1bAgEqd4m55ve2wji+6OVK1C50SnAMnRS/8hK6LNkoVeifovzvA+bjiFwo73aTCSV00vgLKPkKM+BHtOfMvdw1eMvQcxsKnYrx0yjFY95VjYjqkTWwYhu7obZpor5a010C3HTX+fQctCkVpdlBHyQUp4uekjayVjXTcqILwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685493; c=relaxed/simple;
	bh=Kpc3sC/4TREv49W5nqI9ecz1Fy8d/aDCXs5E5pAqF/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PT1Zu5Nxea/83xvdDUhNvLLSlmk54ErA9lbjuWOcK3z4YRC8XEJt3PtL+m1Wi59+ttsJpF/CToRHxyrcg4cMaoFsvAlx3kdN9jV56NP2i9ZCy8ruw1kwh9XGuoGEQ4zk4mkVMY7VOo7GqnUnPd+crdy//EJX5++Le1Ydn5vrWsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEi+OM49; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEi+OM49"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E301F000FF;
	Tue, 29 Sep 2026 12:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790685491;
	bh=HsjWXbih28MXj0uDK4HiYVRVFUWcSXViXx0P7LNF0kE=;
	h=From:To:Cc:Subject:Date;
	b=CEi+OM49YKHqBmg4MFzIgT+DGEzxA8x9q7VwMbkHtdSqUKo/NttOTOHfCeIk9U6zQ
	 klDvMz9Dd1RPtla6+a2N1Ts+HYXQ+uE1nwE1MRT/k5MjeR3xWzVVlGpkrG7J0dhrcq
	 EgYiJJLvrOJKirFK5mHyWvlEVciEBO2Knc3saBfUx1RQavURHFyDzZ0/nca9lIKYLq
	 eRq6J/jf/VF39kHK9ytldM8YGLXzrzobEnjDolTIw+eCyuUAtgU7RzkuXiDksdw3rg
	 y3U4FC+B7nRTSGZ2LE5hVQiEN2F73DDOGlyic8HRCADy51kwV/kaR06Ub0cgpr2gfu
	 ohRV5GuTU8cHA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Joseph Steel <recv.jo@gmail.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] spi: dw: use threaded interrupt
Date: Tue, 29 Sep 2026 20:18:12 +0800
Message-ID: <20260929121817.20896-1-jszhang@kernel.org>
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
interrupt thread when non-native CS and host only.

After that, since the dw_reader() and dw_writer() are called in
threaded ISR now, so we can delay the unmasking interrupts until no
rx and tx action is taken, thus reduce the interrupt numbers further.

Tested with below two cmds
./spidev_test -D /dev/spidev1.3 -s 30000000 -S 327680 -I 1

./spidev_test -D /dev/spidev1.3 -s 30000000 -S 327680 -I 1000
./rtla timerlat top -q -k -P f:95

The first cmd is to check the interrupt numbers optmizaion result, the
2nd cmd group is to check the threaded interrupt improvement.

Before the patch:
each 320KB spi spidev_test transfer triggers 33118 interrupts

spidev_test reports ~22090 kbps
and rtla reports:
                                     Timer Latency
  0 00:00:37   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max
  0 #9958      |        1         0        67    103394 |        6         4      2198    105031
  1 #36902     |        1         0         1        18 |        5         4         5        29

After the patch:
each 320KB spi spidev_test transfer only triggers 1 interrupts
spidev_test reports ~23520 kbps
and now rtla reports:
                                    Timer Latency
  0 00:00:58   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max
  0 #58362     |        1         0         0        29 |        6         3         4        56
  1 #58363     |        1         0         1        23 |        6         4         5        68

In summary:
before the patch	after the patch
33118 interrutps	1 interrupts		reduced by 33117 times!
103394 us max latency	29 us max latency	reduced by 3564 times!
22090 kbps rate		23520 kbps rate		improved by 6.5%

Since v3:
  - If native cs, don't use threaded interrupt
  - do one round of FIFO in the hardirq
  - add cond_resched in dw_spi_irq_thread_fn

Since v2:
  - rebase against latest version
  - remove the "spi: dw: use DW_SPI_INT_MASK instead of hardcoded 0xff"
  - add three more patches to clean up irq code introduced by recent "enhanced
    spi" support
  - Don't use threaded interrupt for target mode and the enhanced spi

Since v1:
  - rebase against latest version
  - drop two patches which have been merged
  - correct some performance numbers
  - don't move request irq code block so no changes for err handling code path
  - move spi_finalize_current_transfer to the end of threaded irq fn
  - don't rely on irq status in threaded fn, but try rx and tx as much
    as possible in the loop


Jisheng Zhang (5):
  spi: dw: use DW_SPI_ISR directly
  spi: dw: remove useless dws->transfer_handler check
  spi: dw: remove duplicated "!rx_len && !tx_len" handling from
    dw_spi_irq
  spi: dw: restore previous irq handling behavior when !ctlr->cur_msg
  spi: dw: use threaded interrupt and optimize the threaded ISR

 drivers/spi/spi-dw-core.c | 78 ++++++++++++++++++++++++++++++++-------
 1 file changed, 64 insertions(+), 14 deletions(-)

-- 
2.53.0

