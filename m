Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6391B23BD1D
	for <linux-spi@vger.kernel.org>; Mon,  2 Mar 2026 11:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772452630; cv=none; b=MvB11jt13RjllITFtPiNa065JM9w1uA11vibmb+TJi2T56wWFQtrdWH27EXzrsxGJHR3ZYiOVCJPzsjFY9o7OaspxxDpUKD+mkVvHwtwOHHuR/7N6X1Q+vsSh7kUgms67cGG8LAsMHHBvzxBQZxlf4KkLsf5ywWHIgEP75s+CUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772452630; c=relaxed/simple;
	bh=yGxr+JFIbBygiBrgwgODvnRoN1MmrjuHAGS0HFzg+1M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Yuo1ASjl46y77FVIuDQJQwkk1bvHmUzqAgp5IUJI3alCN0pIVrtJklBx1yqRNQd2wUc2qr14B8jbpiWHkAxkwGtDzosJZjB8H4JSd3knpCH97XtO+eh2SA4EUz3pnS8J7NUKvh7Kijr/YyKz1WXm+zVylbLRSYwqQwM41If71r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxAekWnt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxAekWnt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AB8C19423;
	Mon,  2 Mar 2026 11:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772452630;
	bh=yGxr+JFIbBygiBrgwgODvnRoN1MmrjuHAGS0HFzg+1M=;
	h=Subject:From:Date:To:From;
	b=kxAekWntKh+rGb/p+2oIPq+T5DXU2wv5YG5YK1nRK7TkmcUJeBeOU7DKMf6gFMhMl
	 RM0d5fDyXF3ChEVhMMDjWo3Gv+cVYuwYokpKZWchmKHiyEAJ843sQBF+heLdVWVs8+
	 ihUeDZ9eM1kIYZL+cVPMeUcv3ByH4r9w+dZSzJLAJbJojiC1qbl9t6+fe3Qr5OTTPc
	 WTwoTzdCovCHfQWUCCufYWiO/lJbK+XnVmlS8WG3AQt/1d8Wjha/1kH1jMNJSuWzcI
	 u0mpm70wSI2rLS/Ot2po5wry0l0GNoYKQkQ2VTEa0DsuHWCWwGzGEGi3hWmyopkQtA
	 4z5Tx6RjyJdew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D05D39308ED;
	Mon,  2 Mar 2026 11:57:13 +0000 (UTC)
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
 <177245263208.4050897.7248570995230843881.git-patchwork-housekeeping@kernel.org>
Date: Mon, 02 Mar 2026 11:57:12 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] Add support for Microchip LAN969x (2026-03-02T11:20:08)
  Superseding: [v5] Add support for Microchip LAN969x (2026-01-15T11:37:25):
    [v5,01/11] dt-bindings: mfd: atmel,sama5d2-flexcom: add microchip,lan9691-flexcom
    [v5,02/11] dt-bindings: serial: atmel,at91-usart: add microchip,lan9691-usart
    [v5,03/11] dt-bindings: rng: atmel,at91-trng: add microchip,lan9691-trng
    [v5,04/11] dt-bindings: crypto: atmel,at91sam9g46-aes: add microchip,lan9691-aes
    [v5,05/11] dt-bindings: crypto: atmel,at91sam9g46-sha: add microchip,lan9691-sha
    [v5,06/11] dt-bindings: pinctrl: pinctrl-microchip-sgpio: add LAN969x
    [v5,07/11] arm64: dts: microchip: add LAN969x clock header file
    [v5,08/11] arm64: dts: microchip: add LAN969x support
    [v5,09/11] dt-bindings: arm: AT91: document EV23X71A board
    [v5,10/11] dt-bindings: net: sparx5: do not require phys when RGMII is used
    [v5,11/11] arm64: dts: microchip: add EV23X71A board


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

