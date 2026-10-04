Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FEE2D249B;
	Mon,  5 Oct 2026 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791216234; cv=none; b=A8fh7c2waIaPpARUKE6SpqXzVcW4SEhsFjfjeTS7dsYLn85s/yoW+P/BA+Bu4QxUFmMlqjEHA0+iX0lY/GGsreANVH3e69t/XgwepIRK0zMTD6W1UBSlcqA4yEbfcwTIOqzh0X6oCqbeopve6MTm8RLTe8onxYbPUEIz8OTaTgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791216234; c=relaxed/simple;
	bh=3wivVijZ6QtEHqNiTFkYR+pzGLpET6cGzfTLooWvoV8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Em2Lo3zctUeJS0/T75PIjaZNPglS56pxqWwCXNimGCUGyIX5FRbGaEWv6yNtMrOL9aZdT0ONIyYTJAkRHoVJdFe437u7fsCB01yy/hK1KXYsx4f3u/+sCE57xA80NIu7hJRtmFyVatCb39vLtUvSXOob4W8S90SfJjWUBTe75kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/SmWcsf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/SmWcsf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8691F000FF;
	Mon,  5 Oct 2026 16:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791216233;
	bh=3I7X7qg8cSReFfZUwo1DCcvj2OWKH+QnOqcW/ywr3q4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=U/SmWcsf8jXHE5CV0SDWMPFna0NN2MEFTIq5U3iTQf1Gy4Ij/T6NSqJZLj4hieS5I
	 Xs15m1dTilQ91A5uI7PTsiZGGcSEcbcA4iQzEo87pjEGZPLvA9MSlcuMow4vIPPrNt
	 7bTqbPWX06XLwNVtH7tcaMmC6e29O68ijt5cTdWy2Ee2qyE86SpwSir53+zhCX3qx5
	 7ucJyM82TnB3Vrrbik6xFCYwvWiJGLiDZ4OmogJnMJIlG+gMMalq/L/aRwpjoI4SrL
	 1ufKaGzYEY/PSDiaQ4gbjPa7DnqzKyNp2zR8bESaI+5HisWOePbeVGHzsiztlMKLI/
	 ywCrONRMbIojA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Alban Bedel <alban.bedel@lht.dlh.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20261001153507.2011806-1-alban.bedel@lht.dlh.de>
References: <20261001153507.2011806-1-alban.bedel@lht.dlh.de>
Subject: Re: [PATCH] spi: Fix ACPI SPI resources using relative path
Message-Id: <179114905426.150114.11326796595038562001.b4-ty@b4>
Date: Sun, 04 Oct 2026 23:24:14 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1107; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3wivVijZ6QtEHqNiTFkYR+pzGLpET6cGzfTLooWvoV8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqw8pjPOut0UkwLdhtfVVF4hsr3GLIXVHFrLST3
 e7xJFl7fDWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCasPKYwAKCRAk1otyXVSH
 0Ca+B/4uaTOFUja+2muzlYGZajUdJyaKMadfVBNnQ8K9PuO9DWrcaG/Pmq3WiCIDAckN4OG5e0W
 j2uZwsN9fGhseUWXIYmRz3MOoj/zFyLu/N+jDyY80yLu18LguYGwBa1YZhHVEfMc912FUTfyvbu
 07lZnGEB5vmepR02cBtE2dB3g4HUPgNxHRku/GZ5eRZYjNOTZ9uW/r3TXkZBL9UdlJ0YPEILqBs
 wZsYt1Qi+WLkMbfU5dugTq1Oknskui9koMfYkAbYlQScLaPrMyfmUQKWMMvn4UjSEJuEk0RSoEH
 RE72vMwOAyjjZxYi1HgA3ktSeNhDJSGACtDUqpAVEWh9ENEk
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 01 Oct 2026 17:35:07 +0200, Alban Bedel wrote:
> spi: Fix ACPI SPI resources using relative path

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: Fix ACPI SPI resources using relative path
      https://git.kernel.org/broonie/spi/c/4825287f6d23

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

