Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF913429CF6;
	Tue, 14 Jul 2026 21:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784064267; cv=none; b=d7D8/Cb52k9qwS1pH3pAoWfNBOX6kRkmGdcXJKRwmNjMZyscrXT3QHawjReyZEc9MraPIsRsyN6UolIiUqt6QzHfyzwpMZ899llQRDmNKb7zetY9Y5O7nIqBOWd4y5RV9PrGrt3xX9iDSS/b6OnLcrLoTVXvs95nKk4gz3jONRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784064267; c=relaxed/simple;
	bh=vNOBqqC9yFiEhyoXR9LChSsTeYbMgNrUtgO54Ckjo6M=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VYHudGmbe4v2f0nMdoFb42/5tyJTQEgZIF3E4kzXw6kOz0ZKnRsUrl7jv3KQbyukZU1DNqvM+FTcfGPo0rkqYCaLZ/+SudHdzbohh6Zr2fJyu7+385yYke1WXiifYiia338eq6pTfRVy/RmiySitvyl43gnZh/k7GJwMAeKfQsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXQVcews; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXQVcews"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B481F00A3A;
	Tue, 14 Jul 2026 21:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784064265;
	bh=Kc8QH6BxvyW9ef8PAyxaqiwonZpdVzbJV0CMm+y4Vs8=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=CXQVcews4hmtRA84seJ3Qk/SD4B4/jZVLiyBOzKwH9O0BvAstEESVXu3S6ADb1VjQ
	 XT6Q2pBpI0wkBiL3oVo7QXj969wq+MKdbD2Uwc6wpBOlzAGXwP6vkAkCTYzg0ayRis
	 4Q/Nu2MkM0ns6zADbWoCjfQXJJe1r02xiI/pgttwBsuxSjWdV0hSz0pyoD+KulvTpg
	 SY/m2kCWutzvh2OGhVgBzlA0qA6cEilK0vSMWLlviXwc28BzpISFguHC3BWRRIuXMx
	 IV0p2BHDg6DeBQgzxdqxIN6fk8Et77RQo85OgCMclfLX2d45g1Lqiv5R2gjF3hy8yL
	 bMN6273gJhwCg==
From: Mark Brown <broonie@kernel.org>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260705172737.120095-4-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260705172737.120095-4-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH 1/3] spi: atmel-quadspi: Simplify probe() with local
 'dev' variable
Message-Id: <178402987400.7661.258618486934275116.b4-ty@b4>
Date: Tue, 14 Jul 2026 12:51:14 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372; i=broonie@kernel.org;
 h=from:subject:message-id; bh=vNOBqqC9yFiEhyoXR9LChSsTeYbMgNrUtgO54Ckjo6M=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqVqkHO380qiDwrpeEr1UzHf3y/xbG7gwxxNKhH
 DsjxxILTsKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCalapBwAKCRAk1otyXVSH
 0Do/B/4lvOm0J5liKBkExSMKLVgDP3KhutGv/fNZDFbKqOfDsSdpSV6CslAPwGMRF8BODazMI16
 m/rOctg7uo4IHGw8XXiY09nclcvKuqfdnH6jkJHvJiN97eRVCjkDOY0j8klepjf7lsx+qhtg+mK
 /HrQomPJJ2SoTuWuqwNFBxAJ2HavzKt+p0hzDpzjt2NJclx4LTVBl2YYSOJqtVQYgv97ZvheFqD
 /NUoyVc31JzbDB9LImNQWS4WxL84duPd9OqFok51YRH7mIqlQ4533TKG5X9QTPvBVUNu3W1NRX1
 zz4V5z14WA2OnG4j6corLhS8qGE3+8syCl4DSQeofckgzKs0
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 05 Jul 2026 19:27:38 +0200, Krzysztof Kozlowski wrote:
> spi: atmel-quadspi: Simplify probe() with local 'dev' variable

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/3] spi: atmel-quadspi: Simplify probe() with local 'dev' variable
      https://git.kernel.org/broonie/sound/c/51f761e4071f
[2/3] spi: atmel-quadspi: Simplify with dev_err_probe()
      https://git.kernel.org/broonie/sound/c/3ae07d8f3075
[3/3] spi: altera: Simplify with dev_err_probe()
      https://git.kernel.org/broonie/sound/c/3e106385e3e6

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

