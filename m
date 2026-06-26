Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15DA379EDA
	for <linux-spi@vger.kernel.org>; Fri, 26 Jun 2026 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473438; cv=none; b=YXHR/hIvoHukoeJkefz1moysm7vPdSPQ9SynhDeGgJzAxJiuvVTFmjuO1x3awExJku+XbU7k/gfNZs1ZvRbLiiNpOWjAqul1zpX6V8UrkgY7USHOsMk4uR4QbOTpCmyPYcxvmBJlF8THEP3auwfU1+yH2i1F3kGCzCQnaG7vZG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473438; c=relaxed/simple;
	bh=YH4gZZPTqYBWri5yfgawrMD7hen/QMoBFdZM8J6LvXU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=tQDgf+jsR8GessizT6b/0ulwjXpL5v3S2G6pH96LwupU5NFsP/PzI+hPuut1RByUf5QvG7qUuwyiqxPfXl+DI58TnYoJMVF3+9C56U/Nz+p3Ir36+BJ0eVsp0RpaBo3ealgo7Y8X249hWdFAE2LE7lygNmjFggbs8I1KNmSgO+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLtCvTYr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLtCvTYr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB39E1F000E9;
	Fri, 26 Jun 2026 11:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782473437;
	bh=GpkSWAsMjzz1PCoaZYpzX9RmiwdSrL41H9qALxDzIPY=;
	h=Subject:From:Date:To;
	b=CLtCvTYrswjV6VfC81krfbT2/cEdQqXRZrZ/8TXksuIbYay8MZG5RyrLyN/5GOx4O
	 Qs0/DjWD6sDbRuFfKVQvoN0kEH8jgqQ2aDoL5F0dOHjS6pcR0FmlzfEK+Zf/gV+/r/
	 7hEiFczLRZOmLZvoi/bTRa77u7BVTLRN+Tgq4IsXYsxdOxDrqQGZioGtnt2f6Hh79c
	 vwYR7FB30/FqLINpP9786ME6p4ofGWw/to+qKXw8Tb0yLBC5MiRH1/TBCln2yzzOhQ
	 ch8/gmcI3A4Uj3yO89x2sGzJduMX1qS0aTJ+NdzI6JbHDlcFiMH/xHF4HLIgewxeBV
	 UhPkD2fT7DNvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AFC39389EE;
	Fri, 26 Jun 2026 11:30:25 +0000 (UTC)
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
 <178247342432.457674.4420497010575556468.git-patchwork-summary@kernel.org>
Date: Fri, 26 Jun 2026 11:30:24 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: sh-msiof: abort transfers when reset times out
  Submitter: Pengpeng Hou <pengpeng@iscas.ac.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1115421
  Lore link: https://lore.kernel.org/r/20260623135834.55442-1-pengpeng@iscas.ac.cn

Patch: [v2] spi: core: Abort active target transfer on controller suspend
  Submitter: Praveen Talari <praveen.talari@oss.qualcomm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1116639
  Lore link: https://lore.kernel.org/r/20260625-abort_active_transfer_duirng_s2r-v2-1-1d6f724406b6@oss.qualcomm.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


