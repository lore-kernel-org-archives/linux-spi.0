Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4E33E44E4
	for <linux-spi@vger.kernel.org>; Fri, 16 Oct 2026 10:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792148310; cv=none; b=qgYHiytTpkVqh0fnlX70tRIBKFxS9RY+x/keLCuB5zmysZ8mefipbUviZSB8ZyO//lQlRN2uaMFJo3ikBKORALdaSXwyG1as3+rcZLM3beWW2iobRTwjWSc75GFVYGedo3q4rAcIHCVXyDDlNFXsDpIsixwlZLDL3xf5t8CWTQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792148310; c=relaxed/simple;
	bh=kT6NShAIYuoxBGjlDBtbRi/e2l1d7xX4MGK+SeitjO0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=P6vJPwziDiWlI47PbfM8UG+wAP/sf3s6YTm3CF05rTz9yqfk9pOiZQIx6x4SRjmdeZmG9SpL75B/EiOru48ouf8z1/QBXzSKww3SPV2pQY77rsVRATvt8K5eOb0+bs45eMwOx+8BLcXsqhqfal7qdQzmh5Hto1fcrCCZ8rGe4es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otSSic41; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otSSic41"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459BF1F000C4;
	Fri, 16 Oct 2026 10:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792148309;
	bh=Pq5nDbK2g6yD6JFO2M7pkiLqkCT9iVDuTP6jWsFjtIg=;
	h=Subject:From:Date:To;
	b=otSSic41MRlTUnlD5YgE7hJqZIxkaS7xTjvETtkK+maaVk1gfhCHVVtjRG+IeMbkv
	 BGtHoOca2/KSv2g0/2Kv5cZQRMHhrKI1y6aQGYWAObX8RnfH3dBNDb9Ik82gWutJgB
	 W2HO6SaFQ3ULhwotf20UZXGbFjWDC9HduikrTr33Fi/T6GUZeYAdRvnHCl11AJxIOW
	 dKZ+V32y9fEfaUHphEf/nchDAvxv/ZUzVicdOEZrGrZv+0UIdLvF7DEZnEKCbnL8aB
	 XVz4LUL/j7phRO6uoFJzRq5rjVxpQIOzhiHISYq39vrRHtI748LY2Mw723i5iPSkIc
	 EhplBIyHlIYDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3753809A8E;
	Fri, 16 Oct 2026 10:58:29 +0000 (UTC)
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
 <179214830767.228310.2664885260956055929.git-patchwork-housekeeping@kernel.org>
Date: Fri, 16 Oct 2026 10:58:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: Add support for panic mem writes (2026-10-16T10:29:10)
  Superseding: [v3] spi: Add support for panic mem writes (2026-10-14T15:42:54):
    [v3,1/7] spi: spi-mem: Add support for panic mem writes
    [v3,2/7] mtd: spi-nor: Wait for NOR ready with poll_timeout_us()
    [v3,3/7] mtd: spi-nor: Add support for panic writes
    [v3,4/7] spi: cadence-xspi: Clear "SDMA ready" IRQ flag after polling
    [v3,5/7] spi: cadence-xspi: Add irq-less support
    [v3,6/7] spi: cadence-xspi: Add support for panic writes
    [v3,7/7] spi: dt-bindings: cadence: Make XSPI's IRQ line optional

Checked 203 series in 4.31 seconds.
This project currently has 16781 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

