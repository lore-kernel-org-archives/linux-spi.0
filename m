Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E72336887
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342624; cv=none; b=IJXOJbCR4cXtSt+gEsUs8kRSVzX+CzBqJC4zzfs65a+WgA27hDCwrnZKVMIfNFcfrwk9xnME83E0EwZLIDB66Ut1fzBCaFqreUK0oOUewdPqxMpYTBbpFM1U2SErJnyYJkF9bovAMZIBpRuUhBv52B4teooXg4DQdN1Aj70aeic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342624; c=relaxed/simple;
	bh=dQZKdu/v/OCQHhvc453taq3DRoCDE5ITov7OQvplXyM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=RIYWaUi3rEuKN1jvio7rbfuSwDhMyssxqE5RO4fTr9P6qxxZQ29vm6jgJWT5sx23qfO25jLhRyVlChe/k2rxYVjGFXiNzi8ll9RLRQSYktphNBSUqtqZ68yLJxeuR3XX9ofIwCcLUvSCbrbuw0vOng59VV8M8nmoFtLD6E5Cpv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/ped6R8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/ped6R8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7B1C19424;
	Tue, 24 Mar 2026 08:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774342624;
	bh=dQZKdu/v/OCQHhvc453taq3DRoCDE5ITov7OQvplXyM=;
	h=Subject:From:Date:To:From;
	b=G/ped6R8ekXdazd+9sIt3MkjdXJEJDpyWqtw/Bh57pVXcPXiDm6cEPj5s37RHAN8q
	 ZjWsNqHed9wUgMeRGuV5/Y5z5rZVS2fcgf3OQcyT/gaddfaHA+uaIZX/UK/4RR5ayQ
	 soAziE9aopwEHNzAkAcBZo3qcvmaOANJSQ6XtBIqGd6nAcXo4ecdbWRc1tNFMQ9HT3
	 Z5y/TtGvh0MKZ14s/RIg5TFlEG2mxbcD88SOPc4Ug1rhboNNY8jsrNoe0S8+k4Aw/9
	 PLfQqJ3tugc7NiKFnX/kGi10NyJI3Y0ip7sqv75i4F/dR/YZqvNKNz8TeswfE5YRkO
	 4KMMAjgD11SPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CFFF3808200;
	Tue, 24 Mar 2026 08:56:53 +0000 (UTC)
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
 <177434261222.571280.15120409366794088920.git-patchwork-housekeeping@kernel.org>
Date: Tue, 24 Mar 2026 08:56:52 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: imx: fix use-after-free on unbind (2026-03-24T08:23:26)
  Superseding: [v1] spi: imx: fix use-after-free on unbind (2026-03-23T10:49:47):
    [1/5] spi: imx: fix use-after-free on unbind
    [2/5] spi: imx: switch to managed controller allocation
    [3/5] spi: tegra20-slink: switch to managed controller allocation
    [4/5] spi: rockchip: fix controller deregistration
    [5/5] spi: rockchip: switch to managed controller allocation


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

