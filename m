Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8EB270ED7;
	Tue,  7 Apr 2026 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580252; cv=none; b=g4PsvywW3R4MiEonilwhgu+B4/f1VYH9THjLGaz6ADyRCSSbgD4U08DryAKeB9wwJuxbZhnA8r0BclnSfAyr8p/QQPFIjhKxGHhbo84k6VRYJRjYuJQpXAlZGa29h6bx7Iyp4G5jrwjWfueF+ACKo/fyd3CFhL7Xct+NUAY5UcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580252; c=relaxed/simple;
	bh=OTLcOXmaIfWcPVXtCmveKkzNsSZvfPjWzGKzUesx3EU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z6iqjoNR/CHuj2qp3r6/14zA0ax7yJI2JCdPNOiY1e5GcFXbDuL3o+juf91Nsz340xRNCMC2TZw9r7nz6Uoq7c4qQbrtIHPkv39rjOFxZdV2ZW10TPpVYkwRoLNXQ5om4jyZynocQ6mf45wNTfS9yNJiyGT1+r0pHc17TZYyCnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpXy0Ecn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpXy0Ecn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C31DC116C6;
	Tue,  7 Apr 2026 16:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775580251;
	bh=OTLcOXmaIfWcPVXtCmveKkzNsSZvfPjWzGKzUesx3EU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DpXy0EcnnZPtnFAaGsDKazeREJx46aq15xf/UKgzE19eh43h1biXtQ0jEWoEmuMCe
	 duUQM/W6JsXWT5RGKAPO2wJT42/8dv2jn+5HEZFCSVNBw2UbTxWH9QrXrwLd9CrGnA
	 vS9+bVGxujc4vfj5hOZb1KmKl+mL6x4yU3TOdSK3vy0sm/77MS19uX/le1u2leqVna
	 aBYuCXFY3yrdcmd8iLNBEiaFk8HKOs8e+iyXkIYCR2Qd8FkLTZifGJoH8JVZZkq+BR
	 A/PXmdTqNMz9EVGXvUpWt+fCQKPXGMIVqLPhOgWMtMFf5y2ySGC2khVmIPllv8EXC9
	 HwXhiPeM8Co1Q==
From: Mark Brown <broonie@kernel.org>
To: Frank Li <Frank.Li@nxp.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Marek Vasut <marex@nabladev.com>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, kernel@pengutronix.de
In-Reply-To: <20260319-spi-fsl-lpspi-cleanups-v2-0-02b56c5d44a8@pengutronix.de>
References: <20260319-spi-fsl-lpspi-cleanups-v2-0-02b56c5d44a8@pengutronix.de>
Subject: Re: [PATCH spi-next v2 00/11] spi: spi-fsl-lpspi: various cleanup
 and enhancement patches
Message-Id: <177555933572.37897.44593080530337492.b4-ty@b4>
Date: Tue, 07 Apr 2026 11:55:35 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-7a3e7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2778; i=broonie@kernel.org;
 h=from:subject:message-id; bh=OTLcOXmaIfWcPVXtCmveKkzNsSZvfPjWzGKzUesx3EU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp1TRZT2SeWOEi6GIYKMMiG3MM2y+jysCQ7g+GT
 7n+42MEuoqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCadU0WQAKCRAk1otyXVSH
 0IElB/9Nhx8fQ52hxTD9fMvwISsrorXRrcXi+Rz5S3YdkFRyzHqQs0ZxmQcxMwEhJPCLBYFDe52
 idrhL5uvqfCdyTvGIvUkfDt+6w0p2oE9NF/PJy8OF8yPxoqVutB0o6CbneFl71wTE6cogHilQ2D
 gIcpNRutpP5ieUlqlZpdO+BQJ1P1ii4ItEp1y9fSHkjrGPV3UrvvfkFFOB3wAt+fxm0fMVn6wzn
 s2Bp8B7Kg98q7Kq7QuPSf5/+3fyhlcHvEXm1XllGP/xco1ADKlguH5XcdUrk3LNbFPl1lN6dn7Q
 pRS7qCJLHOzeEZlhkIl4gBHx85NvQ8JHo11ER2j01B8AU/sy
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 19 Mar 2026 17:55:34 +0100, Marc Kleine-Budde wrote:
> spi: spi-fsl-lpspi: various cleanup and enhancement patches
> 
> While optimizing the spi-fsl-lpspi driver, I created some cleanup and
> enhacement patches.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[01/11] spi: spi-fsl-lpspi: adapt to kernel coding style
        https://git.kernel.org/broonie/spi/c/8292eded5998
[02/11] spi: spi-fsl-lpspi: fsl_lpspi_set_watermark(): use FIELD_PREP() to encode FIFO Control register
        https://git.kernel.org/broonie/spi/c/732b903ea3e2
[03/11] spi: spi-fsl-lpspi: fsl_lpspi_probe(): use FIELD_GET to decode Parameter register and add size check
        https://git.kernel.org/broonie/spi/c/6e5431f4d0b6
[04/11] spi: spi-fsl-lpspi: fsl_lpspi_set_cmd(): use mode from struct fsl_lpspi_data::config::mode
        https://git.kernel.org/broonie/spi/c/b191fbf446bc
[05/11] spi: spi-fsl-lpspi: fsl_lpspi_set_cmd(): remove obfuscated and obsolete assignment of TCR_CPOL and SPI_CPHA
        https://git.kernel.org/broonie/spi/c/1712be8623b2
[06/11] spi: spi-fsl-lpspi: fsl_lpspi_set_cmd(): use FIELD_PREP to encode Transmit Command register
        https://git.kernel.org/broonie/spi/c/c6e178460434
[07/11] spi: spi-fsl-lpspi: fsl_lpspi_setup_transfer(): remove useless spi_transfer NULL pointer check
        https://git.kernel.org/broonie/spi/c/ca431d50bf62
[08/11] spi: spi-fsl-lpspi: fsl_lpspi_can_dma(): directly assign return value to fsl_lpspi->usedma
        https://git.kernel.org/broonie/spi/c/e59fe5e0c418
[09/11] spi: spi-fsl-lpspi: fsl_lpspi_reset(): convert to void function
        https://git.kernel.org/broonie/spi/c/b326c71d4e6f
[10/11] spi: spi-fsl-lpspi: fsl_lpspi_write_tx_fifo(): simplify while() loop check
        https://git.kernel.org/broonie/spi/c/4ef7fa7bca57
[11/11] spi: spi-fsl-lpspi: make struct lpspi_config::mode u32
        https://git.kernel.org/broonie/spi/c/baa1cb259cc7

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

