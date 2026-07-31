Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBCF33F59A
	for <linux-spi@vger.kernel.org>; Fri, 31 Jul 2026 02:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785466740; cv=none; b=dV6P7NKgF7w/7Nna0PpGlel6Czh2OUkx6bLZr6n1tgjkk6xoCPg+d4RmuTioTink+ECiGjhYMd2+fR9BhwUQq5LfKdnIQ+Q4G1aBO0pj5dcjfDxgK/jdT9HHqipf+Te4eoK4E/UBnUUR0WgYlYMrayQfJaOCDglL/dy3F4LJVVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785466740; c=relaxed/simple;
	bh=KtlnsP7nNXD+xNIV5fB+si0R7ngCTbyxP2nEGwoG3e8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=WKiguzDdRLM5fU1uc7LEGSnxzi813DKsRBiGVvTaW2vNdqvPa9tv+iyQkzSdgKH59lv6NxD+vrBDxh5btwC0rkO7pOSdUeGlwrHhny1Z/za6mYJuwMWfzB3NhogpYoullTKIQrAn6WOUMhC2qNOXaalWw/lyu88INiOIhZvqmpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOpXbm63; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOpXbm63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AF61F000E9;
	Fri, 31 Jul 2026 02:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785466739;
	bh=+DBcCKm4n7UsYdQ+14X7f9ZvCDlSmReQ5lGYDAhKwFs=;
	h=Subject:From:Date:To;
	b=mOpXbm63e2Ug4KkB9UI8xS5DQON0FsSGkTXqLqdRgLCKQn339k6JL1fKdCtEUjysL
	 Nalo7R9V7mdGHmqxo2jcdtbCDZygoyJhw5+Ss+KvDXA35IAdvPj4ixDpv1FI35y8PQ
	 HUwmeF8oMNOCctc+eShF+Ns7cRl5Qba7Bx1k4LPSIbu9jBtKw0WJ/8bXwhZ6m9eJS5
	 rCSb7CX/wxpisqvgqF9ZQc1QlXC31jPqx9derajV1hCc9hUuTA/UpE7bKaK0JWSkVb
	 p2yr0fe8+FouKq5O4bLTy06VLsr7gc7ZSrVQewxa7h7psWu2rGiXfv+WzDhMMvRY1S
	 vhvzid8piYPDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 961753924477;
	Fri, 31 Jul 2026 02:58:23 +0000 (UTC)
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
 <178546670213.95089.8698977528168090622.git-patchwork-housekeeping@kernel.org>
Date: Fri, 31 Jul 2026 02:58:22 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] spi: ma35d1-qspi: Add Nuvoton MA35D1 QSPI controller (2026-07-31T02:38:16)
  Superseding: [v4] spi: ma35d1-qspi: Add Nuvoton MA35D1 QSPI controller (2026-07-27T09:18:31):
    [v4,1/2] dt-bindings: spi: nuvoton,ma35d1-qspi: Add Nuvoton MA35D1 QSPI
    [v4,2/2] spi: ma35d1-qspi: Add Nuvoton MA35D1 QSPI controller support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

