Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F485256C61
	for <linux-spi@vger.kernel.org>; Wed, 13 May 2026 03:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778644272; cv=none; b=A00rw9qqxJ6y/uFYo5XiazhmOzacAp29RlFVd5bhZPw4uMfHjgzxNHr6S1cwy+tubCglDReMKb4GVfkCfff7vwY/INJ1HUIKuNe28RO15NhUS8zsxHsCvNuokLKhBoe5JcZSZ8Q8HHZeLplJLnh4TMaar3kClvu2My8i48eVTCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778644272; c=relaxed/simple;
	bh=x/zSAH5g+R4Fx9vaDDrKLQsZtcmvlUE5E74XWrKUPQQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=XgYHSD+c5d0DTVvqNu6RoQ63kKe/QhTZaAf/uJeYZXi9kTEeccubjla+iDJBlGRqDGtlbe+VcKtuFpkW4pVKWw4nHirt2YwOawr+8b+KfDk3LmSmzGtaich26AvvXq3nccjrJ9AYmqajMJ6vMS9TvINOaDZYeoAX5RijQFvLdks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jp71Wtld; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jp71Wtld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87C9C2BCC7;
	Wed, 13 May 2026 03:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778644271;
	bh=x/zSAH5g+R4Fx9vaDDrKLQsZtcmvlUE5E74XWrKUPQQ=;
	h=Subject:From:Date:To:From;
	b=Jp71Wtld2hS+2fNn0pjqrlzctOBXyv7SOn8g7ZffEW9iXTeFeZKTXnBEdcIGGJHgp
	 smao04Oyh1Va3j3KlH6e9oiN4qSr3muu77r/aka00nguNAfKAC402ctNhDwUOcmrUg
	 V1iJOGiTRcbM7zmMRr+S7MyGCMrv9M5ZSRa/VFumVCbswLHFuTyeflDYRgxHkjS78I
	 3cOIcRJBGbCxV8pZS+bkAgQZlR6BE3Y4p8ONhh7+1Ujrjb1yyXIeikrFAs7bmhSlos
	 wmW+0x9oCsG7DbjYDm5UVyudRgVdxIhiUWJQkeuSmLHy9Gv0yfizI/HTec3CnQ2sbu
	 TrCN90sRfMJug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BCBFC3822D60;
	Wed, 13 May 2026 03:50:18 +0000 (UTC)
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
 <177864421731.3447242.18266068144345274373.git-patchwork-summary@kernel.org>
Date: Wed, 13 May 2026 03:50:17 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: ep93xx: fix error pointer deref after DMA setup failure
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1093352
  Lore link: https://lore.kernel.org/r/20260512074849.915143-1-johan@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


