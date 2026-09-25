Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426F848A2A1
	for <linux-spi@vger.kernel.org>; Fri, 25 Sep 2026 10:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790331685; cv=none; b=X/rBWVF7SNrYstOmoE3MvdJySoAYjjlNTRWakbcDJPTIfaP66IbBGnejTmBEFOKEg8dfNKk6dfl9H8cokPF4utVwy1fBqbgdZLLA1yd2fh93Qb9qdWGysruLCCAOSC/xoCWtyiS+pJmgh7A+6b84fEsWutBKgdbkYIcmTdoLroQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790331685; c=relaxed/simple;
	bh=pp+KoDJKu8cfVcYIWyFsvio5fwP0dyM5X0zt8uhCdHo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=MoxfYJegilfD/0YuWSV3TJJs17UODKMXU5IcvWHTaqzLS71dgUHv9aHajzwbMPzzX+jDUh5hYf8ybs8i44ictMhdR+7SiM3ic1d8RDQJ4llzqeQXf9BNJw9VlkRIHgJKdoW+bcmZN613BXhJ+6B+of10DdmbXp6fwckmMubHoD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntEHNsTg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntEHNsTg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5821F000FF;
	Fri, 25 Sep 2026 10:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790331683;
	bh=a76bQGqL+6IcmGrirOf1fXtBQSGD/sdeBFmjyOIMgZ0=;
	h=Subject:From:Date:To;
	b=ntEHNsTgrFDAvVEpiW6FuQsqZK6Jc7lv2EwpxT+dcNfOrQgtg6sJW8eRBx/yL0LHq
	 wbalZFIQrBdiyg4g8ZNz/itbtAY/5+MQ2sSf2bBl/bthXZG6IY28iKeN5heR6l0U0l
	 4PHPwt5leRpzclgdhDVAP+NQux0LjONg9zECJxrYD7ZLZo9YUG9+I6JGO4DtpH9SnK
	 n36nH7aDZoF9AToGYfUk4Lv6Ib1kiaYhtOTriJs7TnUmxSorbvgB60ERmIKdpIbeiN
	 C2m0ib/z8+pAnnI2a6fbcwYOPfHQpTFHqF+RuZ+OpfOjxJnnNNSCtkOy5athONgnz7
	 w8aI2y3gXU/3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1C0153AA6A42;
	Fri, 25 Sep 2026 10:20:13 +0000 (UTC)
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
 <179033161176.2436202.8188772519635984217.git-patchwork-summary@kernel.org>
Date: Fri, 25 Sep 2026 10:20:11 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: spidev_test: new features
  Submitter: Jonas Rebmann <jre@pengutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1173156/
  Lore link: https://lore.kernel.org/r/20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de
    Patches: [v7,01/13] spi: spidev_test: include tools/include
             [v7,02/13] spi: spidev_test: clarify usage for --size
             [v7,03/13] spi: spidev_test: make size argument mandatory for --size
             [v7,04/13] spi: spidev_test: allow zero-length transfers
             [v7,05/13] spi: spidev_test: abort when -I is selected without -S
             [v7,06/13] spi: spidev_test: always compare loopback data
             [v7,07/13] spi: spidev_test: add compare mode
             [v7,08/13] spi: spidev_test: allow disabling rx or tx buffers
             [v7,09/13] spi: spidev_test: don't send 0x0 or 0xff
             [v7,10/13] spi: spidev_test: send predictable data
             [v7,11/13] spi: spidev_test: add option to split message into multiple transfers
             [v7,12/13] spi: spidev_test: print TX on error
             [v7,13/13] spi: spidev_test: rewrite unescape() to stay in bounds

Patch: [v2] spi: spi-qpic-snand: reject when no enough OOB space
  Submitter: Ziyang Huang <hzyitc@outlook.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1147281/
  Lore link: https://lore.kernel.org/r/SEYPR01MB5882463D860A9670617D5834C9A72@SEYPR01MB5882.apcprd01.prod.exchangelabs.com


Total patches: 14

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


