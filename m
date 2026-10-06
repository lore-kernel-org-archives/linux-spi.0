Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E543E00B6
	for <linux-spi@vger.kernel.org>; Tue,  6 Oct 2026 08:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791274816; cv=none; b=BNeHMI7qlOA4eluum+r2Ir1xfKgwfBvNjztbHCGz6YSz8sIV4jYFe3AjRbxURICtKxwuiv88gGkXuQeULBTw/J3AuEcOno0mgSk76MDQBjn6UtNmNWFHKfeu65kDrgi8f3WHGBKPCkXLx9SMRJyVu18McT8rHcHGK7Q6UHKTEkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791274816; c=relaxed/simple;
	bh=JOX6B+Raea/THIB5YfSrDFjpTLENlhQV4smy/LlH07c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=VzlLbPGOafA1zQ6FsZCYZePvUD9fNa9e0U49uNLEdu69k6GWZgS+WDGQzFEiFub79hIR8ZDMbfvEskTfQ3pb06R66ocFVo/hOrO40Qh6DGkCFrFBWtSP+INc9KfXbUezrctksTZ9TDIuBHDWxUu8AhGl6+FX/bcnwB/VhP5BIWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J36ZHRiW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J36ZHRiW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9E11F000FF;
	Tue,  6 Oct 2026 08:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791274812;
	bh=WrxRR6J7Ann8r4ANlLvvq5DVxMx6FsDZ1ZPa/xRuVAc=;
	h=Subject:From:Date:To;
	b=J36ZHRiWXA9Xc/e3vp8rf530XMantOpJIFc+wrES3Y4vMQw7kiz+8EEC4COcHQVwm
	 /W8nfngs6RyeJgK1aHYCsnPjcwcgTMYQKyowc2uC+UZT4gjHbr1Vc2G+p/H1FFQX1f
	 uREdhMV+icVd/UWb3XWamJynfD/qQ4rygqlcLIp6KUJDbvWYMUfMHXyXt6TVrIpBzj
	 44AIZ6R7qJqXuz6BE06fwtqKKiqmzoONtHCEgTrfeGcVVUp4reCDnzry4QeGpH6/wE
	 c6w1h/AhNTyI/PiZv6NW++EWgg+is8Amb2kIMlx7lPfP06zXH0gTc0tNdnWOa4xLl1
	 zCb6nlCUys0iw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B6D9F3927059;
	Tue,  6 Oct 2026 08:20:12 +0000 (UTC)
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
 <179127481136.2073428.5446214660846188739.git-patchwork-summary@kernel.org>
Date: Tue, 06 Oct 2026 08:20:11 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: atmel-quadspi: balance runtime PM and pclk across system sleep
  Submitter: Karl Mehltretter <kmehltretter@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1171750/
  Lore link: https://lore.kernel.org/r/20260923012950.15651-1-kmehltretter@gmail.com

Patch: spi: Fix ACPI SPI resources using relative path
  Submitter: Alban Bedel <alban.bedel@lht.dlh.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1177807/
  Lore link: https://lore.kernel.org/r/20261001153507.2011806-1-alban.bedel@lht.dlh.de

Patch: [1/1] spi: use dmaengine_submit() instead of ->tx_submit()
  Submitter: Frank Li <Frank.Li@oss.nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1178553/
  Lore link: https://lore.kernel.org/r/20261002192616.161440-1-Frank.Li@oss.nxp.com

Series: spi: qcom-geni: Use GPIO to notify master of SPI target activity
  Submitter: Praveen Talari <praveen.talari@oss.qualcomm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1174792/
  Lore link: https://lore.kernel.org/r/20260927-use_gpio_to_notify_master_of_spi_target_activity-v5-0-9b973623080f@oss.qualcomm.com
    Patches: [v5,1/2] spi: dt-bindings: Document ready-gpios property
             [v5,2/2] spi: qcom-geni: Use GPIO to notify master of SPI target activity

Patch: spi: dw: Unconditionally stop DMA on errors
  Submitter: Changhuang Liang <changhuang.liang@starfivetech.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1178906/
  Lore link: https://lore.kernel.org/r/20261003161807.59429-1-changhuang.liang@starfivetech.com

Patch: spi: spi-nxp-fspi: exit stop mode before waiting for DLL lock
  Submitter: Bough Chen <haibo.chen@oss.nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1175204/
  Lore link: https://lore.kernel.org/r/20260928-fspi-fix-v1-1-a0f9288cd5c8@nxp.com

Patch: spi: cadence-qspi: Fix status polling with octal DTR chips
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1177775/
  Lore link: https://lore.kernel.org/r/20261001-winbond-spi-next-cadence-rdsr-fix-v1-1-ec5ff594ba5d@bootlin.com


Total patches: 8

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


