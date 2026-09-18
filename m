Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91D150EC11
	for <linux-spi@vger.kernel.org>; Fri, 18 Sep 2026 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789747396; cv=none; b=gFfsKZ3M9jH3PcRwNGpeANn2TbChUghRltp0S0L1sCEQ9csfAO8WiIpGKpQAb2Wb4lxM6NvpySFnC/izt0l/SvEykMhyXIUIS+9tDo8+Lz41eeiiMNdgrUu26gzC2miiAw85mgaDQYJxaQQJdkIq7NLefeHj/gVx3jHxD/GmI+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789747396; c=relaxed/simple;
	bh=aXjjbhoLPi1eVxOp7bMyhMtudC43BYMnM+5TGhY1YoE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=HXcYDqyyii9fN9uS+Lf1hbiUdKoLHdPAaQUxx0NIs3j60vQ9f8/g2DY82touNbLu/1vYdbjdjy0G3vPPRuIMaLvzDp0kNuza6FCF1oI2wgV2j5qB7nryI5/eypTkBUf0tkVzU28DuhBIUE81SIyWDChLy9JUCg+sc1uqDanwVg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTGINPA+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTGINPA+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556971F00898;
	Fri, 18 Sep 2026 16:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789747395;
	bh=HLZv5jSQSFzYzjrcsO463hkWAQ/AjxvO0bLy7q3tcsw=;
	h=Subject:From:Date:To;
	b=XTGINPA+gaYB3Trj1ZyLgaiT1ds7yTHFojvQ0wGdolQdA4zNzpyn8hJZVMvP8Iq44
	 OGVo9r24fWefvi0b0Gc2q0BsfOtKum7fq2ZCzo83Hr5k/hdwo5aMDUcIcAJSgCxkNk
	 XBFUswwmWP2mWZNiuK1ScxlWoPpUrh9SVG8NxElTHNaRfmYYlUYQJGeqdpLIWYUN35
	 TKszwkF/+eb9oyM3wbF4regomxp2lM27QvKUzRCKLEkliNi04CiqwwzYZ6EUYo5NYW
	 hyi/yPsiRPIXssD0c3sv7Lgb+Elpg8C6YiE7l5lQPINCONUgRh8mjdqqJAgCAnWfJJ
	 RaWCSiTjscJow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 963A6380CFDD;
	Fri, 18 Sep 2026 16:02:09 +0000 (UTC)
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
 <178974732811.1022098.711479859478904123.git-patchwork-housekeeping@kernel.org>
Date: Fri, 18 Sep 2026 16:02:08 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: spidev_test: new features (2026-09-18T15:22:48)
  Superseding: [v3] spi: spidev_test: new features (2026-09-18T12:44:59):
    [v3,1/8] spi: spidev_test: include tools/include
    [v3,2/8] spi: spidev_test: add compare mode
    [v3,3/8] spi: spidev_test: allow disabling rx or tx buffers
    [v3,4/8] spi: spidev_test: don't send 0x0 or 0xff
    [v3,5/8] spi: spidev_test: send predictable data
    [v3,6/8] spi: spidev_test: add option to split message into multiple transfers
    [v3,7/8] spi: spidev_test: print TX on error
    [v3,8/8] spi: spidev_test: rewrite unescape() to stay in bounds

Checked 160 series in 5.07 seconds.
This project currently has 16520 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

