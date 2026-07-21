Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798273FF8B6
	for <linux-spi@vger.kernel.org>; Tue, 21 Jul 2026 01:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784599126; cv=none; b=jqFFhPHKKRiS5tP58SzKYvSXyl1Q3VqoGZW8uN4ShpQXaWepr2R/Vi3TSC50gV9u21RyAVBvdTT6nQjBbX47Fr9yuQiQCgP6CLSCFbr5onOV2PxaKP6vIpXqLeSnJQs1zjUi/Kv8mO4pf+AKe2/aFQglDTvJz+lnebFeG8v63nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784599126; c=relaxed/simple;
	bh=ZLjHcq+QkzkmaB+P9nYerWcaRE3bcPF0X3AZkwWpAPg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=no+NZM1w8shUX88gUDN6VdDiCB2ye57o6aziMKdFhIqZsyYdv2SzH3MI/k9h5PPEF05a5xqR2J475WaUDS1b/DXqMfoPjS4320LfbzPDnfJIvQZOL960dYBmM6JCoewRsi5BVPyo9Tr8iHUKngOMHgqgYuzm5U++GN3hnKozIrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPrS3swf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPrS3swf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2A41F000E9;
	Tue, 21 Jul 2026 01:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784599125;
	bh=jaq5nUGHQkIWsZZCsdfoGRJJfgT970bcX0HQjgn4FFY=;
	h=Subject:From:Date:To;
	b=JPrS3swf6glppZk4TRzIkNrXbPBJfrVKs6lWCOv4u5K+jCRW4/fVQQFXpv3VhHUsR
	 BBP5ood+Ogw/DOYVP8Wjs8nB59iYzgu7q4VawfkH8YYbngzvAKKhUUMQDgZDmEGeHU
	 UjLl/Blll7NohqbXxcrwnV7UpVqtoLwTmvD4/36/iSN8cE3FU5jpgzivgud5Pb5jal
	 y9a0bQupbKYGevBscN+ylp+KScfozKwA27TfRzqMe5aAuEJ6yJe48ghc4zMyL8z9Q8
	 +auye7lcs3QZcBhXHVji05VgOLzgZtwI72GjBuDxyManmceB01O7rkXDwKGnAha777
	 gB8VTXD8XyICQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5949839244E7;
	Tue, 21 Jul 2026 01:58:16 +0000 (UTC)
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
 <178459909480.47206.2250253444241907509.git-patchwork-housekeeping@kernel.org>
Date: Tue, 21 Jul 2026 01:58:14 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: ppc4xx: devm-ify probe and drop manual resource management (2026-07-21T01:02:17)
  Superseding: [v1] spi: ppc4xx: devm-ify probe and drop manual resource management (2026-07-20T00:30:43):
    [PATCHv2] spi: ppc4xx: devm-ify probe and drop manual resource management


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

