Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE34481640
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787677132; cv=none; b=Foiy4TekuOwnXeyTjT7dmslex3TVyYRKLaC7+bMerxBoz6lnLqHTJU2tHv+9zhtDOf/971pBSCEhZQ60X2sQwqhoHbZfP6Uaya5d3kupM442EEgyf9ZodhWg2ZZ5lHIYppBg9LcFRRsSViu8r11glhiWTIN+JGRLOTsXaxuYMvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787677132; c=relaxed/simple;
	bh=QTkqFsTuYpKmEP9VRimqCTDLeeAzkZ0iBuoB9F0taz8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=VmRbFUQIpf1W05MMSwy1pTLv1wwm9k5yVJ0vVk+fQBAw1S0P+j1KwdUUPQbAS/A+a7XrMY6f+IdAdxWrga8B8nlNysxvbg0kRADVHeXWn9ctCvlDRLkWKFgUwvYfG/Y+GAJUvR9hM1s3SA26UafhC4Qq6/iS4l5zSblRVcc4mAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHYK+lpF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHYK+lpF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FBC1F000E9;
	Tue, 25 Aug 2026 16:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787677130;
	bh=zMlhNB+mjCjJ2rzuQRW9VrTxFKsNkpOwg33GSFz8yPg=;
	h=Subject:From:Date:To;
	b=gHYK+lpFUzO0PMFQAQIR1Sw+IkY1BUcjj0KrkeTBqfKky9qjtozYoFUFdtNpAaZsO
	 f0boNn4FPdV+6O09rIAuX0OrxVDxBovh5ZFHN6eCxZGUWYGYD65HPtEO/4NjD3esvO
	 J3xy0izT3XyVPocig79Pyrow9rxboa+YVxNSaSY6r4TKMkDK0IN/myW57N1vqGQjO4
	 YD59iUCLQKLgu/iK0YlW7GxH4zv2gQZvs8bre8IujH9zUAjaxogIMC8YhRXnUAxzRf
	 kDkieWx1GRIJaYK6RcHYJqus+pLzxCgm3W1Is9TpsQJI0Jk9U33YB7mr3pPR9AidYx
	 R9E98L+S4YEYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A743924FEE;
	Tue, 25 Aug 2026 16:57:58 +0000 (UTC)
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
 <178767707753.3970717.17353092679695602276.git-patchwork-housekeeping@kernel.org>
Date: Tue, 25 Aug 2026 16:57:57 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: dt-bindings: microchip,pic32mzda-sqi: Convert to DT schema (2026-08-25T16:35:51)
  Superseding: [v3] spi: dt-bindings: microchip,pic32mzda-sqi: Convert to DT schema (2026-08-14T10:17:33):
    [v3] spi: dt-bindings: microchip,pic32mzda-sqi: Convert to DT schema

Latest series: [v5] spi: dt-bindings: microchip,pic32mzda-spi: Convert to DT schema (2026-08-25T16:22:57)
  Superseding: [v4] spi: dt-bindings: microchip,pic32mzda-spi: Convert to DT schema (2026-08-14T08:32:21):
    [v4] spi: dt-bindings: microchip,pic32mzda-spi: Convert to DT schema

Checked 161 series in 3.10 seconds.
This project currently has 16374 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

