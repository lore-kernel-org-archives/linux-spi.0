Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298741DBB24
	for <linux-spi@vger.kernel.org>; Tue, 15 Oct 2024 23:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729036575; cv=none; b=OA7O7FdfyvcuejW3r+ZuD2uHpfo4lzsspG4gVDCee64PSh7U6lAUhKqEpWb3+OrxyXzh/DQw4i0Va2wOUkMGbQj2u2IIwC1t5su+JDzyo7fydcC4X0EwK+mWmto6QHQoUQ92INpCTTwsLIKMc6swgfH1n0yVwXlYxCYM2DB0e68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729036575; c=relaxed/simple;
	bh=NYyDil8fB3aiG+9IscuA/vzVadWqX9RyuXDuA/32pD0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=TJVR2Pr6ScQ29ej3tEpO0uGvZGm7vlm5iUmLANjqnt9Kv5DaCn0/3U1peHBsbyer5GrvA3vUA2YNBCRMPZCN8bicMdfQpulYbYKNKs6YBrzRDjL3/H+kzcSQtA8SsBBV5RXxgkX1kCW6i0Lve4Fi2HGnPMREpCKpq4MUECK7jyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUzcjOGB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUzcjOGB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB6AC4CEC6;
	Tue, 15 Oct 2024 23:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729036574;
	bh=NYyDil8fB3aiG+9IscuA/vzVadWqX9RyuXDuA/32pD0=;
	h=Subject:From:Date:To:From;
	b=aUzcjOGBhPxsz27nwulxTF+DYhp8OJBIHXcwhTjSjCKrqsUX+xRjnOxtDjlB6lP/M
	 mAGA3eQnOtYuFUNtZcwFKbDCOxJ7FvV5qwK/rmSvV41GbZvii/vbtQ6E+smRsw2bKm
	 GVAXsx8RhQiT3uGKUlePEhbKlq9RANMQkMGEHKZUSUrCBxgkV9cCm5tPbIILOlEG3Y
	 Q5XkGXE4qZZZ5vMw7WCzfx2hrlV0EO9yXNL7nGASYCBUBJ/m/AvQZvKahuaJ1eyZ47
	 4a2I4NbLeswVLP484yOe9V4qEJ5vhLO22KEvRSLSYCYYvpniwncicoeDBS++qn8XqY
	 mHeNQUJjygTDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F143D3809A8A;
	Tue, 15 Oct 2024 23:56:20 +0000 (UTC)
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
 <172903657946.1331027.4829769674672637364.git-patchwork-housekeeping@kernel.org>
Date: Tue, 15 Oct 2024 23:56:19 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] Realtek SPI-NAND controller (2024-10-15T22:54:34)
  Superseding: [v4] Realtek SPI-NAND controller (2024-10-14T01:52:42):
    [v4,1/3] dt-bindings: spi: Add realtek,rtl9301-snand
    [v4,2/3] mips: dts: realtek: Add SPI NAND controller
    [v4,3/3] spi: spi-mem: Add Realtek SPI-NAND controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

