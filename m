Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5911850A4
	for <linux-spi@vger.kernel.org>; Wed,  4 Feb 2026 22:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770243606; cv=none; b=ayp3sEqwPUTfNpcutAciGeLcPsuqbi3WsQLrvQJi5WK1/g4KJLyKj/HKrobMNGom5XOfL0ssnVyKegw2XMXj9OI9xhVfmwY8h+FuWJkwAw5EsFRzdlG6AQoqYIib3R7QeQUHXKP7vOTrMdFkd/A8Wd9YHSmRQVqXRPR14tDNKh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770243606; c=relaxed/simple;
	bh=LWMah3rTz2EojThneOOVY4jVNS4dsXgqca4EoNqnrHY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=jXoWDI+clzJC/8EL8R07LZR3xF8OVd8mi6KwmVRTT+8VJ1f1U1RyvAQSO4c4BBi7VrXVyyIzazHaCnyCCQOI5kR/p/Ndqba1KFd2nrWzbFC9Xa9CK6+bGceIbvtDH+KiDmir+dCXxH0ujfUFCWrETXXgeGL4dTSwMFj45LfTJdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLSVTKH9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLSVTKH9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12166C4CEF7;
	Wed,  4 Feb 2026 22:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770243606;
	bh=LWMah3rTz2EojThneOOVY4jVNS4dsXgqca4EoNqnrHY=;
	h=Subject:From:Date:To:From;
	b=LLSVTKH9V0yFiGEzdLw3riAj4fybVv2uAdXRQ3rHsR33DV63DH95FyFFD4MrOhbH8
	 gndRjkrq9pfiZkM+Lw8FdgFMUsIAIdvL9xCgJX7qfu28LthUvpTyLA743vTMrCpIXj
	 y32Fu0bwuItT8sPPIrrSLbsRyKm9x6YPH9LENNtu46kwLB4EOnaTiVWtCJ4fS3laMC
	 N+a7e8J7OOLWcomfSE4vf1z7MmdeH8MaTg/qfe2WNM0+//Ls0zN4cP8Q5wn+FExJ72
	 32LD9TX45herU801KeUwdMIFJLryMqjWZWxukbEMAnWopg4BjUXfd2slkpA/87SR4a
	 KwfN3tmhSmY2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4A9303808200;
	Wed,  4 Feb 2026 22:20:05 +0000 (UTC)
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
 <177024360374.74746.14771985319575622674.git-patchwork-summary@kernel.org>
Date: Wed, 04 Feb 2026 22:20:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Improve SPI target mode support and error handling
  Submitter: Praveen Talari <praveen.talari@oss.qualcomm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1050814
  Lore link: https://lore.kernel.org/r/20260204162854.1206323-1-praveen.talari@oss.qualcomm.com
    Patches: [v2,1/4] spi: geni-qcom: Improve target mode allocation by using proper allocation functions
             [v2,2/4] spi: geni-qcom: Fix abort sequence execution for serial engine errors
             [v2,3/4] spi: qcom-geni: Drop unused msg parameter from timeout handlers
             [v2,4/4] spi: geni-qcom: Add target abort support


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


