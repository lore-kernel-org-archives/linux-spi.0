Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF037324B1F
	for <linux-spi@vger.kernel.org>; Tue, 28 Apr 2026 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395507; cv=none; b=PfGB2XI6na5BZfS07ZVSNIc/OPdc5IKFU+h3alY6e4GvAnuzRnBYFMgGH6bRgleLZ8cl7+ipmTBGPP0HM4mEGsgktAsW5G9FkSuHz7MYaEW7G4TLTxrl2ciO7dwFMohSCmdi98libzAvaMEtJVhf1Xni6OHKkgNnm+7txEkQTAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395507; c=relaxed/simple;
	bh=b5hv1oKxpS52FqIEF5GpIVzMMIglEFz1queeJvkeSzA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=I/acqZNU9Mtf93Gbv3uqxmmlcVNzYgA9lui8gyGcd96mOP+leEezZMyK2LHht6ZdNo38hSxn0KIg44HRVJEgUmwtHeBlBN48ZbN1Nak8B9BN2ThKS+4tDUB2yb9kyWNs4g+RXILywUb/QD20WLICpBrkESCrEcPMzONxhAnna9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aF8uqLww; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aF8uqLww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A49C2BCB5;
	Tue, 28 Apr 2026 16:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777395507;
	bh=b5hv1oKxpS52FqIEF5GpIVzMMIglEFz1queeJvkeSzA=;
	h=Subject:From:Date:To:From;
	b=aF8uqLwwcVLxz79rpHvFM5DVDl/VvrdH/KjJcAdWp2j+5xYvI1KeGjqLRJJqTkGkR
	 RN0DS5up1uYt7yktdBBJ/wmKASy22ndGVdAMT6NZYMGhSsIn2nKk/En98+Bo8LnV45
	 FcdWr3AecBZn/FgPhZi+vkl56Sb6h03P8sJW/xLS7MJxWy5kkMk8odinBRfwRlAKbD
	 rOeSWnT6d24Bpte5ll/nYXcVRi+ZXwDXN0lI0kRm+auKg0PicQXsQocNe6bbpAH645
	 ROZ+ZEBEWQOMHfmH7f+ES4BDIwrGqxYbf2aGTkNsAEvyaKVVGzB2knurliptGH6hBM
	 dzM9VZQNkb5bA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF003930230;
	Tue, 28 Apr 2026 16:57:45 +0000 (UTC)
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
 <177739546413.1067566.2565161589267487474.git-patchwork-housekeeping@kernel.org>
Date: Tue, 28 Apr 2026 16:57:44 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] microchip core-qspi gpio-cs fixes + cleanup (2026-04-28T16:12:04)
  Superseding: [v1] microchip core-qspi gpio-cs fixes + cleanup (2026-04-22T15:15:41):
    [v1,1/5] spi: microchip-core-qspi: control built-in cs manually
    [v1,2/5] spi: microchip-core-qspi: don't attempt to transmit during emulated read-only dual/quad operations
    [v1,3/5] spi: microchip-core-qspi: report device on which timeout occured instead of which controller
    [v1,4/5] spi: microchip-core-qspi: remove an unused define
    [v1,5/5] spi: microchip-core-qspi: remove some inline markings


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

