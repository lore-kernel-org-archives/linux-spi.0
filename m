Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55D749E5CB
	for <linux-spi@vger.kernel.org>; Thu, 15 Oct 2026 06:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047502; cv=none; b=eSDgtjD9Y7UgYfDP4FxA0egqT0ot4WCyuC3B+KAvr8KcyZtFjS9V8zX1uJRo8B+ToHVKhT2BH0RQoC0mQaz1nQXYeFENgzGwToJiR645eRyELSPFPSoLtQI5/WecYjCLDa1psBtjbZvfFTqU491H3zzDw5CRpt8GRy8ZJjAYX0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047502; c=relaxed/simple;
	bh=2nTReV2kHqKsKjWQ4d2jVki2/PCuhXg63kycH0PZpTg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=CXULVoC1+Us6J2RpH3EU3GkYzLqlQ9EjFxseHgIbuY0wAOeTkC0Gik/a5Aa54FjUMC7IOebNK66+V55RsnRp+bKquOBYB+CS7yOCgJh0/WSN6QXtyMv8fctjAlTY6lwo+JQdpLKmIb4nosxP5dvxqTyCzx9sUXjrazNHmHYp/dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpRmSxTP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpRmSxTP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A33C1F000C4;
	Thu, 15 Oct 2026 06:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792047494;
	bh=6HlBBRpifj39na+3n/S0jxLE1EGN+5/rZLMyqqiwsVU=;
	h=Subject:From:Date:To;
	b=OpRmSxTP6KK93WV8sJckDKaE2IklC7KATPnt0tCsZHPlnW7L4jE7gfsizhTTNUYXT
	 Q9rlj5cDZfyVBlxDZfE28zF8vL4PeaMJGukt3HFvBuNbklvjAAbhSG9TKuWBjfhD1r
	 Z7KUXlYAptMESYuMyLObZPYQKvKCemFHCc32EDoOay06KVUprIoisFFeC4lpsSfK9W
	 tTb6RuiQXinz2mEg68Lbslm0GoA3sg0PYxn8aoKe91HD+uq8q3cByJ7rUzh9gjAL3N
	 WurYCxyp1PBKs9LV53PGxyiC2MFAKKtTdK+5r/00n7ySNQeigKTqtd3/GPp9t+lsR+
	 sbSSL5nbkfHTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A33E392E9C2;
	Thu, 15 Oct 2026 06:58:14 +0000 (UTC)
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
 <179204749284.3226947.7907751742825536786.git-patchwork-housekeeping@kernel.org>
Date: Thu, 15 Oct 2026 06:58:12 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: omap2-mcspi: handle DMA setup failures (2026-10-15T06:43:41)
  Superseding: [v2] spi: omap2-mcspi: handle DMA setup failures (2026-10-14T04:56:17):
    [v2] spi: omap2-mcspi: handle DMA setup failures

Checked 203 series in 2.99 seconds.
This project currently has 16768 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

