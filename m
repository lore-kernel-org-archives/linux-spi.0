From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: RfC: Handle SPI controller limitations like maximum message
 length
Date: Fri, 20 Nov 2015 12:05:02 +0000
Message-ID: <20151120120502.GT31303@sirena.org.uk>
References: <564CEB61.2000601@gmail.com>
 <20151118215755.GL31303@sirena.org.uk>
 <564D0098.4030107@gmail.com>
 <20151119114057.GN31303@sirena.org.uk>
 <F224F5F3-FAD5-47FE-9419-39E53BCBB8C6@sperl.org>
 <20151119171538.GO31303@sirena.org.uk>
 <9CDADBED-FD18-4635-82A9-5AB14C9ABCAE@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HL+2C3YiDdBCOf2R"
Cc: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9CDADBED-FD18-4635-82A9-5AB14C9ABCAE-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--HL+2C3YiDdBCOf2R
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2015 at 11:18:42AM +0100, Martin Sperl wrote:
> > On 19.11.2015, at 18:15, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > Please don't do things this way, please make this more data driven -
> > have the drivers declare their capabilities so the core can just do
> > these things based on those flags rather than requiring active code in
> > drivers.  This keeps the code central which in turn helps keep things
> > maintainable.

> Well - I was thinking about starting with this approach for simplicity.

> Making it automatic/data-driven by just defining limits that the core
> can then handle transparently is something that could come as a next
> step.

It makes things more complicated in the long run, people start open
coding things and then making any changes involves changing per-driver
code and we can't use the information in any way other than the one
specific way the transformation functions were written.

> Also the bus master driver knows what its limitations are, so putting
> them inside prepare_message seems reasonable to me - that is unless
> you really have spi_device drivers that would handle those as separate
> facts and not refuse to work.

Every line of code that's in a driver that could be in the core is a
maintainence burden, people will want to start doing things like
combining functions in fun ways and if we want to try to do things like
figure out if we can coalesce adjacent transfers in the core (which we
really ought to) it won't know what the limitations that exist are.

> > You've got this back to front - drivers are responsible for initialising
> > the master when they instantiate it.  There's nothing stopping them
> > using the data if they have variants to handle but they shouldn't be
> > speculatively looking at it on the off chance there's some limit.

> I wonder if such a variant-construct does not create more headaches in
> the long run as each spi_driver wanting to do something =E2=80=9Csomethin=
g=E2=80=9D
> special would then need to get updated for any additional constraint=E2=
=80=A6

I'm sorry but I don't understand what you mean here.  However we
implement things anything that wants to know about constraints is going
to need to be updated to use them.

--HL+2C3YiDdBCOf2R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWTwxtAAoJECTWi3JdVIfQyI8H+gPNqTSROCHTIQbSCyxe1QCb
DMZC5izVted78EU9gB/ItG4vfp60JiBVLBC93trEsw4mJsjCAnBg/4/39ErKrTQ9
lsoXwYSZCdmMpm5XvyGAPFgS/SgxAtLH8RX8RhCWFA44gR6TxEmKDWW1SZeqj/Xv
fFM56XF1fFmxDvEsU2SminV8+7cr1NhOIWhCc4JDn/29QtwnLF6vciXLdI3/XHI4
+xSGnJHDc4dQqndueKd/ya3lDiy7ICrhFcwlaV0q7D1Vr518468646VX/+qY8bOs
twCS5xlceXStv32DAgaAbTrgPOoYmXz3digLgZ/CKPG1TMbam8N1UyXgWLF49cQ=
=ycR/
-----END PGP SIGNATURE-----

--HL+2C3YiDdBCOf2R--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
