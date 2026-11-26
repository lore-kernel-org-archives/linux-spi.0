Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795728505;
	b=Hwa9eB6z6BxZw5AZleIRyuukzg9eHEAt752AiKZ2AiqZcDe1Mis95PlpSCbaAt4qgL3r
	 tcgqhsprSo+6Wi/V6pfEkyUdB3IKD+23xQX6eHk7vg1Y8zTySl6maikSr5FMXSBakG5g4
	 g4LBRJabzJyGcQ2iXM4QuJQlARDMwBmIuGXQQ0QIANUwDpBmx8gXBERNlvtmEssZHsLm3
	 fK2sSJ20ybA2DdpH+03xcdAONh1CKw4OcPevHmnvkjvr+L+WJDWPGcIW1M5TKvicD15TN
	 6WpN9PyL4CekwbIX8Hy6hy7kmKBIbfCPjGYhKYiH0aWiUrxu8uU6qNVRSf8fKj9C/mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795728505;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=AKE9hZpQGszWx/7HA8tIwIZOKLxBkMhWpBT53qbuBGk=;
	b=2cpwsq9ePmuQ6CrcofEVLiaZNVck6UpTW8LzF6PxUTZo5Qxe9+lNlscgMpgVsZUQx7tC
	 mY7EVOQ5/8spTxQOUwQ/PQLI83CkTOOoKt8uv/wzi0vTtLofgfbFz+9H3B9bBUDkK0P1v
	 KQO8dKhosbA3vjevqLPfz1qEzcPVjXltzSZ1oB8wxPHBLcX+7PJtwjgvMqkHKcOlGiq2l
	 yaEsUwoCme72TLf7argtK+ooSIRshRTMD8l7/xVyD3okL2kP9VCXr/x2eWZEdDjKk63Ts
	 Ajz1Hbx9GQ7HA9Jae4GDN4BKBwdSuenvlMjSg5b1/a3hBtciYwKSCtvHebSpZXWNL5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+oYj628;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF6A606A323;
	Thu, 26 Nov 2026 21:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+oYj628
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF331F000C1;
	Thu, 26 Nov 2026 21:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795728504;
	bh=AKE9hZpQGszWx/7HA8tIwIZOKLxBkMhWpBT53qbuBGk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=m+oYj6287zb9RCTfENOWwvGl/347fysghidRTIGsZIAgQmoNOAUZI1xSYgX7dJiQ/
	 NRJK+RAtzUQDtCpRovni3fW5ILQGGCgP0SGIG885i+Acm/L/M+DV1mF53fqEJ6jZ03
	 tF/R6JnEsWVP8szh5sBl3ygKbsZKDyT6STwJcNfY86gqYS0KJUKDWwAUAhaYFmO61I
	 UHR6VaPZOa6ah08pJlSTdShRR3ouj7KvAtT7qvXMOkYaJPyB+dg1PYszQeu/tTHGhZ
	 h6WBnHbokPHlhxTZjDWI+4nlxkW6e9Jic/7ytegVXwSn6Ry8NlwhPnxQhWkpqOj8F7
	 uPT4Ps0lZtg7g==
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
Subject: Re: [PATCH 2/2] dt-bindings: spi: rockchip-sfc: add RK3506 support
From: Mark Brown <broonie@kernel.org>
To: ZhuXiangyu <1194781887@qq.com>
Cc: Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Chris Morgan <macromorgan@hotmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <tencent_E24973E955D1A26CF5A4F983929F8F8B0006@qq.com>
References: <tencent_B239E24A7651B43AC21C4769D1E75FA0A505@qq.com>
 <tencent_E24973E955D1A26CF5A4F983929F8F8B0006@qq.com>
Date: Thu, 26 Nov 2026 21:28:16 +0000
Message-Id: <179572849658.838304.8494302770279500225.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=558; i=broonie@kernel.org;
 h=from:subject:message-id; bh=NYkHdhnKP6nblxfLbI6IxY44AGsOc8rvLXvhgNlcXKI=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI5lhTuFngeoThR2myD5bwJRrGbd9UE3D8kFiw5/Qu7X
 5LrstaojlIWBjEuBlkxRZa4LO6X9SWv1/AdXNgGM4eVCWQIAxenAExESJrhJ6PKjGP1XEGOKRvd
 rHMWPBLKktfxD73+oPljAXNAL//fH4wMD+wTmRSauf/EVDjrfdFW3h5zKmPvfy/h/L6J7Fnc71T
 5AQ==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> Document the RK3506 FSPI compatible with the generic SFC fallback, and
> the rockchip,grf and rockchip,max-dll properties used for the
> power-good handshake and DLL training.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

-- 
Mark Brown <broonie@kernel.org>
