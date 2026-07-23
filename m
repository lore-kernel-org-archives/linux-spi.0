Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952A63F1ADD
	for <linux-spi@vger.kernel.org>; Thu, 23 Jul 2026 07:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784793546; cv=none; b=BMEShS5iyScc6xOdXIicMQ5vIKYY+UeM1gad723d9d3PEtewRepJIzkfi2pNdfYDN6BvvmPTmKUjPm865Jl6cUlWc5PXksKA4zq4NyIdeKurXTclVTOhgTWMVpj1VQ2JS3fbXQTuq4ocYAdoo12eQ67wNz/DdedFLFnOhz4CrDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784793546; c=relaxed/simple;
	bh=g9EtoUSV59DK90xk3yf8eFzwAcNjQazDYSmShf0GQKA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=CoBkI6wn6xLO6PWWi46I91XH+toYkSmCRWCXUbOH6VTVFf7W2+TP+qEe0USXATB9wKcnC3t3N87MY3sj0kAHPMoWPSggQeWKS3bfUncRZKJ3TSH0cypC9CJrWNNIG0Aq9xLnvPim/aiYnPAX7ocqEajZMW6XwnY+7LPuONNillo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXnixZTK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXnixZTK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8521F000E9;
	Thu, 23 Jul 2026 07:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784793545;
	bh=9kbco0XKcfOAokrjUier4XVRhL9qTQcJ3F5vrpOmjOc=;
	h=Subject:From:Date:To;
	b=kXnixZTKOhMnSwQ84m4FGaMZn5gYvjEfTT7Rq1phg9JZGnmWYfUbAEArxqAZrp2pZ
	 Znuth9jJ1XUPRwpE2IvhAAuUeZTBM934e5k0G5LKmXzLP6WdcIAx7QE1RQrwzZM+Sh
	 QJHw5DgN6JFbxVLxfRLGZFObpZgxqmtCdcSbjVqPQOM9y38ElP5cS9XnEOgKI/MRoR
	 gekNf+UVjOGq/57CrFF2Cw739Af2+uMAc6+sCYOATxoAoJz+fMtUserF/8JMAvshVW
	 UwWgVLfR/TbFiRF5r+9jTQoMrdR62CM2uIMNtB8XfA3E1AzsL4Y5yFBCGcYKVoPdOR
	 jWpwapCT9HTwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A7D380CFF7;
	Thu, 23 Jul 2026 07:58:34 +0000 (UTC)
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
 <178479351333.2191789.9122832378128213571.git-patchwork-housekeeping@kernel.org>
Date: Thu, 23 Jul 2026 07:58:33 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: add support for Amlogic A9 (2026-07-23T06:43:41)
  Superseding: [v1] spi: add support for Amlogic A9 (2026-07-17T07:49:34):
    [1/3] spi: dt-bindings: amlogic: spisg: Document A9-specific properties
    [2/3] spi: amlogic: spisg: Fix the incorrect keep_ss of the last descriptor
    [3/3] spi: amlogic: spisg: Add support for A9 controller features


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

