Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14502F6900
	for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769075792; cv=none; b=rYweBo7WfRUaXjSD5a705AQYFSCWzTkA49Yev6JWbFnHRzL0OLAZ6BUXY0zhpr37J0owo5mZv6GsrDMFemgMNsb/4dlV9EMzAZLf8PfdaJnLFbTJY9fBtLGbzDliHInzztqZDrkMkwi7FECoCCR+taqZXPuES2PYjJK508u1JyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769075792; c=relaxed/simple;
	bh=+qcOtSk6fcvff265Xx1+SjogAgl5OaElGK2ewlpAWyM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=PypwDir36Avq5RpflOzKlFGhvXixIrSZPsiaXwM6O60p7k08zSoHAYckNv5W+yqKcmpjOZv1l32oWt5ZuhBNcmPzMihzJSzqUdN10pNWEbOpEx/mpIkmD+Kn5bSZcrG1sHJBukMucRhJD3DlHH0FGS6Ej8Bbje/GnsM0dk3w3Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lm//WgTS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lm//WgTS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B4FC116C6;
	Thu, 22 Jan 2026 09:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769075792;
	bh=+qcOtSk6fcvff265Xx1+SjogAgl5OaElGK2ewlpAWyM=;
	h=Subject:From:Date:To:From;
	b=lm//WgTSus0HssJqMzg4gj58abl/lZ40QvMJ8ZlnakXZh+/RC7/W/RAM+l6zpxdIJ
	 06090WtCjFqzYGOw4TIDv/6iLd0SoA5cr50vcpQuVrSAV+HeLQJ5HnfWhoHJ4UBVAz
	 lQpLmZOkA7miVuh4U2gOMnJzUeAVhnZhHGyV4rjJ0BJ5BPiV5O3/7GklrWjYVCy5sI
	 5sWgxSdfJ4SLV/XH/1yIFTdyX3cSlhKGX+5LdEP1ZDUzbxvZ0XRUMZ1u8Ezz5h569t
	 zjP7EM3jDuYk930bUSZj3Rr5UGBFot259mKXACMEgAn+6ejQ5/LCkiH9fsHHgd8Nfi
	 MlUYLaVXlCqSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11D1D3808200;
	Thu, 22 Jan 2026 09:56:30 +0000 (UTC)
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
 <176907578863.1643286.11131424886693414564.git-patchwork-housekeeping@kernel.org>
Date: Thu, 22 Jan 2026 09:56:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: xilinx: use device property accessors. (2026-01-22T09:00:29)
  Superseding: [v1] spi: xilinx: use device property accessors. (2026-01-16T23:35:33):
    [1/3] spi: xilinx: use device property accessors.
    [2/3] spi: xilinx: make irq optional
    [3/3] spi: dt-bindings: xilinx: make interrupts optional


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

