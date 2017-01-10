From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND] spi: davinci: Allow device tree devices to use DMA
Date: Tue, 10 Jan 2017 16:51:46 +0000
Message-ID: <20170110165146.ineknejdhln5mwkv@sirena.org.uk>
References: <1483673177-31516-1-git-send-email-david@lechnology.com>
 <20170109194811.p3if5pzvjjaez2g3@sirena.org.uk>
 <dc47ecd2-fb94-ef7c-af15-590b2233e79f@lechnology.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5287670375686126621=="
Cc: linux-spi@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, khilman@kernel.org
To: David Lechner <david@lechnology.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <dc47ecd2-fb94-ef7c-af15-590b2233e79f@lechnology.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============5287670375686126621==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vcx5zrqa4ndhja4i"
Content-Disposition: inline


--vcx5zrqa4ndhja4i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 09, 2017 at 02:40:50PM -0600, David Lechner wrote:
> On 01/09/2017 01:48 PM, Mark Brown wrote:
> > On Thu, Jan 05, 2017 at 09:26:17PM -0600, David Lechner wrote:

> > > Unfortunately, this excludes the possibility of using one SPI device =
with
> > > DMA and one without on the same master.

> > Why would you ever want to do that?  What would ever make sense about
> > not using DMA if it's available and the transfer is suitably large, or
> > conversely why would one want to force DMA even if PIO would be more
> > performant?

> I don't particularly want to do that, but that is the way the spi-davinci
> driver currently works. The choice between DMA or PIO is specified in the
> platform data on a per-device basis.

> What I get from your remarks is that this is wrong and it needs to be fix=
ed.
> If that is so, could someone please point out a driver that does it the
> right way and I will try to fix it.

Pretty much any driver doing DMA...  off the top of my head the i.MX and
Samsung drivers ought to be reasonable examples.  If you've got time to
look at fixing the driver the other thing that jumps out with it is the
use of a threaded interrupt handler with no actual handling in the
thread, that looks like some magic timing based hack which seems risky
(or completely unneeded which would be better).

> > > When I originally submitted this patch, there was some discussion as =
to whether
> > > dspi->dma_rx should be changed to return an error rather than being n=
ull.
> >=20
> > > However, I prefer it the way it is and don't see a compelling reason =
to change
> > > it.

> > I don't know what the above comment means, sorry (and don't recall
> > having seen any earlier versions of this).

> FWIW, you can find the previous conversation at
> https://patchwork.kernel.org/patch/9437901/

What Sekhar is saying there is right, it is better style to use an error
pointer rather than NULL as someone could potentially come up with a way
to make NULL a valid pointer in the API.  But it doesn't matter greatly.

--vcx5zrqa4ndhja4i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlh1ESIACgkQJNaLcl1U
h9C3cAf9Fp4v6jAUNxccyHktIjSTb9eRWnaDY+696sXQsT7tezWL+0wdAmNPRg5s
nntqr7ucxAro0Z5oFwfbhkG7g+xNGykqP6v5mKJ44RYJK+fT4JT0hL3EmZZ/yHQe
wkRJDbGu4bWmz081IiquVyY3TQc8Ty5wn3C/gUa+td5qIgtsCyNFTjznz5i9q+Cr
GYfNr3lefP78RK6NDQa1oZhqmlRPBuwRNYqKORTWMWN8F6fc7c5sOKqL3xh5Jg0i
wdVvUH3H6dWXwK/Bxy+JJi7Meja1U2XxB3hShvHMuKKphxHrWV0sx3jb9b8Ohm2P
jwDZSXkLrbawlCfzLcGAk9xwy2ua/Q==
=epEW
-----END PGP SIGNATURE-----

--vcx5zrqa4ndhja4i--


--===============5287670375686126621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5287670375686126621==--
