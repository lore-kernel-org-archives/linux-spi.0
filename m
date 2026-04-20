Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8721E1891A9
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 06:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776668292; cv=none; b=kSp8x3a2UWHEdyfKLQGDoX7Xl/HqV31XykVRnE0ZB1yTEgKlkULeSDM3m/amPYVh80PjfJrRIvis3wp3x8fnlt9DnWJ+pTyaSoRn8BKY4ne84WwukMqSHxcO0yyWiD7Id7KY1uuYnb+kIZWiZMZW2mW3CMGRf2k9q/qskTskqZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776668292; c=relaxed/simple;
	bh=p3aKwgP86OzFWvZ07Lke7lei1L2xKor1Ly6HOlvWa7s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=MvWe1ZJv347tg3LGk3z/WHr3TnlSkGDyT8nLkB7QOOAZAlpjxtGbO7VVUm2MrVwbIomKFytm0Bqu7OtBirmVtyqm6cHmRRIhw4TjvAE4BIXhP3BFFyAy8VQJ99I1fpc7JXgFbYLV0hC6bqbJueqxm9ulx8k+f9XCw9pIXHnK5gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDuCfqKp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDuCfqKp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E1FC19425;
	Mon, 20 Apr 2026 06:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776668292;
	bh=p3aKwgP86OzFWvZ07Lke7lei1L2xKor1Ly6HOlvWa7s=;
	h=Subject:From:Date:To:From;
	b=jDuCfqKpPqt5p9Digp47+iE5QoEsPpYRKvPSr5ieNWnsTaMJ001xVugYst6g96aGh
	 h9q04nHRh2AqfRvlSVKDnYbw5JGBA0334CNl7LabSy14CJ/wdbYhHEYs2T/0iGXPL+
	 pjz5TpZOGRjOXOfc4Tcyl1Sd1R9q+vyxvEM/28HW6bhQBXlIBrB36aFQZBcFahsylF
	 rAZRM+HJtUEHgwIynLEFrU95ykbCPoDieHlQxb6kpdpi9MBLmw4fmPruA7o9j7pHFk
	 okoUedqaxzD6VipdCfHQaYwOwhGq4wI68cAe/HNmnfxqCleits6Mow3dHPE5mr+1N+
	 9LF+YY3mLJTSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FEF3392FFD5;
	Mon, 20 Apr 2026 06:57:38 +0000 (UTC)
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
 <177666825694.1034180.11199895535117931798.git-patchwork-housekeeping@kernel.org>
Date: Mon, 20 Apr 2026 06:57:36 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Add QSPI support for QCS615 and improve interconnect handling (2026-04-20T06:12:47)
  Superseding: [v2] Add QSPI support for QCS615 and improve interconnect handling (2026-04-14T17:08:18):
    [v2,1/7] dt-bindings: spi: qcom,spi-qcom-qspi: Add qcom,qcs615-qspi compatible
    [v2,2/7] spi: qcom-qspi: Fix incomplete error handling in runtime PM
    [v2,3/7] spi: qcom-qspi: Add interconnect support for memory path
    [v2,4/7] arm64: dts: qcom: talos: Add QSPI support
    [v2,5/7] arm64: dts: qcom: qcs615-ride: enable QSPI and NOR flash
    [v2,6/7] arm64: dts: qcom: kodiak: Add QSPI memory interconnect path
    [v2,7/7] arm64: dts: qcom: sc7180: Add QSPI memory interconnect path


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

