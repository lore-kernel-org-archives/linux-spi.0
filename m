Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940E61DE894
	for <linux-spi@vger.kernel.org>; Thu, 14 May 2026 04:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778734684; cv=none; b=Gp/1cZwwCYTwAaQUNECOlHp8aAkbPOn+OvuVeIRxAKt3+24Y+BVvVdqd2KGGk16ySTx2lCkwBlczbWYAlL4kSh/pMP5VdFd7CUrtpbm6p6bshgzd1xK1j0rBwoLN0Kxtkj85v541F2DGrXMYQWktQthc9CN75jNBLnCSuBPRqBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778734684; c=relaxed/simple;
	bh=ZSPtPumGLp+bzMZJxThXM4TTzbyuZfALQu+ZymOsDVw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=qmxZzL+OGsPSBNd+3leWUwDlvEdL6nq9jLzECfNPlGCcMdi+ZCDV3r6VASltiiNspqq34AjL4OVJrRpfnDjT59eHOA09GV1mUs3BeWqDjDzZ/WhCTryov3m4NWZjN9bik5GzBWfKq4oKY25VsmFbgRVcKv0jqeC15lwXYhF7z64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6EZkguO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6EZkguO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B46C2BCB7;
	Thu, 14 May 2026 04:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778734684;
	bh=ZSPtPumGLp+bzMZJxThXM4TTzbyuZfALQu+ZymOsDVw=;
	h=Subject:From:Date:To:From;
	b=u6EZkguOrcsiq6qy9eSPVukBaizI6AHxguzhpTY7bfH5bBw1txn2ArPrX3pjolahr
	 qEfQveVEKc8bR7v56uHyznB3J1daQo9bR+3E5VcxgKLSCFVOVCjSTFH5lYbfdnkcBt
	 U0S0wsHex/Hxx33ro42glzFu6ClPLtSr/45gKnb8jyhtn6eKzpExpGYZPqzXgO3bRv
	 xOXbF0gN8f+NvhhCp83JAWjWTiyk6ZIZni3iQF1u5dAcdryq1OWKDKALSXwBFrnBxy
	 VOOSiRr5bsB/CKddVrH7qGnzadQty8ecNDsMUWxN7I+ecxipU3sbwdZdx6ghC72bmS
	 4szxRokT+pzVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7E5A239308B3;
	Thu, 14 May 2026 04:57:10 +0000 (UTC)
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
 <177873462901.3960482.16240589113210703295.git-patchwork-housekeeping@kernel.org>
Date: Thu, 14 May 2026 04:57:09 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] Add LECARC ACPI IDs for DesignWare GPIO, SPI, I2C (2026-05-14T03:43:16)
  Superseding: [v1] Add LECARC ACPI IDs for DesignWare GPIO, SPI, I2C (2026-05-14T02:40:10):
    [1/3] gpio: dwapb: Add LECARC ACPI ID
    [2/3] spi: dw-mmio: Add LECARC ACPI ID and init hook
    [3/3] i2c: designware: Add LECARC ACPI ID


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

