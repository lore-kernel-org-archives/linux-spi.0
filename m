Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4736A486436
	for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2026 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790268676; cv=none; b=fcfk/hja+y3V19iVLBRP+AEzLktYmDz8xyq7VfIliiPQG/HYXElRLCYt1+3tpGkPbO0jOD7o4XELKLoC5ahyfj0N0kwe0ukv5CeCS5M36XZt9Tp1/rlXKT2jzurDlQUFNWmueifdrKddqcADWwho2k4vuMFuM8Xd8O4e59RZ5eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790268676; c=relaxed/simple;
	bh=wMQ8oZpWwfNvULAk4MMMlXZNPubkXM9ZMoyxYc/F9yQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ZyunG89QMsgH9rDKUB2EiTEKOoBLcndgIkXoRPzS+u4jxA0OOi3dXJ1ZevrJLmu2vPvwjWVTH8RCaggIob7oHHbM3gcFuH8d6T9QURNZGZSxeC+Ph4GZ9HdaBtMvmC5ieNA3saw7rfZeBQRZ1no69ErsNkRSZGYL4PF9ZjTNby4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbLUS4zO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbLUS4zO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8C11F000FF;
	Thu, 24 Sep 2026 16:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790268675;
	bh=i4e1QCLQq7HitJztEZ+jJABmsJyqruWRJQyUeyyPJNE=;
	h=Subject:From:Date:To;
	b=DbLUS4zOFPYcDeyoR0/CjDMW3tPZI+7POvVtzQZEIdxusiReVS9K2q7eka6vwKPmn
	 3Cun3SI+qYxYo7gv2WKwss8wMjesaz50Cx1B/10EFWhIDJZs7enrwuP0Y4BtFUqUtc
	 Z3hgC/QbJbUqD1vgbpbvTjcH7Dm8JthhdCita1YVkYy7ZwLtAMqnzzGFy0OZtw7RIn
	 rSQX60b/5bYZppdUgiy4Ke2kZRPJfIrdlv9Qu0qCX9DvE9y12IyCnQIo0jVUgFn/3O
	 fbuWMRf6m02BNToOgRCPVQuJRhcX+64Rp3kfamgu9KGRujQ2rZA0dwug4tmH+oMLqD
	 xZbi+TwAXC//Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1BDE73A566CE;
	Thu, 24 Sep 2026 16:50:05 +0000 (UTC)
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
 <179026860361.1650423.11368873174710289766.git-patchwork-summary@kernel.org>
Date: Thu, 24 Sep 2026 16:50:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: use dmaengine_get_dma_device() for DMA mapping
  Submitter: Peng Fan (OSS) <peng.fan@oss.nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1166605/
  Lore link: https://lore.kernel.org/r/20260916-spi-dma-v1-1-2b30657d373d@nxp.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


