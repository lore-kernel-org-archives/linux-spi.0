Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795093152;
	b=gS/i8YKkxyzomFirO7I0W3XXjTma/xHosviw/fKCw4WFDdhStnOZILgS0nDTWsY5xssO
	 krTtCLX35XVSiy0S+sFK9UAo54kAySscxY6dFW9+BDnXHcLjrNHreVzLmSAEg1kn1eIDb
	 5PYx3k45kXE/ZW1FGDUxDcVD0MZdbjfTeueu6KdmWBeL+z5Ye7Dfgj7n0Z5ojj+cPreRg
	 7Wm+bQrKXOsfBxuZKr66q9B9lUJkDR6tyZCLM/t4eTWkcno3wmmPaV6NXyEWtWPPr/s2O
	 nqFrQ0oMa57ARIIqLSWm9GwwJo048enmUC0gjIAGa4jYq3y6dmdQV5lT+etFIpD50xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795093152;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=u1SN1hC9VIgGoRZ9A5lVags89D283dZdE9oZilD1ZWs=;
	b=qFZ2Dzr9QyuMpsDSGv4bZH64iZSNsa3UEmfISWSCmjCGMpcq2fn3aWdqvy/MdnzL+Jhp
	 WnVJWcz4M2X1aSZNAYeFjlZrpoX0C5ai+KRvCp+XlxwrUnBh77eLJfwoXR9jBqZ/FrK6v
	 7/5hzxmUyF2BoOZ0nJhBgWA+jY1591qqA9EH+bIcGNf87Fz343mkVtW8U+FLaaS8QnB64
	 bznutdi5rtiZ0dqVXAak6tUeB+ab1MkXufS34di+D/GPWlEFQYXMrnjns+903KiJNZXAV
	 N3omsl7Jg9yo/nkeQPpj0S4yHwlYCyFekELczLoeDMbqDXQxFPXygIVkCqWiTMO8/XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JbgCWTEh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC98606A320;
	Thu, 19 Nov 2026 12:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JbgCWTEh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F8C1F000C6;
	Thu, 19 Nov 2026 12:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795093151;
	bh=u1SN1hC9VIgGoRZ9A5lVags89D283dZdE9oZilD1ZWs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=JbgCWTEh7AP6a7DkIhtJ4Z28RPWcN/avbNXbtJhF+OxCRAHBoGShX2dV122ccQ0v6
	 AwboFdq6PccwueCCmW37QOjquYjoKbAYB+9z8hJN8igvxeROvch9wVZAhrdgnoTY3j
	 yBjeB6uTJB+R6aceYQzconlvT6ZWMXETOI/j7gBiXOrcN609QeUL0QBMhyBj2RUW9F
	 M3HvFvErSO8NEEC2vquAaU70yc2PQjOFdZnpk3niMd+Y4+cDmCT34f6Bn13AYrpa8E
	 L/Jd1KqE4V/1r5lDVwP4Fa5bukTi2vh63Cc9t4FJvyrqy+C487re9OM0IZdSABkqv2
	 J5fRrLeqjpJKw==
From: Mark Brown <broonie@kernel.org>
To: Frank Li <Frank.Li@nxp.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261009-spi-fsl-lpspi-more-cleanups-v1-0-2d4549d5205e@pengutronix.de>
References: <20261009-spi-fsl-lpspi-more-cleanups-v1-0-2d4549d5205e@pengutronix.de>
Subject: Re: (subset) [PATCH spi-next 0/3] spi: spi-fsl-lpspi: various
 cleanup and enhancement patches - part 2
Message-Id: <179501545047.349622.14638244834416296314.b4-ty@b4>
Date: Wed, 18 Nov 2026 15:24:10 +0000
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev

On Fri, 09 Oct 2026 12:16:34 +0200, Marc Kleine-Budde wrote:
> spi: spi-fsl-lpspi: various cleanup and enhancement patches - part 2
> 
> While optimizing the spi-fsl-lpspi driver, I created some cleanup and
> enhacement patches.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/3] spi: spi-fsl-lpspi: pass struct fsl_lpspi_data instead of struct spi_controller if possible
      https://git.kernel.org/broonie/spi/c/4eac392e48fc
[2/3] spi: spi-fsl-lpspi: fsl_lpspi_transfer_one(): directly return ret
      https://git.kernel.org/broonie/spi/c/b0f0c761ed3f

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

