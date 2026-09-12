Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3925E391838
	for <linux-spi@vger.kernel.org>; Sat, 12 Sep 2026 19:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789243116; cv=none; b=FscxBhTyMuvE+VS7O+ELUI3ulS//sgSF1ydt/z8LQu8RFUr/qKytoPEol+rs+sA8eLT017v5KcSS/NXQhuMo1f/YzehkQQ2fC8m5VpcrPI4r4GzA/AuFgmRn0m48vFRAgT9toRDkU3vfF45JtB05uBM2ep5qm0ibl9jWeDA/73o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789243116; c=relaxed/simple;
	bh=RPQXp47606pOS5jBGqKWWdKGWBnl8Kxf4LvjEukJ92E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=P2r5pockhxi7YJyGv4kjah0c8jDhzi42k1jq9nbSvH0veS9iGfnyXMmIJge+b70fRmwz9YNWV2gUaNpC7N7zSgFkXxNuYjTRhDVVz8s9Q7fOto47Bk8cx4WxowLpIqNtLS8NsUAkDLZ2jzxdQyfYt+kmyLQxTOkfnRmCMzH/niM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i47EEKj0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i47EEKj0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F321F00893;
	Sat, 12 Sep 2026 19:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789243114;
	bh=hhExoQiuQ7KO97VEggILPEpBi9OweNF+fYbdv1m9vK4=;
	h=Subject:From:Date:To;
	b=i47EEKj08cC598/lbNTmd64+nsdN3oWdeCS8xd50V15iW7aM0pFk3QQd57P5FP4EQ
	 qMBtnh3uwDBlYp03eTIcJanM+pyeMYqITe1ZHuAMc7iRlC424SBYorM1xxue5NmUwp
	 Mo0hD0xH1C4wN5hHp8i/qjgr8nbAdl0lNKfjewwghR/Gr/zQ9+dREcXGcifALpq6Fm
	 a1SDiyYFILlPBG5VXnnoIQi4fSlfKIo7g8N7is2ORNRPcuRW4qKQ8Dm5U5fBPmPah7
	 BVIifbCJFOId2YojOz28/Zo+SdNwxL93oERwnF6tg/1ZDVFh4Xk73+moCMsv7MPMQh
	 m3QsHCeOVeyhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5698C380820D;
	Sat, 12 Sep 2026 19:57:32 +0000 (UTC)
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
 <178924305091.3624053.15431953050235944785.git-patchwork-housekeeping@kernel.org>
Date: Sat, 12 Sep 2026 19:57:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: rockchip-sfc: skip DMA cleanup in PIO mode (2026-09-12T19:00:56)
  Superseding: [v1] spi: rockchip-sfc: skip DMA cleanup in PIO mode (2026-09-11T17:27:01):
    spi: rockchip-sfc: skip DMA cleanup in PIO mode

Checked 164 series in 2.11 seconds.
This project currently has 16471 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

