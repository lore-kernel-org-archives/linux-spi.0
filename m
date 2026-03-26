Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99783BFE24;
	Thu, 26 Mar 2026 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542061; cv=none; b=CF4CwT/m3j7Bhp/NTR13Hm8aXu5GoVClH8TG7tB3G9BF/URhWpNx4WlCS8Jhta7hg/1QuZXh3hstW+SL8lUcwoKcH+aWzhx15N1mJCBuEYhFL8YcICHFH8qR/zy0RC6TIFE+CYH+uSB4oYXAVmQEXPrCq0Uin2+wvn48pAhvEKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542061; c=relaxed/simple;
	bh=oDc/asrNtjbRShjL6ywRMMEViwgWbWOLc1VPOq0yH0g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c3lusW/2uw+clZbzpNC4MYO3wX0Z3xMk1/wZuTpEeChmfluRQ/fly3nJyAbZAg0psnHy1z88AGkOQ2oAza0y2y6sjtCmfJJx9GPhjPhOan2C27tjUjagh70/NWT2/4adSpiaP6wOUJqZ5L5eefzGFCyyGQ9EX5zp+RgFhcvnc/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpC1qXn2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpC1qXn2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E344AC19424;
	Thu, 26 Mar 2026 16:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774542061;
	bh=oDc/asrNtjbRShjL6ywRMMEViwgWbWOLc1VPOq0yH0g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hpC1qXn2Iz1oT69tE3pc1/gxjA/ef415jpTwIq+xKDDt4zxf6X9hU/jN70YyOABhc
	 J5JW4Xet3dJUS7Gxm+CUHOWFkATCMY29oeedHyLoINJvJUbn8tZPp2r9YyhL5vEK/f
	 YaBKb9+2DuDvqiu0mQcaQf7HFkKYHxCkTn6I9nkU/Z0Y3Cg1Q5eKRXNXUXHbZsfDI/
	 fcNMuCv4dU37bzaADYGsWi9JpCopCiTeCriih0PP0MdbfpaoboDyqt3cRK0eG8oU06
	 T3j46lzpRTodrfYtFrFLQI1dJa3MenPIg84LIp3duMvcMECMxUe2fMTymgXkhIu42g
	 DAiAgaVcgi+qA==
From: Mark Brown <broonie@kernel.org>
To: Frank Li <Frank.Li@nxp.com>, Gao Pan <pandy.gao@nxp.com>, 
 Fugang Duan <B38611@freescale.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260319-spi-fsl-lpspi-fixes-v1-1-b433e435b2d8@pengutronix.de>
References: <20260319-spi-fsl-lpspi-fixes-v1-1-b433e435b2d8@pengutronix.de>
Subject: Re: [PATCH spi] spi: spi-fsl-lpspi: fix teardown order issue (UAF)
Message-Id: <177452806820.64163.17076242575488529940.b4-ty@b4>
Date: Thu, 26 Mar 2026 12:27:48 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-ad80c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119; i=broonie@kernel.org;
 h=from:subject:message-id; bh=oDc/asrNtjbRShjL6ywRMMEViwgWbWOLc1VPOq0yH0g=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpxVzqa0vUBLUnDJIrdn9p1HV304rWLH51/FHDF
 mUuXuRZix2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCacVc6gAKCRAk1otyXVSH
 0PXzB/4pefMCzoCJ1vM4ldKe/eqaXxniUaANuPCm5ofDzLQSdv7mZaw8QrcbW1QzwjH3THnioUc
 3PmvDltiUR+0XaPORwRn9/Z2xSAVu+LPF6n2v9/ov/t7CAOc4AAehINaBP58Ymj6IikOoChE1N3
 QdoreBBJLU4OUvidLSnzL3BIgdAo8pXDwqKN1176G+h3A5n5i7EpdcvZfuPk1AjMVZFvZ0lHKKi
 QOha98myirF9+NsRiivvonaparHc6skUOMtS5AfUGjJj2wIv/jo9tWvcgYtvSqZZJC3pmTJPVG7
 2S8RL8nqlR63Yym7sgqs7OGPQMXJEx7fP9g18xJkUkm4rWpV
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 19 Mar 2026 19:38:12 +0100, Marc Kleine-Budde wrote:
> spi: spi-fsl-lpspi: fix teardown order issue (UAF)

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.0

Thanks!

[1/1] spi: spi-fsl-lpspi: fix teardown order issue (UAF)
      https://git.kernel.org/broonie/spi/c/b341c1176f2e

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

