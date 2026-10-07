Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8506A400967
	for <linux-spi@vger.kernel.org>; Wed,  7 Oct 2026 10:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791369024; cv=none; b=WX1qxxG2bWy1pQHyAdeQX9/gI74rdENzgUSGr0b7s2gQicaHMeC21iNvJEDhLMSDbugfM1UvNpVYhTpamBBapVMVm9Tdk6A5nS2gwmiDpx4/X3ouhYWrGdVCh6lod4T08o1Tcd48Ge/5jAkNy6xVGkNWV2Gcuc291p/DpsVxHVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791369024; c=relaxed/simple;
	bh=eapUQM4hkLXVYe+2mT17q7bPgnS0WbIszlnUIKlyonU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=IEzYdPN9UDGVrbGPo83O3HSmN0XRbYfNZ3oDkUlWg2vdbMEfPHjh1e6SjTDjF92fbn5WJArEI/OObQ0DVGTpoNX/YjBZSs3Z+k8Qt3ugvStkTGs8x/NVmd2aejHh7XyCxOksoIeBIVXQnChL2K5VJU8Ymd74UAU3QGzGhE2klw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcRtdmuz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcRtdmuz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC17D1F0089C;
	Wed,  7 Oct 2026 10:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791369008;
	bh=dJzb6aYpoVQBJ2bToe0rL2PGj8NOxIiEhGtZW/8hEIs=;
	h=Subject:From:Date:To;
	b=XcRtdmuzwaDtoW/lhUl6LchNMXaHni1LdSkgNSuLCQCs7dTX8H3SH5pbSR8gMRxoA
	 yxuZXLiw90tty8qVKNlnNeIkH0mwVJM76mre46/XUPz1Kyrn/RDRqAxztthw+CIi3D
	 RPI+7SQq86JA08ZGLUTQg/+HyGU29fgQ+lxJplciS18gy/bRaX8AiaruPueTKsmHME
	 Z4ooYZbIeOPUpiYwLpNOwnApL8wdwvqtbanr9BO3Fhv46TdGOyzL1kfx8SQT5NfzQL
	 Y0cdp8eDU20a2/2wDAQUhVFripeiEreQXGm/3m7edFJh11zmTfgA0Jqllo5FzklxBS
	 miCJ6UQp2Ox/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B6BE539E8A76;
	Wed,  7 Oct 2026 10:30:08 +0000 (UTC)
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
 <179136900719.3026506.16340498862756151453.git-patchwork-summary@kernel.org>
Date: Wed, 07 Oct 2026 10:30:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: dt-bindings: nuvoton,ma35d1-qspi: Drop redundant SPI example
  Submitter: Chi-Wen Weng <cwweng.linux@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1180066/
  Lore link: https://lore.kernel.org/r/20261006063643.198830-1-cwweng.linux@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


