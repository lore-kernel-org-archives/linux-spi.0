Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707206;
	b=WtY6kenBrmz/t7wmVodkrr6oq5h0/tyynKLsdqb8SmupRQvN+TGwJo9ARGgbNUemeSIz
	 XEYDMmuom/0TP9Jn9VTdp6s5P0JjzGQQSk2sgeZa2I1hfg6Xo3S8TM1mCLamdO4Vk9K5V
	 XcIVXf3FN323G6b8my84je1xTa1ibTWv15wz26aBYjN2rF1Mg0ckQ2djQITSDdVznlSvq
	 E9CHIQPMdOoA+RWJguzMn5glvhNXF8ZvCzHcl7u6R+HN7wHzkDzD3fK5bQ96ptOnIeb48
	 F3fkbKYDsk/MC4lqQ/1RgBFd0wKxlCqc83o7bVpwqu5AFm2UeA8PPz/Yh54IlIoQKtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707206;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=RjuJnmITiV8iEK4prZUZ9zOHjKYiJY43HLd7TO1NMN0=;
	b=ctNgfieIoO217CezP0pZqPQ0GwW4PGMZQeQqSpXCKnOXRgKhgaUbFSvdsbT41lGNPCB9
	 8omdG2Ul+wJUwIjV5VyCK3K084PPA+n3pzj+bpVKmEoW43ZjUTkWqLSLvrq/t4ypU5Kda
	 9Mx1L8R1y73Xl82pAT34XizesGB8DLAyr8Co2cA7DpFr/bKfkucZDlwcJ/QtDu+luW35Z
	 FFEs/6pH0Im86KkUDEFLaPZ7KzeLjG80OIG+EYYN++0S7wBb+4MPGcdRMx6KXjMw5nE+q
	 GvI4wcSlek5TiErDe96TlVFQ+ML1rtk3sb0fipguvQRhlxWnKjN2TzH4uNRvZDZb2kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4scrPB5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66EB606A329
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4scrPB5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6F31F00919;
	Tue,  3 Nov 2026 12:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793707205;
	bh=RjuJnmITiV8iEK4prZUZ9zOHjKYiJY43HLd7TO1NMN0=;
	h=Subject:From:Date:To;
	b=G4scrPB5MAwZ0T5upsBbtshn26gezY6QZcRM9InEg3YlDuHcqcIM7QDAWbSgv9r8r
	 j9mVYlhNxDrXAz44CrFG0tfWTGT3nEV3Ght2DQ2y3hdDjNarvm0iL5bniADErN+sx7
	 RshQtM/S7xMDbKccppJAau6OdTJwDdS0D8yH4NTjKl2OMET/i9MTtqIgo83+ca0E8s
	 59Bz0fIlQWQyGhAVis2sfgxm2tjR6KcH0obWUJTbNVteDVLXjyP0ue3xy9yRUgVHwj
	 nUaplDxWoHNse5EVZpCqh1F0veJ3MhzDp99tQifbvLbkDN/pf6WtLLsOwHp0WcAAw9
	 JTcTTZuT+90Nw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D2F03805CDD;
	Tue,  3 Nov 2026 12:00:05 +0000 (UTC)
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
 <179370720413.1083709.10616252917491036548.git-patchwork-summary@kernel.org>
Date: Tue, 03 Nov 2026 12:00:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: amlogic-spisg: Balance runtime PM and clock cleanup
  Submitter: Myeonghun Pak <mhun512@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1163690/
  Lore link: https://lore.kernel.org/r/20260913043745.35022-1-mhun512@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


