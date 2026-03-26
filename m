Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571583ED5C9
	for <linux-spi@vger.kernel.org>; Thu, 26 Mar 2026 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525217; cv=none; b=l8X/vE1zRha7/I3kBsyfbErsOo5t6NIoXjPiRA1y0AZjmEWbaf8zGEUDs6uv/qieRnBC1W81nascztxM6Pv5XpaBjoOn1Q9fBwzoqfvYr4c6CvtOeDkVGgHWtnb8ekWO5gBy1BWVplAMClSCpLY/VUV2LPqITRsZ+lyAVbsTZyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525217; c=relaxed/simple;
	bh=mgTijGRO94mXIz6gBsESifz5zAwKBVr6BtGSwLQ+0QE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=OB7ziaq1psEJ5qH1BArgeUBm8vEXRiBJt5ufIwZAX7J/O5Z+w0KUHwUOffsIUC60Y4QFR/0mZDmUwKxnuhHTrXDelcp9Y1iwhMBi25io0JOda6HENf5W0BGaj77cOZnUKhxQcByWyTj3mugaWVnOz4L3X5aHGfhoS4wr74IcGrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlEhdMf2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlEhdMf2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC74CC116C6;
	Thu, 26 Mar 2026 11:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774525216;
	bh=mgTijGRO94mXIz6gBsESifz5zAwKBVr6BtGSwLQ+0QE=;
	h=Subject:From:Date:To:From;
	b=HlEhdMf24L+0gQtFDgAG1KUncpX67H57zKZNigSiWGGaaOE0fNcH9uw6rhfq8pcB5
	 s5dRzq95O/7UVsJaT2NhuMvByWxY+WaXhkPvDeh2szVo6MSP36DvysdQ+IQ5KG5ZCg
	 0+qVOyHYy+7UutDEFFNIFIEiMjkBCD3c0vxRP5pHc2SA5RdxBbNOyLhUDKmpWuRSmT
	 uF8pEdCbzNsId3UAvu1BwMLNSYOUt3l/c4e5OpnpExyuPe6BAEQd3XeQiOt1lbpCin
	 qKBVlAqHdCOLdQEIOCp2nx8EVn/9aZ6F1zDmxHYZZ8DPMUulmtmsLa1dq2sRX94Y+l
	 LhkKSUaP1gBFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BC85D39E961D;
	Thu, 26 Mar 2026 11:40:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <177452520322.2513064.15040645461088349826.git-patchwork-summary@kernel.org>
Date: Thu, 26 Mar 2026 11:40:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: fix use-after-free on managed registration failure
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1072375
  Lore link: https://lore.kernel.org/r/20260325145319.1132072-1-johan@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


