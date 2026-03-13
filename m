Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C230B3CCA17;
	Fri, 13 Mar 2026 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773423181; cv=none; b=PCsa+NzMsnn6bqA4zJ2WsjgMXG4+bbAjFf0EM1GwGJaUtQRSIOZIAP6kWyN1KokiCHW6TevOvANuUYHgxtpVd37unDhdAKmLf+9AtpekAiUwIVyBqRVBhvISmESRmae5XYpLTQNBpXGeCW2rd1GDzX7wjzqNRUiQyIBnzkaL/Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773423181; c=relaxed/simple;
	bh=9SuT5xpDvkFjO95MggT4M5e1sZ3+DKYN5WEx4HK/AVw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RNgGutR222Dungsj8obH1Uz10Yb9TrbXLP+Z4APsdYNgOosjQGZOS5Hbc8eSmaL5SXJtfAPHixpFfCDZHA3/F6r0bMKMw6GopVclDiO4XwyNUHuSgVmsWRtGNYzAvOlPxw0jZcjDnET8stapSQmOq1NUeS58em/n8rCHFkKKBV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWb/VyAR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWb/VyAR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E071C19424;
	Fri, 13 Mar 2026 17:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773423181;
	bh=9SuT5xpDvkFjO95MggT4M5e1sZ3+DKYN5WEx4HK/AVw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GWb/VyAR4XN2bsUAzk5duGwimkjP1+UmAt6hKikl7J+WFV20IRsgJXeAwEMZ5EFOa
	 fxLTh6DcvGTG9bh/zKcaJX8rPhb9cyVWFdibzjes2HwzjLC0Vl0kPVVUrjedEjwnbh
	 jsP+mWn/aoe0StZ9Y0l11LkCMRAY7ULYMKW9ptVkp7SreVAYonMk3CuQaDEx53BdTc
	 CVCS2N3uUIBrOmOCGiwommLgxokMBA2dJzZSMm8U6IUzclYsLru6Sklq2EQ5mdHaEA
	 KWDlHsZOs3+e4pB5CHRz7pW4brzfKJAlhPBV5npfMqSg6jckTJYLca/FKI+Zfn6ah6
	 g9BgWDRdHJS3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CFC53808200;
	Fri, 13 Mar 2026 17:32:57 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.0-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <6c3c2037d9b46f47a5e3416071f0ffea@kernel.org>
References: <6c3c2037d9b46f47a5e3416071f0ffea@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <6c3c2037d9b46f47a5e3416071f0ffea@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.0-rc3
X-PR-Tracked-Commit-Id: f879365c5bb210ed0d0b0aae1a0202d0c0b4b9d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b36eb6e3f5d8d48798617e554fc886d277921f69
Message-Id: <177342317602.1438840.4842626861835892064.pr-tracker-bot@kernel.org>
Date: Fri, 13 Mar 2026 17:32:56 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Mar 2026 17:06:52 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b36eb6e3f5d8d48798617e554fc886d277921f69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
