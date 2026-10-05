Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40AE3DC85B;
	Tue,  6 Oct 2026 08:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791274440; cv=none; b=qySMhatYYLoX9Kt0+ZxOWRHA6YtNw7DBwXcY9K69pHlzxl9lOb24wC0ShwdekElZ4Mp6oecsyToQ5Fqz4bePTEICwIv0iriU4KzJUPm6LXR4SzADmpZ7wZouZBrwa/FlV9yAiJJyDfJPgmT9+EDLNdrBka/R48HYsOHB/sJvLss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791274440; c=relaxed/simple;
	bh=o2FrFfJqrmwHAqZaM67EDMTPDIxs030awJYY0W+qBco=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cc0O4xrQ+kFXDWHyULH+IvWalz2h0Enbh3t2Plem+ANgE+pBegKCd62UDAs4Y+yBrYbOKG7fyrl5luiA+3TNJd+k01efIrx1NVfKh7mAANRDRhKQoRMGJHAHts2YtHgLyaXgQYZSVnDMsCKYuXpD9kfO3GL3X6Vv+VxHW7/Ku48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDPiO0co; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDPiO0co"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFB21F00899;
	Tue,  6 Oct 2026 08:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791274430;
	bh=V6C9qnw9ePpmNl5mKGjfB+NFMxIvZxKc+2QodoMOIyQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MDPiO0coNRsuZkh5YtHeQdEJZQSY2O8lkXu9fjQXZ54CNue6RJnJvRSobBuTuh6Rq
	 9rlII8TuYOrhpjMXC8082j8BeSPgrDyxDKE10xFGduLtlYlqYMH48Sd1/rd99uJfdd
	 4QYLzOREVMhPyQLLnUhZ8j86El9ubnRR6gNR7ft0gpiia7hYO0tNAuCKpUBb2dztOF
	 9jYBx5k7IkQFr5/PzGCkywFXGcS1NPOMdNMi8Vi+zY35vJLGUPXR+Yp1awAVl3vyXz
	 pHofCmGwEGPQqFbWk8SxzKQtwI4FcPyjkMcABMSQ+0N9i/3vuVX7QvnEOWxzHIsLZQ
	 GeV7YKT9O4Ziw==
From: Mark Brown <broonie@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261003161807.59429-1-changhuang.liang@starfivetech.com>
References: <20261003161807.59429-1-changhuang.liang@starfivetech.com>
Subject: Re: [PATCH] spi: dw: Unconditionally stop DMA on errors
Message-Id: <179120948750.150114.14401915611644765641.b4-ty@b4>
Date: Mon, 05 Oct 2026 16:11:27 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104; i=broonie@kernel.org;
 h=from:subject:message-id; bh=o2FrFfJqrmwHAqZaM67EDMTPDIxs030awJYY0W+qBco=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqxK25q90IJ8R483KLwciYX/IZ730z4dXhi6m4u
 G1tl5bYvsSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCasStuQAKCRAk1otyXVSH
 0DFTB/0eOtnKvZ0uj2FC80+QfHD15mcPyh5ex85SeWHO2/kbdwajMmYlqAS6iKyKXLgeHzlJWvu
 xKbwewu6T2WuPbrjdMuLoqa7YKfFQlA+lf4GbFmTcDBqQMdNxpBMetP1v86mmxoghiR+yLJAxoc
 vrpt9XSDhJBgLJ4T3iIW8nqUrwREbnze/eM8fHo2CX3aeKiamWjqsyp304TH5jhC4AWfFopm9Uk
 t6nxQYRqxjo5zbH6afoANfIPtrWpJDvUU7rwsZYoIBsVakC5Y9HOVVuMiRZXlgtQ00MQuEqCWS8
 oMYHxjUZKzVwTQL1K5k3CvwU9C0GcU4ZYlnIzhP6/laiQI6U
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 03 Oct 2026 09:18:07 -0700, Changhuang Liang wrote:
> spi: dw: Unconditionally stop DMA on errors

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: dw: Unconditionally stop DMA on errors
      https://git.kernel.org/broonie/spi/c/37bc964c2da7

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

