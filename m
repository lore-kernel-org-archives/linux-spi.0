Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483B93242BE
	for <linux-spi@vger.kernel.org>; Thu, 16 Apr 2026 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776347888; cv=none; b=mpd062b5XG6l1lS9VeGdE1kCKMjraUBqcqLsDU0awq6s77Bm5Mq1gWDyuuLUmVSv0WAcjBfhdmdjE/zTYJUDI289ZStyLe7Qxf7HkQKJ32ZmfS96yMTQXY+/eC8joTSG3dDQsgBDQSohEMBcnI4F69fPSqoYEOgRZQV+c+BfX8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776347888; c=relaxed/simple;
	bh=4BEeVO7ULyI5aXdFujqeux13fl0oTAJLhWSuWX8Z690=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=gYMPKyh+2tKx9c/ZhEzIQXxa8ueEtMYTPlOSY/altG56Xty2pBTXZBTSkvzulpG/mr3H7FP0UHNc+vo/qM0VAz+dTPCjdbyb4WESe8DvX+rN/WQMilsVPtldpwYh62vzm3oZZD2P8q3zdz/dgegXTflxHi23PctjJ/Rl6l2m+i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgrdFRH4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgrdFRH4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E26C2BCAF;
	Thu, 16 Apr 2026 13:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776347887;
	bh=4BEeVO7ULyI5aXdFujqeux13fl0oTAJLhWSuWX8Z690=;
	h=Subject:From:Date:To:From;
	b=UgrdFRH4QToCUXhztf+N4Cf4wikD/p/vJN9ALsxA2ibOwkyohTQ2dpKtNCGl2RYk9
	 fMVkmpKgiMBYIBol/eUrPRWcBZPLhB9jb44JTTPF+1JFSg8vYf2GEmvXgi28DIf2Tg
	 c2lmRvGEHoPWSLGiXgQtEZfoBrlPq/82mmEAxYieCIO7l+Tc+dHj7kfF/QR3JJb10R
	 DH0ptfDKCJQ9AUeyAv5fPyg1uJJVCXyxcS9lLmpFoKfV2r57+IdCFJ/FDDuspKPTD6
	 9qEHjPCkHAk9Vch2FzKu4MlPGki1nnZ/Aauqki6DGNKSq1QzjmKvTDPgkjQqzYsB9b
	 MJpm9ybYHWvbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA4CC380AA60;
	Thu, 16 Apr 2026 13:57:37 +0000 (UTC)
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
 <177634785620.2830429.10389964979059429242.git-patchwork-housekeeping@kernel.org>
Date: Thu, 16 Apr 2026 13:57:36 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: mtk-snfi: fix memory leak in probe (2026-04-16T13:00:08)
  Superseding: [v1] spi: mtk-snfi: fix memory leak in probe (2026-04-16T11:46:20):
    spi: mtk-snfi: fix memory leak in probe


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

