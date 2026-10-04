Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2FB4CCDCB;
	Mon,  5 Oct 2026 16:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791216228; cv=none; b=YS9YB1tuqQ3/vtuhxTuGt+peUziE5E5B7d57LHx8OYlZdflVi46G0H91LLaAUn4J2iJRh2JrdGO4Y42/gsVNRhphmFdTFsrrmoCD62+NTTFNI/fcD3OxIprtHTb+Xg2WM6pOM5ei07z/w5Vq985feVs+o6stdX0UyJGYaaFYUQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791216228; c=relaxed/simple;
	bh=TwCApKgSzLwszhlYokP7yH9qXvdd7jTgvIMJN1h2+3Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sIZNF8nTlaT1Rz2zGTX4orv1dXeYsHqu9wKcIGZCkT96twvoxFIam1evmaTR4OJg+eUkmcLpI77+S2ZOwZfT8vdb7cf6vLYPVpCvcHK+wrPeo+Jk3lyUcDTlDG30M9MHq4g+Tll9BprkIFpopvsAwlGvBlDBvIsFEwlLUrQMNwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naR0LI81; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naR0LI81"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDCD1F0089A;
	Mon,  5 Oct 2026 16:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791216227;
	bh=j+VillOJtWalaw/jSDZBznfL15QfMpYdQSSXIanytqE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=naR0LI81YLfOeNm6VeqBbtgI34qRJ+qxJqz/URSBK+YBKRkKjx39zGrqBDH2VouEs
	 WeM8EwGR6PytDADsMbgQmlK2xcQu6ZJPVZwcYXvt5hHQ/6tXzmcpUHEJAv+PW9Mq6H
	 YvqCRphUFPLDmxw6A6lt6QL90zj2tTs4L5rQrmZdKemLB9Tcq5rYiwElECAk/aj1dQ
	 8oogT0JUKKeqMCAkoBJj/1X9zyhqcB6B6jZ2v4n0KhGx9Y5iD8wcE1UNPSSO8PdcXV
	 gSUbsJrNIChqoidCIGTsengCDZWtrixfnS3FFqANX6Gmxf6PcidvU6vR7mCwT6y/ZH
	 Sgkg8a8FWiPeQ==
From: Mark Brown <broonie@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Varshini Rajendran <varshini.rajendran@microchip.com>, 
 =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <bence98@sch.bme.hu>, 
 Robert Marko <robert.marko@sartura.hr>, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
In-Reply-To: <20260923012950.15651-1-kmehltretter@gmail.com>
References: <20260923012950.15651-1-kmehltretter@gmail.com>
Subject: Re: [PATCH] spi: atmel-quadspi: balance runtime PM and pclk across
 system sleep
Message-Id: <179114276714.150114.17193721637289577017.b4-ty@b4>
Date: Sun, 04 Oct 2026 21:39:27 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1152; i=broonie@kernel.org;
 h=from:subject:message-id; bh=TwCApKgSzLwszhlYokP7yH9qXvdd7jTgvIMJN1h2+3Y=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqw8pcv5EFqGPBUU7JDV4g11HA0yZJRIt92YJam
 aJoPX64gE+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCasPKXAAKCRAk1otyXVSH
 0JRzB/49fPpvqUSexwJD8TEcmWyAxxlv4A9Stb2Lnm6F+I56hcwNbR8X1wVPIiKubVfH2KXaV8Y
 2/VSWIQAziCxSJ0vnIvPI+S1Z1nmvM1dQpy6XxWY5tilmd2RM/J4jrYwj0akzwemrVVbNF7LWD8
 FgH2UWkLXXtAWB1cPX8egTQMjmkl2eMUMPEVg0EWgwenfORN7OIhSTjNzh0fn4C6qcou4yDqJ0N
 zj31DD3WLPB9QB7VbsvcEsF2p6C2at43skxh6VKSkP7hCvLc1Qv5hxu/FV/UYQN6cCHhPzVxPof
 Q2/PoU0Tz6i21AlITv5uYchIPCY/ZjmVf5claccgF3geCtP4
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 23 Sep 2026 03:29:50 +0200, Karl Mehltretter wrote:
> spi: atmel-quadspi: balance runtime PM and pclk across system sleep

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: atmel-quadspi: balance runtime PM and pclk across system sleep
      https://git.kernel.org/broonie/spi/c/717e45f97246

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

