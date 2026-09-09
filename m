Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577633A7F7E
	for <linux-spi@vger.kernel.org>; Wed,  9 Sep 2026 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969557; cv=none; b=KnehzudRvJSqDYRic9MI1EGHFB0m1F/p5BKYrEKjAWFLPtUCWaFiCaj7n2y3y3JnE3zC4Jk5naBJ4Nb8doFz8jWL6+395aUT2hvJz1NBD9MqMfgeOtTc41H4XuVkxgoJkyGRVP9E/edqZZ36ZZ+OI9g0ETfZi3Ht4+V2aZNyaR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969557; c=relaxed/simple;
	bh=DmtqE/TpA2xQuofxhScJK8WJNGMXHSnxcWf2ViphxP0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=K3EpDKMqO/YIaHxC3ZdHcjkpSkK1nN+b3F4GO7VJLuRWXvOcJ+xchhaotGz/RD1TzbvPjDmGqHPYdUYoG/544D1fUWJdYweLVGwZzyeWni3AZyu/AZjnkBt9cg6LkuDCdRFpcK+T7037mlpkUNIexWQDbRfJ4ukavEoD74Jze2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UammtDEx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UammtDEx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F6F1F00A3D;
	Wed,  9 Sep 2026 15:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969555;
	bh=BatqUq2dai2WxBkdLolFy3T/3ru47K4qeO7hWv2eVh0=;
	h=Subject:From:Date:To;
	b=UammtDExrumgb97ecfcgfzwBPbYDCgSMzRGwKdGNc9tmMKNWaPF6fL74kUKPbm2kL
	 LUBD+ySAjh7mmeo51npt4i4OKCSKLJ2Lu2u2DtYftEBIyJSyrODvohbY6dpxVOERDA
	 HZ5AMUlF+dQh8Fx6uBSYl0xBGf1Wny3nRtRGRhQ4P6ghJHZmZZ36ppf0WcgsWvciYC
	 XAevEDFr4i/lMQOijP9ajE7lD8QV58CGRBp8W15tklZxQm9qDJ91Xlk0hMqOgEL7ek
	 przLU/bie019mZo8P93eCvaB070+RnzjekbKEhhlM+5NrUO/tzS+kjo/Z7f+Wuy8Fr
	 la4nWd0w7ItWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19BFD380AA48;
	Wed,  9 Sep 2026 15:58:15 +0000 (UTC)
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
 <178896949374.923668.6284086368847935017.git-patchwork-housekeeping@kernel.org>
Date: Wed, 09 Sep 2026 15:58:13 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: dw: use threaded interrupt (2026-09-09T14:36:47)
  Superseding: [v2] spi: dw: use threaded interrupt (2026-08-03T14:06:46):
    [v2,1/3] spi: dw: use DW_SPI_ISR directly
    [v2,2/3] spi: dw: use DW_SPI_INT_MASK instead of hardcoded 0xff
    [v2,3/3] spi: dw: use threaded interrupt and optimize the threaded ISR

Checked 162 series in 5.11 seconds.
This project currently has 16453 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

