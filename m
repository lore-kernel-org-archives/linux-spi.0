Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553E8175A72
	for <linux-spi@vger.kernel.org>; Sun, 17 May 2026 20:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779051424; cv=none; b=qKMrAaXWzFZuRFwJ7QUVid6bDQyRj4y9qw0L0Ru85zkFwKKXrq/lZVeQIPcKKnXbdOXGYPrUabC1JmPjWyrvKlvSxI9zQuRlPIqf2NjaRPhxVcYExDDrQ0kNzKISkdyzIOqqs1ADoeS0JS6TutFvhnCYcjleCMvGHi58eqUJWMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779051424; c=relaxed/simple;
	bh=sK5uGssfGk20BG6yikiEeGyFlnogm1GIiQ7vHKEzUwA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=OUEAhpVoX2VWfEBgwbJJocOOiMBuwVlTZR+gQyFNvCbnJHxF/umx77F/7eSlNM0Kit7YTEoHUkQT2JHJ6Ck4NBiwBOKEMlf4kgyOeWVUwnOTfgALQ9K8W2f2CqEww30zC3CbDPCMbGFvQ1lj89yq6BjpCALls+pkoQBmIxNMKFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LatCYVlI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LatCYVlI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9EFC2BCB0;
	Sun, 17 May 2026 20:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779051423;
	bh=sK5uGssfGk20BG6yikiEeGyFlnogm1GIiQ7vHKEzUwA=;
	h=Subject:From:Date:To:From;
	b=LatCYVlIoU5E+Di2VnuIO0+mm4fTMgXnQgZk1qwI7aCYd4g4deNFa5B+jzDyM1h+6
	 kRhFH20R2ZAIZOyGkOsb3YYXdblsPKu9rdUB9r/z/NiU+pO0cMzqpE7LfDa+ilzF6b
	 2kwNwAD5Wxs9S2vB20AIWBJ+4Z+hwD1a+zemxWENFH9vxkzkLe4Ah60q3kKq4SVqWI
	 sGm/OkaMIRMMJuMx9UP/WxaWwAIAPwqj8DwS6jXAzd0m+loYn4E7tet9BXeInrxWgZ
	 PpGk7WpnUN72L5vEFo7opDspad7t1qHEnydxycVio7Ar2KdNRIPtzGeuX2Nof8v9tP
	 l4Qty/rga29sg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1C4CD3930B8B;
	Sun, 17 May 2026 20:57:17 +0000 (UTC)
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
 <177905143572.689707.7006915352489805833.git-patchwork-housekeeping@kernel.org>
Date: Sun, 17 May 2026 20:57:15 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] spi: add new_device/delete_device sysfs interface (2026-05-17T20:16:00)
  Superseding: [v4] spi: add new_device/delete_device sysfs interface (2026-05-11T10:40:00):
    [v4,1/2] spi: add new_device/delete_device sysfs interface
    [v4,2/2] docs: spi: add documentation for userspace device instantiation


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

