Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335FC2E62D1
	for <linux-spi@vger.kernel.org>; Wed, 28 Jan 2026 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769638810; cv=none; b=FPb3RBC2hm8m6hAI0BGlOgqfwwE/BFXre2uRu/7ASzHQNCRxbwJYQlWpAOVMEsn6bOQatd1NGA47ZP+BeBE2gVWYxGet7yoh+YqqiJ7YEdPuzBmD8V2OUyTP2SGudSfrItVx3wpFHKznyLRC+L1JY6MoeAsRsjQ1/KQVrqbHEMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769638810; c=relaxed/simple;
	bh=ZkzeN2fKjX5nsN+VUsZ1X0FalJPzpsFgjAZRjrpxuS8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=W4CE1APBKcQrgAx5XhE+20eDvz5Y5C7xEdg0oL2PScRVtqcXAFfHgpFyDGYr2LEwPrbkU17uGOwo1l8CtOp8ZBNlUDm1ZwNX2vdmHQ6p9JkFKspAGTWvT1nmC5Jp+7RKdlRLQRGtcBjgZiPQtnn+nZ5oLEAITR/HMYv4fcaqvdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUDG0c7L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUDG0c7L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CB5C4CEF7;
	Wed, 28 Jan 2026 22:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769638809;
	bh=ZkzeN2fKjX5nsN+VUsZ1X0FalJPzpsFgjAZRjrpxuS8=;
	h=Subject:From:Date:To:From;
	b=JUDG0c7LI4QUMyTYPiUGl/kFWZzIoSFP9lloChEqWh5otuOBAvN7N37sa08zQOrMa
	 fhKK+paJfkkpmOEhjl3/R/RPu3V0SAcUxx17C+DiRsRuUzh5/NGwy9ohnUX6ySJyoG
	 O+DHZ+j6KbotjcjH5i4w8L5Qk7X3le4Kb+cKj9PVLgD6JhS4E1CIDendtq267ZjiLx
	 y8Kqsw1FBmiQnWuuOyFzeIYSqvWUJMhntcujbpgPi9gW8iLECAa17epw0e1OtuKzaq
	 K786z9xi7q0KT4sn71sI2azIYkgbneBFPrFIz/dIdcORtkqbIQQrZrwxdOPoqlnbrd
	 s3hm/EVHe1msQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 515EF39EF953;
	Wed, 28 Jan 2026 22:20:04 +0000 (UTC)
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
 <176963880292.2254348.15187848695078561776.git-patchwork-summary@kernel.org>
Date: Wed, 28 Jan 2026 22:20:02 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-fsl-lpspi: Handle clock polarity and phase
  Submitter: Marek Vasut <marex@nabladev.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1047793
  Lore link: https://lore.kernel.org/r/20260127222353.1452003-1-marex@nabladev.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


