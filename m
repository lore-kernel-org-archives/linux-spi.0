Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BB13054C7
	for <linux-spi@vger.kernel.org>; Mon, 27 Apr 2026 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777285850; cv=none; b=fb/tCxK+sWXThjW8CzgrVVDZ8KOyR+ChcLXWi7+b8TqWToQmtEvCyGthvFwIyAJxvOLcjB9NkJDMfUEVh/gdikSgpG4yx9qYb9P9Px+QWZ7bjdQPBJLqenGa/yhRNZ9p90z8OVU/8ZV10JR9xBruXj39ear0WqLJXJTkffkpLbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777285850; c=relaxed/simple;
	bh=VFPXzk//l/KL4IwyfS45qkVLTjr9B36M26IGRUsx0Ng=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=i8oDFuO6w/fIuOT8hUR3PZyq+rfvMdJirxiZ6kTjDTGtXrc0uvR3WLg/ndFeGY3vXuTik9mPuQ9gZivib5sybJDzsoizO/uwR7TeNq+NzhUwWi6qtl1W0DlbE+ijuYxzvll2+BCVkDSEc31hkWgKAQi/4XGoXyiZtDZGazsXVu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0KI+7Gr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0KI+7Gr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBDEC19425;
	Mon, 27 Apr 2026 10:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777285850;
	bh=VFPXzk//l/KL4IwyfS45qkVLTjr9B36M26IGRUsx0Ng=;
	h=Subject:From:Date:To:From;
	b=U0KI+7GrIpjWBMjL8jAm8M8Tc7Bavj8v3x9JtbLZKDw9l2z9OveXwlyaEH6zWnLHt
	 Ab0PojIm2bHRU9LVmszSBC/OeqwR2GhjKTlF3RSOh8qYZnlzcBd+1eNwsv69psZWzi
	 N4eqSirdonEt/IwTQKxf9PKpN9giF1dz6aLq7vX3FOnBfFgbE4WSxsTDn5YL/AGmSI
	 VwiYOBgUp+s57XqGvqyN1KoBVecb05oxhdtUJweIqpHlWQIV8GdAc1gsxAdPuYXWuR
	 WZHHU/Xgd6w3u3BEFrB1wZQh3/XsMy0/D360k2DUrSepmTRWiGfRKNPqEy5RVCd0pl
	 DrDRiuQwmwcpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 422CE38119DC;
	Mon, 27 Apr 2026 10:30:09 +0000 (UTC)
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
 <177728580797.3279777.12110441890085060570.git-patchwork-summary@kernel.org>
Date: Mon, 27 Apr 2026 10:30:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: atcspi200: two cleanup
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1082121
  Lore link: https://lore.kernel.org/r/20260417-atcspi-v1-0-854831667d63@gmail.com
    Patches: [1/2] spi: atcspi200: fix use-after-free when driver unbind
             [2/2] spi: atcspi200: switch to devm functions

Series: spi: cadence-quadspi: runtime PM fixes
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1083842
  Lore link: https://lore.kernel.org/r/20260421125354.1534871-1-johan@kernel.org
    Patches: [1/6] spi: cadence-quadspi: fix runtime pm disable imbalance on probe failure
             [2/6] spi: cadence-quadspi: fix clock imbalance on probe failure
             [3/6] spi: cadence-quadspi: fix unclocked access on unbind
             [4/6] spi: cadence-quadspi: fix runtime pm and clock imbalance on unbind
             [5/6] spi: cadence-quadspi: clean up disable runtime pm quirk
             [6/6] spi: cadence-quadspi: drop redundant match data lookup

Series: spi: cadence: runtime PM fixes
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1083838
  Lore link: https://lore.kernel.org/r/20260421123615.1533617-1-johan@kernel.org
    Patches: [1/4] spi: cadence: fix unclocked access on unbind
             [2/4] spi: cadence: fix clock imbalance on probe failure
             [3/4] spi: cadence: rename probe error labels
             [4/4] spi: cadence: clean up probe return value


Total patches: 12

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


