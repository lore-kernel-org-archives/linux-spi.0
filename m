Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C8623ED6A
	for <linux-spi@vger.kernel.org>; Tue, 13 Oct 2026 05:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791871070; cv=none; b=rOldRshMOQBrz+c5AzwUyKcmaxSkAsC25AFpihwDdiPdzLMemeM+EN/URjR4PChSqhRufjDxsUamv3DDK/7flv+gDE6mxtE84cECR8QQS/g1KzM+aM2HVSRafPMT6SW3w9i3IQKpj6MvCw9nDgAGCu7rm1l/+BLcGO3T5Dd4ztM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791871070; c=relaxed/simple;
	bh=y+weBupnAsTQO8dvtXUWk1QB83QFbAKcxYkBrrNA80w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=d+9l7V458Ul5jSpjdTv3ww/agGi38ewVvu9Ztj0POgFbQAmn0bcP380VgMIgqVwBqyQnnUPDELO1WXfmQt7NDLPi8fV2kTPflas4uoFgbKn86pTZWi7jlKC/BVaShO3u3Mkh9AIFgQRbAq3qzOaRarA1hBoY1L2wblRUbMq2vkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfaokGtq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfaokGtq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0894C1F000FF;
	Tue, 13 Oct 2026 05:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791871069;
	bh=NDjJoYBIx4d47D7qw6VH9S2ptUUYG1VqQ0Hykwz0Y5w=;
	h=Subject:From:Date:To;
	b=PfaokGtq/tR8M4SnWzwXMZ+5JTtdyA2S67Aewyr/h824QzXIlNTVqp6+9MwcqEUjD
	 ca4E+LHnKzA/xW+h84lou4jExHmtMoAHhoLO2wCoxWCUn+eOcLMMYo9P1+5oBC8IEK
	 nofPzgYQdr8ZyJFdGl3s1cgVFSIiiwWvZVHnlm26xjy4+jFCJgx53YYyBfVMnV0S55
	 iM3V/b0tXNuFdxxxOfoMGw/BbcLOdLSFE8BIHpZ0lLX9xc/aVDCWWp5X7aqWRzQhJZ
	 GAyL/2sTSqTLXzOEmekoTlkK1neF2l9v7LGeXv0R3shpaph1FMsQew0TaYqa/Vj1ih
	 FPddScLK5iv3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15B03926257;
	Tue, 13 Oct 2026 05:57:48 +0000 (UTC)
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
 <179187106747.65790.9476247947087847139.git-patchwork-housekeeping@kernel.org>
Date: Tue, 13 Oct 2026 05:57:47 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: ch341: handle transfers without a TX or RX buffer (2026-10-13T05:43:39)
  Superseding: [v1] spi: ch341: handle transfers without a TX or RX buffer (2026-09-29T08:11:52):
    spi: ch341: handle transfers without a TX or RX buffer

Checked 201 series in 2.97 seconds.
This project currently has 16747 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

