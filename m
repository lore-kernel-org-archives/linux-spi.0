Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620611;
	b=bxbTTv6SSyMMfs4xvoY31Y6pzeRRsyx2mTJpntjzfilNSFzAQTrv7o64sFaIrRzSmnH1
	 kRtOkuOZ6sbqxG9tBIl+RK6d1uR64rN+Ial9Ge5ZFFy6XLTNtNINRgmgUglrzg7w6lJUI
	 1wKpaa0YEavPT26MOmV1nk2bd9LnK3HLEM1wYBsi3CBQu9agsBfcEvf2EbeUxXEtP+j9g
	 Jo+SQliGlbF2GsSjsr+vmxPk9wp0cmzJ9FDqM8qZSAFpuoKxYs4HwR0SjYredrCMdO/+s
	 2IHgEEja0SxsYk0h+gIrzvDAIoi9zZSWBrQ2htObA0A5mU+zLk4S4BqoYCFS3frjj0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620611;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=CHKeGPUaRDwepfg9X5UsuzvW/dz90ugXevptJJ1o4Jk=;
	b=G1uEyHJl7gtW1SB3wa/yEuTzOKfxr6ItbGwoVrwgBvbUiv4eoKuYu29Dzn3ca8XXPVXW
	 Q2n2k04xBmCOphu4mEnf+ZZJqvWTFCGZWp3Pju/pEeaMu4ATmSgiXb3+Ac3At0Sy7VBP4
	 LQc2roFV9Moc3SliQgo31wsY9tkcn4avpDhxee/fjh8m+aBYVvdK8aKiIOkZV9YcUVLRL
	 3QCJu4LnKvUzsWqN04kSp/gRSJUWZ6AmLWknj9BHAEty0bb1I5kngwKE36BTFxdna35Bg
	 KwpOMSdmXD8XW9Pe1dE9cdLEJTvGOz9rk2zZC3Hnx+IDmCTmFMi4hqIpzfekKTQ4uKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cw6iuiTm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDE1606A32D
	for <linux-spi@vger.kernel.org>; Wed, 25 Nov 2026 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cw6iuiTm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FCA1F000C6;
	Wed, 25 Nov 2026 15:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795620611;
	bh=CHKeGPUaRDwepfg9X5UsuzvW/dz90ugXevptJJ1o4Jk=;
	h=Subject:From:Date:To;
	b=cw6iuiTmZ8r202QsW4SglEeM6f8tmocZsYBB1+mXSOFxOFPTUXCVo4sXMV89YYbPH
	 e/lV63SRS4zcUIguOjSWRmAICUO9e8GreIcj8DEpeAEE1lhuTaBdYIYE4UUufCs5zf
	 T5bushNCl4ZHJKfJd2LUJ5VizMBmuSG4wTH3kiQDQoHl5uVm/kXsfZB75KnLekAvEc
	 qIMCN5OrxQmLQbhYFGp+B3K9BXYisFAG4vNq/B/W4tdjGCykI5scm0llRDzVoh9ciE
	 B1Mb86PfmlSPanYiIZqQ6fqC1KKLthzL8ERkrRrNAHrF7axXFdEt3wGw53M65p6o44
	 37DA1RcrYtcag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id DF2BD3808209;
	Wed, 25 Nov 2026 15:30:10 +0000 (UTC)
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
 <179562060973.619539.17798101309933466930.git-patchwork-summary@kernel.org>
Date: Wed, 25 Nov 2026 15:30:09 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: Implement a atomic transfer as a last resort
  Submitter: Heiko Stübner <heiko@sntech.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1216224/
  Lore link: https://lore.kernel.org/r/20261119135808.2377849-1-heiko@sntech.de
    Patches: [v4,1/6] spi: Allow spi_toggle_csgpiod() to get called from atomic contexts
             [v4,2/6] spi: Allow spi_delay_exec() to be used from atomic contexts
             [v4,3/6] spi: Export spi_set_cs() function
             [v4,4/6] spi: Add infrastructure for atomic sync transfers
             [v4,5/6] spi: rockchip: Fix runtime resume error handling
             [v4,6/6] spi: rockchip: Add an atomic transfer function

Series: mtd/spi-mem: Enable DQS control
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1220970/
  Lore link: https://lore.kernel.org/r/20261124-winbond-nand-next-phy-tuning-v5-0-261e0e712857@bootlin.com
    Patches: [v5,1/6] spi: spi-mem: Rename the DQS setter and pin field
             [v5,2/6] spi: spi-mem: Clarify the conditions upon which DQS is usable
             [v5,3/6] dt-bindings: spi: Document the spi-dqs-not-wired property
             [v5,4/6] spi: spi-mem: Take the DQS wiring into account
             [v5,5/6] spi: spi-mem: Take the controller DQS support into account
             [v5,6/6] spi: cadence-quadspi: Advertise DQS support

Patch: spi: synquacer: drop redundant IRQ zero checks
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1217543/
  Lore link: https://lore.kernel.org/r/20261121-synquacer-v1-1-9e14702ce84b@gmail.com

Patch: spi: cadence-quadspi: Bypass STIG for Versal and Versal Gen 2 OSPI data
  Submitter: Srikanth Boyapally <srikanth.boyapally@amd.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1217112/
  Lore link: https://lore.kernel.org/r/20261120-ospi_stig-v1-1-54f4d5f9f7b9@amd.com


Total patches: 14

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


