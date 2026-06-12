Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7867333D6C0
	for <linux-spi@vger.kernel.org>; Fri, 12 Jun 2026 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275240; cv=none; b=dUccB4FkYdWU49+i4Iwsb8+36sJ6Y0x3xCO2zDHGAzJy4VEbn9BtJ589I/t44G6IQFsD5BHUKac7UnW4/vH7gZINd+YpIoz5w+yv3I/3etM3vrGdoG3FgI2BKcgQKjTVGYiUcOlqjB+CDGC64Vg9nttn/10X6P/DIQub/9yH/Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275240; c=relaxed/simple;
	bh=x0OGyUJ6m4OX31IViaNxpgoWdyEos2UlCTxh39am8a0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=WXypmQ7wGVSL5gQpmsywSqUNfgUkZ/LWJbnteEyXk4VnR6/7GhLtQrbP3CUhoiRYOgW33GPSakVkxsf6jA2S3ZKcciD8uhyrVdVqgG5ymlHHh7vDxqrDA/VgFuWQyokjYLI9AISB30G4a9eE1ZmEoz/6RgH5/UGrmrVj0dchEYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Te5g6lh9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Te5g6lh9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229301F000E9;
	Fri, 12 Jun 2026 14:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781275239;
	bh=av7qM//qaGYRixqkEciUO35QJ+YgGTaR0kUgP6m/YXk=;
	h=Subject:From:Date:To;
	b=Te5g6lh9tAq8hDy77a2xxlEGitkTg852HVw0EiMdIwmm+eb1IWf+jm3X6BIYTKcMZ
	 pGZyo5tH5xvgYKHyWRouhLOQoMkZ8jdRRrYGPAfD4dyOU6b7a1VI+CNt2yRUqWbF0a
	 WOKqrQQdrZlGbcV4OU9t45PEajLudjgXSqbv36vcg80vXO+m8IDLvPaHeeSAYR0+WW
	 4l8FZU8yVVifXhim7Wv0f0z2o1gYK6PAd/N+GRzFtLQ+RqX23U41CFAgQz5DyUzy4y
	 1y9fiJC0b8T9srxV5kUNtoWe/7+2Qahg2cWchFAlM2cY7T4SNc8EH8ujDJiaKvqVzU
	 LojlhjhLd6JPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1C467393108F;
	Fri, 12 Jun 2026 14:40:37 +0000 (UTC)
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
 <178127523562.695131.13677970773453697907.git-patchwork-summary@kernel.org>
Date: Fri, 12 Jun 2026 14:40:35 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: xilinx: let transfers timeout in case of no IRQ
  Submitter: Vadim Fedorenko <vadim.fedorenko@linux.dev>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1109556
  Lore link: https://lore.kernel.org/r/20260610222843.782337-1-vadim.fedorenko@linux.dev


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


