Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795523330;
	b=h7QXtV/KU8Z76PUO0+UUXaBVmQd8LWJZaSiiJ5sbVhQCQ1QiEAUh58NlNdIo9TdY01MA
	 EllOl4IpJMalA3jMeV7J+NlsdU/kicqBUYVlncm4AOUeZo3AMc8oeQgeizUwFC4FQmnD2
	 GLYHQUuSJepwoKfy/WLOzejO0pebpb/ngfNlJgRdD8CTx42FPy/gHghKlHuESLhJy8UXd
	 ZZq6J4vGGjKzFt1AwEYOIAmJWVVNDI2Vv8OPBPmE4xKQo+twsrnXAokefJRsoZCBp63LC
	 ibQdEiFmUnBJgzzUaZI+KRNoUvxBpYA8k10YhelqXNoRXNAz4Ukr4R+mtMCbWSYlm8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795523330;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=DSgNhq0oz3vKOlv3QSP9kBbNMwqQYiYNo6WzcgueN9I=;
	b=bJW5z7dStOQuw07Us6UZ3bDWVvf/ihU37Yw9R8iz2jH0muA9bbizbdicuNzuAQkbTj25
	 BLuDt6/3bQX17acBuXAstyCWb4rMC28CYT9tGGUwUY5oe9+8YGiAO/PuCGKSIGGPxnzuA
	 H25W4KTM4OICG8I7Dw3oRORkI3zTnBQ1+GI/l48GcI69sTjs94esCGSfh68+/BiuwsZwQ
	 d01OsdyQEmr/kL9OEMP2Sqwo+ngqVeE7A008ize8pO8pnr9dH6cScL3487WEvENKuRcuV
	 7l4QXeFMoy8sEx0WNO0GxkR8YePPbqa1c7mYnpBFU7trjopJN+KzTOkuCa5ltMMoc3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TSXAF1EV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA9B606A31E;
	Tue, 24 Nov 2026 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TSXAF1EV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEE91F01569;
	Tue, 24 Nov 2026 12:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795523330;
	bh=DSgNhq0oz3vKOlv3QSP9kBbNMwqQYiYNo6WzcgueN9I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=TSXAF1EVqBLJpkr+3t4yP/G5/tCZJAVfieSHrZB5cMLaXBfkzVmY5Dor6w+cqOpzQ
	 HHYLBMtPqtbUWyvj7GmjqJNPLuHLG9NsYY6kNjege0aTboT590Xi3B5xlWZx51ab9T
	 yKRdu5Q8jR6ItIbv5CWOz0Jp4GZDOQfYVFALKT+u9syfiyzMl0Jjo9NKYIpy9rJM3a
	 8vMaD81A03Ty+t9Jte5/to4cnsMEgJinyT++ZfLqI/ySc3s5sx6MBbByO6WaZTD8u/
	 CnUPZhh7yuSRnq04S0urN2Yp+ofdWI1dh05WlUbXAHvDI+ext1SamzH6dl1N1pTJ8T
	 ar1mrDuuAET9A==
From: Mark Brown <broonie@kernel.org>
To: Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261115-qpic-snand-v1-1-74df634096ee@gmail.com>
References: <20261115-qpic-snand-v1-1-74df634096ee@gmail.com>
Subject: Re: [PATCH] spi: spi-qpic-snand: fix DMA unmapping on probe
 failure
Message-Id: <179546037989.25092.9320656307785641022.b4-ty@b4>
Date: Mon, 23 Nov 2026 18:59:39 +0000
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120; i=broonie@kernel.org;
 h=from:subject:message-id; bh=MTk8yy4r7VBjs0MKYGjbyFcaHK75rxJBhf0mBv8BQws=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJZm/4fe7N48ZUEPxezYn7/lQZe71iZBX7LtInybReYV
 fbpQFdMRykLgxgXg6yYIktcFvfL+pLXa/gOLmyDmcPKBDKEgYtTACZytY/hr4Se7svlNrsd+Prn
 yFhlvVz5eNPVQLGcwnO21nc60k6IdjD8ZvuauMjEZ+7+Dc46b9Yu5j+ya/fknZMrz24X2KvL+iz
 XjBkA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 15 Nov 2026 01:48:42 +0800, Felix Gu wrote:
> spi: spi-qpic-snand: fix DMA unmapping on probe failure

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/1] spi: spi-qpic-snand: fix DMA unmapping on probe failure
      https://git.kernel.org/broonie/spi/c/4021b62d6f88

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

