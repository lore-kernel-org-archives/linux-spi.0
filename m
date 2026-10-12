Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7BE4E7802;
	Tue, 13 Oct 2026 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896513; cv=none; b=lNFI4MepOl1vDuPmw2TxVrewMRRwC2VZOL7MeF+w5iWLC7cHE84ByLYQLts0oMvBkCv/LpbWAqiR5Qb2ITX1waAhLacQnS4gtmqshBGRmNZseL6ex2bc98HPc6Z/ECvFA2fSXjUa/nFRiHSLYW9lGGlhtRWeFnhdLHjj/5mjIXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896513; c=relaxed/simple;
	bh=NuOh7wBIhZd1RHO4Rus6m4rMR/l7DagzeucNd2UIMtc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dkGVEmQYplwS89SvHKzJqhFWckfyVjtMmZzYSIRJCbd0LdMjsAojdpQsgJEDGM2VVFKmmZlWJ2oQ+s4RMjtXp5xCKUnCdXGpBoG/rfBwtllh+xfSD2C4OyO929dAsFRDCnbJEl11iG8vFERJih9mqhoffMRDrazEHVVSaw6n1Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaL1sXz0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaL1sXz0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44A31F000FF;
	Tue, 13 Oct 2026 13:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791896512;
	bh=+2KWlNH/dKYBZGhB27/EiZHrWU4ncrZivuoz8zhAMVo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=BaL1sXz0vei7p6io5bpoMKh777p7eGxXtlIiQrInX2k5dI5BZndHFs0qsIaqZZv0p
	 MqZNWGXcP9t1yss93KiUNlRBBQcTEC4+O9EuW4Aos4RR8BhG/3njS+X/sImJDELrB5
	 hHSsnWmU4zU8HzmBm5estxyDdathjH7adDK1fVaedQxtIKeh0CtFA4i7Jz+mPHk6uX
	 BJ192zm8pWENI9OvExCLW1w5PrS0sPBhB1yE3Qv8DPlv/1oSOnbHn+GZmdfULFTXyS
	 mt3X2VhKDyaTvEt4D5HqIa65lxkIAA4/19G1uSHjXB8H68nL5yhalPzEk576yQn7ay
	 uMmFbVrbqPIFQ==
From: Mark Brown <broonie@kernel.org>
To: Aayush Kumar <code@aayushk.dev>
Cc: william.zhang@broadcom.com, kursad.oney@broadcom.com, 
 jonas.gorski@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261009133631.579644-1-code@aayushk.dev>
References: <20261009133631.579644-1-code@aayushk.dev>
Subject: Re: [PATCH 0/2] spi: use sysfs_emit() in bcm63xx-hsspi and
 bcmbca-hsspi
Message-Id: <179184447901.390394.5153297919246175143.b4-ty@b4>
Date: Mon, 12 Oct 2026 23:34:39 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1499; i=broonie@kernel.org;
 h=from:subject:message-id; bh=NuOh7wBIhZd1RHO4Rus6m4rMR/l7DagzeucNd2UIMtc=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLOae+dtaBzmfr3M5x2d4Nyr/ZWv82RfmToKLetVmB22
 zGJxOfRHaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZjIAW6G/0X5c3kyZ4vcnjX7
 4MmwmOop7AfWfzry8enehpfRuvf0eH4x/DP2PNS7eTbrhl8PJ31o/sk4fePk6Qm6Lrall5lnaT5
 3a+MGAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 09 Oct 2026 19:06:29 +0530, Aayush Kumar wrote:
> spi: use sysfs_emit() in bcm63xx-hsspi and bcmbca-hsspi
> 
> Convert the sysfs show() functions to use sysfs_emit() instead of
> sprintf().
> 
> Aayush Kumar (2):
>   spi: bcm63xx-hsspi: Use sysfs_emit() instead of sprintf()
>   spi: bcmbca-hsspi: Use sysfs_emit() instead of sprintf()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/2] spi: bcm63xx-hsspi: Use sysfs_emit() instead of sprintf()
      https://git.kernel.org/broonie/misc/c/516d487c6037
[2/2] spi: bcmbca-hsspi: Use sysfs_emit() instead of sprintf()
      https://git.kernel.org/broonie/misc/c/2bc876264259

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

