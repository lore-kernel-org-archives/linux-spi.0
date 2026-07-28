Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFF93769F0
	for <linux-spi@vger.kernel.org>; Tue, 28 Jul 2026 03:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211102; cv=none; b=YNf283r/9rTQcs/Ib31lBxygMPhNvdsLUOrdqFHf7nFGlMFv3AlY3w718RNaiIiLs9LYCNOegvh0kw70S4KlHKltVufb3A5dU9KD1bj2MapT9yfwBHgvvyH0GT/fBQDYWVKGmT8z4T21QYaYAALOyzEZ5qnNmnLiPW5orUPZOVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211102; c=relaxed/simple;
	bh=UWBoHbLLOIy4JMNdzpi2k7OgeuESg/lFNC5g1QuRHKA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=iMz05OS+p5jax/EdNG2l0nuMpWwRU2DV0NcdVlvoNK8r3EllEGj5NW8fHqaSnKkwZwKSphbI2uhL5t13PhJWbmgLHHL825+D/M3f/kfTW2n637lmVLE/HuaeIWD3pFYod7AMyOC/ecr6xaO+HA0PtfnvOqvhtmONgOyPzUYN7fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsNhPzDN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsNhPzDN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800E81F00A3A;
	Tue, 28 Jul 2026 03:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785211101;
	bh=JOG6aMTZ9QkWZFP89ins49ZDG1MWM+uQzWwgtRLLy0w=;
	h=Subject:From:Date:To;
	b=dsNhPzDN8TF7933CsgZrshou3Rqj9IBNPSY2XQdiXBZGO2i/rjKWlpv7R9Byu1PVY
	 Gp/O3qKHhHv7YiD4cvKycg/qWRxuU8KTEL9ctTMGXS3k8ANeY57hcq6MOZ6hQIOeH3
	 Zvvo5LaQzmURyyY7Og2igSwG2xNu71buuQpmcpAnCEEbqvQg3aps2ChAXph6i5QnpO
	 4tbpTqTH2GJui4UUH7PYafPTZtTO115D7Hn4KUdEi8OdpZUW9EJuaLF2nSvK0SqPhH
	 /hwDwzfv5OFTsMRuO56CrBXaHMckxmHJvWMVNGJjoTYms5kxn4ZsTdpukMwg1v0Ky5
	 8ASKtoLEWToRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B1A380CEF5;
	Tue, 28 Jul 2026 03:57:47 +0000 (UTC)
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
 <178521106641.1532899.3751628170997162246.git-patchwork-housekeeping@kernel.org>
Date: Tue, 28 Jul 2026 03:57:46 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v7] spi: add new_device/delete_device sysfs interface (2026-07-28T03:05:39)
  Superseding: [v6] spi: add new_device/delete_device sysfs interface (2026-07-14T10:09:43):
    [v6,1/2] spi: add new_device/delete_device sysfs interface
    [v6,2/2] docs: spi: add documentation for userspace device instantiation


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

