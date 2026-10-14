Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71263515F2
	for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791993509; cv=none; b=nUSfk+SfTzSDQQDGe8IH/CdGcp3Z7Q1oghFt+2PqD49UbHvjMi9oBgSaF0Cc2wO6biZDUNrt2vQXNVVaNk9Gj03/ZHL/Hu7B+cfkuD4Q5h2lUIcn3ZbGE8GYQaq7tHLyq3UYPU2pJJXDe9DsioCpdyOFDBBiPrn6pqCK7K3KUSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791993509; c=relaxed/simple;
	bh=RCBT5KBdYEmY0QUr2/eUfdVX1TDoIp0IRLuamZNxU/s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=O9ep7XIi8WtUKqcjviRjOW7I8UgmIm1MY81c5B/Q7OS+M/Yu8gcsrAKiYmrgT+TmYuqe9V1IzFvhUzpUqi7tuhVOqj8Sa9oLggWQzIdUmI3mylxqwtfFy1WPgxF+QFtcxa0zwZWpyZWSXLnapZQ2qn3rIs/4VUQ9tXB3AxO9y9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCPNopK5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCPNopK5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9A91F000C4;
	Wed, 14 Oct 2026 15:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791993508;
	bh=ZgnTFONISF3U919VMHihDwCJ0hpLTSfzpJHvfzgp6Yg=;
	h=Subject:From:Date:To;
	b=PCPNopK5a/URBQnmslPX5SwuLUr05mna72DRDsMzvTXo7FWqWQ7g+3uXx+0Nc/11F
	 yWIeceBYFjIiciZpvcOIdLY7QymIgSKYtz1L2F/qa+pqmoaXMcg4Xkh//nOxY2EgLN
	 sr+JG84gkEx4Dvt88gFV/q3KUK7j2i8aHT24E88T0l95YUehSLhtu11jEfwcbO5Fv1
	 hIhVjYtHZOD/3FqAtB27vj076lIXnUTvOQE/r3VWmLMpQCtqsTXr4QM9cvKObc4ItZ
	 UxsTuQiEHMP5VSVXQi9sZJ4ngJ/Gn+cMJ6xcrgCP31av+fRlX49O8qJv2A2akE6wB0
	 QFecxkgZd7J/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6FBB239EDE30;
	Wed, 14 Oct 2026 15:58:28 +0000 (UTC)
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
 <179199350707.2830195.3639127335247852059.git-patchwork-housekeeping@kernel.org>
Date: Wed, 14 Oct 2026 15:58:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: Add support for panic mem writes (2026-10-14T15:42:54)
  Superseding: [v2] spi: Add support for panic mem writes (2026-10-13T14:13:43):
    [v2,1/7] spi: spi-mem: Add support for panic mem writes
    [v2,2/7] mtd: spi-nor: Wait for NOR ready with poll_timeout_us()
    [v2,3/7] mtd: spi-nor: Add support for panic writes
    [v2,4/7] spi: cadence-xspi: Clear "SDMA ready" IRQ flag after polling
    [v2,5/7] spi: cadence-xspi: Add irq-less support
    [v2,6/7] spi: cadence-xspi: Add support for panic writes
    [v2,7/7] spi: dt-bindings: cadence: Make XSPI's IRQ line optional

Checked 203 series in 3.91 seconds.
This project currently has 16773 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

