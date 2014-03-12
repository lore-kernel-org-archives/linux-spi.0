From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: add xtfpga SPI controller driver
Date: Wed, 12 Mar 2014 00:34:01 +0000
Message-ID: <20140312003401.GE28112@sirena.org.uk>
References: <1394541891-26469-1-git-send-email-jcmvbkbc@gmail.com>
 <1394541891-26469-2-git-send-email-jcmvbkbc@gmail.com>
 <20140311194959.GB28112@sirena.org.uk>
 <CAMo8BfLTn+pneF6_7XkP66+LzpZgcefnAo_FkwxpvtYdt9yduA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LioDbVBSbBewOkfJ"
Cc: "linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org" <linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>,
	Marc Gauthier <marc-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMo8BfLTn+pneF6_7XkP66+LzpZgcefnAo_FkwxpvtYdt9yduA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--LioDbVBSbBewOkfJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2014 at 12:20:49AM +0400, Max Filippov wrote:
> On Tue, Mar 11, 2014 at 11:49 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > On Tue, Mar 11, 2014 at 04:44:49PM +0400, Max Filippov wrote:

> >> +     unsigned long timeout =3D jiffies + msecs_to_jiffies(100);
> >> +     while (xtfpga_spi_read32(xspi, XTFPGA_SPI_BUSY)) {
> >> +             if (!time_before(jiffies, timeout))
> >> +                     return -EBUSY;
> >> +             else
> >> +                     cpu_relax();
> >> +     }

> > So we'll busy wait for up to 100ms - that seems like an awfully long
> > time.  Perhaps fall back to msleep() if the delay is non-trivial (or
> > just reduce the timeout)?

> The timeout is here for the unlikely case everything went wrong. Normally
> transfers get completed in about 10 useconds on 50 MHz hardware, it
> doesn't seem worth msleeping here. I put the timeout here just because
> otherwise infinite loop polling the device register looks scary.

I appreciate that but even with 5MHz that's three orders of magnitude
longer busy waiting in the error case than the operation is expected to
take.  If you must wait for that long busy wait for a bit then start
sleeping.

>=20
> >> +/* Unused: this device controls its only CS automatically,
> >> + * deactivating it after every 16 bit transfer completion.
> >> + */

> > This is too limited to use with most SPI clients, they'll want to be
> > able to transmit more than one word (and the fact that only 16 bit words
> > are supported is also an issue, though that's easy enough to handle for
> > a bitbanging driver - I'd really strongly suggest supporting 8 bits per
> > word as well).  Clients are pretty much going to need to use GPIO based
> > chip select, you should make sure that's supported and covered in the
> > binding.

> There's no hardware for that. This device is really dumb, it is specifica=
lly
> suited to control TLV320AIC23 which expects exactly 16 bit words, SPI
> mode 0.

This driver is not actually compatible with the tlv320aic23 driver since
it needs 8 bit words, you need to at least support that.  You don't need
hardware in the controller to support a GPIO chip select, the whole
point is that the controller chip select isn't wired up and a GPIO is
used instead.

> >> +static void xtfpga_spi_chipselect(struct spi_device *spi, int is_on)
> >> +{
> >> +}

> > Omit this since it's empty.

> The bitbang side doesn't like when this callback is NULL and returns
> -EINVAL from spi_bitbang_start.

So fix that, but really it's trying to tell you that the hardware is far
too limited to work with many things.

--LioDbVBSbBewOkfJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTH6t2AAoJELSic+t+oim9df8P/1KhuFyt9TPtdSNa1RNHCmDj
nG72Wa3e3+Vel9AVTImz41S5MEWcUhV5RurE14eFpRPlgmDG8SV8+iASAqVD4Xng
cpiB9HrJWhIX30G8JJncueS7lY89/Vi3SAs0BPjTUUr25XTpr2oP6a/47kh8UQhO
2ZG38Bz/2HiIoKrdlW4o1Gh3bh6Pnm/qWNlqpIo0tfb/znJ2efsccAmnNI6gvVpy
Mn7zPzBkwYGQX8f9YjCNO5YLcapJVKukIimxkNfXU40GcVkkQN4erzXP+QxeVMo5
f1oe9q2pwF7qLmIE+znEvGUY7uvd/kalxqgr7haiIretIXL7Nyqfw1qqDQJnJCH2
9cnqTfBEcpkQbzeCioGaYFoovHgj7bkdPp+BsfnSg0ordzqiXE1yBXCmyXQ/ZjgW
toETYQn+nLs4WNPf7rxpqmLpvmTMFSX/641FsZWhedHcbm6qiMNNh4jxag5FMfcj
XQ3nnlP+G3Xxkcxr3NeK92+XWcvasNyYmonJodlC9BdrH0a34pQLCfrh/CWGAx+B
1NImW9PKZ/nkKeZWmV4LDc/+S3I7PLUMrY+hOlwKyAiT9d9j9zVHylu+xm4/EC4y
NaHN+xJmPuwwKGx0DfOxtdpJ6AfD7gmjhDFKR7CmhITZWoC0EKCGvXM8Sjaipe8J
nt2zeoHeRj9cleFqYbKk
=2a7j
-----END PGP SIGNATURE-----

--LioDbVBSbBewOkfJ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
