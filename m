Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95C020B80B
	for <linux-spi@vger.kernel.org>; Fri, 25 Sep 2026 20:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790366509; cv=none; b=MLd5G2PuYvETVdkPu/Jx6nOAk86+vJW+kbZf35qB8+GW1DJLJLAjL8DL0kMVJAdjUjkHeTfHvRTiHlDgJu/OI/wTGuiADiB778Yxfapb8P8yKZYYf1P4ng2K4Cq42EnvCy/UsGHcauvfnE2uaoRZ2R0ubnXp7jAz0uXQX1fatv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790366509; c=relaxed/simple;
	bh=8+KYNjytHMmF2c4V1E/rWZk5nes3OPlpyZvik+mZZow=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=OSs1oZQrqaOT5VW5IX8AROHP4MNZ4fsMWyl2sfSDIHXg5R/u4Ms7FrI0ZXJvEPQqNKZYdbZCCluoBnVd2r9ZL8LFKxMkuGl6Oo1q7IOJK0MM+2uND/vzFHYG0tdF8Sv2N0yvVO/6/uThZIqGFYjxDopRW0w3Uo2RMRpnMhxhpEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0Wcvt5h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0Wcvt5h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FBE1F00893;
	Fri, 25 Sep 2026 20:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790366508;
	bh=h9uSDJVqdv6TlA663THCjTaYqS8Xmni8SEu4Q2tJPNY=;
	h=Subject:From:Date:To;
	b=A0Wcvt5hG3jY4yfQ227HNFRwMsvkTie45ufoZdf89saymEWGoTwa26CmRnOFQzz0N
	 czzstY0AGKDpUl/T1CgFr7qN0jwe3lHb8N2tiVGk1mr8EcnVzYVw2N7j3gh/Mukm6C
	 78G3BcAFTlzaLy7mHawO2DnwD1yN8epB0ux+D3yhge37s9hQkStcdXrhEQfmy25Jqg
	 RfEjxMgOUmy1qn8ZJWHaYl4pO0FpXlN8M5mO6heL9nYYgn7enXPQqmMFysEwCoBSM5
	 K/qOQrgOrF3INWyPMaOWfuPKsBFbjh4+/i3v+qhpvqELgB8H1/Xa8VfLLDS8BGBaZT
	 VS5R0bKwIJ0DQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9627B380820D;
	Fri, 25 Sep 2026 20:00:37 +0000 (UTC)
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
 <179036643605.3121774.18145051378037593655.git-patchwork-housekeeping@kernel.org>
Date: Fri, 25 Sep 2026 20:00:36 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: bcm2835: fix device_node reference leak in bcm2835_spi_setup() (2026-09-25T19:30:08)
  Superseding: [v1] spi: bcm2835: fix device_node reference leak in bcm2835_spi_setup() (2026-09-23T18:44:50):
    spi: bcm2835: fix device_node reference leak in bcm2835_spi_setup()

Checked 174 series in 13.43 seconds.
This project currently has 16597 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

