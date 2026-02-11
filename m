Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EB135B648;
	Wed, 11 Feb 2026 20:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770841696; cv=none; b=HkldVOUxANfbqKwbdOo+ap9VUCki1j6T6HzbCv0QNnPlFm9fZGKXzN32JX4R9jLBUmVYlpQ4ZzQXAxVQDgCV2Vv6V9IDytrNlOnJAPP58rbqKXcI/j9nSS3FFW7s4GoOYa0qP7dWX34FEDjBeKGv7mOBLnPVBVtI/bSRG/23MZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770841696; c=relaxed/simple;
	bh=UgiHrS35W6GS2F6VrMSw3bE0YucWGCpQtKAqJ01eDdg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YzvG26OwRMFKpextl8XX8Aqn0U0beIrjpAIe29tq0lzdkeHh8rOwWmhhZRKtJL34yf+6IM6ktrTQIbwC0nQqbDxYacD/z9nDqLjzHL7j1hG/tzS1NHabBcMjulwZslFW79/AJSwXe4zQL7LdRyMoNSPMT2T0Ob1DLl8vl7EPtz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APoTJ0Ci; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APoTJ0Ci"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58952C4CEF7;
	Wed, 11 Feb 2026 20:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770841696;
	bh=UgiHrS35W6GS2F6VrMSw3bE0YucWGCpQtKAqJ01eDdg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=APoTJ0CiJCGkeKdvptUZIOGy5TA/WqjUL07Leiijzqx+bIDS5oDR6we0h43gY1IvS
	 3gUvV8UQ+M9mZ+9vXtjJrvhs0EpvBWdWPlsaCgNPWAAuqhWFFgR+eIoQdVLdC4MX6u
	 YCx8b0E8Kb91vAL+Byf7cZAI7ovCGCswjuO4QO/p5ValD8X+zh27vpS9151XHgy8a6
	 suMjmnk/eu6TR/ypc0Wx4CQaLFZuzHGqSgzy9eDPkKXkFdb9fDwqBluSUw1YWRkvIS
	 BNnGd81sI4Dq1Q36z7uHMjfdHyOC65qZG4CecNtYbCOY1ARZqwft7eWVyFF8FldB1l
	 h1Sc7+wBc4l7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 482BE39EF964;
	Wed, 11 Feb 2026 20:28:12 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v6.20
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260209162649.EE5881AC57EB@finisterre.sirena.org.uk>
References: <20260209162649.EE5881AC57EB@finisterre.sirena.org.uk>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260209162649.EE5881AC57EB@finisterre.sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.20
X-PR-Tracked-Commit-Id: 5af56f30c4fcbade4a92f94dadfea517d1db9703
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e86dda7bde8801d32ffe7d1570fe173cab14d1ba
Message-Id: <177084169096.710910.3229098133672874202.pr-tracker-bot@kernel.org>
Date: Wed, 11 Feb 2026 20:28:10 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 09 Feb 2026 16:26:45 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e86dda7bde8801d32ffe7d1570fe173cab14d1ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
