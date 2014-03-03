From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: fsl-dspi: Fix getting correct address for master
Date: Mon, 3 Mar 2014 10:46:08 +0900
Message-ID: <20140303014608.GL2411@sirena.org.uk>
References: <1392353352.19487.1.camel@phoenix>
 <CAFRkauD3WFBw9VC6h+2bxcnuky7175G47+7tP8=5f4D2PeLpEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ai3I8gwHc37+ASRI"
Cc: Chao Fu <B44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alison Wang <b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFRkauD3WFBw9VC6h+2bxcnuky7175G47+7tP8=5f4D2PeLpEQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ai3I8gwHc37+ASRI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 02, 2014 at 11:09:41PM +0800, Axel Lin wrote:
> 2014-02-14 12:49 GMT+08:00 Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>:
> > Current code set platform drvdata to dspi. However, the code in dspi_suspend()
> > and dspi_resume() assumes the drvdata is the address of master.
> > Fix it by setting platform drvdata to master.

> Hi Mark,
> I guess this one is for 3.14.

> In dspi_probe(),
> current code has:
>         platform_set_drvdata(pdev, dspi);

> However, in dspi_suspend() and dspi_resume(),
> current code has:
>         struct spi_master *master = dev_get_drvdata(dev);

The patch doesn't seem to have been appleid at all?

--ai3I8gwHc37+ASRI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTE97cAAoJELSic+t+oim9c0EP/i96ZxLVKg8ygURKcu5q24KT
t1bI66ps7SCWLd3piB8ehKP1sQgObh9sOvhgH01vB5HvyzQPQqULLSyWgIlBuSnm
OClO2C+9wq4ADulK2+gdH9haQPARfn7SaeTPmzlHnZWBHPOIjS6F8USULHqMEjAY
sbAPxDhNwaGa2OS7uxurV6PvFWm7CIcsU+3bjMNFtHNKlafmNNljantb+A8wLKj2
ZUjb7owgId0QFp+VcqMmM06zuzuaJ9sXyjmcaoab8gCwW0/35JK8uz8sqE9DdRSu
ngVtIN5e2mkzH09iZml0x+kU1bSqGzsMoSz2T2LCSw9pXxVQfsbFn7j9v4sqC5E4
ZjWJ0lgNBmD+rQpJ8L7NyfvBzQ/9BzHVG27piN3Htyk6YbBF7svN+0kmda5Bsyh+
CyMk09TYF4MnqOoj13762ui8youLtkWdpo4ems9iyRwzP52jSz9z35/GfUCIF3/C
KhXSavphUqbmpaaMdE5zybbiNtzrEwuktlW0L3wuowZk6Iwx6tnbHql7EjKbojuC
5AsEDCj1KyWtHlcl3JClb1fmFDPgBPh/1qVw0C7E1+8m87FvKtEnrfH1J7BhHuRL
bv35sq0EDlFd91SDFHHw+q/xmaX1jwFdkigCo/678p0YinIBd/llVPSLYSVnTrki
QzBDgYd7EnqVnK5RgON6
=SBQ8
-----END PGP SIGNATURE-----

--ai3I8gwHc37+ASRI--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
