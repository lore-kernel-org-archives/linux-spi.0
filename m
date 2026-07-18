Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3463B43F0B5
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 03:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784347109; cv=none; b=fa8vDLyRc5lpQQUbDjZjqr+Dt4wwJlcWOdhqk9WesT3g+aXh/5HEUthgFZxBK6h7euqg6N2/to23D64QDbs2zDZc0WG4v/iOJp+0DJnFJyF8E46gUvHhksvfh0OyWjsX9MRptev0gjwlql8eeM0PhCRD2+rc9vTS/sUEDzrey2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784347109; c=relaxed/simple;
	bh=wTJkxZgWmrjF39fuef2FKZ4VQYKCCf8Z4Az+7XcGjC8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=PxIMX3PyrS8VfDdBdW4oD2oaZ/fI+2n/5a5e4CkXvjpZbxdaSfEfw937nTd8DVfjIEKgsGUlxj5MNjUQeXvlWITMat0fn0WU+4wA7kTZH2257xIIm6ZyaY5v6l8V3VfCXghlR4npCMtjzzFdpQlknoJWDskQgGdvuWypxGlsiLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCTrAott; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCTrAott"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5381F000E9;
	Sat, 18 Jul 2026 03:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784347107;
	bh=la3tV+94zakPUpVajT+ccJ/++B6aFIf3PttD/Uu0wzc=;
	h=Subject:From:Date:To;
	b=WCTrAottVEkXcU9yw40fkKnslQMNXtk8sBRwq91tx5EyyWlcd/nV/s1Jl3B44/Rbj
	 JdbPa1jH16WnL8UMigxV7lDKqxI5/6hRGkn+uaVqQvNt8VrqJzqBrFmrOxMN/ETLeI
	 HPXK8pJyRALtPXsT8bqUUDPTpP9iWeIDQvld3ba8AsGp7+3eE5eM5Z3piyUumcSG5N
	 Ent3J/pMUHRtz71hetGL4Zl71GkvYYHVv4lO3CyOIPoQ7OcJduWnaoB0P/meXihTFS
	 gmmm4MSBjtyqi6+EHPeqD9GSQnoLD8DYHQDxpyr6y6xGna2manOU2d9aNGlqVL5KzA
	 wi6HmbRAx9jfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D3F5D3811955;
	Sat, 18 Jul 2026 03:58:00 +0000 (UTC)
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
 <178434707934.2395831.11176849381813095579.git-patchwork-housekeeping@kernel.org>
Date: Sat, 18 Jul 2026 03:57:59 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v8] spi: pxa2xx: MacBook8,1 quirk and LPSS S3 resume state fixes (2026-07-18T03:22:37)
  Superseding: [v7] spi: pxa2xx: MacBook8,1 quirk and LPSS S3 resume state fixes (2026-07-18T02:09:13):
    [v7,1/2] spi: pxa2xx: disable DMA and fix runtime PM for Apple MacBook8,1
    [v7,2/2] spi: pxa2xx: restore LPSS private register state on S3 resume


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

