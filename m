Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C657538238D
	for <linux-spi@vger.kernel.org>; Thu, 12 Mar 2026 02:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773284254; cv=none; b=gQ5s2XckcR2Z84LeVr7BBgBYCBxhVcTaNJ4VX3Ohz1K+VXX3ysVyYHuHiNkDUgzEh3VrYWs2cTnwQSSjKRxsKP2X4EhuftDN9IHIxQRKgJNYijz/CGv5KnQh/ah4pO+h0oZHrnz0z9rDeQ47A7dHXXWjv7lKvxpJuc553iJVcLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773284254; c=relaxed/simple;
	bh=D2EvwPL2IUS0i94AqldBxKtxB+yWnxvKEnv+QL3az88=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=QJXla92Dp1TGLFpjMqmiXj1kUEdNFcZSsA/Ns4Hc+FehJE/3uZ4BvSGeB7e7UF+DZ3rbWIf9EolxKOiXyYBHnx20d9AmVVMeXx+yNofjPaO/xmRF9L0xfYWzhg7dUjPBBl7/nr0SrneDw2SqlxnDa0sIYtnXXXhHpCxr2qBfetg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICrRhLQO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICrRhLQO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A085C4CEF7;
	Thu, 12 Mar 2026 02:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773284254;
	bh=D2EvwPL2IUS0i94AqldBxKtxB+yWnxvKEnv+QL3az88=;
	h=Subject:From:Date:To:From;
	b=ICrRhLQOQlvv0oZCf1MxY6EokB1X1DehgosCoyCQmW7EhHPJ6yjaQXE1u1GYhneYr
	 fttxyAegBKpR07Yp/Thto2I1IritzHJ3gbRonh+4qUGn5gYzoDgLxcNQtfrwk+u8Hk
	 LTptSRar3B+v97G+oaKR09rIzti2vi1EYuRdCeVEOSOhgT8V1P9lFAs6sevSdGBWYW
	 35cDEmBLPX1Ply7fry+WfheVs1w5YyiipTb+rvAEA76/RrEXF0hJ83KqfG7lj0Qcq1
	 pOnlORkfJuULGdyQRuhaAJVJMJR7A+v1mh3tI5l9styQYVd27sqAUYNVLpE1cnC84e
	 fCv89k2Brk14w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0595C3808200;
	Thu, 12 Mar 2026 02:57:31 +0000 (UTC)
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
 <177328424964.3917549.18305370538009536980.git-patchwork-housekeeping@kernel.org>
Date: Thu, 12 Mar 2026 02:57:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: atcspi200: fix mutex initialization order (2026-03-12T02:47:55)
  Superseding: [v1] spi: atcspi200: fix mutex initialization order (2026-03-10T09:55:47):
    spi: atcspi200: fix mutex initialization order


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

