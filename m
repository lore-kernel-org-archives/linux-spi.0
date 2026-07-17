Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AECD400974
	for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784307514; cv=none; b=nYH5L/8RCnsS/iadNkCSwoup/bEd//ZaR8e4QoGH+37IE+Q7vtxcOu0EIUiaVa7N+5QF8S78nFsja+HdSgAF7GsX3yADfDFDp5CHMowU+Ac1QhWCsIX8LNk/KOgX9tuSqYr2Lgj39ynyotH7duAsoJ9R0U+bPSWzekgTWAkTn4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784307514; c=relaxed/simple;
	bh=hz7ckpoEKniUToxGeBuKNoj8dyjKSpAbFfEk7n+SEHw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=B2sOSlexR27+WwOBMba8J9gPVTv1YTOBiMpSz9VqZvjQZ90pIU4da0jIpcs4JNiWf7N8/+Lvc9Y/eijd6BWdsHMgQHynU9/4/johzIDkTfldDtrau3Cgc7aGqt5pe0MFlPXDeiI7XnJJo5mavoJLl23MPPxRxys75U5mCLELiyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBh/kyeB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBh/kyeB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466CB1F000E9;
	Fri, 17 Jul 2026 16:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784307513;
	bh=cJzWt3NTFXqasBJU8sOk3qcvy7e8NZvEuoVEwncAuP0=;
	h=Subject:From:Date:To;
	b=hBh/kyeBaAxzTDEzIPqjf0Espvctv4KPwPy8W+yLFsK2jjf6OmNLfTMJi3tPNXbdK
	 1/U3idM24Pv10/ZlBdRWsx8UTW9ZyGBmyb8ZcKZbWHLWPW8lmgiEKdrd87e/ghMVXB
	 XONtNGM5y/BwamEkejAKHKeezaTYN6p3Yyy9BBTaidcVqyBeOcDIle4QP4SQzmZHWI
	 O7GaG5DFJD64JK/ZLNW96/ZlkqA9w+hfKI+T/v5lD63gikia6oo/dBzu3UssZKq+tz
	 6Eg4X6SivV7FI2VdLx6tovTkw8V5VgjhAZh3s+MN8hHGzsVpC6ys4XVmFu0Er0m4i/
	 NTYUl45z7dfcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D355B380CEFC;
	Fri, 17 Jul 2026 16:58:06 +0000 (UTC)
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
 <178430748530.1799574.8198283400365778251.git-patchwork-housekeeping@kernel.org>
Date: Fri, 17 Jul 2026 16:58:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: pxa2xx: MacBook8,1 quirk and LPSS S3 resume state fixes (2026-07-17T16:37:29)
  Superseding: [v3] spi: pxa2xx: MacBook8,1 quirk and LPSS S3 resume state fixes (2026-07-17T15:46:44):
    [v3,1/2] spi: pxa2xx: disable DMA and fix runtime PM for Apple MacBook8,1
    [v3,2/2] spi: pxa2xx: restore LPSS private register state on S3 resume


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

