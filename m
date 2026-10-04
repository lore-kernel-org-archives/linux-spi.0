Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4897A4825D5;
	Mon,  5 Oct 2026 13:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206084; cv=none; b=cpQ4i/k8PS3Z02tbc73os2MCgaKfTNE1Q8+YNDn7OpKkIbb0FA9biDlmjuR693NPggAyGP2tQZBo6ZvvhUOOJQmbTtEzKYHdVl2p35Oo6cCtWqniTZ7iWOwUHGkiWLICcj7xzzhnt/DQcXx10uH/UMMgP4IuNiDs9fuAlllxZvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206084; c=relaxed/simple;
	bh=KVGeYyZ+6WVVLz3FLkcRdwWY/D8tnkeZOopq1PLkY8M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WzQmFtuLG1g4wID8nROZ/k+6oXhOouS2oOPfjootd8zmD54jcrNq5CKDp9/uMwRAagb+qABgxtFMKTSZWXuagO79hx2160qQt+hu9d4EtJIXdNzeCCeHkX8Zl+KEF2PAmS4BWuRsF/V0fSl8QJz+3iDEmeFeDCcrx5dKGD+i4ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZEOtb4n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZEOtb4n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DF71F000FF;
	Mon,  5 Oct 2026 13:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791206082;
	bh=rinosCynbc2xpe3rDyj7sc4OtS5EUsnctpcqA6exJpo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=JZEOtb4nZaXBOW/R96TfohV/XC08ptl4jMwaJKP0DJ4Sax9/HHj6kpL8nLvOCMxJW
	 cS5ZW4x3BpU0WpJ837UZmPRP58PrCjMBEs5VU9m1LLLby9W/2szifjJVHrIjtzDmUS
	 7wELp05B88pySbsjbxNSaIs5PZ7AqMZJhQJ7D5DZGl6YO8nk7jJLDvf/DkRL/42myA
	 rwl+XJV74yYuPJfclqishkZ5H22Dqy1zo3rAe5QmaRWM0tvjuFQa2K0lMmGFx95PPb
	 7hkzrSl9L2ocSaEv55GfEd5XBJZ//Gm26T0I5YaxuyiOczE83GVq8XjFI522C1LMmR
	 PHiPRJ/WKoaog==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, 
 Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com
In-Reply-To: <20260924-ti-davinci-spi-v5-1-ed811dc6cd89@gmail.com>
References: <20260924-ti-davinci-spi-v5-1-ed811dc6cd89@gmail.com>
Subject: Re: [PATCH v5] spi: dt-bindings: ti,davinci-spi: Convert to DT
 schema
Message-Id: <179113445460.150114.379419426296382402.b4-ty@b4>
Date: Sun, 04 Oct 2026 19:20:54 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=broonie@kernel.org;
 h=from:subject:message-id; bh=KVGeYyZ+6WVVLz3FLkcRdwWY/D8tnkeZOopq1PLkY8M=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqw6K8qMhKJZ78dWWvOIYCkRZyq8g5Ma6N73h/Q
 js71uWZHHuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCasOivAAKCRAk1otyXVSH
 0EmZB/9QWH3BLvEK/ETB7ZJNoIzT142mol77BtQOPzpHXGrhAEFxBKIQrAPgMhvhepeE2o/Q4VB
 HYJNF/qkDIBnJlCEd6hqHUClo2uLi+qUe/Y6U5tl9hJ89L4LL57uWTa3YgpP3EGMStkmXIcaRN9
 PgRDe7HVxOpqshzVX1eu0o+LUm6g/VLKL5cpX9/WpPtIRibIYdVFmBQnrKLCqnpISjIGTBIyweR
 AVeTK5gjOe4lj5VA04JYvtFnaFRoUQh+QsHgx8biXX91Nb/+/xC3e+u0JDuaYKx+kIZXP4yxqEF
 /4GdJIVfMpzf3r/2ZftpBkQ0BCCjzl92AQUTQeLkxgf5FXUU
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 24 Sep 2026 04:12:40 +0530, Bhargav Joshi wrote:
> spi: dt-bindings: ti,davinci-spi: Convert to DT schema

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: dt-bindings: ti,davinci-spi: Convert to DT schema
      https://git.kernel.org/broonie/spi/c/38ee6caa8d10

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

