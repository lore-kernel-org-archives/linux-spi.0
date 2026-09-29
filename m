Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C73524AF4
	for <linux-spi@vger.kernel.org>; Tue, 29 Sep 2026 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685608; cv=none; b=AyHkR9xTaD06Y68gx5+VPJB64QgoKQFhE+xAMYSwTCrXQ5LiRNFYLTDSR21tTsfFwNBrA643LFbSdgLsssA0NFzGM720n1pnro4JZTvY86oTaVAoLavbBv9R2YjEqq5nQmOIuFokRdSRM7pLpL1F1w5ULTP3hMpIE+xjXmDwfRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685608; c=relaxed/simple;
	bh=/9ZXITnTV1VgwAGHaIJ6VzyaSPUzjZgVlNgnyK6quDU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=s4SuSa9NVowXo2M7iuCJL/NyHAomB5dImSYTC1RxkPS0mnNrNaOZ49N1lVwYDkLClFHaSEbv97LmB4Tu3poFx4TWQ0Gvr2TCD4s2SBqkRdsmYLRhFMqb6R7OHOMV/Mklw+UuhTqe5AkdWmeAeDRlGB7drhzW1QXxpgwYC7oZmdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfWvz6Fd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfWvz6Fd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF3E1F000FF;
	Tue, 29 Sep 2026 12:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790685605;
	bh=w+cReuv/dbYNJf1PWvLSIP1MgvkQ3QyqB8d1sVn6MvQ=;
	h=Subject:From:Date:To;
	b=HfWvz6Fdn0PBXT4zZBY0bkJCl7oFtbaGbQ43W+R9DdQ8lx8kF7SO2PsgA9QIM2xLt
	 acicn4cElbYQd7MsO6tM8xzKSHMWINiUqnOxwIdC2yTBKIUxNk+AIX1HrNgbJ95j6R
	 gDoqUyyXVCW35s8dz7FCQh2ie6G1yYpiczqDHOOhw4hWLTmaTArI08J7+UqVtThCQR
	 H39Jf9EBzJHxFkBO9lMREhOfH1j5uT3dfAD44WRU3CpG3S8TZzQVgi9kZRswrrRh60
	 ks3a7AghDNwjE4Ik3W+YNCLRiEsTZSTbbtbZTaHZRI4WFeaDGY4b+teV8Twes0vB59
	 cCIhW3sPuGQ3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F3CFB39263B4;
	Tue, 29 Sep 2026 12:40:04 +0000 (UTC)
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
 <179068560354.471062.101206116344480632.git-patchwork-summary@kernel.org>
Date: Tue, 29 Sep 2026 12:40:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-qpic-snand: remove 'ecc_buf_cfg' member of struct 'qpic_ecc'
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1176058/
  Lore link: https://lore.kernel.org/r/20260929-qpic-snand-drop-ecc_buf_cfg-v1-1-c9de93142815@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


