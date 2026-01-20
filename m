Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654C842B729
	for <linux-spi@vger.kernel.org>; Tue, 20 Jan 2026 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768913796; cv=none; b=S9OZUVOkneCX1/ydLKwpHi4BqIlqVopsOKIQGE1Dx22kJ4+BXbzE9NnCg8jE75JS2HqWTlKPAparGNM8rP25EpFPLhcTm2UclK5pnK5DxSA6VMqbyfSIj9gHNlaq6dK28H2bYvLLTsVWfD+yf1o0iZ7pY4rE787JefJ3WTjpnqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768913796; c=relaxed/simple;
	bh=YoCfRVcakVidQjrIP0rijh+ZYC4tTFY+cdbSuHs8Fcw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=KN4LwbQFQ4BFtP4J3OH1JtAmME9i/TVidOAT4MIihnE0g9YTG+D75r2/82WOyN0jaX3yGAXZM9eVbrcfE5TbtaIeGpu3e8PKlM0bvVciChQoO1pKvlNHxPL5CwZym/sb3guzIMWu2NpNwVVhj78bOVra7UV/G0DNvzP1uBIp/rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBjBNfuk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBjBNfuk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B97C19422;
	Tue, 20 Jan 2026 12:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768913795;
	bh=YoCfRVcakVidQjrIP0rijh+ZYC4tTFY+cdbSuHs8Fcw=;
	h=Subject:From:Date:To:From;
	b=RBjBNfukXFBEv/ISUuckFEAJZ0GyPLqhkom72ZLCbOKmYaWJYyDvuAVIKrPK8knTv
	 Lw6fENzWev5CzTrPFu+35N1YL/m3zXWbY4th8c0kBjR5/suE82oi+t0phhjPnA3E9l
	 JoKquLog9PWPrPykAjqlFBpuaN11N+36X3f6SJVwkb51Wcdjs6lkWYJxwfhCi6RWpY
	 DClaoV/E/1yjqPKEKGAzlaKgWOY3i1hoo8tgJkI68rH269F5UjedjQSW5VjZtI8DNg
	 TAeKbWGyAqquzSPuRCZXe6506ZOlT9vam9CH2hnV9geIRwl1oB0jIZzQQlHpYn6wC4
	 2PXHaGbAI8PrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7C6043805CFD;
	Tue, 20 Jan 2026 12:56:34 +0000 (UTC)
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
 <176891379298.783647.3058523580168036374.git-patchwork-housekeeping@kernel.org>
Date: Tue, 20 Jan 2026 12:56:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: aspeed: Improve handling of shared SPI controllers (2026-01-20T12:30:03)
  Superseding: [v2] spi: aspeed: Improve handling of shared SPI controllers (2026-01-17T13:42:14):
    [v2,1/2] spi: spi-mem: Protect dirmap_create() with spi_mem_access_start/end
    [v2,2/2] spi: aspeed: Add support for non-spi-mem devices


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

