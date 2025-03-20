Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5417A14B08A
	for <linux-spi@vger.kernel.org>; Thu, 20 Mar 2025 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484004; cv=none; b=YGTef6PS2VtONt7b+qMK6wl1tSoYhyoG1wqsx6KntaB3fnt6Mn56odTDPteb8W9kGYEs8mQPdbZqY7i9nvfusvsqgJbJXJRlmQu0ZhMkugQWa4EbihELv3qIXL4rKl43CwMyiEAZ+aXF4kUP9w783ofOgkNBubTcxTJsYqsdQB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484004; c=relaxed/simple;
	bh=mVEBDYt+Vx/rZccdFDVcsFOO5H+XhjxriGY7s0ijssA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=rbyho1AiaiMVsakZx/I7nZFZe0LV3f4tTN+GE1fu8UjxcGpFom7NuN44WPeD0NFJUM0EPaVYvWjU0skWcjJp2hTU9YNDoy3qYzg2jRBGvY+XoQAxymBpjpSwvD7Mvr/7lZELvMUsOvDLhSMEnAMDTHs9/5TcULgCxWpD1FhgFXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQGcVCYr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQGcVCYr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C315AC4CEDD;
	Thu, 20 Mar 2025 15:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742484003;
	bh=mVEBDYt+Vx/rZccdFDVcsFOO5H+XhjxriGY7s0ijssA=;
	h=Subject:From:Date:To:From;
	b=gQGcVCYrWD4RRgEetuaPbPYGKNXIWPBHNQ2dBoWenzticSCVn9YUx+cHJWL/Twzns
	 DlEwhH6+7bSPAC1bC94I0rdOHV825M3jOEdF/60pGJoij113YCqm2zjMVM3HfN7m3f
	 DhJswiZ7fN1i4z1xs3s5jkzYUf6N+uqwV62DI791G0NiJus+eqzA9wd0893IeEupmm
	 FDg41e7+JnDnXRUH92KCjiXhgvZPv79pJqMInAL85iyu+8IHRPv2ovzqJcrALPyOhq
	 ypqlKyBqY8UcoZovC1g5yBZFoQxDcCOTc6JGHwj9gHnhFndAYIDLL6ldwEB85dcJV3
	 5q3ujubgbilyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B249C3806654;
	Thu, 20 Mar 2025 15:20:40 +0000 (UTC)
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
 <174248403927.1806084.14314169514426106564.git-patchwork-summary@kernel.org>
Date: Thu, 20 Mar 2025 15:20:39 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: spi-mem: Introduce a default ->exec_op() debug log
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=945902
  Lore link: https://lore.kernel.org/r/20250320115644.2231240-1-miquel.raynal@bootlin.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


