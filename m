Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482597;
	b=OIEe4rEkHpoeuJ3x03Iim64vdX7+faQPIq4l/EKLxydm9UtxZ1VxB8wEd0WExbA9x6kD
	 XYc8JlFdkzK7cpIVjGsnT4TTkvwGIekWRz+g92LIAC5kgwr/6EqmBi+y5UDow5iVDWJ88
	 GP4P1OiMZwQbED990/hTklmScmDjqTnMtgkvUCmqUNK/b9ZHzdfOzIgGG81uzmY01iIpd
	 KiFqdjDz+g9OGm0AvccA9FXCnhoTsAS76DgkflqSm1/g7qHnYwrsLv+T6mwXdy3B2GR0M
	 fMY1gz5LA8NPYSg5fvGDb/ymPaCXYDNASLEbMBkVmDzwVFqZiVJrxRTKK/QFbp4VnXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482597;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=DZX7LrkkoITSV9q8/hf9tQANgdUAkilb9PapYVkP0Us=;
	b=4GpXONGjYXSmWOFgsJbrI4EsV9cN7hx1dqvxeVtF/uR9WSVGnxeMI5M0FdN18vrhjmkk
	 aBYZ/v5CXzXmLypxgVbg1ZLi09tpWDidL+ZgU1oWofi9vnR1wMz/4dFatUp7J2xAqsV/l
	 ahnlR2H6WleVG/3viNJ2htYyW7bnJp/7cf1Pguxt5E9CjkuYQlxuxACs8WQ3TGS1IZBDc
	 UY136zGV9OWCGQW0MsUhLpF6dxRGzqgho5jKeBFLD8dh+8h1SxXQ9zhmjaoxnK8oSAX4l
	 8e8nNP5HkfGIvKJGsc8ipsZ60muNUhmRwG56lZeU/HoWNy3vjTSxKZjrH99+ZtOPurQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YqmAvoQX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C3E606B5A7;
	Thu, 12 Nov 2026 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YqmAvoQX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84BA1F00A09;
	Thu, 12 Nov 2026 11:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794482597;
	bh=DZX7LrkkoITSV9q8/hf9tQANgdUAkilb9PapYVkP0Us=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=YqmAvoQX8W4N+wqZSyw9pDbbUpniRn45n7LV6ZTubKpQXfpqBlFX4JcoAfVoZAIlS
	 OLASWhwS0rZjwY2tt6LsppgyHiLisBJgYxORqQGH8GydG3Od699tTjKm6x+Eqx9Fq9
	 fqpBzyJB0pTPWq+WFptNg+vhtcaBcuVubPOQvrPyOFv74DaFluwQ/sV9GjXdENntVL
	 uB7UZ5EQbZd014TkijwPVJ2BNPvwfAWcGtFR36y3jzwh6vbA4rTZOqn1rWfUpKKuqc
	 ImWGVpkZJRNg1PLXnpN2SoYoEDEHYEg8uYQBD2BK/HMLr+h7zj+IWX8qCZEBOOicC5
	 7fqJWGLRqDkjA==
From: Mark Brown <broonie@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Tomasz Unger <tomasz.unger@yahoo.pl>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261110-spi-bcm2835-kdoc-return-v1-1-dffdfcc36233@yahoo.pl>
References: <20261110-spi-bcm2835-kdoc-return-v1-1-dffdfcc36233@yahoo.pl>
Subject: Re: [PATCH] spi: bcm2835: Add missing kernel-doc Return sections
Message-Id: <179441977679.393238.9199268057403171713.b4-ty@b4>
Date: Wed, 11 Nov 2026 17:56:16 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1118; i=broonie@kernel.org;
 h=from:subject:message-id; bh=WxllxCixDuNeTCya0yxN5aR0r/TIzJI3BYcLFM2baPM=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLK+LlwUd+xWgOOCyIXfLpjOipJ/w7ysnbNxw59nZk+Cr
 T48CtvM3VHKwiDGxSArpsgSl8X9sr7k9Rq+gwvbYOawMoEMYeDiFICJvFNi+Kfn3XP5sNGtTO6a
 wN+MHOIqL49/nqJp2X0hVndH3JZd8xYx/A/fHLl0pdPcy9JSz92nn3k2WTmDObDrxcm3nU3T09t
 st/MBAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 10 Nov 2026 22:33:02 +0100, Tomasz Unger wrote:
> spi: bcm2835: Add missing kernel-doc Return sections

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/1] spi: bcm2835: Add missing kernel-doc Return sections
      https://git.kernel.org/broonie/spi/c/2a28392d4b4c

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

