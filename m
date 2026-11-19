Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117205;
	b=B1hqKHpYVeXt733KX5FBC9EqHCEp0rPgt9bA3Tgs1tdZ9HADUbO5/SCny5Qzf/M5pXP6
	 r/lKySiGx0I3XZS1eyjft4aSlMKi1/2oALsTOod+v1GRiAyUtyxDff9rQOw9qXdyTfo8N
	 flQJJHUhNAbEBq3/r1U0VZRIZdhfIthmAjalGa/qfTFwBHxGqvyVuPolFZo53YgJnWnlS
	 PL7C1pXkKaIg6W3c6huTFBRHBvHNYHThcmUtCtfRe8mNQILEVZ1sNAC3ETZKiHFToJAmv
	 LrgdEJnEV9P+dZ8nkgVy1AZD8VH0vJnNBSCIgtiTpMeOVtj9qx8vCsKPu793+7iFl8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117205;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=aAVYTz633GpsFtGmkkkGwBSGQWg6dM24Kn73zye6Wx4=;
	b=anyqULR4dhAQzS3oLTGrtDwbj6cFWADeVYpeLJlNT0w/oUid2lmaWjr/qQYhcyoDpmnj
	 mrzZ3tPE/iPQmauSbYIhMQ7aCH2LY+YRAQXednqlVq+aZFWIZwU3ZX/kLJy2dV2e7BONY
	 Z5N3UhCTNkSnGgaEtYeNEAD6A3HwV4W141Qao3hgENbLgwO3oc1OjftbGlDn9Z+H9vdvi
	 etNJNUgEArolAdG33Cr0Hd5MButXSd+c1ukJjXJz/OOkZM7RTuv0TEcDYFXcXLJ1PQSpt
	 2sxdpYeGxFob63bkdRRQsaGjXT0e5bpCVNMeMuRUloBy7dqJkreE2PksvxRipYfjB4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MGZQ1Ugt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD1B606A33E
	for <linux-spi@vger.kernel.org>; Thu, 19 Nov 2026 19:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MGZQ1Ugt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251D51F000C5;
	Thu, 19 Nov 2026 19:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795117205;
	bh=aAVYTz633GpsFtGmkkkGwBSGQWg6dM24Kn73zye6Wx4=;
	h=Subject:From:Date:To;
	b=MGZQ1Ugtab8idkqjFsK1SACaH+4s7kxSgFy3W23CTLFInt3lexBc5tUHXXfhl5D1a
	 PByWLe4TJOL3nIkpy1mMVJxtpVWkWXFuilvD7iVJHI+1id7mR/wtOYiN2jUpBOo/TW
	 bRR/B89+m0JC0YkjtIxn+V0PZzrBcgr+gdfhoH7eZJPi2TqZ7p+YNV520Z2m0BlF1P
	 PRsacAvWO/SppTxIA7s2ZDICAMUDy2qbyALQbbebbPZrkc2k2CZkSEK8qmWAQguCAB
	 YzzR2xezeWX+mabhnnl4kiyHI2qGvpG6dCwqHvCyLxLZX+2lHn1gg7YZY8OUHScLBG
	 kMU1FhPzxFrAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F38FC3808210;
	Thu, 19 Nov 2026 19:40:04 +0000 (UTC)
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
 <179511720367.3770832.15467510501881415980.git-patchwork-summary@kernel.org>
Date: Thu, 19 Nov 2026 19:40:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: mfd/spi: sprd: fix ADI transfer length handling
  Submitter: Weibin Liu <liuwb@xiaopeng.com>
  Patchwork: https://patchwork.kernel.org/series/1193883/
  Lore link: https://lore.kernel.org/r/20261026153253.689525-1-liuwb@xiaopeng.com
    Patches: [v3,1/2] mfd: sprd-sc27xx: Pass byte length to spi_read()
             [v3,2/2] spi: sprd-adi: enforce the exact transfer length


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


