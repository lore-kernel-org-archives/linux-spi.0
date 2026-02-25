Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC2E2E719B
	for <linux-spi@vger.kernel.org>; Wed, 25 Feb 2026 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772009802; cv=none; b=OwW/WuUApkWXT/1NlnDTT40eotSbwffgeTKb6Ok/PpxJF3qFPDVQUi9iUoMTAEH4hbElk6+SHQEg0HKnUn4hBy0wEP3n4ga1DzmMZNykVOTKDutX/W8xFzbF2sd+TrRnUgDwf5Ra8jThvR3+UBzxrttW8WzsK1womreWa3/cK8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772009802; c=relaxed/simple;
	bh=MUIgmvbQ6XZr+jvOJRgZn1v+U7r8DaWzI7blduBXGR8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=qRMAht8KNXYetW8RYcx9v/ZCTXtutsv87ApAeVS6KXxWpRbbBJeMSfaTboXM+VkHQEU9hHAsOmKJjP+xnvkjj2BpyQ9A0h6coZt5QD8BUsLSrhdqvO8oBfeeVMh5KzeAzqEQ7f2Bk5JoA85ZQJWpS8pRAeag3GT9W+csfBOCL4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVTcxxLX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVTcxxLX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A5DC2BC86;
	Wed, 25 Feb 2026 08:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772009801;
	bh=MUIgmvbQ6XZr+jvOJRgZn1v+U7r8DaWzI7blduBXGR8=;
	h=Subject:From:Date:To:From;
	b=uVTcxxLXLyqPxRBEDnbaq6uceuafY+3G+8Q5uR5mKdxgaBFQI8tOXjWCWtiyguikR
	 7l0KEYf3Dc6mEquEyMKCbJXdXPrjcmZILJWndapmNmIIKAFkGPtrtIJcq9xhxuZN1s
	 ftxBvC34oNUuJLdPgCBe62LutfYlPCrlAMLjwGSO+Qz9pXXBZ5bxrCebgpCuaIHAuM
	 /fB2n+f4uzzbOlBSaWCT5sa3jM9DaZdArRkyjbVkkMy3Sa9nj6hIfOpmHvI+ciw8WF
	 I+lm16ps7M0L86bvWMxn0X1lnbBrs5Sptk3BCXW9nTNSC+P7OYIC5m406mtaJU1ucj
	 h939nM+peBIuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EDE173809A0B;
	Wed, 25 Feb 2026 08:56:47 +0000 (UTC)
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
 <177200980666.213668.10218584091453334451.git-patchwork-housekeeping@kernel.org>
Date: Wed, 25 Feb 2026 08:56:46 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: cadence-quadspi: Implement refcount to handle unbind during busy (2026-02-25T08:02:39)
  Superseding: [v1] spi: cadence-quadspi: Implement refcount to handle unbind during busy (2026-02-12T08:17:43):
    [6.6.y] spi: cadence-quadspi: Implement refcount to handle unbind during busy


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

