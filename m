Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CF0392837
	for <linux-spi@vger.kernel.org>; Fri, 14 Aug 2026 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786707666; cv=none; b=n9QUa4XooSWxNRQUIEzaHpiZ6RQjZzQBapOy6jAUNgaskpdJkqSe1pLY5J5aP7J+evYWGlaX6FDpGmNsobi9mheJ9Ju/73T6s5zZmWW6K6nGzRG7KnmFhB4RHfE+tD4VcFllzM6DvwVFbuupp+SO+u03bqJsCjyZPE4OqGC2azM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786707666; c=relaxed/simple;
	bh=hGd5/rMerJFwPjXGC6mAVzHDfmJUelfXJ8DbTW45/yo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=sCT/QzKud2C3E6vKU3NvRe3V+8QrxKaJvXjXemaDJYe+TkcC25TNviLdJLGmsOCKOnmGP29guSOp0lgqvRKcndPMM8NXqQA+pBkyjyifjWNuZq6O5wLsI8cOD/BlcMQbT820SVAElPZy0GWufrfybL4bVZ7Q5LDJoHiZEtzViH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEClIVkz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEClIVkz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88CB1F000E9;
	Fri, 14 Aug 2026 11:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786707664;
	bh=IA1USTh0F5obMGhhpgXZsCJrfiC+ulAj1anP+Dqvqj4=;
	h=Subject:From:Date:To;
	b=LEClIVkzEjxdbp/0SbOrTELBpQ3jVJXpkte5CwoVuOnPmUa0IJXRCYB65BKYLObtS
	 XCq04HOnsQqj/FsJzdyjEXIQMirbE8eyZ8Mogm+86lJLgt/ZU49lLBumq0UZQNTgHv
	 t7Ax17OSSRxz1lk83rwz6nsZVNGC8v2Dhs6T+6mMp0BTY5WNWO72909fHuoHgoUakj
	 sMV3tg98KAYV2+KWY5JOlOYXDx3ATJ9ZVCVdw182LUWK6bbTXjdWoTQOCXSwfJ4gac
	 5PO4GIQsJBEXVqgXNun6BynZ3/pQC+wgNz1yuE4EbuKUjNB0XErYw2PoyfEpWJ84fh
	 xmdX6eQVamXYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1C44D380CFE1;
	Fri, 14 Aug 2026 11:40:20 +0000 (UTC)
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
 <178670761877.3315844.2450440779740712705.git-patchwork-summary@kernel.org>
Date: Fri, 14 Aug 2026 11:40:18 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: virtio: mark device ready before registering the controller
  Submitter: Jasper Wise <jaspwise@amazon.co.uk>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1145257
  Lore link: https://lore.kernel.org/r/20260813084618.613172-1-jaspwise@amazon.co.uk


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


