Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5668F18EFD1
	for <linux-spi@vger.kernel.org>; Tue, 28 Apr 2026 03:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777347651; cv=none; b=LuJm9k+AtL9oiEpgNyEiVcCnlRhXGp9WiqBkMsxhNztY5qJFQuARbEFZy+3HC59ZxK5HZMSnDDGE/IoEnxBjruoOV5/+T3C15XicpBeqKCQLEy4H1P6liAMCekRPXh2dUw2HuwvM7D4hAdp6pOktT8BozG2B3rBmWMCBQXQMuzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777347651; c=relaxed/simple;
	bh=RBKBIYvC7pwxWYfLAGtZD2k7P61BIbnTAel/4ZEDQLA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=cU8k6qrZKxxdJZzHq/RkDPLinOcjN0W1gx8SklnDE8hoz95s86T0GA9R8OoK+MWqnc5cMlTvFnbWu2r6R6tZRI5bF1bOgDXbrofKVScAcCwDL5gWu/7brNE2Mg9nxNAGkXaz+jA/xwFEAH9zkugDigVbUtXiSCn3BBB6I3RTtKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emV2wqxR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emV2wqxR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81A2C2BCAF;
	Tue, 28 Apr 2026 03:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777347650;
	bh=RBKBIYvC7pwxWYfLAGtZD2k7P61BIbnTAel/4ZEDQLA=;
	h=Subject:From:Date:To:From;
	b=emV2wqxR4nlAtLg5ErrG9ytrMsSDD0+fD0OzHy8abKn5dWJrdp1LGCrczT8+W0UwM
	 1h8lyn8VGsT+GUlhVDpuXTe+X1/FpzFoocQnhaSQZWBQyKsAY5GEUJTcO2uDt3MyMQ
	 XKrK/pVz5SI8YeS8YcpCjvaE0KwTmqb7h45KjiBZc3qoEYu+iOCghtH5ApBdEmFDxz
	 m4RvzGza2sTguJU/urjTQK330IulvozYeQpNH3mn5yrYZW6GeQCogLYe0ZRzCyRoDU
	 9FhtHg03iuy1IG5OpiBtxZdnegGzUGH4sbQdVEH8RVSJbMaMncv0FDF7fqO3LkGe6R
	 tTBfjQrx4PVBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 42677392FFDD;
	Tue, 28 Apr 2026 03:40:09 +0000 (UTC)
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
 <177734760767.229273.6544188501592103136.git-patchwork-summary@kernel.org>
Date: Tue, 28 Apr 2026 03:40:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: amlogic-spisg: initialize completion before requesting IRQ
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1086330
  Lore link: https://lore.kernel.org/r/20260428-amlogic-spisg-v1-1-8eecc3b446d6@gmail.com

Patch: spi: axiado: replace usleep_range() with udelay() in IRQ path
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1086265
  Lore link: https://lore.kernel.org/r/20260428-axiado-v1-1-cd767500af72@gmail.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


