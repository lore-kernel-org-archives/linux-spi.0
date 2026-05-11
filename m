Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4258F3F7A86;
	Mon, 11 May 2026 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778509953; cv=none; b=B2tpGYdcjR5zF947lF0bXE7/LOcvQK8hH1JLRiQJonO3EQ8lyQpXe7UrxKyAb/EQfBNXYZEQD6ChZss2KckRuUw4xpjYMMM/qM5Usy1UODE6H2kic2cF0styAKhzLbwqXfms1H5743tU/wU4Fva+r5FNT+63plZhNl0r5r6uSVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778509953; c=relaxed/simple;
	bh=6yDaCsm6Fs9/qKu1KUmDi4lpZf7x22qyRdhvdJv9Oww=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gr8PcyYhNJgCrCSLU8tSyxdsIz3kgwSeKUhHp71J8RFGbTH951w/Lfo/0ITtVUx2Qs6gaFmSu8XSwtPICsB4bzUfcI0IRqd2YgcshkqirEC7IRPAJrK0LuESPRdm6ejT17wa2jz/ps/f8ugy4aWg20vdfaJSk/EEqEJjcFVp0vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icPhxbc9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icPhxbc9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B853C2BCB0;
	Mon, 11 May 2026 14:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778509952;
	bh=6yDaCsm6Fs9/qKu1KUmDi4lpZf7x22qyRdhvdJv9Oww=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=icPhxbc98tRXVJGF37J6eXmeRpm12v6pan1cFmoGM0830Cpvh691Wj04oH6/hPSox
	 g6JS62vnM0lvZVuRfEF/xsyV7/un38Y+f6f9bxClpsCs5tS+1lyKmD14IsTMqR9dvJ
	 bNhzafjdJYFJ53Psw9zHojjB+gPBQ8KC2YHV3xNgErJXfwkCYpOymSCjR5TtCmKA6O
	 2lTZQdRweGWxqNGQqXY0+wh6gwQQVGe3ZFP0vIOzzEbpLyf2TWz0SdUMvNM54TfvnF
	 0hCrtu8nHVnrmARng8NGBDlhXTjWjZuxl0HIw6cOsjQsRN33fzrNrbsOaxlfddQsGY
	 AXQ6PTIJh9Ygg==
From: Mark Brown <broonie@kernel.org>
To: sunny.luo@amlogic.com, xianwei.zhao@amlogic.com, 
 neil.armstrong@linaro.org, khilman@baylibre.com, han.xu@nxp.com, 
 haibo.chen@nxp.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
 lhjeff911@gmail.com, hayashi.kunihiko@socionext.com, mhiramat@kernel.org, 
 jbrunet@baylibre.com, martin.blumenstingl@googlemail.com, 
 Hans Zhang <18255117159@163.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com
In-Reply-To: <20260430155456.36998-1-18255117159@163.com>
References: <20260430155456.36998-1-18255117159@163.com>
Subject: Re: [PATCH 00/10] spi: Use FIELD_MODIFY() for bitfield operations
Message-Id: <177850111749.988959.3324914194988461245.b4-ty@b4>
Date: Mon, 11 May 2026 21:05:17 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2369; i=broonie@kernel.org;
 h=from:subject:message-id; bh=6yDaCsm6Fs9/qKu1KUmDi4lpZf7x22qyRdhvdJv9Oww=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqAeh8vjkGkzUWV0FtkGu3VAG7YFX76JbuewSvr
 7LFDYp1pNuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCagHofAAKCRAk1otyXVSH
 0GgYB/0bjIyo5EXJiMTycuOQXtlDCYiBMJdMFY7I1IWduMD5RfXhniWXgWw9k/IIvjGySM8RXO0
 IIhV/HTwGFzjDO2SXcPM4W+Jr/8ZF7Qgw9SE0jEpgJN4OAvuq+Xik1N3z68utaNT1f6RduItRcE
 Zy7ES4g0a0t3V0NvEhMX9Mk5HL++3ycbAX6/3GtnZJOhFtHzPjYKbhhDxZiZYCsr+nKFTcHAFtq
 jT3ZRGgXQKN3xMnPqBBedkhZqWWNnhB8QIFZg64/HuIhb4jAla7PrY4zWwZ5cIdM2zeACsGa6EQ
 ddioBbSzHiHvztPDDNzxCiFvaq0EdY3ACBvex9ByywYEtj/R
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 30 Apr 2026 23:54:46 +0800, Hans Zhang wrote:
> spi: Use FIELD_MODIFY() for bitfield operations
> 
> Replace open-coded bitfield modifications with the standard FIELD_MODIFY()
> macro across multiple SPI controller drivers. This improves readability and
> adds compile-time checking without functional changes.
> 
> Each patch modifies a single driver, allowing independent review and
> application.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[01/10] spi: amlogic-spifc-a1: Use FIELD_MODIFY()
        https://git.kernel.org/broonie/spi/c/8262b1421ddd
[02/10] spi: amlogic-spisg: Use FIELD_MODIFY()
        https://git.kernel.org/broonie/spi/c/b69bfa593329
[03/10] spi: cadence-xspi: Use FIELD_MODIFY()
        https://git.kernel.org/broonie/spi/c/6fa473f4c5dc
[04/10] spi: meson-spicc: Use FIELD_MODIFY()
        https://git.kernel.org/broonie/spi/c/cfdab17cd2d7
[05/10] spi: nxp-xspi: Use FIELD_MODIFY()
        https://git.kernel.org/broonie/spi/c/0f2efc6d4938
[06/10] spi: sn-f-ospi: Use FIELD_MODIFY()
        https://git.kernel.org/broonie/spi/c/579fcc06576d
[07/10] spi: stm32-ospi: Use FIELD_MODIFY()
        https://git.kernel.org/broonie/spi/c/21ee6902a576
[08/10] spi: stm32-qspi: Use FIELD_MODIFY()
        https://git.kernel.org/broonie/spi/c/3e0530c087a9
[09/10] spi: sunplus-sp7021: Use FIELD_MODIFY()
        https://git.kernel.org/broonie/spi/c/673214ac9bcd
[10/10] spi: uniphier: Use FIELD_MODIFY()
        https://git.kernel.org/broonie/spi/c/ce7984bea2a1

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

