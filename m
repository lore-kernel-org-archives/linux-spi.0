From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: spi-imx: spi_imx_remove: do not disable disabled
 clocks
Date: Fri, 28 Feb 2014 15:13:44 +0900
Message-ID: <20140228061344.GD29849@sirena.org.uk>
References: <530EFE8E.5050303@freescale.com>
 <1393492575-32495-1-git-send-email-phdm@macqel.be>
 <20140228034620.GH9383@sirena.org.uk>
 <53100FEF.7060600@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VV4b6MQE+OnNyhkM"
Cc: Philippe De Muyter <phdm-vQo90/bmh3WzQB+pC5nmwQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53100FEF.7060600-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2014 at 12:26:23PM +0800, Huang Shijie wrote:
> =E4=BA=8E 2014=E5=B9=B402=E6=9C=8828=E6=97=A5 11:46, Mark Brown =E5=86=99=
=E9=81=93:
> > Why is the fix for this not to convert the enable/disable done when
> > tranferring to be preparing as well?  The message transfer doesn't

> It will make the code run a litter slow if we also do the
> prepare/unprepare in the
> @->{un}prepare_message hooks.

> This is the only concern.

If you're worried about that then how about doing the prepares in
runtime PM and then using autosuspend to keep the clocks prepared for a
little while after the last use has finished?  That's a little more
involved though and would still need this due to runtime PM being
optional.

--VV4b6MQE+OnNyhkM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTECkVAAoJELSic+t+oim9onwP/2KcQJcHjJ370lBY8YsMMzhG
cZjBFlXa5Hk8knM+agLzf9YnqiH+uAoZZmCRd4rG93uf2fgGXgnZ4b3+ez+oiPKQ
Ol8WTRuVVDVDoRPbNHEIRn3yeT35G4R5peaXjpTOrWIEkqyqM4Uo+TG268scio0U
aqla6Mwh3JcHOX+sJu62c/BQT1kZFKol9d65kvCcDvB0FPUJS3qG09wA3zuQRpsH
siLioFQIyxqJ+mx5waFl+ClDPdwNnzVbzmKMC6Wq9JJMFZrlkwIxMGmS/RphLDMH
4fZsB0I1Q/GoDc1yMVpLDMLUe+twIgOscZFXO0NprRIZthrdgCtSB2cZD2yPIb6A
pyUBw/dSRjj0iBvxbbLQdZPu4hoPVCN//dJMmh9DAq4FmKeY6o86doCmNgl8VBgD
wkP/cmclfrQK2v4ywss5zgNrGsmvuCXnQRAAw1SlTSzcYIr5NzguZLyPyUJq1Kv+
If9GAf7p6AN2INV5de8DL9x9DwntpI1ep5AusXt7b8P0AyvZJl860Dxz17IRspXY
7WJrkOaglDNB45ASANImn2r1tc2sVBXP2HhTa7LVuXzaZtRugk0Y+YknuITlwywV
dHW40c4PrQKvr+NuuOZrsB9odxBuDYLa9+VsjM/7MLfUvIwLwzIbXwIswBkhRZcI
vpSG/xf2RWbeQ9F9lxe1
=gnQj
-----END PGP SIGNATURE-----

--VV4b6MQE+OnNyhkM--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
