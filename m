Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C8442FCB0;
	Mon, 27 Jul 2026 22:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192921; cv=none; b=hnkFZLokPE7J2jpPo3to8YX4M01VmVhAF54izlSEuwKl5FyPWqS7/02zBszllHfhQ1PEITP8kdbFeYQW0XSux5uZ5cJS8mG73WCbzwa1ARswfLDkaLwTKK5yYc3y5Wv3m2i/iTGSnIy3eH8y1V9yADoQNxky8SxNwAT6eLxYyMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192921; c=relaxed/simple;
	bh=t2L1/52jcN/yikhDHwRXymAi1tNNZhVuG93OkJs41OA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DEwSczoLIJCSfBC6uimzxNLj9gn6dcY1LD7eIejy1OcMEg8R3CX7eEDJY7fh5/6vm76+scrl0Jd7E1A2lZpIa736cLN4/6Df8lhEI190rOilkg7WcPniWbPdrZ3rKH4UcIHTsAj+kKTYJD7Mz38BfVnj8cuE+B/HjKDjHC+rqNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WenzdwPA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WenzdwPA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163C31F000E9;
	Mon, 27 Jul 2026 22:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785192919;
	bh=PcCkppdQZyJG3G4/8u+i7PtFUDcOYUvqp+mZF0nbRKI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=WenzdwPAZeZlKsu7ul+ZpsJHOuwR19BnWHecYJMJxak9C8r7KoAKnfYL7z/QjqKA+
	 jxniE7E2PGcf4Dh0zNB/B2d7AlVd0EZEQc/vZC7b/1N3EstQPCTk7sCPpE1g4nfJwX
	 iyJchW4EUfT55XrNsqe8A1Ba+YpQRUOVhpT9VndtxtoqsgYHTuJ/Yoq2f7Lf+DDjyb
	 Ne35YWBbJnf2W3Z2yBsSaCyzlt5Z+Ik7xUE04SPWRr+2l4taPsdvAmWIl5Jwo79V0a
	 BjZxo1ErqECeDK5mexROe08FRLi8BnE1D3TdyVM7VAa6jyTbGn/OAaf7C58Y/lfqVz
	 rdfEYKiizvgpQ==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20260720003043.1536358-1-rosenp@gmail.com>
References: <20260720003043.1536358-1-rosenp@gmail.com>
Subject: Re: [PATCHv2] spi: ppc4xx: devm-ify probe and drop manual resource
 management
Message-Id: <178517425482.50339.5908120506912544581.b4-ty@b4>
Date: Mon, 27 Jul 2026 18:44:14 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=broonie@kernel.org;
 h=from:subject:message-id; bh=t2L1/52jcN/yikhDHwRXymAi1tNNZhVuG93OkJs41OA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqZ+HWkAkFb5k/y2i3Lrc3tGjom8AAEm8IssRIW
 YtDmNl5iYGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCamfh1gAKCRAk1otyXVSH
 0Mt2B/0Z5bbQfubZE4i0lD83xESgjz7cqzOh8yPyyJOvJUOxw5hmHn7E82CkkEh7it/EVsqgs7U
 ZdUQ8B3aJc46JWjEacXpjExxJYiVMR3gWp2u2rEstsdA7LVIVYtPX7AppRBlZp7auZSiop/udy7
 RdAd+5rFuzoGnmiuS5kxl0FbwT3WTrYwh3bZ15+uYR89A37diW+Zni3rfZ5mqw/dzKIQOxPbIqE
 F/DFjSK+oBuljvlT50odeeRfmdGYjBt/I025jSoUzHxc+11DVkgQ5dr4tg9aW9KP2s1syTYiX7f
 GNJNZQheqlCMYsFfjDeB/0X2LoyEc5BRPKBpV4cxhF1nMhDu
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 19 Jul 2026 17:30:43 -0700, Rosen Penev wrote:
> spi: ppc4xx: devm-ify probe and drop manual resource management

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: ppc4xx: devm-ify probe and drop manual resource management
      https://git.kernel.org/broonie/spi/c/fd741c46ae03

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

