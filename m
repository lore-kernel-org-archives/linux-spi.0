Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C823F23A6;
	Wed, 10 Jun 2026 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781087007; cv=none; b=UL50+wFLLSxzNxuUTW5yGIuYsLBc5eKA0iChdM3wPXGRK1RZfBSdyQ7hZp8YR0PCyM2+tTFepdAcy/ZjrPtDrcMgMPTCV41O6X3L8JE6g86EVb4/ISh2eqFdT+T/isROUxWiWm+3ugX2AjumhuwoDrj3la6lpaDZfi+hZUkQZhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781087007; c=relaxed/simple;
	bh=n5WzW3XUt/cMfOz35Inio2fh732PCbPa2hCon7zabKY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RTg0yEsQMWs649z4EBZ67qfr6T/3+5EvZqz/fGp0dYFFlaXgqt8TM3S+ILpXX3oXLP6h7+qFY7vADYQyB3Vy6kjtA5fW0T201LIDbmQMHOhL88bTYBLYbTPBroaAprJ/MqGjHji5zr2uCQTw+n2YqLGsmEpqdrGj4l9jMc5HpbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocket4/W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocket4/W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8EF1F00893;
	Wed, 10 Jun 2026 10:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781087005;
	bh=QZdlIrhAKv6s1FaOxwE7DnOAOnbIyuvawUpM/VzoamI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ocket4/WRE0O5rw6vk7LUuT1b3Qq2HklfQGF3aPDJXp2gotSdiL1dCkPoZVUVFUEH
	 LOfZQv4Y6W74PtxOftYNQkHgGq+J+9xV9B1/sjMxqcw4HKZqMen6J7ZvMKqRgIJ/Pl
	 0ne2BW+u2mr/7i9hytq9/rwgTCwmQdJqam0B8mf5/9RsX/yA+Ktj000hd8c3lr/MPH
	 qgwC8v4D0ADi6PDOoKbg0BtsdyWGwNyoCg6TN400ZJAiko8El/euXbC+6n1YG/RwbJ
	 UIjMv9UA3csLVQjew5MSonsPqYv0q0j1/h26M4MzoTqnnTFKgFfws8O2A7rEqZHHuh
	 HsQvOHenHOZJg==
From: Mark Brown <broonie@kernel.org>
To: Peng Yang <pyangyyd@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
 Jonathan Chocron <jonnyc@amazon.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, pyangyyd@amazon.com
In-Reply-To: <20260608095849.3446-1-pyangyyd@amazon.com>
References: <20260608095849.3446-1-pyangyyd@amazon.com>
Subject: Re: [PATCH v2] spi: dw: fix race between IRQ handler and error
 handler on SMP
Message-Id: <178104646333.212106.314927572121638369.b4-ty@b4>
Date: Wed, 10 Jun 2026 00:07:43 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=broonie@kernel.org;
 h=from:subject:message-id; bh=n5WzW3XUt/cMfOz35Inio2fh732PCbPa2hCon7zabKY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqKTsaxQYYUXHCYtLWxX9rbxO+Xulp5WOnRmeHh
 VI5A92WlVuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaik7GgAKCRAk1otyXVSH
 0PwZB/wMYyGlduBi7x5HRXys7kTJg+CwOZqyc9W01d+yq0mGPXWQyfthya/GWGKx3/K3GyXKp/l
 1ZjhneHRhptKiFwwUo8AmfdRvyZ5MOkOcdOp5cvvI0M7VflBD3UEyUDfylVQZ4eJatDV7rl3zot
 cY19cLwls7kiS2BMbwojSrwOZafYJleFSu+ST0T6lBhSrPhyKL7rAvaPE3cN8HkVvBzpAIOtiJ2
 cfVcJC65iMLxePyCY5thx6ckwwCngZ1Hmn2bg/U/t8tNJNP++vtByu6rXWzVVS3wjJcL+K9Sg20
 W1JwibyNkkejbpdNJHJL/PkJAWr6DhkC5Bmx06dX9xNUPEao
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 08 Jun 2026 17:58:49 +0800, Peng Yang wrote:
> spi: dw: fix race between IRQ handler and error handler on SMP

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: dw: fix race between IRQ handler and error handler on SMP
      https://git.kernel.org/broonie/spi/c/3c60184e39b5

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

