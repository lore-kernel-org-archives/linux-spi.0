Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793184168;
	b=iXlLsU6eon0Ud3cVOGtLZI2YBq7PZP3LljGrTGDFnTHMKVuiOh+Pp1Tj3REnPD2HOHS+
	 MyrpckpNku7WWalc1oLOqv2undWuzXxpns93M6dI3df9uhYdttUqmyFqhCuHsMzP2YM99
	 zXHovue4duWkq/crU96n6DDZQdRsLnLFmPzD8Vb7tSxTD26BsIqwFjlgFEjOKwV86GzT6
	 MtB159kzXl7ohM8cZw2Yju9e5tr9vV0hhVSTnU/TDae/5360vrKWIjzLGdqK2Ya0sPlFD
	 6y/l6MsKa7UiYEDYQ+mpargQJqJB3KCIseXn1lnHOMzWt2xnHHXvxIZNS8Uljo6xHdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793184168;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:
	 X-Last-TLS-Session-Version;
	bh=G7SGsnjmO2AtGa1YhQju9ah0Ewiw5mAJClKeUYxhBsU=;
	b=bfeMWEqx050mykSlAu/zzWK8Vl3NOoRZd0hiJ61Nh96SkQv9tZKOWha618wUXVHLfCCL
	 x78hDUTWoWBRzKgwg6N10uzgKKLbGPNb3A+m363Z8VueBcBHwXaOa4iEsKHTfZ0k7sDwY
	 p/2XR/qBei/XIlzOInm3F9w3Q/15pAkwaEoRC36T+FU/dHhHe617eWKwx2EMbPjHq0L3L
	 PZxBjDYnsXgEKe6SokMxx7ODvZfw6ALCeAyns4tSROBjy9q4pnoWr/SfGOTgtSAx/rBK4
	 h9UX0MbOuHVY7B8iGeoNqsJKso8Ne2kbxBSIbcH3guMbQVBxU9rVzBI2UzCJvecPT1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=f4gB9JfG;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F87606A325;
	Wed, 28 Oct 2026 10:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8F87606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=f4gB9JfG
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 277B84E412DD;
	Wed, 28 Oct 2026 10:42:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D854560769;
	Wed, 28 Oct 2026 10:42:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4BB39103290AC;
	Wed, 28 Oct 2026 11:42:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793184162; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=G7SGsnjmO2AtGa1YhQju9ah0Ewiw5mAJClKeUYxhBsU=;
	b=f4gB9JfGl2MsxLy3brpGXg+G5YiC8friNAVRIR/pW0cXoVvzpMz9F+2Mx75zlxUblt3kwR
	RILbkCBaOb/DYo01a7OLZZXjoaFBgDpZhvhVAhwAcdF4lGFadI4Wcsg6VynphzAgQRYCE+
	52aiaEBTHrRUtFV3mA0CueMUb90PvOPX4Yt2Cm0rq0w9T6bx5RIe7zzPGyZ49rRK8laPJ5
	15ejyqmkRsTG0uLEKPqlNSRil6lZpLtF2kMzPfIX+Haj4Z7VKdPrKpQ89H1WJWVzCuHX2d
	aSDX8mxdhwJ0tjURlxDwH3CDLJv8UzO3SKgywCOdeOHrR9hJUXgv4KktJcFK0Q==
Message-ID: <fdc79c99e3045635841f68c89fec3b9d9e2f7233.camel@bootlin.com>
Subject: Re: [PATCH v4 0/7] spi: Add support for panic mem writes
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
  Takahiro Kuwano <takahiro.kuwano@infineon.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger	 <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Mark Brown	 <broonie@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme
 G . Piccoli" <gpiccoli@igalia.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, 	linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, 	linux-spi@vger.kernel.org, Bharat Bhushan
 <bbhushan2@marvell.com>, Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Tanmay Jagdale <tanmay@marvell.com>
Date: Wed, 28 Oct 2026 11:42:33 +0100
In-Reply-To: <20261016102917.171095-1-paul.cercueil@bootlin.com>
References: <20261016102917.171095-1-paul.cercueil@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

Hi,

I have a second patchset for spi-cadence-xspi pending (unrelated to this on=
e)
that happens to have some Fixes: tags, and those fixes conflict slightly wi=
th
the changes here.

I'm thinking that in order to make it easier to backport those fixes to old=
er
kernels, my other patchset should be merged first. So I guess I'll v5 this =
one
with a rebase once the other one is in.

@Mark, do you want me to wait for -rc1 to send it to you?

Cheers,
-Paul

Le vendredi 16 octobre 2026 =C3=A0 12:29 +0200, Paul Cercueil a =C3=A9crit=
=C2=A0:
> Hi,
>=20
> Here is the v4 of my patchset that updates the MTD spi-nor code as well
> as the spi-mem code, to add support for panic mem writes to a memory
> partition configured as pstore.
>=20
> This revision adds a workaround in mtd/spi-nor to avoid a call to
> kmalloc(), and fixes a kernel doc mismatch.
>=20
> Changelog:
>=20
> =C2=A0- [2/7]:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Also update kernel doc for n=
ew 'timeout_ms' parameter
>=20
> =C2=A0- [3/7]:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - kmalloc() is not safe in pan=
ic context; reuse boucebuf instead
>=20
> =C2=A0- Patch [1/7] and 4->7 unchanged since v3.
>=20
> Cheers,
> -Paul
>=20
> Tanmay Jagdale (7):
> =C2=A0 spi: spi-mem: Add support for panic mem writes
> =C2=A0 mtd: spi-nor: Wait for NOR ready with poll_timeout_us()
> =C2=A0 mtd: spi-nor: Add support for panic writes
> =C2=A0 spi: cadence-xspi: Clear "SDMA ready" IRQ flag after polling
> =C2=A0 spi: cadence-xspi: Add irq-less support
> =C2=A0 spi: cadence-xspi: Add support for panic writes
> =C2=A0 spi: dt-bindings: cadence: Make XSPI's IRQ line optional
>=20
> =C2=A0.../devicetree/bindings/spi/cdns,xspi.yaml=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 -
> =C2=A0drivers/mtd/spi-nor/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 128 ++++++++++++++----
> =C2=A0drivers/spi/spi-cadence-xspi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 114 +++++++++-----=
--
> =C2=A0drivers/spi/spi-mem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 42 +++++-
> =C2=A0include/linux/spi/spi-mem.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 5 +
> =C2=A05 files changed, 209 insertions(+), 81 deletions(-)
