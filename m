Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794018967;
	b=YGFsihPa0E7bJkJjgq8a9MiwTAq2IDEWKrqmGaWEH5D/LPkdiVLXPIhB6L95p9adnOZA
	 QdJm5pla6+fmpSjstvDanB3UlA7MX5CIIkJJqkGRgGxJAxqaxxXAFR4yOTH1H0C42DDxB
	 cB0njosXkBGAzw9XIyYyfDpao+jiYPKUXJZvUx6JB23jYHlwM8ugKu8ww9Wm4CEz7WnIT
	 yN+bFdlxO9glw0i5zRcBEOmNBj9D3EpdPvjWlsnLncwh90zDLQp8Gy1I2bwZ3NxSN8rI5
	 bn2vQI4PE7ACcG3vxKCbPrf1nytXsMgIffe1UrOLedNJOQ52xD7VBy1ptw17h3ZMkxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794018967;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=v712UGBT916bmhBnvp8NE4rFlnCTJxp0AJI2r2bH/p0=;
	b=JHoTH4YK0lg+Qj8TblDRnqt9CwN5DzknFg1LcfobdVZkVxrkt/kuizoy6gLTF17jCLNt
	 RwUkANXpMrw/pEeH2tZzQ4lbxAyibdJCsGGS2wuL1MrGuwZxaFHCr1yeF1BPULLrEKasu
	 bh2TU4aBAn/S7D8iCKEm9zN1dN/EdMhdlmmIrPWP/q53R8yfaioM05gthYzvxMjmQdpuE
	 s0v78sYT7qRgSB2hJJpf7RG60ZzE5qfgjEUSVl2qJCSd3V6ND9u5tpGV3ppXT/YPr6uRN
	 wBWP5jugjEkz4PQqut3J5nbVglpC7JAbwFWKRPnlKlvy9QZPZE7bj/twqqMDtD9qWnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=ifU31Qgi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4576606A32C
	for <linux-spi@vger.kernel.org>; Sat,  7 Nov 2026 02:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4576606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=ifU31Qgi
ARC-Seal: i=1; a=rsa-sha256; t=1794018955; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MtPclBf6Oq00X7GJgLcyoqNjzMkXF+RPs8dNEViqwb3kWHkglMRvBofPGGVnH553GGDEry8yUQVJaPOy8Lr3gt2N10s5HENi0Bor1/yjz2gmNZKYAMzXCBoAUDhkotuPockGqdVgny2y4rQBZVjP+o5J6kJUKRmwZn3uo7NCI6k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794018955; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=v712UGBT916bmhBnvp8NE4rFlnCTJxp0AJI2r2bH/p0=; 
	b=AitNI4VBDs1jIkOAA+E/qaRLrI0+tdNbgiL8bPP22bdOmprcCLxfG/HbDTmRKhDQNExEh4lvr1MVgDXa1JRf1meBADEiKC90xtq6fm7BUik3oPViA8MSZlHAmx4/NpUu3ZVE1VVUvnDN8DuGsoEtOyNObpKE7i+3tfBtG/ZNBhI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=ifU31Qgix9ED1k9JqJjLhZtis7WD3n5gK5HApCN24ahGx/mA4YNN6WDAjw521c8HHdiWP5oOrjtrbdm+Uu22KBG//5Q/34Ys6d81jrEtr8qhXdRA8lkZVUObNDKxFkLy5KcFI4mKkYyi3C963KqDFSQDP9riezWXCmDadbpPObs=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=v712UGBT916bmhBnvp8NE4rFlnCTJxp0AJI2r2bH/p0=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794018954405705.4847357899479;
	Fri, 6 Nov 2026 18:35:54 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id A49FF180312; Sat, 07 Nov 2026 03:35:51 +0100 (CET)
Date: Sat, 7 Nov 2026 03:35:51 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Mark Brown <broonie@kernel.org>
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>, 
	linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] spi: rockchip: Fix runtime PM underflow on CS error paths
Message-ID: <au6LMNctO1fx_Kcl@venus>
References: <20260806191854.922530-1-eagle.alexander923@gmail.com>
 <179397711825.3231166.14531785924256368148.b4-review@b4>
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
	protocol="application/pgp-signature"; boundary="loz7exf7kqwri6c5"
Content-Disposition: inline
In-Reply-To: <179397711825.3231166.14531785924256368148.b4-review@b4>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/293.995.13
X-ZohoMailClient: External


--loz7exf7kqwri6c5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] spi: rockchip: Fix runtime PM underflow on CS error paths
MIME-Version: 1.0

Hi,

