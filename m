Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C18145B3F
	for <linux-spi@vger.kernel.org>; Fri, 16 Oct 2026 02:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792119508; cv=none; b=EScqXzQ9l2u58Rs2YRmn1F1lwZCHzaYwDYYfIybJIABKlUKPoSQYz1nloLAbn504TQqGYt1UShIrLhRY4KsTo5WGBxcxA8E3wGz044wLV8V0gNlQL6lsRHQGAYUIncO82US2GGvoUVcx7UI+Nkbcz8vy0LiX5tEkTEK2LoLVcUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792119508; c=relaxed/simple;
	bh=ZsWKMLskZj+7bPv/3+stva1vKi6aGGkqpUhwEZ2Y3MI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=rIAP5ixHZ162/N8EKTnSx7wT46GIbeSJkJe8lieK8+vPv3m8RY9XlydvfB2W++rUEEcnCqGBm3vXf6bednDq7iClH9IF1GHqgXFc6hCm2Du/jhrdl3f6lpCVT/QNw9VDQQT87FTj8c+XQKJ6Q7P2nZPAPYAdidrcYN0uQno2mnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFY3e8Ol; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFY3e8Ol"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131671F000C4;
	Fri, 16 Oct 2026 02:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792119507;
	bh=fogOpXCIfEGkVV/+5qjgW11cJHBrbYvB2Eu/x7kwea8=;
	h=Subject:From:Date:To;
	b=gFY3e8OlqWpbGtlApzamzGmqXm2TWOGQoJPg6FMZGHwVl71X1uOB3rHQ68QO+z+2P
	 JTnnuGf6wiwceLFehTkg+EOAEx0C72m0znEAXAZ5iGHr+Ze3ADq0IC8j+rseruDubp
	 6fFxlUSQWqC3JFZtcAb1P5Q8SPaLU0/bVwCc2KLfUsnW5yz0wM5qetYi5wjcLOlbG0
	 O0HS4ut01QYt2CmbVp+dtGJJa9kV0Wua3S2ZUJbImoOQ7JKmWv6/Xgu1DGB9ErIzN1
	 pMUA5uqwL4N8XwNaPi2pJ4ytTTvlADJQJdDBTBY+5KjL93w3DBRVIYvQDsgybiOBFI
	 cxN5Lo0VpnY+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F3FE43808209;
	Fri, 16 Oct 2026 02:58:26 +0000 (UTC)
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
 <179211950558.30124.892641213071617593.git-patchwork-housekeeping@kernel.org>
Date: Fri, 16 Oct 2026 02:58:25 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-pci1xxxx: quiesce DMA engines on transfer timeout (2026-10-16T02:00:36)
  Superseding: [v1] spi: spi-pci1xxxx: quiesce DMA engines on transfer timeout (2026-09-29T08:11:56):
    spi: spi-pci1xxxx: quiesce DMA engines on transfer timeout

Checked 203 series in 14.70 seconds.
This project currently has 16775 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

