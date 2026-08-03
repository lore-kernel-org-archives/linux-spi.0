Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F389311968;
	Mon,  3 Aug 2026 14:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767183; cv=none; b=oDmo2PCtAKphiF74LygHtUIQTpsmbu2QOx6krYqawdeKF8xOyMd5QeOVDxVT8qtfBTNwOqH6o/1dIoFHJRfo3u4As02tFsv05315xdO6wGnVfFcT2zKsow1BbPsfJybmeMFTVylngM3K/oXXnOEVi/zPkQ0e7EIgMmN6g8gCjvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767183; c=relaxed/simple;
	bh=ViE0WCrvDrbj8TZ2wRMnZQBlQSc2RV5gUdE3PIlxb1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p9UjRAcUZ60dIwRCUvrOCX/ql9b86UuzLqv7UwcvksxxbKyJUzPbQIFqFdGZUReojWIunCOX8rlRmRSb8k4qshfPecKuHGIwsbxYFb56NcZmKUvboezhMdOg0X4qM3kcBSy6TeiZhEduKJmNwdBkJXHrI2L+7VS+uOUYsrl8hNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYaArs7U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYaArs7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C3F1F000E9;
	Mon,  3 Aug 2026 14:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785767182;
	bh=hmDgF69SaUHW2W0lHwvZS1qx7CXiyTl7fQrk3CrDeT8=;
	h=From:To:Cc:Subject:Date;
	b=LYaArs7UucejC5dqrco6ufhZWLy+wWwiTyghI3TenMG1Da+m2v+oyJk1ctIovLLaJ
	 M8TTVYnfqFc9o9Rjoa5ZOHX0C9vpHQYHz301KuzL5fAimDOG4RjepQ2J+H0KsN6Ai0
	 7fev6NL1OzLx/TW5MxBgWRwuCyVJg/PMRoWadAw44wCrZngmvwFi4qCX9I8FfNy1gR
	 ihqsXy++APgkJNfmw4PYy1McGgUJfOKFIGJRCjOpLLgD/PxihDrp581r8djXmggVOs
	 Z9ZFpqH2vOW3xazw7O7HrgZbw/EHCRy1viVl8BhA5MEtHIWpk+LnLatdfUVU13OtGv
	 sK5EwHWGxDA9A==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] spi: dw: use threaded interrupt
Date: Mon,  3 Aug 2026 22:06:46 +0800
Message-ID: <20260803140649.12718-1-jszhang@kernel.org>
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

patch1 and patch2 are small clean ups
patch3 does the conversion and optimization.

Here are the performance numbers:

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


Since v1:
  - rebase against latest version
  - drop two patches which have been merged
  - correct some performance numbers
  - don't move request irq code block so no changes for err handling code path
  - move spi_finalize_current_transfer to the end of threaded irq fn
  - don't rely on irq status in threaded fn, but try rx and tx as much
    as possible in the loop

Jisheng Zhang (3):
  spi: dw: use DW_SPI_ISR directly
  spi: dw: use DW_SPI_INT_MASK instead of hardcoded 0xff
  spi: dw: use threaded interrupt and optimize the threaded ISR

 drivers/spi/spi-dw-core.c | 96 ++++++++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 36 deletions(-)

-- 
2.53.0

