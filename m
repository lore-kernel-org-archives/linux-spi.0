Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533885;
	b=eXFnZKixsV/JUGHGKYa2uFBjNfEKw1ZEDMr2jpnPm8QoDXxwR1gfHw3Hvdq0qZP4IdAX
	 dKhPxdrj6n0G9XZugToqkkHKboEr8TAMGUkKoB5xQBF79w4WEDMKGktiNwzpJJ0DYQ5cZ
	 c6qfl99CXnzREFBFhThq7FIo1IwOLnufFbgZUn7itTc/TCmn+zOnKJEWyuHg2RMLAADDb
	 WbyNj1v9tb1uCbaWgW6yNorxhLIZokxa3bVpvzCh6PIrIhbodZ3tdNGf6ThUKLD8iwRLF
	 xRhqg4aqT+xbEtSZJug0Xxcos9hDYOdF1dSvUnCH8YNtm+sA4Ha3c06jfn9OcpTZY8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533885;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=L5RaIVDqU7NPWHLGOuRCt1JyYN8BSygwNONuqz946MI=;
	b=gpXZJiewMNSvGyAWtPZlMxmKYYDMq8KDmj18+wdu22VXP65vhZ1BouZsD24BaqJ89qBh
	 zVSfFlbTpc+Lu97MrRHVWtcEpDAwScjZcvgQbgACve7EcYNVtIqsDnFYPKDoqL6p3YXDI
	 9JRn5c3Ioep4LHur/XJ2MvS4SBexR1LYVA2v3q/66SXoQJ6doeTmwE4dGv67+djXkLD/N
	 Culyshua5lcNB56edQhJsGR1mRxGAMx0vPtXpNLIWC48URra2jfk4xWam6oaYL+28lffu
	 sEAw7+9mT5yWsDl2qM3qzxco+lk4by19oTgwI9cuXneFQ3jnMG7kjjQkaqJw8IULr+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=etFNhmHb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D615606A31E;
	Tue, 24 Nov 2026 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=etFNhmHb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930981F000D2;
	Tue, 24 Nov 2026 15:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795533885;
	bh=L5RaIVDqU7NPWHLGOuRCt1JyYN8BSygwNONuqz946MI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=etFNhmHb+TIXhCbCawFK1wBDk7pLIZ8Qsl6s6uW5t/ybXoSlqiyZMtdQ4iEYJ8BsS
	 Hz+9DrgQPPC+DdXXsYQVhGiZDlyOF6Y+dq2EZ9dGg4FgEImNEGJ4Cq64xZydwOeBoB
	 sE5Uut+3xlh3uIlekwfj7JPE8Bh8iov4p0DQJ/woEbwK7XL9dLzLvk4w52LeMfCqvz
	 y85KpMUZVmhP6bf6TUPqexDPqjwn19UAmwC0wTxTi5LrIgBSB2txogXCqSrHsDLNmD
	 S4UC4RdHke/PoL3r0EpL2bmjgFxn6AMPZvBM4S+xdN0Iwk9HFIeTtE5/wHRhb92Ti6
	 JiWe3JuUe45AA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Luo Yifan <luoyifan@cmss.chinamobile.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20261117020557.20019-1-luoyifan@cmss.chinamobile.com>
References: <20261117020557.20019-1-luoyifan@cmss.chinamobile.com>
Subject: Re: [PATCH] spi: dw-mmio: handle clock and reset failures on
 resume
Message-Id: <179553041910.264265.7756516182543226325.b4-ty@b4>
Date: Tue, 24 Nov 2026 14:26:59 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121; i=broonie@kernel.org;
 h=from:subject:message-id; bh=VZ0m0jl+lPz8Pgr79+Hp+5PrDWCxliOKMJsaQ9UAydc=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJZ11gd81/qVvhp6szjD9WvvFyeUVgRI7dQUotfQG/2p
 sCAhID9HaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZiIJjfDX4kGF9nv33s72c7M
 N1o9+ce7g3ousZU8om8YjK432ifPTWD472ESt9TMRyHNs92B4dsavc137nX52n5y7CoOeX5q/Ws
 7RgA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 17 Nov 2026 10:05:57 +0800, Luo Yifan wrote:
> spi: dw-mmio: handle clock and reset failures on resume

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/1] spi: dw-mmio: handle clock and reset failures on resume
      https://git.kernel.org/broonie/spi/c/f18eef622542

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

