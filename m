Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D9843E4A2
	for <linux-spi@vger.kernel.org>; Thu,  8 Oct 2026 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463809; cv=none; b=eSUz2bHZvy9PxHdEhmrZYIvzxrfn6tvQzGvdNx3wzCMSRIhUe6Bp0vir8JUSzLFdBY8RlTEUM6eyNSzlhKyLvJ7ayVLrbg8wE0v1a8nMxeBeIEFRLXZageQmRjG9QiXjvWCXIQZi/dJugMltvYLf45b5QyDTRo7qnx+HCsFsris=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463809; c=relaxed/simple;
	bh=pih7IeA6RjSsJ5vqc6MNDxXxz4wbzQp/jSKr46HUnvA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=JQtV12iRP1tFafMWlvij08617zVhcvN6BsyuKdmyylBw1nJiY3RkFHVGSEbWqXGu2AH1/oYAQcOg48GoCG5XioUX2GzHvn9O6w22NWF8fTBPV2rOfQ8MI/7tSYBxY+yg0yvTJyctNWaURvanoPY6I5xSGeCGC6Y0+Jt8Xr0XNNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhiUw4b7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhiUw4b7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2646C1F000FF;
	Thu,  8 Oct 2026 12:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791463808;
	bh=8FSo/roj53ajZ0aJWU/5q8i44wjLQnfqPB7Eqe8jcK4=;
	h=Subject:From:Date:To;
	b=DhiUw4b7ouRwPzsF7qmrjWfIFvQI6GhnZ8m2nbdaaNHgwdcWCWc7h/kfD7ITbXytb
	 lIE0lSXwwNDFvKnggopUTI4UxvO1Cv0oU0ZGjhgibfQA9cNkhUF4gjpCmgVtd6PnaH
	 ptLM5gu4ryfHulyQcXp57+jxcN+SLLKWpldzDRhSz+/irNgI7mHAuSN8PyRFaVL3dT
	 3Q4rs1FmBHfL8jhPe6o1O0EjJ/H/+wUmGSDRqs/VhHMeJs2F++9zIuik+LBRCoCJOP
	 smDFzREEt5olh6yoqdAyEpDM1m6NAJr/IUHWKrC6QAK2SYkqhqAxbi9Gv61LcfYWHB
	 0BUAsbVzlRZfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F3C4B380AA52;
	Thu,  8 Oct 2026 12:50:07 +0000 (UTC)
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
 <179146380665.257551.4396220438680853914.git-patchwork-summary@kernel.org>
Date: Thu, 08 Oct 2026 12:50:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v3] spi: dt-bindings: snps,dw-apb-ssi: Add Synaptics sl2610 spi
  Submitter: Jisheng Zhang <jszhang@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1181182/
  Lore link: https://lore.kernel.org/r/20261008010058.28382-1-jszhang@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


