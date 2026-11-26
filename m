Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795720805;
	b=HKwgf07H0Z5+vtq5pgrdWq/u0XVki0zH/R+c9p+hNzPBlO3cdRRZYAFkX9ov9BhcjbHf
	 G2pxvSlwmvLn/vkYZ63TwESimTpeFZHBLFk6c1hnllU1HhwUHPAS22iwUhIYYf1YlzCrI
	 0SSBKtydtqGqYMYwdgI2GH/euQtDe7gTjPuIGAPRn10RqpktuSookJadzDJ3PDQUDJHsO
	 gc1UwbIQuKhZ3ez3WwbTPSrDt0XOIAYW7ONPHMwAt4z0uNoDqgxw4qQ4RmcvMcVu4UmJz
	 XQUbYrxbtjkAOE32pBmWD/Iz6DYWweGy5xB48qy1BEhNxLyQke6/TP+lQDrmOG+Ts3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795720805;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=7aoTYIHr2s5er61tO4HepkVCXR3LpGHzGhmZxPN2kaI=;
	b=PsnAdUBOaiVZI9xXhQuascuDErQTIVKTzhZQ5aMbht7wRRtG8Sc93pri97PG06dnJM0x
	 EITDq4VzTxj98GrV+O0WNzVoyGv/2p4lMIR475HdjPt/oj4dtDNABzGK1ro8d/ybukwsH
	 nwGnQJQVB2SHh3ydvZe+Hjg65NQa5wHsCwlD5PwcTEPIShT/TSVI1PvByo54pb+6Mla4l
	 0Bk9XaTcyjgT6qcsyiU369R85b33X8HfVTaiMPWz4Ndu7xJw1QBdxo4ttK2Pjh9YIHIMQ
	 B4by1r4jfNTrSeha9qF28My992E1Sre68gm2D4v9VhV9zkrFQ4i88b4dOxpeHrgCoow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hoHA+RAa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A872606A31C
	for <linux-spi@vger.kernel.org>; Thu, 26 Nov 2026 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hoHA+RAa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB131F000CF;
	Thu, 26 Nov 2026 19:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795720805;
	bh=7aoTYIHr2s5er61tO4HepkVCXR3LpGHzGhmZxPN2kaI=;
	h=Subject:From:Date:To;
	b=hoHA+RAaE5WFRv5HEkJtrPCaguFaUKW9moqrwsWp7duU9BAweB6ksrsR4N8+GIDPr
	 JTLD7sD8R5m1iUp6onInqF+uOE81/lH9XdUsFFcwul4FVI/tdC8ygVZ30/jUopLLoJ
	 KpSte1Itn4nFyO5KpaFzSLLRHxKfUDtrtAscDcTYBr+hEvcquig0LSI3XtDiftx+k+
	 kjIP12HFppQei8ycu+SNI5ez+W1ZGAzyBpP9OJdPfTm8HXCdzK4M/1/BiP6bPFvIdD
	 7TAewph7u0blWmpxZncUyL62KkjHlQ1aPB+vkFbbFuqL2WhpP7hhHWiiLzn8lkkWi6
	 nCPFYCG8wOQiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EE01B3805CD3;
	Thu, 26 Nov 2026 19:20:04 +0000 (UTC)
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
 <179572080348.574449.10741878756352768496.git-patchwork-summary@kernel.org>
Date: Thu, 26 Nov 2026 19:20:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: spi-ti-qspi: finalize message on transfer error
  Submitter: Joseph CT Chan <jctchan@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1216552/
  Lore link: https://lore.kernel.org/r/20261119191001.878454-1-jctchan@gmail.com
    Patches: [v3,1/2] spi: spi-ti-qspi: finalize message on transfer error
             [v3,2/2] spi: spi-ti-qspi: add a KUnit test for transfer error finalization

Series: spi: spi-mux, core, ti-qspi: error handling, delay fixes, KUnit tests, and lock context annotations
  Submitter: Joseph CT Chan <jctchan@gmail.com>
  Patchwork: https://patchwork.kernel.org/series/1199263/
  Lore link: https://lore.kernel.org/r/20261102163023.2574632-1-jctchan@gmail.com
    Patches: [01/14] spi: unoptimize message when queuing it fails
             [05/14] spi: spi-ti-qspi: finalize message on transfer error


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


