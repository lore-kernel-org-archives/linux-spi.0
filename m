Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F673B6BF5
	for <linux-spi@vger.kernel.org>; Mon, 10 Aug 2026 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402277; cv=none; b=Qel8A4AvELevZEVPLAnWNbtviDmzHTReaP8BaeLAMBhK0Lr2XpBohGIkdsXUoqVysgG3o7p5FH2d27b8sLG3LwlF9l/WfvYm1hJmRa4eL/eI/A4Rhp4Z37Yj7UEfvjrgI96lLkWXmdxg8NjAxCD7ytRu/TpC/UWKuznuW6dpzM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402277; c=relaxed/simple;
	bh=Rp748ojy2pLrbZ7rP/0myNJ/OzBRH3oT8dvVskqEdzY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=fttzeVYgWp8qtqCfP9p8uw4bXbTtjiKtEbwnm+Sn32NZiyy5mjQL8L51sqm6M0mqNMOYzI7SWbaQtK4WaHUy8DlwUJwn++WPKzEE2TzxFPuThZvspNY8EkcGVaFieM++9y/bUG0ENsAgTSc/cdB0SodMbb4L0pAsXziKXQoUlY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sloi+Qil; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sloi+Qil"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D889E1F000E9;
	Mon, 10 Aug 2026 22:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786402275;
	bh=Ii/24YxjGqCR5kqC84yrqC15/N5JOrLgfEGIVY181TM=;
	h=Subject:From:Date:To;
	b=Sloi+QilAYL2XC5GGVbalT/de1VGAK874xTtQTlpSVyyfPswrXw37m0YEv7MsYcQs
	 jTla168Hj9JAh/ivx3c1TKJZQtr3zLgfLyieeXANmL+juGyxYnkIP+I2efodN77sSi
	 Zz7cXPXxMCBM6gYgc4i2U0RzgqbUD3Z4erLt68Rf2MRvM/WG81SUfQODQVfFXMe2cL
	 BAzPlZ1/uwRl6Mg+janu37PUWCkXcRvvQjYu1/1pLXMI8AEiNB5QbHneK2cXS8fWER
	 SYigHGZIT9NuTHMIziN2HzONKMD38sB81mPxZoPspBEHSE0U5HFsb7JH/HnLe+j33Z
	 Bzt/aPYRT8vsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 965633926265;
	Mon, 10 Aug 2026 22:50:33 +0000 (UTC)
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
 <178640223209.241658.1825778024445785785.git-patchwork-summary@kernel.org>
Date: Mon, 10 Aug 2026 22:50:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: mtd/spi-mem: Enable DQS support
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1143508
  Lore link: https://lore.kernel.org/r/20260810-winbond-nand-next-phy-tuning-v3-0-a97c3a61e675@bootlin.com
    Patches: [v3,1/3] spi: spi-mem: Flag DQS capability


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


