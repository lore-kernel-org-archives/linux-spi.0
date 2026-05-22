Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D35384229;
	Fri, 22 May 2026 20:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779481540; cv=none; b=sFgtBLJKFoqwHwKr5VnDzP8WU7G7oeQFpkAa9AnfwPUx4ofX947tVPkHb/LdcGOMm887lq9hjbkSWJj/F46q5gYmOr0eIC5/DYY6xFw9fikLxBx7yq4FNcq5Z3BfSH82lzv5U9D8Dmxyif5o/0ktyU3xoqz3GF9g90a0R0Gkmhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779481540; c=relaxed/simple;
	bh=kw164GAbsLdMBlwbVmm4pS/6+kQDh9QQ597ONWW+uno=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=C8kVqQIU+iTQZ2cRF6otsq+XJJUtOstF3UW/qsqtUCOLqUp6dhEu4C5HJezFjTIpDhnu0YlV64vd0dAhNAhS/Z/iL7eTVnNAil1VgLrRv7tSyyyICs5yOH7wanMYgQ6pNb7SrVQCIsFhrZoKKm+q4xLn+6csVi3plwsYskN0lfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QubVWlG+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QubVWlG+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5315C1F000E9;
	Fri, 22 May 2026 20:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779481539;
	bh=nxJhoH36PO9oFO4jja02jWQ/6q5L2EGP+V2e8vmWgCQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=QubVWlG+6KsVM2hIAWfSg7xc2g+fSeTJ/wF8BAkCy1h163NBD52z72ka/5F0N2Omg
	 kW3+Pn4fAgV/FJE9nb11AGRA6Jo3KyiAVSGBrXdRk3kGQL8Y/m532fcK9uC9RmCf/F
	 uNwHO8NjiYTCtZm4WluqrOQpc4uRZNceHemYiINrDYo1GAqN53WHXSFfWSwMWawMWF
	 nxM0hDZGFtP2GTduax0YwPDY6a+CIci0Uql3d+bqOrZd7ii8bgbxIKhCNtc3JHMXY9
	 BYlQb5291up1j9zubasav02wQ/duroHA5KoaNS4APXPmLrtM2TZgN6uAuYEjhDmo2q
	 YEETL9uyaWGpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9390C3931009;
	Fri, 22 May 2026 20:25:49 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.1-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <c3dfa0ed3041398d4443c1331c7334b7@kernel.org>
References: <c3dfa0ed3041398d4443c1331c7334b7@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c3dfa0ed3041398d4443c1331c7334b7@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.1-rc4
X-PR-Tracked-Commit-Id: 27cd2dde35b2c3b8659fa18f6a935c61fedee5c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e216d85eaf4ca525520ca2c0a7d99ee8639a5718
Message-Id: <177948154807.1357013.5880440416302585177.pr-tracker-bot@kernel.org>
Date: Fri, 22 May 2026 20:25:48 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 May 2026 18:53:44 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.1-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e216d85eaf4ca525520ca2c0a7d99ee8639a5718

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
