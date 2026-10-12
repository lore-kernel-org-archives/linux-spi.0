Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671F84FDA77;
	Tue, 13 Oct 2026 13:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896516; cv=none; b=tZxc7HzlX9/BZscADWGlbpOEkdbtiYLSBnymdQDo0T4/wAlkmczTzAiQJwIkdMa9buENVWR8jzwT1lV8mMRgEYuS3UEFgk2Qf9vFsoPfm2m89vm9qiz09cUz3xNPA++6pEoKd4x2vFV8tGnHKJqViJhW4qt3BPjzYFFq69RP0ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896516; c=relaxed/simple;
	bh=dKD1DuP7nA/1WCRMaM4SY6DfPzfhdDIgSp+12Z9T5Dw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Gp1tUDLBaAJ+yP+SXskK7ta6WkfcMKVZTPYgrK4e4RgMq6V3Yw2ZZpcvy9tE6U6BW/spPFntZZb1VjbxXcGQkfT/j2LssSXK/DwRR987mQ9ikyhfCz/6oTIUaWGq8Kq41OvHw08WtwC5T9CtGSCiwSk4h3XycRB/CBB8Gz+9Qyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVH55j1F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVH55j1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AAF1F00893;
	Tue, 13 Oct 2026 13:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791896515;
	bh=p3fEwqzdUyFVtP8SKxeyVGJSaBF86wuEMEEclRWWWrU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=VVH55j1FwfD0QvYKJktncUMhTL9APb84DAbqwCmgB4/+mWN8nInsUEk7KHNn5isSW
	 zQRODWqDhikzEy64HoZ3qsgGyvi3+tL4LOrze6AbXlSzS6h+3zcovKJUllc5JV8t2/
	 N4eBQ6/Q04Wnq/ZvOdmie5V6eR1hF4QM3wcpKFWyamSpboPooSohB0sTThsbGPwCOj
	 vLXONXIqamuM1jIGjsZMhR8qbPpUUrI/u/sRJy8s6E7cpY4BMbbdEJ/gGq65LS2JpP
	 UYabKxSisQ1+gCAFiMN31UrJGV+7w7Wa00y2GVA/UstjLt5UbbcT8Fw+czXXMx4HFv
	 SiqkIWH8O94wg==
From: Mark Brown <broonie@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261010151459.30560-1-jszhang@kernel.org>
References: <20261010151459.30560-1-jszhang@kernel.org>
Subject: Re: [PATCH] spi: dw: Make dw_spi_update_config()
Message-Id: <179184404859.390394.13085559188873655966.b4-ty@b4>
Date: Mon, 12 Oct 2026 23:27:28 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; i=broonie@kernel.org;
 h=from:subject:message-id; bh=dKD1DuP7nA/1WCRMaM4SY6DfPzfhdDIgSp+12Z9T5Dw=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLOaR/4rX+n+lzgq7SJxU0c5aESJcqSvXnSgbPT/CUiF
 0o/yGnpKGVhEONikBVTZInL4n5ZX/J6Dd/BhW0wc1iZQIYwcHEKwEQOiTEyfLkiOrdUY4fAQo3X
 2VNvfam5InpldYOlyakqs3lv56Ys52f4p33wfMDCtaEXZyaE7HP9Zac6aZv49n6G31v+znvXYyr
 xjA0A
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 10 Oct 2026 23:14:59 +0800, Jisheng Zhang wrote:
> spi: dw: Make dw_spi_update_config()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: dw: Make dw_spi_update_config()
      https://git.kernel.org/broonie/misc/c/306439eed9ea

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

