Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB194071E5
	for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 19:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792006162; cv=none; b=N7QLrDojUK1sLCYi9Xbke/aBRowbphiDaVcrdB40OgV0vxGyQGShvoCg1GHNthcJ67/fwbEueDD5f1Ty6zbLcOX3cFPw/9cpYHmVnXHwNamLyfV69rFUrOcLePZPL51K7xddGjTCLN8JKRD1iDrgH/mlHKaIE2gc5tWcTbJLZj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792006162; c=relaxed/simple;
	bh=IgHGxOxht8wBH37DC0EBY6hUp6ZbsnA9xBE5J8dasCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMmGMheCeeXZth22ItsZCI7jRqVBWB5EnDrtfNzD66WlNNIxnYP6ZUNqPZbUsT8XDd7nUYoj2cvKTZfDj/3ybwpxt64iUkOTP1/1ayXCnoE0yP8Ht0aIvlm+GoBB1bOdZa32BXe3I5qauUXgIe2dfypS+zow20Cq2qKZlxLNxMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lo5vJkfO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lo5vJkfO"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49ff680331aso15365445e9.3
        for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 12:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792006159; x=1792610959; darn=vger.kernel.org;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cGRgdcL3hYpLvnGFyKUFvjXygNKkl24WYKGarG/Ntdo=;
        b=Lo5vJkfOP29LD/R/QfkTkv6takfwZNlgmhEP8Tu9gnYnmdv11WSWUkQ80hPBlbIgnp
         9oBG2k6urJf0c2GoRxwEKGv4f265G0WIQnLIJNvWi6zz14owafOynsG+2PNXa/IQlCpp
         QcqNAGK/KsAMHjTt9XTxhZXBSalpW0+tlNnbwW5lUi+NQq8s4tH3kaPDIbkHTk6q/iej
         ciixRzbXHZ7+OaWSW+k1NmJQKHDx1meeyahyd+9tRxrNbmL/sLq11Z5MTMSlhdOqLpg7
         vAFn2d9IBqpQeUT636FIoKTe8Q0/8CgyNG2mhL24VmQ5VzHFE/S1suVKwHXQOq+WYCab
         H+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792006159; x=1792610959;
        h=content-type:mime-version:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cGRgdcL3hYpLvnGFyKUFvjXygNKkl24WYKGarG/Ntdo=;
        b=tiMrUIV1zYnAWWKwJkyJhUWjnmNx7a1+HX2atfv2sUIVGPxnkuaGcfVrCLQnO6AZvD
         4zDLmwVRRtGocvvc2IVMfkx+c76LmbO298ppk1G6P9YxbnAWxN00ITz437J1vmylDf9c
         jLbAMZyDjRpcCNgsRQc6mfV3CbKZhS6GsDeF4jS9HnteOWitBd96bP3HjPSk62giIt22
         2lnHi5hvuzKAkU6xca89tY4eZb9fbKghF9CsLgeNYBLtQfCXmNgfUepDs+eY01UzdgUl
         RRFzVQsJCXV6NcH8yu/98eM8IhR4V0wGJXG5gFbrpN+zTylTbQMxlabUbdaih6yXwej8
         65Ww==
X-Forwarded-Encrypted: i=1; AKwUvBwNPrNc/EkBpYXI1Q4FfmIbpawri9k0syeIjNWzAwYaW/FPCxGVFDD8zcwoMJbiVWn1rQVZ2MQsxLo=@vger.kernel.org
X-Gm-Message-State: AFq9FYK43zjB8hIfBlZiZDRB3nTdk+68i8W8x6bURSkOeVV2kfC7Qc4K
	nHlM9az5eDut4LatBusPReri9YEcI7o1atAlUmIdQVHkc+EC5erzDGIo
X-Gm-Gg: AYBFou0/+Mk53Hj8ic2BRJs+s51Ed0zc6d/vKsCESNiQZfMOjYWcc469mlvPDAturjk
	/+e98chf4Zk+YJeocYcsVL341mgMWALnpz+cQnFE/pF9po8DOQThOiJqUcmeo62pSUYlS0pHz4c
	1+JYsE2OP5JZwnwA0/jksWSNBNsUDEN+SJ01fBMvtpzCyu+siJFfzQsBl3IZWvJvn479Vciy1+I
	foHV8AuzcUyxoKAEUzjgAmb6B+PqBzbfkaGTjlMikXMsv5m26FROwsU7rBhLukcRXX1lksOiXhV
	g+0+mXmDj7lI2Oh4jAtHZfjVXPWcYjM1lG+wBE907e898CbXXHSCGcMZZnR1i8i1db3zCZ2d7PN
	GZmRpVTmB7sTCmcQuL3J/PN2eYg8aoj3T/MmfdVjuPdvrnYT6qIOFsataHn21+qENTTwgNl7rCs
	OYy/OHLoSI0R6BJv4NwhBzixCY7ZH9FdlXQ5N9EbDcWL/SsNYn6jnh1ywsFBDaMaXnD2J89e4lf
	1ui4RDHMvAX3sJ9mFPVKf+4dhryJVP23iDNbCQ7OHpI5q/hXPo=
