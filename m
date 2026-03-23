Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3E41E5714;
	Tue, 24 Mar 2026 00:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774311103; cv=none; b=gZT3+Q1EjvlNjqK2IhUMzwJsI5KBlz/mL9gRq9uBsLWlrVJEIMuNckWwFHxuXXEy9UtE2o7zNNSqSplEgKxoiYAWnb/cGIkwhNHfAtYUqXs0DiyJEkF3U5J4jhnKZKpQ6yE7RkAHnow6Lxihv0LbzM42D69C4JK7XWGPlH8uLiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774311103; c=relaxed/simple;
	bh=Di5mcPNb0r2N+QWMH4UxyuhE6p8fkYgO2pkH90SHdT4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SQFR6mjD9peggkr6AFRj31p0rbl0gydFoznFtGy0YF+m+iKbE7TGVsJCWSBFjNw1WJpswXxByYWujXNF1DK2z55VEZ/9JeM3HpgnvBmhHzeeTthH9aJE5zQnTBEcMcaWLpx8RP3oEH0Rr4mCHSSED8TEGQSxukRg6kbNvZ4Ua9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7r1JImQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7r1JImQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BE8C2BC9E;
	Tue, 24 Mar 2026 00:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774311103;
	bh=Di5mcPNb0r2N+QWMH4UxyuhE6p8fkYgO2pkH90SHdT4=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=f7r1JImQB/SRvnQqdQ62Ik0ATXOFu5eMEUFc4YTTBMHtSqYJ2gVutAKIN/VqjZyeF
	 P2sWCb8H6rrSfm5Knf95lClTIk/6qD2abXnr5aBhHVu/X67jk+7F9AYilQBE84u2yA
	 rT39OWjQR0xJvp7VaLbyF2OcpkWudRMK2uWc0MlRJDN9EvAQ0LyuFLkhCgUNPFBo/b
	 1oxbwvUphkldddonytnk1kx6CJ8qHHZnUTDKibToHOrTSl1x+lGlVT1gCXFfpcXSq7
	 SZtrQQi3Hgc7YNXvUJ+sD/K4XIhpBirnHXziunLrPKWxYxlEVUSz0YcQq0/YACipLq
	 qa0h0Sq6mV5BQ==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, openbmc@lists.ozlabs.org, 
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, Frank.Li@nxp.com, 
 amelie.delaunay@foss.st.com, Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <cover.1773885292.git.xiaopei01@kylinos.cn>
References: <cover.1773885292.git.xiaopei01@kylinos.cn>
Subject: Re: (subset) [PATCH v5 00/17] cleanup in spi by use
 devm_clk_get_enabled
Message-Id: <177429527684.757727.3178430227590182148.b4-ty@b4>
Date: Mon, 23 Mar 2026 19:47:56 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=openpgp-sha256; l=2226; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Di5mcPNb0r2N+QWMH4UxyuhE6p8fkYgO2pkH90SHdT4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpwda8CnOiOloYzFySgYbCE/6hff/7Co6oZovH/
 NYX07fdL5eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCacHWvAAKCRAk1otyXVSH
 0NvUB/4tGt133fOvYsd5ccQQIQOzVbVHSDtwT2WLeR3+X0YErOBbugNfEdY+SSuDTTx5dvleDwv
 RRu/m16aqCnbltqs+xqYo0EXuNKhb/EH7dIXDpbBvc/66u5FoNCTIqeF5Jfab/mZBDBQKddVugr
 5e0Weu5eT9FYS5UydoOJLtwKzXRKlT0OeLmLgYIV5CuL4HKShuJNQ4VHb1+VsVS74JesMhW3FZL
 e9cayQAVBijhwh//ogTcJasWpFIG0iF14Lf9dGiYeeZalKEWH9KveHB6VChUAjuE75JWrl/xt0a
 8vEuC/a9d+boVY7I08rDLiYeqO164RdPm5UbQvrxTWXR5C9G
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 19 Mar 2026 10:03:56 +0800, Pei Xiao wrote:
> cleanup in spi by use devm_clk_get_enabled
> 
> I know that many old SPI drivers should not be modified for hardware
> stability and to reduce maintenance effort. But I can't help cleaning them
> up. To minimize the introduction of issues, I tried not to modify the
> timing of those hardware clock enables.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[02/17] spi: bcm63xx-hsspi: Simplify clock handling with devm_clk_get_enabled()
        https://git.kernel.org/broonie/spi/c/e532e21a246d
[03/17] spi: bcmbca-hsspi: Simplify clock handling with devm_clk_get_enabled()
        https://git.kernel.org/broonie/spi/c/8b237cb10e32
[09/17] spi: sifive: Simplify clock handling with devm_clk_get_enabled()
        https://git.kernel.org/broonie/spi/c/140039c23aca
[13/17] spi: stm32: Simplify clock handling with devm_clk_get_enabled()
        https://git.kernel.org/broonie/spi/c/7da637804805
[14/17] spi: sunplus-sp7021: Simplify clock handling with devm_clk_get_enabled()
        https://git.kernel.org/broonie/spi/c/ea0e916de134
[15/17] spi: uniphier: Simplify clock handling with devm_clk_get_enabled()
        https://git.kernel.org/broonie/spi/c/fbf34af0c6eb
[16/17] spi: zynq-qspi: Simplify clock handling with devm_clk_get_enabled()
        https://git.kernel.org/broonie/spi/c/c9a4136c4746

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

