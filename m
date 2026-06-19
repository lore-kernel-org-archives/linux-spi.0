Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A153822AA
	for <linux-spi@vger.kernel.org>; Fri, 19 Jun 2026 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781870411; cv=none; b=k2zpdsAkPJXL8m4JuF79GYzPMhP5HMbo49Z4npT6Cvtb8tkgRqhlSrFMDSBCavEfw0uVmLbmCYAUdUIjTsx8jZwnaJUiXM7kgmv2VOoi5J9Q1k7t1VBUiyDJiEBHEulcypRHM5faTiL3foieyNSB9xvs9eN72xxPzreh2zvvxRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781870411; c=relaxed/simple;
	bh=JJ5yH4eJMwS1KaOeJh4uyRHmQ8o9JptQY0lmJV6Svcg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=jbdJnDn/46gbWYvmfadGb1SfvqTAVyAcDvQKMt6h7AKElVfeb0sGV6/cNENuAnf+92RgjAYZVLM95ZPvWlQlZpdYBnKdNnhCbHL23yM1uHCaOEtv354zP5AUzGanVRMCm0BG0gKU8aiHuh2LpXie9GGBXqdvDsaVL7vjuGnToO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANmjpnD0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANmjpnD0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCEE1F00A3A;
	Fri, 19 Jun 2026 12:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781870410;
	bh=x//OWNDVY9FbJ8SS6oaGFsJa1fvrmUtI6WJ49lO3EGQ=;
	h=Subject:From:Date:To;
	b=ANmjpnD0VvFKbEd9sgQWNLDcatKQm3bYt/KdBYBEOfHofaSs+h/Qbv6tvh1GBzAKf
	 bCxHpx1dnT2au5l9jtbdTSaxQ+ld+zgv4Ce4GDeBZBjG9yP/5+NLfHZuJUcL0z4Udb
	 G7B4R4bymJKV61DFVI92kD15RMuKWnxyhMxH7bY8PyBFYvyoz7FvFSnWchnflcJ1/T
	 KA/rxKe8HuYNpfpMAEKVY2VJt1OpEjaEHVq8f4fxcqiRdEsbv3CuTySQM2FBN5aqmD
	 ZWbd1JY7tY3jJ7FUzlE4NeUY7mKXiV1SfVe/EdtBcbvbkWyhkFsLoucq5QsQyFnXDn
	 J3QIZGAKksalA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C783AA6A58;
	Fri, 19 Jun 2026 12:00:04 +0000 (UTC)
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
 <178187040347.3447764.3582830642580049644.git-patchwork-summary@kernel.org>
Date: Fri, 19 Jun 2026 12:00:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: rpc-if: Use correct device for hardware reinitialization on resume
  Submitter: Biju <biju.das.au@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1113293
  Lore link: https://lore.kernel.org/r/20260618081932.172168-1-biju.das.jz@bp.renesas.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


