Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794143BE623
	for <linux-spi@vger.kernel.org>; Thu, 30 Apr 2026 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777546715; cv=none; b=QZUzVh1RHBRK+vstk6CGMFPRIn9KeFidASTDbSfjW53cDCKMiZPA/bbhMFL2+is56Wr15QopVR6qg+pr/H9akZn1JTxReUEecnRFbzaw9UDg1lnjtIHzIq+fhitCGrcOV9YBDT2kwQ9u7RCv24NCxliLW4KrqMkqB1ViaWjN1QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777546715; c=relaxed/simple;
	bh=XN/2so47Dd2R0vGyYvYQOUhmxNQcablFEQnpJK1EJxQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=rmPwnISinOYBrd1djgNIEwd63sdW+UrrIFVBvfhc19Mko+4VDkKCADfUlqOjmXJEeaRWMfHji4Q3sS6MGrE8ZWrrnZt3bmoVgi1w/RP1r1kPAuVhEPSwu6phBRLICJzLQhfabyithVGPkbw4SadP/a35jbxkBrRWtL50HQ7pCMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Il6DN+fS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Il6DN+fS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1902FC2BCB3;
	Thu, 30 Apr 2026 10:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777546715;
	bh=XN/2so47Dd2R0vGyYvYQOUhmxNQcablFEQnpJK1EJxQ=;
	h=Subject:From:Date:To:From;
	b=Il6DN+fS//mu5yZH0kD8SWXcpUeDqY+pWLegoD1MRNx4p1EBZ4qpDI5M2M7Mzc/ud
	 JdyVgMmdr1sdrDKjhs0GXTB5lTRyM1Aqg1U7tRZVHhEKa7Y7Oirm12W2wcKgC4i5nQ
	 IsONcDDiT9mhSE1O/yVtC39exbgCqKEcwWWvJ6iS0PAakiititLngjW0R9UtUudaE2
	 WWUyac2BQOebE0pbnLA2haIKXnjPCILozsY8RUpS31hO48K1BVFC8cmeTOfEpJ7Ct5
	 ioSAY/KBm+LYUl1Rrjz0zmnSnoBntYopXk/JiK4YmvpIpVLAbDlmaZObCecwVNlD9q
	 yywOoaQN1qVlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02EFC380A977;
	Thu, 30 Apr 2026 10:57:51 +0000 (UTC)
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
 <177754666960.2515017.15159236570316030965.git-patchwork-housekeeping@kernel.org>
Date: Thu, 30 Apr 2026 10:57:49 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] microchip core-qspi gpio-cs fixes + cleanup (2026-04-30T10:10:17)
  Superseding: [v2] microchip core-qspi gpio-cs fixes + cleanup (2026-04-28T16:12:04):
    [v2,1/3] spi: microchip-core-qspi: control built-in cs manually
    [v2,2/3] spi: microchip-core-qspi: don't attempt to transmit during emulated read-only dual/quad operations
    [v2,3/3] spi: microchip-core-qspi: remove some inline markings


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

