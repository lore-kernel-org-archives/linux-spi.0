Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B85282F13;
	Tue,  5 May 2026 01:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777943367; cv=none; b=j3kNbeCpcBurIXJqOyRSIrDsaj8946xyzm6lYu5UdYfDHIdn1p90IhIamAiAp7Xv/rzQj3j5L86xowzijAIHcvh19rkuWePdFCEwmx1CK6jtZY3GPvieToz+VYRuVt4FJToZlWhIv0FG+wCtS1F0Hn0e/uxsmWeSxuWfERpl3RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777943367; c=relaxed/simple;
	bh=d035+S4249vuXGzpkMkWCXjluzoLOmmVQX0sJxi1Jdk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VRn/QWgVPLIFAXdxHE8zMJQDhm2fe4i3n0AIlmj7YuqhXw6jRTvG8ETQcEH7IzrZKhrb6Jm/ZN3LvWY46O+JOhevyEscrnnWPWZDnSwVfabSrm8bJjKKDTn9m2QlOyKJ+BMWQgCeB1w649mXWqOQVrdaxK5Gm4aFbvj/1KQ8S0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViVsjpQ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViVsjpQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDB5C2BCB8;
	Tue,  5 May 2026 01:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777943367;
	bh=d035+S4249vuXGzpkMkWCXjluzoLOmmVQX0sJxi1Jdk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ViVsjpQ3ZCxKV39kEpW/waMhSspGDIPGYMwEmvTbHiL/xrpynfP8jtVNMCTi7+gX9
	 CiP0+v7xGLPnWoU6t5x0WR6LStSBa342A4vZlNdKsLDjB5zSjzZc8rejmDpEwGCexa
	 86Jbbd8Epk3wT/6tTNFabR2NARBjxr5kC0OCXGDBKde1Q8iMqY5S1McuRb+cLJB15X
	 MYaNY6BqE5M55xr86nu0hfbYreipUuP2JZVy4caGeX+srMjCrydSk6WD4qqhkKWHAi
	 EubOX5stURcDlpnuoyJPrSD3zMoUuftEHfiJPH9ltB+75Ke5KaLKHoojQv32WYX351
	 Q0Xr/GxEprEvQ==
From: Mark Brown <broonie@kernel.org>
To: Radu Pirea <radu_nicolae.pirea@upb.ro>, Johan Hovold <johan@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260429092005.166128-1-johan@kernel.org>
References: <20260429092005.166128-1-johan@kernel.org>
Subject: Re: [PATCH] spi: at91-usart: drop dead runtime pm support
Message-Id: <177789984868.458539.13365333450005072163.b4-ty@b4>
Date: Mon, 04 May 2026 22:04:08 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106; i=broonie@kernel.org;
 h=from:subject:message-id; bh=d035+S4249vuXGzpkMkWCXjluzoLOmmVQX0sJxi1Jdk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp+UNEhXADtrN2zdzNMpjphX/I3U2LB8YEaQjCP
 RGwlHyI9ViJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaflDRAAKCRAk1otyXVSH
 0BeqB/0V7DYxGYAJ4rcYstdiGrSuO9Eiz7oGp7QA4ZK6HYnuflk+WKpA7LSSEDz8vp9jNIZ57hH
 zLsW1XQTJw3NM42xXuB8pim3C2+0eaOAjIpwkQh/Yd+NJiKjKzT7a/DJ19McMuOXSwXdz8236ZJ
 zeu8tBhM3XOQjhFNaD7YTRrG4YAYoZH6nt31XwQ8bTboZSlMgIuzdD4jJRzPc3JGbn9WbDZsxqe
 tTtvrfW03Dhv+SPznUzEcQz4Q6KO16lZ+BsaKQwTxh+JkV0pfApJbEaO1qC6Gpzft34rllYX5/V
 yLmxl4e5lo8yL3NenZGgFLUetqzVTFyqMY+ViLCGwSoBxxFy
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 29 Apr 2026 11:20:05 +0200, Johan Hovold wrote:
> spi: at91-usart: drop dead runtime pm support

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: at91-usart: drop dead runtime pm support
      https://git.kernel.org/broonie/sound/c/ae4ccd216dd3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

