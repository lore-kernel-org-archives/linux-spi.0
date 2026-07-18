Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B470C282F2E
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 22:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784412039; cv=none; b=l4vLnSiuqoggwGLlwabXJTKx5JRg+PgEfujuGSmNGu74jWAx6yudFUBE5VtQpzcYk7yRConTolBZIbrgwwzHkHdBsHC35S4/ymLJYcr9brX7mjoRRzD8HCCqLGkuyOHCH4RA/JAScw1OE6sqOYcEyzSljWMv8DtJT+kR3eoIv3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784412039; c=relaxed/simple;
	bh=z5KxPnv1ElZ7PxzESX0g0q+PPRzFMIJsWkKFK26l/20=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=fWtI8fDirmPQ3H9leXFbQbSQFiL/4EgGZdx2LthEsxG4ytcxrHonH9rv39loFTBJfJ50gz3LOlPDQVL3529NeI1aFw7fi2J1ovvVta4/TYtTLipEASO9bzrZnwFTSNXQIAGZQ8X9mnidi7rHTQNnknPOk9/Y+vvdm7HT0GFo2Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJ+Zk4+U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJ+Zk4+U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677B11F00ACF;
	Sat, 18 Jul 2026 22:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784412038;
	bh=VcN+tYMMoNJolDEFbvEcxaF9ehl8srIIJh9Y+ygDhSM=;
	h=Subject:From:Date:To;
	b=LJ+Zk4+U7k8fO99iUZEzoxJFsVtlvrcq5uHfEOLH3kKizQo6Ytbn3iobzOrxw9082
	 p0s+zB7wpfvwZ9u7v/Jqg7EIIKy7n6a5P59KxDkWPmL4HA+jY2SXWUPNuVvSOreYat
	 Lvh6FUt9M0HkyGa/jLrFecTHzEzM8G6CxXPQDq8j9zdxxmtLI1ahE/6Y4j2hZuSBZX
	 eVjoBx5nYqsaYIXvGNuOSXREuISgEN4ajaStOeZYPSGZBcgd/Px29MpWrv+D5Cg1aQ
	 3EwyIwIfPWa7YJRJKDt1CNgn+ZVA+R5lRwtgVFkLC++yLwSeqcIX0IThZfE4k57c6o
	 r3pUclDZernjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1C56F381197A;
	Sat, 18 Jul 2026 22:00:11 +0000 (UTC)
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
 <178441200953.2590353.15933834060046033230.git-patchwork-summary@kernel.org>
Date: Sat, 18 Jul 2026 22:00:09 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [PATCHv2] spi: orion: use devm_clk_get_optional_enabled for axi clock
  Submitter: Rosen Penev <rosenp@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1129132
  Lore link: https://lore.kernel.org/r/20260716231411.1737001-1-rosenp@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


