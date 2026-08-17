Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B813455172
	for <linux-spi@vger.kernel.org>; Mon, 17 Aug 2026 23:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787011152; cv=none; b=dt+1OatswbRiVYuPJVqOtU8ScFBL34P5kqHTDKuXAkOirI/eqkxOq8IncIvP9htEf5lTUKAZPq80Q2iJRUp5t4tZfZr/BPJowEVFr2bWMoaEHd8eW4AdmIqpf77O8tKa9OPngJiBR6pHWwKkQQCN4N782TEYQLDdbCqid+AFllU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787011152; c=relaxed/simple;
	bh=hd9F9+ByfLZFTm0dGIvzOgKrkKDZn3ZE3De7krYy+AA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=hIiIyPYPZGp++Kc1RftAck3905kdbi4B0zRiIAyeamxR0hVe+1aUSYBlfmJgLtwrt+CHg08SOmNl1QSaAW8dEAocka8AlyFcn6CO85WOoGnLM9tZu5y+SoavJid7jgc4m58mY449JSnU66qt0y7vM9jGL/Mjmm1YbEEQgcK7ZEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUevfAd8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUevfAd8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B51B1F00A3A;
	Mon, 17 Aug 2026 23:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787011150;
	bh=6AjNT7G6lAO3UEVHBsJvjA0RMWLF1M/9dAEPo8eWRLw=;
	h=Subject:From:Date:To;
	b=LUevfAd8H3l8FjI9NYlrE3W+f8jQdhPWNZOUoH8gVDRFyPQ43EAT/s0iLTrPcZP1A
	 AdMOnqWqTBtyRUWblTQ6WazS1DZwd08ttKpausrfDOt57TOTSi8DOT95ff5MJ5AhUC
	 K1/HRjKmO5I61HrgWWrQi3qo2GyQ0svAKOZ4lbtEmE8adMBzXLgHQeJaew8Rxh6Dt7
	 nDYgYBVOcpt0IKD5fpqqDbfvB9Komlglceyn0tq9xMxQKjtq28wQMXxZ+m0OYoEJJN
	 awEUoRaSlhyhYCUfktodcPctlw5F0e2Vj7Khyj+0oXFhFmTCga7gd+jurKbdPEcIbj
	 hIy9fuwFC3njw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D32663926276;
	Mon, 17 Aug 2026 23:58:23 +0000 (UTC)
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
 <178701110239.1796399.16818716205095523586.git-patchwork-housekeeping@kernel.org>
Date: Mon, 17 Aug 2026 23:58:22 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: add multi-CS and multi-chip aggregation support (2026-08-17T23:32:10)
  Superseding: [v2] spi: add multi-CS and multi-chip aggregation support (2026-08-03T03:01:33):
    [v2,1/5] spi: support simultaneous assertion of multiple CS
    [v2,2/5] spi: expand device name to include all CS lines for multi-CS devices
    [v2,3/5] spi: introduce SPI ancillary device with lanes
    [v2,4/5] spi: spi-engine-ex: Add support for multi-CS devices
    [v2,5/5] iio: adc: ad7768-1: add support for multiple chip aggregation


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

