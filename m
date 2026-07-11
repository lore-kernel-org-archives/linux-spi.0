Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2C315E5DC
	for <linux-spi@vger.kernel.org>; Sat, 11 Jul 2026 13:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783778313; cv=none; b=aOtbRei0LpijmlTjqJtN2xX7LtKBcoZAcyoDLNnN0fjo52tk1WfDT3MJshbuPqEsFB+XkPjT0ss4dtL7zcLTwlFtyCvZRc2/2zTiCGjxkEjvjBiNHMBeaFh40Gc66vG7JXhtcoD85F/VAetWhjqnRZe0CZ2uiw+P9bs/H8I4AB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783778313; c=relaxed/simple;
	bh=wYdzJOR4pBG7fS1Fwr4gW6LnigjAxXAR5tRlrCpou3U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=hfGVZ6znmR05oFgp4VdtZNIIc6Q+fCu3PWQ2NXon9BD+KJS0zu9HRvnXjIR+qnuJvhMWwdswXnLmyk8ZE8mnC4MhcjusZmxV8iPCAVizjM+ZMc226f+08TkxWUoEeNcLO+S+9VnvlqShLfw5jAeiCKw5EH6e27PngMYxvNvXt5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpEcAkxj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpEcAkxj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BCF1F000E9;
	Sat, 11 Jul 2026 13:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783778312;
	bh=lgpnKXBMBj0xBnwUBWIcfryfZhLEbnXDk03KMH65Vag=;
	h=Subject:From:Date:To;
	b=FpEcAkxj0dbV4GoEE+l0QsNKWH/KlpSkOS/D7xI4rSqaEXDwadTZkfYpjtziUaVpD
	 skavxgFNhu5V1jzPl6duPJep5aeUB41S5Rv42dVCjuBJhvFCoOedVdA+4clHDCRptH
	 oMbaI9qfaTKNifDHq3JmA7Z3mA2Y1Nxb+IJ17CAdkMPLu269LTN9Oeda+rRJFLcVFj
	 yVMb1iydyCXFe6dHUtynjREygO1GnBt8Tlfqft9yFx0EpmYIu1l7S186cpdUmmzS3X
	 63AUHBQPqS1vQJ/TtzTyTmp2Dq/7FkC3A0kZfiSqBg/xt1C9+5C5yF1Qs+QdwiybiC
	 /KoGkLdjbIZgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 583B439244FB;
	Sat, 11 Jul 2026 13:58:10 +0000 (UTC)
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
 <178377828891.1116146.11492544306770281869.git-patchwork-housekeeping@kernel.org>
Date: Sat, 11 Jul 2026 13:58:08 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] Input: applespi - cancel pending work on driver remove (2026-07-11T13:11:38)
  Superseding: [v4] Input: applespi - cancel pending work on driver remove (2026-07-11T11:49:35):
    [v4,1/3] Input: applespi - cancel pending work on driver remove
    [v4,2/3] Input: applespi - fix NULL pointer dereference in tp_dim open
    [v4,3/3] spi: pxa2xx: disable DMA for Apple MacBook8,1


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

