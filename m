Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920BA24169D
	for <linux-spi@vger.kernel.org>; Wed,  8 Apr 2026 08:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775638691; cv=none; b=PZ7mzTjrdhM5z2uAZgINz2iwPI+6RPfCg16ZHnzKONrK0oO4Zvbay7LLs4MP2JAJMHyNJPnOYHfx2dlgbhU4CNJWZjP7rfvapoxqv+82BpmbH5aeHUdRNebeb5sIEyescQIyPYvG/Qdb5guJHrsJ3sAoHYX+umgd68hA3LGI34A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775638691; c=relaxed/simple;
	bh=dio5VlxRp22V5aNKHS38iUNxtnWEIktIM0scGW8RinU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=f3dsLjdRiiKHi7pFp5F9/KLZ+TYT2mi3llCjFkp0fs97AnHJlHmTGnmtb3A++YRFO2vzqgk42sQm9En01o/eoECotc+dhOw2RAojMet/vpvBCRwNoOxQl8I9zHEMe2jR7odAwzouGJa+7HXh4Ge/pgaoyltO2zS+/WIPiMgMNOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6/jHMgF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6/jHMgF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3A4C19425;
	Wed,  8 Apr 2026 08:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775638691;
	bh=dio5VlxRp22V5aNKHS38iUNxtnWEIktIM0scGW8RinU=;
	h=Subject:From:Date:To:From;
	b=q6/jHMgFx71vJ4lG0QLI7fBbAHBO69eLRHtBCrUC919PuZandAN8ULW5u2lJVB8ak
	 Tvfh8fzGOPnVrzlYQ1lLr/qxYx1hrfzmtHfFW9twQmJQOKR9eQqoNv/J/0bgbyeTYc
	 4emPubUgpiokBOIh4/0K2FT2WkzlTK5iO2EgRvvfvK7LFIZEDOT8PKtXdowmLMoA1V
	 pxNN20o2gg/SAy6ax9zmhLmTSrxOmHIfGNbzDTZSdU7LwmTLOkgU4ZdyrgAonot8IR
	 bGLEHJ7Ll0sX6lyDY2/9V6Yw1Lg5vkfpSpl74ZQZlodrwqY16WMXNdhOh+vTiw3i7W
	 9fc2CK1irtQiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 72DEE3809A29;
	Wed,  8 Apr 2026 08:57:49 +0000 (UTC)
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
 <177563866800.161907.9507661536533099946.git-patchwork-housekeeping@kernel.org>
Date: Wed, 08 Apr 2026 08:57:48 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] Add Renesas RZ/G3L RSPI support (2026-04-08T08:54:13)
  Superseding: [v3] Add Renesas RZ/G3L RSPI support (2026-04-07T14:57:49):
    [v3,1/2] dt-bindings: spi: renesas,rzv2h-rspi: Document RZ/G3L SoC
    [v3,2/2] spi: rzv2h-rspi: Add support for RZ/G3L (R9A08G046)


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

