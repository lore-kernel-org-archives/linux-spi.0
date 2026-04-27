Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610A737B019
	for <linux-spi@vger.kernel.org>; Mon, 27 Apr 2026 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777301906; cv=none; b=dZCj6N/U3M0xJHUon8lg74dy5Lpj1fNiyUelH/02xZrUtHKX/+8vmvXMSna2i0E/c4DA7/Gzrn3exeElqGzrZulC1rBCIfvBty9dHLFZ2NCVgANvy3Ss0N8vg0iqO4KlnFmDJEPVL3BHT2bcxJH1BDryhNVSk6fR1TlX6AQlNA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777301906; c=relaxed/simple;
	bh=TPzzEu42qVWTHGblSXg2ZLoDYXfpmao5NIPjgxpHsdI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ux3rdZCt1ixbzu1JtjgwE/sTtBo0SnDt5IIG2wM94U5MyBqnLBIm5wCREiTgq5SJISJ+UHwZ/oki6XjvZ93i4HOMe+i1hjDm8oTREdWYLk59xmLGRnyOiBH+/S1LAM5aQALTBYqIAROvI9NDywbAD8sH1AC3fmMiMS3hkKkY8QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJGE6aQX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJGE6aQX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8C7C19425;
	Mon, 27 Apr 2026 14:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777301906;
	bh=TPzzEu42qVWTHGblSXg2ZLoDYXfpmao5NIPjgxpHsdI=;
	h=Subject:From:Date:To:From;
	b=WJGE6aQXvSbj/Own509VixXZG1ctjrODECqhNbviQo0diwds9q9g8dXlR0wmTUBk0
	 dywIbZWg75KQSpMDb3WvH6mTfjAkLQpElLTL5nKhR1nv1lHYTVkho3PPBEfyRHLzYi
	 7zS4sjLVEhwUaGCxi3E6uw+SKagx9JZc8XN5LUpOtfnGORf/6jS98CL9cmKcBWogED
	 M5dPki5TyHItj2ddJAB+p5TbVcwM4fPA+sAyuaTh5+oa4XqEVhst1vry93d5M/voDw
	 NRU2wDnyJ4btvziCQ1sW1I+mRM5EOC/YIRE6NUdSZxVQN9Kh57PdDtrugyFYVm3FSt
	 rEMj7BWgi8iWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D6F0838119FF;
	Mon, 27 Apr 2026 14:57:44 +0000 (UTC)
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
 <177730186350.3957431.12046953163866944116.git-patchwork-housekeeping@kernel.org>
Date: Mon, 27 Apr 2026 14:57:43 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v9] spi: support the SpacemiT K1 SPI controller (2026-04-28T02:01:26)
  Superseding: [v8] spi: support the SpacemiT K1 SPI controller (2026-04-11T03:04:19):
    [v8,1/3] dt-bindings: spi: add SpacemiT K1 SPI support
    [v8,2/3] spi: spacemit: introduce SpacemiT K1 SPI controller driver
    [v8,3/3] riscv: dts: spacemit: define a SPI controller node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

