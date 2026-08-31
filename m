Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA2B40D578
	for <linux-spi@vger.kernel.org>; Mon, 31 Aug 2026 12:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181154; cv=none; b=O6LsvP1Y2JfT/7z+XrV/NqM4SGFZuRlpuqoFIS458od1kmpMEliDX/9hGOjuZ0kbhg26v3dY6hhHpDdl6o1otTYdBvBSN5GrOJkbBpM6WH67b373mf9MCn+96IFOpxPLSuysv/7ttliT5bDg3ET6Iksu4G+cjBh4Xhs41gwdAbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181154; c=relaxed/simple;
	bh=Taojr6edCbIUmdQcSm4S8ISQsBAL5KpO/6kP58Wruvc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=DFYP7mZEiznr1saFAdVlfnYxhwlqb/Z9S4u0chmgesLeAtiytSSnnA+bx3w9+/E9gOLu36xD583pDlcy561NkKEXajnFaZ4ygbQsSetxTKhHD2iHkgKib2HXLJjW9ZmJyZQAPvehvIJY/4VNtOjCMtAaDORwIfECTmhzMDLPPqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFMcN3/2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFMcN3/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D251F000E9;
	Mon, 31 Aug 2026 12:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788181153;
	bh=bEy+VsXKMQf0cExSae2GSIjMsuLEpA+4hDkYSYYeYfg=;
	h=Subject:From:Date:To;
	b=fFMcN3/2bZkQpap5lLXhZ6+Hcb5vVi3X8e1qK0PBsOv8hpkmHfFrcYutc1wPOJRR9
	 VdMgyH4Ga3FiNY7Sem7GZxNJiCspYllwHO59VM4DkAT+9/arFyRDuSEQrRIzd4hSld
	 SwbXpvu9Q2P5B3ILAgERKsTdPZvpGy1f0Sp110En2DoiDcuxZyulsJYq7W+DayIbZP
	 Jd++CmH6+ua5c53BCTMBuJ38C8Irxgk4CAxb0iLIgMmniB1/khLZEXiBzIlgnZ0yK9
	 l9olNYTvkoTKlD4OkTDnzYf3qtvd6ieZo34EASc+ZOY3E0PWLUf4NrG4xTEGEVZsNS
	 DbonfdLPwsG2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19B2238111DF;
	Mon, 31 Aug 2026 12:58:18 +0000 (UTC)
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
 <178818109665.73581.13404038323810890467.git-patchwork-housekeeping@kernel.org>
Date: Mon, 31 Aug 2026 12:58:16 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Report platform enforced SPI flash write protection (2026-08-31T12:05:50)
  Superseding: [v1] Report platform enforced SPI flash write protection (2026-08-29T01:04:31):
    [1/2] mtd: spi-nor: allow the platform to supply write protection state
    [2/2] spi: spi-intel: report controller enforced write protection

Checked 167 series in 3.50 seconds.
This project currently has 16426 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

