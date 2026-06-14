Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47E12882BE
	for <linux-spi@vger.kernel.org>; Sun, 14 Jun 2026 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781433609; cv=none; b=i5QzZkwVn6+3U9O3jDav4dRv0wyK9l8ZhwRrsRa+0yyxbNDL2Tq1XumV92YTjPkehInZOHuqoF9C5l9inq5gUn5u9+BYKgHyNsfT/c7vfkBEefGnNz0Kk6su9d5T8McM6gWKNPmIpxiqJXp4hTlN0lJ5s2NjSngyW1nV5TXgffU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781433609; c=relaxed/simple;
	bh=KkZpBt8rY1AzzA6V6YEA76pr9Dr4ky8L8fJUCkpbrZo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=XVwdRMS/UvD/EO87oX8RrADq5oEteuAg01ysh4heUVB0WBL2/7Xd+NejGWgMj2ZyL99+7CW0leAJpXaQ0MEDLzrnJb+rOlYxB0a5OmAFQipF/4tcFgRGiWu7ENgG6oTTyJZk58I4RTtaYn/Wh9QnCGK0/uE8M+7f513AkGvKGSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ykb1gxAi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ykb1gxAi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599141F000E9;
	Sun, 14 Jun 2026 10:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781433608;
	bh=58yikTZRB+GGtsKwCd3yZ6GYCiZf8iNhoJs9hYOpSX0=;
	h=Subject:From:Date:To;
	b=Ykb1gxAikU1FpPjHgPo4SPB5X2VHL+cQoTY7Lq+VZmTJWRoBjSeLFP4/QqkPKvSct
	 YeQImcglrl0quQQDxgk+XOyWTPFe+Ey/zsjtHfT5a+O18Bxwgf35LrQ6cIGLEFP+XV
	 Ez3I57Zy876sK8JjCjdSOqO7uAovV0N1GmhqUV3ALpxgUSTzZBXiQk/VTebtHD3QxX
	 hrsh3l8Gvs7Dg9Cx5m4+CE5e0L2QT+eHBOlGwd0LYUbMsToCxi28rHjtJ5OlulBECh
	 wmb/8cw76UkSdw9SL3b0jooSMnNEk2iBiPGLATx5vTrx3ARc1AOcdGzpkBv+LnMYoL
	 7KNlYmCiVPhGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 594D53A54A3A;
	Sun, 14 Jun 2026 10:40:05 +0000 (UTC)
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
 <178143360399.1752409.13634343522345880687.git-patchwork-summary@kernel.org>
Date: Sun, 14 Jun 2026 10:40:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: Fix mismatched DT property access types
  Submitter: Rob Herring <robh@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1110888
  Lore link: https://lore.kernel.org/r/20260612215017.1884893-1-robh@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


