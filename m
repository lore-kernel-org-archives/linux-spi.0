Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23BF4C4F73
	for <linux-spi@vger.kernel.org>; Mon,  5 Oct 2026 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791216000; cv=none; b=LdlC4+8kIVmRghjO5P2k0r0X/h8dqr7wJQtnEAdmShpoBJL2nB1c/vliZHlllmT8Y0PBGA+JKWz4x25yn+/hOWMuahlLiq1XypbnZKjgGNFVCBbJMSUyEmBDgk8wOL7xQUIq5Xy5gVfMcZvBJDMLpvySyrsx+6zXOYfue5XMsT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791216000; c=relaxed/simple;
	bh=nEVjcyrNHdo6pf/UstFWvgn/yz1ns8LEDtajR3Y+0NQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=up3QJj/DbL2ftD9bLTqNfaey9QExcuhzvxd6A1lt1xsh6GVcUj211iyqfzEJpnguzUxZXltUipEYTApIt+dPTCA97oLOQh76e3iSo9HwaHWvbqsuVw4VQPBtPJH/vrfns87CCQfZCsL6jG5TSlcjK+t4SqGT1nLWVR7HDsoiUmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fw+OPeS8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fw+OPeS8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837E81F00893;
	Mon,  5 Oct 2026 15:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791215999;
	bh=J0QV0+FNRQAUxcacU0z2f0/vnZyEE10v9lPCHBP6ltc=;
	h=Subject:From:Date:To;
	b=Fw+OPeS8CebOlqjk8XJjK9aj5kZQn2eIeV98vDuEZAAb+wAN5ueEmg5W073/m3EXg
	 vu6QmZUbeY5qHTDwnUyKbXyKPq+kvygPB83nwyldf4RVlJap+ASoRw8U2z4cjVjgoE
	 yNjlIrV1WJVnPbHaVGLrkWfY7oMbELxzfOtyJMHMYj725+FKbhdxdbsNmoARGNGnBq
	 4y5kYdw0fFh26Z9hOdWpMqJqqOetxgAxrYHdtqH4HAN7sADnEd0tXr6nJAakXMGdUI
	 hBYojSMksn9/AnAuq4XP/w8YwmQVEJgh4ToaAh/t46vxmZQbJsK9cWJh3uN5YDyQYo
	 g3N8IRmZgjhag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7757339263AA;
	Mon,  5 Oct 2026 15:59:59 +0000 (UTC)
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
 <179121599812.1790615.3393768452194830199.git-patchwork-housekeeping@kernel.org>
Date: Mon, 05 Oct 2026 15:59:58 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] spi: dw: use threaded interrupt (2026-10-05T15:17:35)
  Superseding: [v4] spi: dw: use threaded interrupt (2026-09-29T12:18:12):
    [v4,1/5] spi: dw: use DW_SPI_ISR directly
    [v4,2/5] spi: dw: remove useless dws->transfer_handler check
    [v4,3/5] spi: dw: remove duplicated "!rx_len && !tx_len" handling from dw_spi_irq
    [v4,4/5] spi: dw: restore previous irq handling behavior when !ctlr->cur_msg
    [v4,5/5] spi: dw: use threaded interrupt and optimize the threaded ISR

Checked 193 series in 4.73 seconds.
This project currently has 16694 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

