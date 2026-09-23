Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F892311946
	for <linux-spi@vger.kernel.org>; Wed, 23 Sep 2026 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790151675; cv=none; b=OKWlPX9G2IRjsbE0JXAgZc+DHls73goMxUS7iPAmLzk7nyAo367J0dvbKxoxoAOX50WxfYLgnxjX7+A9OIJlVsN5QdNtGnIDa1S3G0+wKyr/7ZYn75BmmXKyyhUXY5cnKIldKdrlR4n595i6v4CbMPe8ZYrJyrrluGVnoONeOsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790151675; c=relaxed/simple;
	bh=knPBLneu8xtWi6jOtwgqJSsgEFt9nCtLnroF1tVSgxQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=R45VYqRS80xNfpuaz0OLeA1oThkrUeNmcOgvNXCF3rbE9u3htd9xI9SdmPBm1iGjljkSApCXSlwWVZCfW0XuuLbO+EEL6wcS2zNPIKZhsU3Bg8xa5iEF3vtTjlWD9Kx9cKPqrsmhcKDj6/xnLTB31QdRpYxBqFC9acK+34p5A6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mf41yo51; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mf41yo51"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323F31F00893;
	Wed, 23 Sep 2026 08:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790151674;
	bh=3Ho8UIG7o5WoZEI6Rnu2Tw8GNPVI50Wae4tX8rtxTmY=;
	h=Subject:From:Date:To;
	b=Mf41yo515z5zmPYKvT/HftONCcVOGi8ubG5h8oQIytT1ezoiRb0rXuLBWuIwguDvY
	 zFI1CTHJX1B/BxNE3VTgl3TNdz6e+/gzf/F7VUBeQb7o7X3fV094lAlcNB4w2QblhR
	 HH3udeZ6KyrMhg3rIX/pXcwQ0YomIVsjzTn6z6nWNhdCXq2m3zffmvvTST/t5Qd+hn
	 CAjfkAIpCSO3YnpNiVFAGOInlxOG/XKQc3GpJKSoai8DKVrnNF4nC4jNtLi9/ybtI7
	 dSTLUdHJiRAEXAR3a1AaUz6uVE/gQwd98YbBZo/w/Hn1m0SbXEssxHi1suP8XSPVgv
	 AQM4hFuiARsNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9670D39253CD;
	Wed, 23 Sep 2026 08:20:05 +0000 (UTC)
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
 <179015160421.308215.12458913051210961452.git-patchwork-summary@kernel.org>
Date: Wed, 23 Sep 2026 08:20:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: realtek-rtl: add support for second CS
  Submitter: Jonas Jelonek <jonas@jonasjelonek.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1170728/
  Lore link: https://lore.kernel.org/r/20260921213145.671282-1-jonas@jonasjelonek.de

Series: spi: sh-msiof: Add support for R-Car X5H
  Submitter: Geert Uytterhoeven <geert+renesas@glider.be>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1171110/
  Lore link: https://lore.kernel.org/r/cover.1790065451.git.geert+renesas@glider.be
    Patches: [1/2] dt-bindings: spi: renesas,sh-msiof: Add support for R-Car X5H
             [2/2] spi: sh-msiof: Add support for R-Car Gen5


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


