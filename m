Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511868;
	b=CzpTxUoghLIG32IBPWz9nbBS0DviH7M3ypR27sBkZhv+Jltyu8janeycUFQeChy4hk1I
	 vp1NGQduy7CzLzH+GEzOfQY8ia4d/JfwGU+qbhODAULMazWIWllo5HN1T+LHkeHY7P4on
	 OfFDfxzlyhqHwIbGNVk2Vger910Rbz1VBJafC7EoVdPmjf1TVr1C/jpmukBdADpxAgc9B
	 zlbNiS2yIQzDJxTApRRXL2yGfxl8uXVR6YX9T1jWX/E/Ggk+tBburITAYoo3lgqApz8CW
	 Jk3GHiNeuvJdHWWPMwDYBZjV5K4T3Z2oOjJ2VEDuInziawGogNI9pb6Rb6XX73LzpDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511868;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=hOGCv8DFCDG4oqORRcTq2k8xm+GYXpzMleKYWoWudVM=;
	b=LvR/Rgt2fSXKJgWZaG5ZofPy+usyeoKeMgLIwTetPcQ7P6nAnCFa/f2SWgX78YqjZ/Kq
	 XU6J5GF+HSDBGEiPSTZ4+Rj0w44l3BVKGKMtGRuPWnKtBTojbnXJBZnIeZCYGlVBM5Yb/
	 5qjdeL9DosZA30K7V0PO7T52vv/KRDx2lY1njj3AKUaOycOStwlAdU2/Kud/L/uQQWVD7
	 MLMNi65cYFV0yS9d3JActXeKUqM0OxkAo95LrarEcpFK3vC13vjSa7yp1HZB+vdDcsmKv
	 bkeQxDuVaTcwyGA+VjCTytg1tVpCImFbUpIsVzUO+Ce5pXyklYb8SHdXMO6KiQPQ15Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PudDZdk4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0368606A31C;
	Thu, 12 Nov 2026 19:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PudDZdk4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF25E1F000C4;
	Thu, 12 Nov 2026 19:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794511868;
	bh=hOGCv8DFCDG4oqORRcTq2k8xm+GYXpzMleKYWoWudVM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=PudDZdk4CfTO9cAwPUXP3k5bcLpcc55Zj6ASERF65bNN9VVfLtVi3DU1t85bP3T4h
	 5KZR2ziBCAnyMZMl7MWVr/QXBwgcE6XtDmiIvcb92k+ZtmanX3A3RfcIRJSpHCOJqZ
	 s6plIbsY6VmWb5DspidZg1bzzbbC82RPqIpInht4lMLhLW1F/T/tx5+htrUDolMWtx
	 ik26fCWfufImXfXMptZ9hxKrtllmeKwgE58y1RhtlxpDyB4jIf8Ccr5CxX6CTgZDWA
	 gqhOzMViCnpB6tTXJmx07v1/mrJOM69ZlxKF4LrzB0a08zeY8oWvPw2suCK1n+tFQu
	 /w7ljLzbKLSsw==
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
Subject: Re: [PATCH v6 2/3] rust: spi: add SPI driver abstractions
From: Mark Brown <broonie@kernel.org>
To: Shuai Liu <847807867@qq.com>
Cc: linux-spi@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 broonie@kernel.org, ojeda@kernel.org, dakr@kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <tencent_C5AC68A2C63D42DA8E8547FEA38904F74D05@qq.com>
References: <20261027054209.904654-1-847807867@qq.com>
 <tencent_C5AC68A2C63D42DA8E8547FEA38904F74D05@qq.com>
Date: Thu, 12 Nov 2026 19:30:59 +0000
Message-Id: <179451185979.339049.12323339081307899766.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137; i=broonie@kernel.org;
 h=from:subject:message-id; bh=L6uOFQoDghj3iOooCMMgHHNF8Uh+zPJyo9fZA01cBlQ=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLK+Cf/UbOaMePxxI4f65EV+a1+waYmt67TRndG7+KleV
 tCL/lsWHaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZjIUkuGv0KSZQFzst/y8kxf
 s6i1x9s+6ULAijPsRu4blqxQXfHs20NGhqY8+4XOmu6usz5PPG3B9EvlQLjb0omJf+aHph0qeHp
 4AwsA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> The `write()` and `read()` methods copy the data into DMA-safe bounce
> buffers before transferring, as the SPI core requires transfer buffers
> to be DMA-safe and the caller-provided slices may be located anywhere
> (e.g. on the stack). `write_then_read()` does not need this, since the
> C core's spi_write_then_read() already copies both buffers into
> internal DMA-safe bounce buffers. `write_then_read()` additionally
> validates that the sum of the two buffer lengths fits in `u32`, as the
> C core sums the two lengths as `unsigned int` when sizing its bounce
> buffer.

I do wonder if it's more sensible to go straight to the
spi_sync()/spi_async() APIs - these APIs you're implementing are all
convenience wrappers at the C level, I don't know how idiomatic they are
in Rust but if there's a more Rust native way of doing this stuff it
might be better to go with that and then arrange to map it onto the
lower level C APIs rather than deal with the C wrappers.  Of course if
this is actually fairly sensible for Rust then leveraging the existing
wrappers makes sense.

-- 
Mark Brown <broonie@kernel.org>
