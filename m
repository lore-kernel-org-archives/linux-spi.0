Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB4627C162
	for <linux-spi@vger.kernel.org>; Fri,  9 Oct 2026 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565099; cv=none; b=fADCx7KrUvBFqo+NOAwOwSRAXyUTZlE26eNU4EgrQWnM9qWsI5h0C9xXXhr9YZMEOoVplUTA1QIl1wV0RCaXzU6rQbiIfETeeCzj9FQ96tHkDTlY445+AQ8QxnZgmVAGoz4UXWsvy2u7qihc6jKuCIhKubYtDillNKmeHM5XKxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565099; c=relaxed/simple;
	bh=MTK4rF61lxedHPlxqaTvX7M7UgNYJSKfjyVeIAOFWsc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=rDjr643cNSuIr6kgPpZx+qXOlyS+2RkXwNbj3k+OVtkP7eXUjHEUMSTxcX0ljB7DTjQJEQR04YgEAp8R5qccHcmhGTzgU5VQwNOL9rhhAANB8xA0C+ezffU6Ds9Bsr7aDgcP3I+SP60Pd46A8ff9ox+9VhF2QnyF0LwMwKZegqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/W7H/5j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/W7H/5j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870291F000FF;
	Fri,  9 Oct 2026 16:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791565098;
	bh=CNcsDFRnHDQua7AYD0yxDovSECwIOwL3ZC83tFFwB6M=;
	h=Subject:From:Date:To;
	b=n/W7H/5j1DZmZ04pxfgNgPl3hLYX2+XB2CamXWdsSZ+DztNpmsrQwi6dsZOiZVbNm
	 9sCBxj5+j4pqW+myBmBo/gtZ2+RsOAi9onoSPCHe/B+dYxELITlqvm/Px5rbvjXYWg
	 +bF5yu432f2u1aFZpOTl48JUvgmDEIEuR4oqV6HIRP+eWJreh0Y50VOE/GNj/0a4Gz
	 eL9pMK2mjYCbvkLm3rECHliot+Ot23w1Y9kBbXSzzVEf32BlPb/CFaeagz5OE0sibl
	 PflJy2U8WCgr81CsK4r67/z0AbO/lxwaWs+rcjQCESLBO97L0JH63swVLvJcRxofoR
	 E++S+lzxGJsBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7753939253F2;
	Fri,  9 Oct 2026 16:58:18 +0000 (UTC)
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
 <179156509717.892068.14235979621474004578.git-patchwork-housekeeping@kernel.org>
Date: Fri, 09 Oct 2026 16:58:17 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] dmaengine: Support bus widths of 32 bytes and above (2026-10-09T15:52:52)
  Superseding: [v4] dmaengine: Support bus widths of 32 bytes and above (2026-09-11T17:25:36):
    [v4,01/10] dmaengine: Move enum dma_slave_buswidth to a new header
    [v4,02/10] dmaengine: Support bus widths of 32 bytes and above
    [v4,03/10] dmaengine: dma-axi-dmac: Use bus width capability helpers
    [v4,04/10] dmaengine: dw-axi-dmac: Use bus width capability helpers
    [v4,05/10] dmaengine: qcom: gpi: Use bus width capability helpers
    [v4,06/10] dmaengine: stm32-dma3: Use bus width capability helpers
    [v4,07/10] iio: buffer-dmaengine: Use dma_slave_caps bus width accessors
    [v4,08/10] ALSA: pcm_dmaengine: Use dma_slave_caps bus width helpers
    [v4,09/10] spi: dw: Use dma_slave_caps bus width helpers
    [v4,10/10] dmaengine: Drop legacy bus width fields from dma_slave_caps

Checked 198 series in 4.11 seconds.
This project currently has 16720 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

