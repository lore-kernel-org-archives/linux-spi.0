From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: add initial set of spi_transfer transformation
 methods
Date: Thu, 3 Dec 2015 00:36:18 +0000
Message-ID: <20151203003618.GQ1929@sirena.org.uk>
References: <1448888695-2260-1-git-send-email-kernel@martin.sperl.org>
 <1448888695-2260-3-git-send-email-kernel@martin.sperl.org>
 <20151201212929.GV1929@sirena.org.uk>
 <35C5C134-8291-4856-8916-7EDDFB07A0A9@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="66fSncucMF2yJS4h"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <35C5C134-8291-4856-8916-7EDDFB07A0A9-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--66fSncucMF2yJS4h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 02, 2015 at 08:25:08AM +0100, Martin Sperl wrote:
> > On 01.12.2015, at 22:29, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> >> On Mon, Nov 30, 2015 at 01:04:53PM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrot=
e:

Please use normal formatting for e-mails with blank lines between
paragraphs, it makes things much easier to read.

> >> +/* the spi_resource structure used */
> >> +struct spi_res_replaced_transfers {
> >> +    spi_res_release_t release;
> >> +    struct list_head replaced_transfers;
> >> +    int inserted;
> >> +    struct spi_transfer xfers[];
> >> +};

> > This quite clearly isn't a struct spi_resource, nor does it contain
> > one...

> It is done the same way as devm_kalloc uses struct devres:
> the magic devres struct is hidden by the devres framework.=20
> Only the payload data pointer is returned, which is what this
> structure describes.

> You want it as a more explicit member instead?

If it's not actually a resource and is really just a structure that
happens to be managed with a resource then describe it as such, I'm
complaining about the confusing naming here.

> >> +static void __spi_split_transfers_fixup_transfer_addr_and_len(
> >> +    struct spi_transfer *xfer, int count, int shift)
> >> +{
> >> +    int i;

> >> +    /* fix up transfer length */
> >> +    xfer[0].len =3D shift;

> > It's really not clear what this is supposed to do.  Among other things
> > "shift" appears to be misnamed and anything using tx_dma and rx_dma is
> > worrying.

> Essentially this will handle count spi-transfers that have all identical =
data
> (Except for transfer_list) initially - especially Len and tx/rx buf.
> The first of those transfers is set its length to shift=20
> (no need to modify rx/tx_buf)
> The others are reduced by that length and the pointers are shifted up,
> So that they are now starting at the address after the first transfer and
> Transfer the correct number of bytes.

I'm sorry but the above is still very opaque - why would we have some
list of transfers that all have identical data?  I *think* the intention
here is to do some realignment and that shift is really an offset to
move things by?

> Rx/tx_dma is handled because it is there and it's address needs also to be
> accurately Shifted by that offset. I know that it is a depreciated interf=
ace,
> but as it is still there it needs to be supported...

It's really quite broken already for most users.

--66fSncucMF2yJS4h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWX46CAAoJECTWi3JdVIfQxwAH/irYcv8g9NcGPTHPHwR/Q6uA
XcqDPmkCuFE0Qo4Gx0CDYiFTVSmSWzDfgh2aGbyS3Pr5v9qYERt+ycmvviWZLQZ0
XZ/SetrVZexXtP94ieGxdCTLaXKznYqlVZp11KF85Ar/Uqw4m6SmEH0VrsvGh347
pH2t3Kq5JgwybaXEzyrqiy8oLgGt2zck+jaPHS4JBEFbwKR9G+TfENicsrQ1ZMIS
CE/qulcMSFv7pYbYvw04HXg+3Ay65iDhPRnKpxQm55TGHIWYDn6eEl0FVMU1Axdu
woikYdbPbmm7fOFyUYrkrQRpbpvsRtEKCrBUy9UgCNDW8AXzpfgdiFjdbVr7tzw=
=J6TD
-----END PGP SIGNATURE-----

--66fSncucMF2yJS4h--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
