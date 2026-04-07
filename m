Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573263B0AFB;
	Tue,  7 Apr 2026 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580319; cv=none; b=QYgt61EjSZp3X6azeAVJgAob3UieI00PIA1BeWgYiGpaQVEbpfmpSCNLui7XCU08O6lyXN29rKBvd/f8/PN7HGrGD0qUf964qzQ3z1V+mguYRv9ABI7FIhyDqZoqvoxaCNgjDl0YDRlgECqO7SKYyqMDB0YoQzq0Eh3biSg0CcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580319; c=relaxed/simple;
	bh=OFlRtoTBxT3ZxOuAalmu5V1pi+W9APG3C/5lSVlhBBQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=effGVddfBld25jXPs4CcgfFLHMmM+vCMxIf3D8/dmA7RH4pmLt1LM104EdvhRCX+aYprbhQ6wpXbACyQjdJbzh9e2yzM9OxtIpPEOtvK1Jpkaax2vIPEcowTcTegz8y03yVgJ1KoTSFQXtEgjhHdwW/wBm5aIdzMNsTYsmEjppI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFqpBEv6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFqpBEv6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5907BC116C6;
	Tue,  7 Apr 2026 16:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775580319;
	bh=OFlRtoTBxT3ZxOuAalmu5V1pi+W9APG3C/5lSVlhBBQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gFqpBEv6UMH2PcF/phLs11ehyjSJUifWvvx3noZN9EkBhOpGpXg1PbOQcb7mtInDQ
	 BV1jLwZwGax89efI5/VMbi/733PExXDUScK50MdziAHR0xxWKm9sm6DhVfMwqPuP4i
	 8n6pQrsXVFLJ1beY7Z+8sOLANr6DJnUMtFrKp4/sggGmxHfgxGMUZmqE8/1vLNk+f5
	 gasR0panHXW8bm7a4Ck601k+/erRlbOMX1+JzYWjNecltJ7CxyrGAmGjcgnTCwqO+r
	 5OyGBJKIb4lMAAl2rrQtvV69XTlZTaJM3WZrJBd/duMVux1tuBu+6npUJ0MFal7TEa
	 5+GdnoEUMJmww==
From: Mark Brown <broonie@kernel.org>
To: Frank Li <Frank.Li@nxp.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marek Vasut <marex@nabladev.com>, James Clark <james.clark@linaro.org>
In-Reply-To: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
References: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
Subject: Re: [PATCH spi-next 00/11] spi: spi-fsl-lpspi: various cleanup and
 enhancement patches
Message-Id: <177558031709.133725.10452867057722173874.b4-ty@b4>
Date: Tue, 07 Apr 2026 17:45:17 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-7a3e7

On Mon, 16 Mar 2026 09:39:01 +0100, Marc Kleine-Budde wrote:
> While optimizing the spi-fsl-lpspi driver, I created some cleanup and
> enhacement patches.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/11] spi: spi-fsl-lpspi: adapt to kernel coding style
        https://git.kernel.org/broonie/misc/c/8292eded5998
[02/11] spi: spi-fsl-lpspi: fsl_lpspi_probe(): use FIELD_GET to decode Parameter register
        (no commit info)
[03/11] spi: spi-fsl-lpspi: fsl_lpspi_set_cmd(): use FIELD_PREP to encode Transmit Command register
        https://git.kernel.org/broonie/misc/c/c6e178460434
[04/11] spi: spi-fsl-lpspi: fsl_lpspi_set_watermark(): use FIELD_PREP() to encode FIFO Status register
        (no commit info)
[05/11] spi: spi-fsl-lpspi: fsl_lpspi_setup_transfer(): remove useless spi_transfer NULL pointer check
        https://git.kernel.org/broonie/misc/c/ca431d50bf62
[06/11] spi: spi-fsl-lpspi: fsl_lpspi_can_dma(): directly assign return value to fsl_lpspi->usedma
        https://git.kernel.org/broonie/misc/c/e59fe5e0c418
[07/11] spi: spi-fsl-lpspi: fsl_lpspi_reset(): convert to void
        (no commit info)
[08/11] spi: spi-fsl-lpspi: fsl_lpspi_write_tx_fifo(): simplify while() loop check
        https://git.kernel.org/broonie/misc/c/4ef7fa7bca57
[09/11] spi: spi-fsl-lpspi: make struct lpspi_config::mode u32
        https://git.kernel.org/broonie/misc/c/baa1cb259cc7
[10/11] spi: spi-fsl-lpspi: fsl_lpspi_set_cmd(): use mode from (struct fsl_lpspi_data::config::mode
        (no commit info)
[11/11] spi: spi-fsl-lpspi: fsl_lpspi_set_bitrate(): don't treat devtype_data->prescale_max == 0 as a special case
        (no commit info)

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

