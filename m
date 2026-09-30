Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CF134CFA1
	for <linux-spi@vger.kernel.org>; Wed, 30 Sep 2026 02:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790737159; cv=none; b=j21a+mg2rZVbLAMvzOTR4jRQ8/78PcSJQUl+UMGLWewyDe8RyWHznZ9cxyPrFlIo+5rj5WNWIaD5IDGEJt/DB4yF3ZDi8pOfIetF/MGpLLHLYPEWXyAn2bCy0M3Jz11zz0u/B9Yncd/ul7dFbB/HVO51Rif2Pvb6XtGNpe0dODM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790737159; c=relaxed/simple;
	bh=lBS6B7seUuz2Qvfwgx/tYkMBOV3asT86ZAn6qoWjav8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=mbmU4fIJHCSwwl/j8R7doBpawFfM3R7qQqbzrEvltouqum3UTOcSorA08A2hDVXr2r7Cg0w+hdVOrStZODCEo8aXrf7GsXXWiu/CtLiiyAF3mD/p4uxUnCEVTuOHnylaVoMBR7w+CcNvirzYVRlHbCt/sriEKXqM6rgddVhFfeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSMG853B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSMG853B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9081F000FF;
	Wed, 30 Sep 2026 02:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790737157;
	bh=x3tkt05IFmkr1xRUMlgCkp2pny1S7rA6FnpJ91kIMRs=;
	h=Subject:From:Date:To;
	b=nSMG853B7uR4IyZVNBsvsr0LIxmZVkL4cKLubTfxjlDSmzbt3oiYN4qn2aNJNMZBu
	 wqpthJTfNa6MW+sI+RtTchQYhj0GCFLZ1A9Rlu7RGcWFFdl4uyYC/p5zgPsahJI+Mw
	 4ixl5sHRtFf6UxnNadkLWQ6RD3BfS+N0secnb88w40qzEDaj1pt6YdztaTEBi6hk38
	 qzCPseub7+Es1kHnRs2yaEzwnt2K4VAfnX9dChR0Sne1nhnQzwQio/V7c8zOZ8cHHn
	 XBnVQw3qHKXkMFoCPm1wjRi+G1VdFqx3O1xyz5HLp9dhGJB5RmMns0sSBI/SR0j8dz
	 jlDhOXC93G+EA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B74BB3924FEA;
	Wed, 30 Sep 2026 02:59:17 +0000 (UTC)
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
 <179073715636.1226726.3097094665762641475.git-patchwork-housekeeping@kernel.org>
Date: Wed, 30 Sep 2026 02:59:16 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: axi-spi-engine: fix stale SYNC IRQ pending (2026-09-30T02:17:06)
  Superseding: [v1] spi: axi-spi-engine: fix stale SYNC IRQ pending (2026-09-03T13:49:22):
    spi: axi-spi-engine: fix stale SYNC IRQ pending

Checked 185 series in 3.79 seconds.
This project currently has 16658 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

