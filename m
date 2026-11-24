Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531806;
	b=RFjDVFe0sp0ylZ9F2eZvmNJX6Rspbw/ryMS+KEKsn3maeYkPLEaoJzBQqBo98jIGwV/C
	 IBj92/UNLCrGneI0FkM9WC8MJw0n7muLL1FWHEBPWnX4GboO7oSc99lKBBxIdzrTxqy4f
	 PsEkYe6qMHBALUU2OB2WTMKLHOjLIwuYnvwSM6bC0pphF7HEGjmBG+JNVMHITjHbMrJ15
	 20TEMKM5TPN+Wx/NyOmUSwUGuOgl9PC7otku41CXaIpf5lAWaWpyW4M627s9zWAQbIXpc
	 2IjD4b3g2ZGcyqTalXqsyCvjRLTpxVbPEyP4FHnoPJ+WixiWa/mKZk13piZcfAStdWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=GyxdzBw1tIgco0I4kunliwJDK0dmXe5/N1iPTLZsPrc=;
	b=3j/9DS/A1FUwSdpElgcFf5PLKkH2t2aDW0L/XtxiguX617r7rJ9SqUpBttqRuhMh6/SF
	 D80E0/cw+ZBbqOtIHAQzbaxy2K5oLMj5aBIqY4PBRR3fqT3Qm0IEZ5g3gjyXPDWsytSzW
	 li40Ga/DITSSBcJljUp00siXJh77RHi30uKeDuu+NrKaRYcyk3GKAtpGRFOM4Lmsj33i7
	 yrU51ZS47wk4O0wClOb/lld625tAoZARHIA/YdmT7VQty8xcvHRgVB8UzQVlgjFX7QUXe
	 m0z3XqMB9R+9cEHpQkJZ7BrTGIwvLllIdp5brBhYFuZb2kYFRT8qTQpyULbYHNhYmQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9cicL2x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80CD606A327
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9cicL2x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C9A1F000D3;
	Tue, 24 Nov 2026 14:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795531806;
	bh=GyxdzBw1tIgco0I4kunliwJDK0dmXe5/N1iPTLZsPrc=;
	h=Subject:From:Date:To;
	b=M9cicL2xM7lXlTzf2DAoOWYA4XFMt9G76qLMSQe3DA7r0rDEUT36dEV7Cv2IM94Og
	 cuE8Yj8c+Hp+KDYWXohUxPkuza7+43KU5SjCm+LGm8gcmMD/GYCa6aS+nf7vlwfdaO
	 gFVkr7KMgCWXUOtG7DLpTu21gM3EwYONvJM7OH3IT4xvWQJNcawKzIXs5eKKyOqxds
	 fYcdk96Av22y74f1B8NXM1VYtgyrNEXblMxAEpgXDc/raiB1N3CRSld9TN9PlCenAW
	 BXkf/yIYseySTB+k2sOUDuIyIExXZfD0rbue3b9Ll0IIlrstNz9ln6/rzgJyAAFBpO
	 4cTcwycEfwVuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F3ABD3931128;
	Tue, 24 Nov 2026 14:50:05 +0000 (UTC)
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
 <179553180461.3581158.12493601373200275580.git-patchwork-summary@kernel.org>
Date: Tue, 24 Nov 2026 14:50:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: orion: handle clock failures on runtime resume
  Submitter: Luo Yifan <luoyifan@cmss.chinamobile.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1213323/
  Lore link: https://lore.kernel.org/r/20261117020646.20111-1-luoyifan@cmss.chinamobile.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


