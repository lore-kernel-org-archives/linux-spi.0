From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Fwd: Depreciated spi_master.transfer and "prepared spi messages"
 for an optimized pipelined-SPI-DMA-driver
Date: Tue, 29 Oct 2013 10:56:27 -0700
Message-ID: <20131029175627.GC20251@sirena.org.uk>
References: <F70C4469-6325-48D5-A7CA-52CC1FC404BD@sperl.org>
 <CACRpkdb6y=o4__snBs2DR1f=xW_u7KdkHg3fb7XN5e2gicBJeg@mail.gmail.com>
 <CACRpkdb7y88oq7XyVFc_0Nx4pXtaebPe7KB2yizBRJGwWLqJig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdb7y88oq7XyVFc_0Nx4pXtaebPe7KB2yizBRJGwWLqJig-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2013 at 09:59:23AM -0700, Linus Walleij wrote:
> Let us discuss this on the new mailing list, BTW.

And with the maintainer...  I have zero context for this so I'm not 100%
sure what the original proposal was.

> On Mon, Oct 28, 2013 at 11:42 AM, Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org> wrote:
>=20
> > (... ) I thought of moving away from spi_transfer_one_message and back =
to
> > the simpler transfer interface, where the preprocessing would get done
> > (DMA control block-chain generation) and then appending it to the
> > existing (possibly running) DMA chain.

> OK quite a cool idea.

How is this going to interact with /CS manipulation?  We need /CS to
rise and fall as requested by the client, if we coalesce adjacent
messages that's going to be an issue...

> As you will be using dmaengine (I guess?) maybe a lot of this can
> actually be handled directly in the core since that code should be
> pretty generic, or in a separate file like spi-dmaengine-chain.c?

FWIW this is one of the things I've been aiming to tackle in my ongoing
refactoring, the initial two things were making the core able to do the
DMA mapping (probably adding a transfer API which passses in sg_list, it
can then handle things like blocks that aren't physically contiguous and
coalescing scatter/gather for the controller) and trying to overlap the
cache flushing of the next transfer with the I/O for the current
transfer.

> > Now this brings me to different question:
> > Could we implement some additional "functions" for preparing
> > an SPI message (...)
> > The interface could looks something like this:
> > int spi_prepare_message(struct_spi_dev*, struct spi_message *);
> > int spi_unprepare_message(struct_spi_dev*, struct spi_message *);

> Maybe? I cannot tell from the above how this would look so
> I think it is better if you send a patch showing how this improves
> efficiency.

The current SPI API has exactly those functions...

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSb/bIAAoJELSic+t+oim9M9oP/2wWEl4NFJ1xr7dRU7iSjxAr
lLFWuny0w2WZEThq75DJxooKL8FpR3JUZ1Wu8CDxMC52Xf5VoXvL36YhU7OOvtMi
Ki7cj2wZFqyxnkB7Q3X4BKqurKwstktaJVRXy28X54VgLgV5YfURF3v3l8/X1AQD
YJ2thws0M5rnATZxOMLeYV7yCUT6hr5mbLX5yp2dZSAfaNhsFv07j9W6c5Hn8y1R
F60EHo5BiCbcZ2YpfIvVWSF52R84w8mpg39w0Ln/eAMDp0PdF0KBOKH7/XYbRp1Y
wjVjQGxxb9X+VHA4W8JbCjzvFVvpCJl27eaBY+dwhZwjZ5br41AJqShnSE1czPLD
3ThqIQPsAjrYR1Z7NjtQxBn9+3ZLbZDM90arZ2s4sNhQKm+AriTcWIKAUBL5RhgE
4m27t6YypMHCKlNJqdM3vB+Fq8vyceVQnrhyqSIk62DBKXeYmLYKgrqKHjdBjeLj
mXmYo1cUKsQXQ7KlSfV+7DSvS7N2Zxvn0/6XnL+LFlmK3u7WIwO9+XVGI29SqL1j
PlDWicAKninX/ZdZ0cfRNZKqXMo7aJXHhI1aZCNqN+MNl9MhzIdzf7wokC7xEj8D
Oi6ZEvMjSQtY2IxPMAmTmbiKe3B9tMSww4X15X+RdHQc0zvh8ccKNo2eis/iWBeV
/iqtaKfKWD970OR+ey7B
=sR4s
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
