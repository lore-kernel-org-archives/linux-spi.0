From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 2/9] spi: dw-mid: clear BUSY flag fist and test other
 one
Date: Fri, 06 Mar 2015 14:40:29 +0200
Message-ID: <1425645629.14897.196.camel@linux.intel.com>
References: <1425320166-13788-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1425320166-13788-3-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20150306112519.GH21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150306112519.GH21293-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, 2015-03-06 at 11:25 +0000, Mark Brown wrote:
> On Mon, Mar 02, 2015 at 08:15:59PM +0200, Andy Shevchenko wrote:
> > The logic of DMA completion is broken now since test_and_clear_bit(=
) never
> > returns the other bit is set. It means condition are always false a=
nd we have
> > spi_finalize_current_transfer() called per each DMA completion whic=
h is wrong.
> >=20
> > The patch fixes logic by clearing BUSY bit first and then check for=
 the other
> > one.
> >=20
> > Fixes: 30c8eb52cc4a (spi: dw-mid: split rx and tx callbacks when DM=
A)
>=20
> The commit this is fixing is in v3.19 so this should go to stable but=
 I
> can't apply this against my fix/dw branch.  Can you generate a versio=
n
> that can be applied there please?  We'll need to work out the merge
> issues with the current code I gues...


Hmm=E2=80=A6 Just tried apply on top on fix/dw using

git am -C1 -s
0001-spi-dw-mid-clear-BUSY-flag-fist-and-test-other-one.patch

It went fine with reduced context.

Shall I still resend you that version?


--=20
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
