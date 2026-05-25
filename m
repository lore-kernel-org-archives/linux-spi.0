Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41FE3AD510;
	Mon, 25 May 2026 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723497; cv=none; b=tDIoV43jXBhtZwtamqZQwWJpAZA+pnKONcfH78iKRtOsJPD1W/jgffd+RB4oK3Rwh1Mtdr4Qq8Viy8fQa0giOeSjdFUC/z7z5hsoBpwvxrLueIIdg712yzIGUfNT+Tr2Kt3is5tqPrb0Y28jHgDckBQiwt5hzx82Jjuecq0zgmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723497; c=relaxed/simple;
	bh=ZRxp9UAiv7JNxlcc4eFybY/fw9pIZ6klWSZ/djFLZJA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fORHhH5ahKBFhDD4fZCYBbM4anDEr6W6Ut57UggYMBuj5pRwR6k6yM2r/XZmz4qO7HRZ08GKIuhNl9ii7Z+flPeEQ5xvlLjF2qEzPnPuk1WTH0IEsxsxZHl5hFo57tdhIRD1o34ntbosxElltV8QvzVWyZeplMO795iaJAJpoic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIwQuWia; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIwQuWia"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9631F000E9;
	Mon, 25 May 2026 15:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779723496;
	bh=E6kCJdpdL4+DbbIwhxKQs6oZ53aM+acOROLZz7W8W/k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=OIwQuWiad1VSqzm0Z4hsH7X0nq547nKHYRN0VMOxTkY19M7K1iOsHjTY0BsGdI8HT
	 MECcbKLPN1xkcO2RAy3b4UoJMwTgb3zZSmezMczAbOkNNDofxnwG2i13uRhU6YmhBQ
	 TXaiDcive/5dWe5+LgY/qo8oKPSDvY2iHjCuaJGCoewzGBTjAebGAcQKnmq7BoAXav
	 nXs6fpV7yBIy2e1RMxZ6l6xdawIoO5DSKM5tFrgaEayeqh2HVqWV+XbVuwvDDVmNry
	 xYJMeeviF9fhkStLA1mgrt0LmqG7ivYkXxL8uyd7jmB9SzwaDqY+SqVaPkuIBjZGJT
	 jtohJmTg8QXsw==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20260519004352.627148-1-rosenp@gmail.com>
References: <20260519004352.627148-1-rosenp@gmail.com>
Subject: Re: [PATCH] spi: omap2-mcspi: Use of_device_get_match_data()
Message-Id: <177971244162.58460.2534987056752342515.b4-ty@b4>
Date: Mon, 25 May 2026 13:34:01 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1109; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZRxp9UAiv7JNxlcc4eFybY/fw9pIZ6klWSZ/djFLZJA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqFGzmwQILER9l1BelGVOoQVwP+gY6UBTLT+Zf5
 O71k4V60CKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCahRs5gAKCRAk1otyXVSH
 0MlMB/4z0AZkVhEBJESTiC0TNqYmdrqNda0GxZMmyyoQdBiiIc9IzuiEiUXkjW3g3RSehSFsF2u
 zpBCUnocQOmY/6be8Zh5/Ell2IO5fJe2SiGwmql3lubavAnhxV3U5Wn1uyf1nDesH6kNZiLZtiY
 J/7IpOeoAn6IUXg6cf8iTL69Xo40bTgcf5+inDANWvN9yz/2mW9jSeEWPJXAexdftTUGwKtyJTd
 Q5anfF4c58IE1bz5IewL6Vq9bubGHLTaJIUJ7BTV3nMp1quw0SGPBYmX4PQGPQKRRAuyK8BEm8V
 +cFpVgxYqs0iuVgVFdIgcfHrjSQ3p7UqsSLopLqn2JPnXL1N
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 18 May 2026 17:43:52 -0700, Rosen Penev wrote:
> spi: omap2-mcspi: Use of_device_get_match_data()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: omap2-mcspi: Use of_device_get_match_data()
      https://git.kernel.org/broonie/spi/c/82056957e5c4

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

