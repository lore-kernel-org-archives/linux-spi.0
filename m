Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01313518136
	for <linux-spi@vger.kernel.org>; Mon, 21 Sep 2026 22:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790028418; cv=none; b=npqCoxkxvH8uc292GIStY1tDrUdq1NuJ4Mp6WG4LPGt2mbVjVU3+oMMb8MJHEchuM8k/hefKOidHggF2McQayqrdmA/RSbd5zfEl4cF64GlWEH10iSEhWRzxCk27nvHWJ0GET8DWltMoZwB2viALvNAvnUDr/LC0mmiwxu+JKgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790028418; c=relaxed/simple;
	bh=7Lu0j2w4cKnq4D4oOQBcxRQHzx8zD+RVhMDTec0k48E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=WTAwjIKVBB2M4iRwITX5WwZ10Wj28SRsaXVkW0A3CXL4RR50BTvWC8fOsn+PzcTaUt3PXMq4VBpjRbuOrWWOzkLH7Prl8zCoEnTdC+CypcaRRtjPR4gAq/WaqUM/ChmQ2sqig2s2ja6Co8Kf87MH0SvtRSQWb1kOn9/TAuWXXaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVtscY3Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVtscY3Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FCF1F008A5;
	Mon, 21 Sep 2026 22:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790028416;
	bh=7Vo+TeXgn5+kz4dUlkrJj7VxXJQPWCDQcB4Th7gDbJ0=;
	h=Subject:From:Date:To;
	b=VVtscY3QdDX+251/i4bkp+m4xMCxF6s4R3eu4xsLYLyTjN+cMgOdmm2bQuB7Gt0rD
	 4vzloNebcNPWvkA3YSWn+HzsVqCFQeQLZ27zD9Pfruxrch3Juuouzg59kdOtRGpoRD
	 laJiOJ/Ayi9LZGIcer70x7sKUybM2WJb6rGgkxXP0Q8RKCjRg2g1wYc74Cl1vJ8OV6
	 akBLxF7p0Su5c/JFaPDD+OX/zj2/AWLDkQo+Sz364Nv2UL25/mAuOGn4xJe/cmSXgm
	 oeFxEZJf4USLguKtQrEPcWMhqVw007GEu/cdQ7FQ9+6t6NJ2jlK8YZMgZ5aywyJRox
	 CSEFs7s8xjDeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A5239D237E;
	Mon, 21 Sep 2026 21:58:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179002792580.3255427.18358263851955065208.git-patchwork-housekeeping@kernel.org>
Date: Mon, 21 Sep 2026 21:58:45 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: realtek-rtl: add support for second CS (2026-09-21T21:31:45)
  Superseding: [v1] spi: realtek-rtl: add support for second CS (2026-09-18T21:47:40):
    spi: realtek-rtl: add support for second CS

Checked 167 series in 3.68 seconds.
This project currently has 16537 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

