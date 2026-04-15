Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662A7390988;
	Wed, 15 Apr 2026 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776290500; cv=none; b=pIUIYMdVckQU7sGNDSrspEYuo979vt+BOGoh2DWBfPEs27d73CBhzUTY+rc+CH6qVU0dAUJS78WO+5e9EEQIp2zqKfC7zwsqzZqro/03S1IwLSpWekZwQASEew3o6gr25GsdFBaYmEDvULk7IDqTzn1ZEoIW63Aydr61IcUzIUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776290500; c=relaxed/simple;
	bh=X8ot+w5fN5XIXnKrF6idfQJfV7u5DvKeJl+GDOGfSSc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=COfqUk7Suw3qLDzwHGUMllTqXXlmtfLo2Wd4DSjjYzkFC9KMMOKpF8a7Ypyw7xpJp1Vd9uJU+Vj0A9n7NUE1toJ6SreF5R90JMvDXnr11QMJiumGKts1b3LofgqRYtajzWjXJbjPPP/3FMcikhcTKfvr3Mxvv1joUQtrk1IT10U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xqfo/MWu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xqfo/MWu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFD0C19424;
	Wed, 15 Apr 2026 22:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776290500;
	bh=X8ot+w5fN5XIXnKrF6idfQJfV7u5DvKeJl+GDOGfSSc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Xqfo/MWuReXWC5SbFqGB9abZsuMuhYB+QJzAVZeQbtuJWQBbHoFh6GaCWytNmK3cq
	 bHz4xCEM+3zqVOlRqw/Vcq0KsvccZ/LqmMiVfhgIc9Q79jr8bX2J60lh6E8F7iGtai
	 fcbAAeuwKNBm3uxLJEPIbDus11DGvaKV0WFpMGopHtJoCZngPo9SOVy3k6XYOj+PMR
	 vLFqHYlL04a9NgW781dmEEWu8nwqd5bdBX3jPQk7ZX+T7lrIRZ/4tFpXYHA/8FsX/Z
	 xl0PW5ksn6Gq7sMMmvr+YtWLeOsYgQFs7SQMmEPPWTAghQEX0LJZGrxAO3dtNa03A5
	 wopnLYQDTDTxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9D69380A964;
	Wed, 15 Apr 2026 22:01:10 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <5dc2e23847a30ccbc6e1f4a494412157@kernel.org>
References: <5dc2e23847a30ccbc6e1f4a494412157@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <5dc2e23847a30ccbc6e1f4a494412157@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v7.1
X-PR-Tracked-Commit-Id: c4c3fc872d2a05bf10372233c98e81344e685cdf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 405f6584d7d0fc46534fd370e374630283dffe60
Message-Id: <177629046971.2457809.1298877949678606782.pr-tracker-bot@kernel.org>
Date: Wed, 15 Apr 2026 22:01:09 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 Apr 2026 17:09:06 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v7.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/405f6584d7d0fc46534fd370e374630283dffe60

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
