Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2B64EA38C;
	Tue, 13 Oct 2026 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791915076; cv=none; b=frmNsOTvBk0TBol3Z5ft/qN/3hpow8++YjuKxO/k296Ln16jVl/ssOa+IrDDlfPj3BFCIzWP+HuPizJr8SKsTxJ9I3aiHN76EN+QbkYYmQjt6/1nNcFFCQbbB+aSK/69gytD0LbiWdlMV4dfOBhhqZGelAdlG7ta44JdI3KrjEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791915076; c=relaxed/simple;
	bh=xUeRDGRReejpEc6wjvmHvxGvsww5/e7RU/2/PhK257I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k1X8U/NNH9bcVuGEO3dABw00MqGomGkOtW73UMbpnTnvvcG17DrImQ2go9DWpcFdRd3GYwYo3gZTi6jaQ9D7TZoLR6IzgddZ5fHQe2WotYaXnCSv8ao5qe6M6shchKUWAzuxcfCuRwGgV+D7K1ztnGkyrCHVNDFsEPHW45UjYto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P308r+Gc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P308r+Gc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CAC1F000FF;
	Tue, 13 Oct 2026 18:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791915075;
	bh=V//pp1TrrLbWS21zUIc73cPPrcsSLo+5tVDgFNkrt9s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=P308r+GcJvBVfX1Wi50HCc3v1tIe6128Iq5PP26/HL6P4uGnud2PzVfH7e5W+XP+D
	 gbD9MhgIMjbMv3bqfk1ABUwbZsN3zbTz2NaqWCfFs9+4EhdNAvB5l9oR5yveMAd+WX
	 0pyiY/h+B5TAOtPJfsoYqj6KoiJTfbuQZigzMKwiy453aMrZCEzHrm6EIC/mZTrKGC
	 jcOwfcun9OYAearGKgXP9PcCSRcQ8IsOb2PUzZwV64ljxU9sPZ5k1Dp9amnIPabitL
	 fECyCaK80jlHQT+qohWXB+04HBfW4OqvXxoGl9sshaHgpkG4jNqLC9X08vvR3L6lQa
	 IWNByNSvMYYoA==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 Jonathan Santos <Jonathan.Santos@analog.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, michael.hennerich@analog.com, 
 jonath4nns@gmail.com, andriy.shevchenko@intel.comls
In-Reply-To: <cover.1791361360.git.Jonathan.Santos@analog.com>
References: <cover.1791361360.git.Jonathan.Santos@analog.com>
Subject: Re: [PATCH v3 0/2] spi: axi-spi-engine: fix stale SYNC IRQ pending
Message-Id: <179191506652.42298.2745024231338016590.b4-ty@b4>
Date: Tue, 13 Oct 2026 19:11:06 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1665; i=broonie@kernel.org;
 h=from:subject:message-id; bh=xUeRDGRReejpEc6wjvmHvxGvsww5/e7RU/2/PhK257I=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLOldi/tVq096NozzL7pdv8DS/wbtowSVInfb1XOPNSw
 ycTdZredZSyMIhxMciKKbLEZXG/rC95vYbv4MI2mDmsTCBDGLg4BWAifyIYGWYeDXDbo5oxrdB/
 /2TZ2twEz7X7j1vHTVXMWhiRs6pyvzYjw5z47y4qh7m2hJ5q2DXhuVrG8uvrm6vnMHFrz3696qf
 icw4A
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 07 Oct 2026 05:52:05 -0300, Jonathan Santos wrote:
> spi: axi-spi-engine: fix stale SYNC IRQ pending
> 
> Both spi_engine_setup() and spi_engine_trigger_enable() send a SYNC(1)
> command and poll SYNC_ID, but never clear INT_PENDING[SYNC] afterward.
> This leaves a stale pending bit that fires spuriously when INT_SYNC is
> enabled later by some driver, causing premature transfer completion at
> low SPI clock frequencies (more likely). Fix both functions by clearing
> the pending bit after polling.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/2] spi: axi-spi-engine: fix stale SYNC IRQ pending
      https://git.kernel.org/broonie/misc/c/ea29c686f96a
[2/2] spi: axi-spi-engine: fix stale SYNC IRQ pending in trigger_enable
      https://git.kernel.org/broonie/misc/c/18febc10a353

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

