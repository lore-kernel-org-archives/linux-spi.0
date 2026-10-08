Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315BA26B742
	for <linux-spi@vger.kernel.org>; Thu,  8 Oct 2026 01:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791424753; cv=none; b=a/1lPINeChZ86fQcPbpaVvG5cE7uZyi/S5iiT7sD6DvGAHAu8pKP2FXQTUP3ALHIen2XwcfVfxZTaEj7R8qapB4zYsn9su4UVG9ESBKsA9yehzP34A+0FQhhhI0oC8SmVrdHRb5xpbUIhZMblvWWCU0Bp6WK5ZdsugqFOtGDq5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791424753; c=relaxed/simple;
	bh=hkpZ6td0pI8y/J/0vfh2jRc7Bq+PJyGstGCmgAsTPrs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=P1rSEOb/pUL+CgD2ZIV371Z1j9UdihwNd6C09ILBXWOCyAyr6xiUuS4l/uWreg2x34a/uBmA9eQhZvrLFWwX43j0+Jj7tTpD+NmjQWVvuoUOCdsyGP8NEF6hFDz72HW/9wleGxnE4tHAx4b5LZvEDJ4UhdNIO4/duFW30FVXsec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZEd/clc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZEd/clc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C601F00893;
	Thu,  8 Oct 2026 01:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791424751;
	bh=5lCnojz0Cgspx/arjCriJIlZuwJk/izPNrAWrpkiGaM=;
	h=Subject:From:Date:To;
	b=VZEd/clcThqype/Z2POipvtGuDwPTj8ekyX3MU0MJU4qgQvLgov7TpfNdiJZwG4QN
	 upoQdy/r9CPxLCcU9ADzfkBMUafVJYH9pnd3eFakqc4kSPbH7eqefdanM74pApIlD4
	 8lC3rYPlG58sc/9Tf0SrycYS/Z96PhAA+YbHKVxj2T7+pHF5yEm/5Jg4Uwts8FUleR
	 RG0FOsc51Vh6HJIULdCLVxfGEC1ofpzMtJ2zwoVGUZ//9R3gXcnwAUdn2CCyXHMfTU
	 44e3uUyQ5LAh7FAJrjQxSUoen845x9RpxXD+96y2SyuM6aekIEyrfmimGUogAyEXju
	 MmKycas/LCBAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B71C33809A08;
	Thu,  8 Oct 2026 01:59:11 +0000 (UTC)
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
 <179142475037.3768263.17161996800476374663.git-patchwork-housekeeping@kernel.org>
Date: Thu, 08 Oct 2026 01:59:10 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: dt-bindings: snps,dw-apb-ssi: Add Synaptics sl2610 spi (2026-10-08T01:00:58)
  Superseding: [v2] spi: dt-bindings: snps,dw-apb-ssi: Add Synaptics sl2610 spi (2026-10-05T15:22:30):
    [v2] spi: dt-bindings: snps,dw-apb-ssi: Add Synaptics sl2610 spi

Checked 195 series in 4.17 seconds.
This project currently has 16700 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

