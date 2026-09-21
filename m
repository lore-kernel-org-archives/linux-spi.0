Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F20472099
	for <linux-spi@vger.kernel.org>; Mon, 21 Sep 2026 10:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986080; cv=none; b=BvPxXJzVTP9eyBrhvhU8O7RPQye3810swfIOd1ZYib50t1tKftZYBzHW6zpQDRM2cZEOmR50Ma8vSK66Lq3yUsRo9s9PCvxpX7aCOwz4hr/xH09l4ND1iB6HLNt6WElkNUKNl5oPmeunlv9Q8vwbuHUVvHY0gEsaJbAXnfSGogs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986080; c=relaxed/simple;
	bh=7YMGKleBVNbVQV3tZ+xXmSe7KGuBdpquw3sgz+sMXZc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=LBlvHwup5p8e4GKhdJOHrJ6yxRSxGfZHn8oWp8Ja012hZzTh1X97LoQw0hxzfY6IO8QkcS0C086PDNODx2/tnXchUj8yk0qeWstdnLPEh3BWryTWM07ZuF6y2tNh1zunpRJb7z0ik3tP6BU6Jqu3dducO9MQYKF6CBKjNXqcZek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdakSAl5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdakSAl5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24E01F00893;
	Mon, 21 Sep 2026 10:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789986075;
	bh=V6XtDPy7649Qpet6xgBW0rrEyNPNgSyerIpIjDqWMik=;
	h=Subject:From:Date:To;
	b=GdakSAl584jf4JB2EnIAggNvuC+pjJmZ9t26A9pGkx+sJvSelzwHDGduSS4JWhMsp
	 z7tKXoRnriN1Ypi7rC822YIaxXuPbopiOTtysqE1OFjWfrscbh8tCAGCnpIk/zsIUB
	 phrPsjpfAP6XuoC2O3WlHwIBAW4izcatH5pY6aJvBBhoeWgSuzbndldbaR4j1Y1pGF
	 isGuFphd3BC7gcX1nxrcqt/eYdD+VIkWm0oDJqfe56x8iRPLbjKX+9cw8UzvRKJNtA
	 SjK0dJc2FghhliSTXH5D7B6G8RGwUGNTqql0DgZQHm7LBVbayUAMIvdY0pNjJZS2sR
	 J2uXKMFjCgzAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9603C3926391;
	Mon, 21 Sep 2026 10:20:08 +0000 (UTC)
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
 <178998600726.2486548.2329791111233597936.git-patchwork-summary@kernel.org>
Date: Mon, 21 Sep 2026 10:20:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-qpic-snand: add qcom_spi_config_page_read() helper
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1168986/
  Lore link: https://lore.kernel.org/r/20260918-qpic-snand-config_page_read-v1-1-a686c4657857@gmail.com

Patch: docs: spi: spi-master: use literal blocks for commands
  Submitter: Randy Dunlap <rdunlap@infradead.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1169996/
  Lore link: https://lore.kernel.org/r/20260921044713.93122-1-rdunlap@infradead.org


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


