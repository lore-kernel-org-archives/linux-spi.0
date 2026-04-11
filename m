Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C641514F8
	for <linux-spi@vger.kernel.org>; Sat, 11 Apr 2026 12:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775909429; cv=none; b=CxCYV+ZFy0FiihvUSGPoQ0l1PGoQya+xcIGdTIH9VMJtfp61j5quFhwlvUvQ/u5nSL+3U9nxA3oGeHze7CWdCcGKNqDeuUACrgHdtnIfBtczFVfsK5U0GVMIeSwUB+/WCeQ1cs/cODaSTic4urIlU2HPIzBSxNNelgepVkD2ZW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775909429; c=relaxed/simple;
	bh=+9/s/DQanxD2TitmBSDP3ZmQcsSLM9TNmGhlBSmv0t4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=hKVhseRWB2Gi2QHvULAGJEcBHyvq6MtKTmcaxbEn9/QfA0emveUnPeGEdh+oUic9/FYHTPqguQZ5YBlJBE61D9CRAe6xi9HRdxKxBf5v3Lzt3nJuwEdYHLNZ24hxpHUS+PQ+W65rc5NAhhAsuTdUi9vCoC1rxuhlMkLgBd2ZmG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6xMjv+J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6xMjv+J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF0BC4CEF7;
	Sat, 11 Apr 2026 12:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775909429;
	bh=+9/s/DQanxD2TitmBSDP3ZmQcsSLM9TNmGhlBSmv0t4=;
	h=Subject:From:Date:To:From;
	b=F6xMjv+JUMSpRLz8sQQeYobgm97dXb5UoFFTtWy7OhyetC+KuyGlbPIx6BHMznv0H
	 GgchRCkCe2Nuf6Lg5d3a8QloNWn0Q4ToKvl98VDsO4vGcXL99Nuh53E1CPtXfVY7Hf
	 O0aoZGHSaf6FLaQZx9iSK9WYeCdJjRhfk5K2LdZqtwYosQxsiZIJt3ykctjEY5hAzB
	 H5+33+NsS1zEYOy82Sh6O3YWzVbtRaoK9Qh/4owAekLsO1QGx4mCtyeDM2QNadJkQz
	 TbvjwTi5m70UaMIPev/U35rEx4kR3h1+FizxBJZIVpIeig3JMvOvOfyFz3mw4d0SOt
	 3AdMlh4WQ0Yzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 427173809A88;
	Sat, 11 Apr 2026 12:10:04 +0000 (UTC)
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
 <177590940268.2952216.11629252730877327950.git-patchwork-summary@kernel.org>
Date: Sat, 11 Apr 2026 12:10:02 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: mtd/spi: Fix Winbond W35N02JW / W35N04JW support
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1079878
  Lore link: https://lore.kernel.org/r/20260410-winbond-6-19-rc1-oddr-v1-0-2ac4827a3868@bootlin.com
    Patches: [1/5] spi: cadence-qspi: Revert the filtering of certain opcodes in ODTR
             [2/5] spi: spi-mem: Add a packed command operation


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


