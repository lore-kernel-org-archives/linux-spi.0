Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483430;
	b=UUoguaWlv5B+E/eNS6tmkMgG6AB8bTUY18WpyUnsVakcmACkNKYdE9sFozHQ+2k17d5t
	 B0WX5D7qK/uTszDQT1fJFCSUAfsis5vXLZS3tFzxzRf5evsWzi55GisWJafvnzjkHz3S/
	 DreJexJZdkh0aaAtzSTvbCZ4/x8AcopJJ4J/JS2IL0U0pbJ/YzVqPyppEalNO4WLAzGlD
	 FBgnr3rftdF4az0W36a1SnCaj7ksDGv/HKmFmTNeYySe3uwcdrhlDXeURy6rvWTzwgFwk
	 6L4K4lUUGDKyOTugZ5cJCz3cNnZDyAOH4c6yIinsECdHW1j+RHZboiDxN6MJzxfcJfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483430;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=QHhfXSlF7EGQRQSXuS0ww8XO98LQNxgF1We+5dGehjg=;
	b=C1HMZNz35CNNAp4NRRCzHcJB8JQLmUpb+k3al1hBnFBzVAXBZnfD5zzSc9oG7/iKlJE1
	 jM4GftsO5SNYtc90+eae7+S+mowuxjDF7kwI9CuZ/azn7DHh4Yr1J1PwkQmEQvBtKS+V4
	 c1rr9VAGJGwmWZ/jc12BrGRpoy6xkY/VN+FT+FYYYh7OX+Cmkd6qKclg+1fgxvSP+njZi
	 Y/eLZjclR1gSXGoQyrlaJFhHx0mrd6XOsMi17aAwfLKFjYLcrCrWa8sqDf72kvrb7O+7z
	 nrDDdp7R40cZl+/Dfd282E5dsb/P74OzbO8w9coNISNTlMV/cLVkRWOKoLAVlTIzNZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bETNJTMG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54C6606A31C;
	Thu, 12 Nov 2026 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bETNJTMG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3D21F00A06;
	Thu, 12 Nov 2026 11:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794483430;
	bh=QHhfXSlF7EGQRQSXuS0ww8XO98LQNxgF1We+5dGehjg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=bETNJTMG1PTUEzCwKt7sysGMDLLp/rkJdLIfLcjF1eoFNNdo0JwA17QSLZjDI5FvI
	 dvYxBtVcZr+qzqvIoP/0WXV1d6297l/L9IEXzdqijLLBUZ4Cf/7voQ2L8uvfeWRAI+
	 Z5lHrdxgKhmJv/AksP0yNvuMPJJYXgQLdQQjILClr+53XzeM+hdfotFjxxh/a8l2q4
	 +/zrFAhTfDZ/OA6DNa0DLJBOxOLqA5FCz8RRkLZgWq7SyxFYIpUdJYbEdSOnxiap/E
	 XalH9ic57bRH6MbDeZ+okI6JH6uCYSsvUxO6P80dFn1Iykk/nVh7Gyp04CkgopWnMZ
	 fVMYS+yEMuVDA==
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
Subject: Re: [PATCH] ASoC: soc-core: start rtd->num_components at zero
From: Mark Brown <broonie@kernel.org>
To: Dennis Gilmore <dennis@ausil.us>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 kees@kernel.org, gustavoars@kernel.org, linux-sound@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 michael.hennerich@analog.com, nuno.sa@analog.com, dlechner@baylibre.com, 
 linux-spi@vger.kernel.org, miriam.rachel.korenblit@intel.com, 
 linux-wireless@vger.kernel.org
In-Reply-To: <20261112025252.71375-1-dennis@ausil.us>
References: <20261112025252.71375-1-dennis@ausil.us>
Date: Thu, 12 Nov 2026 11:37:04 +0000
Message-Id: <179448342405.66517.5463730214277229760.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=510; i=broonie@kernel.org;
 h=from:subject:message-id; bh=qeN8OdTaE3iAI/xHQWyAjn96Rkec7rUqsQT9NgQks+o=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLK+LnkQ9GJW09qtNmw5z80v/X10PbLw/ZI3Uov3OraHr
 s45+lliW0cpC4MYF4OsmCJLXBb3y/qS12v4Di5sg5nDygQyhIGLUwAm0hLKyLBB6eKxJIZPwfcu
 lG3N03lz82jDt3xfv3u8s3IcXcynX1rGyHAiKDQigW0dR/jVmCNrTDPfcbpkPzSRuSWQZFjVGh5
 fyAgA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> Since the conversion to devm_kzalloc_flex(), the allocator sets the
> __counted_by() counter num_components to the allocated length
> (num_cpus + num_codecs + num_platforms). This only happens when the
> compiler supports __builtin_counted_by_ref() (GCC 16 here). With
> older compilers the counter stays zero, as before.

This doesn't apply against current code, I think this is an issue that
was already fixed.  Please check and resend if it's still needed.

-- 
Mark Brown <broonie@kernel.org>
