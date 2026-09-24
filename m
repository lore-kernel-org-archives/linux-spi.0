Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E930E25B2F4
	for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2026 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254837; cv=none; b=BFEqNb09n9HOAoI9bm/p7jSEb7e39PaHX6wt805IZgO6Vry/ui7TmQQRNiJGMrn+t6FYaReDKfQeSiqan3iauHHlitl8inH2Lbqaii0m8avcCRwssDInUnGXBgEXBKd6wTF7U2BSfXoOxb57Azwb3htEwA/t9wwm2+2GXyCgDro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254837; c=relaxed/simple;
	bh=iE7E3O/WM3JofxeAL5vpqj86CjDo0vv0lGBWsW9U2ow=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=M3U1rce8Y9UPl0aLa+M9iHucXlUnLA3sM4cAJ+UYzDgPVZwnIbQgXr11Lc6RaSmYpZSj/sE0uDQblLfKr6Td1JP7+y6EPVWgyqYCMIncjjGjfWireNx7eICvulP3M1bcHsQmRI11onMfgtfmyH8ryGOaTY7pPse7YMpx0c3ejLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7M2Ntgr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7M2Ntgr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E551F000FF;
	Thu, 24 Sep 2026 13:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790254836;
	bh=WesIiN4vAX64s69J5ReVwWkGHAwvTTTdZBn39JU3CaI=;
	h=Subject:From:Date:To;
	b=k7M2NtgrF3nacNWugYlsg3NIfQYwDMkd+QCn3ZkJuQmFOqCRp2RcblQ5mRpdlJ7QL
	 tMkqolZ1qRpoer7UVKXmp5BVyYYCHseIx6iN/CwXFh4lNtAZXbauhsXYlRehCli/AK
	 I8x7HnowvhKPCrv4lROXuIiYl7rS7Q/Cl+IJXj7lYLtY1k77WPDyoxmmHFKDAx6w3t
	 e7DadOn74X0oWeszCDOr0FwNCU2sBPvWJYpxlxfdzFE4JNAE71yOOJS8WAoQUCPTZz
	 rNCGcVoD0y3UC1z+M6PDvu83Q5RgH3YnAaM+w8Q8n5tJc99367EC/P6G6n4fV58k+8
	 F8yKXu6yXHF6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D343539F202B;
	Thu, 24 Sep 2026 12:59:26 +0000 (UTC)
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
 <179025476532.1529522.9167781055039566755.git-patchwork-housekeeping@kernel.org>
Date: Thu, 24 Sep 2026 12:59:25 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] spi: spidev_test: new features (2026-09-24T12:27:21)
  Superseding: [v5] spi: spidev_test: new features (2026-09-23T20:10:00):
    [v5,01/13] spi: spidev_test: include tools/include
    [v5,02/13] spi: spidev_test: clarify usage for --size
    [v5,03/13] spi: spidev_test: make size argument mandatory for --size
    [v5,04/13] spi: spidev_test: reject zero-length transfers
    [v5,05/13] spi: spidev_test: abort when -I is selected without -S
    [v5,06/13] spi: spidev_test: always compare loopback data
    [v5,07/13] spi: spidev_test: add compare mode
    [v5,08/13] spi: spidev_test: allow disabling rx or tx buffers
    [v5,09/13] spi: spidev_test: don't send 0x0 or 0xff
    [v5,10/13] spi: spidev_test: send predictable data
    [v5,11/13] spi: spidev_test: add option to split message into multiple transfers
    [v5,12/13] spi: spidev_test: print TX on error
    [v5,13/13] spi: spidev_test: rewrite unescape() to stay in bounds

Checked 175 series in 5.38 seconds.
This project currently has 16582 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

