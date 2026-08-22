Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB601A9F96
	for <linux-spi@vger.kernel.org>; Sat, 22 Aug 2026 01:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787360464; cv=none; b=LgkO+3NKERilWN5pxgdn9MDEn6WaU64K0K+IIvisXRTiBrZiIHiabTgqQm0/eyYVawg9DqGk4RlwZ22s/5HKt+nzwPdhMgywwPwcWEL8ZT0i1lT1RxXr+RMDhdPqZad3vkyR0QIbmEzS2vCGBHkWsvd+988R+64XcHnYvhwl7yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787360464; c=relaxed/simple;
	bh=dwQQSBXE7+2De7i7wgn8uu8cHs4O+9J/3UbEPHuhoFU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=aAM35d26BcM1FedyLXXLQkSQ7uMrCrENeDzINGz658za8NYdxntDVtNd/DfwBNed4JLAF1+FYAdlmE12zbqfSa6Besj/7+BMt97iz+PXByejXNcrX/aX7D+gqp2kRybVOk0z7oLK/UtmXppiyzFWJDu57vclqPjRxPVb+YkH+wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnicZRjr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnicZRjr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3641F000E9;
	Sat, 22 Aug 2026 01:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787360463;
	bh=8TjLGsR3/2WDDBDGG93aWd8E1Mkp0XSqm6p3gLCcXuY=;
	h=Subject:From:Date:To;
	b=jnicZRjrLQWca9lvtuXH/TU8TroWB24Bx1frEaWxVbS38gjcqFKN0UkCJJJY3ZRmF
	 eNkoBVFWj3WZitydEn85NmwtPGmKJRpB/p8jGY1IgHYMArsZ8lzrO3S1Ypq7yjMexN
	 ZRYovPJvk077JORcmwAbXa7ddeJD6KERAuVtSCxnqR4+UdVSv5mhQ7D/Z7J8rrgY3Z
	 vwQH1qeqkSkAmF0fQh9RzoVInY1pejYaTKXAUyHYi4RR/z4j3CCSyRGaHbqzQuEEP2
	 ZRpsRrMXpq13a2u39xFs2XxTP9LLRc+mc8uv4I1JS20CwU7TUDNQNzhgsd233EmkQW
	 VYLrlsY/AWLAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 962EA380CEDD;
	Sat, 22 Aug 2026 01:00:13 +0000 (UTC)
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
 <178736041209.1547320.2383607073458936777.git-patchwork-summary@kernel.org>
Date: Sat, 22 Aug 2026 01:00:12 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v3] spi: loongson: pm: add .freeze .poweroff .thaw .restore
  Submitter: Li Jun <lijun01@kylinos.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1148974
  Lore link: https://lore.kernel.org/r/20260820092351.101605-1-lijun01@kylinos.cn

Series: clk: Make sure clk_init_data is fully initialized (part 1)
  Submitter: Geert Uytterhoeven <geert+renesas@glider.be>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1148675
  Lore link: https://lore.kernel.org/r/cover.1787165329.git.geert+renesas@glider.be
    Patches: [treewide,1/5] clk: ti: Make sure clk_init_data is fully initialized
             [treewide,5/5] spi: amlogic-spisg: Make sure clk_init_data is fully initialized


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


