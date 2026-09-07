Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04663542CF
	for <linux-spi@vger.kernel.org>; Mon,  7 Sep 2026 23:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788823270; cv=none; b=VfFZW6EfveSQ+w//V31nHcZxcct6aLYN7do7mOUNP5muKTyYIif1GqbdrqHiRzY9a+Pw9VIEei8Xc0VWDllB81umYL8sS9cmwXMpa9sygvWChb693Nt1yB+kiil6ZlS9LDB3t/ZLeo4YH/EeOQsG//uxl6h3H72XvXzPmFXob4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788823270; c=relaxed/simple;
	bh=Z8zMHZKhh2T38sM2U3or2sH+WUS8i7QBQ/3F3U1Q98A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=BUB06Far8AzXdxslQ1oaIKkaKZMBCNvSvDJvX/Nyflb3x6fH/O2vQjPgJBVI9RP5V/Gzk/vhIfLdWdivUPuHRBjj1uG+pNJGeBsRKv4Xl4HG22PYR4vUJ1XckQeXvzGCEdJOIGoxOqbhLKlOVtD6Q+Nv8ydw8gMFyHwcJvAPYec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvbouwRf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvbouwRf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECA91F00A3A;
	Mon,  7 Sep 2026 23:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788823268;
	bh=hTOpnGKyufVRgjBPqvY6Ik0HO3T2MddsYyN6RSoWxow=;
	h=Subject:From:Date:To;
	b=HvbouwRf74nC2I3OEPBmPqK8+SKsaIHvXVKpSNVuJzg3DHTkEBHixCr7WvR6ywFLr
	 aOajH1q8iiKWqExHGqjMgQsS+O8AIr2tqKXGZT8ht1PQooaxAsnRPnRQ40bTCnCFu4
	 cN+OkbMZ0TcbWC4h9TVGNhrHGtotPK54qu4EjM4QjVV8/yhy4BOOqyIr0QuC6B44Ci
	 y+8WthppeqZxzs2fsbd7wO703jSjI63BGUwpTAjTogvYji1ZW+gyeYgqyX0p6OcHII
	 owcArZtJGUPToMHc8qCT0FurpJn93bZi70PiDdTw5po6rs59D3yKPXxAs+dCFXJylG
	 baMWnsauaeTHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D345739E8A5A;
	Mon,  7 Sep 2026 23:20:08 +0000 (UTC)
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
 <178882320738.3203880.18098806876362251898.git-patchwork-summary@kernel.org>
Date: Mon, 07 Sep 2026 23:20:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: ingenic: release tx DMA channel when rx request fails
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1157301/
  Lore link: https://lore.kernel.org/r/20260904-ingenic-v1-1-06218181a4f8@gmail.com

Series: spi: add support for Amlogic A9
  Submitter: Xianwei Zhao <xianwei.zhao@amlogic.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1138011/
  Lore link: https://lore.kernel.org/r/20260731-a9-spisg-v3-0-a15da3f70029@amlogic.com
    Patches: [v3,1/4] spi: dt-bindings: amlogic: spisg: Document A9-specific properties
             [v3,2/4] spi: amlogic: spisg: Fix transfer size limit and timeout handling
             [v3,3/4] spi: amlogic: spisg: Fix the incorrect keep_ss of the last descriptor
             [v3,4/4] spi: amlogic: spisg: Add support for A9 controller features

Series: spi: ma35d1-qspi: Flag the DTR capability correctly
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1158218/
  Lore link: https://lore.kernel.org/r/20260904-perso-ma35d1-master-v1-0-b6936e8c6fa1@bootlin.com
    Patches: [1/2] spi: spi-mem: Enable DTR transfers using the standard API
             [2/2] spi: ma35d1-qspi: Allow DTR operations with the regular SPI API

Patch: spi: ma35d1-qspi: assert reset on probe error paths
  Submitter: 李佑鸿 <dayou5941@163.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1154983/
  Lore link: https://lore.kernel.org/r/20260901025129.359960-1-dayou5941@163.com

Patch: spi: mtk-nor: fix runtime PM usage count leak in probe error path
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1158197/
  Lore link: https://lore.kernel.org/r/20260904-mtk-nor-v1-1-cefdca098f83@gmail.com

Patch: spi: fix typos in comments
  Submitter: Hemanth Selam <hemanth.selam@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1157891/
  Lore link: https://lore.kernel.org/r/20260904110420.13707-1-hemanth.selam@gmail.com

Series: spi: qcom-geni: Add shutdown and panic notifier support
  Submitter: Praveen Talari <praveen.talari@oss.qualcomm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1147858/
  Lore link: https://lore.kernel.org/r/20260818-add-shutdown-and-panic-notifier-for-spi-v3-0-8b62c4bc2d21@oss.qualcomm.com
    Patches: [v3,1/2] spi: qcom-geni: Add shutdown callback to quiesce hardware on reboot
             [v3,2/2] spi: qcom-geni: Add panic notifier to cancel and reset DMA during panic


Total patches: 12

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


