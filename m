Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDBF2E7F25
	for <linux-spi@vger.kernel.org>; Thu, 27 Aug 2026 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787817566; cv=none; b=eSRcYKZmCL0vgh5Z/5m8jPuq3kpLjA7BqP3j4nfFR1sKShjdWjxFXKWG2WkHckvZD9TPqBf1/4m4mlLaJ7S7U0DXpcl1gFZu0QRAtvnzIspg5FRnVR5DNKqaj4G0xbNCMYuDXiJ+FzVxGCQBgoBpthJt0n7q5sVlVt4TPNdWE24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787817566; c=relaxed/simple;
	bh=wWG0Wss/KQUJCqZwcfjuA/RtVHVEquPYedx0M8AkSYY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=obAiNd4X9AadDA1I4YP4e8aaRocDs9Em8503KTE+833Tb3UVqy6HmFI6dOOgLlsA4dLKo2BfJLXgEQrtZSX+Xdl0w1CCo2q2xaqFwKi2LPfwcSRduPQ5/D9HKm5qx7RWw/w26ctgx9dqG03zDn09ZmAd6AFryOsKH0ht2S9OxlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNbxImq6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNbxImq6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593F21F000E9;
	Thu, 27 Aug 2026 07:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787817565;
	bh=AzNMEazQLXHwrtt/BMi3rI2BsWkDRqHYwCosy0ywb0U=;
	h=Subject:From:Date:To;
	b=CNbxImq6K4JvahpiG8cyYX196B0oJL/07Cj1tNYlnY9qWQO1OX9aOnpEySouNT3ZD
	 fgPTnaQxD/X8Xcr8YupokwO7wAdNdLdyjFCXD4K+p+OABcKne1wCL0Ea0s1egKlFx+
	 HqO5ycln9z7Z1CyhxkaX+34VjGKa8bx5tUAgeLJvAXD403V5iexv2opg1STapbSL6e
	 a1KwhP3KbW8LP5EN9HM94no3rKud9XHPlTcms68zp3060V6i5JC/s4qxrSGn+DJxAv
	 TvzUuQamwZqAEaec91ZTW/N7Wi3+AMCIij/Tmp64LCTaSrYQ86rkpowkfhJUI6Ukzm
	 Ju4eGkQRH4ORg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5698A3809A12;
	Thu, 27 Aug 2026 07:58:32 +0000 (UTC)
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
 <178781751080.1088232.348015866617716.git-patchwork-housekeeping@kernel.org>
Date: Thu, 27 Aug 2026 07:58:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v10] iio: dac: Add support for AD5529R DAC (2026-08-27T07:34:46)
  Superseding: [v9] iio: dac: Add support for AD5529R DAC (2026-08-20T07:08:21):
    [v9,1/3] spi: dt-bindings: Add spi-device-addr peripheral property
    [v9,2/3] dt-bindings: iio: dac: Add AD5529R
    [v9,3/3] iio: dac: Add AD5529R DAC driver support

Checked 163 series in 3.72 seconds.
This project currently has 16399 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

