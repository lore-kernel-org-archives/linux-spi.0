From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: Make core DMA mapping functions generate
 scatterlists
Date: Wed, 5 Feb 2014 12:00:02 +0000
Message-ID: <20140205120002.GH22609@sirena.org.uk>
References: <1391349172-27668-1-git-send-email-broonie@kernel.org>
 <201402050730.57398.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8V/AXrYGldrj4WKF"
Cc: Lukasz Czerwinski <l.czerwinski@samsung.com>,
	linux-spi@vger.kernel.org, linaro-kernel@lists.linaro.org,
	linux-samsung-soc@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201402050730.57398.marex@denx.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--8V/AXrYGldrj4WKF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2014 at 07:30:57AM +0100, Marek Vasut wrote:
> On Sunday, February 02, 2014 at 02:52:52 PM, Mark Brown wrote:

> > +static int spi_map_buf(struct spi_master *master, struct device *dev,
> > +		       struct sg_table *sgt, void *buf, size_t len,
> > +		       enum dma_data_direction dir)
> > +{
> > +	const bool vmalloced_buf =3D is_vmalloc_addr(buf);
> > +	const int desc_len =3D vmalloced_buf ? PAGE_SIZE : master->max_dma_le=
n;

> You might want to rename this to "sg_chunk_max_size" or something, "desc_=
len"=20
> doesn't make much sense here. The variable describes the maximum size of =
one=20
> single scatterlist element.

A scatterlist entry is pretty much an abstract descriptor though.  I
seem to remember looking at the name and thinking it was good that it
was something less easily applicable to the length of the table but it
doesn't make much odds.

> > +	const int sgs =3D DIV_ROUND_UP(len, desc_len);

> Looking at this, the variables could generally use a more meaningful name=
=2E I=20
> think it'd be clearer to call this "num_sg_chunks" or so ?

You do know where I lifted most of these variable names from, right?  :P
Looking at the code again everything seems idiomatic with the naming of
the fields inside the sg_table - I probably would apply a patch to
rename but I wouldn't write one.

> > +		min =3D min_t(size_t, len, desc_len);
> > +
> > +		if (vmalloced_buf) {
> > +			vm_page =3D vmalloc_to_page(buf);

> Just curious, but shouldn't we check if buf !=3D NULL right at the begini=
ng of=20
> this function?

No need, the check is outside the function along with the check that the
controller is OK with DMAing on this transfer and so on.

> > +static void spi_unmap_buf(struct spi_master *master, struct device *de=
v,
> > +			  struct sg_table *sgt, enum dma_data_direction dir)
> > +{
> > +	if (sgt->orig_nents) {

> I don't want to nag, but why not use if (!sgt->...) return; ? This would =
cut=20
> down one level of indent.

I was looking at some stuff which might add a bit more in here if it's
not just the core doing mappings.  Not sure that's sensible though so it
might never materialise.

--8V/AXrYGldrj4WKF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8ie/AAoJELSic+t+oim9NOUP/3QjvroAXWet+ErWQNfZEa2C
C0M7+PppzptjESxNwAI9EnYjExtIembMeI6stRU2UQrgxklLel79FDVPo5RYOo0/
zDSAweW2Vie4cRUqEWfBnoiOZvU0W3kWmsBFanxfo15It0Q4Ygh02LiwI/9goi+B
12IXWOx7lmVGmZdPbUvMA7rEVCGvcrKYryLMGnGpXsecSryfzwVc3nlu35kqERzs
sFZHwGdIZsjh41bhXNNXB0QVJ2DVKOCzDCCB38V2dXwydTiZ+5pgza2ApUIcZwEX
ZyQ/RGHdx3FoGxG78d5yQVVD1+iMYDuWiTFNlnHRyULjtyZWxx2qELSm0bomeWt5
dgkxy3OIMGYMfo+RA0KgPF8UhiR3mn66eZJzMCEtmmUrCU8DPxsiF2J4REB7L+Vn
y5PJCXXjsB59YXMOa8bpzq1ZqACKe8WTdhEXoVGCBx68Xvk5EZATr8+jrMrKQuiw
lgXgyIPfh/H/ZUWLJY4MU5Puy3kWqu+QS7o+egc8XjvfLNCnqH2Clt+SyovV3uL6
cjQzECFvLej66bsl+QXDvfxH1fhuxWghuDQXQrwbsjMTNJmvkG+4243dVhBZocEn
VHLR1WdNhO0TlxHrbmJlXjk+2ojPMWlzqWuDE0SNMOhIJPB76Kx1WdXYe+nmtHAY
TLrPHRuW/Va9pnzgFFKi
=d3ui
-----END PGP SIGNATURE-----

--8V/AXrYGldrj4WKF--
