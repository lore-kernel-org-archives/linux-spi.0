Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EEA35B654
	for <linux-spi@vger.kernel.org>; Mon, 23 Feb 2026 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771844205; cv=none; b=Mp2SBbH2BN0mKqWNNaI/K7EUXIkWxHhRZ+XnmVAq5IN4uPF3bdB64iAj+Z/NkOGpOr6gWShXQJOtTIOtWD+0Ciz5c1/dEVF4LcmuuEJtJhVr6N4ge/lh5LgS+neaLQPVlbQrWpgwRyMTP1MubcdhptPpesBUyD5X2HSvbcU/D5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771844205; c=relaxed/simple;
	bh=SpgkO7reXYEE8IK7r8ecWpPSSvT0mFRXGbYVPM1xJLY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=cJicdJ/P7YTdaxMZn4iC9+/dgy82R9vSvJB3IT7gMPMLup0YH2+rJvVAXvujrL4EPCAzZ4898t6iVa+/0/BBsjZOe/uZ7oFdIHV5scc5UpEpyrQvVpCC7eBhhxDXUqehq8kTQkqIcH2yFIIBXJgVnZxMEu5L4b37fk3aXqoaJGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJLuE6J7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJLuE6J7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FBCC116C6;
	Mon, 23 Feb 2026 10:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771844204;
	bh=SpgkO7reXYEE8IK7r8ecWpPSSvT0mFRXGbYVPM1xJLY=;
	h=Subject:From:Date:To:From;
	b=EJLuE6J7GbCZh7usXMVl7lqY6rImOxIYLlgPVLRWNitiuI70Eag/H79Al0swhJUMH
	 Kko9bWUD9uqbLjwqMyaoYldU+2F5BKIDOZicTyAI1978E1IF+Yvjr4wtfy395GpwTD
	 SjnrCsaJpMATtdZ42eKP6Xlopzki/z0r8H3Tdwu5hFQQHRu2Cuw5Apl/OwmOi315qm
	 Xwv0rTuZD+fUiUs3jY8FeSuZwYLFNUJ5HqMYRzeTpcqBPsEnaWWYgZFa7SHNnkdjoX
	 Kc6HakeWIlOdFGRTjl1axZIeNMvTFsC4R6v1fDqqyEaLR9dWGhLWnvnL3SAfRrbhQl
	 as9l5XvZTxMzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FEC43808200;
	Mon, 23 Feb 2026 10:56:52 +0000 (UTC)
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
 <177184421083.2264806.4988893398147673436.git-patchwork-housekeeping@kernel.org>
Date: Mon, 23 Feb 2026 10:56:50 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: cs42l43: Don't support sidecar properties on device tree systems (2026-02-23T10:07:17)
  Superseding: [v1] spi: cs42l43: Don't support sidecar properties on device tree systems (2026-01-30T15:21:49):
    spi: cs42l43: Don't support sidecar properties on device tree systems


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

