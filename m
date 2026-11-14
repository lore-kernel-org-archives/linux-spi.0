Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794765302;
	b=jkGzG1RmwuR5vw691TwJCFVjyp6spwK0LvVLXAh7dMOfkEaEIlEEgFcGVXCJb91/acVq
	 GJdE48EvvSbDzG4xAe5HNYHSBFYACR/cD6G64wkNyz29vBJYgUxc/QyH3wVLPU5cahF50
	 AjvwDQDF2jKH1h+atQf97EOcoxD1lDyludEKbwaDj/YyMf2mF7W2jcmzJk7ZLHGS8ngMw
	 8AJl6tKsFZMuu81xWMVTvZQU6iiVrs2whWlPPB8KAufv/Mj+GfiwE2eB66+7sb9p2b0Qp
	 y9dQ+Y1xuQcjb0Wdcd0lonrpWDEkfxRAMOYunEdaGqzFo6rA4UKrousysXuTFC02Dyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794765302;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=e+KRSjz5unGISTmIji2Qh3NG8Y9zdvuwaVseTB7OBUI=;
	b=F814ejzu0iLQkpnRRMjzHzuFdBJeZnM3L7akcqSvCychIeTS/9BxtuHcDSCew378R6ZR
	 wYS/+ZJezM8qT+9PjtPdVHjX4R651bo/DcJAAF03bkHlLvJt30SwyDd7WX2N9Vfuhpz/E
	 3uzHLJlZKG2jZkJzYwn8GrL/UVO7SpMt63F5L9a3i3YoTn8vbvS722xNdnFhApgERjOvH
	 MGmOZeCLMJXxbABbk6/SiBaAY5a9GzpeX0qG2+kvbe6N22OuviH5zfAQeTkFakdiTdW8R
	 TGEi2wJTM9dZ6tYgeGNf69aNV7EeVBy0OLJZbs93C3YpszNIMlFrt+/NFLAX+06gqew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zb9DS5Ga;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825D3606A31F;
	Sun, 15 Nov 2026 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zb9DS5Ga
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F58A1F000C4;
	Sun, 15 Nov 2026 17:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794765301;
	bh=e+KRSjz5unGISTmIji2Qh3NG8Y9zdvuwaVseTB7OBUI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Zb9DS5GaYhaJ6Ch9P6489+j1eOAgwsoSPVIXKZ6ccab5Va309Oj/m3amgIVTklthj
	 GZzKvxc9YK01oD93KHf3oTkD3dxZjMI5xJF8nBeqq/RkTvh+LYmxF+MtDeINdLihqg
	 xcvnCUClDZRAtmDALXvgOg8FQY7uL9EXhBCFNXTye3oIKCxKPGZ3ibCV4XSbB7+/OE
	 u8mU5bfP6WqcckcAbdWhs9MhcUHip6RCvZmhin7hGJWYXqQmeVRfA4DB0/x+0U+W68
	 4+ZJG6p8stGVigJ3aRoiYeY1R1M8VEqUPVtMFPRpiaRpQnCw7MEiYTwS2w8THrYgTm
	 HUUDT/cmY1Iuw==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 3AD3C33B9F9C;
	Sun, 15 Nov 2026 17:54:55 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Mauro Lima <mauro.lima@eclypsium.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Pratyush Yadav <p.yadav@ti.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261108203728.25735-1-rosenp@gmail.com>
References: <20261108203728.25735-1-rosenp@gmail.com>
Subject: Re: [PATCH v2] spi: intel: only check locked opmenu for SW
 sequencer operations
Message-Id: <179468058364.102466.10330309101011843963.b4-ty@b4>
Date: Sat, 14 Nov 2026 18:23:03 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Sy0uJjTextcTMdBboR3+Gtyrnv40Wq9GFRPpsf4iyDk=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJ+fny/vuLxrh7RisN75+a48MrUrbmooejp0/FQeleH9
 U5hs3dyHaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZiIfycjw69u2xbFJrE7V8RF
 LHgaNl2d81n1jZG/HidPRuYcobeJGYwMJ3f9zjx/+sprhcw9JyovOgVf5HH42hQ5X7YxU5lf1ym
 bDwA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 08 Nov 2026 12:37:28 -0800, Rosen Penev wrote:
> spi: intel: only check locked opmenu for SW sequencer operations

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/1] spi: intel: only check locked opmenu for SW sequencer operations
      https://git.kernel.org/broonie/spi/c/374557008e5d

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

