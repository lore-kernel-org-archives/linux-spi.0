Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B4E3B27DE
	for <linux-spi@vger.kernel.org>; Wed, 20 May 2026 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779267486; cv=none; b=qUu4u4szI8GxX0sMZ5ra6s1RMlICETCyV3lm2nrwH0AQo+6Jtarq2SVdIQB/m+64xUqY/dB91Aj05ZBTc9rD88GNLtOirjtSMnilhsXUG+4quLZ/bX3D0Tjvc42YlQoj5huvu7qs+gacbgwQQFvd6LRBpFfsNqu1eUWaz9A+wC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779267486; c=relaxed/simple;
	bh=Iu5qm/FlMrbFqHuq9e6tqLY2udjZxTpXYMKIeizdl1Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=VoRkqdEYNkewcoautqaISSXpqaA4AOvqKFl1xiCEjuBS37+ky6KnEPJkWt0kdzTlCGY5uigCd/iujLRB287uKj4GsFj/n7cXesH9zPRrcm0ich+IRuumitvWvPN4PtETgTefryi8BNdwqIPMyKueH2f8Nxjc7urXekyT20Pga3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYrByAaw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYrByAaw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D03E1F000E9;
	Wed, 20 May 2026 08:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779267481;
	bh=3r9RCZ1ZNmSYxbiMckE4TIxjUaCbk65BpwIc5jaEgj8=;
	h=Subject:From:Date:To;
	b=EYrByAawYwYCU5jPM11Dvn/lCB1G4mA66sn3ooDQZGhy5EIA5yQySEuLg/1I1jP64
	 mguzYklaYlf3cim16zfeBhPgU++tBSC30AYQUudHIdCHkkpvUio8xtttJhY0O/vS3I
	 CmgQ6dwOsV0MuRo4qq1wgS7Ko84MwuvOr/+zjZFo0pg0s5TWSTDp5zLFU5Muc8A3zO
	 uxjRai2v26Pno195ixWsoEhadxZiVy26sq/1ak5YwLFpkgrj1akINFv6TGqr3eJA/L
	 z+6+d/pQJUgJLDNAG/APkMYOVEtvnX1pRl4jULWvMcXqfGMe1N958R7muUpXwnuUGZ
	 F+PGaQuJeCsdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569C939309A7;
	Wed, 20 May 2026 08:58:13 +0000 (UTC)
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
 <177926749198.3064745.10593129269633132491.git-patchwork-housekeeping@kernel.org>
Date: Wed, 20 May 2026 08:58:11 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] gpio: dwapb: Add ACPI ID LECA0001 for LECARC SoCs (2026-05-20T08:11:35)
  Superseding: [v3] gpio: dwapb: Add ACPI ID LECA0001 for LECARC SoCs (2026-05-18T02:49:35):
    [v3,1/3] gpio: dwapb: Add ACPI ID LECA0001 for LECARC SoCs
    [v3,2/3] spi: dw-mmio: Add ACPI ID LECA0002 for LECARC SoCs
    [v3,3/3] i2c: designware: Add ACPI ID LECA0003 for LECARC SoCs


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

