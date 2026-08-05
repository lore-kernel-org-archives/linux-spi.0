Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B223D8916
	for <linux-spi@vger.kernel.org>; Wed,  5 Aug 2026 10:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927044; cv=none; b=Y/Y3kKXhzB+KyFobcTy9+ZMDgCX2wwoBKxkFybHGSlQMpD2jeC2oJsOJ/4PCYwI6CxKrE3ZYNPiX9tRhB1DEaZd4lQH4hQQLm2hT6H5VX6q+xybtt8XhuifVZN5k1aoKowRJ0l9XnRLoZs21b08mA7ITgipy0nZ4aIneA/UxhrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927044; c=relaxed/simple;
	bh=v3wgzajWG1QPOC+SxQJ7u1hukpgOLbzuqNGBb4KRhTc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=LLgelY8o5KHN15pYuevh5b+0aoJqu/08FPsGtz/KuptSGNg/tcsse3dNH5jupbSZ01HrqifJWFs+JC4HNh0KpVD0hXoTs0ypHiLMWOGm36D+JDB6s0vcp1mjTD2UHuOcVeytKO0QofhGm4KjtMBz02ATWky7LUK57rRo0UN1ARM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWGJKd/q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWGJKd/q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA931F00A3A;
	Wed,  5 Aug 2026 10:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785927043;
	bh=uFv4T/3yDcgEjboMoDIL1tjr0J1lUm79vvrvtRVNqFo=;
	h=Subject:From:Date:To;
	b=nWGJKd/q1niHp5r7dOPOdopaUbaPM+cZNd6J3TNaDKknlv160oLZ1IvUCcMIMZuh4
	 CrOlNcCGrJkDqJ1Kp2mNxynFse7/39gWC8Hl1if2raHk9sv1RsA5+eEhst7z/If6Ee
	 8DSbTYTtmdaq7bO+yhJ6RzQI/eixd91Z8yeRUNteDLPynb85fRFv5SJHzUJYAh5R7T
	 BmYxKGSreQ+RYpU7I+uWtOrJmOHYOpgB0jfGWodCV7YNoS73FrIjTtRpdxYWq//RNY
	 hEebWPkTn13x9vIyT3RdkYb1n/5a068UZuKS4gvxq5E+wM9KauxIWZDnYD6BBjuH1c
	 pJKL0I4/MGslA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9616A3927078;
	Wed,  5 Aug 2026 10:50:04 +0000 (UTC)
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
 <178592700309.4050767.13992073606210856773.git-patchwork-summary@kernel.org>
Date: Wed, 05 Aug 2026 10:50:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: ath79: use devm everywhere in probe
  Submitter: Rosen Penev <rosenp@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1135422
  Lore link: https://lore.kernel.org/r/20260727201543.18857-1-rosenp@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


