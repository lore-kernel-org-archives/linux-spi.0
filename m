Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0AB263F4A
	for <linux-spi@vger.kernel.org>; Thu,  5 Feb 2026 18:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770317828; cv=none; b=aXFfZ7KmA6Y+5Je6DRFrIMHkKtzy+4aAAJpxRUcwuRZlPO1Y8Z/0CP8tMaXUkcu+CZ3UrRjQdrampBm5+6yM4dtOpY3YtPcw068kFbc8hfkGy5cVsxnVYfPBNIcFVucLKi4glPO27NUst4ezCDaf567nlG1KDOIiPSiHvKTKubw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770317828; c=relaxed/simple;
	bh=1z5SRBXOdTuwTR23tX8R9/KCEltJ7pS2UF3aTHhsUMc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=fqhc0im9Liwhw0JqvDOdZnvm0G7yNFJk5mCYkPyXHTuAJmeFF3rZfKihn2kFpvYNT02oho5rmBRJsrKYbI/hezVYH1FKh82glonj4UjEGxPmn3WitBR8GAdGcZO2Vb3VZW3vqZE2HNvczscOmmaoQ37qi75NQVaCAdKuB+bgBcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pp5IWmFc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pp5IWmFc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A821DC4CEF7;
	Thu,  5 Feb 2026 18:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770317827;
	bh=1z5SRBXOdTuwTR23tX8R9/KCEltJ7pS2UF3aTHhsUMc=;
	h=Subject:From:Date:To:From;
	b=pp5IWmFcZq7PokNt0NQAjx2jfyM2FYNe3EpOGugR83IwyFxDlqGCgJ3iauXaZiyla
	 zz9IdioX+b9qlnfd2mbWfw4G0YH5lWZ/oNV6FaWAsO45uPIsU8oMa0cI84ma1fh5Bg
	 E6GhYly3Z+l5SEsXok1UeznTsgzhXT/IGLojKgO2MQYAxIuiNQDN+eLeZjTqEa423g
	 7RISYzrVAUTiSZB84lwcPDbjH3+KX3wsFnN2NIkZjrh/JP2bKc2twsU4FZJVgSrLOF
	 hKLDTDgIAA28555Y7/ufb6PrhtZqfJziRcjnr/dyQZtAyHLG+YnVUA5HQT5F4nO30R
	 YORwadmzubGnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 855B73808200;
	Thu,  5 Feb 2026 18:57:06 +0000 (UTC)
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
 <177031782520.531373.17027062892174056779.git-patchwork-housekeeping@kernel.org>
Date: Thu, 05 Feb 2026 18:57:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] spi: cadence-qspi: Add Renesas RZ/N1 support (2026-02-05T18:09:47)
  Superseding: [v4] spi: cadence-qspi: Add Renesas RZ/N1 support (2026-01-22T15:13:25):
    [v4,01/15] spi: dt-bindings: cdns,qspi-nor: Drop label in example
    [v4,02/15] spi: dt-bindings: cdns,qspi-nor: Add Renesas RZ/N1D400 to the list
    [v4,03/15] spi: cadence-qspi: Align definitions
    [v4,04/15] spi: cadence-qspi: Fix style and improve readability
    [v4,05/15] spi: cadence-qspi: Fix ORing style and alignments
    [v4,06/15] spi: cadence-qspi: Remove an useless operation
    [v4,07/15] spi: cadence-qspi: Make sure we filter out unsupported ops
    [v4,08/15] spi: cadence-qspi: Fix probe error path and remove
    [v4,09/15] spi: cadence-qspi: Try hard to disable the clocks
    [v4,10/15] spi: cadence-qspi: Kill cqspi_jh7110_clk_init
    [v4,11/15] spi: cadence-qspi: Add a flag for controllers without indirect access support
    [v4,12/15] spi: cadence-qspi: Make sure write protection is disabled
    [v4,13/15] spi: cadence-qspi: Use a default value for cdns,fifo-width
    [v4,14/15] spi: cadence-qspi: Add support for the Renesas RZ/N1 controller
    [v4,15/15] ARM: dts: r9a06g032: Describe the QSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

