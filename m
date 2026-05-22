Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7C0368D4E;
	Fri, 22 May 2026 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471852; cv=none; b=jnrDFLcwOCH7bWK2wh/Ulwk0538laXgOAsu1efZWa4K00vFYBh1PfnIl/T8WiIQo8guF8qNIsUS3XXk0A0r8cf2/684gHJy7irvPy/Z5Qr8ZtlBjQ6kh5IgbIgUwGf3sRxBmUArJK4Y3jbW++WqMPhJikgXhtpxhKMaAUwrGWZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471852; c=relaxed/simple;
	bh=V07QmYmfsyWHzSefum+3adPA/S+2RNjNUSCGhQS9PSM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Hrxx98k2aeIRxPAscjC0UvUlRaSGEruzhBJmbbmB93XyGIcV2DzRFN+48ToHFzxHHwgMruUrvNbR0Np7SKtpvLlC+OS1os4tSGSW28hN/Km1mX4a6RcEWgCc5/iS5OLTHJN7yARkFA94zy0XGmZteAAQ6cpJECGJxAFiZbfx/7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kN6fB6bu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kN6fB6bu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B431F000E9;
	Fri, 22 May 2026 17:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779471850;
	bh=hlGejMl2U59p2dKLsEwcDxI0EdG8nLITOHDQYQ51LPM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=kN6fB6buAgiSdNJQt7lU8RPifABkdh04jCWza+0DinnG3cqN/pfk7A8YiCZ+TzDTU
	 QEOKnzH+2GwO91hSiBzZYza4yTYsmSPert2tJLyKGlOAVWmOwTPTRw+dWo5dUchKzf
	 TqGAzYWZp8388X1SvUbAsTrt4xWwZnexR/hpNXoqNnR+LUlFuZx/+9m8h1Ytp/a/vi
	 gpaIFmLE/4plw4nHr6Crx4haxYpRRUl68KuWVgORHmI68cCFDpOE5EdbOOKPbtDXO4
	 wGHoTN76XpfXhqjxiIGUv9a/N4Q2qnneU45KyBQaX4Hn7A5V1hxomxBvh0PIvUfPC/
	 AJ4oYfYois4Fw==
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260518170542.807843-2-u.kleine-koenig@baylibre.com>
References: <20260518170542.807843-2-u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v1] spi: Use named initializers for arrays of
 i2c_device_data
Message-Id: <177944833730.6494.595179515258195951.b4-ty@b4>
Date: Fri, 22 May 2026 12:12:17 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1151; i=broonie@kernel.org;
 h=from:subject:message-id; bh=V07QmYmfsyWHzSefum+3adPA/S+2RNjNUSCGhQS9PSM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqEJXpHbAZF6ZYDkRoIa6EtEC/NE3VNc3ZcNHAi
 UKLWUDW7AGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCahCV6QAKCRAk1otyXVSH
 0KHjB/4i9iRZWM1gX4Tw5Q1ISRsJmlCgLYZN83ydcXK8UE2I01KJcg4OqgLCO4EI6aHIJYsSCZZ
 KkUuqzx7Fk/uC45cxhuT0UVWTndskr8ZKZvqJfEhr2u+cT73YKxVdeHGfz3LBCTIm9tGyyF7mEZ
 3QsVhe1jrI0T6uwll1LYQJrNOffi8ec1WA0Czd7hk9o6RP/CYfm5yAywDtbRYg5fUkVUuu0bQFF
 W//PB2T835OvOSeyC8YBzeBBEC1hbYpYmUZpwMvx9Xa7Lg151rZJbT7iN7Yc7+3v9p6ORSrxwCs
 BusiS8nxhhROnoGNChTW8DxtNMv1ChvPHEmvGUMA2xLlxhsR
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 18 May 2026 19:05:41 +0200, Uwe Kleine-König (The Capable Hub) wrote:
> spi: Use named initializers for arrays of i2c_device_data

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: Use named initializers for arrays of i2c_device_data
      https://git.kernel.org/broonie/spi/c/84bfaa6ceed6

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

