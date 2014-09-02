From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] spi: atmel: remove unnecessary #if defined(CONFIG_OF)
Date: Tue, 2 Sep 2014 17:36:58 +0100
Message-ID: <20140902163658.GA29327@sirena.org.uk>
References: <002a01cfc65d$2dc86640$895932c0$%han@samsung.com>
 <002b01cfc65d$569ef570$03dce050$%han@samsung.com>
 <20140902105018.GR29327@sirena.org.uk>
 <CAMuHMdU2S_vwv3=CUtgGjqnq-nbh=up42gDWzR35ai6s4ZVaWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DG78IEnUmLKoW088"
Cc: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdU2S_vwv3=CUtgGjqnq-nbh=up42gDWzR35ai6s4ZVaWQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--DG78IEnUmLKoW088
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 02, 2014 at 02:15:09PM +0200, Geert Uytterhoeven wrote:
> On Tue, Sep 2, 2014 at 12:50 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > On Tue, Sep 02, 2014 at 12:24:00PM +0900, Jingoo Han wrote:
> >> Remove unnecessary  #if defined(CONFIG_OF), because this is
> >> already handled by the of_match_ptr macro.

> > Applied, thanks.

> If CONFIG_OF is not set, binary size is increased, as the OF match
> table is still emitted, while it's no longer in use:

OK, I've discarded the series.

--DG78IEnUmLKoW088
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUBfInAAoJELSic+t+oim9ItwP/jAHyYhpSBexiVlkj1jIm00r
gt+cX8YRmNK59wjHErTgFIyG/99uOy4ltmVg11oDFW9wDdIzWIsHy8Qc5nKD/90a
B7++D57RYn7YeXZhDgxT0bOxzvwrY5ofWlxZQjuNlbfqdJUIL4eyEfVPqtVBwBXR
O5boEr+NirWmeeibvPcvqiSjwD8xWAtqI/4JiDpQsoAZNc8xQ3RFeQUiM1gaqOAb
8UzAlQw30loBEy4RBdKe4VgBn6v5p1n7UttlFH9dWb5LkSlQWfgxuKvmmVFv36fy
HvTxQfqLJgHWotGiqQqdjBobMmTlzn7uyfDBiHQCql+V4buGtdCPMPKvsDUc0iIs
6vVFj3TmlSHB8tn2Ntsj/Tv5LbLN8IEwbaK5D6Cs5SoNoutrQuRKHPNcqeKnG6H8
Ds5M83vKX6vmdS4RpCpDDMdyMpxo06bKS/LMnbQaUMllTshPUoyMzed2lZOKduQ0
9wMktnhpxyVnqV1l2eswgz1fT7hmkZ0DwjeYQbi1lc/jSpFEn7+wKyWM0v8RMvyW
aUrFYCKKnqq1l03CiENsJOWQMH9j785VPRzrW0PUi3h6mywEk/wk1MGGGEZifOoS
jCvy/KLW2LenqJ6eUDTQEu9Mi6IDnfqokWkvBAI4Py5Q3OEZP9VuIUDp0DncK4Rn
ahDG3E5HsLFKzQbOGVIz
=2NlD
-----END PGP SIGNATURE-----

--DG78IEnUmLKoW088--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
