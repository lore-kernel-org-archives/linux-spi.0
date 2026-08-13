Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D764D3368AA
	for <linux-spi@vger.kernel.org>; Thu, 13 Aug 2026 20:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786654761; cv=none; b=qYPOwI4lg05ZOYc6Qyj2EyhLwyAdqNqGybXfeEekvYtFDNOQmi1334xS27yZaybg/Gvu31GrLR+FwYIZ0iEKrQKmWUIq3Xc3/HVbe9DLp2RvBX5Rkt422KcpnriXMZkyz4Z61/2WUDMoM7MrxnuQgftomxsxv2RfnkGxUNN4OP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786654761; c=relaxed/simple;
	bh=EZTO5WMhPmvkevbaCNNVtXYwFlp+F+w5cZ1VApctS48=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=QyMIUDLqBRPD5iE50JXk8e9iBjcMxKzEAC0fJOGqIw07eQECiIVta7d7yZzKMWR/5lPwmEg8iWnV5mZk+OWtPRei+WQ/VG8HEY20ZGHNi8/khobcz7HF7HKFgX+X6BRofKgMYpdD0b1v1CZhsAoPWATjOEcpnoEOAjUra+qzWdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYDTRU+w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYDTRU+w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794931F000E9;
	Thu, 13 Aug 2026 20:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786654760;
	bh=HLfK+8qcz3b6CEvCO1cj7BxdWA5L6+iR5qmBJRwe29o=;
	h=Subject:From:Date:To;
	b=mYDTRU+wydIo8oiaOatmkfWo0yPGutAxusPB/sflQki6D80LqkFRL9lMTRNVBTQZR
	 SjD2+5d289u78fTbWkrZGOHSOTEjuRKgxykpF2kVtNushWVxbeCKZhdTIBC6I8oz68
	 9EJW2zufRCeSKUyL8g/XYjUYNWZIHBmBSXay41WCKj4vXtHux3M3yRdKER8y3kaHHt
	 GkNzHQ0nRpr75PA7A/wXPcXOhlYixE5FxR1GZqcU6l8TFJYX6QU8v7JNsep4GFY6u/
	 +kb3FqrRwgZveH18OTtzosvtXfDqvp7hcJpwCwHhqDa9l/PFVq9nQ2/PCvywN22KNM
	 CNCuhymdcRpIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 59359380CFFA;
	Thu, 13 Aug 2026 20:58:36 +0000 (UTC)
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
 <178665471500.3044399.74333954448284285.git-patchwork-housekeeping@kernel.org>
Date: Thu, 13 Aug 2026 20:58:35 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] spi: tegra210-quad: Improve interrupt handling for loaded systems (2026-08-13T20:00:25)
  Superseding: [v5] spi: tegra210-quad: Improve interrupt handling for loaded systems (2026-07-08T01:12:55):
    [v5,1/3] spi: tegra210-quad: Convert to hard IRQ with high-priority workqueue
    [v5,2/3] spi: tegra210-quad: Cache TRANS_STATUS in ISR for timeout handler
    [v5,3/3] spi: tegra210-quad: Process small PIO transfers in hard IRQ context


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

