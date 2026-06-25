Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7766732B11D
	for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2026 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403577; cv=none; b=IIqlSsswfi9GlY8fCNH8LUDhDCk7ThCnKl1QRNnIsM4hbuV7QieKggLqrlQaBF2o/D/3XCiSgyhVp7Y3h3LJPRv8sGdAIzNUHvcP04asS85Y3MLVs4kYGljWnjsMU4jZ7qc70/OlxHtLGZicilTRS7eSRy3MW+oOw4ttGPHT6s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403577; c=relaxed/simple;
	bh=ZcJLwJfw4peiKjOnHc4IYjUADsHV33LNx1mCv9kuV6I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=T3Z/8bUNQntao3qldtgKEfnwKw1GXMZkWTUuMN+sa+YdQB0KP+CKdM73/k33n0y/K/pLiz93Lx/EqRlVfleXiqh+A7t1mFGsvoOAD3nrFXKbquQpx2YhJCIRytY1r1S1YKHdDNidttYRORJyYhHo5DtJOHvAfygsN8N8uAMjUoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpsNQeur; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpsNQeur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A606B1F000E9;
	Thu, 25 Jun 2026 16:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782403574;
	bh=f0HWeEvswssx88eoV6s1Y+XV6h6vTrEKUNnSOguav/s=;
	h=Subject:From:Date:To;
	b=cpsNQeurUwbwVgoiHrys3lXEKSQ56iMVYhC/wpdR4vdWzXeakzNB2khFmIOyCwn7t
	 zl8k17W//inWIK0zeF6qaM3v/EEl6+p9GI02X3IE/AMmbefilmnO6q9YW6zEQU7dg2
	 2OQwdbjJAPghd+wNqjbuUFdwV67fPiFqzsOFi3RaXEUUo9Aurqs9acY3/DJFTDs6P8
	 wOVP6z3yICivvkGIyK/Vlq908Ym39vbk7PZjUOpNhcTGcf7HwplZzfaaAnxajH5ixA
	 MnJPblF87IGeoKRtVfzAMEWhKK1FPrdQ0IGylRXzkvuDACfpdTrWEX0naXl88baFQY
	 zAtZ0ysNSC+Ig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7E7BF3ABD2A1;
	Thu, 25 Jun 2026 16:06:03 +0000 (UTC)
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
 <178240356226.3792654.8773818363097982400.git-patchwork-housekeeping@kernel.org>
Date: Thu, 25 Jun 2026 16:06:02 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: core: Abort active target transfer on controller suspend (2026-06-25T15:56:02)
  Superseding: [v1] spi: core: Abort active target transfer on controller suspend (2026-06-25T05:39:35):
    spi: core: Abort active target transfer on controller suspend


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