X-Received: by 2002:a05:600c:524c:b0:4a1:825a:5726 with SMTP id 5b1f17b1804b1-4a18e4aeaffmr324226295e9.31.1792006158806;
        Wed, 14 Oct 2026 12:29:18 -0700 (PDT)
Received: from silicon.doe.home (91.141.74.240.wireless.dyn.drei.com. [91.141.74.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd6428b3sm15366385e9.1.2026.10.14.12.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 12:29:17 -0700 (PDT)
From: Stefan =?UTF-8?B?RMO2c2luZ2Vy?= <stefandoesinger@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
 Navid Ghahremani <ghahramani.navid@gmail.com>
Cc: arnd@arndb.de, krzk@kernel.org,
 Navid Ghahremani <ghahramani.navid@gmail.com>,
 Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject:
 Re: [PATCH v2 20/24] spi: zx: Add ZTE ZX family SPI flash controller driver
Date: Wed, 14 Oct 2026 21:28:05 +0200
Message-ID: <bE7m-smAQceC5FbpqYFgPw@gmail.com>
In-Reply-To: <20261014072109.1759502-21-ghahramani.navid@gmail.com>
References:
 <20261014072109.1759502-1-ghahramani.navid@gmail.com>
 <20261014072109.1759502-21-ghahramani.navid@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPartn0EpJE-9SfSFuAAbPf508w";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPartn0EpJE-9SfSFuAAbPf508w
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Stefan =?UTF-8?B?RMO2c2luZ2Vy?= <stefandoesinger@gmail.com>
Date: Wed, 14 Oct 2026 21:28:05 +0200
Message-ID: <bE7m-smAQceC5FbpqYFgPw@gmail.com>
In-Reply-To: <20261014072109.1759502-21-ghahramani.navid@gmail.com>
MIME-Version: 1.0

Am Mittwoch, 14. Oktober 2026, 09:21:00 Mitteleurop=C3=A4ische Sommerzeit s=
chrieb=20
Navid Ghahremani:
> Add support for the SPI flash controller found on ZTE ZX family SoCs
> (ZX297520V3, ZX279128S). Implement tuned PIO to avoid redundant FIFO
> depth reads, dynamic CCF clock scaling, 4KB operation chunking, and
> optional DMA support.

I'll diff this to the version in my tree and see what I can grab. I don't k=
now=20
if I'll find the time before November though.

Thanks to Navid for testing the driver on different hardware. I'm happy it =
just=20
worked :-)

> +MODULE_AUTHOR("Stefan D=C3=B6singer <stefandoesinger@gmail.com>");
> +MODULE_DESCRIPTION("ZTE zx29 quad spi driver");
> +MODULE_LICENSE("GPL");

I plan to submit this myself eventually. Right now I don't think the state =
of=20
zx297520v3 support is ready for SPI (no pinmux yet), and the code itself ha=
s a=20
pile of todos.

If zx27 gets to the point where it has the prerequisites  are upstream firs=
t I=20
can speed this up of course :-)

--nextPartn0EpJE-9SfSFuAAbPf508w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEQxb0tqoFWyeVMl1sPRO8yFRPGiIFAmrP18UbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMywyAAoJED0TvMhUTxoiYhMP/3T4GABMIAqaQToNO4bW
5MxJeHgXF4/Y9WgnyJpEShP1rbz33EBc9GonZUdR4gXd5G2lBmdHxOJFfyGr4BZ2
x9peuvHNo/sPJyGKah5Vzuc7u8xZNr8btz5Ii84aQtIZVlaSpeR1S9cJBEmIlGZ5
85/3Cj1IzgkVH+JcNEQtKzGzktNBoUBCnENMmwwH8ipgaaCcoIPgNAdRJpRFGzWp
e2rxRXAy+myHu2LYVxxrO0oKjb282Zww4QOqfdlg87NALZPYwHwNO4c7pVgWILb/
9jg/IXAuSj4ZL0/FmYT643GPLeqpIgkdD5wdY4o3tpJoi9CxTazQqp/8sZtQb4Oq
w/TnwFEKasPUKrgJnsOjYBwAeSuRPeg5ru5+P25cZPiB9oEGB/HpZvlHHVW9LC8A
Ife9JcUXnRYmOzyGIjhRT7QOX1BGxjiHKrN773QZetafZCvjMh2QnfTdb/1ENB9E
qWDOEBNUdXjhbsT/d4pWn5pjdufUni20OcHlhBaOFMZFabF/nWdUFN+/wXKVP0BR
twBNS/vtYkhD8LU/40uBOKzqHXOUVsnQn5R/hc5/LbvhV7mPnShsqf3Q2aMjfFHk
pb5hJgqiBHD4iFUx/6Rh5tfnyT920sdUj1vB5gGOj6JZJ1pCGr5XJSAoZSBmy8Mq
l+U83RloZSQSKjTwRix7tXWx
=cqfH
-----END PGP SIGNATURE-----

--nextPartn0EpJE-9SfSFuAAbPf508w--



