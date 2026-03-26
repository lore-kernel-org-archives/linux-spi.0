Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A9B2D9796
	for <linux-spi@vger.kernel.org>; Thu, 26 Mar 2026 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542619; cv=none; b=k32qzSyKCjcKduSfKBeCfa7g6x9/qlHonI5qK3HorO7lEV4V5HZoSGQgAlEbO7oRGW5EJxnv1zUs9DDzhOSIDacu/LXHv5QSAzbigZ17PuUn7AhYY96eGnlpNBfc2j2k7Uz7Nd63/eB26jVAZlf9bx0XfFpxoEK4pG1f7uwi8dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542619; c=relaxed/simple;
	bh=1mKXWR0xslsUqNEpU9UsROUXYHMFW5Q/pXq8F7xvxd8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=kzGD+mcDHHHVSGopm5rhYRK3p946uw7Ru4QnTzD+i/gtIgtRuWtAiIehYfXTK7HVUs7pMEMjux4ruaw8sd0n2Ta9ExROum28peD7WH0LodprjXoESpeAoRYy+bNtPWAAtMsZrDGk5LEBCmu5gGqsXnODkcwdi3wLSTdM8Jy6S8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eoh34Afi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eoh34Afi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9336AC116C6;
	Thu, 26 Mar 2026 16:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774542618;
	bh=1mKXWR0xslsUqNEpU9UsROUXYHMFW5Q/pXq8F7xvxd8=;
	h=Subject:From:Date:To:From;
	b=Eoh34Afio+HMNgB5Qc0ig/CWvsN77ZEVkwd2u22rAbV98Ja1IQ0jYc36M9JVp08gx
	 0IXME/IZc7ESvwClWXvA4BfB72diiQwkhUk8jvYv66iZdFkDYgW/hsdk0WyUvw2pop
	 m+zWcqeYNx9COIjwTzYkg5oe+PHIAtN4Fm5Q36SySD4e2lA3zl+E6wv4onusFakGdx
	 cGK/8LXax74GTfOK5NX+tnTtZhctFwuQCiJt6fyw+/25r9D3SVwOliZTqS5bYZ0twC
	 tdVchwF00QXw/K1QhLs4gtRFU6ogt/JxzeGzN08k0o+Bw6LYHt+2B8e2TP+XqDtFu5
	 llIPYXM2+XXNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 425E739EFA69;
	Thu, 26 Mar 2026 16:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <177454260488.2660909.13079298613995455421.git-patchwork-summary@kernel.org>
Date: Thu, 26 Mar 2026 16:30:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [spi] spi: spi-fsl-lpspi: fix teardown order issue (UAF)
  Submitter: Marc Kleine-Budde <mkl@pengutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1069464
  Lore link: https://lore.kernel.org/r/20260319-spi-fsl-lpspi-fixes-v1-1-b433e435b2d8@pengutronix.de


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


