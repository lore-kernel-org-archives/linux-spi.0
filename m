Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E0E2E62A9
	for <linux-spi@vger.kernel.org>; Fri, 10 Apr 2026 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775839252; cv=none; b=ZxZ2ZN6OoG6XQ4b2OXjA+yX5B/7vTez87MtgmmkFnlfNfXZ9Rfn6UhimDaEHQtmoEtOx1EMFRRuv88dzaAWYK8ORnBWTjJjTLPt12C61CyLd4VpD2t/2ajYvzyNQPXD6k9asglcrT4E9hF0fn6+xeH9Xw8J8x2ae1bTYDGh1Q6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775839252; c=relaxed/simple;
	bh=ZLI6JX+qOpQlOk3ax2AhRiL1txA5e61ohulltzwfaCs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=IAFikBUF5HwfUM8WOBRreQfNqYJIzVJVmZ5BwvJkJI4G0z5cuZqOlVjRnpOmGg1HjEtyEn0El9S1yHKdAjmzVcsAmYoHBfpq5vYmZPwczF8C6TMP8WUtlUWlZx6mELACDAFd+AStZuErQRpNync9aQnUMwYuyQQv4kxc+RZuZmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ixh8Vigu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ixh8Vigu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D0EC19421;
	Fri, 10 Apr 2026 16:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775839252;
	bh=ZLI6JX+qOpQlOk3ax2AhRiL1txA5e61ohulltzwfaCs=;
	h=Subject:From:Date:To:From;
	b=Ixh8VigutDFlqya37QZopG17SP4rLyexwe62N5si8WaGB78iHXhjNe1MsYsv1A3DF
	 gVktOTbbS37pwBBNln+P55SOgm4VdaRCGtqQg4FmuXavex3gGX+92fka5sohd6bcUB
	 m12nrzkJ2MTPBS4RQvdCW/OryfaI7kK3JrsjP++b6zmjNBRGBEuzmRMiVD2UPGJjuq
	 Xos0lGj0VqiUX1dIOcwLX1Bv/SbHAzBtJifSThRhN4UcAMXiJbov1+Xi21LfgJTvIO
	 Vg8YJoyBhrnqK/dhz3AyMEPIaKUcS5zWwJujlBZWBCAt9F8GegD0jfqBr/iQJTd8Lx
	 S9Iy2z4UTarzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BC6EF3809A87;
	Fri, 10 Apr 2026 16:40:27 +0000 (UTC)
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
 <177583922635.2556896.12747714683540064241.git-patchwork-summary@kernel.org>
Date: Fri, 10 Apr 2026 16:40:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [V2] spi: mtk-snfi: unregister ECC engine on probe failure and remove() callback
  Submitter: Pei Xiao <xiaopei01@kylinos.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1077980
  Lore link: https://lore.kernel.org/r/20263f885f1a9c9d559f95275298cd6de4b11ed5.1775546401.git.xiaopei01@kylinos.cn

Series: spi: fix controller deregistration (part 2/2)
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1079630
  Lore link: https://lore.kernel.org/r/20260410081757.503099-1-johan@kernel.org
    Patches: [01/26] spi: mt65xx: fix controller deregistration
             [02/26] spi: mtk-nor: fix controller deregistration
             [03/26] spi: mxs: fix controller deregistration
             [04/26] spi: npcm-pspi: fix controller deregistration
             [05/26] spi: omap2-mcspi: fix controller deregistration
             [06/26] spi: pic32: fix controller deregistration
             [07/26] spi: pic32-sqi: fix controller deregistration
             [08/26] spi: pl022: fix controller deregistration
             [09/26] spi: qup: fix controller deregistration
             [10/26] spi: rspi: fix controller deregistration
             [11/26] spi: s3c64xx: fix controller deregistration
             [12/26] spi: sh-hspi: fix controller deregistration
             [13/26] spi: sh-msiof: fix controller deregistration
             [14/26] spi: sifive: fix controller deregistration
             [15/26] spi: slave-mt27xx: fix controller deregistration
             [16/26] spi: sprd: fix controller deregistration
             [17/26] spi: st-ssc4: fix controller deregistration
             [18/26] spi: sun4i: fix controller deregistration
             [19/26] spi: sun6i: fix controller deregistration
             [20/26] spi: syncuacer: fix controller deregistration
             [21/26] spi: tegra114: fix controller deregistration
             [22/26] spi: tegra20-sflash: fix controller deregistration
             [23/26] spi: ti-qspi: fix controller deregistration
             [24/26] spi: uniphier: fix controller deregistration
             [25/26] spi: zynqmp-gqspi: fix controller deregistration
             [26/26] spi: zynq-qspi: fix controller deregistration

Series: spi: rzv2h-rspi: Fix max_speed_hz and clock configuration issues
  Submitter: Prabhakar <prabhakar.csengg@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1079625
  Lore link: https://lore.kernel.org/r/20260410080517.2405700-1-prabhakar.mahadev-lad.rj@bp.renesas.com
    Patches: [1/3] spi: rzv2h-rspi: Fix max_speed_hz advertising prohibited bit rate
             [2/3] spi: rzv2h-rspi: Fix invalid SPR=0/BRDV=0 clock configuration
             [3/3] spi: rzv2h-rspi: Simplify clock rate search function signatures

Patch: spi: tegra210-quad: Fix false positive WARN on interrupt timeout with transfer complete
  Submitter: Breno Leitao <leitao@debian.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1078688
  Lore link: https://lore.kernel.org/r/20260408-tegra_warn-v1-1-669a3bc74d77@debian.org

Patch: [v2] spi: fsl: fix controller deregistration
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1079583
  Lore link: https://lore.kernel.org/r/20260410064749.496888-1-johan@kernel.org

Patch: spi: s3c64xx: fix NULL-deref on driver unbind
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1079675
  Lore link: https://lore.kernel.org/r/20260410094925.518343-1-johan@kernel.org


Total patches: 33

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


