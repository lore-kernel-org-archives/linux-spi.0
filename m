Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0613F280330;
	Mon, 16 Mar 2026 01:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625148; cv=none; b=MAyQKqNhFpxZEY9oBULR47rBdEOvWwMkg5tiwjCjzwLGqMlCk/8J/OlMweofaALtoUVaSJTDK0ArwxNzkf9GWZQP26nZMxQAWiB/qQ8DPgsWqJBiwXKLzauZqEERqqgCKlKXZi09GADX5JwXULjUn16wJsstB1YnKMz/5JORSBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625148; c=relaxed/simple;
	bh=GHssaiP8DuSVxQC9VLdP43oeCAJxsmaWw9v5wo4kr3k=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lsjCwA7CRgoueb4x5n8cUm4iTMa4hOi4pZNDbSKBILO6K1Db2jxC61+RkCHJHx54kwLislvVaGYufmsLwhJquD6jEWvK+/6P1kzOPATxpO/klA+S4ZIhnrPziZYmh18FiM20elLE9HTgIfKjaH32m9SI62oBpaoiP94+tr9UMoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRfEGIWu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRfEGIWu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C309BC19425;
	Mon, 16 Mar 2026 01:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773625147;
	bh=GHssaiP8DuSVxQC9VLdP43oeCAJxsmaWw9v5wo4kr3k=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=pRfEGIWutWeXHo/zRyeXXRPhizo2H/rv0EzosucyQDHHo73g7iIEltGIbDfyvCJfa
	 St1qSG/N3FaTmHYG115Wxjo8pKZmJixCLj+lEKsz7IAvHreCGRJ0QyrGOA7k9gAlRh
	 JPCgE6KV4eWGFlyLsZ2Uq8cfjZUa9mtcy72Cnsi8kBP8QymxY5Qv/y14qiYcUjxdLs
	 f3o7nmqMgqqJzRKvGzvzfiXLObsNetkU79/bHU3Ft/e296byAwkPVcGgAU3QU/Zr3g
	 yMG232rrirbyFR9U2zMYleve4U2gDifqjYsw7djHmfH1mCmEvCMAQekpCSw/abehAC
	 C9kaC8+0i0R7Q==
From: Mark Brown <broonie@kernel.org>
To: cl634@andestech.com, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <cover.1773193726.git.xiaopei01@kylinos.cn>
References: <cover.1773193726.git.xiaopei01@kylinos.cn>
Subject: Re: (subset) [PATCH v2 0/2] two cleanups in atcspi200
Message-Id: <177352550782.149922.3716322656911111817.b4-ty@kernel.org>
Date: Sat, 14 Mar 2026 21:58:27 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1198; i=broonie@kernel.org;
 h=from:subject:message-id; bh=GHssaiP8DuSVxQC9VLdP43oeCAJxsmaWw9v5wo4kr3k=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpt185nSGuKpNeXveALdh1gRowKKXBJdhajKxAw
 +UEEnISRmqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCabdfOQAKCRAk1otyXVSH
 0BZwB/9/LYBQDCW9CEV3F5zgRk/E5x/QhTJ0/L2EicczQkfkPkpO4KJ9tzms6TUa9NNY0ZsP1Kb
 hc9p5iLE/ML5bP/xGFFpfsZHkugB0O+fqIgxpbIJ22pXQKbzJOdI9WULuO5UVwUxHw3ZbF/2O4O
 4+Oj7B1Tn3mRj9vTEhgSPC+kRRjJmU5WBVpYZ7Y0j6ld4wyifEGl4Gtd9DOlJzHhQzZrBTJb19S
 ka6SF6aE1kMYX3A0VzI9LpeuJ8loMzLk+Pa8JuPGrc172MfIdG8G3cma3uSm6e5bxEK8pw3Nd+E
 o2VWCQ/2oOHCo3NGD13Z3du+yKhLaamgDven1Av2YILjAfbZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 11 Mar 2026 09:55:12 +0800, Pei Xiao wrote:
> two cleanups in atcspi200
> 
> 1.Use helper function devm_clk_get_enabled() to simple code.
> 2.fix mutex initialization order

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/2] spi: atcspi200: Use helper function devm_clk_get_enabled()
      https://git.kernel.org/broonie/misc/c/97545e37234f

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