On Fri, Nov 06, 2026 at 02:58:38PM +0000, Mark Brown wrote:
> > The Rockchip SPI driver manages runtime PM reference counting around
> > chip select (CS) assertion: pm_runtime_get_sync() is called when CS is
> > asserted, and pm_runtime_put() when deasserted. This balanced pair is
> > expected.
>=20
> > @@ -256,6 +257,7 @@ static void rockchip_spi_set_cs(struct spi_device *=
spi, bool enable)
> >  	if (cs_asserted) {
> >  		/* Keep things powered as long as CS is asserted */
> >  		pm_runtime_get_sync(rs->dev);
> > +		rs->cs_claimed =3D true;
>=20
> This sort of boolean tracking of reference counts is extremely error
> prone, and note that there are two chip selects on the device.  This
> should probably at least be per chip select.

I ran into the same symptom while working on RK3588 system suspend
and came up with a way different root cause.

I haven't found the time to investigate more closely, check for a
proper Fixes references e.t.c., hence it has not yet been send. So
take this with a grain of salt, but it seems to be not Rockchip
specific:

-----

=46rom: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Sat, 5 Sep 2026 00:26:40 +0200
Subject: [PATCH] spi: Fix runtime PM imbalance on pump transfer message err=
or
Cc: kernel@collabora.com

The current SPI message pumping code may drop the runtime PM twice when
an SPI message cannot be send:

spi_master spi2: noqueue transfer failed
rockchip-spi feb20000.spi: Runtime PM usage count underflow!

Fix the problem by always keeping the runtime PM count increased when
exiting __spi_pump_transfer_message(), as the caller handles decreasing
it.

Note, that the function already keeps the RPM usage counter increased
for the error paths following after the prepare_transfer_hardware step.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/spi/spi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 40cda0037ea5..9cd1cabfa0b3 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1951,7 +1951,6 @@ static int __spi_pump_transfer_message(struct spi_con=
troller *ctlr,
 	if (!was_busy && ctlr->auto_runtime_pm) {
 		ret =3D pm_runtime_get_sync(ctlr->dev.parent);
 		if (ret < 0) {
-			pm_runtime_put_noidle(ctlr->dev.parent);
 			dev_err(&ctlr->dev, "Failed to power device: %d\n",
 				ret);
=20
@@ -1972,9 +1971,6 @@ static int __spi_pump_transfer_message(struct spi_con=
troller *ctlr,
 				"failed to prepare transfer hardware: %d\n",
 				ret);
=20
-			if (ctlr->auto_runtime_pm)
-				pm_runtime_put(ctlr->dev.parent);
-
 			msg->status =3D ret;
 			spi_finalize_current_message(ctlr);
=20
--=20
2.53.0


--loz7exf7kqwri6c5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmrujoMACgkQ2O7X88g7
+poXuw//e/AAKsrPGLc0TGTC0FEDRJWx2suSUGQbQhMTSKVm4mDU0ed3DHZU8lf4
btu+nzbxqdX4I5Je2w3lbeLk5jJKj0zduPNG0qVKq4R8N9Z0qETKYxBPZjvHQBa6
88Vbds8T25hRjOD3Icv3xjMhytvsAfhzkdRQeruzkUdCeiAxACPzeW2s38EPfklY
BHW2UoufPdO/j2o93TQ+AMUMXS++7vcziulWt74nw64p3mbtv302rJG0lPKge2Xm
SIvjZ03zYcUiLVALNOj3VvxRCbln7P0+WccawSdfS7mqZioKQ2eaHB6SGxz81gKb
oTvgY2NufpbvYt/Q7AB5TFzhR1e6/rgtGesFSv8k+J03r59aZqzc0qU4A8xjP9mb
VHUkDTroHdJSj0bdlOwezfNxJ568wDzEvUdOyIlrW3xcMSki3ODjEzZR7f8qAavD
rahgjmg8JFnRyMi8xEERXQxHIFmbF0V7z0RtXpGMZpSvaDdBmkmIZqxcmNh8Ki8i
ZDnQeoGJzoKh0PmMqrJdiHoLdSlVI4zUe9QDA4vEfapwXNHqXaoX/GXV40+GKNSQ
hayP/UwHBRCrTJF4Af/R0VtGIDF/uSX3Ws/0j26TQj0hiUTXO757xLrzjZMiYtBq
1aNpoFrnn/vHK4ETd9/3UP0rVZwfsuopY6scyn4LJnvIZDy9Y3Q=
=Lhsf
-----END PGP SIGNATURE-----

--loz7exf7kqwri6c5--
