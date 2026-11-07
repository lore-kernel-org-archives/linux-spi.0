Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794083133;
	b=BDhf6CoBXzi5UqMFYsx2VB180qAbjVNTe7vnepGLWllpQZBekO5ccv5T0Cs71u8L4uK4
	 EKxkDK98aoonqceJXTUElwP2NYAw6EBFnMQAVm3E3zg/q1G1ZaPRLmBRYoHLIcRT5ulOb
	 iQ7DbpCsWuSw1EhOG9K0xYTIX981pi4dyKjZ0bPHiF6Lli05/C9tp19VelktC9CRnvnxD
	 D11erBJ4zRWajb+iJB0Iii3l3oyeCssPD8QfWJ7OxVLukRBDEOnMtVwiOA49/1TaM3nPw
	 AcpvOgZ10V90TuoLKQReXyK4RWdy5IVLZEVJBOiVAGyV6dqhjw2mRMQ7xgKQxzDwmag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794083133;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=pToYmMBphjVU3epzzYlrvFGEReJQn885wleEBDszcuc=;
	b=m8jCanutgXs9V95v6R9VY5De4QEr/tD0LfAGO/hJVobJGVkE2X0xY6t7HC+uA9XVOEIZ
	 JdH1lSj1fMjPjEtu186Q5/BOXraoWwK23YeXdbd55PWN5fmym1ppSCABhjc0DJGHGXzRN
	 s3WkLNpgBbSBYIJxjzD34ibhV+0leRNeXXs9aqRqY4pOfX2uaoxx7mtoqfraOozzXuIMT
	 TGNbnXFoBheqdfH/BKS32FQvo0XvvUpWZYIeIpOAvcpesKDobtXYOm96K5zyxRY2KOXbA
	 65EYjPZ3Yz4CgDEKklMeNqbhUtGLDWESTOpcQysXmr1NT2JwkzpiyWbcHVZvyt7ZbUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BsYJkR25;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F072606D807;
	Sat,  7 Nov 2026 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BsYJkR25
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16771F0089F;
	Sat,  7 Nov 2026 20:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794083132;
	bh=pToYmMBphjVU3epzzYlrvFGEReJQn885wleEBDszcuc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=BsYJkR25n5q5nz5xwXmNsUxEC6yQmFjAZOqRi2VRdh0plSLEfxsXHQkQj4ANHmLQ7
	 S4bkvyjAlgELLIoOopkV50Oi50l964cmz+xXHRV08oEkCciEY1UqiC8aoj1Q25S7nP
	 rMurRO5ieGZotiWh5yvufIqhLHe7DxzKbopMMJVId0Vtb6xqdaggLkuMMhOsAwf9pN
	 62iqw7kYcv/VXGqrdWcl4CiZl/C9obBDMk/kOxXtzmM0FDWsz48RElE9ZVdzzgyMdO
	 sq248ypgKlaIg5qmZFazqycZO7/7PnVanR4WYfqpAgeLfUhKQx8bZYeh8AXbwXHFAk
	 8BC/xvYK9mKdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D8180380821F;
	Sat,  7 Nov 2026 20:25:32 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261107113357.5BCDD28F332C@traversing.sirena.org.uk>
References: <20261107113357.5BCDD28F332C@traversing.sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261107113357.5BCDD28F332C@traversing.sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.4-rc1
X-PR-Tracked-Commit-Id: 059518f775baecc9803fc97787bd0b17558f8047
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c1c70a8431be6df4ada55ed4930ea9bac9baab48
Message-Id: <179408313163.1325067.12119711532236229290.pr-tracker-bot@kernel.org>
Date: Sat, 07 Nov 2026 20:25:31 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Sat, 07 Nov 2026 11:33:18 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c1c70a8431be6df4ada55ed4930ea9bac9baab48

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
