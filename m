Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEB728136F
	for <linux-spi@vger.kernel.org>; Mon,  2 Feb 2026 23:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770075834; cv=none; b=ASjGjUXDElusX/09fsf/kKMuo93aBdXZTL8o5aYjuWO3KLRc4O4PoooxkwbD/t28nRw2ITHA7mENbs5t3LLB/blTfqacYQCkjhgXApjV/c7Mij4Obm37rXckpPvuQbhcG7F57GNjW1ELljfjHEt7VIRW8LEAtU5TIsdeUg9X4rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770075834; c=relaxed/simple;
	bh=LfgQXhKmrKc+n7Za+i5c0iMiXwfbU5RLs6xKrG/kXe0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=l2U7/MOOT4CCj3k69FtjN6bzoi+d+cn8rNOjmu7J1g+cwpubMnJVeXZtdjTQRklZY9QSvmAmdMbn+qhJWaTMs065s9lMbJky926GRhlOlgOoaZt6esbv2Ur0CEwnoiW35t2668o65DyTV1L58fGqFtZkZdOeeteFFq0/YpObAeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRbxzn0A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRbxzn0A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90419C116C6;
	Mon,  2 Feb 2026 23:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770075834;
	bh=LfgQXhKmrKc+n7Za+i5c0iMiXwfbU5RLs6xKrG/kXe0=;
	h=Subject:From:Date:To:From;
	b=YRbxzn0AJMQZ6FWFuASdEfeZ3wMBPP7Zpq+qxDB82dMftIasL8Qa3oaIjkkOv63U8
	 j5kPGFiyPVW7koSMwwKK+FKm0HCqXtEpRZ9QeMzoyIfusPY+cnJVIDYPkjs3hjyPeB
	 xznsdyGmz6nH89Fy8tuvA/h6FMZXJXI7/qnoiZzxOSnCuRdR6dXjkBTXCyOuG1pHhE
	 QVOFUYsHJChAyf8BKQ6dVcIv11vr4jIm24lwAG53LaBm1zYPIf629dqNKRYV8MZwHT
	 2s8H69P4YSXCu8R7K8M8Jn+u512sRWpLHsFv1sd4SDd0tJUtzg/P3D6sRF2UdL96Yc
	 jz0MBO6EeidSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 911E53808200;
	Mon,  2 Feb 2026 23:43:52 +0000 (UTC)
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
 <177007583123.1233804.15497556398474331076.git-patchwork-summary@kernel.org>
Date: Mon, 02 Feb 2026 23:43:51 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: tegra: Fix a memory leak in tegra_slink_probe()
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1049836
  Lore link: https://lore.kernel.org/r/20260202-slink-v1-1-eac50433a6f9@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


