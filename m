Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14BB407110
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 17:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774371618; cv=none; b=oa8RQDOIZDPFy3xBCpCnSXU4qhuWPnFPG2WyAwv/X7D9oHfasF+Uzd64tZ2eXN0BTDFWBt9SM8aA0xbnhleMbsHiGd+IbHlKWXAJgEO+owTxfgmSGxdR4nzg9cRxVXYSXYOJPB/Ar+okCjJo4/a4iWuEyFrkK6q3AJ2Yjry+Wsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774371618; c=relaxed/simple;
	bh=rl+vJArOGcdkfdw8lU+2E/D+D0KziEHbdrrQowy9Hhc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=FC9RHbtU3GrNTTiPb6v8MJfAzQs6IfZYIp2QOEOpaEs7rfUCKBSfBmuPtJ+016JIkFfveokpw/dEoS5M73A92MI1FjlRQE42wav4Z0+4jh+wUpx3S2QrKetgwbaWbMopY9SjrxgTKOn1N8HJaupkgxBr/+J6zDWMKhcnYYfba/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7ugzNEe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7ugzNEe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA21C19424;
	Tue, 24 Mar 2026 17:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774371618;
	bh=rl+vJArOGcdkfdw8lU+2E/D+D0KziEHbdrrQowy9Hhc=;
	h=Subject:From:Date:To:From;
	b=G7ugzNEevF/22Hhs8zx3GoS6YqRz71E1YC8H/HQVXMvwyDur2z0L3cMpEwfOwV4yL
	 9bAuIXWupdfr1bV8vE05F7z/7aYszt+LfZQ4RQNN7mPoJKF72nSbb3JDSVjtia4kE4
	 jXo6kT/74GAP1gMTpLtXmnT+hnErg0SmpZgSP6wl5OcsdZs19SOMzKL0wPn7XT72dr
	 grCKN+/U8p7jitxPbRsIQ/Xu1t2jdsqTjxgD1hDTqDyN2Kuacp09jTVFxxF5ug7syI
	 c/Y3Ytboi8Y31fgdMWFMHaCnOvoDW4VBAX2oI56Hjr74Gy1oQZi8KMt+Iwbh1XDQLT
	 mdqchNytPsirQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 428DC3808203;
	Tue, 24 Mar 2026 17:00:07 +0000 (UTC)
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
 <177437160587.1210317.13843484127508292251.git-patchwork-summary@kernel.org>
Date: Tue, 24 Mar 2026 17:00:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: treewide: Convert buses to use generic driver_override
  Submitter: Danilo Krummrich <dakr@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1071294
  Lore link: https://lore.kernel.org/r/20260324005919.2408620-1-dakr@kernel.org
    Patches: [01/12] amba: use generic driver_override infrastructure
             [11/12] spi: use generic driver_override infrastructure

Series: spi: imx: fix use-after-free on unbind
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1071484
  Lore link: https://lore.kernel.org/r/20260324082326.901043-1-johan@kernel.org
    Patches: [v2,1/5] spi: imx: fix use-after-free on unbind
             [v2,2/5] spi: rockchip: fix controller deregistration
             [v2,3/5] spi: imx: switch to managed controller allocation
             [v2,4/5] spi: tegra20-slink: switch to managed controller allocation
             [v2,5/5] spi: rockchip: switch to managed controller allocation


Total patches: 7

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


