Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E6C345EBF
	for <linux-spi@vger.kernel.org>; Tue, 11 Aug 2026 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786471259; cv=none; b=VlH5kc+sgFnj+xvmoGgz+nGXOblwXZhoxRtzm6zupx7XROgOqGBV6wcgA9hCKlDMJwrwTEahorhj1L6xNrqr7WKWM8kV4eUZJ1AEHEs9Wq3pQaKaB1yOoCwBFapj5F9pCDl12VxpcnB5pmUY178219nhywZE7GWt80YM+gTRWoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786471259; c=relaxed/simple;
	bh=hgXJai1sxKRkO+38yFbq8qV6yABhRDWGm/0xrms8gaE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=JS4HslgFlqkD76+MFpW6T3KQT8Byyeb3pbUtKaN5VRGEp4O+thFbbMcbo1THY1uPOfdhvIpWOf2aaba50sEUIGVtxUESinhOn40kyQytF1Sd19QXZAEgXdGs64+Pxb36nwxuNpQchOkFzMoNAeuvw0E+SKZmdunMWk1qN32itWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcDjYOVk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcDjYOVk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E331F000E9;
	Tue, 11 Aug 2026 18:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786471258;
	bh=YNf3w9Lx4ZHOpGun0XP2ywnsmZ0IJKo/OfJ+71I5pGc=;
	h=Subject:From:Date:To;
	b=KcDjYOVkEaZjfoGsEZCdy6fpDXh/+FYvk5Qc83QFzEyMUBMvjwoupogyG/9vVeZl6
	 t8mo3apbh/tolmkiIIN3PR4pH2Pn0jp3oBL41z8hdLXvnCgRkT/JOZpAUiCB+oYAKY
	 vl2sX1SoQZemiYb3A41E+pH8xf5EWjP0Hb3GNiBexKqVE4fd1mwuyHH9TdHYUu18pX
	 CBvgr/OEk05FaliXdXu60/Vd0YHrR0b6377Nk0ZVPucgCtEVqCDfq5d37nIEx4D6o8
	 BohXV4HXYxZKOgcnaD1xqIpZoK508TpNhicIYd2tupZ7h6daePth6P9hSujTbEnBwz
	 jIxhfeWWQUcGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5A427380820D;
	Tue, 11 Aug 2026 18:00:15 +0000 (UTC)
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
 <178647121375.1087421.7777586843086447816.git-patchwork-summary@kernel.org>
Date: Tue, 11 Aug 2026 18:00:13 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: meson-spifc: use devm_pm_runtime_set_active_enabled
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1138686
  Lore link: https://lore.kernel.org/r/20260802-spifc-v2-1-46e9d06a3217@gmail.com

Patch: spi: dw: fix wrong RX_SAMPLE_DLY setting after resume
  Submitter: Jisheng Zhang <jszhang@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1139471
  Lore link: https://lore.kernel.org/r/20260803135925.12622-1-jszhang@kernel.org

Patch: spi: hisi-sfc-v3xx: Propagate errors from optional IRQ lookup
  Submitter: Bui Duc Phuc <phucduc.bui@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1142125
  Lore link: https://lore.kernel.org/r/20260807103848.46315-1-phucduc.bui@gmail.com

Patch: [v2] spi: sprd-adi: Fix probe succeeding without registering the controller
  Submitter: Babanpreet Singh <bbnpreetsingh@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1136369
  Lore link: https://lore.kernel.org/r/20260729053543.7-1-bbnpreetsingh@gmail.com


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


