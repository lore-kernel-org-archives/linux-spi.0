From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/5] spi: sirf: fix spi full-duplex DMA transferring issue
Date: Tue, 15 Apr 2014 11:12:49 +0100
Message-ID: <20140415101249.GO12304@sirena.org.uk>
References: <1397457001-5266-1-git-send-email-21cnbao@gmail.com>
 <1397457001-5266-6-git-send-email-21cnbao@gmail.com>
 <20140414200628.GX25182@sirena.org.uk>
 <CAGsJ_4yO-LGJEkpNy=dizQWjSE3pHEBOrrPndho3jt1_YMRvHg@mail.gmail.com>
 <20140415092609.GJ12304@sirena.org.uk>
 <CAGsJ_4yWkBr2x=hLNaCsVwytDTua48kR+DEO86A6vH5x+jLEDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PtLnLSExlPr13a2X"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	DL-SHA-WorkGroupLinux <workgroup.linux-kQvG35nSl+M@public.gmane.org>,
	Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGsJ_4yWkBr2x=hLNaCsVwytDTua48kR+DEO86A6vH5x+jLEDg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--PtLnLSExlPr13a2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 15, 2014 at 05:57:39PM +0800, Barry Song wrote:
> 2014-04-15 17:26 GMT+08:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:

> > OK, that needs fixing.  That code predates anyone doing DMA.

> if it is out of specification, it seems fixing spidev.c is not enough
> as spi transfer actually needs an precondition of tx!=rx now.

Well, it's enough to avoid bugs.  Adding the validation to make sure
nobody introduces the problem again is nice too but isn't as urgent.

--PtLnLSExlPr13a2X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTQYeAAoJELSic+t+oim9mxgP/jdcZ2ZqA3k9627yeCIUNFnJ
JBJBSZqZIDWPPKZArtwtaXRAgIbGoWPHWhUy6NWkd4pLX+QLmwWQ5Ktd/VlffHpO
zAoIncuGhZll758gGjpl1ZAhRLHPfi3Yr5Gt9S4oR52T56b7Kgzzswtd2+Ys3pEv
TFY/Lib6wucrt+QWIvwqVgz75xfjC+eb0ariAFWEWIz5qPRsWkyAzMShWYQ8NvU7
cQYaja4IUOrGg4/gF4pocyUAc05vA29f3HcOyvweQqXtT6k7I4uv1ksDpKKfjjiO
8WaAC9Ui2C/uqI2kuLXE4JniGBnEDEwPwKabbO22htiZHhYUzRNhGRroFzIhTODi
1cNHqYstLhns+KpsGUulKXNs7mL0NK1ehn1mnCcQ4HrnzzHIXLsCPOxsnx/4M9uE
oS22+x3BhJYQ3w3HlZ4XUC+jq45BosL/F2xKddHehyRqNpoZGMlDU8l8edct5TWe
VR43pGML5AXfsFYvbC+F+iCtD3gaMpnh/Do40NNTx9h5eOTEaQTS6EL6qPCDko2y
uVWmHYnBCbHsozXQvZUexr+oCu2JdkCz+0tgRebC/mNfYWiX7fmW+aBXNIqBNCzM
UwQRnfrn+L7Ng6gs73FFBqqEUCWp96OIPFwQDMs6sFnvpLPlTUcQcc8aq/B+IHFv
XmtXagWEr6jJfwDCYlbH
=bwgS
-----END PGP SIGNATURE-----

--PtLnLSExlPr13a2X--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
