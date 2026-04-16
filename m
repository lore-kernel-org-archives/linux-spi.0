Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6442B370D5F
	for <linux-spi@vger.kernel.org>; Thu, 16 Apr 2026 22:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776380278; cv=none; b=VP2YjaukSyhTscL/BKiJdDcbdpetuAxYf1mVODu23jmJrHSmkFhDVOSklaMN3ziToFB0cNgtHnWdn6UKEIjg9wGbCiNGPDBoiIXzHEseO4P/QhPtLZGxOYMKPsC5qaBGUaCXSaPdP/P2rN8ViYibMAQDEfvyq65+Ao2x6DAIg9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776380278; c=relaxed/simple;
	bh=50LjQvpUqBAPxmUV0wszgvpqYPun73ADpqKUckUrMhM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=V2+7P0VrVPXZVSXKwDi9ZsjXM2LuqBE/wZ5TJpHtYqH4kYnYZoTU081PNp3V+swsD/4DBWfXr6hcFBy5E/BpSlB2SrTjrSB1amGTRkJdGbXcq4p1JbYycB9cqFysiGIKV2TNN0htVuNn1sFNNithht/Flf3lqr4/avPrXWd04CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLmIItZz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLmIItZz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23994C2BCAF;
	Thu, 16 Apr 2026 22:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776380278;
	bh=50LjQvpUqBAPxmUV0wszgvpqYPun73ADpqKUckUrMhM=;
	h=Subject:From:Date:To:From;
	b=mLmIItZz6GlROfPxzqMrFUTrMwp8fH+HPC3UbMaVwmPObIu6M9rJ8+Lb0zUyGoIY6
	 qsqbdxGT2rWpIquuXVr2HRjcOheHp1JBN9hSy7HDYMd6oX1Yf31klskzr8lju8cuVN
	 4CigchbNo7Oge9U5KUlLlK+6ivAuTm6zNPgH1eb0S/RF3FojcFXGoxuxzEmcE8NaKc
	 k59Ub8xwjLOmS0Qd2SoZk/WhdFSK/I3tDcc9zGCQkAFFAZS9gj+JyZlNcW2fG66wQz
	 U/KNwVWQM9MQzjqd2zWCOS9ZFDGEFa85sT/vPResYD9yBgtWMuO7FlHf5siuBXXFHq
	 kPNhLRfZ8Ozmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7F8CD380AA76;
	Thu, 16 Apr 2026 22:57:27 +0000 (UTC)
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
 <177638024612.3430602.3876329923285206142.git-patchwork-housekeeping@kernel.org>
Date: Thu, 16 Apr 2026 22:57:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: s3c64xx: fix all kernel-doc warnings (2026-04-16T22:40:56)
  Superseding: [v1] spi: s3c64xx: fix all kernel-doc warnings (2026-02-26T05:12:44):
    spi: s3c64xx: fix all kernel-doc warnings


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

