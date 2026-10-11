Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FBB448B82;
	Sun, 11 Oct 2026 18:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791744957; cv=none; b=ujaqm2Zu4+fVq8gO8DlnNJfW/+JWMoymGbRVxOkxRenfkjPeIx1s030mwvnf4/YVhmdfBOElaolxkWosOLabynqxsYUAj9cUO1AJKANniyOPEQJtkpQTa3ItVw8cJyylHrcd5mdngjcqMpUJC32bKkZ1gtROqizVCW6mVQLDjPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791744957; c=relaxed/simple;
	bh=D+1fTIcwE1eEJF0ub1YTYbl6OQudXam3c9TlRs/vz8w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ply4GcXSfUc/1b82WCjvu+/fLasc7+SPPvZWEnlo99AzY1Y/TzemJAXOoEtWnprzD/34ItV02lcM7O2kXO6RozD8TSLcCxqLD19SVmo3PqV3YEha9EqYQQ4CMsJ2f+L8CEUW36aHo2PZypFAsrhBvuOJW4y/OLoNUULVY/ydRyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbMtC4cp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbMtC4cp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BE91F0089C;
	Sun, 11 Oct 2026 18:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791744952;
	bh=1jVAn5ocjJ1joZPK7i3aLTOY6NSfevVY4gItLWH2lAw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=NbMtC4cpu27EX/LDWIww7fAJlRy8jXz5YTzdr0kmIrYnMCc4Msx0cTQySlJaxiNTL
	 7EpSbkxhAx2LLdHhpkRDnQdSs5HSNI+VkFCe9vvPavU8tCsZZVGa5kR2Wht4anbObe
	 tz1JIygXgjhWhHTJMUMAXX/fCF263IOnU5sgJB/eYVfjYnJG3Ua00nTKr0MZTRnJAG
	 nJDZ85wSgdhDFJB9XphkWYTo6YpBxfvobFfPKELBvTuoxuUgngWyZrbb3nVJ4nFRkp
	 b6Q9scMp3r+HujNUkFQnVOBGPMMF/cwYiZsbKb+WynUVbeXbnsX7i6xACChY7iLX+b
	 Hfd5GqlsdwGnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3EB38119DB;
	Sun, 11 Oct 2026 18:55:52 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.3-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261010234903.606031AC57D0@finisterre.sirena.org.uk>
References: <20261010234903.606031AC57D0@finisterre.sirena.org.uk>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261010234903.606031AC57D0@finisterre.sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.3-rc6
X-PR-Tracked-Commit-Id: 00765a3467b992d0eb56704a28887256317eb4bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f47959816751f02a711aab27cf1c805bd4964819
Message-Id: <179174495081.2141808.2654921757405291769.pr-tracker-bot@kernel.org>
Date: Sun, 11 Oct 2026 18:55:50 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 11 Oct 2026 00:48:39 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.3-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f47959816751f02a711aab27cf1c805bd4964819

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
