Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F384D223707;
	Wed,  3 Jun 2026 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780513215; cv=none; b=meH9DsXjunLtQ8/J8I2WPF794Zk3CVMigisQchvDh1Lqtz8TkGpDrztwpJRLceA9caoREvqLWpeBXcj5eOtmYDEHalTjpzDKEr1wllnjAldx1uCDXGBJQ+mZ4hXJTeug7d0Fjru3LUMqH2EbBtEo+/0l2AQEqEyBh/yJmdrDO2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780513215; c=relaxed/simple;
	bh=wl+l/vW0r++x0B5qYAlcvZ6XQyXHmIqGbv3IccDYwO8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=DTFGO31DPCNwrNbnuOMjAhZ6eMxCZZ1y91OvUYjEeTLtkLvquL80IeYsjxEvtDuM1H/WZNgB+J918ToyXzXTyi5MjXsYGeBEHmQrMJEDpr5yvJBL6r1Ts85rFFhEmnhyuWAo35k7jRIPKNimDaUJ3OEFeOwuUhW3rHbRJuIgve0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id EF76B5E1;
	Wed,  3 Jun 2026 21:00:05 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jun 2026 21:00:05 +0200
Message-Id: <DIZN96NYLDUJ.DS1LFFAS2JH9@kernel.org>
To: "Rob Herring" <robh@kernel.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 02/13] spi: dt-bindings: cdns,qspi-nor: add PHY
 tuning pattern partition property
Cc: "Santhosh Kumar K" <s-k6@ti.com>, <broonie@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <richard@nod.at>,
 <vigneshr@ti.com>, <pratyush@kernel.org>, <takahiro.kuwano@infineon.com>,
 <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <praneeth@ti.com>, <u-kumar1@ti.com>, <a-dutta@ti.com>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.20.0
References: <20260527175527.2247679-1-s-k6@ti.com>
 <20260527175527.2247679-3-s-k6@ti.com>
 <20260602164945.GA475455-robh@kernel.org> <87zf1by5oc.fsf@bootlin.com>
 <CAL_JsqJwxgcFOB=kE7bVQYDn740-w4RppMF5W-3Ne9=9qV9OrQ@mail.gmail.com>
In-Reply-To: <CAL_JsqJwxgcFOB=kE7bVQYDn740-w4RppMF5W-3Ne9=9qV9OrQ@mail.gmail.com>

On Wed Jun 3, 2026 at 7:38 PM CEST, Rob Herring wrote:
> However, you already have to support using label, so anything else
> is supporting a 2nd way whether it is compatible or a phandle
> property. Is it really worth it here?

Do we? I don't think we have. That was among my very first feedback
on this series. Don't use hardcoded partition names for this, but a
phandle. A compatible sounds even better though.

Also, I don't undestand why this property has a cdns prefix. This
can also be relevant for any other SPI controller.

-michael
