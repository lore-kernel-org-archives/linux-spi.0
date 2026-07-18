Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E203043F0A1
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784383120; cv=none; b=ZlT49px/7yU2oeQ2a+AfXpv2yQ04llmcTzjhiUFB1ap77XK+aUG7Nji6LYMec/dZ/IawhY6zkJjOKDg6WBktU8QfCVmGaDXR90A2h74xAfXuc1+ntLNDvqjN9Grh60IS79VJZE0uodXawGT+z64kKciRPCjVrBPmKNatuY+Xqeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784383120; c=relaxed/simple;
	bh=rKEkzbswW8hDmwhkYA299KkVjhO+yi1w5j/LSUpVjRU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=S/GpZe9qJTRMKMjRVZ2k6L9oEhyVvdZ2TonCFWnJu4MmgqNrI/dKwQ9VOReuDmKrEwE0EOmfBsVqCuJA023W7ygwyr0BJj8dyP5ogHM6hO92rM8jOk5q6IhrjPmPAu+dQma6Zs6eY5ADOWYYjylLtmH8RTwxYdo9YZL4icXl4es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpFEvq1F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpFEvq1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9571F000E9;
	Sat, 18 Jul 2026 13:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784383119;
	bh=qazcm5+Vl/8oe6lXZ2X+XXjGyr5a02bgLF4jEaK53Zc=;
	h=Subject:From:Date:To;
	b=lpFEvq1F49wXB+eIIV1R4rWyL8kmHKwgNioeAHGfrwN+xMMJ/H8aCno4n6V0l1oEP
	 fHrjp+SQnE+SPxZAhqFPdk4SQlj3GXmVJpxiwAF3bCx1vmdKj0W9ua4hHP1/SzNlaj
	 FiXb+MAabN73spH1OYk89zic8E38Q1uxTQ+7pPUZ90CTvzAEIAfOvh1pynsCOLai7i
	 H7eu7VIAamyiBrKblB859+nebXZ/MViwTaB8Y7Esei0q4zd9cLF6BKDESb0vqRnn44
	 MsiOpt12XH1nlN4ej7XHADL2G9Y2kdfAFvJlh1WC3+zaX8h4fsgsXIyd27QiEaxDMO
	 O5ZWsW1I2I8lA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A4C3811965;
	Sat, 18 Jul 2026 13:58:12 +0000 (UTC)
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
 <178438309112.2500105.13412125335027912387.git-patchwork-housekeeping@kernel.org>
Date: Sat, 18 Jul 2026 13:58:11 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v10] spi: pxa2xx: MacBook8,1 quirk, runtime PM, and LPSS S3 resume state fixes (2026-07-18T13:14:28)
  Superseding: [v9] spi: pxa2xx: MacBook8,1 quirk, runtime PM, and LPSS S3 resume state fixes (2026-07-18T06:10:53):
    [v9,1/3] spi: pxa2xx: disable DMA for Apple MacBook8,1
    [v9,2/3] spi: pxa2xx: fix runtime PM and interrupt handling in PIO mode
    [v9,3/3] spi: pxa2xx: restore LPSS private register state on S3 resume


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

