Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794915059;
	b=KCVsep2qcVwEQC6S0B7McVj02CTbvpUfCGXf5cJMMBkTLklnXs1JNGgScwcw7dwx0/1i
	 FjCvhNjcjtqgAeNUZ/IgQkULkFRAn3niJOBzbzDY92VQHDYPblPRRbSDy07nb22bJJr91
	 jtr0Rhxxb0yhumeWvA+tmohZA7PB0d0juQ+gTn6uUdcNQR6kIhO95fhOQhEVaCHc3hkRI
	 1xTLf127LBJB3edSHvNSSn4kE4p0xlQ6k+tuZk5h3+S2vdyq6+Rk3peFkrSy5UCrrrDXv
	 0Ytiy2AVp3vmsDotQ9KTWHOK/SRY28JaRREL91l9IULoTRdi9DJNzCPdCj3V6hmruXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794915059;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=UjeFj/MyPUNWDbVwwEJsipn3uRR7/DYQsVAq3EMntcY=;
	b=sASF08y3XPgXdThXiT5BWwqSx/w1ZRpN17vrlzeOu00KeVrqiCTrcn84ZE8jBdAaZYsM
	 1jLIZrajzkSGsNDnNzMUXLBAjqXeIqvVjvE3F0QlIXt5FJz0G/Xbs/s+UtysVBmDm6UIz
	 fREQ6tKDMtNWUnNF5ytDpvnONeTNyrxUwxAMHzby8Gge0fY922scvGgLInZdcAE+ckBCb
	 G4YjCOPr+555rCUuyzxtXXGquaeF/V19iR5lMusau6Os/F6V6FcWxJToRFL9cuq5rWf5X
	 A0Yyj+AqoQbJt2yFkX88SGN+kolM6yLUgf1qpirpMEv0yhCl37aYaoh8g/E4WOxPDFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=joxxqiwk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538A7606A31C
	for <linux-spi@vger.kernel.org>; Tue, 17 Nov 2026 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=joxxqiwk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA391F000C4;
	Tue, 17 Nov 2026 11:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794915058;
	bh=UjeFj/MyPUNWDbVwwEJsipn3uRR7/DYQsVAq3EMntcY=;
	h=Subject:From:Date:To;
	b=joxxqiwk3eLKJe8ygioVr4BUpoCwBqx5jue6IWLqLvlHeszy8vbboC+LuxFoIv3Ic
	 eVrkT96Dn3TuO/D/FgTEL+gXTtQbglCuvuUf6JV/imqjwq8rHAN7iYpFBSlPwrjZbT
	 tJX6WT48ZtQNeLCu3BZib424B3XgVVYkScE2bG2bML/ft8TYzv4c8j9DUYk3Ku6QtN
	 roRPdblL4fdbSrRiLvBdwCh/tqTRC+VsQu98Scz8RTT7+aXJQYfraOgZIK+4AfVunC
	 kp6RO8a61cAZ8ofWDiJnn39csjFEBO9wRgETwJasSyySVQnz0ozuYGuymZKGHZ4LCZ
	 WDWx/Ylqnj+fw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B683E392665D;
	Tue, 17 Nov 2026 11:30:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179491505719.519637.14106667038445672803.git-patchwork-summary@kernel.org>
Date: Tue, 17 Nov 2026 11:30:57 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: remove redundant pm_runtime_dont_use_autosuspend() calls
  Submitter: Joshua Crofts <crofts@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1205334/
  Lore link: https://lore.kernel.org/r/20261108-spi-dont-use-autosuspend-v1-0-3587b0183cbe@kernel.org
    Patches: [01/11] spi: axiado: remove redundant pm_runtime_dont_use_autosuspend() calls
             [02/11] spi: cadence-quadspi: remove redundant pm_runtime_dont_use_autosuspend() calls
             [03/11] spi: cadence: remove redundant pm_runtime_dont_use_autosuspend() calls
             [04/11] spi: stm32: remove redundant pm_runtime_dont_use_autosuspend() calls
             [05/11] spi: stm32-qspi: remove redundant pm_runtime_dont_use_autosuspend() calls
             [06/11] spi: zynqmp-gqspi: remove redundant pm_runtime_dont_use_autosuspend() calls
             [07/11] spi: mtk-nor: remove redundant pm_runtime_dont_use_autosuspend() calls
             [08/11] spi: orion: remove redundant pm_runtime_dont_use_autosuspend() calls
             [09/11] spi: rockchip-sfc: remove redundant pm_runtime_dont_use_autosuspend() calls
             [10/11] spi: rtk-nor: remove redundant pm_runtime_dont_use_autosuspend() calls
             [11/11] spi: tegra210-quad: remove redundant pm_runtime_dont_use_autosuspend() calls

Patch: [1/1] spi: nxp-xspi: use dmaengine_get_copy_align() API
  Submitter: Frank Li <Frank.Li@oss.nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1208719/
  Lore link: https://lore.kernel.org/r/20261111202741.3866239-1-Frank.Li@oss.nxp.com

Patch: [v2] spi: atmel: use the maximum divider for an unspecified speed
  Submitter:  <shao.mingyin@zte.com.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1207383/
  Lore link: https://lore.kernel.org/r/20261110225742093XH08EkNNnrDUM6Azn-oCM@zte.com.cn

