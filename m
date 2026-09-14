Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD5A47ECCF
	for <linux-spi@vger.kernel.org>; Mon, 14 Sep 2026 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789401564; cv=none; b=LWn1lyhuXMvotW0j2tcHeuW/DFwSkC+AOYIwSg5416mxxElO/pXnu2pghZ70Ta71gQXoaqULD7UmSpCJVIdC7oNqezevra7kFifnpcwfZdd/Fu2J/x2inFu//H5MI+PomoOzA2Kqvihj3sOweJtQRpsJFMU0LQkLbH4G7BW6W0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789401564; c=relaxed/simple;
	bh=RIbFmW0LRGZEMvKLxNyH72wW7QIwOTwMXbiE+rcTYVk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=e7LPNX+cpKjiyokIfUx0q5cXRW79Ct9UeyLfQD5taeiZT1Erq1Uv5eztCLAs3rPRP4gzgSLJxagbV76bCyUO8HFgggioAazV7UY/w03RBBVDFsSqu5VLVavL/te44X4uha+eAsUymHGcUtGP0IDtkBXWFehKH6ZKw3Rt7Ty2Zj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+Ug5rep; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+Ug5rep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0921F000FF;
	Mon, 14 Sep 2026 15:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789401563;
	bh=w65joEC1FMozzBwfE/iiQduXdEp7egKPmq8ge3DdLnM=;
	h=Subject:From:Date:To;
	b=X+Ug5rep1K9048bqdk3UFu8i82iQi5yXtWjNt7WvBRgvVi+tnRPEKLH/xUibJ4d4b
	 jJ4PZp9KKheVwCyCgpTDzmJsFvRZIhppaP/AxEDjJpomeTQenhNVvL4KWHg6QbUSY7
	 LOlCOB+an/UXYfcRYVWsOajX87bTlyU195GEOkrZiYZcWzWviJJJVeaVpuDpzInNzk
	 GswCzmeAZfkpVHdjPg+4OZycgTJhtyY/uFXXGTe9Zu7E7TuRuy1LxeBaOyWskOGgYi
	 PqlyUNEEVgf876gKz8vzMratRivQu9F2Z6d11nSh8SvsQLi4Z2rKlaSw+tcydpBsQG
	 1FhsDFfsA0EpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5695E3924FC6;
	Mon, 14 Sep 2026 15:58:19 +0000 (UTC)
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
 <178940149789.659126.6235187883731565263.git-patchwork-housekeeping@kernel.org>
Date: Mon, 14 Sep 2026 15:58:17 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: spi-sun4i: assorted fixes (2026-09-14T15:35:55)
  Superseding: [v2] spi: spi-sun4i: assorted fixes (2026-09-07T15:31:40):
    [v2,1/6] spi: spi-sun4i: sun4i_spi_transfer_one(): fix transfers for SUN4I_FIFO_DEPTH
    [v2,2/6] spi: spi-sun4i: sun4i_spi_fill_fifo(): always apply A10 FIFO fill level workaround
    [v2,3/6] spi: spi-sun4i: sun4i_spi_transfer_one(): fix setting of clock rate
    [v2,4/6] spi: spi-sun4i: sun4i_spi_handler(): fix race condition between transfer completion and RX FIFO interrupt
    [v2,5/6] spi: spi-sun4i: sun4i_spi_transfer_one(): add error handling at clock setup
    [v2,6/6] spi: spi-sun4i: sun4i_spi_transfer_one(): report effectively used speed_hz of transfer

Checked 160 series in 2.55 seconds.
This project currently has 16482 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

