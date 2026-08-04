Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1900C47127A
	for <linux-spi@vger.kernel.org>; Tue,  4 Aug 2026 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877255; cv=none; b=dGVo/ITMCCc/cPa63DY60mElzlrwiv1QKHPVMZSi6nwIk9TLDhCRaTBSDn8CCuuid4iKIOebQ2193OGw5I1muxnWqasOEy+AQYV5BA3Lf7QREHu0bSuLPtCbSJiEVqUrLOgYMrv6dr2qxyjL958ZThbICjZP7RLFzEbFYlH2lwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877255; c=relaxed/simple;
	bh=D4jggd6eoYf7zML+bArsybfhRjpwxjS/a1XUjRLmLlk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=H5Tqk3xpv047u6O1vJ9CWXZ5IBTtsQ9JHSuC4MvHAL5YoeKTv6PIBzI9aGKJPCuWEoFBFKc8rn3h2sN3f5i1Vh/CrpfXe5r7DCFCb7TKbe5PpZT55ZgwIPsi5N7XaMYusu0zy1mfdEc8S49mf8xlt4BX/34OUAOvDLPwonz8Sfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmF3PqrU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmF3PqrU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3D31F000E9;
	Tue,  4 Aug 2026 21:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785877253;
	bh=XPn9MWc/z8NZDgkNBpC1CXIp5h8PbfjbuFWaEAuCf0E=;
	h=Subject:From:Date:To;
	b=CmF3PqrUIyD8j0NN9FngSHpvi23ixOztXfDNN7ma3+yHq2UbY5Vfc34fpZ8J/u4Hu
	 PJOyg7AzBTmaBNR8STYR/xsrBFjXRd0+1atBjo/26A0G5aNGJlrBZ8XLMdzDB7Goft
	 loaySej5Pffvb5IvqjxYnNP8gyn/TdjPj1VIPy0Phd6JpNIHKJ+duC4XfrT+ENfP/+
	 gndcs9AdKnKiO0yxgRk2g75QNlwf8VjSwDhY1r6bgf93ZuUgDEv6tcLbt0Ki3H1DAu
	 B+rUGmS3pcA8sLeNrnW6ARBgeRwGy6pkPYxMyRE9ty27DPSVeayvJRyiGo59Jx7k47
	 YVO96BkMN3TWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AC53926645;
	Tue,  4 Aug 2026 21:00:15 +0000 (UTC)
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
 <178587721403.3783867.14080239088476685332.git-patchwork-summary@kernel.org>
Date: Tue, 04 Aug 2026 21:00:14 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: cadence-xspi: remove 64BIT dependency
  Submitter: Jisheng Zhang <jszhang@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1139476
  Lore link: https://lore.kernel.org/r/20260803140728.12747-1-jszhang@kernel.org
    Patches: [1/4] spi: cadence-xspi: group marvell support code together
             [2/4] spi: cadence-xspi: put marvell support code under CONFIG_64BIT
             [3/4] spi: cadence-xspi: only use readsq/writesq under 64BIT
             [4/4] spi: cadence-xspi: remove 64BIT Kconfig dependency

Series: Add support for StarFive JHB100 SFC
  Submitter: Changhuang Liang <changhuang.liang@starfivetech.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1139372
  Lore link: https://lore.kernel.org/r/20260803124044.156998-1-changhuang.liang@starfivetech.com
    Patches: [v2,01/11] spi: dw: Introduce spi_frf and STD_SPI
             [v2,02/11] spi: dw: update SPI_CTRLR0 register
             [v2,03/11] spi: dw: add check for support of enhanced spi
             [v2,04/11] spi: dw: adjust size of mem_op
             [v2,05/11] spi: dw: update NDF while using enhanced spi mode
             [v2,06/11] spi: dw: Introduce enhanced single/dual/quad/octal spi
             [v2,07/11] spi: dw: send cmd and addr to start the spi transfer
             [v2,08/11] spi: dw: use irq handler for enhanced spi
             [v2,09/11] spi: dw: detect enhanced spi mode
             [v2,10/11] spi: dt-bindings: snps,dw-apb-ssi: Add starfive,jhb100-sfc
             [v2,11/11] spi: dw: Add support for StarFive JHB100 SoC SFC


Total patches: 15

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


