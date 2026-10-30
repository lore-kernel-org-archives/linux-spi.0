Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793385356;
	b=ruXE3gUl/TOCoJhfjHM9SgaeMnOa9YNakuLV4c+xTSrv88p72dTNs3E8ycyOPAfOaZuX
	 0TajqY0CuHGjkfJMgxgiPLjKZ+8nD7B8h2UmZ5OQyXL2uwVCnSa+3k570zUR1XviP/KVq
	 vnzbTw4G2cooZqIrgxJeuy0Kg6bc2iBtHoMcoBG35VAi3O4JpPqnj++MqgYUXRC76Dk2O
	 vUoVlUoVfYMSMxbe7jbFKMm8DZpcXzmpOlo0vmpzTA1VZB23/OiL+yilU0JYyvaU0Zjzw
	 nlUcuJh2+yrTgrgpHJlVMxCmhYxDntuWTPrXnUrG+JCg+s+OUwYW3FCtbJLUZrnTpRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793385356;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=TLrNhV1mHR/Hf+PB+ygRUyNXpRfugNyOeP/SgeOvbMY=;
	b=z7UKdMyEiU+JrkgIEl2d3krkWDvemUqZDXo23ngVKYQN9+0OnW5klkfUK5VsFBVtBGfx
	 0dq5kM6B3fIlFnKxmB12/XleqT26z+5G0TJQfOXUDMTyy+eOTmbhxQu06HlDBlVALreMd
	 ne6YifaLgI8YNY2FoIGOeGu7Oi87j7FdAp++I//oTADlRKnrcZjfEJNTDB9ouuO+O569a
	 LzP7Mto2546ohWRoKwVRbieCmifxQskoRqSWFTna5sDPyz1nGX/Jdv4/8bcbMg3PS10AH
	 TfbpMPFkGvwrFd39k/CNiSMQQoiL23IOjSa7vQmn+O1iMuNsIjYnP1yBlFWUVuExRaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFGyie4+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670F1606A325;
	Fri, 30 Oct 2026 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFGyie4+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4171F0093A;
	Fri, 30 Oct 2026 18:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793385356;
	bh=TLrNhV1mHR/Hf+PB+ygRUyNXpRfugNyOeP/SgeOvbMY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=iFGyie4+y9aYlFslzX3/OyHBqY+JtA4mZj+WKYlS7tjjRKP29LhcunygGY8g9jT8N
	 06OjqHzDHqIt7EtXophL+vHy1sIFu/SvMMgkxOyiAVN0hlcAnPCZCXmKwQyOv4nByf
	 FE5Kk6+yPYvWqFTnFAaUE+krGU+XbXFLcj8SrsYKOtIRYte2k2MTUALxbNIBxwMgow
	 zg+ojakBupNiQDuC+y6hMrSPHL+H9dozmI5KmXXaDVoWIPVEMZqp1Kzo710bk8x3Of
	 9Cfvl4pmctPs6tVjvhz1Mimi4+IKu4I8BbUVCZz1ajVrf/AWHDpXK2ZOpmDstNquOu
	 85Bdh0nCRLu4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 030EE3800473;
	Fri, 30 Oct 2026 18:35:56 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.4-merge-window
From: pr-tracker-bot@kernel.org
In-Reply-To: <5e5b62bd58db33070504988e42e31d6c@kernel.org>
References: <5e5b62bd58db33070504988e42e31d6c@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <5e5b62bd58db33070504988e42e31d6c@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.4-merge-window
X-PR-Tracked-Commit-Id: 7da2aca123754c0e06092bbe179d58078b58d8d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: abf8c33470f78e2226ee3dcdc69004660020ab47
Message-Id: <179338535448.1709878.1347548445939407628.pr-tracker-bot@kernel.org>
Date: Fri, 30 Oct 2026 18:35:54 +0000
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

The pull request you sent on Fri, 30 Oct 2026 17:10:40 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.4-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/abf8c33470f78e2226ee3dcdc69004660020ab47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
