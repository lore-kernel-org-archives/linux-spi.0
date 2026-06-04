Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75933C37B4
	for <linux-spi@vger.kernel.org>; Thu,  4 Jun 2026 06:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556303; cv=none; b=GT27ryMcidny+kSn9Pe08tIL69wkIrvIAq9B86uDg7FMfpi0W7rePUMsLdHaK0VwyBgcASaMvp50WdlVCHd0d5VKRT+aZu/yW2Dl1ROv75ucWEMTNRyf0AlNLbwKrdqtzNRzGUdN1oaoqPEnZbG72/8hefl2zwLPD65vo4DZFnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556303; c=relaxed/simple;
	bh=MMM+/etK1PoaJ9S2++fEEKZg6Xlt/f7S+v+8QCDViaw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=bZQKr3XHyx+y80m49TR66mmDRmegX4kddrx+lxf2MJjjbQGPjacL3h6e98MpyVFpMVMznLjAdPNkT78pyFzDv1igjwDWCkFkY7V5G0oltyNCMm/2Vxo8uhnWnLmNw6hG81M4bE8PLV+tljs8AyBuFeah56HebJGEtYPH7alsifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZRnydFv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZRnydFv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9414B1F00893;
	Thu,  4 Jun 2026 06:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780556302;
	bh=Rm7wn9aWZEmIiZbnj3TLKq61TF6BI8kNmHGwpdAG13E=;
	h=Subject:From:Date:To;
	b=eZRnydFv6RpQv5DAlfSrFI+vGsK7lTV3WYqmi/lS0U5yeefBtRtoEXP34HEZsTJR9
	 j8L8uWtRcSm3mHJPN4pJhPRPFDwazDI3xeCnzpLlxks0YM8TS9tyYparnffr2L2tC8
	 IvuhKh4NDfIg/XjK1l8zyPdaZdDgSiV2Z+CdS2ecY7CMey4dYlyfhsWacYaH+GEVaF
	 MTxQwLq7aNs2Y+3BYlMh5VE/bymhQZ2XKUkGYEiF+0mUXmyiftrAfwYD08uSOykhXf
	 6v4DApuCI2bLrHWZEoBCDW36ns5X3KnsGNySrrWDoTWvWTOX440pq5ULVRzqPatBeA
	 ZyyShy9CKG0qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D221B39308F1;
	Thu,  4 Jun 2026 06:58:24 +0000 (UTC)
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
 <178055630351.2278026.1169850939079405577.git-patchwork-housekeeping@kernel.org>
Date: Thu, 04 Jun 2026 06:58:23 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Enable SPI on SA8255p Qualcomm platforms (2026-06-04T06:50:34)
  Superseding: [v2] Enable SPI on SA8255p Qualcomm platforms (2026-05-30T18:28:22):
    [v2,1/4] spi: dt-bindings: describe SA8255p
    [v2,2/4] spi: qcom-geni: Use geni_se_resources_init() for resource initialization
    [v2,3/4] spi: qcom-geni: Use resources helper APIs in runtime PM functions
    [v2,4/4] spi: qcom-geni: Enable SPI on SA8255p Qualcomm platforms


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

