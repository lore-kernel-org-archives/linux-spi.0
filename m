Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF11A1A9F8C
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 17:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485533; cv=none; b=U8uLMVfS7dF7zftpF3iCu74NznK0468iNBo4BGZ5TGstIf3ohcG6d7T93RmCeupetsIiEKO2WVz3iPIlBMQ5WVn1/DiC01GE6LaUYJkajhvGH55OOnxYBaWxQiFMOZrj9j+VzdEpbXiLyCiSBtulFnAVBvRcfbWRgsPoln2ZmgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485533; c=relaxed/simple;
	bh=qPmcyj+l8+PKj79y0GPCDNH3uFoConJbVlibxTUS+D8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=X23txUZl/C6Otjr7LrmXVlZvGRVbaTiPe4jUZqKKtG6JkSQnKR5y6MjZ6a12X1wsgCAJLdWzjNGdAkJypWp7gzxpYWJEDDlmaEMzEAGRRHayw3s8u62DXnMQY3lnU+UB+ilvsaiegi43nbQt9fw85HEnPokJk2e5AzN/EC7TcMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMBFC2uK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMBFC2uK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515E9C19425;
	Wed, 29 Apr 2026 17:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777485533;
	bh=qPmcyj+l8+PKj79y0GPCDNH3uFoConJbVlibxTUS+D8=;
	h=Subject:From:Date:To:From;
	b=IMBFC2uK9ip8Dssv/0Z4ojgCg8hWDIbHa0QtF7rKWPFuiouNLRTDOUP4z/4vYyJAT
	 6NCY77dqhfrA30Sugb6YjuXjAZzlvX5PpaA151KpPzCdvBjMYMUMDeqEFaRBfPIw5I
	 17IowUdcmB0rY0DPqBLE/09kwVyD77iqyb/2wARQm4kCjWrsvalN1hPPfvAigj82+2
	 qFe3M2F/ckRs4qdnrAmWPib9DyFOh1j8XnGpyDfwn0JwnE87gMONx1JcOPa3WEUq7f
	 Ht1UKbnF/Qmwh0wXJYVGZRf4Ck3IbvUm21zTz9rd+pFV9MpCERJxP+qZ95T16jwf9g
	 ShQx2KDq0wMTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F8C3809A09;
	Wed, 29 Apr 2026 17:58:10 +0000 (UTC)
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
 <177748548863.2076223.7526783171410468940.git-patchwork-housekeeping@kernel.org>
Date: Wed, 29 Apr 2026 17:58:08 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] Add QSPI support for QCS615 and improve interconnect handling (2026-04-29T17:01:35)
  Superseding: [v4] Add QSPI support for QCS615 and improve interconnect handling (2026-04-29T04:22:39):
    [v4,1/7] spi: dt-bindings: qcom,spi-qcom-qspi: Add qcom,qcs615-qspi compatible
    [v4,2/7] spi: spi-qcom-qspi: Fix incomplete error handling in runtime PM
    [v4,3/7] spi: spi-qcom-qspi: Add interconnect support for memory path
    [v4,4/7] arm64: dts: qcom: talos: Add QSPI support
    [v4,5/7] arm64: dts: qcom: qcs615-ride: Enable QSPI and NOR flash
    [v4,6/7] arm64: dts: qcom: kodiak: Add QSPI memory interconnect path
    [v4,7/7] arm64: dts: qcom: sc7180: Add QSPI memory interconnect path

Latest series: [v3] mtd: spinand: Winbond continuous read support (2026-04-29T17:56:37)
  Superseding: [v2] mtd: spinand: Winbond continuous read support (2026-03-26T16:25:47):
    [v2,01/11] mtd: spinand: Drop a too strong limitation
    [v2,02/11] mtd: spinand: Expose spinand_op_is_odtr()
    [v2,03/11] mtd: spinand: Drop ECC dirmaps
    [v2,04/11] spi: spi-mem: Transform the read operation template
    [v2,05/11] spi: spi-mem: Create a secondary read operation
    [v2,06/11] mtd: spinand: Use secondary ops for continuous reads
    [v2,07/11] mtd: spinand: winbond: Ensure chips are ordered by density
    [v2,08/11] mtd: spinand: winbond: Add support for continuous reads on W35NxxJW
    [v2,09/11] mtd: spinand: winbond: Create a helper to write the HS bit
    [v2,10/11] mtd: spinand: winbond: Create a helper to detect the need for the HS bit
    [v2,11/11] mtd: spinand: winbond: Add support for continuous reads on W25NxxJW


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

