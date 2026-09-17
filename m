Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A621349B441
	for <linux-spi@vger.kernel.org>; Thu, 17 Sep 2026 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789640473; cv=none; b=lW5QTISMT1SOsxDUlL6aIVa4H73LDvFXEY0pG7UXs6HhjzW4BRe+t6vUH1/B2sqDG3Sqws3VJzqhfWMU9fl59AxFRYOF84c4l0mo7lajQOC9R3n77cvkSVHRRfRQ5k9P2Pxyv1Pra/JVlE7n/Sn3oTKnPb93ElnJdOKGKxiVK4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789640473; c=relaxed/simple;
	bh=fttMrIaJsS2fYQJnBoAdNw/pSRHj+3392yJc0PvCYxo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=XqxjGkosJHL22RrtqKQibWOuiHbg2vNuuu2vtBw+vtZmt778Nlkiv5NHQ1ooLJWsc36WTxO+FoGXIO6IUYAkgLfh/Yl/uPvK1QBLq5NkMPlk40Fle4DNtMOLk5BrPbPGq3AAwiL+t0ZmOhO3z0/6f6gl1epX3TZ1CnGwXYoKG5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3dl9oef; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3dl9oef"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3E11F000FF;
	Thu, 17 Sep 2026 10:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789640469;
	bh=z1MWLTmQmxywPqQjRHRjKhTMHrCVR/I5FjaWiuIvf5k=;
	h=Subject:From:Date:To;
	b=c3dl9oef8auMnyGIYxvJxmjoJiwenuOCbLhNQXVgdGM6BMRs45OyNdkpg+Yzzb61a
	 E/ph98zzqiBH2guDKodylfumidUJTlr1GYEl16UpS4jZqV/VdOIxHHkDolfKRUb4Si
	 3P3+hjJGkdyprZgwzuXlR9MchVqMo42LM/AXjZMW3pKDOFzpZ6QzJON7d0QT1xANMv
	 6v7taIN2nAsIxUpJycQpwHUOdXuOIbAhsKHfc1QdcK2KTEN/qa+tVAUGrbWnD2Q50b
	 8JbaXCfPO/GCe4j5XI6zXPFt/dFFMFgcsOF8rdQa8jtlZx5ZY7N9ws82rXVx8e76F5
	 IZlAM3X5x1iXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 960E2380DBDA;
	Thu, 17 Sep 2026 10:20:04 +0000 (UTC)
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
 <178964040329.3552644.10695021022195280380.git-patchwork-summary@kernel.org>
Date: Thu, 17 Sep 2026 10:20:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: spi-zynqmp-gqspi: stop the controller on shutdown
  Submitter: Itai Handler <itai.handler@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1162280/
  Lore link: https://lore.kernel.org/r/20260910174832.873352-1-itai.handler@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


