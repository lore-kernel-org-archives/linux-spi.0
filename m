Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5676D2248A3
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 04:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777438716; cv=none; b=onZw7V4l0T+kBuqJdcn6yyxCLKZlUgXqIDPVmdKo3x16Yc+xYatck9foWNkNTdr/qppjeIquHQlpLkW6cbdvu6lp3K9aLfCzL2pXSR2ncVr8pBvecEyek3QsmdrIhNBOvrBZy3/7h6EIaY9DiBpN2kGSPfQdDiszkQtloDVrGKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777438716; c=relaxed/simple;
	bh=uU88h8NXZXcc4zBDIgSUnPTsZs+0w36Oepjfllp4siQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=BweTCWLl5MTICxGCOE7byU8UM88EQKy92kfZYGhEI0HZieuhYJYvsTWnVysAGruidJZgM6BTqCb7mlZffeFjKgKDRlSwN08BTPBAcehayeclPkZ+ybBNtNfqkGtYPn5u5vW8KVQsvCPujLyZBUD/vlQJF/E5XlelbBOiz9tcQtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcitA76k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcitA76k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3421C19425;
	Wed, 29 Apr 2026 04:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777438716;
	bh=uU88h8NXZXcc4zBDIgSUnPTsZs+0w36Oepjfllp4siQ=;
	h=Subject:From:Date:To:From;
	b=YcitA76k/LZehlbkUvucdMwDw1LZCmfyfo5F7iyGnklvYtF9mH+TWL+LTQ3zkyWUU
	 MjjJ/YrIUg32j8i7+Yb6eXk5hDqW91DbGOvrAGvNRX9uXYOLcsVnW4b+BWLdrbRrWK
	 C+aUpulMgjMEzT+6QuoGrCi2YcyzH+PJYwqDlVZ5QwgF5cICp0bOrBp+Ro/WeYxTwp
	 NjA9GRosImDmPW7LysaO3cLk6XxBkFYjjCOlTUkcY4UAfEWFscJ+yIDEZzC4KFWkCk
	 VxAVY5cWg1D9ZzuxrjWQUd5EjWBMnxswbc3UUFNDEmS+j0fl510wB6KHwfVlOl/Oyp
	 aXepacw3cHiRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE4939302DB;
	Wed, 29 Apr 2026 04:57:53 +0000 (UTC)
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
 <177743867212.1349817.350601171712585095.git-patchwork-housekeeping@kernel.org>
Date: Wed, 29 Apr 2026 04:57:52 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] Add QSPI support for QCS615 and improve interconnect handling (2026-04-29T04:22:39)
  Superseding: [v3] Add QSPI support for QCS615 and improve interconnect handling (2026-04-20T06:12:47):
    [v3,1/7] dt-bindings: spi: qcom,spi-qcom-qspi: Add qcom,qcs615-qspi compatible
    [v3,2/7] spi: qcom-qspi: Fix incomplete error handling in runtime PM
    [v3,3/7] spi: qcom-qspi: Add interconnect support for memory path
    [v3,4/7] arm64: dts: qcom: talos: Add QSPI support
    [v3,5/7] arm64: dts: qcom: qcs615-ride: enable QSPI and NOR flash
    [v3,6/7] arm64: dts: qcom: kodiak: Add QSPI memory interconnect path
    [v3,7/7] arm64: dts: qcom: sc7180: Add QSPI memory interconnect path


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

