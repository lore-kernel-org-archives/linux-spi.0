Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453552;
	b=czFJGTY9QNPzZ+Ifzyr4MyNFzZ9jV1pOUg/j82JT1zZ18j6NsUnD3uodYyUp1lPDykbS
	 Y2Bm7CXKMMoxDhcXDyHkkB63nra9FIqOS3pRMplFkI8/npJyJTDT1Mr1+GHgiiTH1aMBZ
	 A7x435KZrRlVv25z/+KA+u70gvVUyiMT0WpXVfRyPbkaO4UPeWF0fanf138CWOIQLWENH
	 khh4LSq0jv4b2h9UqenLVcwTzcwtxRbu4fYNNB5NjkU/gR4Aa8+do0oZ0RV9RydaWb7nq
	 KHo1GDwUuaHVn5uvYQv7jDPEZ3HSQhFh8Hdh/Kd/jFqnc6L2J4KTVvPdoHXZcD4c9ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453552;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=UdOz9tM78aKCNuwtvaRDMGailtWmOr3a12bo3DCQKKM=;
	b=titz/ARUq9+2YeHutPVQ055ORFZfDrwXJkNzWIFoRmbS7BZ8OT5vg12FwVkib9TvPVLT
	 bKDqziBjeUQueg72HmVkk0oN+oShA/RJJ0vkLBuTVVnd8fiA4cTEs9HVSRTqCaWApjr7o
	 pHDSeQWyXj22ynbqFMXoSD9RXj4CgKCeA7KavtZrZGZ4sL2amrPLsPczYRVer5njJ9iQu
	 fgoDzxwRJpL8zo+arbAkf4Nl6jD8IYwf471KzEgrWaP3hxclD6gMSgOZb6i/ydYViMsUO
	 kUTD8TGRA3UaxUFpfWRzUzznA0v4CUjRmob+uFXs5Sw11kyMMYNyrQ7OVPC+zUW+Z6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lw/4s7PA";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D45606A31E;
	Mon, 23 Nov 2026 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lw/4s7PA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40AB1F000C4;
	Mon, 23 Nov 2026 17:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795453551;
	bh=UdOz9tM78aKCNuwtvaRDMGailtWmOr3a12bo3DCQKKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lw/4s7PA9Qla9M6pyfDknLccka+tq6vuVRz/vbaY/sABfmgf3JY7C86z7VRe3+khP
	 4XmqAScsw3+Ph3jikfOvUSiWg/MhO4vN2nGE1whUyTpSby5BUPtBigqzPGDi9pfPtM
	 1d5b966w+CW0ATxP3b4D12pJbua7UYD4k4DY/2nJ6fvoNdqo3PUTKPpKqzOQDCSAPM
	 DRmcCJ/6n6OhM85v6JAlqEVJrNRl88UDcOHdmfiYbFLqKzYSk711DpfABfpppbg8K6
	 5ulk8ekabYv0IBnTLLE/MrY6Nm1l/iWiCGmiZTt1Mw/rl3J+1siDwG+sK0wnhbmnan
	 GiITtjhTImdAQ==
Date: Mon, 23 Nov 2026 17:05:46 +0000
From: Conor Dooley <conor@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>, Mark Brown <broonie@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	Bingxiong Li <libingxiong@loongson.cn>
Subject: Re: [PATCH 2/5] spi: dt-bindings: loongson,ls2k-spi: Document
 loongson,ls2k0300-spi-io compatible
Message-ID: <20261123-bulldozer-corporal-630630eb69b9@spud>
References: <cover.1795425389.git.zhoubinbin@loongson.cn>
 <f4b1bbc084281212070f4aacd19fafbaaff11b42.1795425389.git.zhoubinbin@loongson.cn>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BiGc8CbVpXuZRysG"
Content-Disposition: inline
In-Reply-To: <f4b1bbc084281212070f4aacd19fafbaaff11b42.1795425389.git.zhoubinbin@loongson.cn>

--BiGc8CbVpXuZRysG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

Sashiko comments on the other binding patch however are worth looking at.

--BiGc8CbVpXuZRysG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCawRyagAKCRB4tDGHoIJi
0q6dAP4o3xF06bi8JXip8F7kt3m3k+/i7n/Kchl4KRL6Ls++uwD/XF17S/Wrg/bK
PR7gr3s+yLbRjj1aq9h6y/0FtY3V4Qg=
=jpFS
-----END PGP SIGNATURE-----

--BiGc8CbVpXuZRysG--
