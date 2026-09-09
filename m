Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F03548549;
	Wed,  9 Sep 2026 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965801; cv=none; b=Qfa2ihF/i0W7XPipKxEtmR9ZK0HH2NOooHFKPYCXKrT5jAzMcqdHRyOPJ/LG1b//7ijForHfl3HOryMe6xEbVeIQ/3A6t6QqKhnxwF8ZYnfde8xozgfKZgGaaeceU9D/8THrZY6G2hQPCmABPcvRSKvbpgBzotxc7LlcFEo8y3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965801; c=relaxed/simple;
	bh=w+UD1MiUWmIRDloiIPb12y4w/gX4nCmJOiW9H4O3xIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H5dBvzp69PL+HCBO5EzLA6bBZKwXkjm5LudN+eMNDOENoCqxro7YGLr5BHWJV7Qcf9PcczXkYebW1iZplo1lz5zEoR8xbu0wioqNbuV7TTdTlDsIDvWHNSgu+wvX+1w5gHK5Yg/6fTSAsaVmfE/joeXLN0jvF0NlhsXrYlXQqV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G49gV8fe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G49gV8fe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BC61F00A3A;
	Wed,  9 Sep 2026 14:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965799;
	bh=3ay2MobbZQLu2mwYp11snxFg/p8toCy6rvzuc8TWscs=;
	h=From:To:Cc:Subject:Date;
	b=G49gV8feOAwmMiflT9m3W0o3BPbFKHkBroR0BiLra9CKCRKLqyruL3g/faFmr9Vu4
	 KXCZiyS3bKE/eYtWcyXwGyHLUcF5Ms0lr8BnZaV+giTMByfhqCAIq4+yKJ0BtB/UZU
	 moMOHqiYYNnHtD8hKmQmQW09z1+Jbv1pEIhk3FCNsZ19WHYPYvNtKUD5sQ9erbwQsY
	 JQX+1aAKcU45b/pZNnFRHr9jg89CefiwhCrrS1Ah1Yp8oM0RvR20Ymalf238buwFYZ
	 /UVq1jS4xSHMmCNeft+5sCiO8b+BAXeD8JTkwGxB4+BDqYlhNqYcLtzW1FOAtaE6Sr
	 0+HPNZSlTDALw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] spi: dw: use threaded interrupt
Date: Wed,  9 Sep 2026 22:36:47 +0800
Message-ID: <20260909143652.9234-1-jszhang@kernel.org>
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

 drivers/spi/spi-dw-core.c | 86 ++++++++++++++++++++++++++++++++-------
 1 file changed, 72 insertions(+), 14 deletions(-)

-- 
2.53.0

