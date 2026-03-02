Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7702D3EF2
	for <linux-spi@vger.kernel.org>; Mon,  2 Mar 2026 06:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772434631; cv=none; b=A1VIsLwMaooz3CvjS/oiv6oa2Ux4oE6DxXYBWaHaLcaVpTLaxZK4tlymRfrvT826VOfMiPnHxHYCWqlXWFmm98xF3vzTE8hpewYhsCZxbbD6pPt4kyMrOM6xXIj90Ky/AlYZtWnRIG0JLxa3TzgwAww6gsOoMlPiL/KB82dbnHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772434631; c=relaxed/simple;
	bh=3+TMQa7tXRhr/AfK2skYv3zCcQ5A4ojjomKriQilbQY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=rhBhAVnxKGLeXWo876VgBriJaSmPAeja8hbWZlVNtJ9YSJOcrxYja0CQPqUbjEb+Zz3aCiyW/WDmzKDXaFbCo3T+Kua6cNbLPXiBRmNNTe+XgqZVVsamt56t//2QF47mmrStxLBwbuavJpj9HqygY7j+r5DCfAgbe9rPhqUwKRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaOGNDY/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaOGNDY/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9744BC19423;
	Mon,  2 Mar 2026 06:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772434630;
	bh=3+TMQa7tXRhr/AfK2skYv3zCcQ5A4ojjomKriQilbQY=;
	h=Subject:From:Date:To:From;
	b=UaOGNDY/VeYDsUNQF4vE1Yv0sNuYHa+TB/PzLHC+4nqC45DXbOUeZyb21ZFjmLR+K
	 T861rZZoaIz24za0FxfVTiXHgI8lMKZw3SixknPzK0A0mK3YJt3jY4QYAwFy3sbAoW
	 lAi87jxFt49Wh//pcmc11ZPBii2ELUyVnGDZT8W00PAjiU5A0pUOI0x7eEtv+/p4Mk
	 XDu+IUUrmHSZrCU+kcWyIJFuGith3NlpxH8EGGnDQXcd7TkJmB820LsHp6itTCZFrl
	 B2a4x8JcCHHl7S3MUFElu1Upy5Zqtmp9hO6EB4MdJPbt+VyB3lO1OvLg323Qpi3Yiy
	 tEL/SB3nvN85A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 045423809A38;
	Mon,  2 Mar 2026 06:57:14 +0000 (UTC)
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
 <177243463266.3936125.12479695752477030632.git-patchwork-housekeeping@kernel.org>
Date: Mon, 02 Mar 2026 06:57:12 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: cadence-quadspi: Implement refcount to handle unbind during busy (2026-03-02T06:47:39)
  Superseding: [v1] spi: cadence-quadspi: Implement refcount to handle unbind during busy (2026-03-02T03:10:15):
    [6.1.y] spi: cadence-quadspi: Implement refcount to handle unbind during busy


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

