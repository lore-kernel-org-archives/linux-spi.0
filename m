From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] Revert "spi/doc: spi_master_put must be followed up by
 kfree"
Date: Tue, 4 Sep 2012 04:57:38 -0700
Message-ID: <20120904115738.GA24634@roeck-us.net>
References: <1346703986-7849-1-git-send-email-linux@roeck-us.net>
 <20120904072523.GB28643@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	kernel@pengutronix.de
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120904072523.GB28643@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Sep 04, 2012 at 09:25:23AM +0200, Uwe Kleine-K=F6nig wrote:
> On Mon, Sep 03, 2012 at 01:26:26PM -0700, Guenter Roeck wrote:
> > Actually, spi_master_put() after spi_alloc_master() must _not_ be f=
ollowed
> > by kfree(). The memory is already freed with the call to spi_master=
_put()
> > through spi_master_class, which registers a release function. Calli=
ng both
> > spi_master_put() and kfree() results in often nasty (and delayed) c=
rashes
> > elsewhere in the kernel, often in the networking stack.
> >=20
> > This reverts commit eb4af0f5349235df2e4a5057a72fc8962d00308a.
> >=20
> > Cc: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> I didn't check the callback, but I introduced
> eb4af0f5349235df2e4a5057a72fc8962d00308a because I saw the kfree in
> drivers/spi/spi-imx.c. So I guess this needs fixing, too?!
>=20
This is a bitbang driver, which is one of the tricky ones which I have =
not touched
yet.

That driver calls
	spi_alloc_master
	spi_master_get
=2E.
error:
	spi_master_put
	kfree

which works out fine, since there are two references to master (one fro=
m
spi_alloc_master and one from spi_master_put). Calling spi_master_put t=
wice
would be cleaner, of course, but one can not have everything and at lea=
st
nothing bad will happen.

Other bitbang drivers are problematic, though. For example, looking at
spi-altera.c:

	hw->bitbang.master =3D spi_master_get(master);
	if (!hw->bitbang.master)
		return err;

That error case should never happen, but if it does the return would le=
ave master
unreleased. In practice it is not necessary to check the return code he=
re since
it will only be NULL if master is NULL.

exit:
	spi_master_put(master);
	return err;

So this driver calls spi_alloc_master and spi_master_get, but only call=
s
spi_master_put once in the error path, meaning one reference is left an=
d
master will not be freed. Given the context, it should really be
	spi_master_put(hw->bitbang.master);
	spi_master_put(master);
	return err;

This is just an example. spi-ath79.c and spi-au1550.c are wrong as well=
, and
many others.

The issue really is that one must keep track of the number of reference=
s to
master, and many drivers don't get that right. Bitbang drivers usually =
call
spi_master_get() to get an additional reference to master, and thus mus=
t call
spi_master_put twice (or spi_master_put/kfree) in the error path. Non-b=
itbang
drivers don't call spi_master_get() and thus don't need the additional =
call to
spi_master_put (or kfree).

Guenter
