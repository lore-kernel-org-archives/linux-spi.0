Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAABB2C15AC
	for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2026 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258454; cv=none; b=RAa0227b3+JKZw8K8OUqfhtJvj76xOCoSf0zXs/UedcRUFBhMOcd7oYqgxUqoM3Ul3WIqXNhcyHnuNAMGnn1EoKURFfnxnM+jwBbBxHxT6ai/aYPXjEE1mUVUmbV2qWu0Dlvj7ZXBVrymRDKpdbaju6gd/sFpcl6T0nRhMP9afQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258454; c=relaxed/simple;
	bh=F5Fw4tSNf+hjZpHL+WCjRP9IReabmgYmaO5qzJapZ+A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=h0nc61SCgWRexDARrtcsL/Kc0ifix3Z8R2f09rOd8I8HN5LvnaNYXHiE6FU9JFj1u9A1b1JK3pf51wGcdwKiaZvEAQSX16M9mcaDhgWp+E+dhlZqn+8R7nZxy7eKZVuHb0PXqcdjQf+/48oUei4i8ofbit3A5aUmf4pqxcce7BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfdkbT9e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfdkbT9e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834531F000FF;
	Thu, 24 Sep 2026 14:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790258452;
	bh=aJh7OEPUdKmg0RnuVxksr4xt0kTUsu/rSmSEkNDb440=;
	h=Subject:From:Date:To;
	b=KfdkbT9eFPTxCnUTKNuFOSDaDUnXRwUc1Mcuv9/WaaVbL32/3hH7MmNk9aHEljTyb
	 J9RFYsPQpAhJChT/2vbVxoetfHpwfOoRWuUdp06UYJ1acLgifwPIu4gcMgA+ZdPWPN
	 0pmrY7o7GOm7Gui28Fvt8yZpIiLH0pXNbvqeTUi781LzS+0cJ7nqRHoC2nbD63zu9Q
	 5nE10O/BifXaqq8J+jlldwVIVKNcCs045cU1aCc9LAk9UJvwJ06/uxhnC3NAnxoXCV
	 gXtx9kAMxoBD0IeWUZVWomFS4RnFI0OBkzDjraGl+9Q4d5MFouW7CUcPLPB8cNPRVc
	 tJ5zDo9X+cy8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C0B39FD338;
	Thu, 24 Sep 2026 13:59:42 +0000 (UTC)
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
 <179025838146.1561776.7528519256482811471.git-patchwork-housekeeping@kernel.org>
Date: Thu, 24 Sep 2026 13:59:41 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v7] spi: spidev_test: new features (2026-09-24T13:43:55)
  Superseding: [v6] spi: spidev_test: new features (2026-09-24T12:27:21):
    [v6,01/13] spi: spidev_test: include tools/include
    [v6,02/13] spi: spidev_test: clarify usage for --size
    [v6,03/13] spi: spidev_test: make size argument mandatory for --size
    [v6,04/13] spi: spidev_test: allow zero-length transfers
    [v6,05/13] spi: spidev_test: abort when -I is selected without -S
    [v6,06/13] spi: spidev_test: always compare loopback data
    [v6,07/13] spi: spidev_test: add compare mode
    [v6,08/13] spi: spidev_test: allow disabling rx or tx buffers
    [v6,09/13] spi: spidev_test: don't send 0x0 or 0xff
    [v6,10/13] spi: spidev_test: send predictable data
    [v6,11/13] spi: spidev_test: add option to split message into multiple transfers
    [v6,12/13] spi: spidev_test: print TX on error
    [v6,13/13] spi: spidev_test: rewrite unescape() to stay in bounds

Checked 175 series in 5.35 seconds.
This project currently has 16595 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

