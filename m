Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D7D33F8BC
	for <linux-spi@vger.kernel.org>; Mon,  9 Mar 2026 20:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773089807; cv=none; b=NXMbkHYJjDLSCZMRieNY6KB0MBzgC6MhW0T2ETPKC4jRW+148qvwh/T9/X2Hf/Mt29dRw0GWkl6egmPqDhi7zC0sXp4GcLJUiU41Ey2veOc1EksBJv0rMZc5mYoHyNtTbXZcocZiHvM/vfKl10/cLh8YPPdnGts7Y1b3Apab96I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773089807; c=relaxed/simple;
	bh=lzLaCSn0mWx5XTUN0MUmqq/XQnOWjhp4Gbb4I9ZMJuA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=uSS5ZNRRZqPngnZlaEEySzbkGXGlZdDPQAEsR2EjTRkV6l62IEcKL6YTWPKMYGc48nZVtkjloeGF2uWt+eIC+9nsvHK9lN9aRmYfjCztcCBlBzjXSl8nmf43h4FTmKE15/NHY+7TtcY+zsJklNz1XlAi2IVkYS/Jf7+9qWK1XdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUwJ/F95; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUwJ/F95"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8C0C4CEF7;
	Mon,  9 Mar 2026 20:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773089806;
	bh=lzLaCSn0mWx5XTUN0MUmqq/XQnOWjhp4Gbb4I9ZMJuA=;
	h=Subject:From:Date:To:From;
	b=jUwJ/F95Gf0ByoEQZjunKjJEwybRfBI05UOWFIHJ5eFi9SUG3DT/OK3NtqigGL8EF
	 klgLBL7N3H1RAdc4G7aoclYxE0d9shu7f/myNAvtE1uz3j0S34aDPNBWMTpQxwx1vS
	 fAw1JMAwpKp4GPhR0BRZV7u22HEWrApwumvEG6uv5RITrz+cQSyNsd0F79jVkLWAmK
	 5hOX80tDX8mCQOSosch50Kr38pMMYxk96nY7Qh2eUDiCsvgOD8YWiO/rD6rSkE3tQf
	 fnbfDTrEYzEkojoXr8SPoFeX97EePwQRbL+DJvYmHrrMqxu7d8Z0RVfg2CQ6KLx10H
	 7MvNqFy0wABaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE7A3808200;
	Mon,  9 Mar 2026 20:56:45 +0000 (UTC)
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
 <177308980398.1777985.246050875948989110.git-patchwork-summary@kernel.org>
Date: Mon, 09 Mar 2026 20:56:43 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: atcspi200: Fix double-free in atcspi_configure_dma()
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1061950
  Lore link: https://lore.kernel.org/r/20260305-atcspi2000-v1-1-eafe08dcca60@gmail.com

Patch: spi: amlogic: spifc-a4: Fix DMA mapping error handling
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1062099
  Lore link: https://lore.kernel.org/r/20260306-spifc-a4-v1-1-f22c9965f64a@gmail.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


