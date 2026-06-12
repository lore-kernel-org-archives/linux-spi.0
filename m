Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30E0391826;
	Fri, 12 Jun 2026 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781288734; cv=none; b=a9GICUG6v9W24Ik+HnWvbK4wIoXdJPS29F+T2/ccN6UGDVFzZh+lbHiNnnWrnUEnaoPuyQhi2VYgjYoA6d7vv6j8RE3jR1br/u/qWG+WqLzrRv9AxxixNeibwmt0B0rqhc9nkc9RfBzXG7nv1qagnfzkvpIw+8vb2guQNNy4fUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781288734; c=relaxed/simple;
	bh=V0zMIuGsDYXopElFiYSZmMi3qUhpX+oLcypCNnGPv38=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=npvabBQFafb9hDE83eHnjkxR1cAtzDqkt0YKeXQWfQ+pIPw/XPQSj4Rvsx2RoUmBXLvS4Qo8vDDLDS7l1/mYTNGCdpMjsvrDcnssIC6XKs8hsWajdD6D8KS6op1LCx3z2aHuCSxTtYq8RjvjqeOoWhgO5ZdXxBZXYC8N2GT9K6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvR3o9U0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvR3o9U0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4971F000E9;
	Fri, 12 Jun 2026 18:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781288732;
	bh=ZwxlyuIdHM5jq9TZ6UwM32UCQpS+A2sIXYbhevYjo7k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=PvR3o9U0ifV9LM9bRObu01/H58eE1uE5pg9L8r5WfikbL8I+4V8BwnhfV8pUZE7GA
	 rOsBU0j52fDEyYrI+usJxI9bCVWCsN1wFOo1fCTkjNQzR6vniRy+XTe5GDuxvRNryY
	 35eFQrzAQNKxxb+TqXwkrR127L/iEYnRowoOQruLO6bRSclSG6bGlsK4PaDBGkTMQ3
	 2UynnuzAXbo6MOSUmw5wLVKTQl3jUaRdMoAtn03pP2zbI3WcFL7DjKg89BdFtMukpd
	 KC87rp6SrLayHJhqASnt+hCN3LKfte3Bas0LMemzkHi/AVtiUce1TvYQHA5e5DWfjt
	 i0el/6Ge1j4HQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199B639D2F40;
	Fri, 12 Jun 2026 18:25:30 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.1-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260612175231.46F121AC5AC5@finisterre.sirena.org.uk>
References: <20260612175231.46F121AC5AC5@finisterre.sirena.org.uk>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260612175231.46F121AC5AC5@finisterre.sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.1-rc7
X-PR-Tracked-Commit-Id: 3c60184e39b57e5efe664fe8540cdbc1bc7ea899
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28608283615e5e7e92ea79c8ea13507f4b5e0cbe
Message-Id: <178128872866.784234.17524469831625483185.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jun 2026 18:25:28 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jun 2026 18:52:25 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.1-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28608283615e5e7e92ea79c8ea13507f4b5e0cbe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
