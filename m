Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030377;
	b=IEpTdasIEzOXf69/pz3I5X76KHXuPkRse1CUOvKMDeHd2V2MzDU8BK8NwgjGO77u1fLc
	 MTltW05QXZWMtvTN2V4qgVpzM3EW+1P6pw3bf6SKsm85zM0PzzO9KHuAEH1A4DJhZoaLL
	 bYlvu2MSJl5OnUI3wGYuuU4Eqq02ZQ81tKhmWZ0yYGVaAmrvPMvz7PdPPgYTUkOCYqutp
	 lImlbjKDEl2RXYSshgd7I32ZQk26BBE8JKZhXWvP2X7JXfAfYKSze/sDLzaUy3RvvXO5v
	 EjfLK1xCcDIfr7LtGsHmTTT1p+ffduq60piWMbXralqBB1XRXP7EQhc3hiGLOCOXGsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030377;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=V6SfYm1mCPKye1Aub/nREYN9LWwpnFxkGmdLTbpxCIQ=;
	b=oysvU4d/aCrjDM1wOew9srspjXt3in15UYTRFCwUyADYXrA3LOUFkg+e0r7JyvFy/Jfh
	 IZOSVw732u/E5xyTVWOUbbucyuOCsfb/a56c2E6bmORtUF0vpiLI9C702992pJGMooESG
	 LHIZ6DU+HZcjJt1eTKdMElTpnX5/RVT3UWD/PAg0CDUTA6+lkAFFH+Ds0QfQHZ4XBZRb0
	 Cxn1UTELuMmlg9HTyms8OasjM7K6Gmyy/EBNO/Kr3ihMkBy4T+gqel/65Sn6RP/Y0/RIN
	 GqogrjIYi2dROiDbxWPwzDkjT7029TkV9w4gJasKpUaietZSEPZXn0hSI+MOp1Cjc/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b2xMt6Pr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2259606A31E
	for <linux-spi@vger.kernel.org>; Mon, 26 Oct 2026 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b2xMt6Pr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A80C1F01825;
	Mon, 26 Oct 2026 15:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793030376;
	bh=V6SfYm1mCPKye1Aub/nREYN9LWwpnFxkGmdLTbpxCIQ=;
	h=Subject:From:Date:To;
	b=b2xMt6Pr7hQOUhOvafJVHIz1QmlNajHBlHP0hXnANtbxbYl/0ZY+xifRrl1fONQH3
	 CrVkRzwMnhMolYbUkTvBK7a+/it7t+fiRWhLWlWCH6lfdPpvaXpH3n0v9Z/reGXFkK
	 9bF7rUE8SOKh651GbypIgB5BvYx/Dq23dBjHZt0SNUxxHKelPvBgHFYbGvF5BPHmNc
	 lGGaZixrHTBUXr0EoNva5CYYnyRbkpYUSkXxMH0ZhK+WA0ehrTRBk/rHWc5jT6mKA7
	 MprtclNNmzB2GYviAVAtFiFratwpIS20WGhAA5DwTFNW9t2RDy2R7gqgK80noo1iYw
	 GJiTTTho6lPag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 814D239EF95E;
	Mon, 26 Oct 2026 15:59:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179303037523.3248585.18028861186726733161.git-patchwork-housekeeping@kernel.org>
Date: Mon, 26 Oct 2026 15:59:35 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] mfd/spi: sprd: fix ADI transfer length handling (2026-10-26T15:32:51)
  Superseding: [v2] mfd/spi: sprd: fix ADI transfer length handling (2026-10-15T12:33:12):
    [v2,1/2] mfd: sprd-sc27xx: pass byte length to spi_read()

Checked 199 series in 3.90 seconds.
This project currently has 16829 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

