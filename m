Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2F73BE17D
	for <linux-spi@vger.kernel.org>; Mon, 28 Sep 2026 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629283; cv=none; b=F5kzkNQmH1BENICq9BbGZNYV1v7eIr6l+I4EgiPuizyE8kFO27Oix7Ap3Oc+7HfZeZusTVTX6nqOrWhuO6gSJPr6X67/nMCVdQ1MorpeQ2KLcG0B9J04YCVYWp+x44f3nfthJq7rup/grghEfA+dfrV4CrNK+78rKQ2zQIUP7JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629283; c=relaxed/simple;
	bh=o9Qf/eEjsRFzTQjw0GJLwZi39enO27HUOT6myWh89Uo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ef7oi1Co5Zh6p0cnHN0rjOXLhlvHGCtlxp18ukYM5VMaP6kFX5aKaiwfLgY2DqB8TUARQwRXRx0izsXbcDM9WJoRnEJiJ1ZS0hXVUWSGthjhwylqxaPt5e5nLWUwzl3IuRWKOYL/Pu9Giyiat2nGlU/ohEmNO4ay50G2wjjt+EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDOHr/0z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDOHr/0z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC011F00893;
	Mon, 28 Sep 2026 21:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790629281;
	bh=t6CJE5n5VsmCTMXn9SG6PMpaN8rWeccUx8BRLlL5qTM=;
	h=Subject:From:Date:To;
	b=RDOHr/0zJfEE6Mulf+bN7nDDd/K2D6bfZMne2iMlGVemKV+Y1RfkXreE184cCkZLm
	 H2xVLg3ITz9yAzg7HbpQnk6YP46SScZye6LOCuM3dwr13LNo5qGheyfZNkxLKM2Cd5
	 +s7u+6G1uvd687FBktbpc0wKw57nzD7iGI4W01ODYuNO5anJL8PTvgGOr9nt3juSqM
	 P8d180wd5MaSqgrCWTG1saaJ3YizubewZksVspSwKaXAhSgpThnYUuQUEzrgMIkAIl
	 lSxSS4aJWrz3BOJcA5oh64szIlfBxsf42OGBm6oacj7em9/msmOm7xgjNeEO7V4MIN
	 nY+vlycYlr5Jg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9646A3924FCA;
	Mon, 28 Sep 2026 21:00:07 +0000 (UTC)
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
 <179062920627.127793.763799149699590723.git-patchwork-summary@kernel.org>
Date: Mon, 28 Sep 2026 21:00:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: t7: add some nodes for Amlogc t7.
  Submitter: Xianwei Zhao <xianwei.zhao@amlogic.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1172754/
  Lore link: https://lore.kernel.org/r/20260924-t7-node-new-v2-0-319d3c19b4b2@amlogic.com
    Patches: [v2,1/3] spi: dt-bindings: amlogic,meson-gx-spicc: add T7 compatible

Patch: spi: rspi: Fix DMA mode when the DMA controller is built as a module
  Submitter: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1170664/
  Lore link: https://lore.kernel.org/r/20260921195943.107247-1-ovidiu.panait.rb@renesas.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


