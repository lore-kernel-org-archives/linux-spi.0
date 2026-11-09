Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242735;
	b=c7R2q+bCZEIG3875oIMcFD0WeaTkQM3KY4eqFdsRpRd16nJz/XNLRA4a3z7OVm7SAsDf
	 e1c7dr7QH+78QcAKyFCal1k5zBTwnYAM7RA5lBCBUo8WzprxxbFZskeDoOny6rob+FYGG
	 Z9qDhWQ/0LBcL4GxmD/HsB/aS04Q4TYN/QRcLrWjUitivmrt2k83F/QOJIKPY9bWIE6VV
	 UhbJHLNDQL8jW+6JK/SKqLFpXLA6+wsOjkFB1vw4NjjpV58oCwJ2gbFxno9d1al6pJG16
	 O4PpBFK0pWUfREEBdM7DiC4GqnD6IdMC+RP80eZ1lA9NseSsYnz4ndfkp0Im1/Rf9zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242735;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=q1JvrQTWjMyX6Hna0zPaIeARUedqQEOJyQ+qp5v46TA=;
	b=iAjfLiqdYIbuu46/q9Mmuch4JN6tfcAM5ScaCP+RFkpx/Ij5tFPKeEuaR2FyayKrjS/d
	 PPACQwaXhpDtm1iJsv//E3RVFPpSM5NefkpAQdNfCTIuLTRwY26dLGTWLR/040N7OQJ1x
	 d7DMF7hG+PGjDz+ihd7DHtBuPUyRDJ1+cPUxLgJfcyXb7cfWRUuuge001pfa8RKV9jr8Y
	 4cx0px2sgpyNcc8i3qBwj66tULtzQHWBTHcLZbaclX6eQ50kys4BrnQERdx4BYwDu7fTZ
	 pxqDSAS0STnCq1oZVXHXJqGQUTRJGwDcmMX5WSLbGnr6o3Ixanut9zBDVVyVWjkcfAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S061gWYB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB400606A31C;
	Mon,  9 Nov 2026 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S061gWYB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0891F0089F;
	Mon,  9 Nov 2026 16:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794242734;
	bh=q1JvrQTWjMyX6Hna0zPaIeARUedqQEOJyQ+qp5v46TA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=S061gWYBETMLZyOPz/wm/WJeVceYufEkb0T6jPQ5i6f/t16Rp7Ced8w3ddTi9jm1J
	 T5hjDlPd1tsePgv2g3oVQuRxm+dxjT+UEMREO9ct1eWzY2nVdKrwSr/OxuSK4eGC6A
	 tGaLGN6UAU4uczUvps0npWOSpZr5Fa9uaF5cFv8ydgrNa0rZRnmBcENtztoFEBWpi8
	 N9gTiJf23bvf/H1wViSM5UI3Y2GAqHV8oXNpaI5GXNug197fyZmEdk+tytv1mrHL1A
	 P7HnBdGyzkPQmbtX0s1ucFEcPgg0r4Qjpek7W5A+lqeRJvqIKwjok+7bf/4xSCWmzF
	 Den3FL7toFhbg==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id B47D32EC942A;
	Mon, 09 Nov 2026 16:44:43 +0000 (GMT)
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
Subject: Re: [PATCH] dt-bindings: spi: pl022: Allow a power domain
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org
In-Reply-To: <20261107-ux500-pl022-power-domain-v1-1-d51913109afa@kernel.org>
References: <20261107-ux500-pl022-power-domain-v1-1-d51913109afa@kernel.org>
Date: Mon, 09 Nov 2026 16:44:43 +0000
Message-Id: <179424268308.3711751.15318704365491632351.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=541; i=broonie@kernel.org;
 h=from:subject:message-id; bh=IzpUl5oKoNHoRO9cY++wf9F9ReiT0l1/nNQM676srkQ=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI+/qiennpiVv4UP+dTTSpbt7Fed3S0mrxb2oZhT8HWI
 O3ILumKjlIWBjEuBlkxRZa4LO6X9SWv1/AdXNgGM4eVCWQIAxenAEwk8SrDP5vrEoeNnHwyz75b
 q5h6YcqsSSxi9ncyhBSZAneaFYveOcDwz/oSL3uTWXd+jXtPnkfk8mLv27XZO19+2nH32VK7qko
 rPgA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> Ux500 PL022 instances sit in switchable EPODs. (Electric
> Power Domains.) Allow the single power domain used by these
> controllers. Found with CHECK_DTBS=1.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

-- 
Mark Brown <broonie@kernel.org>