Series: spi: fix division by zero with a zero transfer speed
  Submitter:  <shao.mingyin@zte.com.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1207416/
  Lore link: https://lore.kernel.org/r/20261110233450305Smji446Uhvoxa7r8SHEgl@zte.com.cn
    Patches: [v2,1/5] spi: sifive: clamp the clock divider to the register range
             [v2,2/5] spi: bcm63xx-hsspi: fix division by zero for devices without a max speed
             [v2,3/5] spi: bcmbca-hsspi: fix division by zero for devices without a max speed
             [v2,4/5] spi: apple: fix division by zero in clock divisor calculation
             [v2,5/5] spi: atmel: use the maximum divider for an unspecified speed

Patch: [v2] spi: intel: only check locked opmenu for SW sequencer operations
  Submitter: Rosen Penev <rosenp@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1205474/
  Lore link: https://lore.kernel.org/r/20261108203728.25735-1-rosenp@gmail.com

Series: spi: Add support for panic mem writes
  Submitter: Paul Cercueil <paul.cercueil@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1187224/
  Lore link: https://lore.kernel.org/r/20261016102917.171095-1-paul.cercueil@bootlin.com
    Patches: [v4,1/7] spi: spi-mem: Add support for panic mem writes

Series: spi: ti-qspi: three cleanups
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1201843/
  Lore link: https://lore.kernel.org/r/20261104-ti-qspi-v1-0-c286943c22c3@gmail.com
    Patches: [1/3] spi: ti-qspi: Remove unbalanced runtime PM put on removal
             [2/3] spi: ti-qspi: Abort probe when clock lookup fails
             [3/3] spi: ti-qspi: Correct runtime PM error message

Series: spi: loongson: Fixes, cleanup and IRQ support
  Submitter: Binbin Zhou <zhoubinbin@loongson.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1210178/
  Lore link: https://lore.kernel.org/r/cover.1794538736.git.zhoubinbin@loongson.cn
    Patches: [v2,1/7] spi: loongson: Fix incorrect SPI mode caching logic
             [v2,2/7] spi: loongson: Drop redundant CS deassert in setup()
             [v2,3/7] spi: loongson: Make suspend/resume registers PM-specific
             [v2,4/7] spi: loongson: Fix clock rate retrieval on ACPI platforms
             [v2,5/7] spi: loongson: Fix clock divider calculation with explicit table
             [v2,6/7] spi: loongson: Use bitfield helpers for register access
             [v2,7/7] spi: loongson: Add interrupt mode support

Series: spi: spi-mux, core, ti-qspi: error handling, delay fixes, KUnit tests, and lock context annotations
  Submitter: Joseph CT Chan <jctchan@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1199263/
  Lore link: https://lore.kernel.org/r/20261102163023.2574632-1-jctchan@gmail.com
    Patches: [01/14] spi: unoptimize message when queuing it fails

Series: spi: unoptimize message when queuing it fails
  Submitter: Joseph CT Chan <jctchan@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1210089/
  Lore link: https://lore.kernel.org/r/20261113020352.1741295-1-jctchan@gmail.com
    Patches: [v3,1/2] spi: unoptimize message when queuing it fails
             [v3,2/2] spi: add KUnit tests for message optimize state on queue errors

Patch: [v2] spi: sifive: clamp the clock divider to the register range
  Submitter:  <shao.mingyin@zte.com.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1207384/
  Lore link: https://lore.kernel.org/r/20261110225741763HzyrdGiR7ZOAU1NiFmCCZ@zte.com.cn

Patch: spi: mt65xx: Remove the CPU latency QoS request when probe fails
  Submitter: Rui Cao <i@udp0.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1204827/
  Lore link: https://lore.kernel.org/r/20261107-mt65xx-qos-fix-v1-1-9d9c16a584e4@udp0.com

Patch: spi: dw: configure CPOL/CPHA for each message before sending
  Submitter: Jisheng Zhang <jszhang@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1204785/
  Lore link: https://lore.kernel.org/r/20261107070718.17395-1-jszhang@kernel.org

Series: spi: cadence-xspi: add DMA support
  Submitter: Jisheng Zhang <jszhang@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1204791/
  Lore link: https://lore.kernel.org/r/20261107072044.17574-1-jszhang@kernel.org
    Patches: [1/3] spi: dt-bindings: cdns,xspi: Add DMA properties
             [2/3] spi: cadence-xspi: Support dmaengine for sdma io copy
             [3/3] spi: cadence-xspi: Use writel_relaxed() for cmd regs

Patch: [v2] spi: sunplus-sp7021: fix clock prepare leak in system sleep suspend
  Submitter: zhaofeng2 <zhaofeng2@cmss.chinamobile.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1207819/
  Lore link: https://lore.kernel.org/r/20261111024235.1542-1-zhaofeng2@cmss.chinamobile.com

Patch: spi: bcm2835: Add missing kernel-doc Return sections
  Submitter: Tomasz Unger <tomasz.unger@yahoo.pl>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1207653/
  Lore link: https://lore.kernel.org/r/20261110-spi-bcm2835-kdoc-return-v1-1-dffdfcc36233@yahoo.pl

Patch: spi: imx: Avoid PIO replay after a completed DMA package
  Submitter: Baek Kyu, Kim <pocj8ur4in@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1197630/
  Lore link: https://lore.kernel.org/r/20261031060344.94687-1-pocj8ur4in@gmail.com

Patch: spi: sunplus-sp7021: Fix target transfer completion
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1211506/
  Lore link: https://lore.kernel.org/r/20261115-sunplus-sp7021-v1-1-43d06657fc90@gmail.com


Total patches: 43

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


