Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48C22EB874
	for <linux-spi@vger.kernel.org>; Thu,  7 May 2026 20:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778187491; cv=none; b=mo3mAZ7FODT7WzIODxQaOcUSRX1aAszU+olOZNMnlgGgp5nd1w5tDTljMykMYMnQ7pFS2L4eJBEQk2IFRH/CumHHkY1+yb/nSbo6J/w+a3poy3KCBtiT5jLaqrOPvLniemo9nHeBFvLsaYANqSZWwsqJFMZvhgWiY4Q3oKMmw5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778187491; c=relaxed/simple;
	bh=yWmIObFX7JHwrgpxK1KB7lbjrzZM/WOXrZwunXmh51M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=WRGTpejp6t60v0AGEPBGM0jZbkK/xmlsXotCC5lbUlRfctAQx4S2eBMahxi/XZw3yBDBM/L8Ia2cmr2pVvPu9ZVeJFRkBXtrP1SUB6mA6W5FbIhtbFaKH+MCXG6kJty/J6pNimZUitlzYq3MMjf2Gibuw2YXdNtXMdTeqhb+9OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPnZWZmK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPnZWZmK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706C2C2BCB8;
	Thu,  7 May 2026 20:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778187491;
	bh=yWmIObFX7JHwrgpxK1KB7lbjrzZM/WOXrZwunXmh51M=;
	h=Subject:From:Date:To:From;
	b=QPnZWZmKZY3hnR0v2LrIi3fmOIQvhvlFgkqrY3uvH7QUcsvj5913jXr67PN40KZ4h
	 45WCsd6u+5BVnnsX6aEQBEnYD2s3u70ZAcMbTnzH6RwDfUF+z4KOzRzx6yMeNFRaK4
	 vsDQ04Rde95I1IvsxrcYh206tQaE5f6IEls1X342hWiC8Dfrx4OtPa8SD3GAB2CUBP
	 0o84ISBPd4LjKBPwhdEeN5nR35f6dUybYckUHqgUyEnWrvNENOIaZRoipA3zPsSWre
	 PGPTGrZ8wr25/n0ZUYiGDNITIAmG2HajHuWuQZTv2tBTbboi44p6/TS5j/XmKLEZ9k
	 J3OYL9IyzTUqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA077380DBD4;
	Thu,  7 May 2026 20:57:21 +0000 (UTC)
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
 <177818744037.4158961.10351374444536972470.git-patchwork-housekeeping@kernel.org>
Date: Thu, 07 May 2026 20:57:20 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] dt-bindings: Fix phandle-array constraints, again (2026-05-07T20:16:00)
  Superseding: [v1] dt-bindings: Fix phandle-array constraints, again (2026-04-21T19:55:25):
    dt-bindings: Fix phandle-array constraints, again


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

