Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794147006;
	b=WQFj+1oDTwaZdkM+6J06Urks98KDIeVwkss7Qzeh1G9vlhpMWgM1fdsKNENQ4T/rywwA
	 wEfXQwCRD3DBVhYyxeCEn2Qu19nrKZiKschbYMg8Mq3typ7opizwtSM/AVW9nGZ4RT1fU
	 osM1CTKDpk/GAlhRNzATH5kwMGd47q++ulS2UHtSjmZZ9NgzYv5kxGoUjnVQ0RZFky7aQ
	 WfRdnU2Tw6BkPlnWuxPsLA94UYnvXRGTA7qvZgltaLkL0WfKdr+kMXNlW/CTHOprLW6Rc
	 AVVFA1FZSWPF1fzF0m38VCCdMygLiAUJVzJMfwkJSlN/evnWa1/2ak6uwWzdMDqgy1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794147006;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=I8UF1lihJv+RvcMa6hv8Sx3owpXRpNopgVQS9pFJPFo=;
	b=QStqeDJupGda7s/JciV0UFrXudBEHUa2tDmbcjLOQ822gQOai1j7pUMCIMP7ozgCjFnr
	 A/aLBmjLC4jGuuvDoOTMgrI1i6pFZ6Mdju8IxIoaGFhHHPbLscXXNlQ2Nl2yUsp5jp7Hz
	 3n2YTav7GS6zxOwsw2rPnlABGmHldrNpQzVlRg9gBFSdL4nBdMfQMjFOp14XfXFNVggdW
	 DqQ2BfE1bI/fYx2kPzA0HAvZW8JUQiHCWu1a8e8E5ZU92V+HgnXQ3HnuJqQARxeQxKBA8
	 R6uTrEP6+307hjfSdUj8VFPvsjMU5IGM5lFW88hFcxhU9mc1CArGY8+xeG50aTBe5YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cLlAbyB2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B50606A31C
	for <linux-spi@vger.kernel.org>; Sun,  8 Nov 2026 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cLlAbyB2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574541F0089F;
	Sun,  8 Nov 2026 14:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794147005;
	bh=I8UF1lihJv+RvcMa6hv8Sx3owpXRpNopgVQS9pFJPFo=;
	h=Subject:From:Date:To;
	b=cLlAbyB2Ef8yb6qvC8wrlrmAtGvDM6LvOaBIijjJtEaN7m1gb46A7BTuq3Yn6BikM
	 b92X0ARHj5Q5T8f6WZbfHLSaWflJjYXrpYYToE2p2ZZBA3kLCDYM3YIwXJQfFIm0JF
	 tZzF28jP9wC6r8U8icIo2j3I0cTkwjskqDpdBM/Tuxti/qWMGWW06xRkJZz1uA4AQU
	 9ZF8MMFQLZ8BF3ppuAWv1qIG1xzWxql9BwJ+26klafeG4JWz/EcLeYwshMLeSo+Gu/
	 wKeNwy/n0WKyQADfadiw5P2uPCoVunrS4dx6nLxRe2PW/HmiUzgmxFkWyGIGMkk5iF
	 /edpoJZQu6PIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 238DE380821F;
	Sun,  8 Nov 2026 14:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179414700384.1595776.1874501691363043776.git-patchwork-summary@kernel.org>
Date: Sun, 08 Nov 2026 14:10:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [1/1] spi: replace chan->device->dev with dmaengine_get_provider_device()
  Submitter: Frank Li <Frank.Li@oss.nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1200933/
  Lore link: https://lore.kernel.org/r/20261103215824.1823272-1-Frank.Li@oss.nxp.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


