Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08683C4B68
	for <linux-spi@vger.kernel.org>; Tue, 30 Jun 2026 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851455; cv=none; b=jqsNMLKkT3rlvp/z8fCYJUjTwEBbKDIArAHcK5Yr65xsx6xtiY6P2ySD3MkktJ0o7VDhzLErFtuaCsl27QVhbsP6nVlHyKjw/XV52YN86gIokycoqfqimGvyAhIq69oU0E7S4WPyAcE4AD0A9kQVsM1Yf1DhXBc1KNKojFMycms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851455; c=relaxed/simple;
	bh=sddfoLLoeoj4J8UjFBoj8McWDXn4wxQB62tdHsZIigg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=r88CltJKpbH+XVd+qcmjS0M67WDfwp8M3VWiOt5KE40dh/EMrjbjmqI5AS+ex4pvPQzzPVutt/rJqLVDM47tlKoWO4XmCIbfA2SxsoZjNSw76xBZ2nEFxWtFmxyg0cXFmcB4rtXHQWeqFn082ANjW7WfQnXkv74LEQ6RQPdbjUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E45aIy8I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E45aIy8I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801B81F000E9;
	Tue, 30 Jun 2026 20:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782851454;
	bh=CPDryq0AdR0cXO+1BIrVDbRZz6coXspU2ewJftlO7T8=;
	h=Subject:From:Date:To;
	b=E45aIy8I76lv88oHd3ythphPV/3PN459euxIerakkAgos7JXzkFEChZJlisFWO4q7
	 lwgS2d0ChsSPH/K37/aMr7vMKPyONW87eYqTjh/ooeHXRk/yIn+9GPf079cykRywgd
	 8ajyVucbQCZJpjdYY4gaLzlYwmfm1XXjwA0+RXjmcgHsSxsH6joUU1Shi/aTEpLMwt
	 OIvlPoZPXdGd8Pfm7JinnfWyGXEue57Le+foT2fV+DlTue2wI+Wjuhck7GSHi4rOML
	 Sqme3vpSftRJj2c9DuGW2yHyUr7pXru4lzAY0MtI+hq/O64z4M+gZ2cvYOHRg03gjF
	 Phr75NtVt7N1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9645E393A951;
	Tue, 30 Jun 2026 20:30:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <178285143821.267316.15797304086501439766.git-patchwork-summary@kernel.org>
Date: Tue, 30 Jun 2026 20:30:38 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: dw: use threaded interrupt
  Submitter: Jisheng Zhang <jszhang@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1111452
  Lore link: https://lore.kernel.org/r/20260615044039.9750-1-jszhang@kernel.org
    Patches: [1/5] spi: dw: fix first spi transfer with dma always fallback to PIO
             [2/5] spi: dw: use the correct error msg if request_irq() fails

Patch: [v1] spi: npcm-fiu: support dual and quad UMA writes
  Submitter: Tomer Maimon <tmaimon77@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1108327
  Lore link: https://lore.kernel.org/r/20260609071458.2692482-1-tmaimon77@gmail.com

Series: [1/4] spi: atcspi200: return error from failed controller suspend
  Submitter: Jiawen Liu <1298662399@qq.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1114145
  Lore link: https://lore.kernel.org/r/tencent_306FA547FD68D10EE4B2AE9C132060F12F06@qq.com
    Patches: [1/4] spi: atcspi200: return error from failed controller suspend
             [2/4] spi: bcmbca-hsspi: return error from failed controller suspend
             [3/4] spi: fsl-dspi: clean up after failed suspend and resume
             [4/4] spi: nxp-fspi: disable runtime PM on probe failures

Series: [1/3] spi: bcm63xx: return error from failed controller suspend
  Submitter: Jiawen Liu <1298662399@qq.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1113573
  Lore link: https://lore.kernel.org/r/tencent_0BD7D4091B90EC17A8B2BA5EBA8803725905@qq.com
    Patches: [1/3] spi: bcm63xx: return error from failed controller suspend
             [2/3] spi: bcm63xx-hsspi: return error from failed controller suspend
             [3/3] spi: bcm-qspi: return error from failed controller suspend

Patch: [v3] spi: dt-bindings: octeon: Convert to DT schema
  Submitter: Ninad Naik <ninadnaik07@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1113606
  Lore link: https://lore.kernel.org/r/20260618180149.475658-1-ninadnaik07@gmail.com

Patch: dt-bindings: spi: st,stm32-qspi: Add power-domains property
  Submitter: Patrice CHOTARD <patrice.chotard@foss.st.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1113254
  Lore link: https://lore.kernel.org/r/20260618-add_power_domain_for_qpsi-v1-1-4d7e57bcfb9a@foss.st.com

Patch: spi: qpic-snand: free OOB buffer with ECC context
  Submitter: Pengpeng Hou <pengpeng@iscas.ac.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1112409
  Lore link: https://lore.kernel.org/r/20260616151129.76060-1-pengpeng@iscas.ac.cn


Total patches: 13

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


