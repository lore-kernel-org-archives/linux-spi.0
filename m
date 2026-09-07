Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FAE3F4827;
	Mon,  7 Sep 2026 18:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788807410; cv=none; b=fXPw7J0fAxsQRTDPavGkjQJhKjUb53QDITnktmqJLxJauOrgTQhN/4mJb9Ho5lShMfGggdwlGDkbLRS4AvHFVF1BeJM7iwJa8vAzQzkgpLjqzgu4LBgzx2AJW5c77ADOPh3D80Vjr9tQfqLWdeqlkZIMXVLF1jaWvrKQdPhxQiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788807410; c=relaxed/simple;
	bh=nTVRlglTD9ckzVBTIRaaAh0k1mLw5g26dmcPmA7obJQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uRI4yNBMQJJ0xqW+/pcZleOX/wLH1869LW+TVIbZxbR94RAkwry63dP+wb2KRX+BfM8a9qgQ9Oao1u60VqODqjCfC6NH0r51yvl9nynraCp5WMKKvsDhx4KjkBjrnWkEMMANVMWdKVf91edhRvlmzYm0qvvLLgjnw9P8J6kR1ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWOZAw4q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWOZAw4q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0691F00A3A;
	Mon,  7 Sep 2026 18:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788807405;
	bh=5qS+uYAlXoVgoA5y3VMmw6zK3k+dLYvW/w3xfEGuyUw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=oWOZAw4qVcPyIyz31HyUKxqgWVkfl8JJHlBJziUh9ea0iOFHvs5ahLfRVsNNc9Mjc
	 C4gE7jzD3ytTnCVSbPbimSDkzeCrU8PX6lqD7h4RmGBIIKtmRrmUIg0uAG2iQLCbqC
	 OO/8bJaZsbFnc6Cb56LcHmwyIZq3LJEz+WYOB++MTmIY8kX3iJe2iwvkNr9x92yNS3
	 QfpOTTzGlZ9iNaFJ4hU7NtS3Easgj8TyKgVqyapuuDcqLRpBtMe+dcveaHh1UngMJN
	 qNbiSnZOCanuuAvL16GvKifWp2C0pABRvraLJfHIUnNggpP4jc35quvvw+C2njduzi
	 OZhXOgOQuSa3Q==
From: Mark Brown <broonie@kernel.org>
To: Jonas Gorski <jonas.gorski@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Michal Simek <michal.simek@amd.com>, 
 Hemanth Selam <hemanth.selam@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-sunxi@lists.linux.dev
In-Reply-To: <20260904110420.13707-1-hemanth.selam@gmail.com>
References: <20260904110420.13707-1-hemanth.selam@gmail.com>
Subject: Re: [PATCH] spi: fix typos in comments
Message-Id: <178880178905.118202.7414086624567890048.b4-ty@b4>
Date: Mon, 07 Sep 2026 18:23:09 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1067; i=broonie@kernel.org;
 h=from:subject:message-id; bh=nTVRlglTD9ckzVBTIRaaAh0k1mLw5g26dmcPmA7obJQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqnwjmLMJ612y12jg5vNINZFQMuybqmkcJJARWg
 sf5MP2QFQ6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCap8I5gAKCRAk1otyXVSH
 0KZHB/95sPFMK+ZElZYPGxiFZhS9eZvnnj+DTWdk+xxvrMzkurYYLkBL487FgiKRyWzJVwjG9mD
 9AZr/e84CFxrfnWfQyB1GRG8i+Pi7zuNkkiPucC+gHfr0ArmCPLT7oPNWf+5FGpnFxVbsbOkNr2
 6BXYnokYv5PgSO5LSXsuuYQfcK9TqfpEdpt2a4QpX+rxof3AROAomc4P7osQT35hl+63TtsBlG1
 qkYqzU/Ec+SKZxgAo487B5DnFLbHj2lF0c95S1zxZiKFdpic/jtOj7EWUXJv69UsOAinMHbcyGb
 cXIB24cRqik0QWmVEuiv1jAMRUi6cLtQDFEIyhPXdWi/Y6xv
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 04 Sep 2026 16:34:16 +0530, Hemanth Selam wrote:
> spi: fix typos in comments

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: fix typos in comments
      https://git.kernel.org/broonie/spi/c/98477036fc35

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

