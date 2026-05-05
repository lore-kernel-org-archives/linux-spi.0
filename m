Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2CD175A62
	for <linux-spi@vger.kernel.org>; Tue,  5 May 2026 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984255; cv=none; b=Oso45Pm3pU3SjcmfenZvBMBqBhIXdysPNyGsYmQ6YTX5k1DfGKDw1C4W4atfG07wohDM1h9xAvqkJNggST9kwGNkKKDH18vPrZ1WpU/SWM7S+7+fCVqCMADgY1YGAEhGwKMwRq+9B9lN1tHFpIpO07seqIbxMPkgz2rkuyWAAr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984255; c=relaxed/simple;
	bh=FDtQ6icYZpdcWuO+YJwgOVDFErI36waEQKVfuoToN84=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=lR5pEf+lkJtDoQNZWfVUllCHbGDj/wXxt32SeMAMZYqQrR6vVOwZzQEfqft38rRfl9TlwULh5sU+3VCpjTe7fQiYv6nr//W9o8bUlRAr5aDIzsviUMytV222dwfZnXD30At0dCk40aYrhccCgaLMJuh1u3+FW9b7hJ2UEvIiDhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4ygTfSh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4ygTfSh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A381C2BCB4;
	Tue,  5 May 2026 12:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777984255;
	bh=FDtQ6icYZpdcWuO+YJwgOVDFErI36waEQKVfuoToN84=;
	h=Subject:From:Date:To:From;
	b=S4ygTfSh8+q6HmmxmlhWHrTKp1Vw3YREr3C0jOQaTj599V4gqdGKMrWNteHklGsc3
	 GHvBKS0CN5DjqiyUNh3C/U8Z3KkQvUnMXCqVm6VVAH7ZWk7pjk36jC4M1zi96Wafvf
	 6vP2LRGhPeLO+tUIkzilQsx2QcWFcW87nLlu7zSxxpxtuw1ebGrBMoR7C2pl5OvwVs
	 n0KB+Y2NWpisuK6mZeIjju0ZnumdOrFoTW4NYWzsPSXr3QDD10E0UtflGBg2QxHoc5
	 KujyL89ckCnBAQ4nQbYiSZFVqfDGs1OoUZrNEocqQuBoKl71H9Kh4BXonItDVC5uEQ
	 6UxPQ+QfJZxrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 053953930217;
	Tue,  5 May 2026 12:30:06 +0000 (UTC)
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
 <177798420444.1605686.10800249834501267983.git-patchwork-summary@kernel.org>
Date: Tue, 05 May 2026 12:30:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spacemit: add u64 cast to NSEC_PER_SEC to avoid 32-bit overflow
  Submitter: Guodong Xu <guodong@riscstar.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1089580
  Lore link: https://lore.kernel.org/r/20260505-spi-spacemit-k1-fix-overflow-v1-1-77564c2e4e86@riscstar.com

Patch: spi: Consistently define pci_device_ids using named initializers
  Submitter: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1089314
  Lore link: https://lore.kernel.org/r/20260504142117.2116978-2-u.kleine-koenig@baylibre.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


