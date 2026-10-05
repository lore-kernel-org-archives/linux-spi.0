Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DDB4C680B;
	Mon,  5 Oct 2026 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214661; cv=none; b=VWkrJJpZIbbj1NimQmemCB0RCpKl1dqMiMMMt0OQplc5ceSSeBciJWEwYVhyUFS4we7oXst2UJdkE3RXNRt67Ekj2hOUH1/U57xWB2qV3gkaFjYXc3YS8ysydFUHUxOnPUjaD102KXQf0ZKwThrWBtv7jM4+Od4xm77MhQ9qemo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214661; c=relaxed/simple;
	bh=9+9S31deoiNpj3Vy5EPGJdqG+2N4TChhVWMomTufivo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MhNGi+A60bpgtCkwm2TtvDjPUQviqBscPcQGjWmxpwXDOmXyLMkdC3WxSl2eMsAZFngkBQIaY9BW1tyT+36SZk1fULY3r30nVl7/q1o3bxm9ujIrIfnmKapBOZRB08Qx++ltfrUyL142TLh2DgKKTFYhYzo+77d3LE+XSZAqVDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2+qzmgR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2+qzmgR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC491F000FF;
	Mon,  5 Oct 2026 15:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791214658;
	bh=0Fg8GFhD5h9MItfMFB/E3GaWzAhhnFMJhFQEsihPyDw=;
	h=From:To:Cc:Subject:Date;
	b=A2+qzmgRFVd0Jjo3RE4R6N6Ygq22f/UI7s0jE9CGAfqvTHeM5YL4r/TGnK9lNs8HB
	 bCcZTJue3k/I/fw55CVJmehZb2ZmyfE002xLcBICRrNbSgSCWUL11ap85+LkYP0shQ
	 uoRZ8xCb8jt/EylSZX3Ra6LKRcd2PSexkIARICNWvTO2tg9o9h7pQAmDq8scT3b48v
	 uGteAjB2d3MklHXVBrmkHkxHaW3WYBUQ2XEmspLO4FQgWvUKigq/Kq+NngnRBq/HVt
	 vVTSUFJmAlXLYZ7odoMC9DzX0VIVi6AtNEUYv8/SkkA2uPDr1eA3G1tyZtE23MSiWc
	 ZFasmV3N6Wlpg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Joseph Steel <recv.jo@gmail.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] spi: dw: use threaded interrupt
Date: Mon,  5 Oct 2026 23:17:35 +0800
Message-ID: <20261005151739.25233-1-jszhang@kernel.org>
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

Since v4:
  - rebase on the latest spi for-next tree
  - set a local flag before we complete the transfer and use that to 
    decide if we wake the thread.

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


Jisheng Zhang (4):
  spi: dw: remove useless dws->transfer_handler check
  spi: dw: remove duplicated "!rx_len && !tx_len" handling from
    dw_spi_irq
  spi: dw: restore previous irq handling behavior when !ctlr->cur_msg
  spi: dw: use threaded interrupt and optimize the threaded ISR

 drivers/spi/spi-dw-core.c | 79 ++++++++++++++++++++++++++++++++-------
 1 file changed, 66 insertions(+), 13 deletions(-)

-- 
2.53.0

