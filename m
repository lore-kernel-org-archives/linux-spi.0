Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45222D0629
	for <linux-spi@vger.kernel.org>; Fri, 18 Sep 2026 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789736444; cv=none; b=JedFUXpvc6+T7eJXuMpVWBHJQwmZNHtxU7kWRjofGrcIp6h0AIFy5lMI6bF2GGIYib2y586hGlXtSwbGXnCkWjN/TYirXP42DNu8IRMiITN9smKmmNTd4qOZdcg8Laiv/jm2CYx/QNPL3I08PC10CvJc5dY8bQ6lVZbabPBokOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789736444; c=relaxed/simple;
	bh=dFGaneMFDysKIMne9OghBgqmiHDLCleQNXzRVmVTgrg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=EFNjZTm7pcca+VuE3cfHN3r/Cug7zYI+0YldIuUZud5WjUvqicwoo4+I1GEnFKkzClpoqHImC3uaJaN8a4q9BvJpbIN117453linRbqCw0nPaEbXWilazKJtwX6x4zYAi4AWF8j7l8ygRQWALQjGf2I/83vIrjphsAdSQsEbNSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQrqfeGz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQrqfeGz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391C11F000FF;
	Fri, 18 Sep 2026 13:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789736443;
	bh=98boOhfzGYPEkbH3fLB6ro0OcT+HqMtD5TNVLD37JOM=;
	h=Subject:From:Date:To;
	b=nQrqfeGzgRfHuv57TflcRLsSnXPx4XhLfFPBJHhblBrpWWhgU4dc9MwcGMrhbSndb
	 tJOqK/VrlXV6UGWM3Err03T4ONE6oJMh6ZcD1YMUCbZw/RMZFZX/k2Q9WWx3KZuRqu
	 nzgLiRceb4Q9LDYOJM2SWrGYxdX9gUEjgE+59m8bJ+7CVXegFv3WjH2805VFxACPrp
	 hLCuzFUinpLR7OcnK8xtJU0M4rdcI/TwCDBGPt8N9VZH3ZZdswSg7jK0IoaMjMGVSm
	 VWR7pXozZzAij+etdEA48uuU/znoQvx/ryIC+fKvbGtG08NDhEM5yfHQriNUIF2+kv
	 OE71honGBDh1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9628C380AAFF;
	Fri, 18 Sep 2026 12:59:37 +0000 (UTC)
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
 <178973637608.479087.9559251271933017728.git-patchwork-housekeeping@kernel.org>
Date: Fri, 18 Sep 2026 12:59:36 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: spidev_test: new features (2026-09-18T12:44:59)
  Superseding: [v2] spi: spidev_test: new features (2026-09-16T17:41:19):
    [v2,1/8] spi: spidev_test: include tools/include
    [v2,2/8] spi: spidev_test: add compare mode
    [v2,3/8] spi: spidev_test: allow disabling rx or tx buffers
    [v2,4/8] spi: spidev_test: don't send 0x0 or 0xff
    [v2,5/8] spi: spidev_test: send predictable data
    [v2,6/8] spi: spidev_test: add option to split message into multiple transfers
    [v2,7/8] spi: spidev_test: print TX on error
    [v2,8/8] spi: spidev_test: rewrite unescape() to stay in bounds

Checked 160 series in 4.65 seconds.
This project currently has 16511 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

