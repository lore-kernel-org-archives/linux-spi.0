Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6053F33F59A;
	Tue, 22 Sep 2026 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080547; cv=none; b=rx9w790VO97jo07Sa91LowIo94uwo/1V9tEYzOIlmgN377xVg/NrJHJD7QthCulAfEsQF/93/uzbrPJpnChyGKmXKMVQSvxqO+xC1SSpdmTHBPnpuTrCJIEnhj9WEmNZoeLBFPFcGslHh3kFDIHbl+vy2sxgKppHY+jgfGxFP7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080547; c=relaxed/simple;
	bh=tgSMGCsCY9vZ+1j7IOsxDfddtCRgW13akKbljKVNHKc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EozDK+wdhM5fFG9DSIgQyJ1FNwhY3WN3eTpfbQ3Z7YmFL0LTzkuemTxOjhTwdCHkIMxPNh3kYf975A0qDWg7rmB0iDZqb6hIDmGgcasGt+87GJVy07ro1fMhiGdv2AE299tG/XBwGJp9iEaTT1Qx7G33EkbqW+f6w50JPoSeHJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F35WPHvt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F35WPHvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DD31F000FF;
	Tue, 22 Sep 2026 12:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790080546;
	bh=yylM6/4j7S18oCQlJ4+UyXRNITmvmrcI4H6TGpElRFI=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=F35WPHvtovbkVCq5p8/QaYXU1BKlvILhAUBJcw3chmoE99zfcuqPy5fjj+x+Di9ny
	 dm5Gm7Lv9yPM7cO4OoEdjC80wlP1J0DANTfzeiyZJ+ILtMv11vDMgViS1NU/0ep+pg
	 IoqB/6m7iVJyD2lgRx4tfq9AOsIkaQWOjvHbabGzwkZN6aP8NQ8kXhApJc7Wd/qHA3
	 9/+S0MQkcvjGL1nMXCRe6ITQG0gPgdiB4CpiGFknPUAwSIkiAvcADSM9XNWssA3b9W
	 rKR9CSpcvseMw0xiOYCmo1/M+I5TD8WVLES/8C5AqlkR1OBdB6LtAEuf2E/hIN0H+V
	 ntdWzB/pLkEOA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonas Jelonek <jonas@jonasjelonek.de>
In-Reply-To: <20260921213145.671282-1-jonas@jonasjelonek.de>
References: <20260921213145.671282-1-jonas@jonasjelonek.de>
Subject: Re: [PATCH v2] spi: realtek-rtl: add support for second CS
Message-Id: <179007403654.322763.9451673825610613813.b4-ty@b4>
Date: Tue, 22 Sep 2026 12:47:16 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1101; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tgSMGCsCY9vZ+1j7IOsxDfddtCRgW13akKbljKVNHKc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqsnYZW4WYdJ4g5733mF0tydlTve5QTYTnS7JRV
 ebQSna73z6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarJ2GQAKCRAk1otyXVSH
 0Fg3B/4s3ROu0exOPAO3gtDoQ0z/nasgO+hemyV/FgnEkk6ykRMc4/ncei3SEQMuN3xbykadOgX
 6EUnLlJ9I8e8Txpg40v7ouuQ6VYD9Q6SM5VIaYsetZMO2ddrOiA/+9cFwk4UgKCBL8cvfSy6GA/
 qASLtML6demBYmeBhOu/JfkkcnFRgdbVBl3IvrgPkQRE5PpzTulkLTTAZYzsMQaeh8Ou8eHPPHp
 diPbNXryczA6P3BE1l/Xqa0GUSM4ptpBeZqPL6igQ+P8+iU98NCwGo4rwK6YybaM+R7Uzmddhq4
 6UltzuZAu7F81w6mtQtBzopz7+nAs6PJu9kX5LGTzMAlkwDD
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 21 Sep 2026 21:31:45 +0000, Jonas Jelonek wrote:
> spi: realtek-rtl: add support for second CS

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: realtek-rtl: add support for second CS
      https://git.kernel.org/broonie/spi/c/1f82e6956faa

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

