Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E9F274FEB;
	Mon, 16 Mar 2026 01:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625073; cv=none; b=PaaxNYxk8pav1udthhN7tvYsemcX1Uwi1SzqOJpPdqnG3snbntFdd/v2zElKhQr4Vw/oUAVzBMH3DxLb5KagGvNxQa+4mkYyIcGdCXSKUTbJiRQ0z3GHx0shP+XyAlz84GpY1olK8pKiCDweJfFu72713/tya63gUJ0B/sUDDtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625073; c=relaxed/simple;
	bh=Glq6+9XIxCd/jbXJKc9VoKiZnzvS4fGwihV1NGcUWkM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DwMD9BpxL3SnyEcPqFOQ0R1lheUoELMnEHHOMX6TtOrGZnSa2WOVHslOdO7p5ziFPxybcD2cYSv39riU+R45JT5HnaVIQoUiA5GQBvnZHEnswB0wum8pJ+yMHpY8LTwfyHjmMmX7xtVX5K/bKTpeXDBFDf6UX5jwUzeh+aS4WKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgxra6gd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgxra6gd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA15C2BCAF;
	Mon, 16 Mar 2026 01:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773625073;
	bh=Glq6+9XIxCd/jbXJKc9VoKiZnzvS4fGwihV1NGcUWkM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sgxra6gdshGQIKJe0znZKli2r9Lgi8D+0zFGpdmTnkm3rgG+eMMyqzO0Svd1wLtx5
	 9jjIHnyRdOMOygmOeqUka9Kf87umnBfX9mRJTT1VHtbuHvFDXf2degfV98LHrgVXD2
	 SThO78HzeEH9J72DOUt65atgzarcqh1JjW5zRdqbz5+q17mkS3zNuXZDUhuFz7WJ28
	 8XdHvychqYRGPy5plp/4SNOEYwH7EoI6sglSuwvM2IL7ORYRRuilvZi0E21nR0nbId
	 KCVrpv8eDKyYx2IvkDBUV6AsryPfxB3NfyiSbo67KtK5fI4cio6ajyjxTT+zCnHzao
	 Akq4V43g9hbhA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 xiaopeitux@foxmail.com, CL Wang <cl634@andestech.com>
Cc: kernel test robot <lkp@intel.com>, Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <20260303024737.1791196-1-cl634@andestech.com>
References: <20260303024737.1791196-1-cl634@andestech.com>
Subject: Re: [PATCH] spi: atcspi200: Handle invalid buswidth and fix
 compiler warning
Message-Id: <177352554518.149922.6765955948112155408.b4-ty@kernel.org>
Date: Sat, 14 Mar 2026 21:59:05 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1138; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Glq6+9XIxCd/jbXJKc9VoKiZnzvS4fGwihV1NGcUWkM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpt17ucVvsa2eBiLUMXho+NHDJcgYta1MkJVCTD
 FgoKQflSLCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCabde7gAKCRAk1otyXVSH
 0OwDB/9ZooaQ5Ju/wBd0u9c8C54OdBroO70INLKApJ22A/HXT7J7ekvn1Xaww7Ph2jC88+Oh8KP
 PYWniO2+Xql5Rs0slsPT8c5O/NqFiYtETpyUsGcj+B7Q+//SkUugwS2aaJ87yMIMt7y+O4/sal5
 vqnxwfSUX4dBwhNf+2qIQR74Yh1X19CTDwFt3aeBBPM6a1lm7Uz5+TMAzmUkKrMIzakOm9dJz4o
 afAedyOcoSTUknFSXWatSt2DaaZQxCSnaEesuR10yuYbAOltZjJDQiSJhCjTvYnvHTtjseExehU
 jSbPJn8zgLKbCDtsI1Y61gjmSdicDq1jG2P+YxSq39nhapXv
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 03 Mar 2026 10:47:37 +0800, CL Wang wrote:
> spi: atcspi200: Handle invalid buswidth and fix compiler warning

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.0

Thanks!

[1/1] spi: atcspi200: Handle invalid buswidth and fix compiler warning
      https://git.kernel.org/broonie/misc/c/f879365c5bb2

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

