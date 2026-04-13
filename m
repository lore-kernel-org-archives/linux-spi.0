Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AF1362149
	for <linux-spi@vger.kernel.org>; Mon, 13 Apr 2026 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077881; cv=none; b=ILEB/lypZHaLePWbL+UYdzT/LL1SzNYw2Tb8xroOC/IxEXeKsa6ClBIW6Hk6QG3dLKuhBj7wrqRpwamxN7nq6xXyrd4VfDv5JViHEasqsAdEG7JrJr/tVpCw6+cpZDjV0nosCE8JPQadoaXpt9ZiDTgTiv0MMptpMEOVB+znckU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077881; c=relaxed/simple;
	bh=EwzUFaaDq72v8/n8W+S+Sw5y6OnTdupSXrnFhlVg2DY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=hthhtYKhg+mNb/TMYjv8gyqcHTe9+4izqh0honCoYOugmNzsO8+T3WILVH/FZJDFBdorxL6BXq0bhQLtQiV1mIu+gs8LUbWIUEc/6ueuuwjIKlaSHaake6EaQlGRy3wD1oVgz1UhjzxbKxRrLaSd+aT9AqgS1tntVVfVM1GcCgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3j2oLV6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3j2oLV6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F16AC19421;
	Mon, 13 Apr 2026 10:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776077881;
	bh=EwzUFaaDq72v8/n8W+S+Sw5y6OnTdupSXrnFhlVg2DY=;
	h=Subject:From:Date:To:From;
	b=b3j2oLV6vLUSlnA1ojJOurD/KSfxpoyGnqudrzDRgNMjRB6rqmXo0SRP2O8Z27D6U
	 QhMYt+0ZA/kfTD33x3D0Z3sAQW1Nt3ueneE94jjEc2NBthzKc8QA2XIcCfn07SvSUg
	 sEIM5msfZ754uUTYkKgwGOKnSfrIDwtENRxWfsE6sgthNmXf+pkFdZG+bNyM7YVnRE
	 Dv9ot9uiPw3W46EPZwxTr1Rv4gyriIXyLuG5Yu0+IZYQlvoEVoDhPQAWq9HkXTHTN/
	 q1t5obUEpUD7i7e8mE/aK21ZkCZT8L53AC/zc5QKq+Fc9Ba1v9M4QhP0Q3Xbfjw+WD
	 xDUA/3TvCydNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 424793809A8D;
	Mon, 13 Apr 2026 10:57:34 +0000 (UTC)
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
 <177607785288.4068669.2022129048804263511.git-patchwork-housekeeping@kernel.org>
Date: Mon, 13 Apr 2026 10:57:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Fix CS35L56 amplifier on Intel LPSS SPI with broken ACPI cs-gpios (2026-04-13T10:05:27)
  Superseding: [v2] Fix CS35L56 amplifier on Intel LPSS SPI with broken ACPI cs-gpios (2026-04-13T10:01:37):
    [v2,1/3] spi: Preserve preset cs_gpiod in __spi_add_device()
    [v2,2/3] platform/x86: serial-multi-instantiate: Fix SPI chip select on platforms with incomplete ACPI cs-gpios
    [v2,3/3] spi: pxa2xx: Handle clock gating for GPIO chip select devices


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

