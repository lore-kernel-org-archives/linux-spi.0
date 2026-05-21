Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D707D224AF9
	for <linux-spi@vger.kernel.org>; Thu, 21 May 2026 07:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350269; cv=none; b=oXBLqRuWu7AjxW/oRJNTUprd6GWZm/ILtXKHHka14PnuWe8dMbMcfMMEAzuvyU/qWevBvjWiwvfepqROK+1cANoAJIJDW/bn2+o9N561zfn+YIou2cPP8wh6qfxUAJ1G0VvielV9FVfho4gG9ge+G693SqHA/nWC3leQ/fO25BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350269; c=relaxed/simple;
	bh=JTPhMiLu8SZlzvj034862d6ypXeEj1INjJaKwIG09Ws=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=NWzC7GWDBgkxXEe7tqCvkpqt3Oi7J2+ZQWFI99GSOyfFUOM9bbgXftYLcCrQJ/MXfU9CnIJ19mmdc4FL1mvwQJidgrwC4igGgRFe7qB1uEHvhD3e/jfgICVtqvLLkyGMuIiklcjXeDoKOyEjHd1CQX6Cu5heiZJ/45WxX+xNcMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmAbOufM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmAbOufM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC5E1F000E9;
	Thu, 21 May 2026 07:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779350268;
	bh=ajTBqHQbQNP/PvDsJuU6uxGxY79HddVIO9067WHcZws=;
	h=Subject:From:Date:To;
	b=HmAbOufMVZWzG+TjwoXDSIFu9Mkezuixv+CvKHC5Gs6vvU1Qx90xBcsFe52SPqrJG
	 ylGXQwSR4x2cfMSxDuGy9cHfReTxmwAr+UAlK8wHbsIMW5GortrdLDjPgG9hplJaN+
	 N1XqXyU1RlsO/otMncvPuJ6gTZ6akWnL3Kvf76YCQr0/T42ALpHwOSSKREJNomWTQv
	 vcUfNhAV5CMmIcRr5DtOmkGi23zzsTv0Er+05PAaysklMEcZd/xWspoHyURfwDYtrB
	 vtT/PqwQnJXQq8ElzpzpxmUFRbqZYzXxEDWHMwgZ9kHLdEiIAH1/FMs4tdXyYDS51A
	 H95JNNzlif0Yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A613930C89;
	Thu, 21 May 2026 07:57:59 +0000 (UTC)
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
 <177935027851.3948292.8921005010942646926.git-patchwork-housekeeping@kernel.org>
Date: Thu, 21 May 2026 07:57:58 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: fix controller registration API inconsistency (2026-05-21T07:38:16)
  Superseding: [v1] spi: fix controller registration API inconsistency (2026-05-12T14:01:31):
    spi: fix controller registration API inconsistency


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

