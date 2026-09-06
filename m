Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7E14CCDE5
	for <linux-spi@vger.kernel.org>; Sun,  6 Sep 2026 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788710389; cv=none; b=Mmmjz/8c46xzwIjCjxzBNpMAPMvcHeP7UxSdq7dDoMH/hsBT6MYGq15iXwvBuf6mSPqgEv7wvPUdXf9TNvuqXzjEl9PDOQXn4KcyugacjDAW1QR7vuCxneDM92pUJaax1DP/7rFT1VGEi99Wi7z/9mSlyuk7owQtSbLdO5UilVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788710389; c=relaxed/simple;
	bh=8bnG7i8LF2kufFCz8kq5NbTYAryoICJV+CwhVgvnBpg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Srru/agif52tNAWugDiwOuytKrFka5Lu6CxicysH4xX976dv4krVj49NldzuLvvON8nBV0EMO4QWJfg7dec3op0X9XbAkguma0k/7yHVQuMuC8GbzHelg+IE4scTJSx3ejA+3MPUhv4xwbPhbpCN5nZxrHbbbG0d27KgFCu/hUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsGg9udM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsGg9udM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDF41F00A3A;
	Sun,  6 Sep 2026 15:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788710388;
	bh=iUF16kSQtdGh2dOYKJchbGzthJVD4+sTujFVkjoE0bo=;
	h=Subject:From:Date:To;
	b=GsGg9udMG9W+tLqwn5upIgH/OhyU9lt1HAwt3KWRK4Vp/d9mk6MLUVqrjirXI1Bep
	 aRnyOHmL9OIdL4SYLZpblOXi7I65pDF8ygj1rSj3UcYqNCVJutrbTijfgtg0/orsey
	 NyymrUgb2Vhs2QLNESYlEbkhZZE6GjjOcWjNfJc7lfMz3gyPgX6GMguIHFK4uiqSmz
	 EmFyzjwmcadVOYpzt+4LmxY1iyZbpp5KqD5gwaC2ZNgsuByCUxIdinm2PYfO4Bx3zP
	 3MJDbfy2XS4jsASPu61DK1r2HSNoEkwutWo9ZDD6C1cQ4F/ytc2Jq36gVFMnQdxRaQ
	 rgN0Ry6dLuMWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D333839253FC;
	Sun,  6 Sep 2026 15:58:48 +0000 (UTC)
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
 <178871032734.1600781.133320244683634294.git-patchwork-housekeeping@kernel.org>
Date: Sun, 06 Sep 2026 15:58:47 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: realtek: Add support for RTD1625 SPI Flash Controller (2026-09-06T14:57:53)
  Superseding: [v1] spi: realtek: Add support for RTD1625 SPI Flash Controller (2026-09-04T03:12:49):
    [1/3] dt-bindings: spi: Add Realtek RTD1625 SPI support
    [2/3] spi: spi-mem: Add Realtek SPI flash controller driver
    [3/3] arm64: dts: realtek: Add SPI NOR flash node for RTD1625

Checked 171 series in 3.77 seconds.
This project currently has 16454 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

